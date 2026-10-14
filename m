Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782B4EC67F
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979029; cv=none; b=oCmHOETqxyBv3tFCdkxX+bVDFCnzjXwGvTlDmm48J4NrEAurqzjMLcW+kx4DdZbs/YpJ2/x6iG11kkoTmstn8NREkIWXN6p71hB6jTAWDfq7qCNsR0fj5ZKfEb7MiKSf6H7Ol6FZIBxPcinzDN+dZd9KZUF4IROOdFsSbpWmgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979029; c=relaxed/simple;
	bh=FRQnbsHgTDXcs2PaL0f/esesvvlx53r+cQEFvCkyO0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUlmUEHnOQXEURWjUx9S07jYFQEObcmSDFWj1JMJK+VZshnZMJo28d/1hZq5Dvser2zgdNW5loXZkwKEStMaWi16/R6R19PD2ImuBbQQKlK0hYG0cwjN/RYeGpQXWytJjTwCRvSpVM50PJvkRxmxYFlAo6rWUlgP+hQCZ9fvtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbKLqxqK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbKLqxqK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so3316711a91.0
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791979027; x=1792583827; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+CgE4PAybMaE82beuKefalgA3NgE1MsAQaFsyVRQuE=;
        b=NbKLqxqKuxW5prpyZACXt6uslcGhnLXQLhHCPqLXuGWrfCvFNtDeuJdNpGiCTIcX7C
         Gdo4Z4yBrDELFMnFqfbss8UnUDReKL2nQz4T3RuGZr7LvUYDcKHn5mv9dyTJNvJc/kRw
         hBwDwktRZ6dpbA8uXsbdrVlhvBBR///gZW6RiiP/OFAO6ezSyJT7aavuFJki+sDUlCmg
         Eo8SwYZi1s+Sx7fwAumCJ6DsWGG1jb+UZc7MHi2hzclHCteuymye/1mzYQxzM9x3Astl
         x8ATgdldu84zXy1lKQBy72uA9I68HC2s8LF1K4VZmMZ+hSEc2ctLZIaBtJKXa9uoJQ/f
         RCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979027; x=1792583827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8+CgE4PAybMaE82beuKefalgA3NgE1MsAQaFsyVRQuE=;
        b=bEFfjl62nuPGzH7vTRI0896JVtC1n/Lym7dHRyrYk5fzGoplN9TjXxmSTc3DACBrDF
         12Sj0WFGVRIzlQ79Puny9I9CNI0BBmkOYcd9E/ghMcI0MWpTx0bxKtAHzs9grGIkIkU6
         K9V9QfJI3Kp0WT1cYHVEUmH0tsH3+GNvxx+Ow9d8TXNa5L491LzvlrgSdExBYsDBzV+a
         dm7hvfi+qWkfFuPM0QFwtjXEErRJc6zqp54p1fKxQGvrpjFC6GAa+p7FYIpd6OIB6p2S
         pjJzRVIfu+3F4j19NQTYWK8kDrPT7g5JKjzvYx7P8wYpaO0JEN/yqpliVlqMY0+beD1v
         zfkA==
X-Forwarded-Encrypted: i=1; AKwUvByhs1HCxiWN2vUh0OVRhqGWvWVDeiFzPKwJtLkze7GBGWfDbCRHKEdzd9n/N6ewvXFUFysMXAl9jMwhLTvByQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYL0K69mwSgJt973dUv29hSJmD521CqXleWsn+b3TyX5ZHFgmX/d
	H0kFHEh61W2SoYDFuvML7mcNKi6xSWgG7BkFM1UFA9PlVWFmX+dvkL+g
X-Gm-Gg: AYBFou2UPi7t00PwaW6q1h6qBAB95uEy+/UvC2zlkpWPBnS41FoOJw0Uhk/L7wq/nNZ
	/zul2YapZq9i7njHy5lORxQ6xqFOMhz9fP2fk2xppZ2Cb4BkXuvepo7HDpB3H+Wg/iSxcI5vwF0
	OmFxIuiFwJM9/6rJ2BWao3y1lHa5bvIV1M2JXxmHOV7Qd9JUW8Hvx+ybyz5mchZlPCC0Fwt9AO7
	y6x/GGCQmSz0HHZRvDg47XiD9lT/b6d6JcyvE7fuiYbJAA8W5cKGUjiPN0VPoQqMOJfyljagXtU
	JWIzMSU2O19VRhAfX1d2xNOnwSL2xyT7VWMER5Hl0aA8Ft297xMuu6op5zaFYSbK3sRS39Ja0Aw
	a2jfxl9AvCib8yFyDgTdITOjd5K5xL0tkYqL+CVkCWF0jIowZpbFBAbGyF32Qm1WujH0wLbsFq5
	diHoK3NYcm5BQPvq2V3S2FfWJiUbDsqKWzk2hGZfMzEUOOfdJQTEj59bKplMW2Cu3Sqb2dCQ==
X-Received: by 2002:a17:90a:e7cb:b0:3aa:f2c4:12f4 with SMTP id 98e67ed59e1d1-3ab3a95369emr15188850a91.31.1791979026832;
        Wed, 14 Oct 2026 04:57:06 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24b74csm4795691a91.7.2026.10.14.04.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:57:06 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/4] vsock/virtio: amortize RX socket locking for stream packets
Date: Wed, 14 Oct 2026 19:56:38 +0800
Message-Id: <20261014115640.184286-3-physicalmtea@gmail.com>
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

The virtio-vsock RX worker currently looks up the socket and takes its
lock for every packet. Keep the socket lock and lookup reference across a
bounded run of STREAM/RW packets for the same established socket.

Reuse the locked socket while packets continue to match the same flow.
End the batch for a different flow, non-RW traffic, malformed packets, or
a change in socket state, transport, protocol, or receive-buffer headroom.
A connected-table miss uses the existing receive path.

The reused path still traces every packet, takes an skb owner reference,
validates the source and transport, updates credit, and runs the existing
receive state machine.

Sockmap can replace the protocol without taking the socket lock. Check the
psock marker at each packet boundary and serialize initial admission with
sk_callback_lock, so a concurrent attach ends batching at the next packet.

Cap a batch at 64 packets and 64K of payload. The packet limit bounds
per-packet work, while the byte limit bounds how much data can queue before
a reader acquires the socket lock. Batching remains in the process-context
RX worker.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  11 ++
 net/vmw_vsock/virtio_transport.c        |  29 +++-
 net/vmw_vsock/virtio_transport_common.c | 183 +++++++++++++++++++++++-
 3 files changed, 216 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057e..26dde6909c4ed 100644
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
index 4f9aa9c4c3aa5..ef076732158d4 100644
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
index 61ee3bc205d5d..ff74e805527a5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -576,11 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
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
-
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
 	 * metadata. Check payload against buf_alloc to be sure the other
@@ -588,7 +593,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 	 * queue growth.
 	 */
 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
-	    skb_overhead > vvs->buf_alloc)
+	    !virtio_transport_rx_skb_has_headroom(vvs))
 		return false;
 
 	vvs->rx_bytes += len;
@@ -1798,12 +1803,38 @@ virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
 	return sk;
 }
 
+static bool
+virtio_transport_sock_has_psock(const struct sock *sk)
+{
+	return (uintptr_t)rcu_access_pointer(__sk_user_data(sk)) &
+	       SK_USER_DATA_PSOCK;
+}
+
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
+	       vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
+	       !virtio_transport_sock_has_psock(sk);
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
-				 struct sk_buff *skb, struct sock *sk)
+				 struct sk_buff *skb, struct sock *sk,
+				 bool *batchable)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src;
@@ -1813,6 +1844,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
 
+	if (batchable)
+		*batchable = false;
+
 	/* Listener sockets accept packets from any source and are not assigned to
 	 * a transport.
 	 */
@@ -1854,6 +1888,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		break;
 	}
 
+	if (batchable)
+		*batchable = virtio_transport_recv_pkt_batchable(t, sk);
+
 	return false;
 }
 
@@ -1894,7 +1931,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	}
 
 	lock_sock(sk);
-	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
@@ -1910,6 +1947,140 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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
+	struct sockaddr_vm src, dst;
+	struct vsock_sock *vsk;
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
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+			le32_to_cpu(hdr->dst_port));
+
+	if (batch->sk) {
+		vsk = vsock_sk(batch->sk);
+		if (vsock_addr_equals_addr(&src, &vsk->remote_addr) &&
+		    dst.svm_port == vsk->local_addr.svm_port &&
+		    vsock_net_check_mode(sock_net(batch->sk), net) &&
+		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
+			sk = batch->sk;
+			trace_virtio_transport_recv_pkt(src.svm_cid,
+							src.svm_port,
+							dst.svm_cid,
+							dst.svm_port,
+							le32_to_cpu(hdr->len),
+							le16_to_cpu(hdr->type),
+							le16_to_cpu(hdr->op),
+							le32_to_cpu(hdr->flags),
+							le32_to_cpu(hdr->buf_alloc),
+							le32_to_cpu(hdr->fwd_cnt));
+			if (!skb_set_owner_sk_safe(skb, sk)) {
+				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+				virtio_transport_rx_batch_finish(batch);
+				kfree_skb(skb);
+				return;
+			}
+
+			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
+								    &batchable);
+			if (!batchable)
+				virtio_transport_rx_batch_finish(batch);
+			if (free_pkt)
+				kfree_skb(skb);
+			return;
+		}
+
+		virtio_transport_rx_batch_finish(batch);
+	}
+
+	sk = vsock_find_connected_socket_net(&src, &dst, net);
+	if (!sk) {
+		virtio_transport_recv_pkt(t, skb, net);
+		return;
+	}
+
+	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
+		sock_put(sk);
+		virtio_transport_recv_pkt(t, skb, net);
+		return;
+	}
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
+	if (!skb_set_owner_sk_safe(skb, sk)) {
+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+		kfree_skb(skb);
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
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
+						    start_batch ? &batchable : NULL);
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
2.53.0

