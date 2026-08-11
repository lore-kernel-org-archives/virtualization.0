Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1E23EAB4
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414865; cv=none; b=QqCfI7feD942NPiwH9bvaMYBll0IPc5fPU5JfP/wIM6Cwo6lzbXQyttyt9HYkbTPaX0bxjJuJ9RFx4xDapgWPVL35vYjM1FzqtRQW1Y/DW4v5tRosY7QoKwYVcMLehvddfzEG6fSC7nKwdqYBtwFo1dSHn4ZH4QYwE9BYGBk6Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414865; c=relaxed/simple;
	bh=GiliA1fw/32zbqx2m8wbpDyHZ7nIcgOGzHDhTxyC6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHrCcbjxSApAawmGU7PkH0MaOHRypdLAitpe/UgDpVH09YUrEF51Qxkl7tQyW64da95J59/sObyuW72qdJRTyQmpgbXiQOxV3CRPHlPtJfy7PJxbpZzTT36xahoGDbvLub+lsd/uEIdj58PU8Rs4cAD4yTzNYsZeo1W+CfuF26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 49e31f8c952b11f1aa26b74ffac11d73-20260811
X-CID-CACHE: Type:Local,Time:202608111019+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fdc6256d-c5e7-40b6-85ff-6c0b9176d201,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:fa4d02fda70af90fa5aa4847e10bba74,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 49e31f8c952b11f1aa26b74ffac11d73-20260811
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 819321497; Tue, 11 Aug 2026 10:20:58 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: mst@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	jasowang@redhat.com,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio_net: roll back RSS state on control failure
Date: Tue, 11 Aug 2026 10:20:55 +0800
Message-ID: <20260811022055.3465420-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool RSS and RXHASH paths update the driver's cached RSS state
before committing the change to the device.  If the control virtqueue
command fails, the cached hash types, key or indirection table can then
report a configuration that the device did not accept.

Preserve the previous local state around RSS/hash control commands and
restore it when the device update fails, while propagating the error to
the caller.

v1 -> v2:
  - Use kvmemdup() instead of kmemdup() in virtnet_set_rxfh() for the
    saved RSS header, since the indirection table can push the header
    size up to ~128K.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c..995ca4640 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4295,6 +4295,7 @@ static int virtnet_set_hashflow(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	u32 old_hashtypes = vi->rss_hash_types_saved;
 	u32 new_hashtypes = vi->rss_hash_types_saved;
 	bool is_disable = info->data & RXH_DISCARD;
 	bool is_l4 = info->data == (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3);
@@ -4350,9 +4351,13 @@ static int virtnet_set_hashflow(struct net_device *dev,
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
 		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
-		if (vi->dev->features & NETIF_F_RXHASH)
-			if (!virtnet_commit_rss_command(vi))
+		if (vi->dev->features & NETIF_F_RXHASH) {
+			if (!virtnet_commit_rss_command(vi)) {
+				vi->rss_hash_types_saved = old_hashtypes;
+				vi->rss_hdr->hash_types = cpu_to_le32(old_hashtypes);
 				return -EINVAL;
+			}
+		}
 	}
 
 	return 0;
@@ -5546,6 +5551,8 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtio_net_rss_config_hdr *old_rss_hdr = NULL;
+	u8 old_rss_key[NETDEV_RSS_KEY_LEN];
 	bool update = false;
 	int i;
 
@@ -5553,14 +5560,8 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if (rxfh->indir) {
-		if (!vi->has_rss)
-			return -EOPNOTSUPP;
-
-		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->rss_hdr->indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
-		update = true;
-	}
+	if (rxfh->indir && !vi->has_rss)
+		return -EOPNOTSUPP;
 
 	if (rxfh->key) {
 		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
@@ -5569,13 +5570,36 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		 */
 		if (!vi->has_rss && !vi->has_rss_hash_report)
 			return -EOPNOTSUPP;
+	}
+
+	if (rxfh->indir) {
+		old_rss_hdr = kvmemdup(vi->rss_hdr, virtnet_rss_hdr_size(vi),
+				       GFP_KERNEL);
+		if (!old_rss_hdr)
+			return -ENOMEM;
+
+		for (i = 0; i < vi->rss_indir_table_size; ++i)
+			vi->rss_hdr->indirection_table[i] =
+				cpu_to_le16(rxfh->indir[i]);
+		update = true;
+	}
 
+	if (rxfh->key) {
+		memcpy(old_rss_key, vi->rss_hash_key_data, vi->rss_key_size);
 		memcpy(vi->rss_hash_key_data, rxfh->key, vi->rss_key_size);
 		update = true;
 	}
 
-	if (update)
-		virtnet_commit_rss_command(vi);
+	if (update && !virtnet_commit_rss_command(vi)) {
+		if (old_rss_hdr)
+			memcpy(vi->rss_hdr, old_rss_hdr, virtnet_rss_hdr_size(vi));
+		if (rxfh->key)
+			memcpy(vi->rss_hash_key_data, old_rss_key, vi->rss_key_size);
+		kfree(old_rss_hdr);
+		return -EINVAL;
+	}
+
+	kfree(old_rss_hdr);
 
 	return 0;
 }
@@ -6171,13 +6195,17 @@ static int virtnet_set_features(struct net_device *dev,
 	}
 
 	if ((dev->features ^ features) & NETIF_F_RXHASH) {
+		__le32 hash_types = vi->rss_hdr->hash_types;
+
 		if (features & NETIF_F_RXHASH)
 			vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		else
 			vi->rss_hdr->hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
 
-		if (!virtnet_commit_rss_command(vi))
+		if (!virtnet_commit_rss_command(vi)) {
+			vi->rss_hdr->hash_types = hash_types;
 			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.43.0
