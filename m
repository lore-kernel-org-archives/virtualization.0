Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455E30E0EE
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318499; cv=none; b=sfWlNsMrrq2t7lYiYMH2grGzcMz6ZmHbQXPhd3j5QGGC1u2PUIaRKzZVAeeZC97M8lgWMwtRbU9itIXZwMtCYRxw05zhv9Osw8nNrvDlQ6LadjFkRD0jxDaaX1c7gvCEyVHn1MoW+/LvtJpgDfWU6xCW+TyYony1h/dUkNt/0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318499; c=relaxed/simple;
	bh=Gg1nmF2BIwqahLlAKHrDdQElBJulqFj/VnBEXgD8/+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YytsLMcPeKkYyTNe/ZCBSSNTjT9M+kf/I5ClGRz2T4lXBhgyRulfvAvaIAoKewDp1Qul5Fh81RbUU+fk598OEPw6ia6mcTyHPDY7qcExta/kvrIG+N2A7jlt2qqcuqcJHVBG4i0a4nab9Dq+HaAklqOYSthOKbXt1Fw50aoFovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpumywP9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpumywP9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3307de086d8so2173477a91.2
        for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761318497; x=1761923297; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5kuodqL1XE4BwxT+c9wdfrA/FtLyiL1+q+ub9Uk7uI=;
        b=CpumywP9whWuKsr/5g2wmJ7WpzEI8Y29WgmE3YPZGn+rifiQ7rnyvyDKEEktW6dp9z
         3nskYls7ItYOMqbWkEm7nIX4GERoxVWqW7yTwsFuSE68TzeeoLYepYUqTrb/7eQomScR
         OSX8Zxjc4l0oYL5RXJwke0VycmFT3pn7x1YUdB2y2iOhULGGioEua4mgGbha1IRiPZy9
         17wghX4YpzDKLnyh/4dxwzO8lApAlnrNGrgRR7LiEJlj0Vd1fnTbMts2YDTjMr8AQawo
         xZ983SDFfi+ns+6kiP0ze60rW9+q9WahAfasr7eKdXEmhI+i2q2pnp9bAqRxdUV370/n
         LFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318497; x=1761923297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5kuodqL1XE4BwxT+c9wdfrA/FtLyiL1+q+ub9Uk7uI=;
        b=GnTYGvA372HGINxdEp6+CYz1XMkhoQZRXBRjc7wlB+qrTeBRJS9vPiwma/p/i2e5Jb
         UANh/osK7E0KYhTuAXgEiM7yTmMdk65GdWBqCvqNat8M76lsX4yPnkScT0vtZDdLxysj
         4QE0XHYZO8LPz3XVA8/m3JywKFBF72EEvYqZoPJGFPXGh/fqKwSw0Mg2y/FVKfZd0Gur
         EMrUURC8/sZsyht1vuRocQJC1ONA6WmNglc/M6T4/FLc3ddYQeVTA7ySYVDg/d9dVMQm
         fZ4hiu9zp9Yjh8u6QDZS2TitSuUO1FCUiBWVnPIUBgLS0UtbCujjsVau4sZ2XzCKfzSQ
         IOcA==
X-Forwarded-Encrypted: i=1; AJvYcCXRYcnuvm6kqCHDTQ2Nm0+MAZWKp0zUttOXLYO6eDCzePtZ8VRvQZjk+hsnzNcWu4B4Tk8bn7GV0SNLaUWkFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXGKcQZK/RlHt+QgBy1EJpl9EAjbp3qz0F/NPSgm8mqkJdimUj
	QnltMn6M7ymQWEMydhpDCjNDDP1zsmq0bgJet/aMU00FrDS42ZZ7GNyK
X-Gm-Gg: ASbGncsMdJ9cYC5e5JYIpPLMXvyh4ivS7lVT2ScfRvIgv8TzJfRylker4WGgeneg1jO
	E/AVFIzarU0TRoAXkB6qQhHr0u1C7Yo0ht3qxvRGctNeSAFo48LBmXNBcJapEMs87JtLGInS7Lu
	LhmRTNpyi86NfzdWlxkqbKo5OlimavH0xkiJXFSMccHktVai6+DcmA9Rnyw6ZDuea3uQADnANR0
	XYpO1J0XXYPuylbPdNU4K9rLDghF63147f1JgXCCD66tpWZcvr7SjzWb6OC89viyfL4G9Ny2I2C
	bp9CYVpWimTa4T/YA1o2KLMby2lgBCLCMycaSORsb84wOWJifq52qFJr0jdaiDbiDW4Vots5QBl
	Aqggn1x7FPB/eUsZM6GV7aneceUKaGVsr+roe15haXN7LVg7AC0R9mF9kxdWq5CL2VedfNAkKWy
	rW8RbeV11wcZ7cvx8b1CNeb+8e
X-Google-Smtp-Source: AGHT+IEIvsCPeZId5sB7KWJU1zEUO/VQOzw5rKKQ7D/ehXSXh4dGRIiEaa8KnJaPfgpC64pTh/Lipg==
X-Received: by 2002:a17:90b:4f:b0:33b:bf8d:6172 with SMTP id 98e67ed59e1d1-33bcf92aae9mr35463946a91.34.1761318496553;
        Fri, 24 Oct 2025 08:08:16 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:4deb:2cfc:5afd:7727])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33dfb1db6aasm5934227a91.0.2025.10.24.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:08:16 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5] virtio-net: fix received length check in big packets
Date: Fri, 24 Oct 2025 22:06:49 +0700
Message-ID: <20251024150649.22906-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), when guest gso is off, the allocated size for big
packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
negotiated MTU. The number of allocated frags for big packets is stored
in vi->big_packets_num_skbfrags.

Because the host announced buffer length can be malicious (e.g. the host
vhost_net driver's get_rx_bufs is modified to announce incorrect
length), we need a check in virtio_net receive path. Currently, the
check is not adapted to the new change which can lead to NULL page
pointer dereference in the below while loop when receiving length that
is larger than the allocated one.

This commit fixes the received length check corresponding to the new
change.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v5:
- Move the length check to receive_big
- Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
Changes in v4:
- Remove unrelated changes, add more comments
- Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
- Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
Changes in v2:
- Remove incorrect give_pages call
- Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..2c3f544add5e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		goto ok;
 	}
 
-	/*
-	 * Verify that we can indeed put this data into a skb.
-	 * This is here to handle cases when the device erroneously
-	 * tries to receive more than is possible. This is usually
-	 * the case of a broken device.
-	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
-		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
-	}
 	BUG_ON(offset >= PAGE_SIZE);
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
@@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb =
-		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
+	struct sk_buff *skb;
+
+	/* Make sure that len does not exceed the allocated size in
+	 * add_recvbuf_big.
+	 */
+	if (unlikely(len > vi->big_packets_num_skbfrags * PAGE_SIZE)) {
+		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
+			 dev->name, len,
+			 vi->big_packets_num_skbfrags * PAGE_SIZE);
+		goto err;
+	}
 
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
 		goto err;
-- 
2.43.0

