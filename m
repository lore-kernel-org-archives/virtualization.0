Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDE2080D2
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291838; cv=none; b=Nphfa9AlxZhrjddcMXwVz+963GByxIhuHN8JsMa0QyHO0MtWC8V254SLC3e+Is9ecFZKrmLogu4hNdETozwXx+QZ0lltpWl+lJBhJ9+SUUiXw4/h7e1O07BCnE4qXa0zYVuSPjZqMRG4FGTpMVOE3NzZDtgw7FXaSC+jcDn0maI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291838; c=relaxed/simple;
	bh=2H0LOy1dl1R4X21fJQz5w5DwYt+uC1RiozFTUOPEQtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfRmo9UOUNOOQXa2B2f/Pi4SJiLbcpeBH31UShYUXpEdl0YLlvZqV7+9Qe73XJJnYztwDZ3lmXo1nlNml0FPC5eEKVkUcrBYr4YnS1SpzvlCp6Mc/IAiarCmT2lFnnGY0oSt3TaHmelSJw6xSmX0MAceEO5uWMsdJ5U0gy+hnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=c/V/vhnq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="c/V/vhnq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22398e09e39so114342915ad.3
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291835; x=1742896635; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwN32a07GbawJSXlfUmDtsmEJH/9PVnotVoppSFrOi8=;
        b=c/V/vhnqoCl57jVFtJk1mLKjwNovRcvxrF3BXTePq7R/sRsMVH0Rgif8RB+rWKEZ33
         i8Wj36owLy/ewMHDk8XVwIS3aea0wiYhrrq4eOiGUe12rjusw04cuYl30dD/wqw4aAK5
         jDTBiQYtME/BV3fYG9+JNFw6swURW+VKKALQyqFkA2ygcoqVUcci/ZXe21K8E8dYplt0
         Ld1YUslA1VrgQahIJHCBU/MxWY6sZn+ZFO3hNDzz1/YxX1yrxRzENujg7FZxO06a3D0n
         S+E7jCsbzSp5NWQ4xggQfMTuPjaizfiWIXfddS+NUnIfJn5bfR6KMbEsl4JJKXitA67P
         5mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291835; x=1742896635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwN32a07GbawJSXlfUmDtsmEJH/9PVnotVoppSFrOi8=;
        b=nnUyARtvCG3/+dFf6KsjGGsZXfOoIkMWaGENxoDAGfWu9YHGDKstppHs7JrRZfhMAK
         M1D23yCzAOmE6T/899A7mRpH+Gk2QkID6TQM8lfpQJyCjo6IJnlmmY986kXXoC2OvhaS
         4iv7WYFJCZGrxXOI7+v2xFHyV/87NIEl7bLWptGEVVJqDKTB/BGhWtM5V6jQpB4MhhN+
         HNxxfvASKf5l7u1+SJ/RNydudRS8/qFSxfBPhZYGSzhjlJ1JlTHfQMRQ9xvCOPoju/e8
         tK8koxPYkNQhVIM3kYxpKrrNbeIsiV8HWfBe+jLIIBeAMkUH8TESKSG2LEnt0Hsp1Fry
         9+pw==
X-Gm-Message-State: AOJu0YyxP9yvBE6BQsRyrjH0HhWiQxYOnSgClQ/u+4iD020YfiZ1Lc+E
	0m+UBZix3+/C4ONEDTOVQv1nnkgvOfRmrVCUZIn0ENHYdbiwEWK3rWZ0iHwSzDY=
X-Gm-Gg: ASbGncuBQ9Nl96DBvLaDcYw343wS77oa8+JMog0WsIqU/hvcDGQFmBJfXwToJAuwoBm
	4YfDItqeHIEi9YnpJlchj+63XdSEfmMjqssXNNg0FIflc/OZ6pjf/eS4kD3X34dDq2sA1f86f4F
	Ytaxt86OMACHyvsW3kZAfriP1yfZsOE+vX135FkiNwxUb4zGBbUotiFJ02K5vlUVSN25crBzjLk
	yUigxpCF4ZBt3+q/4hX9cga0mnXKK8BypPFXAFrEYiEJwN/pPF0OPZQKrdWSJGuE6EFP8xUHXck
	1+VxiinFksjcGtHsFpD/lgkoxmN7eaJM8Ia617bRZKHzyOD9
X-Google-Smtp-Source: AGHT+IE1M6ocCW9rTlNS1UlNLsp7Dsf3oTTmarN4fQcPRxkzPeR3CnVRs/sC2YRmUWRBq1CjvKmChA==
X-Received: by 2002:a17:903:2cd:b0:223:66a1:4503 with SMTP id d9443c01a7336-225e0a8fbfbmr165428575ad.30.1742291834854;
        Tue, 18 Mar 2025 02:57:14 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af56ea0428fsm8588661a12.38.2025.03.18.02.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:53 +0900
Subject: [PATCH net-next 3/4] virtio_net: Use new RSS config structs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-3-344caf336ddd@daynix.com>
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

The new RSS configuration structures allow easily constructing data for
VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
for the command.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------------
 1 file changed, 43 insertions(+), 74 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d1ed544ba03a..4153a0a5f278 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -360,24 +360,7 @@ struct receive_queue {
 	struct xdp_buff **xsk_buffs;
 };
 
-/* This structure can contain rss message with maximum settings for indirection table and keysize
- * Note, that default structure that describes RSS configuration virtio_net_rss_config
- * contains same info but can't handle table values.
- * In any case, structure would be passed to virtio hw through sg_buf split by parts
- * because table sizes may be differ according to the device configuration.
- */
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
-struct virtio_net_ctrl_rss {
-	__le32 hash_types;
-	__le16 indirection_table_mask;
-	__le16 unclassified_queue;
-	__le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
-	__le16 max_tx_vq;
-	u8 hash_key_length;
-	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
-
-	__le16 *indirection_table;
-};
 
 /* Control VQ buffers: protected by the rtnl lock */
 struct control_buf {
@@ -421,7 +404,9 @@ struct virtnet_info {
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
-	struct virtio_net_ctrl_rss rss;
+	struct virtio_net_rss_config_hdr *rss_hdr;
+	struct virtio_net_rss_config_trailer rss_trailer;
+	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -523,23 +508,16 @@ enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_XSK,
 };
 
-static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
+static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
 {
-	if (!indir_table_size) {
-		rss->indirection_table = NULL;
-		return 0;
-	}
+	u16 indir_table_size = vi->has_rss ? vi->rss_indir_table_size : 1;
 
-	rss->indirection_table = kmalloc_array(indir_table_size, sizeof(u16), GFP_KERNEL);
-	if (!rss->indirection_table)
-		return -ENOMEM;
-
-	return 0;
+	return struct_size(vi->rss_hdr, indirection_table, indir_table_size);
 }
 
-static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
+static size_t virtnet_rss_trailer_size(const struct virtnet_info *vi)
 {
-	kfree(rss->indirection_table);
+	return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_key_size);
 }
 
 /* We use the last two bits of the pointer to distinguish the xmit type. */
@@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pair
 
 	for (; i < vi->rss_indir_table_size; ++i) {
 		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
-		vi->rss.indirection_table[i] = cpu_to_le16(indir_val);
+		vi->rss_hdr->indirection_table[i] = cpu_to_le16(indir_val);
 	}
-	vi->rss.max_tx_vq = cpu_to_le16(queue_pairs);
+	vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
 }
 
 static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 {
 	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
-	struct virtio_net_ctrl_rss old_rss;
+	struct virtio_net_rss_config_hdr *old_rss_hdr;
+	struct virtio_net_rss_config_trailer old_rss_trailer;
 	struct net_device *dev = vi->dev;
 	struct scatterlist sg;
 
@@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
 	 */
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
-		memcpy(&old_rss, &vi->rss, sizeof(old_rss));
-		if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size)) {
-			vi->rss.indirection_table = old_rss.indirection_table;
+		old_rss_hdr = vi->rss_hdr;
+		old_rss_trailer = vi->rss_trailer;
+		vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		if (!vi->rss_hdr) {
+			vi->rss_hdr = old_rss_hdr;
 			return -ENOMEM;
 		}
 
+		*vi->rss_hdr = *old_rss_hdr;
 		virtnet_rss_update_by_qpairs(vi, queue_pairs);
 
 		if (!virtnet_commit_rss_command(vi)) {
 			/* restore ctrl_rss if commit_rss_command failed */
-			rss_indirection_table_free(&vi->rss);
-			memcpy(&vi->rss, &old_rss, sizeof(old_rss));
+			kfree(vi->rss_hdr);
+			vi->rss_hdr = old_rss_hdr;
+			vi->rss_trailer = old_rss_trailer;
 
 			dev_warn(&dev->dev, "Fail to set num of queue pairs to %d, because committing RSS failed\n",
 				 queue_pairs);
 			return -EINVAL;
 		}
-		rss_indirection_table_free(&old_rss);
+		kfree(old_rss_hdr);
 		goto succ;
 	}
 
@@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_device *dev,
 static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 {
 	struct net_device *dev = vi->dev;
-	struct scatterlist sgs[4];
-	unsigned int sg_buf_size;
+	struct scatterlist sgs[2];
 
 	/* prepare sgs */
-	sg_init_table(sgs, 4);
-
-	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
-	sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
-
-	if (vi->has_rss) {
-		sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
-		sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
-	} else {
-		sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(uint16_t));
-	}
-
-	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
-			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
-	sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
-
-	sg_buf_size = vi->rss_key_size;
-	sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
+	sg_init_table(sgs, 2);
+	sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
+	sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_size(vi));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
@@ -4097,17 +4064,17 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
 static void virtnet_init_default_rss(struct virtnet_info *vi)
 {
-	vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_supported);
+	vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_supported);
 	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
-	vi->rss.indirection_table_mask = vi->rss_indir_table_size
+	vi->rss_hdr->indirection_table_mask = vi->rss_indir_table_size
 						? cpu_to_le16(vi->rss_indir_table_size - 1) : 0;
-	vi->rss.unclassified_queue = 0;
+	vi->rss_hdr->unclassified_queue = 0;
 
 	virtnet_rss_update_by_qpairs(vi, vi->curr_queue_pairs);
 
-	vi->rss.hash_key_length = vi->rss_key_size;
+	vi->rss_trailer.hash_key_length = vi->rss_key_size;
 
-	netdev_rss_key_fill(vi->rss.key, vi->rss_key_size);
+	netdev_rss_key_fill(vi->rss_hash_key_data, vi->rss_key_size);
 }
 
 static void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_rxnfc *info)
@@ -4218,7 +4185,7 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
 
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
-		vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
+		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		if (vi->dev->features & NETIF_F_RXHASH)
 			return virtnet_commit_rss_command(vi);
 	}
@@ -5398,11 +5365,11 @@ static int virtnet_get_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			rxfh->indir[i] = le16_to_cpu(vi->rss.indirection_table[i]);
+			rxfh->indir[i] = le16_to_cpu(vi->rss_hdr->indirection_table[i]);
 	}
 
 	if (rxfh->key)
-		memcpy(rxfh->key, vi->rss.key, vi->rss_key_size);
+		memcpy(rxfh->key, vi->rss_hash_key_data, vi->rss_key_size);
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
@@ -5426,7 +5393,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			return -EOPNOTSUPP;
 
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->rss.indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
+			vi->rss_hdr->indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
 		update = true;
 	}
 
@@ -5438,7 +5405,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		if (!vi->has_rss && !vi->has_rss_hash_report)
 			return -EOPNOTSUPP;
 
-		memcpy(vi->rss.key, rxfh->key, vi->rss_key_size);
+		memcpy(vi->rss_hash_key_data, rxfh->key, vi->rss_key_size);
 		update = true;
 	}
 
@@ -6044,9 +6011,9 @@ static int virtnet_set_features(struct net_device *dev,
 
 	if ((dev->features ^ features) & NETIF_F_RXHASH) {
 		if (features & NETIF_F_RXHASH)
-			vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
+			vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		else
-			vi->rss.hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
+			vi->rss_hdr->hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
 
 		if (!virtnet_commit_rss_command(vi))
 			return -EINVAL;
@@ -6735,9 +6702,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
 	}
-	err = rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size);
-	if (err)
+	vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	if (!vi->rss_hdr) {
+		err = -ENOMEM;
 		goto free;
+	}
 
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
@@ -7016,7 +6985,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	rss_indirection_table_free(&vi->rss);
+	kfree(vi->rss_hdr);
 
 	free_netdev(vi->dev);
 }

-- 
2.48.1

