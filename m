Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0E4B53E4
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873110; cv=none; b=HtGrC0/Xf2gTbFdLxpPiiUx4N/+WJus8B9XLHAMsNGUGNwA1ccbWwVTAHzhbV5ndVd1DdkbRmDnuiJ+0bmDJ2KFWSlDyd7bGPu3RbafZu+9AjvAG0wxWcsYgFbx8W05yQZc7pkvzh9YfojTh7UYIA5QlrpIZ39x8Iw2XVjbu6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873110; c=relaxed/simple;
	bh=iZKwrleWYnxmSV3fQDb8fxjnh60Iqkpz4jyqzrq8Ing=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5pqnVJBHvV0osc1H3kq460+SXQPKf+1xZZhCs4u2gbHxe4pL9Ullfu+MDtzqJSxfoNFTsFJC7HsMqK1LkRjuukzwDnubTestz9dtcCQ/uIqspuq0l1nQK8MyoG5cW2Zln1ZD5Nare1sESwRZjej2zrZIqCQtQT+PAhbFPJs2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cuy3HQW0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cuy3HQW0"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab2bf5e75bso1324122a91.3
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 23:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791873108; x=1792477908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TG/YKhFmp6a/F5Dziq4QBpGFNwwdmaOR4TRo9UNV5sk=;
        b=Cuy3HQW09+CAHJ61Hu6IaW4yc5IocnQRd+xQtKFx/vZP69PX0EYhqXKojeu23+Mdru
         T3tWOg4nIsu0zB0e5ZTpMfrsYAhUAxELaN9fzGrXjLb1xRBFTW/q6h1uOW9k7yHJnbBN
         Wiq6I7bAzyBG8v2LnUsB9kkcPxc1brS+Qka1CvnCS7K+Ts6xbxcePTPzfTi048y5EriS
         UWT0jpSZO60nsLuceZFNLG6vZNp1oX9E5pe/9N41wUrkjEou8RpLnCQpzewqtRaSX2y4
         Fl1Z1td8aGmxTfQF7fhqNdY6q5OyB8/BWbgi8pguxQBnHNCUJZ3c7pI6TIrIqhGhSPau
         5ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791873108; x=1792477908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TG/YKhFmp6a/F5Dziq4QBpGFNwwdmaOR4TRo9UNV5sk=;
        b=2ZIG8qzwctdvP59n1/CLF+fC+qzmr7gTwLVV2ECvs87jWvn1jOBJsFzWL1FXko0e2C
         DM8z/ds63r0GDrfHWExjT0wInIRXW2k6FY8gvZXCO6MFhFs0VmU1u+DVRdgSZeFzetDA
         Y+mwS5GRtSBd4+hgNr8XUtE0NeTxkEZfVBaqaC62Mkrin6fl1Ikmv3Ill4qS5JPT2a6f
         /UwqKiaLwnmEcTxgtqE8Si1RvC/xEY0+qgaIZKI5E5Ox+kuD95XE0VTCbo+sOkayqlPs
         stIhUCu11s5ZNQqdYGoWW2acJ8dbFC+IWJv4fcr4D+P+RZOm9evSZHFIuSuHcHukoiO8
         ZFKA==
X-Forwarded-Encrypted: i=1; AKwUvBx5wGcXYAfcBmnKsmp90/HRTQcm7cwuNva3caVPibCwWb5Y1zcsWCo+8kvC0xFQPs7tzcLKbPFGO3xqzdx3Bg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIIYRnbr8gDH1LVOnmW+kAEar2G+lWFOP5cU8KDO2OP24jfg9al
	80ZXIDqbMHZ9E6bMlqabe4GgCykqHOG1dSazVllj6Fv75kzMMa0CyJ1E
X-Gm-Gg: AYBFou04nPBlUZ4DXdFdVuw+qt2BQdyVqjgHVm0RGhcgmSXd55RWJtYAynN1yXzGhKf
	5WOqFxn92SE1Jy+4X2zvC9fOVUjWlldrtd/XPi1h/zJvCZhchPSfsdZd/73VJlpqzQjOBUrPZQd
	kJUXc6NObutvXx9FZ1ef1VSzFGEHoFmnY4+X6uq6Oz8BRu2G9yqadACY/ZyyZ21DDdflHuCGhxN
	ZB6h1P1Gfu/ZKozLUReLpndQdEGEXOlIFMgTe4pp1yiXVzh4ZbS+h9gAGX/PuL7Qdg96faahmWs
	Z5stK939HAwZIYQdIxAJ0SIkkDQsQcdFQ08wQuTJJWnjbAQGc+3SU/5UFsK2uhyTgp9KeIij12m
	ja0tnUbtbaXFgQGmOwrEsqOF+26c3f9o6hFFZIh8dpGIeyZWPAC6xLW3E73uH1Qi+5t6ARgICzm
	Pnx/jUy660h6aVLSAKiVRSA7irBc9cInccLH1eVKps/FGWzQlfQDhZfv+JKoRAwDwaiur0sA==
X-Received: by 2002:a17:90b:570f:b0:3a7:da33:ff2d with SMTP id 98e67ed59e1d1-3ab3ac5e4damr8957176a91.48.1791873107274;
        Mon, 12 Oct 2026 23:31:47 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b9633fsm24550706a91.6.2026.10.12.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:31:46 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/4] vsock/virtio: amortize RX socket locking for stream packets
Date: Tue, 13 Oct 2026 14:31:10 +0800
Message-Id: <20261013063112.168321-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013063112.168321-1-physicalmtea@gmail.com>
References: <20261013063112.168321-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio-vsock RX worker currently acquires and releases the socket lock
and looks up the socket for every received packet. Keep the lock and lookup
reference across a bounded run of packets that belongs to the same socket.

Only ordinary RW packets for an established STREAM socket whose transport
and protocol remain unchanged are eligible. Control packets, SEQPACKET
traffic, state or transport changes, malformed packets, and sockets whose
protocol has been replaced end the active batch and retain their existing
handling.

A psock is published in sk_user_data before sockmap replaces the protocol
or callbacks. Exclude sockets carrying that marker from batching, and check
it again at every packet boundary. Thus an attach racing an active native
batch makes the next packet end the batch without changing the sockmap
update result.

Serialize the initial eligibility check with sk_callback_lock because
sockmap removal restores the protocol and callbacks without taking the
socket lock.

Limit each batch to 64 packets or 64KB of payload. The packet limit bounds
per-packet work for small payloads, while the byte limit bounds how much
data can queue before a reader can acquire the socket lock.

For later STREAM/RW packets, match the packet against the locked socket
state and reuse the batch socket for the same flow. Release the batch
before looking up a different flow. The cached path still traces every
packet, takes an skb owner reference, validates the source and transport,
updates credit, and runs the receive state machine.

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
 net/vmw_vsock/virtio_transport.c        |  29 +++-
 net/vmw_vsock/virtio_transport_common.c | 170 +++++++++++++++++++++++-
 3 files changed, 203 insertions(+), 7 deletions(-)

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
index 8a930bc42fdc3..bfe40ecf0b2f0 100644
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
@@ -1798,19 +1803,47 @@ virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
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
 				 struct sk_buff *skb, struct sock *sk,
 				 const struct sockaddr_vm *src,
 				 const struct sockaddr_vm *dst,
-				 struct net *net)
+				 struct net *net, bool *batchable)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 	bool space_available;
 
+	if (batchable)
+		*batchable = false;
+
 	/* Listener sockets accept packets from any source and are not assigned to
 	 * a transport.
 	 */
@@ -1852,6 +1885,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		break;
 	}
 
+	if (batchable)
+		*batchable = virtio_transport_recv_pkt_batchable(t, sk);
+
 	return false;
 }
 
@@ -1893,7 +1929,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &src, &dst,
-						    net);
+						    net, NULL);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
@@ -1909,6 +1945,128 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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
+	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
+					dst.svm_cid, dst.svm_port,
+					le32_to_cpu(hdr->len),
+					le16_to_cpu(hdr->type),
+					le16_to_cpu(hdr->op),
+					le32_to_cpu(hdr->flags),
+					le32_to_cpu(hdr->buf_alloc),
+					le32_to_cpu(hdr->fwd_cnt));
+
+	if (batch->sk) {
+		vsk = vsock_sk(batch->sk);
+		if (vsock_addr_equals_addr(&src, &vsk->remote_addr) &&
+		    dst.svm_port == vsk->local_addr.svm_port &&
+		    vsock_net_check_mode(sock_net(batch->sk), net) &&
+		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
+			sk = batch->sk;
+			if (!skb_set_owner_sk_safe(skb, sk)) {
+				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+				virtio_transport_rx_batch_finish(batch);
+				kfree_skb(skb);
+				return;
+			}
+
+			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
+								    &src, &dst,
+								    net,
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
+	sk = virtio_transport_find_socket(skb, &src, &dst, net);
+	if (!sk) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		return;
+	}
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
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &src, &dst,
+						    net,
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

