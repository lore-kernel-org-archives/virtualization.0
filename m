Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381D4FB9D9
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979026; cv=none; b=LUS1CApWi+HWaH9rjHvDVPW2+LrKk0ZfLAyMglgHMYvTee2ik7Jus6946WgyyElEIkB2vCwBwVV/aQr0lWQtXXvX9CWA5WcOiCBHw8TZ2okjkDR2LR6gXrfEqs2YI2BKAj4V0fSnH63iILxHTkxX5UjktU3XGy4u9DvepMWFHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979026; c=relaxed/simple;
	bh=hbtnE8W7pRRMU/4pmxjsxU1MHonesorrNXzdBRBb6sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDZefX0zAlrqvI1C99RY46tHp8MGTFNWoj2I8cwgRLaSPysAKZoq2p3hIPegw7tpiF1h79XCet7l800d8k2KeXHiGe9Inp5IKTXl/7rhaS8xWEH6rZesO7Zk9sJ9+nEX5dWuqlFTu35DVEp5gHpcJY7RvRX0T28Yh3Szbtzl0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pL4/F1Pu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL4/F1Pu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso3052521a91.3
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791979021; x=1792583821; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w7y+RyZF/0euqEMjj6lXHC52QPFtTJhGKHy9NrMHBD0=;
        b=pL4/F1PutFoj7h7KU4Ed1EVUTFGwJBexiD8Xuzyw80NHy6DC8EUBvZ+0mytQtmxDVZ
         GtjXAaMU/Kwj4EY+C8Fa4yho0TPF5OaQ+iyWL3KV/vrj+Wq/JJTtVZFgQOlno7fnBkbd
         ydsEIpkkp3eYanoVBWz9MPmbgaoYM/Wsg1UuKQH17/WYTLEEzoyuZTCnQBL5ZhI2t4Cb
         qkqynLOzNrOy4mEYtn6qGBRZmHd3m6lxOUHgXEi/xztF3363+ul4ScrTD9lDZah0dF8W
         UwdUeB8fXtTfTanSTJEjAEqKCqG8BRY8POjnq0fZbPvZQnKKXEnXzLlH+6/9Ya/5imWY
         /oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979021; x=1792583821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w7y+RyZF/0euqEMjj6lXHC52QPFtTJhGKHy9NrMHBD0=;
        b=cwbP7QRipfPuvx0RtXNhjn3TS/kyBCQxHr2KjXakoFBRbQueIBWqfQ+BJmxXK3hV2O
         IgQIDiDnZdpdtBTyO/W8EpRdBiJajWYlJB5JTKo7Wh905NNoQj4cyevQsSb0zUQYwm61
         5vx2TUbf/gyUCvW02EmXXQXtJAYyv8Agquq65zGIeP+HNsll8KD7lQQ7ickk3N+72/Z/
         99bmg/BvoqLWbdgaE/pl/uxjwPiYLyeJJTwHqX/HZ2bNMo5XWSKLlwiYZHFuDX0gNnzL
         o2JeKVta/+W/WcSOVjmWqMFJI20uKaiVcZQowRwuVJ47iBCYKg7mu4WkRDExR7DomPaN
         kqiA==
X-Forwarded-Encrypted: i=1; AKwUvBz82s8w6eNE+HET6YjsphwdhHcaKyM9PXmK8/IpkMidpksEj9YZ3GpLxVlXQpa4beAcgurht5WENKnR2cdrGw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJpTWSr92pNisPnrvRMZ9SvMye708nPfgGkKkYnvus5QKq6V5Vn
	vEfUogjwSCcrNK+2iGlqIYfJasGrbwLs+fSYxPoQyDEd6nmv/KcYSnIo
X-Gm-Gg: AYBFou1N0wCAzjz7653XJoKlnOIcCxb+9VM/QPVWnzldtoCsRxeBqyRc5YFpDVCpy9j
	1YiCOcA8j9Tt7BVeNEK2J8MLGr99OZTYq1auIegzX1OQNO98vMkmg49ryBsDLiHnWc3Q+Hfc6SG
	bm1ZWB40NqFMJ/xyPnncRAXYT7YRRoOrzs/DP+c7A7WRVqEl3Q93AaD9GfO++rxrB3CnbFwAzhY
	s20cuASsp4QKp3AthIy+cSXLqnRpFuGzuHC4E8OL0FfhTPNos3EeTg1b+s5Ccy1JfKBQPrvbI3j
	NdaPNE0/8fdO4t+ToJSFhsQH6GNIleqUkdJOag5H0JpXO4kJngsFbDZMb0HhCF4/MTz4HmISQeT
	6T3phWoLX59Hh6SH2R4ODPhKmQhYYcBrBxir19qJLQetu5xcfn5Odk8mCeoQ3nMImZIwMK017BC
	UZ4NCYbZw1EkyfQzvEJUWYszgZCeUIOGiVifW+UjXy/sEsL4XQrM5DUwHf5VsciOJIKd0ysA==
X-Received: by 2002:a17:90b:2e0e:b0:3ac:7556:8ee6 with SMTP id 98e67ed59e1d1-3ac7556a46bmr1378653a91.16.1791979021010;
        Wed, 14 Oct 2026 04:57:01 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24b74csm4795691a91.7.2026.10.14.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:57:00 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@gmail.com
Subject: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from locked RX processing
Date: Wed, 14 Oct 2026 19:56:37 +0800
Message-Id: <20261014115640.184286-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014115640.184286-1-physicalmtea@gmail.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split virtio_transport_recv_pkt() so socket lookup is separate from
receive state machine processing under the socket lock. This prepares the
receive path to keep a looked-up socket across multiple packets in a later
change.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
The locked helper obtains packet-specific addresses from the skb and uses
the matched socket namespace for reset replies. Preserve source validation
and failure handling.

No functional change intended.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
 1 file changed, 75 insertions(+), 53 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..61ee3bc205d5d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
- * lock.
- */
-void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb, struct net *net)
+static struct sock *
+virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
+			     struct sockaddr_vm *dst, struct net *net)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
-	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
 	struct sock *sk;
-	bool space_available;
-
-	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
-			le32_to_cpu(hdr->src_port));
-	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
-			le32_to_cpu(hdr->dst_port));
-
-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
-					dst.svm_cid, dst.svm_port,
-					le32_to_cpu(hdr->len),
-					le16_to_cpu(hdr->type),
-					le16_to_cpu(hdr->op),
-					le32_to_cpu(hdr->flags),
-					le32_to_cpu(hdr->buf_alloc),
-					le32_to_cpu(hdr->fwd_cnt));
 
-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		goto free_pkt;
-	}
+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
+		return NULL;
 
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
+/*
+ * The caller holds sk's socket lock and must free skb if this returns true.
+ */
+static bool
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sockaddr_vm src;
+	struct vsock_sock *vsk = vsock_sk(sk);
+	bool space_available;
 
-	lock_sock(sk);
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
 
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	/* Listener sockets accept packets from any source and are not assigned to
+	 * a transport.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN &&
 	     !vsock_check_source(vsk, &t->transport, &src))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
+		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		return true;
 	}
 
 	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
 
 	if (space_available)
 		sk->sk_write_space(sk);
@@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	default:
-		(void)virtio_transport_reset_no_sock(t, skb, net);
+		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		kfree_skb(skb);
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
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sockaddr_vm src, dst;
+	struct sock *sk;
+	bool free_pkt;
+
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+			le32_to_cpu(hdr->dst_port));
+
+	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
+					dst.svm_cid, dst.svm_port,
+					le32_to_cpu(hdr->len),
+					le16_to_cpu(hdr->type),
+					le16_to_cpu(hdr->op),
+					le32_to_cpu(hdr->flags),
+					le32_to_cpu(hdr->buf_alloc),
+					le32_to_cpu(hdr->fwd_cnt));
+
+	sk = virtio_transport_find_socket(skb, &src, &dst, net);
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
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
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
2.53.0

