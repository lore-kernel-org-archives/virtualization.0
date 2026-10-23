Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741914;
	b=lkOj8MPXlcmw/u202hAGX+CSxH7Gn7ME+bFllTG5xCtITGCX/rFK0pFMxHRF55pxLTjm
	 ElIlZiuyTqgWP8zTggfsCT0jowazzzLovGKaCR5oJdOi8F/uSQS5382UQa0hhy4lDTPiw
	 PMGy0+9qP29N4n8vU3WablYtfIPR/neCmOWpTeMoTY9S8GfMROVLOBKxy/7glB1L5Oo2R
	 IJBXfZA+J11OPmwmYWZ2rLBhLTWKTcon0sqx3j7y71VdOa75UbVZmQnsgTxJUaTzpqwbk
	 64hPVEihPFew31bWa7QmllTAUEFZKJNBWAvT38MfZPhb9ZgMXHq4EEjF+Y0uqfU1/xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
	b=HV13nKVpKIrSaB5YG8wxI5jKXTJiK8FNBLWji/yTkP2gOqBQgbq3gugg4A1utGTCwYIm
	 6hcP1vOfNwh4QB7lBTZUhXB9ehepqcGt3PG377RTWxSuUDkUUTtlI+3GEUhPHMVrEZBSf
	 ka1UP2+2JgVRpfEjB6A/zbDh9xBbSJCaFPXDCi6guzQLQEQBBfc1XxR3/2sb2d6hksTII
	 i2ID0ex4tBaHNNn6HBYVknrYzt1jpgu+6VqbvtwV80uf3jzZZtK+x1OjHsoGSAFqJoPGF
	 UQiOMbY/DXtOaLhnCSCgErXWGk5TZSPgsjXiZbMT9EZuuMDRrMMWSSwOp9++AC93JPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXPC8R3x;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667F606A320
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 07:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3667F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXPC8R3x
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e946155442so4391145ad.3
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741913; x=1793346713; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=eXPC8R3xbKgTLFziaqDQffo1j9eH7iAtxkdu5dDiLoPrs2dZwg5wjGkb9qd1JJhR7G
         Yz1X4nYASyGDjAk3qZQ0pgraPJ7bVeoLT3SKiMCzrpUFroJ609E/tjFxqPqHlVEcKTKZ
         Bas3PWirpK4Pgq7HRWUmW8z0MHLm8qKAA4DoEz9Km7J5GdHDt7CQH6W9PGEihYlE1l4u
         yKZRu0dunvjqmImg1J9JqmrEShMLMMWK2+D4u73gmyJWvyfTmfjOM7d/8AFNRTneTNEW
         lafA4TVU7jyfsKLNiez4xflmkBo4GWOcrZrSizL4uE9+bQr4kNX/NJxTEMv8bnNzo/PR
         ia5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741913; x=1793346713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=0sOCIhnqXEnBUvBrEvYlDiyqibOhZhHssXNFg69Hs1HOZollXEg1kMP95yw0+azPsl
         eZbFSb5hzEaL4xvIAZDM1FgJYpV8p2Y06BKTP70D1NTyPf0LEx/xJuV91T3Y843H2Bd7
         uRtg4XLDA30wqngZXTXkEKYg980FIsx5AiO/8HvXmrZH3rKMGCttzAJB5zvrU8PM/R0J
         MOZs0eWIK6VisOGQnFMl49FDAEv4mIBI+jQS868F68384w7WTdktBmGvpi/yYNB+yt/O
         hhKS4zK9cJsIY3sUtVU9btolzNPjRb/gCVe7Z14lPNUYEyR4WygxSpMyqZcxHG/RV9uX
         Z80Q==
X-Forwarded-Encrypted: i=1; AKwUvBxIGFiFOP32j7VTYDQn2LhOlYv8AhN7Tkch43PM7QKdoUaXxYeKjK8QX/cIUkqIIGtK4SLbsuxO9f1rivZbbw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL5FOXasW5pRRJlL7TMeG4BFV6YpYLcQSskYcLWP6+BIgHEQhzz
	IpFtAEg2HxeUsPVZAaomNv9X347s60+SjNZeSU9fwDVuOSR5mjS1KZjh
X-Gm-Gg: AYBFou3ezF/kVFKZINSRMQ+1xTVoqCaSoFyVjT4uryicTNKfXc0eZo80x35YnbEcX8k
	PVtHMSDzlqATWoealeMLXwCbpFI9ewJWPsBo3dnx94xcP67J+QTrYz+J+WsKDEyJL0sCXL1868R
	u3o+ZbVSj504VY7hyH1AZJ0ZPtwWuZRosgM8jpTlBFydzvF4JmF3R+VdLHcJzsc3Pj34aNxFVyX
	G/itnkV2a4G2jDRCDqwfi5RdfMrMG4BPxgk5j/8KcTKY7RhmB95D0N/tZ9FwJ6Gt+eYh2nx/zFA
	+tS2i3pB8QvHWrKy2V78YjewnQ59xhZADvNIS/fctjP8ovGYkqWzqUMP5CbxQqPybQe7eWU4I4x
	Dzxq4Rmfu+9z+s2xZWz3r4kyoRS2lF/14oVe1Es7bcsko/KdBcY6flBO473veP7ySRRHhDI0hh+
	Mlg6XjPm1WAGK4AIo4CoBt5s5xqq+CE1Xxph7aqFJ4TnFHg/r/VSp8IZ47aqap5mmPbhtHON/lZ
	b2y9mbJVx4UM9kJk1MJi/ydBArkZvb7emZL6HQGaEJ1BAApLbEBw7w96g==
X-Received: by 2002:a17:903:2f44:b0:2df:aed3:2ac0 with SMTP id d9443c01a7336-2ea7d09c285mr14383685ad.10.1792741913096;
        Fri, 23 Oct 2026 00:51:53 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b368c90sm7208265ad.29.2026.10.23.00.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:51:52 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/5] vsock/virtio: split socket lookup from locked RX processing
Date: Fri, 23 Oct 2026 15:51:36 +0800
Message-Id: <20261023075140.9613-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023075140.9613-1-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
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

Split virtio_transport_recv_pkt() so socket lookup is separate from
processing that occurs while holding the socket lock. This prepares the
receive path to retain a looked-up socket across multiple packets in a
later change.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
Pass the caller-provided network namespace to the locked helper so reset
handling retains its existing semantics. Preserve source validation and
failure handling.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 131 ++++++++++++++----------
 1 file changed, 78 insertions(+), 53 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..43325d7aebbb1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,6 +1774,80 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
+static struct sock *
+virtio_transport_find_socket(struct sockaddr_vm *src,
+			     struct sockaddr_vm *dst, struct net *net)
+{
+	struct sock *sk;
+
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+
+	return sk;
+}
+
+/*
+ * The caller holds sk's socket lock.
+ */
+static void
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk,
+				 struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct vsock_sock *vsk = vsock_sk(sk);
+	struct sockaddr_vm src;
+	bool space_available;
+
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+
+	/*
+	 * The socket may have been closed or reassigned after lookup but before
+	 * its socket lock was acquired. Listener sockets have no assigned
+	 * transport.
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		return;
+	}
+
+	space_available = virtio_transport_space_update(sk, skb);
+
+	/* Update CID in case it has changed after a transport reset event */
+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
+
+	if (space_available)
+		sk->sk_write_space(sk);
+
+	switch (sk->sk_state) {
+	case TCP_LISTEN:
+		virtio_transport_recv_listen(sk, skb, t);
+		kfree_skb(skb);
+		break;
+	case TCP_SYN_SENT:
+		virtio_transport_recv_connecting(sk, skb);
+		kfree_skb(skb);
+		break;
+	case TCP_ESTABLISHED:
+		virtio_transport_recv_connected(sk, skb);
+		break;
+	case TCP_CLOSING:
+		virtio_transport_recv_disconnecting(sk, skb);
+		kfree_skb(skb);
+		break;
+	default:
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		break;
+	}
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1782,9 +1856,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
 	struct sock *sk;
-	bool space_available;
 
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
@@ -1808,13 +1880,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
+	sk = virtio_transport_find_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		goto free_pkt;
 	}
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
@@ -1828,52 +1897,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
-	vsk = vsock_sk(sk);
-
 	lock_sock(sk);
-
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
-	 */
-	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN &&
-	     !vsock_check_source(vsk, &t->transport, &src))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
-	}
-
-	space_available = virtio_transport_space_update(sk, skb);
-
-	/* Update CID in case it has changed after a transport reset event */
-	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
-
-	if (space_available)
-		sk->sk_write_space(sk);
-
-	switch (sk->sk_state) {
-	case TCP_LISTEN:
-		virtio_transport_recv_listen(sk, skb, t);
-		kfree_skb(skb);
-		break;
-	case TCP_SYN_SENT:
-		virtio_transport_recv_connecting(sk, skb);
-		kfree_skb(skb);
-		break;
-	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
-		break;
-	case TCP_CLOSING:
-		virtio_transport_recv_disconnecting(sk, skb);
-		kfree_skb(skb);
-		break;
-	default:
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		kfree_skb(skb);
-		break;
-	}
+	virtio_transport_recv_pkt_locked(t, skb, sk, net);
 
 	release_sock(sk);
 
-- 
2.53.0

