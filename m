Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5EB443E54
	for <virtualization@lists.linux.dev>; Fri,  2 Oct 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927199; cv=none; b=rczYRHDpBK0A0xBFGKvFibSgADIf7GukWIOht7TTH77JkG9Hxptjg+CQg6gA8c/tp1tIq089EoAh1wXccDLLG98AAiiIjIvmqsu5rLR82VU756s+tpgudcXG/7OrmeA6qc/+68YIl2mhz5grPeUuWtNGrFIUKJ61bgvIP7HIkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927199; c=relaxed/simple;
	bh=eikqDR0Snfqz/3M2HAE23sqiwnjVAjJ9CGW+w3WQUWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSDKm4+vpA5jOvFBpThP/QOEOZomHJp/jQDVkhv6FBXUeSqKcZnVM1h7RijUb+KdmZgAnCgXFitP4GgW3JqRIVUzvSxdi2Na+8Kk2QoCqs50FuxTGsk0T45tIXmCeL/MYApnzPXgfAQnK9qWHE7Cf5Z/wbIjCBtDTTmWm4kuS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDuCIiws; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDuCIiws"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso8371969eec.0
        for <virtualization@lists.linux.dev>; Fri, 02 Oct 2026 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790927197; x=1791531997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zH87u2UQrj815Ks5u5yG9mdoBjsylb8a7Q85tRZwVE4=;
        b=DDuCIiwsKyen5NNXvDU1TZPEx1wdi8R1kOcmqDrWT5aVlRgUlHFL0bp8yEN/qwO1N0
         t3Xh9FBV6PqQ2ggfl5Xt7Dgj2ceAeUI2L8qE/gLgGCWBErqvpuJb/RzT3OfjpexxYKDS
         tNwXxDZIclJVcE8E58rcVRjCqWMpUegyKkq+o8ZNY1udSRELoW8dbtZPZ4rYLewhF1Sq
         vcGxG5R1+FVWCORdKQ/sjJ3jcjL30hck4Ogphg2BluDsY1ZSe+HpybiSNxrtI0FXXruO
         UfhrzFZS//8xK+tRtE05usLTiH8GWPS+++GgjJiAgt6FZiEv1/6PPsba79UQiJG2mSTb
         /gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927197; x=1791531997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zH87u2UQrj815Ks5u5yG9mdoBjsylb8a7Q85tRZwVE4=;
        b=RA/N2b/GSz8Ubu4k83MU8SaHeMW3UbHYpsAkSxs6KbBvabgXXqb9XhbszsCzgzYkrr
         MDB7NfaDnJM/s6iKhXrbV9P/HZ5yIn9Os9BJEN90r3tJYn+mEiB1zgfr59j75BbmPKTI
         kYFh15WWIphVHriezBKEomr5LZiAOBGeg9x/a0eSocOvP66fXCPWN1typWDm7kQuSnoB
         ci12LSkHvZ0RTq+01GEIXcuy44XZAanK9tqmplYSVtQH/Cn42F/LMctuHLOpMH4fhb6d
         ZfWSv38YyffNyZSbWEPNAQJzo/JdcYqgmvI+iYqlFYJcxvCDm/QLC4ljEFfmEhsMhpWd
         jV8g==
X-Forwarded-Encrypted: i=1; AKwUvBx+q84W0hL5mteEhSNwpfSbOEueTDxo8QW1JiiRT3IUEIV5Qk1a387L8ouDbHvQCCDAaCUGSaMcJz611GETJQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK6ihg/4FADVWzAkONBzWvhqDXFsRwnFbt2/9N5lO9BmfTTQESA
	jlHHNX32EbpvRdvrc4QWqkHU0rtoqbcZTnzrJqL2yiOaMnmnCubiFF5G
X-Gm-Gg: AYBFou1ns9K0CvSd7lzLz5rQSt5PkHTLgawqk7aEFnqx8BnX4SZ8OEfFBm5OTTHVDIi
	Y0cQFLc9x9mA/BE1+lu+HkcXbMuaxZwMOqmfRoJ9TdQ7ZXY4z9aCjwMXCsfWK90KmR0wUT30KMe
	K1IYg3Z9EXILgwKDnheGaIWgAqw2hoJek+HqqIZ/FTjpgmIwW/Y5bbw2gq+QxXQngb1hRlVJD+g
	+1xL25Zfg54wOTh9zEjfyBSo1NGRigTVS57mt1ptJF4ZiZ/ZopCNrt2OtYOMWgGgzRaCLl1k8vB
	0bmpSDWw4M9TaiAHJTTpLIAVuAkf9fRa9J2XBcgHGkemu7hPe3FR9MOEC+f4PVmHpXC4B6Lv8H2
	LUiamAwNmXvncSOwQ1fCQgI0BEeSFH/4RzkByAzQbJLM55SXNp6zo5wVDaLySvxR6NsGb0VcsIj
	sWBcCVero2LyGHqccff0r7x4XaNtrkLQTMfDiCN3azFPLrEv59j9vsleH0hDEwYRJpZX2Xhg==
X-Received: by 2002:a05:7301:1a07:b0:315:9d54:6bf with SMTP id 5a478bee46e88-34f15066a8dmr1926517eec.10.1790927196556;
        Fri, 02 Oct 2026 00:46:36 -0700 (PDT)
Received: from dbg-srv ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm5871618eec.4.2026.10.02.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:46:35 -0700 (PDT)
From: physicalmtea@gmail.com
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] vsock: amortize RX socket locking for stream packets
Date: Fri,  2 Oct 2026 07:45:48 +0000
Message-ID: <20261002074551.318789-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

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

Limit each batch to 64 packets or 64K of payload to bound the work
performed under one socket lock. Keep the lookup reference until the batch
finishes.

The virtqueue callback remains a queue_work() callback. Batching runs only
in the process-context RX worker.

Introduce virtio_transport_rx_batch_finish() to tear down the batch and
release the socket lock and lookup reference.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |   9 ++
 net/vmw_vsock/virtio_transport.c        |  48 ++++++++-
 net/vmw_vsock/virtio_transport_common.c | 126 +++++++++++++++++++++++-
 3 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731..95ab1a75f 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -282,6 +282,15 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
 
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb, struct net *net);
+
+struct virtio_transport_rx_batch {
+	struct sock *sk;
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
index 4f9aa9c4c..de5f677e2 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -629,11 +629,21 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
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
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
+	struct virtio_transport_rx_batch batch = {};
+	unsigned int batch_pkts = 0;
+	size_t batch_bytes = 0;
 
 	mutex_lock(&vsock->rx_lock);
 
@@ -648,6 +658,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			unsigned int len, payload_len;
 			struct virtio_vsock_hdr *hdr;
 			struct sk_buff *skb;
+			struct sock *old_batch_sk;
 
 			if (!virtio_transport_more_replies(vsock)) {
 				/* Stop rx until the device processes already
@@ -666,6 +677,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			/* Drop short/long packets */
 			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
+				virtio_transport_rx_batch_finish(&batch);
+				batch_pkts = 0;
+				batch_bytes = 0;
 				kfree_skb(skb);
 				continue;
 			}
@@ -673,6 +687,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			hdr = virtio_vsock_hdr(skb);
 			payload_len = le32_to_cpu(hdr->len);
 			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				virtio_transport_rx_batch_finish(&batch);
+				batch_pkts = 0;
+				batch_bytes = 0;
 				kfree_skb(skb);
 				continue;
 			}
@@ -680,16 +697,45 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
+			if (batch.sk &&
+			    payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
+					  batch_bytes) {
+				virtio_transport_rx_batch_finish(&batch);
+				batch_pkts = 0;
+				batch_bytes = 0;
+			}
+
 			virtio_transport_deliver_tap_pkt(skb);
 
 			/* Force virtio-transport into global mode since it
 			 * does not yet support local-mode namespacing.
 			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			old_batch_sk = batch.sk;
+			virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
+							&batch);
+
+			if (batch.sk) {
+				if (batch.sk != old_batch_sk) {
+					batch_pkts = 0;
+					batch_bytes = 0;
+				}
+				batch_pkts++;
+				batch_bytes += payload_len;
+				if (batch_pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
+				    batch_bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
+					virtio_transport_rx_batch_finish(&batch);
+					batch_pkts = 0;
+					batch_bytes = 0;
+				}
+			} else {
+				batch_pkts = 0;
+				batch_bytes = 0;
+			}
 		}
 	} while (!virtqueue_enable_cb(vq));
 
 out:
+	virtio_transport_rx_batch_finish(&batch);
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index acddb268f..ad1e99689 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1834,10 +1834,26 @@ struct virtio_transport_rx_pkt_ctx {
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
+
+	return sk->sk_state == TCP_ESTABLISHED &&
+	       sk->sk_type == SOCK_STREAM &&
+	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       !sock_flag(sk, SOCK_DONE) &&
+	       vsk->transport == &t->transport;
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
@@ -1847,6 +1863,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	struct vsock_sock *vsk = vsock_sk(sk);
 	bool space_available;
 
+	if (ctx->batchable)
+		*ctx->batchable = false;
+
 	/* Check after acquiring the socket lock. Listener sockets accept packets
 	 * from any source and are not assigned to a transport.
 	 */
@@ -1888,6 +1907,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		break;
 	}
 
+	if (ctx->batchable)
+		*ctx->batchable = virtio_transport_recv_pkt_batchable(t, sk);
+
 	return false;
 }
 
@@ -1938,6 +1960,108 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
+{
+	struct sock *sk = batch->sk;
+
+	batch->sk = NULL;
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
+	struct sock *sk;
+	struct virtio_transport_rx_pkt_ctx ctx;
+	bool batchable, start_batch;
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
+	 * Sockmap insertion takes the socket lock, but removal only holds
+	 * sk_callback_lock while restoring the native protocol.
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
2.53.0
