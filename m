Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679148;
	b=WXPTjN/FYPAnXfJPMrUXXwz6DhY7hTjRiEv5cPEubzZOecBQcY5HWGLbXEaKL2eyWpqC
	 Ed0XEKSkKq0qxtH+NI6GdNE7U4isEsXnUqZ4Fb1W9UfRWFqk8bZiqf7ZeSJi4zirGTiae
	 5vwoL8gc/3HFxIIdhMWqsowgmnTgj+2CJMeKvGRPdcUjiyYUW+7lhjXLJXj/zUupsHi2e
	 EMGz1QfDE+i5fMyWtAUeHXfGiAMy25pTeIjZpf7fm1B9p61IP03yhsB8COm9enjWidFc9
	 oJRGPZM1IYbP58ihrx8Gx08oROLXCW8aCtptRCDsA08WXSiAQwgfbi3DpjfVnqkPsAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
	b=zqSyUaI+G8gq8RSF/5CrH2oQf/kYjLpoYATqVB9DpxW7bvp4CL4UhsIDjv3MIlp2Txfr
	 6c6pjSgFohQeW/XEFS0mgmhbQ2vXbf90fjx1fGyiApXGucgOr2KBj0wYs9lek3jEGRjhD
	 K4IbPFydDrEjnQnC/wedzNANDgdptr9qRMmV54Zr/liF5E/e7r4n49H10MdoF+7N5g+Wy
	 2fKVxqa9DRzP7bSSV3bdEn1hCmjbr/qqs0WwgIIqvvGTzSbTf7S1b0ULUOqWeGsYbm1P6
	 pBvwLAbmWlSaqDQ0u6dRwjy7f9k/xuFN7EF3PsX6lKMRaJUfsCa+zkU/4HLLYex6oiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DX2nHRlk;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E6F606A327
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 04:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E6F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DX2nHRlk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1122058a12.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 20:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679147; x=1794283947; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=DX2nHRlkjPdWzeU78LQ/qHdbrCWWQ3f4WVVEIDrERi8xdfQX6zGOzShvvfUKqUKQwh
         u1LfF/L5XR8yl1yWxL8Fq06+IE2gyW18SmWyO3lT7N1DO6Sc4ueA9ugRyZL2ZA0j2Jsy
         c9sApgl5t9bHbcFHopXoftwW8sq3LNWo0Ogf/rLktClVC2CP7jdai3/HG4OYuhEIAs3c
         dlyZ1Xa+sqv5dWW8Hrimz534czJUBhoKhJ/QY6FT3W2g+uD9vGqz8O9AAgk7E7dUbr4c
         GNGefF3MvfQh6humOu1clIyWCm+FGQb3+Rm63kuYIRaawY/hPyVcyimkessOmOZVL7ds
         AmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679147; x=1794283947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=zzht8eaU2qXKxEICOVMrDN9uFk3DV1WzDwmiTM19nlz3XH4pec89aVaZ2ZIRtHWygq
         qpUMNLnDKQ+r5ZvpVSLwDZcRwMSQa0ta8rO3ym6gJCOX05SMf/c5iB7d3VcWM14pvxym
         1Ww2cAbqGE6gRxsd3DA3R4B8iYv8ZHMh5Z1uEcmEMisW1Rc3llh+xQz0QgTQKcn4tXY8
         tipQtAS74kA3p5IqsSwMPF0sKfl342ad89DfeFzT2nKYZRVT2cFbfWNGvNyNt2dw1a89
         bsY5uTuRh3uLdJhq16mjSEIsCb/WbaJ/H4oZGjhwytLOxyod2eH6mTVcTQU+8Qi9Ivgf
         +lkA==
X-Forwarded-Encrypted: i=1; AKwUvBzhTrooZjGNPENa3CRxfJTtaPtbgaYBPeCc8N2rw3oAgCgy2s1e2SbGfexob9Nf3lvBmXmCcJdRFgNf1LEFhA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/IFZ0Mt/5JLxvoaL8Cri6JlfITik21o1/L+FHU4mp/Fp3tTecr
	/REdLWwkbToySJUp/gbioNYiDN8avrJyGPIpp9FywNKypMTeDQqTgF1m
X-Gm-Gg: AYBFou0Uy7JSC4UvkMFuCyL8+zj5XvQvzEuHHXWkg9E32Idoq1FH+FPMPukXzkmKp69
	bhs/z/szHsGzhIEqJSWPDTGQxMtvZPLUoeZRLJ6R2uKncONPbiql0oxtG1kBwyBZmXSSReGTeUK
	wq2rHBBJg4LHLc3WoYMwJ02iu8yuFxNwsspbdLv+yKeLV152jf9qGZMClBcgxN4WOIzJwGa++gN
	Mnei4mLzs9upGT+fLrVFyjuGcqL17mjoxVtkO4JwAnaocTENkmhXhz0NWadGPI/SW4BFYFoKQDU
	cju+ceXKVHnqZurhM8UQiPWI/c3ZJ2CQv5TDY2JJwI0OnRmiIYVsAzUjs8sEfqN2RZFHThM/giu
	aE1Ai+UGAHogduQBVWqt5ebrH98pAHiFUHdg+7LVqX9rvE+WOEZSgd5sz5eLDYDriCrAKPrgjL8
	uzSVw/l/o6fq3a92ApvphTPeEun6nIqNLlzuxUp+QRdC+MArILzro9G7KoaWjZkQ4Y6EDoTQt3F
	jsuCxaRawm28jdrEgB4eecFWFNvD5/T/QCsF+vb6RcuhTHohdUtIJ8wqvDqEQXEXxfKXUa0ynSF
	mvPI4u8=
X-Received: by 2002:a17:90b:2888:b0:3aa:fc22:8aa7 with SMTP id 98e67ed59e1d1-3ae89853f54mr10262747a91.53.1793679146575;
        Mon, 02 Nov 2026 20:12:26 -0800 (PST)
Received: from gmail.com ([2407:cdc0:f00f::117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6f010asm1941708a91.15.2026.11.02.20.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:12:26 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/5] vsock/virtio: split socket lookup from locked RX processing
Date: Tue,  3 Nov 2026 12:11:30 +0800
Message-Id: <20261103041134.33310-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103041134.33310-1-physicalmtea@gmail.com>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
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

