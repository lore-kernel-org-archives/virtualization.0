Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AF5C433FE
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 12:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 506F0409D3;
	Tue, 22 Feb 2022 12:01:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id URNqhw2ySZcq; Tue, 22 Feb 2022 12:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C0E5409DE;
	Tue, 22 Feb 2022 12:01:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6ECA7C007B;
	Tue, 22 Feb 2022 12:01:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B4D4C0079
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B2F360B08
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Np7xaskVLIh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7AB4B60EB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:37 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id y24so11914904lfg.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hz5CwWPpww2mgl2jAzZIrlUR/pgW56HDjUzMdL+mmdo=;
 b=Md849rszVg1C1RHhHOtVxzGPjafgabCmE/pGKyISdWKKpdQ7jG2sWljz8ZzuRx+YEH
 rY358eUwhjmspP23FafiK3m06a+o65FstXPOrBhSLAKuhtU1Gkfwum4/ZZxT9u4amJe4
 R3al/ElZX99g+vZC92EUFUU3xWr9+XzjXASEHYqegsdQ6PsYP8f9ve16mdZD4bRDHL/q
 9Igwh8AIOCAZ1Fixl9bXVPpNypZIYeSq2VBhc52P0Ctlw6fmGqCrZXhjhCqupX7r/FpO
 w+l7P122wH4go1LPCel8QrIkbZYiVFF9hnYM1F9uTraC+FUSWNsaeFjjlZdHTLHJKuTp
 +g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hz5CwWPpww2mgl2jAzZIrlUR/pgW56HDjUzMdL+mmdo=;
 b=2x3HAxtYdk+Qp9e1vvSlFKzUdCDTA9UPRPmkPCeQ68MyusodgRO7ceaJpCV0Bxj7Nz
 GvVm1qI9xyInBiy60ZPWYaXYJYt2vqDDutATmNg/qwV2IplTH9xs+sYTcNvLBNd+CkHV
 cE4sNzfByrCBPVM609pHExoESnI/3wGYixrnZF7sqMQPOojLrwKpIAPTBO7QJbvdvHxr
 2VR3J+L5AqEbKqXNfrnJhgpFyeG8mekdKyQm/mYJVFnfKZJ/MRdVU0czYeJBuALJhpxS
 4zQNCz9LlRbi0xdMLZzw2VXWYgJeCk5YE/RCfP7jl2w2ZGCalzDA4ZfrBJ9rjgSX6odK
 lgGg==
X-Gm-Message-State: AOAM532LOBxrhU1BczuxcKh03kv+waBe2+1ybCC0T929/vybbHGJYkqX
 rO+0xEZglGO5g28r9t1lpnB5rQ==
X-Google-Smtp-Source: ABdhPJxdAj9p21StHiigmc9Jc3tOG5Kxrktxj6NBps6eqvpJ5SOEEDGtPYzB29bQdsA9OuxrFm3uSg==
X-Received: by 2002:a05:6512:3b0f:b0:42d:1ebb:dcbf with SMTP id
 f15-20020a0565123b0f00b0042d1ebbdcbfmr16670378lfv.275.1645531295462; 
 Tue, 22 Feb 2022 04:01:35 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id v29sm1664024ljv.72.2022.02.22.04.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 04:01:35 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v4 4/4] drivers/net/virtio_net: Added RSS hash report control.
Date: Tue, 22 Feb 2022 14:00:54 +0200
Message-Id: <20220222120054.400208-5-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222120054.400208-1-andrew@daynix.com>
References: <20220222120054.400208-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Now it's possible to control supported hashflows.
Added hashflow set/get callbacks.
Also, disabling RXH_IP_SRC/DST for TCP would disable then for UDP.
TCP and UDP supports only:
ethtool -U eth0 rx-flow-hash tcp4 sd
    RXH_IP_SRC + RXH_IP_DST
ethtool -U eth0 rx-flow-hash tcp4 sdfn
    RXH_IP_SRC + RXH_IP_DST + RXH_L4_B_0_1 + RXH_L4_B_2_3
Disabling happens because VirtioNET hashtype for IP doesn't check L4 proto,
it works for all IP packets(TCP, UDP, ICMP, etc.).
For TCP and UDP, it's possible to set IP+PORT hashes.
But disabling IP hashes will disable them for TCP and UDP simultaneously.
It's possible to set IP+PORT for TCP/UDP and disable/enable IP
for everything else(UDP, ICMP, etc.).

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 141 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8b317b3ef5aa..83f9a36a5efb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -231,6 +231,7 @@ struct virtnet_info {
 	u8 rss_key_size;
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
+	u32 rss_hash_types_saved;
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -2278,6 +2279,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
 	int i = 0;
 
 	vi->ctrl->rss.hash_types = vi->rss_hash_types_supported;
+	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
 	vi->ctrl->rss.indirection_table_mask = vi->rss_indir_table_size
 						? vi->rss_indir_table_size - 1 : 0;
 	vi->ctrl->rss.unclassified_queue = 0;
@@ -2293,6 +2295,121 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
 	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
 }
 
+static void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_rxnfc *info)
+{
+	info->data = 0;
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+		if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_TCPv4) {
+			info->data = RXH_IP_SRC | RXH_IP_DST |
+						 RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		} else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		}
+		break;
+	case TCP_V6_FLOW:
+		if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_TCPv6) {
+			info->data = RXH_IP_SRC | RXH_IP_DST |
+						 RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		} else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv6) {
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		}
+		break;
+	case UDP_V4_FLOW:
+		if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_UDPv4) {
+			info->data = RXH_IP_SRC | RXH_IP_DST |
+						 RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		} else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		}
+		break;
+	case UDP_V6_FLOW:
+		if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_UDPv6) {
+			info->data = RXH_IP_SRC | RXH_IP_DST |
+						 RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		} else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv6) {
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		}
+		break;
+	case IPV4_FLOW:
+		if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+
+		break;
+	case IPV6_FLOW:
+		if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+
+		break;
+	default:
+		info->data = 0;
+		break;
+	}
+}
+
+static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *info)
+{
+	u32 new_hashtypes = vi->rss_hash_types_saved;
+	bool is_disable = info->data & RXH_DISCARD;
+	bool is_l4 = info->data == (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3);
+
+	/* supports only 'sd', 'sdfn' and 'r' */
+	if (!((info->data == (RXH_IP_SRC | RXH_IP_DST)) | is_l4 | is_disable))
+		return false;
+
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+		new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv4 | VIRTIO_NET_RSS_HASH_TYPE_TCPv4);
+		if (!is_disable)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4
+				| (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_TCPv4 : 0);
+		break;
+	case UDP_V4_FLOW:
+		new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv4 | VIRTIO_NET_RSS_HASH_TYPE_UDPv4);
+		if (!is_disable)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4
+				| (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_UDPv4 : 0);
+		break;
+	case IPV4_FLOW:
+		new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv4;
+		if (!is_disable)
+			new_hashtypes = VIRTIO_NET_RSS_HASH_TYPE_IPv4;
+		break;
+	case TCP_V6_FLOW:
+		new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv6 | VIRTIO_NET_RSS_HASH_TYPE_TCPv6);
+		if (!is_disable)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6
+				| (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_TCPv6 : 0);
+		break;
+	case UDP_V6_FLOW:
+		new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv6 | VIRTIO_NET_RSS_HASH_TYPE_UDPv6);
+		if (!is_disable)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6
+				| (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_UDPv6 : 0);
+		break;
+	case IPV6_FLOW:
+		new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv6;
+		if (!is_disable)
+			new_hashtypes = VIRTIO_NET_RSS_HASH_TYPE_IPv6;
+		break;
+	default:
+		/* unsupported flow */
+		return false;
+	}
+
+	/* if unsupported hashtype was set */
+	if (new_hashtypes != (new_hashtypes & vi->rss_hash_types_supported))
+		return false;
+
+	if (new_hashtypes != vi->rss_hash_types_saved) {
+		vi->rss_hash_types_saved = new_hashtypes;
+		vi->ctrl->rss.hash_types = vi->rss_hash_types_saved;
+		if (vi->dev->features & NETIF_F_RXHASH)
+			return virtnet_commit_rss_command(vi);
+	}
+
+	return true;
+}
 
 static void virtnet_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
@@ -2578,6 +2695,27 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	switch (info->cmd) {
 	case ETHTOOL_GRXRINGS:
 		info->data = vi->curr_queue_pairs;
+		break;
+	case ETHTOOL_GRXFH:
+		virtnet_get_hashflow(vi, info);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
+static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc = 0;
+
+	switch (info->cmd) {
+	case ETHTOOL_SRXFH:
+		if (!virtnet_set_hashflow(vi, info))
+			rc = -EINVAL;
+
 		break;
 	default:
 		rc = -EOPNOTSUPP;
@@ -2606,6 +2744,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh = virtnet_get_rxfh,
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxnfc = virtnet_get_rxnfc,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_freeze_down(struct virtio_device *vdev)
@@ -2860,7 +2999,7 @@ static int virtnet_set_features(struct net_device *dev,
 
 	if ((dev->features ^ features) & NETIF_F_RXHASH) {
 		if (features & NETIF_F_RXHASH)
-			vi->ctrl->rss.hash_types = vi->rss_hash_types_supported;
+			vi->ctrl->rss.hash_types = vi->rss_hash_types_saved;
 		else
 			vi->ctrl->rss.hash_types = VIRTIO_NET_HASH_REPORT_NONE;
 
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
