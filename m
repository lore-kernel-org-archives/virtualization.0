From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [PATCH 3/5] VSOCK: support receive mergeable rx buffer in guest
Date: Mon, 5 Nov 2018 15:47:08 +0800
Message-ID: <5BDFF57C.5020106@huawei.com>
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

Guest receive mergeable rx buffer, it can merge
scatter rx buffer into a big buffer and then copy
to user space.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 include/linux/virtio_vsock.h            |  9 ++++
 net/vmw_vsock/virtio_transport.c        | 75 +++++++++++++++++++++++++++++----
 net/vmw_vsock/virtio_transport_common.c | 59 ++++++++++++++++++++++----
 3 files changed, 127 insertions(+), 16 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index da9e1fe..6be3cd7 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,8 @@
 #define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
+/* virtio_vsock_pkt + max_pkt_len(default MAX_PKT_BUF_SIZE) */
+#define VIRTIO_VSOCK_MAX_MRG_BUF_NUM ((VIRTIO_VSOCK_MAX_PKT_BUF_SIZE / PAGE_SIZE) + 1)

 /* Virtio-vsock feature */
 #define VIRTIO_VSOCK_F_MRG_RXBUF 0 /* Host can merge receive buffers. */
@@ -48,6 +50,11 @@ struct virtio_vsock_sock {
 	struct list_head rx_queue;
 };

+struct virtio_vsock_mrg_rxbuf {
+	void *buf;
+	u32 len;
+};
+
 struct virtio_vsock_pkt {
 	struct virtio_vsock_hdr	hdr;
 	struct virtio_vsock_mrg_rxbuf_hdr mrg_rxbuf_hdr;
@@ -59,6 +66,8 @@ struct virtio_vsock_pkt {
 	u32 len;
 	u32 off;
 	bool reply;
+	bool mergeable;
+	struct virtio_vsock_mrg_rxbuf mrg_rxbuf[VIRTIO_VSOCK_MAX_MRG_BUF_NUM];
 };

 struct virtio_vsock_pkt_info {
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 2040a9e..3557ad3 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -359,11 +359,62 @@ static bool virtio_transport_more_replies(struct virtio_vsock *vsock)
 	return val < virtqueue_get_vring_size(vq);
 }

+static struct virtio_vsock_pkt *receive_mergeable(struct virtqueue *vq,
+		struct virtio_vsock *vsock, unsigned int *total_len)
+{
+	struct virtio_vsock_pkt *pkt;
+	u16 num_buf;
+	void *page;
+	unsigned int len;
+	int i = 0;
+
+	page = virtqueue_get_buf(vq, &len);
+	if (!page)
+		return NULL;
+
+	*total_len = len;
+	vsock->rx_buf_nr--;
+
+	pkt = page;
+	num_buf = le16_to_cpu(pkt->mrg_rxbuf_hdr.num_buffers);
+	if (!num_buf || num_buf > VIRTIO_VSOCK_MAX_MRG_BUF_NUM)
+		goto err;
+
+	pkt->mergeable = true;
+	if (!le32_to_cpu(pkt->hdr.len))
+		return pkt;
+
+	len -= sizeof(struct virtio_vsock_pkt);
+	pkt->mrg_rxbuf[i].buf = page + sizeof(struct virtio_vsock_pkt);
+	pkt->mrg_rxbuf[i].len = len;
+	i++;
+
+	while (--num_buf) {
+		page = virtqueue_get_buf(vq, &len);
+		if (!page)
+			goto err;
+
+		*total_len += len;
+		vsock->rx_buf_nr--;
+
+		pkt->mrg_rxbuf[i].buf = page;
+		pkt->mrg_rxbuf[i].len = len;
+		i++;
+	}
+
+	return pkt;
+err:
+	virtio_transport_free_pkt(pkt);
+	return NULL;
+}
+
 static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
+	size_t vsock_hlen = vsock->mergeable ? sizeof(struct virtio_vsock_pkt) :
+			sizeof(struct virtio_vsock_hdr);

 	vq = vsock->vqs[VSOCK_VQ_RX];

@@ -383,21 +434,29 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				goto out;
 			}

-			pkt = virtqueue_get_buf(vq, &len);
-			if (!pkt) {
-				break;
-			}
+			if (likely(vsock->mergeable)) {
+				pkt = receive_mergeable(vq, vsock, &len);
+				if (!pkt)
+					break;

-			vsock->rx_buf_nr--;
+				pkt->len = le32_to_cpu(pkt->hdr.len);
+			} else {
+				pkt = virtqueue_get_buf(vq, &len);
+				if (!pkt) {
+					break;
+				}
+
+				vsock->rx_buf_nr--;
+			}

 			/* Drop short/long packets */
-			if (unlikely(len < sizeof(pkt->hdr) ||
-				     len > sizeof(pkt->hdr) + pkt->len)) {
+			if (unlikely(len < vsock_hlen ||
+				     len > vsock_hlen + pkt->len)) {
 				virtio_transport_free_pkt(pkt);
 				continue;
 			}

-			pkt->len = len - sizeof(pkt->hdr);
+			pkt->len = len - vsock_hlen;
 			virtio_transport_deliver_tap_pkt(pkt);
 			virtio_transport_recv_pkt(pkt);
 		}
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 3ae3a33..7bef1d5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -272,14 +272,49 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk,
 		 */
 		spin_unlock_bh(&vvs->rx_lock);

-		err = memcpy_to_msg(msg, pkt->buf + pkt->off, bytes);
-		if (err)
-			goto out;
+		if (pkt->mergeable) {
+			struct virtio_vsock_mrg_rxbuf *buf = pkt->mrg_rxbuf;
+			size_t mrg_copy_bytes, last_buf_total = 0, rxbuf_off;
+			size_t tmp_bytes = bytes;
+			int i;
+
+			for (i = 0; i < le16_to_cpu(pkt->mrg_rxbuf_hdr.num_buffers); i++) {
+				if (pkt->off > last_buf_total + buf[i].len) {
+					last_buf_total += buf[i].len;
+					continue;
+				}
+
+				rxbuf_off = pkt->off - last_buf_total;
+				mrg_copy_bytes = min(buf[i].len - rxbuf_off, tmp_bytes);
+				err = memcpy_to_msg(msg, buf[i].buf + rxbuf_off, mrg_copy_bytes);
+				if (err)
+					goto out;
+
+				tmp_bytes -= mrg_copy_bytes;
+				pkt->off += mrg_copy_bytes;
+				last_buf_total += buf[i].len;
+				if (!tmp_bytes)
+					break;
+			}
+
+			if (tmp_bytes) {
+				printk(KERN_WARNING "WARNING! bytes = %llu, "
+						"bytes = %llu\n",
+						(unsigned long long)bytes,
+						(unsigned long long)tmp_bytes);
+			}
+
+			total += (bytes - tmp_bytes);
+		} else {
+			err = memcpy_to_msg(msg, pkt->buf + pkt->off, bytes);
+			if (err)
+				goto out;
+
+			total += bytes;
+			pkt->off += bytes;
+		}

 		spin_lock_bh(&vvs->rx_lock);
-
-		total += bytes;
-		pkt->off += bytes;
 		if (pkt->off == pkt->len) {
 			virtio_transport_dec_rx_pkt(vvs, pkt);
 			list_del(&pkt->list);
@@ -1050,8 +1085,16 @@ void virtio_transport_recv_pkt(struct virtio_vsock_pkt *pkt)

 void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt)
 {
-	kfree(pkt->buf);
-	kfree(pkt);
+	int i;
+
+	if (pkt->mergeable) {
+		for (i = 1; i < le16_to_cpu(pkt->mrg_rxbuf_hdr.num_buffers); i++)
+			free_page((unsigned long)pkt->mrg_rxbuf[i].buf);
+		free_page((unsigned long)(void *)pkt);
+	} else {
+		kfree(pkt->buf);
+		kfree(pkt);
+	}
 }
 EXPORT_SYMBOL_GPL(virtio_transport_free_pkt);

-- 
1.8.3.1
