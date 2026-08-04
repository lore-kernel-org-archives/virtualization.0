Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C62F3632
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829026; cv=none; b=gC2/Zjrrzc41TKSsoeX1otB9O9Fvgfw6fEHdemHoLL1BDBipB++IE5q/L/nOkrLk9Gda3ZQFTMnqFxN/bys4pkLAKi+ktwd3JkCueESjZAU1Nle+/Cl438ZNp3EjXlv9Z+lQkv7+bUMsVe5Osf7MgTEOuknqWlwpnqF/XZtBkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829026; c=relaxed/simple;
	bh=CbOyoYrDtV4DNVnOD/IZBNe/FGxESa2gKjw5k3UToHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqjuAurVFeIKiLTLdPGJvt0iZd7cn0aODNraEiVXhb3lv7h6as4L65YeU0Y1Kl164bPeXinKmKMjJ9DjG/58/YOXnlOKBOpFk+68HjH4OMXyRVicrWsy6QMhrqNw0uCsOq52nGH2QM3DT2gsrSHnGCkY2nPyI3ciNzDE+j7qV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 45c97d148fd711f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fd106d4a-38aa-4d86-8241-07bd762a0807,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:fd82b126bca751d90c8842ee01519f04,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 45c97d148fd711f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1858656050; Tue, 04 Aug 2026 15:36:57 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio_net: roll back RSS state on control failure
Date: Tue,  4 Aug 2026 15:36:54 +0800
Message-ID: <20260804073654.1293243-1-xiongweimin@kylinos.cn>
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

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c..ccd96315a 100644
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
+		old_rss_hdr = kmemdup(vi->rss_hdr, virtnet_rss_hdr_size(vi),
+				      GFP_KERNEL);
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

