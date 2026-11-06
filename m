Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941393;
	b=0oGapJU2KWGhdseLZqD6hJdevqvYq36vuh9peb6VHWDczePqUqdimKiUEeipW0nl1m3A
	 9/Gktq3y0iVUDJ0PJoaw22C3oSWqSqsJkwGOJMbt64hmC5F8ag0dHYGXOGTGPgBlvNlm+
	 E4OAIBaXG2PdNXOgFXC7H8koF8FG88FwzniokQcF8FeYRLr8GL46NVnVUr5wlHoUtxAvN
	 EQIqTytTAfYMYu9FwWqqaOpTTkDqNH4JnzOw+Az6EgCdeTlQx1E1ym39P71/IWrSfs0kB
	 EZ9veOBv2T5auTrIMNL4zfKGY+1Y5DIy4sbD7KU7Jxhpe9DHh+9cumW/tZGfPt+PDvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941393;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y9mIycYuVHTutNHVFEKXIvRSytv+OKQ1oS9xSpsMonc=;
	b=E1gSkbCV8PWJeScw+5jjNSYxcSerwtYnH5QBmS9cia/q2ZIseoWiBI+Rf6/emOPlLYV9
	 h1RJz848240ZQEplup2JocJU5VC9uwVeWKIPooDDYAWcHrsaeSE5q/qbYMf9d9OdDJzqh
	 O2gm5bQ3xXpdzHXgVLZrKykoKVfXAsJpwmmpL3+h9hiolFMPOXuFGBK4Gvax5fC8z8R6B
	 3+XxMw5D6Ea+NAboECAJbDMdmL0riss8LlP487praFtm9CFxF+vxIexQRJTbd2L6Wy5n7
	 NBtd5/wTDLk4svefdVk1JpSJk57+nL3jUrtzB4faqMZQLiTgbWStkyVCkpLZAwksKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxhacker.ru;
	spf=pass smtp.mailfrom=linuxhacker.ru;
	dkim=pass header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=dXFFgIs3;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE3606A32E
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 05:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1EE3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=dXFFgIs3
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id 54ED5BEE42;
	Fri,  6 Nov 2026 05:03:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 eagle.linuxhacker.ru 54ED5BEE42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxhacker.ru;
	s=mail; t=1793941391;
	bh=yKlnf7yWRqd7XJLar8zLqK798z/Xes6QlUr9QH1V8qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXFFgIs3V45+hHDyrOFzAKC8vXooTvShDzdWybCpRkhGajdI/6TQ2dluwdtidfhst
	 L5c766MSgaDONA0C8NXHaFgiXgzjackunUIZ3R9FFiD0HE7A0CodpYXSUfVApCs0NW
	 A8YBRHmRwAGFi01jMuF5+X93yAaCYsH42gsaU3ShqeZ3sF4/668IZEGOy+l/UrDjnY
	 wLCd+AbLjrk/X1MJJEvXd8tYhERkolg3HgC5rcCxoalCAxADfAdecu3LueumoSPTbs
	 gRJsMhUezrPORwEyDv9qgCXKQV3+mWKIej99V2dcdWM2KZeTgGRPSHgWp1oqK6Qp4m
	 LLahUzSKK/OPw==
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
Subject: [PATCH net v2 3/3] vsock/virtio: fold credit updates into the one a socket has queued
Date: Fri,  6 Nov 2026 00:02:44 -0500
Message-ID: <20261106050244.602625-4-green@linuxhacker.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106050244.602625-1-green@linuxhacker.ru>
References: <20261106050244.602625-1-green@linuxhacker.ru>
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

Every packet carries fwd_cnt and buf_alloc, so while the socket's newest
packet in a transport's send queue is a credit update, a new one adds
nothing but newer counters. Record that packet, and the queue it is in,
in vsock_sock. When another credit update for the socket is queued to
the same queue, copy its fwd_cnt and buf_alloc into the queued one,
under the queue lock, and free it. Queuing any other packet of the
socket clears the record, and so does removing the recorded packet from
the queue (dequeue, purge, loopback's splice), under the same lock and
before the transport reads the header. So the counters are only ever
written into a packet that has not gone out, and the fwd_cnt the peer
sees never goes back.

The queue has to be recorded because vhost has one per device, and a
socket's packets can sit in two of them at once (a guest restarted with
the same CID). The send queues are shared by every connection on a
device, so looking only at the tail is not enough: a peer with two
connections can alternate its requests so that the tail is always the
other connection's update.

A packet that a transport dequeues and puts back at the head (vhost
with no rx buffer, the guest driver with a full tx virtqueue) is not
recorded again, as the socket may have queued packets after it. A peer
can thus make a connection queue at most two credit updates in a send
queue, plus one per packet the socket itself queues. The folded updates
are not sent, so vsockmon does not see them.

Counting credit updates in queued_replies instead would not work: most
of them are sent by local reads, not in answer to the peer, and under
bidirectional traffic vhost would stop reading the guest's tx queue
while the guest stops reading its rx queue, each waiting for the other.

With a user-space vhost-vsock "guest" that posts no rx buffers, 20000
OP_CREDIT_REQUEST made the host queue a credit update for each
(+18.5 MiB of slab); with this patch it queues two. A guest whose
device stops reading its tx virtqueue queued one per request (200 for
200); with this patch, two.

Found by an LLM-assisted security review of vhost-vsock, done while
porting a project from Xen to KVM, and reproduced as above.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 include/linux/virtio_vsock.h            | 66 ++++++++++++++++++++++++-
 include/net/af_vsock.h                  |  6 +++
 net/vmw_vsock/virtio_transport_common.c |  1 +
 net/vmw_vsock/vsock_loopback.c          |  2 +
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..0a5477a0443c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -99,12 +99,70 @@ virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
 	spin_unlock_bh(&list->lock);
 }
 
+/* Called with list->lock held. Returns true if @skb, a credit update, was
+ * folded into the socket's newest packet in @list and must be freed.
+ */
+static inline bool
+__virtio_vsock_skb_fold_credit_update(struct sk_buff_head *list,
+				      struct sk_buff *skb)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct virtio_vsock_hdr *old_hdr;
+	struct vsock_sock *vsk;
+	struct sk_buff *old;
+
+	if (!skb->sk)
+		return false;
+	vsk = vsock_sk(skb->sk);
+
+	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_CREDIT_UPDATE) {
+		WRITE_ONCE(vsk->credit_update, NULL);
+		return false;
+	}
+
+	old = READ_ONCE(vsk->credit_update);
+	if (!old || READ_ONCE(vsk->credit_update_queue) != list) {
+		WRITE_ONCE(vsk->credit_update_queue, list);
+		WRITE_ONCE(vsk->credit_update, skb);
+		return false;
+	}
+
+	old_hdr = virtio_vsock_hdr(old);
+	if ((s32)(le32_to_cpu(hdr->fwd_cnt) - le32_to_cpu(old_hdr->fwd_cnt)) >= 0) {
+		old_hdr->fwd_cnt = hdr->fwd_cnt;
+		old_hdr->buf_alloc = hdr->buf_alloc;
+	}
+	return true;
+}
+
+/* Called with the lock held of the queue @skb is being removed from. Every
+ * removal from a send queue must call it, as the helpers below do.
+ */
+static inline void __virtio_vsock_skb_untrack(struct sk_buff *skb)
+{
+	struct vsock_sock *vsk;
+
+	if (!skb->sk)
+		return;
+	vsk = vsock_sk(skb->sk);
+	if (READ_ONCE(vsk->credit_update) == skb)
+		WRITE_ONCE(vsk->credit_update, NULL);
+}
+
+/* May free @skb: the caller must not touch it afterwards. */
 static inline void
 virtio_vsock_skb_queue_tail(struct sk_buff_head *list, struct sk_buff *skb)
 {
+	bool folded;
+
 	spin_lock_bh(&list->lock);
-	__skb_queue_tail(list, skb);
+	folded = __virtio_vsock_skb_fold_credit_update(list, skb);
+	if (!folded)
+		__skb_queue_tail(list, skb);
 	spin_unlock_bh(&list->lock);
+
+	if (folded)
+		consume_skb(skb);
 }
 
 static inline struct sk_buff *virtio_vsock_skb_dequeue(struct sk_buff_head *list)
@@ -113,6 +171,8 @@ static inline struct sk_buff *virtio_vsock_skb_dequeue(struct sk_buff_head *list
 
 	spin_lock_bh(&list->lock);
 	skb = __skb_dequeue(list);
+	if (skb)
+		__virtio_vsock_skb_untrack(skb);
 	spin_unlock_bh(&list->lock);
 
 	return skb;
@@ -120,7 +180,11 @@ static inline struct sk_buff *virtio_vsock_skb_dequeue(struct sk_buff_head *list
 
 static inline void virtio_vsock_skb_queue_purge(struct sk_buff_head *list)
 {
+	struct sk_buff *skb;
+
 	spin_lock_bh(&list->lock);
+	skb_queue_walk(list, skb)
+		__virtio_vsock_skb_untrack(skb);
 	__skb_queue_purge(list);
 	spin_unlock_bh(&list->lock);
 }
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index e8481f12312e..7ef6f0c8dd55 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -70,6 +70,12 @@ struct vsock_sock {
 	u64 buffer_max_size;
 	bool recvmsg_inq;
 
+	/* virtio: queued credit update to fold into, and its send queue.
+	 * Here, as connect() may free trans while packets are queued.
+	 */
+	struct sk_buff *credit_update;
+	struct sk_buff_head *credit_update_queue;
+
 	/* Private to transport. */
 	void *trans;
 };
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 74a8fdf825d5..ba814e1c0344 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1911,6 +1911,7 @@ int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *queue)
 			continue;
 
 		__skb_unlink(skb, queue);
+		__virtio_vsock_skb_untrack(skb);
 		__skb_queue_tail(&freeme, skb);
 
 		if (virtio_vsock_skb_reply(skb))
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 8068d1b6e851..bffdc0b1321c 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -131,6 +131,8 @@ static void vsock_loopback_work(struct work_struct *work)
 
 	spin_lock_bh(&vsock->pkt_queue.lock);
 	skb_queue_splice_init(&vsock->pkt_queue, &pkts);
+	skb_queue_walk(&pkts, skb)
+		__virtio_vsock_skb_untrack(skb);
 	spin_unlock_bh(&vsock->pkt_queue.lock);
 
 	while ((skb = __skb_dequeue(&pkts))) {
-- 
2.56.0

