Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33E1B4F2C
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661991; cv=none; b=T1Z34GXBroQh8ek2+oMEdql0n7iNKzgm6AqTAutF4WXzSjtQjCpzaJiT1UdHO0giAzwaO9GySE43YRGpGve4bRD3+7qZlHvUaVr5hlJUzVvak3fOWh7Lif+coTMBuVNpHqs2AsALlSQY0Gk4125uUGMl+DQxvlQE1eO2KxYIJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661991; c=relaxed/simple;
	bh=NEMq1QwVWGTO1PLTTQMmdZ3LbdDaen7sDe5zlw5wwnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRmk9uV2RVWMeeo4Ue4YsL8ZfOhSSUYZoGdZhJ2PAuvcU4B51T7as98IOyOas+WBn1AVz7Ef/zdmVMgg0zeexCbZZHS8AC2Ueejn65q8NG7kZIMQJUG8zlFo4wvk1lNQ2hu6N+zcTQ5ykAYJ7ghwqSBI6gMsNx/xAwRRuHH8MDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCFbJkVo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCFbJkVo"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so8331561a91.1
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761661989; x=1762266789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D93iiJ3dCsDGMRKsIegYWo/bl71Ckop0JjDdJuUp4+A=;
        b=XCFbJkVoNsRv6p243reNE7nKRdANVSJiYXbJsmker3vX6Uxg1DnMIucQM2K803iArq
         CjCrXVNRdKAODbCWyc5M7zxoMQHjYM8FIKRH8qypH61dQ0iC3mdAPIsvLhVCDCuyLzHG
         4Ia6F7Ud6wYxZ3Ljywmce1c//JJ+W3IPkdHB1V8ccjfrcoS6DNw3I7Q5f0P3SB07OQgo
         ZGdhu1O6r++Exo3XbEXWu64FEXoofZZgQyrzJxoq4bptOfKtL1Y/1G8P1aSqYVwrxLds
         +4TYaqwFrApeb68rrfxC3jspcy4lasE/8lPrJJP/eqdu2TzBV4GMLACxOBZ9D2RaAWt/
         rfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661989; x=1762266789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D93iiJ3dCsDGMRKsIegYWo/bl71Ckop0JjDdJuUp4+A=;
        b=CmrYidm/UrjMIpskiiqIOh8a0lCBB88G7cRh+937GiJl5SdKsp3tslvgGeROzYR9Q6
         ALi4GFlhLIFN7eKvlT7/qZi4xp5d82TgZRxSinOpgprcyFzCvtXfXGSm7SUJuTf5hJiI
         VcGrWZTJ7XutWXqwzwdntA3YmVoksWYg0p57+k/W520MuAjGpBXPzEtYawdjOmEdSqAk
         1ygOdHYKZXLoiJPVgx64YGSpIJDNWLPGx4mBphrOUCuMa2aoKMpbaj/rYhTcbyju8v7M
         1tKgLTOOHRkHcsBJJDWfqaVTwIWj0pW4S+JLY/PeMztkvLbWQ1LOu7PTsNXnXaag9TmZ
         CUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxivJky57EYt66gAHa9YsUXJeObxmro2Nu4ec8o4avJYP4t7QDf6nSFMjeT8bQISTJLvXh97m8XW6DL5CLgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHbGMtG1FZRt92l3z4/AIfesLeOej8g83PuDLCp3s5Ioy+UA/u
	wBCGiFR9sJRispxaoiJmX/MYtzlB7vCzY+ZonXXPOiH5t43pf+mCYmYk
X-Gm-Gg: ASbGnct8W2nsmoZb0AMdeyzDWTrfLn8MZBT7ye4PMLZc0xBItpzB+03CPLhozK2lG0H
	5QYEa4pM2XoSg+6spt4/hqZLLtIged53qNSilQXddNoEJT1iE6q5hxDKsF/UWQvcSJLNSVpmPEv
	zItY7AhCPHFHIREFQxUyzdjZGSewb2ajNyR7en/fiS/L2ONgBHx31Va6/Cq3pi82DjOgck3eS0Q
	BN4Auc14oSMads7Y56HGrmBlVwLgaiwGuVp9H2Ke9QKO6oefzLR/TcuyE7d+SO0xBnFyInhvYab
	yu1XgdEOYqgKkp1PFjgzKi0B4bqe3gLPZB7YzarKS317x7sYScZn/DS0phEdQieMkzUN6hTu7pW
	76Nc9xtVzQoVeHpBI/6BDk225DABJPel5SQxTqhydLhKwhfbOgUW17WKbv3dd9JKHB3xllPzYYW
	YJh/JiiMvaeOSreQ==
X-Google-Smtp-Source: AGHT+IFxazy1uo7lguaYfMUdntQxPnZeb5i61czGYGQ3K0U8mqn48jz+w9wNFW2dtNumYz8Q2nBdZA==
X-Received: by 2002:a17:90b:3905:b0:338:3221:9dc0 with SMTP id 98e67ed59e1d1-34027c0782dmr4653120a91.37.1761661988872;
        Tue, 28 Oct 2025 07:33:08 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:c0a1:2245:cbbf:7e28])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm12397037a91.5.2025.10.28.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:33:07 -0700 (PDT)
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
Subject: [PATCH net v6] virtio-net: fix received length check in big packets
Date: Tue, 28 Oct 2025 21:31:16 +0700
Message-ID: <20251028143116.4532-1-minhquangbui99@gmail.com>
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
Changes in v6:
- Fix the length check
- Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
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
index a757cbcab87f..461ad1019c37 100644
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
+	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
+			 dev->name, len,
+			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+		goto err;
+	}
 
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
 		goto err;
-- 
2.43.0

