From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2] virtio: use smp_XX barriers on SMP
Date: Thu, 28 Jan 2010 00:42:23 +0200
Message-ID: <20100127224222.GA31545@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio is communicating with a virtual "device" that actually runs on
another host processor. Thus SMP barriers can be used to control
memory access ordering.

Where possible, we should use SMP barriers which are more lightweight than
mandatory barriers, because mandatory barriers also control MMIO effects on
accesses through relaxed memory I/O windows (which virtio does not use)
(compare specifically smp_rmb and rmb on x86_64).

We can't just use smp_mb and friends though, because
we must force memory ordering even if guest is UP since host could be
running on another CPU, but SMP barriers are defined to barrier() in
that configuration. So, for UP fall back to mandatory barriers instead.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1: fall back on mandatory barriers for UP

 drivers/virtio/virtio_ring.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbd2ecd..6794662 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -21,6 +21,24 @@
 #include <linux/virtio_config.h>
 #include <linux/device.h>
 
+/* virtio guest is communicating with a virtual "device" that actually runs on
+ * a host processor.  Memory barriers are used to control SMP effects. */
+#ifdef CONFIG_SMP
+/* Where possible, use SMP barriers which are more lightweight than mandatory
+ * barriers, because mandatory barriers control MMIO effects on accesses
+ * through relaxed memory I/O windows (which virtio does not use). */
+#define virtio_mb() smp_mb()
+#define virtio_rmb() smp_rmb()
+#define virtio_wmb() smp_wmb()
+#else
+/* We must force memory ordering even if guest is UP since host could be
+ * running on another CPU, but SMP barriers are defined to barrier() in that
+ * configuration. So fall back to mandatory barriers instead. */
+#define virtio_mb() mb()
+#define virtio_rmb() rmb()
+#define virtio_wmb() wmb()
+#endif
+
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
 #define BAD_RING(_vq, fmt, args...)				\
@@ -36,10 +54,10 @@
 			panic("%s:in_use = %i\n",		\
 			      (_vq)->vq.name, (_vq)->in_use);	\
 		(_vq)->in_use = __LINE__;			\
-		mb();						\
+		virtio_mb();						\
 	} while (0)
 #define END_USE(_vq) \
-	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; mb(); } while(0)
+	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; virtio_mb(); } while(0)
 #else
 #define BAD_RING(_vq, fmt, args...)				\
 	do {							\
@@ -221,13 +239,13 @@ static void vring_kick(struct virtqueue *_vq)
 	START_USE(vq);
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
-	wmb();
+	virtio_wmb();
 
 	vq->vring.avail->idx += vq->num_added;
 	vq->num_added = 0;
 
 	/* Need to update avail index before checking if we should notify */
-	mb();
+	virtio_mb();
 
 	if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
 		/* Prod other side to tell it about changes. */
@@ -286,7 +304,7 @@ static void *vring_get_buf(struct virtqueue *_vq, unsigned int *len)
 	}
 
 	/* Only get used array entries after they have been exposed by host. */
-	rmb();
+	virtio_rmb();
 
 	i = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].id;
 	*len = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].len;
@@ -324,7 +342,7 @@ static bool vring_enable_cb(struct virtqueue *_vq)
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
 	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
-	mb();
+	virtio_mb();
 	if (unlikely(more_used(vq))) {
 		END_USE(vq);
 		return false;
-- 
1.6.6.144.g5c3af
