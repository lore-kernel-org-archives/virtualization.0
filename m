Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836932;
	b=FlLpPHRKSliXnhBMW0AJJ6A/Y2qHSA7YZYtbY844ylvtxdtJOYgXNwoS2BDPGPX6lizB
	 4hCPNUT4E9PPfACxyDokke2OIIeZfIhd6WbJCNAq45GjHzDMWgxdUgbuJCxy/Y9Ix2M4B
	 q8++spSR0I/s54y0RiERvlmxo0IPjqpBUedUIfQxigx40XVkFYVdrrjwMqZVcgM6pjnv/
	 2+rM9YSklyDHx5Plpk+vdKKepoT/KuZWfEcCD8ytuUBzFArtKB3rNhCYScmetB+2j+cPM
	 zkFsDnX/NjvwsHw08sbBuGmZosujrhNMsjPIl7Bj9Vz2YAt9mXNuUAxYvw3xvLnRk8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836932;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=LohI0OFoxJxkaEB+sGEh3geC60v7lkZMH4lAoeF1VKI=;
	b=DrIAprQswvpN6V+ZXj7r3JnFeUr/6sWDKgpuEISAozBxdSVUXdE7G/WvfuWs/Dy47Ic8
	 voCZb0nuTlKkNtXDRThI1RyoADYNbkWA6NMVYeZfBI41f/Zeio+NvTttSFFJu07tbI+2K
	 he9yXEXBIwrLg2OPAIPGU0VzMZ8fFVcry5OyeYA4s48JiDDLsTu2WfX4xiqRQ5kkug32I
	 QBsuDh8HdWc98XoNk9MjuaQBcsNiEMQojA2OagSn7DAnjzFAKCiCNCrT3MB+vjPnLJnK1
	 86Zo0F//TKYtjgMV21gUHJA6JqYSQyQ0BfnxUrZADE7ZG+J0jHMtWOwxn8LVkTdwJQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linuxhacker.ru;
	spf=none smtp.mailfrom=linuxhacker.ru;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50950606D83A
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50950606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linuxhacker.ru
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id BB0E7BEE80;
	Thu,  5 Nov 2026 00:02:07 +0000 (UTC)
From: Oleg Drokin <green@linuxhacker.ru>
To: sgarzare@redhat.com,
	stefanha@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	bobbyeshleman@meta.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] vsock/virtio: queue at most one credit update per socket
Date: Wed,  4 Nov 2026 19:01:41 -0500
Message-ID: <20261105000141.3617241-4-green@linuxhacker.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105000141.3617241-1-green@linuxhacker.ru>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A credit update carries no data, so the send credit never limits it,
and the peer can solicit one at will: with OP_CREDIT_REQUEST, or by
sending data that a local reader drains (a read that empties the
receive queue sends one). A peer that posts no rx buffers can therefore
make the other side queue credit updates without limit, about 1 KiB of
unaccounted slab each for a 44-byte packet.

Do not queue a credit update while the socket's last queued packet is
already one. Every packet carries fwd_cnt and buf_alloc, so a packet
queued later makes the queued update redundant and lets a new one be
queued after it. When a transport puts a queued update on the wire
(vhost once it has an rx buffer for it, the guest driver when it adds
it to the tx virtqueue, loopback when it delivers it) and nothing has
been queued after it, it refreshes the update's fwd_cnt and buf_alloc
and releases the socket. So a suppressed update always reaches the
peer, either in the queued one or in a later packet, and the fwd_cnt
the peer sees never goes back.

connect() can move a socket to another transport, freeing its
virtio_vsock_sock, while packets are still queued in the old one. So a
tracked update holds a reference on the virtio_vsock_sock, and its skb
destructor clears the socket's pointer to it and drops the reference,
however the skb is freed: sent, purged or dropped.

A peer can thus make a connection queue at most one credit update, plus
one per packet the socket itself queued after it.

Counting credit updates in queued_replies instead would not work: most
of them are sent by local reads, not in answer to the peer, and under
bidirectional traffic vhost would stop reading the guest's tx queue
while the guest stops reading its rx queue, each waiting for the other.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 drivers/vhost/vsock.c                   |  2 +
 include/linux/virtio_vsock.h            |  5 ++
 net/vmw_vsock/virtio_transport.c        |  2 +
 net/vmw_vsock/virtio_transport_common.c | 62 ++++++++++++++++++++++++-
 net/vmw_vsock/vsock_loopback.c          |  1 +
 5 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b0004cb48999..f1b47a826ca4 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -176,6 +176,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			break;
 		}
 
+		virtio_transport_credit_update_xmit(skb);
+
 		if (out) {
 			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
 			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..6c3fc8faca0b 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,7 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct virtio_vsock_sock *vvs;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
@@ -167,6 +168,9 @@ struct virtio_vsock_sock {
 	u32 buf_used;
 	struct sk_buff_head rx_queue;
 	u32 msg_count;
+	struct sk_buff *credit_update;
+
+	refcount_t refcnt;
 };
 
 struct virtio_vsock_pkt_info {
@@ -283,6 +287,7 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb, struct net *net);
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
+void virtio_transport_credit_update_xmit(struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
 void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..82cd52249de3 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -104,6 +104,8 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
 	int ret, in_sg = 0, out_sg = 0;
 	struct scatterlist **sgs;
 
+	virtio_transport_credit_update_xmit(skb);
+
 	sgs = vsock->out_sgs;
 	sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
 		    sizeof(*virtio_vsock_hdr(skb)));
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 74a8fdf825d5..65d6e0790e72 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -604,18 +604,68 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
 	vvs->fwd_cnt += bytes_dequeued;
 }
 
+static void virtio_transport_put_vvs(struct virtio_vsock_sock *vvs)
+{
+	if (refcount_dec_and_test(&vvs->refcnt))
+		kfree(vvs);
+}
+
+static void virtio_transport_credit_update_destruct(struct sk_buff *skb)
+{
+	struct virtio_vsock_sock *vvs = VIRTIO_VSOCK_SKB_CB(skb)->vvs;
+
+	spin_lock_bh(&vvs->rx_lock);
+	if (vvs->credit_update == skb)
+		vvs->credit_update = NULL;
+	spin_unlock_bh(&vvs->rx_lock);
+
+	virtio_transport_put_vvs(vvs);
+	sock_wfree(skb);
+}
+
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	bool track = le16_to_cpu(hdr->op) == VIRTIO_VSOCK_OP_CREDIT_UPDATE &&
+		     skb->destructor == sock_wfree;
+
+	/* The skb pins vvs, which connect() may detach from the socket. */
+	if (track) {
+		refcount_inc(&vvs->refcnt);
+		VIRTIO_VSOCK_SKB_CB(skb)->vvs = vvs;
+		skb->destructor = virtio_transport_credit_update_destruct;
+	}
 
 	spin_lock_bh(&vvs->rx_lock);
 	vvs->last_fwd_cnt = vvs->fwd_cnt;
 	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
 	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
+	vvs->credit_update = track ? skb : NULL;
 	spin_unlock_bh(&vvs->rx_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
 
+/* Called by the transports when @skb is put on the wire. */
+void virtio_transport_credit_update_xmit(struct sk_buff *skb)
+{
+	struct virtio_vsock_sock *vvs = VIRTIO_VSOCK_SKB_CB(skb)->vvs;
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+
+	if (!vvs)
+		return;
+
+	spin_lock_bh(&vvs->rx_lock);
+	/* Still the socket's last packet: carry what was suppressed. */
+	if (vvs->credit_update == skb) {
+		vvs->credit_update = NULL;
+		vvs->last_fwd_cnt = vvs->fwd_cnt;
+		hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
+		hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
+	}
+	spin_unlock_bh(&vvs->rx_lock);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_credit_update_xmit);
+
 void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 {
 	struct sock *s = skb->sk;
@@ -667,11 +717,20 @@ EXPORT_SYMBOL_GPL(virtio_transport_put_credit);
 
 static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 {
+	struct virtio_vsock_sock *vvs = vsk->trans;
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
 		.net = sock_net(sk_vsock(vsk)),
 	};
+	bool queued;
+
+	spin_lock_bh(&vvs->rx_lock);
+	queued = vvs->credit_update;
+	spin_unlock_bh(&vvs->rx_lock);
+
+	if (queued)
+		return 0;
 
 	return virtio_transport_send_pkt_info(vsk, &info);
 }
@@ -1086,6 +1145,7 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
 	spin_lock_init(&vvs->rx_lock);
 	spin_lock_init(&vvs->tx_lock);
 	skb_queue_head_init(&vvs->rx_queue);
+	refcount_set(&vvs->refcnt, 1);
 
 	return 0;
 }
@@ -1276,8 +1336,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 
 	virtio_transport_cancel_close_work(vsk, true);
 
-	kfree(vvs);
 	vsk->trans = NULL;
+	virtio_transport_put_vvs(vvs);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_destruct);
 
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 8068d1b6e851..84342a97a513 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -134,6 +134,7 @@ static void vsock_loopback_work(struct work_struct *work)
 	spin_unlock_bh(&vsock->pkt_queue.lock);
 
 	while ((skb = __skb_dequeue(&pkts))) {
+		virtio_transport_credit_update_xmit(skb);
 		/* Decrement the bytes_unsent counter without deallocating skb
 		 * It is freed by the receiver.
 		 */
-- 
2.56.0

