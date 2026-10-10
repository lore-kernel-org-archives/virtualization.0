Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF44A8FD3
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642222; cv=none; b=F9UMc8QIbLA6ESar7S23VCmPorAfztk66L1SqOIp/xEcCsMAYbd/tCLmDYU3naOPIyNPJ8kU96duextM4/gmnWsQ0/uBIDkegDBowArFAfBohyoNpC23QBSg+Rb1VFyhAFN4QEtSWJ3Rlva5cFiv7l9TfVM9i5GFurGAj30Zy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642222; c=relaxed/simple;
	bh=SR265Jmv9EOllUtmFjO77CtNsAfQryl1UbcAKyqIvXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JgaaHqTn1CrdwRZyiXYzBpcOpDEM8I6+4IVX2FnTxg8qt9HjJWmKC8Yjt3u2UnPYW6LAxoHPjl0tSKHOBQv2Xew5O8yLwMTiith7l0/EPNQOi6zB104mKRO8IpNssTkJo/Yx10AXk9PieBm0IAKv0rVAd+/7fjSAGwEVAlA3CBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3CnfwaY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3CnfwaY"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab066bef7dso248772a91.1
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642220; x=1792247020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O1x0phht5NvvvSb25eom8J7EmXbou4YWYoQ1p3enTUo=;
        b=G3CnfwaYwNVe0jJ1SIkN6sWAYVWGYo+BZF+aQWRJ9WpJLqk+QQzJfuCNmT7lX3Uin+
         9kKSJGvnbMTzsnxxJfpOmMOVlhi29HyEL2Ak1ei3OoSwm70ImS9ydQ6Zuz4TLE0YvcRu
         oSdvtUHBZbYjFWC4oqNnfjgOSaPsPymwIlv8YTlTjoBI6bix+FgBCl33sn30Dq92T0+m
         Jsvnsxqahvy6tKT7ulUR7vGo9eq2uzKkU3WymzJ+je5nIUBuz5dQZ/g34rwo2Dkp9Lo6
         0xyAyKn2tg3kmupRUqQccRba0cRFCbMPUuwXqS6wmN3sprAe8AACwf0GWNyWh6da2AC7
         7v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642220; x=1792247020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O1x0phht5NvvvSb25eom8J7EmXbou4YWYoQ1p3enTUo=;
        b=kt+VomGF1L4VbQONE23N+rvsKIkT8gntE3NbcISeDIxYD3FRwmZg5zUzK4dSjqDBRn
         9tq3m0YMZVRZfIAlKXn6yxrhMro4bG9DaaaIM5vh8+1Ycnjb2p7pjvyfjHm67yqA+gE8
         uIWbCEJuywEaD/CCv4bZkfl2GtDkx/jviT/caNTb8ZvXac5yKA38lErGx8prMydwQt4D
         +3MCb2P+/gffM9MJIYM4mW+JY0Ew//uEx3Wa/kUDHO5tr2CohsqM77rETminXkkIVhRX
         mUKJDc7o3RVeQQfkykRKFECUcPzidLj3Rjqod+yU9xle7fcBlOIoQTQVT+QiGhmzg8w4
         wEdg==
X-Forwarded-Encrypted: i=1; AKwUvBxvZpICXAyDolBn8eDI/W41cUplQ67IWqNQhFjrSxAoyouaxqXsmXNjKiFrZla1/oeOCMUnovLiLjlI4G0F6w==@lists.linux.dev
X-Gm-Message-State: AFq9FYL9M9qc08ExHCWcFgPJB/hHe4ZylZ8BK9gIca2GEn+Mpnz7VWas
	9tSLoJR33b+JtjLW8WquiJowMHKOG8z9s0PloaVTNGg51GlXB4ncHqofTma3SQ==
X-Gm-Gg: AYBFou0VyPggC6SJQ+v0Io0PBkifO5h0ErkgwijU4+ZtuOFGSODdr8L8q24bs/AJjDe
	SR7869vVS82JyFDvjmupOPT1S5QFhzt/jIdbiob4kLxdfIoYGFSkTOGbZQYnnxujTRAO++WS0Vc
	WI2O8Ktt5mEOglu9jQ0g94rHom/GDYPUaAgqb9xlDCi2nJ/VsEgk6CZfmzN76q6/ROPp4AMJ5Hd
	kTJg4UbfHyZGB6OJYjX1497eluAyRgzWPNgOSja2TDtdmspq6JHnbxvASXr6mw9Bj3WNHix5lDd
	BpDSrJsZ+31bziRjdXexV5ZlsAjuhQQR1QZC5w/ZR68xwg/xqsOOaJobyRtYpQy77L8i35R2TVz
	kScJYBuwT0bfw7UrgXpJzLXW9cEaM8+EQnA2KCwpSRB8150PbbawxpblsU9WaLJkeqmeQC20pTo
	KOlJC+Tuq+kW8ZwnbsmmnkrE+QUnaCX1ISrQxcljlgl9Eezt2fkRJdCPBcOVmyJN1NAsxHBXAmg
	uMt122m
X-Received: by 2002:a17:90b:48c1:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3ab3a32f599mr3976782a91.8.1791642219863;
        Sat, 10 Oct 2026 07:23:39 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:38 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket lookup in RX batches
Date: Sat, 10 Oct 2026 22:22:45 +0800
Message-Id: <20261010142247.99223-4-physicalmtea@gmail.com>
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

An RX lock batch still looks up the socket for every packet and takes a
temporary lookup reference, even though the batch already holds a reference
to the locked socket.

Record the network namespace and packet address tuple when a batch starts.
Reuse the batch socket for later STREAM/RW packets with the same tuple, and
release the batch before looking up a different flow.

The cached path still traces every packet, takes an skb owner reference,
validates socket state, source and transport, updates credit, and runs the
receive state machine. Only the socket table lookup and its temporary
reference are skipped.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  3 ++
 net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 26dde6909c4e..d6528681e052 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
 	struct sock *sk;
 	unsigned int pkts;
 	size_t bytes;
+	struct net *net;
+	struct sockaddr_vm src;
+	struct sockaddr_vm dst;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e67dfcaa279c..73e5c7dfe8b4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
+	batch->net = NULL;
 
 	if (!sk)
 		return;
@@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
 	virtio_transport_trace_recv_pkt(skb, &src, &dst);
 
+	if (batch->sk) {
+		if (batch->net == net &&
+		    vsock_addr_equals_addr(&batch->src, &src) &&
+		    vsock_addr_equals_addr(&batch->dst, &dst) &&
+		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
+			sk = batch->sk;
+			if (!skb_set_owner_sk_safe(skb, sk)) {
+				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+				virtio_transport_rx_batch_finish(batch);
+				kfree_skb(skb);
+				return;
+			}
+
+			ctx = (struct virtio_transport_rx_pkt_ctx) {
+				.net = net,
+				.src = &src,
+				.dst = &dst,
+				.batchable = &batchable,
+			};
+			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
+
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
 	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
 	if (!sk) {
 		virtio_transport_rx_batch_finish(batch);
@@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 	if (!skb_set_owner_sk_safe(skb, sk)) {
 		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
-		virtio_transport_rx_batch_finish(batch);
 		kfree_skb(skb);
 		return;
 	}
 
-	if (batch->sk && batch->sk != sk) {
-		/* Never acquire a second socket lock. */
-		virtio_transport_rx_batch_finish(batch);
-	}
-
-	if (batch->sk == sk) {
-		/* Keep the batch reference; drop this packet's lookup reference. */
-		sock_put(sk);
-		ctx = (struct virtio_transport_rx_pkt_ctx) {
-			.net = net,
-			.src = &src,
-			.dst = &dst,
-			.batchable = &batchable,
-		};
-		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
-		if (!batchable)
-			virtio_transport_rx_batch_finish(batch);
-		if (free_pkt)
-			kfree_skb(skb);
-		return;
-	}
-
 	lock_sock(sk);
 	/*
 	 * Sockmap removal restores the native protocol under sk_callback_lock.
@@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	if (start_batch && batchable) {
 		/* Keep the lookup reference until the batch is released. */
+		batch->net = net;
+		batch->src = src;
+		batch->dst = dst;
 		batch->sk = sk;
 		return;
 	}
-- 
2.34.1

