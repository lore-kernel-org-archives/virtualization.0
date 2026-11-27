Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760849;
	b=jNXWQ1+sOhKh9JjyHdYCB8KCAt2Z/wT3ly6R0D0Fuy5eYjjzea8oGIB+AfcUtH4tZXml
	 E1N5M5cBiLHFKgjqG8jL25NUNJk8GSRWC6hpv0dwN7j85iTyUmeFQzixRVc4TZhRKok0j
	 kfn3EUZmJkTZ2tbWyNW/2WEwDTsDkV/PimZfJxSDp0NNA7TaHHciJl97vOd3xIf4Rvz8m
	 SrsXEIgRj+GgS7pxS6B6AsvRbi0AMO9RCC9xqZPxZ5lqxtvqWIl20fkiina0HD3N9SVbn
	 LHgoN1DtRt8WFe2awObMO3Q7ShQ2ft5tp6ZQt7PEEpb/Ecz0HDdGadeX59kObWawczQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=maKflaiPp/YK1JfzITWg8f5N71eYZK+7tr9+lBawIHo=;
	b=J2fCdRTTe1lsDxhNvS6Bdl7xdC/qrIYaCBDtAPxzeSZet5k68XVd5AbfuazpbFL6SSGs
	 hP1xkHV5tIcHgFeYBO0d/nNq1GIObY9aDXSj0MUSjBsVqJPsotkTRP6SLn9oU8m7pM3Gf
	 Jp8IVF/JFsktSt8RU/XLSz4SSCcpdy9+Jjce2LOoje4NGvICUS4hkGr+em0vSj57+CueS
	 NWtEyehjDm2yxMbeFy3b4t00DZjXnAKMrNY12Sr215uyKVMTaLG8UKLhJvwrKRCxqf+fQ
	 21geo/f1FZUKtHULQwLgbA4VwCTZ67YVEOXnU9UVdmtEvayjabMxAQ3kVOedZ1jJV6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tMM3C6tE;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64517606A329
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 06:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64517606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tMM3C6tE
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f04e3bf46dso57016405ad.2
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 22:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795760849; x=1796365649; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=maKflaiPp/YK1JfzITWg8f5N71eYZK+7tr9+lBawIHo=;
        b=tMM3C6tEWCjQMMO+RchKrIq81ql38MlKgs8mK+bDDmyyi0elfJfozM8/2zUibzlCjl
         YOrTxdCx+y/Qig0Sn9ri0EHiCObSaimeVFxlM5co1DvGY98cqX8Xf5M3BkT0Nt84Iz3z
         BDCPOYUmn3o1/oIqztKsppa8H1eZveJaQCJy36lWTZvfV7jhByZfgvp+cpNOLyaa4mYG
         uTM790QJwTJ4RHw4jC8+9Qq6slBzu3PrEjFIenBThlgzteEuh07oByoqCuHUccI8AjfN
         UyQga33Q4vn3C5xfegKT4h28GSgSATiatg1d7Ll9cxPOLVQ0pxMP4e7fvTMkWWwFOeXZ
         LTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795760849; x=1796365649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=maKflaiPp/YK1JfzITWg8f5N71eYZK+7tr9+lBawIHo=;
        b=prbxjuogi5hg0YYSJGlzYwYCYQ/UkTcmhNaGUdd4OtA/076aLTMUEZxLD4h+5dyTbY
         Se7sZ+Jkx8F498zOeyPV7tKFBith/k8pJi9S+kS08CQzEo7c4c+p09LxP+J+v6nVCIWg
         8Tpfz1kSw8x9uTZuPfrBzyZbZRoedY7UTVVv2HLLSgJxXAfGCWywIURUxQJQ10mC9csu
         Y7ANTAyOQEeYWYP/8fN4TlJyjVTrtybOr5Rk9W/i6MLeT4UTSlXaJ8zm+1vr/TuVZ4R2
         +it0m2e7HGHKpxH4WD32RtSdS35YVBhFzW7sq6FKBsnccrA9UktkYGUTCjjoh1Qly3/3
         +oAg==
X-Forwarded-Encrypted: i=1; AL+hErH2JiAwgCJQrVhd0giGMF7FZ7StcdWPhxc/jhz2z4PPYQRhgulqJ+0ydiTBmRItFEsZnJVfSBdkWByDbv1ttQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+wJXAijjOJhrwQQQ0QaQ8iVSVsyq2y1O8CnkkgfEjp7MSmXITe
	orXMYkzXQVV/nhPX+ZsuF161ZSQ3py7QwKNHNWHXIaaCwyhZSMLgtyEp
X-Gm-Gg: AZFdTZeXwqPIuDqSo0mGBRa1mFPbG1VsqDl1RtbZPz3A0QfcbkC+6MB5Co56FarOVNI
	6WkNmjM7iznI5q0HQg9CoRFvo+o1ZRgPN1Yx8nheUIq17PoyOEfVlrzZsm6NC++3yerAiZ45lvG
	tsr2VStRkLm2UA9p8Tywj/tqKolfaYiWt/ftFWu1q2FICS/7skQWgItKm9PHARO9CWljm4ozsFo
	R1I+at0Zwax07pyMXILwDqnOnQ/iXWDM8PaAlDXvNWNVjobUWvYalSbWwUH8Zwpa43VHXthP+s8
	6e3W+8T0ASGuOySoPBiAq8vODX2T4dDiV1DZj7FaPeS+RDGcQqTlTs5X+xzlbTWtZ2NsD1q62Ly
	nUyPQaCX3F689rv/Du+IAvukT5gULndB0tHt49oGdjXUmHhkSZnxaXABguQsT66gAP6vQ6Evm+c
	CJt4R7H8aeE/9Pufdrp4mZcyEjjr5Wvk6l2RHWGO0qJrKtxB0JllwMrqCoIrqi7xCouLqlmtjDU
	KgSrgGOCfw56xIE87ETP8pPE5XFjBEVlfsSe1s4Ccmfg81JJ5ReVuExtyDPsigzqc5nvGtMsU0+
	jg5wdMYyN5c5dPWNLxYJGxLOv9yrUjiWxv9bXcYapxHh5w3u5Q==
X-Received: by 2002:a17:90b:4983:b0:3b4:ba6:f712 with SMTP id 98e67ed59e1d1-3b41c9988f1mr25740776a91.60.1795760848600;
        Thu, 26 Nov 2026 22:27:28 -0800 (PST)
Received: from dbg-srv ([111.194.74.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm15986522a91.4.2026.11.26.22.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:27:28 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/2] vsock/virtio: split socket lookup from locked RX processing
Date: Fri, 27 Nov 2026 06:26:59 +0000
Message-ID: <20261127062700.29387-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127062700.29387-1-physicalmtea@gmail.com>
References: <20261127062700.29387-1-physicalmtea@gmail.com>
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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 132 ++++++++++++++----------
 1 file changed, 78 insertions(+), 54 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..bebf63115b263 100644
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
@@ -1828,53 +1897,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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
-
+	virtio_transport_recv_pkt_locked(t, skb, sk, net);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
-- 
2.53.0

