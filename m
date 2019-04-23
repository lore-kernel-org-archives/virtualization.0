From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH V3 4/6] vhost: introduce helpers to get the size of
	metadata area
Date: Tue, 23 Apr 2019 01:54:18 -0400
Message-ID: <20190423055420.26408-5-jasowang__27094.8669918411$1555998927$gmane$org@redhat.com>
References: <20190423055420.26408-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190423055420.26408-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: aarcange@redhat.com, hch@infradead.org, christophe.de.dinechin@gmail.com, linux-parisc@vger.kernel.org, James.Bottomley@hansenpartnership.com, linux-mm@kvack.org, jglisse@redhat.com, jrdr.linux@gmail.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

To avoid code duplication since it will be used by kernel VA prefetching.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 51 ++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bff4d586871d..f3f86c3ed659 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -413,6 +413,32 @@ static void vhost_dev_free_iovecs(struct vhost_dev *dev)
 		vhost_vq_free_iovecs(dev->vqs[i]);
 }
 
+static size_t vhost_get_avail_size(struct vhost_virtqueue *vq,
+				   unsigned int num)
+{
+	size_t event __maybe_unused =
+	       vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+
+	return sizeof(*vq->avail) +
+	       sizeof(*vq->avail->ring) * num + event;
+}
+
+static size_t vhost_get_used_size(struct vhost_virtqueue *vq,
+				  unsigned int num)
+{
+	size_t event __maybe_unused =
+	       vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+
+	return sizeof(*vq->used) +
+	       sizeof(*vq->used->ring) * num + event;
+}
+
+static size_t vhost_get_desc_size(struct vhost_virtqueue *vq,
+				  unsigned int num)
+{
+	return sizeof(*vq->desc) * num;
+}
+
 void vhost_dev_init(struct vhost_dev *dev,
 		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
 {
@@ -1257,13 +1283,9 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
 			 struct vring_used __user *used)
 
 {
-	size_t s __maybe_unused = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
-
-	return access_ok(desc, num * sizeof *desc) &&
-	       access_ok(avail,
-			 sizeof *avail + num * sizeof *avail->ring + s) &&
-	       access_ok(used,
-			sizeof *used + num * sizeof *used->ring + s);
+	return access_ok(desc, vhost_get_desc_size(vq, num)) &&
+	       access_ok(avail, vhost_get_avail_size(vq, num)) &&
+	       access_ok(used, vhost_get_used_size(vq, num));
 }
 
 static void vhost_vq_meta_update(struct vhost_virtqueue *vq,
@@ -1315,22 +1337,18 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
 
 int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
-	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 	unsigned int num = vq->num;
 
 	if (!vq->iotlb)
 		return 1;
 
 	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
-			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
+			       vhost_get_desc_size(vq, num), VHOST_ADDR_DESC) &&
 	       iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->avail,
-			       sizeof *vq->avail +
-			       num * sizeof(*vq->avail->ring) + s,
+			       vhost_get_avail_size(vq, num),
 			       VHOST_ADDR_AVAIL) &&
 	       iotlb_access_ok(vq, VHOST_ACCESS_WO, (u64)(uintptr_t)vq->used,
-			       sizeof *vq->used +
-			       num * sizeof(*vq->used->ring) + s,
-			       VHOST_ADDR_USED);
+			       vhost_get_used_size(vq, num), VHOST_ADDR_USED);
 }
 EXPORT_SYMBOL_GPL(vq_meta_prefetch);
 
@@ -1347,13 +1365,10 @@ EXPORT_SYMBOL_GPL(vhost_log_access_ok);
 static bool vq_log_access_ok(struct vhost_virtqueue *vq,
 			     void __user *log_base)
 {
-	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
-
 	return vq_memory_access_ok(log_base, vq->umem,
 				   vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
 		(!vq->log_used || log_access_ok(log_base, vq->log_addr,
-					sizeof *vq->used +
-					vq->num * sizeof *vq->used->ring + s));
+				  vhost_get_used_size(vq, vq->num)));
 }
 
 /* Can we start vq? */
-- 
2.18.1
