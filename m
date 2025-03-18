Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93A2080CE
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291835; cv=none; b=o7lH2ZDtYMhKx8LpB1VrAmYG2tGnM+6o2l5Y4snLMzabRrtWMCwV0PSfGzarMNIlObGkyaEaARwVyiMDHC1lQiprUMyHOfFNQmGqB2JBeDYxLUdnJ5UMyyIUVccDIK3oClQoyOPK6H+6kdwCq7TuJn1STFfg11Q+GB8rZKPCeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291835; c=relaxed/simple;
	bh=kvpzrCPZKG6u1vfeN24Aw1Y9W52FSdUnKV0z3nPYKzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kji9c8o/qSg4xggg5Dbwl3oCtzE/stMNaLT8c+Wo4koLvyZO8aXM3Twgrx4Bj266bChkFhJ13gLx1gMl+DRMLrCnnsqS97wWmQL7vrDg3XzMGsezCQyoBpQHIfRRb0vFFdXZxdv1A9XkePqB7+euOPP0ixT05zntZCsygdY1XVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=2bld17dV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="2bld17dV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2254e0b4b79so127532575ad.2
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291830; x=1742896630; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKto7h723Ki7kYMKjnEf4R385v5d75BQEmZfS9JmO3c=;
        b=2bld17dVodIQqZDNEN7MSH942VC9mupShgP1hNlrKnBcXcJGgHFda/Wz5yZW/hMWvT
         6V+DgtjApfffd7EWpaGP4IgnFRryfdDWCVgTPDhTLFKOndgrjfcDPzsHQ269hcsc1PRb
         f9KErxFw9zjLhwk92pJT77rTBYXnqoje4q4CGGO5/xAyYuZanIpnNS+yBrKpnyDxFE4d
         P1fxwU8u5ahmwzNDusyKbKD5lm2CA8vISArntPl1/RWlJG3eF/Tc2rK+TiX89vjhhGrV
         7vqu/lkHiTkUm6/0U+2DDZo7HD/He0a7b8lIskZEpo6e1DXkIwU5Gje21S/MVHPI/UrP
         LFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291830; x=1742896630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKto7h723Ki7kYMKjnEf4R385v5d75BQEmZfS9JmO3c=;
        b=SrpJr5LNL6zMc0zL4RQamqROChCMVvJU3l7yGClCA9N0AfkkVgI/KQZlqQgBhmnkjw
         tjkcN+uLO32uF/NsnujmYZMXUg/rVX/Z4Ww9cAA7s8rb+n+b6oaXdj5PsOiUIokgoq7Z
         wuB8aEIvcN+OTJBtnJQxaZibcCe83WuGUT4qxsa7kSEga67Tn6CQ254jO/x7YPcp6dZR
         +iWo5r4ZePHMtsyqLrfaxEbL2XBONCgOywiL/73Q6+6Tpkl1zk9z3GAHjisWoUrTUuZm
         i5dqpLVg2kpRn664niqU7Q/cxKrAyGYWbN61ffj8H54ONNs4XKIiwN2UGI9yXDUuDMn/
         GDJw==
X-Gm-Message-State: AOJu0YzT9xLq3ATqIXw8DWG0juJ/tWmgVU7xWRRPHRZmt5P4yhhToIPI
	XjszSt2G+LriL1vr5432oE4mGXIxMLlZEmUIZmLo4YJiNGBhGpHXSR/dd+9tKiZxv0TXA5ucyjY
	fE9c=
X-Gm-Gg: ASbGncsQNC/ZdWp1Um0bpAbajKCC/PDUK55uENixG9c8uBQfIOsKzj3wfbi1+mk+gBs
	KnWa6uPEAeLF1fQP6AX0E2rgPb0RxeZCL/8+WBDanIflk2ndWI7rGBtKIia2QSBAIfSCs4iU6ju
	BB2e66BBSnQLZkmCIEv/m3MR6PuSPVos10MQjP5kpP0hY7yOwVU6yTdDF+PuXT+wLRBhJdpmcT5
	wIpfsJ3KU17CgPuXErDwIMNiHaUQRqrh94pqRB0taJLrWeOy0eLn/CcTmAAsIWjPZNYk0dTaJ44
	qekb1d/bowJFR1rSZ+e7nHQcux0LNfJBYKbw4UHE3pJKYhQ0
X-Google-Smtp-Source: AGHT+IE2MIs+V39ucomf0brjofhjxyDBLUBR6ChaUUJySbvQir92UJ3hGg5A3YxoOe1UF+ZtBdVpWQ==
X-Received: by 2002:a17:903:2308:b0:224:fa0:36da with SMTP id d9443c01a7336-225e0a537c8mr210649515ad.18.1742291829794;
        Tue, 18 Mar 2025 02:57:09 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6ba6a38sm89927275ad.108.2025.03.18.02.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:52 +0900
Subject: [PATCH net-next 2/4] virtio_net: Fix endian with
 virtio_net_ctrl_rss
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-2-344caf336ddd@daynix.com>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Mark the fields of struct virtio_net_ctrl_rss as little endian as
they are in struct virtio_net_rss_config, which it follows.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/virtio_net.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..d1ed544ba03a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -368,15 +368,15 @@ struct receive_queue {
  */
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
 struct virtio_net_ctrl_rss {
-	u32 hash_types;
-	u16 indirection_table_mask;
-	u16 unclassified_queue;
-	u16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
-	u16 max_tx_vq;
+	__le32 hash_types;
+	__le16 indirection_table_mask;
+	__le16 unclassified_queue;
+	__le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
+	__le16 max_tx_vq;
 	u8 hash_key_length;
 	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
 
-	u16 *indirection_table;
+	__le16 *indirection_table;
 };
 
 /* Control VQ buffers: protected by the rtnl lock */
@@ -3576,9 +3576,9 @@ static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pair
 
 	for (; i < vi->rss_indir_table_size; ++i) {
 		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
-		vi->rss.indirection_table[i] = indir_val;
+		vi->rss.indirection_table[i] = cpu_to_le16(indir_val);
 	}
-	vi->rss.max_tx_vq = queue_pairs;
+	vi->rss.max_tx_vq = cpu_to_le16(queue_pairs);
 }
 
 static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
@@ -4097,10 +4097,10 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
 static void virtnet_init_default_rss(struct virtnet_info *vi)
 {
-	vi->rss.hash_types = vi->rss_hash_types_supported;
+	vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_supported);
 	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
 	vi->rss.indirection_table_mask = vi->rss_indir_table_size
-						? vi->rss_indir_table_size - 1 : 0;
+						? cpu_to_le16(vi->rss_indir_table_size - 1) : 0;
 	vi->rss.unclassified_queue = 0;
 
 	virtnet_rss_update_by_qpairs(vi, vi->curr_queue_pairs);
@@ -4218,7 +4218,7 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
 
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
-		vi->rss.hash_types = vi->rss_hash_types_saved;
+		vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		if (vi->dev->features & NETIF_F_RXHASH)
 			return virtnet_commit_rss_command(vi);
 	}
@@ -5398,7 +5398,7 @@ static int virtnet_get_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			rxfh->indir[i] = vi->rss.indirection_table[i];
+			rxfh->indir[i] = le16_to_cpu(vi->rss.indirection_table[i]);
 	}
 
 	if (rxfh->key)
@@ -5426,7 +5426,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			return -EOPNOTSUPP;
 
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->rss.indirection_table[i] = rxfh->indir[i];
+			vi->rss.indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
 		update = true;
 	}
 
@@ -6044,9 +6044,9 @@ static int virtnet_set_features(struct net_device *dev,
 
 	if ((dev->features ^ features) & NETIF_F_RXHASH) {
 		if (features & NETIF_F_RXHASH)
-			vi->rss.hash_types = vi->rss_hash_types_saved;
+			vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		else
-			vi->rss.hash_types = VIRTIO_NET_HASH_REPORT_NONE;
+			vi->rss.hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
 
 		if (!virtnet_commit_rss_command(vi))
 			return -EINVAL;

-- 
2.48.1

