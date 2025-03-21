Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456611EB9E5
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539748; cv=none; b=sdrSPCfDAjkakXIbJlyQeEHVH+vrsW/xAgS6K8Z6r+VmUHBMXsOKRftzQBxsGdH644mzX6uddAxjJjB/6xHtmUgIsLRY5h1oYpRpiNsw2R0nt6wiHr4gIv9+0QkL7CfGhNqnHSIRUyAUf0F1IINBSDBFtc1EKCEltD3z4DNMwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539748; c=relaxed/simple;
	bh=JA5lB20OwEFvfOBpIlszUUf1X9ZmjUyWnEr7Zb3EhmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ryl+ZyfBJyjqYgMpxdw4gMW2vX8P8XwSf4IBjRIasXqOpbULYVbTeXND7NrbqFsMFp84ATZt9+c3nmTM0EL84KbxBh+3ANozLM7fkO+lrTbaVl+PHxqSvKhsAk/DP7DPjUzxPrPh84EsdtE0xKNUenbRaTq3xMjRweluXuYpEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=FLwkThxU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="FLwkThxU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2255003f4c6so30541585ad.0
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539746; x=1743144546; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elvR4miFALyu5FnLIhwEFH5pLlJ21X8V+zrz+RJ4D2Y=;
        b=FLwkThxUGDzABWbWSB4ppeCSHALxmYExMT7HFFR0q4YTJOe1qIXAvHoltXF/RUiaEu
         k3Rrqbc7YLYFl7lJZKR7dIXi4dEB5jWv+2j9Nv1ER7DJ8ftD5KJDpjq5RQnzmGRS+ccx
         jbHbEqvFwI6K4KVcssjxqnIBimbax2Jz/okVTT6Sjkal0KWAAk1S9RRsOHy8H36Z2/NR
         7VI4UNjjnkHueov6x/ZVsRyCGiEIBZzF5JzL5llbqz2xWcQAOoJRJQpKt6dv7jnoO0pZ
         akp8cKkOCIlqMpo02tJU90TS5dipawIOwlNorcn6mclQdN2fJ3RDXHcY5cvTS+lEUXpY
         +utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539746; x=1743144546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elvR4miFALyu5FnLIhwEFH5pLlJ21X8V+zrz+RJ4D2Y=;
        b=Fgm9T/OuHHpEVL7mZpj1jN4QGmDcDrsFM7js9NqxID7DeXOY6fVBK15xP4PVvlTVjH
         MvuuhI/OQhUPRWwGXPyj0P9JAXqYqWo2FFKrZbMPwgB/y8EgGeUQzwRvkCdll2oy3NrE
         1M4QGN2cP25TIuCOAjGjuiqe7lAuDbdkXcSwl2rC4KupUbYbdDrgb4NGkbb23LEMxV+V
         71glyMorjRN+WgUmUdsxHoF2fLRE5m4xvpXt5k3cDBQqXvCy/jZf6AarXrjapAaPAS14
         sg301Pq6FxIEzn1WQKxCU0BLsRUfuAD2ZEoPr3TnQGcU01j4QVT2muVFcNSKR40f9OKF
         5nVg==
X-Gm-Message-State: AOJu0Yzybk4/yiLNMZWRaZRFaWZjMUZTq2LLVQOaACt/q3kDZSNaMr8L
	5E6Z16RV8iWPyyxrr6/38BMjFdhEMXeIBDBWB1bIPKlFPKGsOEHuHJE+IXuIbBk=
X-Gm-Gg: ASbGnctwUcFhIGTrmn/51P5vkJ7gINoNRW2G9wNoOfBMZEH/rkTQIcxLdveKjkPP/Xw
	6P+eCAhcecatNKYfWI6Ofau9cAkz9ydon9ShhdUOCPnYgDY3/hZXIWqYx59JnCMVzTnZKcGXQ0z
	ZJwSKREIAtbG596F08WrPoXW+xWT/vdcwV4imXRqkaHMZJHQyTrPKpsF8tfg6jUD3gDR8maTBZi
	UUEjtBPnUR+uWOJ1RXai2pe1nAFRRuHDPihDhEgVUAAgCyP5Pnhx+9F3ez36hHBIRiwwVyWnIpe
	iykpkj3kpiVIrO45ZBVMxYsdgdXmuypkKNYspS0064qdc1Sv
X-Google-Smtp-Source: AGHT+IGfOuNa5fyjN/141rJ7V6SWVAs5O/iHkELWdhBTVf3wR+4vSaQY0IPj0EQaRSWQrfYKVie/Dw==
X-Received: by 2002:a05:6a21:2d84:b0:1f3:293b:7aa with SMTP id adf61e73a8af0-1fe42f090f2mr4079673637.4.1742539746583;
        Thu, 20 Mar 2025 23:49:06 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2803d8csm999480a12.26.2025.03.20.23.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:49:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:33 +0900
Subject: [PATCH net-next v2 2/4] virtio_net: Fix endian with
 virtio_net_ctrl_rss
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-virtio-v2-2-33afb8f4640b@daynix.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

Mark the fields of struct virtio_net_ctrl_rss as little endian as
they are in struct virtio_net_rss_config, which it follows.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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

