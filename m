Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464B495059
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642210; cv=none; b=gjpyxzDzQuZkXX6RFnq0x0O9a4deA5a1gwTa8knrHAK+XPrzn3SFeUQJhYpTvBv/WToFAO28LJiTAgOJoireTRJyTz+4AHVtv168D2PpQUJWn4fw6RPChV4UDiKQLFOmqLSqZoM/ikCQPYDrhzofiVWxp1MxJYxC/XbJqPeNFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642210; c=relaxed/simple;
	bh=SrTKDRuW9NZ2EjBREXpMO3zaIjzegK2qKsQrkr1UKlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAnU93YR020C08MtS1IhwtTC4JaUqjhZA2VWvKW4qivr2Mf/YmdYJazIoCkCCT8Xa4/yKdSfFovF+x56KQUHHqvXB7tW4OZQNoHpFk3C4Ptr10Da0l8tdWruhmpkKnkpzMEN3puOw9l8CPgUwF1DclG5rfHE7DOmT7s9I7MvTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlirmBTX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlirmBTX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e61f017091so3428545ad.1
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642208; x=1792247008; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ft+6QFIF5f2VFqvcShDWqZDBbOT/nzezeoFifhj5jXM=;
        b=RlirmBTXqOWajyrYpoW4Uh7xKHGBT8g2ZVNJcSgtm5x8mCd3wrEuSttFL7ZaWyitVN
         N53vqaHl+Is7BcieDHIzu71RrAFMsPIjTTR5ki72ekbpMpakFKSFjtqvReybWrJfEdDM
         3HGUShWKo4xNhHhk6Dg1gq96v5/NZYrWbTdULYweGtUQzyBFsDM57SzsevfpW4inNdD6
         wSuKsSNAfPN+K+K20EmGD6+1kAkSztSMlamCnx2ZABzvoyQll7nvq4IuREMlyXJHE84R
         hpV03Wa7aNgTRS+ZLqkZe5o9jKsZbCJ4zKVXFWV9qeJmyS8t77Vwwt42PbfKYmjWA+E+
         nRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642208; x=1792247008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ft+6QFIF5f2VFqvcShDWqZDBbOT/nzezeoFifhj5jXM=;
        b=u3jeuwNzdwAAc3mgs9wleX4FNhnu1eqDPi1IjHDxLU7LSW9cQgq3DcWMLAM61uLjK5
         nSBggzlVgAzN3yLr8rEszFus3rsBmSVRm+v0TzVVIX8QGD+cJp1lAd9mQl+Vtsq7CV6j
         BBl33e23h9EAHITqL5ti7ioSRIq5VoIEOBzD7yIZPnmg5ELlJf4+MrmJqYez2zG7waNc
         +VF9XsqXn6bFNX8JKJyKkbcAslNV7yXJy4NkAAR4sMLBw/YiuzenEIfRDcLs13fGuXW4
         QV+ieerPNXeTMsDFQ2pIuuFU2JYcLzrWHJwwhnHjD/wnfF/m+DGmiUOVPW9GqOIt0Xje
         g+8A==
X-Forwarded-Encrypted: i=1; AKwUvBzhYKf5ZGoI+sxOZRXyrIms7kUwcRpcWFJPPySOhba297tnDaTrzzpq/Ojnv1LwZj/3TswIQjtHeHkB5AVieg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIxcVCRKL8uYHwZXa3Q6aL+5+5feBvrOFXfql97W/J4bVORKqBZ
	EtFGiml/TNyFr6MfXYDgmGkRbvB5Q9Rx5cetEuHaSda4dYwKIvzKjA/3
X-Gm-Gg: AYBFou1JjnX/zL754+yPV8r/ES+7C6zjdXn/nECU7zzblzY4TYINUKFpX+JDYWyaz8U
	SoFguJx9hF+EBYjzrzMIVF+oYIJ4Nx52jw4BDdLIikedcPHwMOFY4whssllIgWkB7RhUPWi1sUG
	ax4/YiHXKvIQn+BRKXj8NIKlHGO8Gfub1K5Vn19N1q1X05TmS70OR/cKifnxLxGabi2l7aVW9A3
	KKbrVbFB5QZZzhb4zejXCMbjgqTMF8/goJQp1rHH+S6wsJPgGkWyTVzZ+E8ekqzmpAfV6dnSBBu
	2qfrufVF4Ix6wmg6k2hBm25Pt50wFOGbmcyErspPp/UCO5HaE9Q6OWG9Aj1h9wKApY7Ef19Lh4J
	hTfb2MINvpyS4aO1FUFzLDvGMEfzQLdK9+lpKi60DjOW29LzMXghgylyoFzgNhiEK2sWoW/5TNI
	56CMnEbJQsSCrq1+ENcTde3moFe0uVvwTHsmmFSlH6MmiD+OwK1H1+1bD1mOBWWQiCy+OkHg==
X-Received: by 2002:a17:903:15c8:b0:2e8:f7a:c69d with SMTP id d9443c01a7336-2e8429a8013mr40631895ad.15.1791642207520;
        Sat, 10 Oct 2026 07:23:27 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:26 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from locked RX processing
Date: Sat, 10 Oct 2026 22:22:43 +0800
Message-Id: <20261010142247.99223-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010142247.99223-1-physicalmtea@gmail.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split virtio_transport_recv_pkt() so socket lookup is separate from the
receive state machine that runs under the socket lock.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
Pass the source and destination addresses used for lookup to the locked
receive path so they are decoded only once.

Pass the network namespace and decoded address tuple through a packet
context to the locked receive path.

Preserve source validation and failure handling. Keep the lookup reference
separate from the skb owner reference so the locked receive path can manage
the two lifetimes independently.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
 1 file changed, 96 insertions(+), 43 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53..e3e75e5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,81 +1774,97 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
- * lock.
- */
-void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb, struct net *net)
+static void
+virtio_transport_recv_pkt_init_addrs(struct sk_buff *skb,
+				     struct sockaddr_vm *src,
+				     struct sockaddr_vm *dst)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
-	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
-	struct sock *sk;
-	bool space_available;
 
-	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+	vsock_addr_init(src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
-	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+	vsock_addr_init(dst, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
+}
+
+static void
+virtio_transport_trace_recv_pkt(struct sk_buff *skb,
+				const struct sockaddr_vm *src,
+				const struct sockaddr_vm *dst)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 
-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
-					dst.svm_cid, dst.svm_port,
+	trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
+					dst->svm_cid, dst->svm_port,
 					le32_to_cpu(hdr->len),
 					le16_to_cpu(hdr->type),
 					le16_to_cpu(hdr->op),
 					le32_to_cpu(hdr->flags),
 					le32_to_cpu(hdr->buf_alloc),
 					le32_to_cpu(hdr->fwd_cnt));
+}
 
-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		goto free_pkt;
-	}
+static struct sock *
+virtio_transport_recv_pkt_find_socket(struct sk_buff *skb,
+				      struct sockaddr_vm *src,
+				      struct sockaddr_vm *dst,
+				      struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sock *sk;
 
-	/* The socket must be in connected or bound table
-	 * otherwise send reset back
-	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
-	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
-	}
+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
+		return NULL;
+
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+	if (!sk)
+		return NULL;
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
 		sock_put(sk);
-		goto free_pkt;
+		return NULL;
 	}
 
-	if (!skb_set_owner_sk_safe(skb, sk)) {
-		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
-		goto free_pkt;
-	}
+	return sk;
+}
 
-	vsk = vsock_sk(sk);
+struct virtio_transport_rx_pkt_ctx {
+	struct net *net;
+	const struct sockaddr_vm *src;
+	const struct sockaddr_vm *dst;
+};
 
-	lock_sock(sk);
+/*
+ * The caller holds sk's socket lock and must free skb if this returns true.
+ */
+static bool
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk,
+				 const struct virtio_transport_rx_pkt_ctx *ctx)
+{
+	const struct sockaddr_vm *src = ctx->src;
+	const struct sockaddr_vm *dst = ctx->dst;
+	struct vsock_sock *vsk = vsock_sk(sk);
+	struct net *net = ctx->net;
+	bool space_available;
 
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	/* Check after acquiring the socket lock. Listener sockets accept packets
+	 * from any source and are not assigned to a transport.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN &&
-	     !vsock_check_source(vsk, &t->transport, &src))) {
+	     !vsock_check_source(vsk, &t->transport, src))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
+		return true;
 	}
 
 	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		vsk->local_addr.svm_cid = dst->svm_cid;
 
 	if (space_available)
 		sk->sk_write_space(sk);
@@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		break;
 	}
 
+	return false;
+}
+
+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
+ * lock.
+ */
+void virtio_transport_recv_pkt(struct virtio_transport *t,
+			       struct sk_buff *skb, struct net *net)
+{
+	struct virtio_transport_rx_pkt_ctx ctx;
+	struct sockaddr_vm src, dst;
+	struct sock *sk;
+	bool free_pkt;
+
+	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
+	virtio_transport_trace_recv_pkt(skb, &src, &dst);
+
+	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
+	if (!sk) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		goto free_pkt;
+	}
+
+	if (!skb_set_owner_sk_safe(skb, sk)) {
+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+		goto free_pkt;
+	}
+
+	lock_sock(sk);
+	ctx = (struct virtio_transport_rx_pkt_ctx) {
+		.net = net,
+		.src = &src,
+		.dst = &dst,
+	};
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
 	 * bound or connected list.
 	 */
 	sock_put(sk);
+	if (free_pkt)
+		kfree_skb(skb);
 	return;
 
 free_pkt:
-- 
2.34.1

