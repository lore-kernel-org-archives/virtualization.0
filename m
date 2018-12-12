From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [PATCH v2 1/5] VSOCK: support fill mergeable rx buffer in guest
Date: Wed, 12 Dec 2018 17:28:16 +0800
Message-ID: <5C10D4B0.8080504__23182.8355034397$1544607185$gmane$org@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In driver probing, if virtio has VIRTIO_VSOCK_F_MRG_RXBUF feature,
it will fill mergeable rx buffer, support for host send mergeable
rx buffer. It will fill a fixed size(PAGE_SIZE) everytime to
compact with small packet and big packet.

In addition, it also add one optimizations copied from virtio-net.c.
- Skb_page_frag_refill() which can use high order page and
  reduce the stress of page allocator.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 include/linux/virtio_vsock.h     |   3 ++
 net/vmw_vsock/virtio_transport.c | 112 +++++++++++++++++++++++++++++++--------
 2 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index e223e26..bf84418 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -14,6 +14,9 @@
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)

+/* Virtio-vsock feature */
+#define VIRTIO_VSOCK_F_MRG_RXBUF 0 /* Host can merge receive buffers. */
+
 enum {
 	VSOCK_VQ_RX     = 0, /* for host to guest data */
 	VSOCK_VQ_TX     = 1, /* for guest to host data */
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5d3cce9..c4a465c 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -64,6 +64,11 @@ struct virtio_vsock {
 	struct virtio_vsock_event event_list[8];

 	u32 guest_cid;
+
+	/* As mergeable rx buffer flag */
+	bool mergeable;
+	/* Page frag for packet buffer allocation. */
+	struct page_frag alloc_frag;
 };

 static struct virtio_vsock *virtio_vsock_get(void)
@@ -256,39 +261,89 @@ static int virtio_transport_send_pkt_loopback(struct virtio_vsock *vsock,
 	return 0;
 }

-static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
+/* This segment of codes are copied from virtio-net.c */
+static int fill_mergeable_rx_buff(struct virtio_vsock *vsock,
+		struct virtqueue *vq)
+{
+	struct page_frag *alloc_frag = &vsock->alloc_frag;
+	struct scatterlist sg;
+	/* Currently we don't use ewma len, use PAGE_SIZE instead, because too
+	 * small size can't fill one full packet, sadly we only 128 vq num now.
+	 */
+	unsigned int len = PAGE_SIZE, hole;
+	void *buf;
+	int err;
+
+	if (unlikely(!skb_page_frag_refill(len, alloc_frag, GFP_KERNEL)))
+		return -ENOMEM;
+
+	buf = (void *)page_address(alloc_frag->page) + alloc_frag->offset;
+	get_page(alloc_frag->page);
+	alloc_frag->offset += len;
+	hole = alloc_frag->size - alloc_frag->offset;
+	if (hole < len) {
+		/* To avoid internal fragmentation, if there is very likely not
+		 * enough space for another buffer, add the remaining space to
+		 * the current buffer.
+		 */
+		len += hole;
+		alloc_frag->offset += hole;
+	}
+
+	sg_init_one(&sg, buf, len);
+	err = virtqueue_add_inbuf(vq, &sg, 1, buf, GFP_KERNEL);
+	if (err < 0)
+		put_page(virt_to_head_page(buf));
+
+	return err;
+}
+
+static int fill_old_rx_buff(struct virtqueue *vq)
 {
 	int buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
 	struct virtio_vsock_pkt *pkt;
 	struct scatterlist hdr, buf, *sgs[2];
-	struct virtqueue *vq;
 	int ret;

-	vq = vsock->vqs[VSOCK_VQ_RX];
+	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;

-	do {
-		pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-		if (!pkt)
-			break;
+	pkt->buf = kmalloc(buf_len, GFP_KERNEL);
+	if (!pkt->buf) {
+		virtio_transport_free_pkt(pkt);
+		return -ENOMEM;
+	}

-		pkt->buf = kmalloc(buf_len, GFP_KERNEL);
-		if (!pkt->buf) {
-			virtio_transport_free_pkt(pkt);
-			break;
-		}
+	pkt->len = buf_len;

-		pkt->len = buf_len;
+	sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
+	sgs[0] = &hdr;

-		sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
-		sgs[0] = &hdr;
+	sg_init_one(&buf, pkt->buf, buf_len);
+	sgs[1] = &buf;
+	ret = virtqueue_add_sgs(vq, sgs, 0, 2, pkt, GFP_KERNEL);
+	if (ret)
+		virtio_transport_free_pkt(pkt);

-		sg_init_one(&buf, pkt->buf, buf_len);
-		sgs[1] = &buf;
-		ret = virtqueue_add_sgs(vq, sgs, 0, 2, pkt, GFP_KERNEL);
-		if (ret) {
-			virtio_transport_free_pkt(pkt);
+	return ret;
+}
+
+static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
+{
+	struct virtqueue *vq;
+	int ret;
+
+	vq = vsock->vqs[VSOCK_VQ_RX];
+
+	do {
+		if (vsock->mergeable)
+			ret = fill_mergeable_rx_buff(vsock, vq);
+		else
+			ret = fill_old_rx_buff(vq);
+		if (ret)
 			break;
-		}
+
 		vsock->rx_buf_nr++;
 	} while (vq->num_free);
 	if (vsock->rx_buf_nr > vsock->rx_buf_max_nr)
@@ -588,6 +643,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (ret < 0)
 		goto out_vqs;

+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_MRG_RXBUF))
+		vsock->mergeable = true;
+
 	vsock->rx_buf_nr = 0;
 	vsock->rx_buf_max_nr = 0;
 	atomic_set(&vsock->queued_replies, 0);
@@ -640,8 +698,15 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	vdev->config->reset(vdev);

 	mutex_lock(&vsock->rx_lock);
-	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
-		virtio_transport_free_pkt(pkt);
+	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX]))) {
+		if (vsock->mergeable)
+			put_page(virt_to_head_page((void *)pkt));
+		else
+			virtio_transport_free_pkt(pkt);
+	}
+
+	if (vsock->alloc_frag.page)
+		put_page(vsock->alloc_frag.page);
 	mutex_unlock(&vsock->rx_lock);

 	mutex_lock(&vsock->tx_lock);
@@ -683,6 +748,7 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 };

 static unsigned int features[] = {
+	VIRTIO_VSOCK_F_MRG_RXBUF,
 };

 static struct virtio_driver virtio_vsock_driver = {
-- 
1.8.3.1
