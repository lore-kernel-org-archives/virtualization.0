From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [PATCH v2 4/5] VSOCK: increase send pkt len in mergeable mode to
	improve performance
Date: Wed, 12 Dec 2018 17:34:05 +0800
Message-ID: <5C10D60D.2010202__42092.2093479477$1544607132$gmane$org@huawei.com>
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

Since VSOCK already support mergeable rx buffer, so it can
implement the balance with performance and guest memory,
we can increase the sent pkt len to improve performance.
And in order to be compatible with old version, so we still
send max default rx buf size once.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 drivers/vhost/vsock.c                   | 33 ++++++++++++++++++++++++++++-----
 include/linux/virtio_vsock.h            |  3 +++
 net/vmw_vsock/virtio_transport.c        | 18 ++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  7 ++++---
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index c7ab0dd..9600133 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -44,6 +44,8 @@ struct vhost_vsock {
 	atomic_t queued_replies;

 	u32 guest_cid;
+
+	bool mergeable;
 };

 static u32 vhost_transport_get_local_cid(void)
@@ -151,7 +153,6 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
 	bool added = false;
 	bool restart_tx = false;
-	int mergeable;
 	size_t vsock_hlen;

 	mutex_lock(&vq->mutex);
@@ -159,12 +160,11 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 	if (!vq->private_data)
 		goto out;

-	mergeable = vhost_has_feature(vq, VIRTIO_VSOCK_F_MRG_RXBUF);
 	/*
 	 * Guest fill page for rx vq in mergeable case, so it will not
 	 * allocate pkt structure, we should reserve size of pkt in advance.
 	 */
-	if (likely(mergeable))
+	if (likely(vsock->mergeable))
 		vsock_hlen = sizeof(struct virtio_vsock_pkt);
 	else
 		vsock_hlen = sizeof(struct virtio_vsock_hdr);
@@ -195,7 +195,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 		spin_unlock_bh(&vsock->send_pkt_list_lock);

 		headcount = get_rx_bufs(vq, vq->heads, vsock_hlen + pkt->len,
-				&in, likely(mergeable) ? UIO_MAXIOV : 1);
+				&in, likely(vsock->mergeable) ? UIO_MAXIOV : 1);
 		if (headcount <= 0) {
 			spin_lock_bh(&vsock->send_pkt_list_lock);
 			list_add(&pkt->list, &vsock->send_pkt_list);
@@ -214,7 +214,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 		len = iov_length(&vq->iov[out], in);
 		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, len);

-		if (likely(mergeable))
+		if (likely(vsock->mergeable))
 			pkt->mrg_rxbuf_hdr.num_buffers = cpu_to_le16(headcount);
 		nbytes = copy_to_iter(&pkt->hdr, vsock_hlen, &iov_iter);
 		if (nbytes != vsock_hlen) {
@@ -303,6 +303,22 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
 	return len;
 }

+static u32
+vhost_transport_get_max_pkt_len(u32 guest_cid)
+{
+	int len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+	struct vhost_vsock *vsock;
+
+	vsock = vhost_vsock_get(guest_cid);
+	if (!vsock)
+		return len;
+
+	if (vsock->mergeable)
+		len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
+
+	return len;
+}
+
 static int
 vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 {
@@ -602,6 +618,8 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)

 	atomic_set(&vsock->queued_replies, 0);

+	vsock->mergeable = false;
+
 	vqs[VSOCK_VQ_TX] = &vsock->vqs[VSOCK_VQ_TX];
 	vqs[VSOCK_VQ_RX] = &vsock->vqs[VSOCK_VQ_RX];
 	vsock->vqs[VSOCK_VQ_TX].handle_kick = vhost_vsock_handle_tx_kick;
@@ -726,6 +744,9 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		return -EFAULT;
 	}

+	if (features & (1 << VIRTIO_VSOCK_F_MRG_RXBUF))
+		vsock->mergeable = true;
+
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];
 		mutex_lock(&vq->mutex);
@@ -848,6 +869,8 @@ static long vhost_vsock_dev_compat_ioctl(struct file *f, unsigned int ioctl,
 	},

 	.send_pkt = vhost_transport_send_pkt,
+
+	.max_pkt_len = vhost_transport_get_max_pkt_len,
 };

 static int __init vhost_vsock_init(void)
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 734eeed..ad95319 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -82,6 +82,9 @@ struct virtio_transport {

 	/* Takes ownership of the packet */
 	int (*send_pkt)(struct virtio_vsock_pkt *pkt);
+
+	/* Get max pkt len, cid only be used for Host */
+	u32 (*max_pkt_len)(u32 cid);
 };

 ssize_t
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 148b58a..809085a 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -222,6 +222,22 @@ static int virtio_transport_send_pkt_loopback(struct virtio_vsock *vsock,
 	return len;
 }

+static u32
+virtio_transport_get_max_pkt_len(u32 cid)
+{
+	int len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+	struct virtio_vsock *vsock;
+
+	vsock = virtio_vsock_get();
+	if (!vsock)
+		return len;
+
+	if (vsock->mergeable)
+		len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
+
+	return len;
+}
+
 static int
 virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 {
@@ -675,6 +691,8 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
 	},

 	.send_pkt = virtio_transport_send_pkt,
+
+	.max_pkt_len = virtio_transport_get_max_pkt_len,
 };

 static int virtio_vsock_probe(struct virtio_device *vdev)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 123a8b6..cc14ace 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -159,7 +159,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	struct virtio_vsock_sock *vvs;
 	struct virtio_vsock_pkt *pkt;
-	u32 pkt_len = info->pkt_len;
+	u32 pkt_len;
+	u32 max_pkt_len;

 	src_cid = vm_sockets_get_local_cid();
 	src_port = vsk->local_addr.svm_port;
@@ -174,8 +175,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	vvs = vsk->trans;

 	/* we can send less than pkt_len bytes */
-	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
-		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+	max_pkt_len = virtio_transport_get_ops()->max_pkt_len(dst_cid);
+	pkt_len = min(max_pkt_len, info->pkt_len);

 	/* virtio_transport_get_credit might return less than pkt_len credit */
 	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
-- 
1.8.3.1
