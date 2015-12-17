From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: use smp_load_acquire/smp_store_release
Date: Thu, 17 Dec 2015 12:29:03 +0200
Message-ID: <1450347930-16275-1-git-send-email-mst__23140.154980547$1450348166$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio ring entries have exactly the acquire/release
semantics:
	- reading used index acquires a ring entry from host
	- updating the available index releases it to host

Thus when using weak barriers and building for SMP (as most people
do), smp_load_acquire and smp_store_release will do exactly
the right thing to synchronize with the host.

In fact, QEMU already uses __atomic_thread_fence(__ATOMIC_ACQUIRE) and
__atomic_thread_fence(__ATOMIC_RELEASE);
Documentation/circular-buffers.txt suggests smp_load_acquire and
smp_store_release for head and tail updates.

Since we have to worry about UP and strong barrier users,
let's add APIs to wrap these, and use in virtio_ring.c

It is tempting to use this in vhost as well,
this needs a bit more work to make acquire/release macros
work on __user pointers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h  | 30 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c | 20 ++++++++++----------
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8e50888..0135c16 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -47,6 +47,36 @@ static inline void virtio_wmb(bool weak_barriers)
 		wmb();
 }
 
+static inline __virtio16 virtio_load_acquire(bool weak_barriers, __virtio16 *p)
+{
+	if (!weak_barriers) {
+		rmb();
+		return READ_ONCE(*p);
+	}
+#ifdef CONFIG_SMP
+	return smp_load_acquire(p);
+#else
+	dma_rmb();
+	return READ_ONCE(*p);
+#endif
+}
+
+static inline void virtio_store_release(bool weak_barriers,
+					__virtio16 *p, __virtio16 v)
+{
+	if (!weak_barriers) {
+		wmb();
+		WRITE_ONCE(*p, v);
+		return;
+	}
+#ifdef CONFIG_SMP
+	smp_store_release(p, v);
+#else
+	dma_wmb();
+	WRITE_ONCE(*p, v);
+#endif
+}
+
 struct virtio_device;
 struct virtqueue;
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ee663c4..f822cab 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -244,11 +244,11 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	avail = vq->avail_idx_shadow & (vq->vring.num - 1);
 	vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
 
+	vq->avail_idx_shadow++;
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
-	virtio_wmb(vq->weak_barriers);
-	vq->avail_idx_shadow++;
-	vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
+	virtio_store_release(vq->weak_barriers, &vq->vring.avail->idx,
+			     cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow));
 	vq->num_added++;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
@@ -453,9 +453,10 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 	vq->vq.num_free++;
 }
 
-static inline bool more_used(const struct vring_virtqueue *vq)
+static inline
+bool more_used(const struct vring_virtqueue *vq, __virtio16 used_idx)
 {
-	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, vq->vring.used->idx);
+	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, used_idx);
 }
 
 /**
@@ -488,15 +489,14 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 		return NULL;
 	}
 
-	if (!more_used(vq)) {
+	/* Only get used array entries after they have been exposed by host. */
+	if (!more_used(vq, virtio_load_acquire(vq->weak_barriers,
+					       &vq->vring.used->idx))) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
 	}
 
-	/* Only get used array entries after they have been exposed by host. */
-	virtio_rmb(vq->weak_barriers);
-
 	last_used = (vq->last_used_idx & (vq->vring.num - 1));
 	i = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].id);
 	*len = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].len);
@@ -704,7 +704,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!more_used(vq)) {
+	if (!more_used(vq, vq->vring.used->idx)) {
 		pr_debug("virtqueue interrupt with no work for %p\n", vq);
 		return IRQ_NONE;
 	}
-- 
MST
