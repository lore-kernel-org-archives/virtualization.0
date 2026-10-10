Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549949E5D9
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642237; cv=none; b=ofx5vp/7nSSGoPmsLvdw8IGzeflautWgLHx6OtDKJqWTTf3LRg76p/cEWqFhRY0sAapUMaoedzcz5uvCyxGqLFEdI2SEZup8oiPdA3IUUoTwB9vT11W3TjuVbiEyP7BB4f3mvM5fycZ3IxQ/i5hg0OjhcR62DBbY/+GhNohfRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642237; c=relaxed/simple;
	bh=L1eZIEVU/ofQte2gvNih6Bludiqn1MxT0tCVYZyJVP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEgaq2iA7ZRwypuhnsy6WJhfm0WYr2nTagcxfQs8lo7RRed70S//AQfBtnsCfgYmg87tMDSE2xKPvDd7xO3mrbOOtQMNyCVGX3wg9ZRwZZPKF+7O3Odg9W8is3RTe3UivYWfo8TnzIM5pRHJNcTcgnkZEnPvjPzUfol/r7hWVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPZcQd/R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPZcQd/R"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5378b281aso2926435ad.2
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642235; x=1792247035; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ow0+9kC3h+sUBY7u1HdgedXX1Au0fVpDxstdKdYipeg=;
        b=MPZcQd/RJuxwVVybQ8FrbIo9pbAcGFEmJcP7spvZXBR4/siaN/SSVYnixFjpvyw+Kf
         P/wyy/FjYW4X+mStcKJYsnjBSYUPYqSc0ipTtVMVkuWmBaUzVdkWuO5kFCU09UkhiEyn
         MfZUBcOZWKCvFDCFAFBBUnmU7Uj4zJIQIdbPuzhXkV64wZeD28khP4IrEUCtyrNsIsBh
         wqeIYDhwl2221OxQee8y8kisGIdaYxXBOmFVnkr7PokZz6FUtLNQlQgjMH5HTM+3RUyX
         nCJSDMCXpvrhAbxJomGVyNkoXiWjfaljQLrsNn3taFJS4yRT8dY+6JZibLaNj8DcNknA
         yrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642235; x=1792247035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ow0+9kC3h+sUBY7u1HdgedXX1Au0fVpDxstdKdYipeg=;
        b=m2Ep5Lsfkcvrh/Xpg5R7w0YY5XvCc+uy6vYiIRTDrlYk6qOwlj0k5H35D58LBTH2i9
         RQs0MSkX7QFyPO6x4XitbE+FgvrPQn/rgqSAtpWJSs8NoA96sHBFVmW0O1yKMSqQnwAs
         1qfv9Oyt7HBKQjls/yFRVp4v5i7MmL3BbVnLu07OIDNVjy/A47RIK0G3Sxxp8HvBSl3K
         xwViUnRkSCKgBUMRMCBkN/BZP28zT29cgX67Df2Tt4+YTNz5M9wRvNpEB0Rxph4PazK8
         LaN/S7Y6mrUlHDP+yBwgVO1EJ/NOxTWGAQ2YhmUP07n7lJDDw1lICmVrQaml/lLPfGwQ
         0dcw==
X-Forwarded-Encrypted: i=1; AKwUvByem9wk4gSX2OxcZkc3wcElZW5uJCB+/KBndcAljfyHV1xjYfOr1K8Vtzc7m3HIjVdqPpVZdUOTsjn0JyKqVg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI+au+BbUR5NDDAj+cjd+hoVikHYJ8RmW8yKMkmiG7isTjeG76d
	YGR03B0cHCYYZtr8+3FgLYzUbFSCgcWyGWlP+tU1FKwru/ryOIm+F3go
X-Gm-Gg: AYBFou0PuccGc8iGBeUCsXR6JEDUap1OtSbHoDGJFyRO0RCDPbJC9Jj7Y8NsOXEfaGm
	BppNYtwutz3OwnhNNdCscrtr2ClMXQCJiEodRA7bEzLpXQ/A94BDjF2PsulMgbROlF00t3fJeXx
	GSE3EAT1PQDSThWZ2DT4jPTRTqyqUPRXmawldXfKX/2b4brr7SOJmc1gkdCcRAfz0tZSFvM8uJB
	ms5z8Jw5bfvlACmMGfOO4oHjq0AKVhL2xHS/70FULDE3zrBhMhVTSmLRZcz85lQtHdi3P5idEiI
	QS6V0XP9C2Nr4zoTEFeFb2Le4dTccWny8NgRxrsTrCM9oDTnOK6LVtS/pQ48CZLbK2OQwQKt9yb
	KttgSTiGvoMiIqkXi/uF7942mnjosjXPXYunHOATqqV4A/bXmwVvCd0uDMrsvrIcPWg4uUc3BuN
	axjhyfgPxNKW63i8f1xd53XLQh9jqzX77HeotHsoJPXNt6Oa0Qb8naccrP/AJEB+YrFomJpw==
X-Received: by 2002:a17:902:dac2:b0:2e4:adb3:c776 with SMTP id d9443c01a7336-2e842bc0a1fmr42948105ad.24.1791642234303;
        Sat, 10 Oct 2026 07:23:54 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:51 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/5] vsock/virtio: defer RX readable notifications until batch unlock
Date: Sat, 10 Oct 2026 22:22:47 +0800
Message-Id: <20261010142247.99223-6-physicalmtea@gmail.com>
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

An RX batch can make a socket readable while the worker still owns its
socket lock. Waking a reader at that point can make it immediately wait
for the same lock.

For the callback installed by sock_init_data(), record when the existing
low-watermark condition is met and issue one notification after the batch
releases the lock. Save the initial sock_def_readable() callback when the
AF_VSOCK socket is created because virtio_transport_common can be built as
a module and cannot refer to that unexported symbol directly.

When sk_data_ready or sk_write_space no longer matches that initial
callback, pass queued skbs to the current callback one skb at a time. The
handoff stops if the callback is the default again or the queue does not
shrink. After 64 successful callbacks, queue another bounded handoff if
data remains. vsock_bpf_update_proto() schedules the same handoff so an
attach or detach outside the worker still drains skbs already queued.

Always deliver a coalesced write-space event to the saved default callback
before sampling the callback state. A current replacement is invoked by
the handoff as well, so a callback change cannot hide the native writer
wakeup or pending sockmap work.

Sampling at batch finish takes sk_callback_lock once. The per-packet fast
path still uses READ_ONCE() and does not take that lock. Control packets,
state transitions, transport changes and non-batched sockets keep their
existing behavior.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |   1 +
 include/net/af_vsock.h                  |   8 +-
 net/vmw_vsock/af_vsock.c                | 103 ++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  73 ++++++++++++++---
 net/vmw_vsock/vsock_bpf.c               |   2 +
 5 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 3a58120d9078..21a3460b940f 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -291,6 +291,7 @@ struct virtio_transport_rx_batch {
 	struct sockaddr_vm src;
 	struct sockaddr_vm dst;
 	bool write_space_pending;
+	bool data_ready_pending;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9d8ae62209ed..86d6e6ba3d9d 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,8 +63,11 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
-	/* Initial callback, used to identify replacements. */
+	/* Initial callbacks, used to identify replacements. */
+	void (*default_data_ready)(struct sock *sk);
 	void (*default_write_space)(struct sock *sk);
+	struct delayed_work rx_cb_work;
+	bool rx_cb_retried;
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -80,6 +83,9 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
 s64 vsock_stream_has_space(struct vsock_sock *vsk);
 struct sock *vsock_create_connected(struct sock *parent);
 void vsock_data_ready(struct sock *sk);
+bool vsock_rx_cb_is_native(struct sock *sk);
+void vsock_rx_callback_kick(struct sock *sk);
+void vsock_rx_callback_handoff(struct sock *sk);
 
 /**** TRANSPORT ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index fe7f49da6c4b..df6faee0bd37 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -931,6 +931,107 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	return retval;
 }
 
+#define VSOCK_RX_CB_HANDOFF_MAX 64
+
+static void vsock_rx_callback_queue(struct sock *sk, unsigned long delay)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+
+	sock_hold(sk);
+	if (!schedule_delayed_work(&vsk->rx_cb_work, delay))
+		sock_put(sk);
+}
+
+void vsock_rx_callback_kick(struct sock *sk)
+{
+	vsock_rx_callback_queue(sk, 0);
+}
+
+/* Caller holds sk_callback_lock. */
+bool vsock_rx_cb_is_native(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+
+	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       READ_ONCE(sk->sk_data_ready) == vsk->default_data_ready &&
+	       READ_ONCE(sk->sk_write_space) == vsk->default_write_space;
+}
+EXPORT_SYMBOL_GPL(vsock_rx_cb_is_native);
+
+/* Caller holds lock_sock(). */
+void vsock_rx_callback_handoff(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	void (*write_space)(struct sock *sk);
+	void (*data_ready)(struct sock *sk);
+	bool wrote = false;
+	s64 before, after;
+	int i;
+
+	if (sock_flag(sk, SOCK_DEAD) || !vsk->transport)
+		return;
+
+	read_lock_bh(&sk->sk_callback_lock);
+	data_ready = READ_ONCE(sk->sk_data_ready);
+	if (READ_ONCE(sk->sk_prot) != sk->sk_prot_creator &&
+	    data_ready == vsk->default_data_ready) {
+		read_unlock_bh(&sk->sk_callback_lock);
+		/*
+		 * start_verdict publishes sk_data_ready after the proto swap.
+		 * Retry once before treating this as a stable non-RX setup.
+		 */
+		if (!vsk->rx_cb_retried) {
+			vsk->rx_cb_retried = true;
+			vsock_rx_callback_queue(sk, 1);
+			return;
+		}
+		vsk->rx_cb_retried = false;
+		data_ready(sk);
+		return;
+	}
+	read_unlock_bh(&sk->sk_callback_lock);
+	vsk->rx_cb_retried = false;
+
+	for (i = 0; i < VSOCK_RX_CB_HANDOFF_MAX; i++) {
+		read_lock_bh(&sk->sk_callback_lock);
+		data_ready = READ_ONCE(sk->sk_data_ready);
+		write_space = READ_ONCE(sk->sk_write_space);
+		read_unlock_bh(&sk->sk_callback_lock);
+
+		if (!wrote && write_space != vsk->default_write_space) {
+			write_space(sk);
+			wrote = true;
+		}
+		if (data_ready == vsk->default_data_ready) {
+			data_ready(sk);
+			break;
+		}
+		before = vsock_stream_has_data(vsk);
+		if (before <= 0)
+			break;
+		data_ready(sk);
+		after = vsock_stream_has_data(vsk);
+		if (after >= before)
+			break;
+		if (i == VSOCK_RX_CB_HANDOFF_MAX - 1 && after > 0)
+			vsock_rx_callback_queue(sk, 0);
+	}
+}
+EXPORT_SYMBOL_GPL(vsock_rx_callback_handoff);
+
+static void vsock_rx_callback_work(struct work_struct *work)
+{
+	struct vsock_sock *vsk = container_of(work, struct vsock_sock,
+					      rx_cb_work.work);
+	struct sock *sk = sk_vsock(vsk);
+
+	lock_sock(sk);
+	if (!sock_flag(sk, SOCK_DEAD))
+		vsock_rx_callback_handoff(sk);
+	release_sock(sk);
+	sock_put(sk);
+}
+
 static void vsock_connect_timeout(struct work_struct *work);
 
 static struct sock *__vsock_create(struct net *net,
@@ -958,6 +1059,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->default_data_ready = sk->sk_data_ready;
 	vsk->default_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
@@ -976,6 +1078,7 @@ static struct sock *__vsock_create(struct net *net,
 	WRITE_ONCE(vsk->peer_shutdown, 0);
 	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
 	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
+	INIT_DELAYED_WORK(&vsk->rx_cb_work, vsock_rx_callback_work);
 
 	psk = parent ? vsock_sk(parent) : NULL;
 	if (parent) {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f0398ae2200d..5499cd1d8a25 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1583,10 +1583,12 @@ out:
 
 static int
 virtio_transport_recv_connected(struct sock *sk,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				bool *data_ready_pending)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
+	void (*data_ready)(struct sock *sk);
 	int err = 0;
 
 	switch (le16_to_cpu(hdr->op)) {
@@ -1602,7 +1604,23 @@ virtio_transport_recv_connected(struct sock *sk,
 			vsock_remove_sock(vsk);
 			break;
 		}
-		vsock_data_ready(sk);
+		if (!data_ready_pending) {
+			vsock_data_ready(sk);
+		} else {
+			data_ready = READ_ONCE(sk->sk_data_ready);
+			if (data_ready == vsk->default_data_ready) {
+				if (!*data_ready_pending &&
+				    (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
+				     sock_flag(sk, SOCK_DONE)))
+					*data_ready_pending = true;
+			} else {
+				/* Use the callback seen for this packet. */
+				*data_ready_pending = false;
+				if (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
+				    sock_flag(sk, SOCK_DONE))
+					data_ready(sk);
+			}
+		}
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
 		virtio_transport_send_credit_update(vsk);
@@ -1836,6 +1854,7 @@ struct virtio_transport_rx_pkt_ctx {
 	const struct sockaddr_vm *dst;
 	bool *batchable;
 	struct virtio_transport_rx_batch *batch;
+	bool defer_data_ready;
 };
 
 static bool
@@ -1909,7 +1928,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
+		virtio_transport_recv_connected(sk, skb,
+						ctx->defer_data_ready && ctx->batch ?
+						&ctx->batch->data_ready_pending : NULL);
 		break;
 	case TCP_CLOSING:
 		virtio_transport_recv_disconnecting(sk, skb);
@@ -1978,33 +1999,45 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
  * Finish the RX batch.
  * For a non-empty batch, the caller must hold the socket lock acquired with
  * lock_sock(). This function releases the lock and the batch's lookup
- * reference.
- * An empty batch is a no-op.
+ * reference. An empty batch is a no-op.
  */
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
 	bool write_space_pending = batch->write_space_pending;
-	void (*write_space)(struct sock *sk);
+	bool data_ready_pending = batch->data_ready_pending;
 	struct sock *sk = batch->sk;
 	struct vsock_sock *vsk;
+	bool native;
 
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
 	batch->net = NULL;
 	batch->write_space_pending = false;
+	batch->data_ready_pending = false;
 
 	if (!sk)
 		return;
 
-	if (write_space_pending) {
-		vsk = vsock_sk(sk);
+	vsk = vsock_sk(sk);
+	if (write_space_pending)
 		vsk->default_write_space(sk);
-		write_space = READ_ONCE(sk->sk_write_space);
-		if (write_space != vsk->default_write_space)
-			write_space(sk);
+
+	read_lock_bh(&sk->sk_callback_lock);
+	native = vsock_rx_cb_is_native(sk);
+	read_unlock_bh(&sk->sk_callback_lock);
+
+	if (native) {
+		release_sock(sk);
+		if (data_ready_pending)
+			vsk->default_data_ready(sk);
+		sock_put(sk);
+		return;
 	}
 
+	if (write_space_pending || data_ready_pending)
+		vsock_rx_callback_handoff(sk);
+
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2015,9 +2048,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 				     struct virtio_transport_rx_batch *batch)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	bool batchable, defer_data_ready, start_batch;
 	struct virtio_transport_rx_pkt_ctx ctx;
 	struct sockaddr_vm src, dst;
-	bool batchable, start_batch;
 	struct sock *sk;
 	bool free_pkt;
 
@@ -2038,6 +2071,17 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		    vsock_addr_equals_addr(&batch->dst, &dst) &&
 		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
 			sk = batch->sk;
+			defer_data_ready = READ_ONCE(sk->sk_data_ready) ==
+					   vsock_sk(sk)->default_data_ready;
+			if (unlikely(batch->data_ready_pending && !defer_data_ready)) {
+				/*
+				 * BPF map updates can replace callbacks while lock_sock()
+				 * remains held. Finish the old notification first.
+				 */
+				virtio_transport_rx_batch_finish(batch);
+				goto lookup;
+			}
+
 			if (!skb_set_owner_sk_safe(skb, sk)) {
 				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
 				virtio_transport_rx_batch_finish(batch);
@@ -2051,6 +2095,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 				.dst = &dst,
 				.batchable = &batchable,
 				.batch = batch,
+				.defer_data_ready = defer_data_ready,
 			};
 			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 
@@ -2064,6 +2109,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		virtio_transport_rx_batch_finish(batch);
 	}
 
+lookup:
 	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
 	if (!sk) {
 		virtio_transport_rx_batch_finish(batch);
@@ -2089,6 +2135,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 	if (start_batch)
 		batch->sk = sk;
+	defer_data_ready = start_batch &&
+		READ_ONCE(sk->sk_data_ready) == vsock_sk(sk)->default_data_ready;
 
 	ctx = (struct virtio_transport_rx_pkt_ctx) {
 		.net = net,
@@ -2096,6 +2144,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		.dst = &dst,
 		.batchable = start_batch ? &batchable : NULL,
 		.batch = start_batch ? batch : NULL,
+		.defer_data_ready = defer_data_ready,
 	};
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	if (start_batch && batchable) {
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..7770a6c51dbe 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -154,6 +154,7 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
 	if (restore) {
 		sk->sk_write_space = psock->saved_write_space;
 		sock_replace_proto(sk, psock->sk_proto);
+		vsock_rx_callback_kick(sk);
 		return 0;
 	}
 
@@ -166,6 +167,7 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
 
 	vsock_bpf_check_needs_rebuild(psock->sk_proto);
 	sock_replace_proto(sk, &vsock_bpf_prot);
+	vsock_rx_callback_kick(sk);
 	return 0;
 }
 
-- 
2.34.1

