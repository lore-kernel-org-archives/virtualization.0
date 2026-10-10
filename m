Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9E3B388B
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642215; cv=none; b=V4SZ4Zal9/cYO3RXAP6C17iM3hlb/brbVKMlPBrHxfN5cLLN0YmDvwFHBCr8+8n6qhAX2bIdjzJqmxgAzqJ447GbS9bavdmrYjt0bIUurwRVFpKwmvt++eKKUnHdtq6meGx7C0M0ddkUoiAwZG5RByLn+5dMvycCK2niMJRcRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642215; c=relaxed/simple;
	bh=daqZc+QyaWQpFjyMP2c+tmz35bLN8UT1WQTyLRhtQEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6b8h0w5MgElA+qro7F7JzpFqHnIhp+rlR63MXS91EVCgORBByxkpGGGIpVdL2RlMdm8bviGqa5DKJDTidOyFXNMaS5CoxVm+XpSBhAuI7EPkZoljkHn8xxdjoO2kEll4K2R6d68OGM6CvDpPv1Qs3CRPsWPdn/hFL0ZJRBw3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnjUEr5/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnjUEr5/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e86dce4510so2731395ad.3
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642214; x=1792247014; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4KNUSu3bS7q4mwIXpQDiAcx7RZBKZD3bVskoMbRLE1w=;
        b=TnjUEr5/2bO0QN1sAMTHMp1JTaBglUDtuXq2WTyv/xtkROEoRnc3+7G2dkXPPanSar
         +wfUNZQFhCoriUzIFiQcSaaeVJ0weHBxztVAbFCP0S/ftDVcQ3+U1b+xT2vTiPxoXx3Y
         1eJXvs8F7qiP80XyXksQ16JVpVXHqSEWzycwsddL9yuy0O80MdawF/cKnTx365ippIVl
         pV6OlRSxEKwjZex1adwczlmwgsnk6K66+NH5svXFh2xTwhkiIAXResmxT4szUVf8A16J
         u2vtUH/OoTp8s9hbLhX988kKvsrRQcKK3d+JXLinfLr3VS72bzAOfkLDh+bDwe0wydRt
         G8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642214; x=1792247014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4KNUSu3bS7q4mwIXpQDiAcx7RZBKZD3bVskoMbRLE1w=;
        b=yotadMNh61E0ku9TF+0n54TE4TmLHecydFyXiFDVxKjm0rbWVRZu2BMLebCgS0PSv7
         7f3/pc/DyNvQx/+FGl7xTfsQjV792TmlJJyVaC7VIRuY7xBfU9YFvJZmjrImh3rmk/Jo
         geMfwT4VJMJSwpLEDBIkhI92j1KMztzW9B3JJse/Cxn1r5exbqDQoCoDu6NGBaZgwcan
         u9PpvgDysxWxqw3lGWwYS7I33dJYv59qDH9Y6sUYay2cth+IjQT++aZtpOklwsQF8Ha+
         wz+2m7mh9wEmwgLt/7Ed7WklzXHakZjyAHztU4oZpsNKi2OowmqZOzm5HUw/6FvFxkQ0
         2kTw==
X-Forwarded-Encrypted: i=1; AKwUvBxFkxA/dT4fGvQRvIi/ete4t+OEQbU4IDaYwBTsoXaKSnuGbriXcd7+UoVn1DKfhmCMZOIOObzDjCqaJLoqOg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKBnZ9+MUDxpxDLazGZSNrdF+p9a2tqtdhmi3nxCbreAPJuVBpA
	c9fq8THR2bQm3X35I0f3tTrOeL/ty5CFV+4AEgECVT7gPWt+ect9v8UD
X-Gm-Gg: AYBFou1JWwUNHvZTP7atCXLOspLEG+JHjPMnWMEDYtSJ+Fh6CHMf55LSbL7VZtiF3j6
	DAsDTi4aa8HUGA6Z+Vp3i0UXzzQ8zjDLyfHaqqRmYpTn4BB9X6zwpqam3eeHrXNdpHfDy/flL1D
	+zCgZkVrqMX8MvACCeI+etxY1TAXAw3pzl0XeZSKyhbvknmuYH/HKj/h7W4+KbzWLJEqfk6ZUE8
	dcmtjiydPc6lytcEY0uPNxukqWO5b9raH1UysX19OckIet2pu4lU6+Yc0wq97sj4o0BI7Ox2fAA
	NU8fiUlKFRRNauLOa2UquDT+3c7XtuWFnV/4FiUOv/HvjvFraTJ61NGI2GBWWp3vc0ZsUhQnPGn
	nuKO4oqzHK2Nwi6+QjF25Vw9yycCh4BiMZMbAQnZaX2308PN5WQuFqks+6GuGxxCxWFi0BqMHox
	ZSFrM6nttDQlz9P1IuwYzf8g1Ne7FctfDeT/M+r8aODfM4NwOvL9T6CYJywZC9FgXeeY2LUQ==
X-Received: by 2002:a17:902:e811:b0:2dd:ad73:c988 with SMTP id d9443c01a7336-2e842bc7f91mr38765655ad.32.1791642213379;
        Sat, 10 Oct 2026 07:23:33 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:33 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] vsock/virtio: amortize RX socket locking for stream packets
Date: Sat, 10 Oct 2026 22:22:44 +0800
Message-Id: <20261010142247.99223-3-physicalmtea@gmail.com>
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

The virtio-vsock RX worker currently acquires and releases the socket lock
for every received packet. Keep the lock held while processing a bounded
run of packets that belongs to the same socket.

Only ordinary RW packets for an established STREAM socket whose transport
and protocol remain unchanged are eligible. Control packets, SEQPACKET
traffic, state or transport changes, malformed packets, and sockets whose
protocol has been replaced end the active batch and retain their existing
handling.

Serialize the initial eligibility check with sk_callback_lock because
sockmap removal restores the protocol without taking the socket lock.

Limit each batch to 64 packets or 64KB of payload, bounding the work under
one socket lock. Keep the lookup reference until the batch finishes.

Keep a batch only while another skb metadata charge fits in the receive
buffer. Share this predicate with virtio_transport_inc_rx_pkt(). When an
enqueued skb consumes the final metadata slot, finish the batch and release
the socket lock before processing another packet, restoring the reader's
scheduling opportunity from the per-packet path.

The virtqueue callback remains a queue_work() callback. Batching runs only
in the process-context RX worker.

Introduce virtio_transport_rx_batch_finish() to tear down the batch and
release the socket lock and lookup reference.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  11 ++
 net/vmw_vsock/virtio_transport.c        |  29 ++++-
 net/vmw_vsock/virtio_transport_common.c | 147 +++++++++++++++++++++++-
 3 files changed, 183 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..26dde6909c4e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -282,6 +282,17 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
 
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb, struct net *net);
+
+struct virtio_transport_rx_batch {
+	struct sock *sk;
+	unsigned int pkts;
+	size_t bytes;
+};
+
+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
+				     struct sk_buff *skb, struct net *net,
+				     struct virtio_transport_rx_batch *batch);
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..ef076732158d 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	return seqpacket_allow;
 }
 
+/*
+ * Keep a bounded run of packets for one socket under a single socket lock.
+ * Limit packet count and payload size to bound the work done while locked.
+ */
+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS	64
+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES	(64 * 1024)
+
 static void virtio_transport_rx_work(struct work_struct *work)
 {
+	struct virtio_transport_rx_batch batch = {};
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
@@ -666,6 +674,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			/* Drop short/long packets */
 			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
+				virtio_transport_rx_batch_finish(&batch);
 				kfree_skb(skb);
 				continue;
 			}
@@ -673,6 +682,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			hdr = virtio_vsock_hdr(skb);
 			payload_len = le32_to_cpu(hdr->len);
 			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				virtio_transport_rx_batch_finish(&batch);
 				kfree_skb(skb);
 				continue;
 			}
@@ -680,16 +690,33 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
+			if (batch.sk &&
+			    payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
+					  batch.bytes) {
+				virtio_transport_rx_batch_finish(&batch);
+			}
+
 			virtio_transport_deliver_tap_pkt(skb);
 
 			/* Force virtio-transport into global mode since it
 			 * does not yet support local-mode namespacing.
 			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
+							&batch);
+
+			if (batch.sk) {
+				batch.pkts++;
+				batch.bytes += payload_len;
+				if (batch.pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
+				    batch.bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
+					virtio_transport_rx_batch_finish(&batch);
+				}
+			}
 		}
 	} while (!virtqueue_enable_cb(vq));
 
 out:
+	virtio_transport_rx_batch_finish(&batch);
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e3e75e59896f..a73e37b3fa62 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -576,10 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
 	skb_queue_splice(&new_queue, &vvs->rx_queue);
 }
 
+static bool
+virtio_transport_rx_skb_has_headroom(struct virtio_vsock_sock *vvs)
+{
+	return (u64)(skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0) <=
+		vvs->buf_alloc;
+}
+
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 	 * queue growth.
 	 */
 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
-	    skb_overhead > vvs->buf_alloc)
+	    !virtio_transport_rx_skb_has_headroom(vvs))
 		return false;
 
 	vvs->rx_bytes += len;
@@ -1834,10 +1840,28 @@ struct virtio_transport_rx_pkt_ctx {
 	struct net *net;
 	const struct sockaddr_vm *src;
 	const struct sockaddr_vm *dst;
+	bool *batchable;
 };
 
+static bool
+virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
+				    struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	struct virtio_vsock_sock *vvs = vsk->trans;
+
+	return sk->sk_state == TCP_ESTABLISHED &&
+	       sk->sk_type == SOCK_STREAM &&
+	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       !sock_flag(sk, SOCK_DONE) &&
+	       vsk->transport == &t->transport &&
+	       vvs && virtio_transport_rx_skb_has_headroom(vvs);
+}
+
 /*
- * The caller holds sk's socket lock and must free skb if this returns true.
+ * The caller holds sk's socket lock.  Set @batchable if the socket can remain
+ * locked for another ordinary STREAM/RW packet.  Return true if the caller
+ * must free @skb.
  */
 static bool
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
@@ -1850,6 +1874,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	struct net *net = ctx->net;
 	bool space_available;
 
+	if (ctx->batchable)
+		*ctx->batchable = false;
+
 	/* Check after acquiring the socket lock. Listener sockets accept packets
 	 * from any source and are not assigned to a transport.
 	 */
@@ -1891,6 +1918,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		break;
 	}
 
+	if (ctx->batchable)
+		*ctx->batchable = virtio_transport_recv_pkt_batchable(t, sk);
+
 	return false;
 }
 
@@ -1941,6 +1971,117 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
+/*
+ * Finish the RX batch.
+ * For a non-empty batch, the caller must hold the socket lock acquired with
+ * lock_sock(). This function releases the lock and the batch's lookup
+ * reference.
+ * An empty batch is a no-op.
+ */
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
+{
+	struct sock *sk = batch->sk;
+
+	batch->sk = NULL;
+	batch->pkts = 0;
+	batch->bytes = 0;
+
+	if (!sk)
+		return;
+
+	release_sock(sk);
+	sock_put(sk);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
+
+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
+				     struct sk_buff *skb, struct net *net,
+				     struct virtio_transport_rx_batch *batch)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct virtio_transport_rx_pkt_ctx ctx;
+	struct sockaddr_vm src, dst;
+	bool batchable, start_batch;
+	struct sock *sk;
+	bool free_pkt;
+
+	/* Only STREAM/RW packets can share a socket lock. */
+	if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
+	    le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
+		virtio_transport_rx_batch_finish(batch);
+		virtio_transport_recv_pkt(t, skb, net);
+		return;
+	}
+
+	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
+	virtio_transport_trace_recv_pkt(skb, &src, &dst);
+
+	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
+	if (!sk) {
+		virtio_transport_rx_batch_finish(batch);
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		return;
+	}
+
+	if (!skb_set_owner_sk_safe(skb, sk)) {
+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+		virtio_transport_rx_batch_finish(batch);
+		kfree_skb(skb);
+		return;
+	}
+
+	if (batch->sk && batch->sk != sk) {
+		/* Never acquire a second socket lock. */
+		virtio_transport_rx_batch_finish(batch);
+	}
+
+	if (batch->sk == sk) {
+		/* Keep the batch reference; drop this packet's lookup reference. */
+		sock_put(sk);
+		ctx = (struct virtio_transport_rx_pkt_ctx) {
+			.net = net,
+			.src = &src,
+			.dst = &dst,
+			.batchable = &batchable,
+		};
+		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
+		if (!batchable)
+			virtio_transport_rx_batch_finish(batch);
+		if (free_pkt)
+			kfree_skb(skb);
+		return;
+	}
+
+	lock_sock(sk);
+	/*
+	 * Sockmap removal restores the native protocol under sk_callback_lock.
+	 * Serialize this initial eligibility check with that update.
+	 */
+	read_lock_bh(&sk->sk_callback_lock);
+	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
+	read_unlock_bh(&sk->sk_callback_lock);
+
+	ctx = (struct virtio_transport_rx_pkt_ctx) {
+		.net = net,
+		.src = &src,
+		.dst = &dst,
+		.batchable = start_batch ? &batchable : NULL,
+	};
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
+	if (start_batch && batchable) {
+		/* Keep the lookup reference until the batch is released. */
+		batch->sk = sk;
+		return;
+	}
+
+	release_sock(sk);
+	sock_put(sk);
+	if (free_pkt)
+		kfree_skb(skb);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
+
 /* Remove skbs found in a queue that have a vsk that matches.
  *
  * Each skb is freed.
-- 
2.34.1
