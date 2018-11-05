From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [PATCH 1/5] VSOCK: support fill mergeable rx buffer in guest
Date: Mon, 5 Nov 2018 15:45:02 +0800
Message-ID: <5BDFF4FE.1080500__48182.6127776459$1541403789$gmane$org@huawei.com>
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
To: stefanha@redhat.com, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In driver probing, if virtio has VIRTIO_VSOCK_F_MRG_RXBUF feature,
it will fill mergeable rx buffer, support for host send mergeable
rx buffer. It will fill a page everytime to compact with small
packet and big packet.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 include/linux/virtio_vsock.h     |  3 ++
 net/vmw_vsock/virtio_transport.c | 72 +++++++++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 19 deletions(-)

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
index 5d3cce9..2040a9e 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -64,6 +64,7 @@ struct virtio_vsock {
 	struct virtio_vsock_event event_list[8];

 	u32 guest_cid;
+	bool mergeable;
 };

 static struct virtio_vsock *virtio_vsock_get(void)
@@ -256,6 +257,25 @@ static int virtio_transport_send_pkt_loopback(struct virtio_vsock *vsock,
 	return 0;
 }

+static int fill_mergeable_rx_buff(struct virtqueue *vq)
+{
+	void *page = NULL;
+	struct scatterlist sg;
+	int err;
+
+	page = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	sg_init_one(&sg, page, PAGE_SIZE);
+
+	err = virtqueue_add_inbuf(vq, &sg, 1, page, GFP_KERNEL);
+	if (err < 0)
+		free_page((unsigned long) page);
+
+	return err;
+}
+
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 {
 	int buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
@@ -267,27 +287,33 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 	vq = vsock->vqs[VSOCK_VQ_RX];

 	do {
-		pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-		if (!pkt)
-			break;
+		if (vsock->mergeable) {
+			ret = fill_mergeable_rx_buff(vq);
+			if (ret)
+				break;
+		} else {
+			pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
+			if (!pkt)
+				break;

-		pkt->buf = kmalloc(buf_len, GFP_KERNEL);
-		if (!pkt->buf) {
-			virtio_transport_free_pkt(pkt);
-			break;
-		}
+			pkt->buf = kmalloc(buf_len, GFP_KERNEL);
+			if (!pkt->buf) {
+				virtio_transport_free_pkt(pkt);
+				break;
+			}

-		pkt->len = buf_len;
+			pkt->len = buf_len;

-		sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
-		sgs[0] = &hdr;
+			sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
+			sgs[0] = &hdr;

-		sg_init_one(&buf, pkt->buf, buf_len);
-		sgs[1] = &buf;
-		ret = virtqueue_add_sgs(vq, sgs, 0, 2, pkt, GFP_KERNEL);
-		if (ret) {
-			virtio_transport_free_pkt(pkt);
-			break;
+			sg_init_one(&buf, pkt->buf, buf_len);
+			sgs[1] = &buf;
+			ret = virtqueue_add_sgs(vq, sgs, 0, 2, pkt, GFP_KERNEL);
+			if (ret) {
+				virtio_transport_free_pkt(pkt);
+				break;
+			}
 		}
 		vsock->rx_buf_nr++;
 	} while (vq->num_free);
@@ -588,6 +614,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (ret < 0)
 		goto out_vqs;

+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_MRG_RXBUF))
+		vsock->mergeable = true;
+
 	vsock->rx_buf_nr = 0;
 	vsock->rx_buf_max_nr = 0;
 	atomic_set(&vsock->queued_replies, 0);
@@ -640,8 +669,12 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	vdev->config->reset(vdev);

 	mutex_lock(&vsock->rx_lock);
-	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
-		virtio_transport_free_pkt(pkt);
+	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX]))) {
+		if (vsock->mergeable)
+			free_page((unsigned long)(void *)pkt);
+		else
+			virtio_transport_free_pkt(pkt);
+	}
 	mutex_unlock(&vsock->rx_lock);

 	mutex_lock(&vsock->tx_lock);
@@ -683,6 +716,7 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 };

 static unsigned int features[] = {
+	VIRTIO_VSOCK_F_MRG_RXBUF,
 };

 static struct virtio_driver virtio_vsock_driver = {
-- 
1.8.3.1
