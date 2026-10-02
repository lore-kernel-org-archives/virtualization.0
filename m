Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC343DA3A
	for <virtualization@lists.linux.dev>; Fri,  2 Oct 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927204; cv=none; b=uPVOQ96T4ZMtka7FT3YTvwh998F3FxV+ztZxHndRTJ5jGtPJB/HL7rjb7mQno+2XHCfsfilI5GnGAcLaJPOZB3uCyZ9AZ6p7FOyTkcBCm4JjxvCVEw3WYSOQ5zSBuEsOw6POyi2JiIiJoPk0NoFepRgIXwWt1qFb8nMbB2IEWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927204; c=relaxed/simple;
	bh=Gi+4nfEvuXQGlo0g5mXVBj1pECSfFNUb6sc20UM6ULY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t55KHiv9c9S5L8QOLIY+ft+eEBiGrVrFq2etpD0wwIPpxJFR3RTw33b2Z4oVqH/GAGmraPSDOsbcixyEQn66uQTYhLvGT0OWOo+tuPETct65zOUA6ahdtz7gTjC8AzW7L7lsssf87+7Yz3Axodcf9xhZpIstvS2ikbyqVnfgzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bod8OzQg; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bod8OzQg"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14f381f0424so380434c88.0
        for <virtualization@lists.linux.dev>; Fri, 02 Oct 2026 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790927202; x=1791532002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcvM+ew7yM+UK9bAQwqe/0F9zFjnDuHgdGa2U9rD4LU=;
        b=Bod8OzQg34pjfX4w3IsLnCxNQCRjljQ3R7vlpejcHScu2D4VU4xli6+1OYc+MW/mTt
         dt2YXj/5MgrBb1edkAhS3Fy8vb7CZ3PK0AMmkJTwvkjdjLvUIvWSv/44QwaD/4P01RT1
         S7gZCZB6yoy/UP4CImF35hRR6LcvuHtLX6id1GwsnzRATSwArclYYSTo7ESRndjSVNue
         cXEOIFkZBCKkwNLqd4xV8VWqoqw4RUX8w6GSF7qlRhTj8gSs9UnRVWgFWaDtEukAl+Uu
         oyl4Px5vZ4fmbkBzUMKqrY8LLTOsqgaRpQadeMqJJcSH/MKkSL5Th7P+1qGTZ8A/0Mtl
         O+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927202; x=1791532002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcvM+ew7yM+UK9bAQwqe/0F9zFjnDuHgdGa2U9rD4LU=;
        b=D6+lCHw6vq7k5L9ZESfohU+cny0+h9/pse9dovU1zO7pMJk0Krq/YHspgeYrhQ7Q2C
         OW64AzmcWXh2EFOmcBmA9p9nqOIxX6lXcnw4TvP11VjJ+E/OkhwCVEtxA+EBYmYFd9Pi
         Aik7MXchgpUpsGd1TL8l3+tvF8doFOzQF17lSM3Meu4Qso03RxO0/y8qT8VLy8mDoClS
         jobZqxWo4z83N54ZJbEI3mAJ/h/Jc/O2CTl51HpCltpWC9jNsXRKdq02Fs5FqG6ryjVs
         +4M+n8gADfA7yR7MPZ80xf7TCYSs1HAr131rStAcy+dZ33B1FwXgRUW+LrXKaI2kJ1+/
         CVrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTzz4haD1Ty1F6r6yW/G6/gynpNHokuYnExP3+9NmezkyeaTVA3PZKUHEp+uEvgfKO4XMdJByg9ZCD4eeElA==@lists.linux.dev
X-Gm-Message-State: AFuF++knLFfXwLUdLIdLTIiyEse8QQUBVuHSRmD5wbP3t8bgoeJamdSd
	Jfqt5bHNdL1MHWh5Osf1vZw/UBhT6Hxc3WLjVj0IeBfnKXt0a/Q2pjjL
X-Gm-Gg: AYBFou3A8BLbTA5w2s94rqZO1D84E2jZoSIVDTPOIAfXytARCWCl2T+LJfb11I23ztO
	uDvxVqZR1s9sxOKyxeyG9MDlVi3fy3AQRQFOGR6F97I0Yx9b6Je4xDil4gfX0xdNfeonX8Hj4yQ
	NcCCS5QKoWqk2+FhBiK/M01sNoii2G1uZH57TQ44nRNh3sSM2RbAcrDcypjo1M6Akmd57dDD6Oe
	P1CLB56Dt07RoTUWlI1zBqRyf0dD2ZPfxRmb98B1M1BdfldlrzmM+hOiZeYDHBi4KIMXjIhdJMd
	O7P7carNOfK4fkNzT8H6kxvjPF79xTg5436kWuwpCdnqvHe9rZ45Td84pLEl7M8fNHJ1wV5QTeG
	0p0UAiGEEWJ/bkAFudCGIr1FYvsuvOJhzliaLRwijMvzAfCTXpjwedr8pZJ+e0PXqxEdmOshLfo
	21KQKmuOMDrGnKoyvjgQwbC1Ee6wtSqirHKZefDqNuiBKw1tBtR+lAM9S6nAjiko7yO6xp2lVmh
	b5uXg4=
X-Received: by 2002:a05:701b:2096:10b0:143:2719:566e with SMTP id a92af1059eb24-14f5d3b9a1fmr1967596c88.42.1790927201379;
        Fri, 02 Oct 2026 00:46:41 -0700 (PDT)
Received: from dbg-srv ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm5871618eec.4.2026.10.02.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:46:40 -0700 (PDT)
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
Subject: [PATCH 3/5] vsock: reuse same-flow socket lookup in RX batches
Date: Fri,  2 Oct 2026 07:45:49 +0000
Message-ID: <20261002074551.318789-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

An RX lock batch still looks up the socket for every packet and takes a
temporary lookup reference, even though the batch already holds a
reference to the locked socket.

Record the network namespace and packet address tuple when a batch
starts. Reuse the batch socket for later STREAM/RW packets with the same
tuple, and release the batch before looking up a different flow.

The cached path still traces every packet, takes an skb owner reference,
validates socket state, source and transport, updates credit, and runs
the receive state machine. Only the socket table lookup and its temporary
reference are skipped.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  3 ++
 net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 95ab1a75f..4369adc07 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -285,6 +285,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 struct virtio_transport_rx_batch {
 	struct sock *sk;
+	struct net *net;
+	struct sockaddr_vm src;
+	struct sockaddr_vm dst;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ad1e99689..d8c9c90c0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1965,6 +1965,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 	struct sock *sk = batch->sk;
 
 	batch->sk = NULL;
+	batch->net = NULL;
 
 	if (!sk)
 		return;
@@ -1996,9 +1997,38 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
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
-		virtio_transport_rx_batch_finish(batch);
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		kfree_skb(skb);
 		return;
@@ -2006,33 +2036,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
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
 	 * Sockmap insertion takes the socket lock, but removal only holds
@@ -2051,6 +2058,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
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
2.53.0
