From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/4] virtio: introduce avail cache
Date: Thu, 10 Sep 2015 10:23:49 +0300
Message-ID: <1441869802-15847-5-git-send-email-mst__29630.3985677243$1441869874$gmane$org@redhat.com>
References: <1441869802-15847-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1441869802-15847-1-git-send-email-mst@redhat.com>
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
Cc: "Xie, Huawei" <huawei.xie@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This allows skipping avail ring writes when they
don't need to change. Good for cache locality.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 096b857..14e7ce9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -91,6 +91,7 @@ struct vring_virtqueue {
 	bool last_add_time_valid;
 	ktime_t last_add_time;
 #endif
+	u16 *avail;
 
 	/* Tokens for callbacks. */
 	void *data[];
@@ -236,7 +237,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) & (vq->vring.num - 1);
-	vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
+	if (vq->avail[avail] != head) {
+		vq->avail[avail] = head;
+		vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
+	}
 
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
@@ -724,6 +728,11 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	vq = kmalloc(sizeof(*vq) + sizeof(void *)*num, GFP_KERNEL);
 	if (!vq)
 		return NULL;
+	vq->avail = kzalloc(sizeof (*vq->avail) * num, GFP_KERNEL);
+	if (!vq->avail) {
+		kfree(vq);
+		return NULL;
+	}
 
 	vring_init(&vq->vring, num, pages, vring_align);
 	vq->vq.callback = callback;
-- 
MST
