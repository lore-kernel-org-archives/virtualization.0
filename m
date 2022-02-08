Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76545C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 18:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26040409E3;
	Tue,  8 Feb 2022 18:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HxpxjpPCAWCQ; Tue,  8 Feb 2022 18:15:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 82E2E403C1;
	Tue,  8 Feb 2022 18:15:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DE7DC0070;
	Tue,  8 Feb 2022 18:15:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A88A1C001A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 987ED813EF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zScsbylOwW9k
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB10C8258A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:49 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id t14so65683ljh.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+37NPEyVD8WMNDuKr+VUpr12blnHBAWksfV9NWdACbw=;
 b=zwnHJGSXcjyPdbLznzXmWvMRa3UWKL5LIZ5Hgobr6ylhWMO+pojrCi+9nahhBazm7b
 CHoqYDO5Nn7LxS9eTBQOyfaCRNDzgOEOePJOFMsh/qWI/hLz736UCQw1LO//91wQoWq+
 4wQ+7jZJWFFZvyJz6a/2pu9MJcBmuoXpdu8Y2KMpuz/IThti9omsfsMlR3INKZmKwr5X
 xcS1BhLqtfXCzrSE2y83j3awjh33Rxm2yOUu9hWzkW9WKy4AhugE/W8yyQAWGGEkCYwu
 o0vMGodNEtf87qq6mvKgzkQaRnihng8EU7H6BQhPJEebfLWlOgKuQB4aHrbmAAD7vLQP
 fhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+37NPEyVD8WMNDuKr+VUpr12blnHBAWksfV9NWdACbw=;
 b=qfV5+6o54DRp8bYtFzeIIx7d29T8ZDhkmOYLN3IBfRr2pWfdkKYN8fBm6+58mj7RPK
 R23/MjAkrmVzysGIu/PRLT2lLxuK7YgI50M/1s46+WqiwOfgRehh8M20//YzWmSfBB+y
 Y/atnwo9eUMdiJopbS/JP82nBrgah2OBMJdtipQ2R3MsvyeH2ldbapxfCpdPZsG6c+Am
 RN990TBXyvFrAdrRGuqDcTBNDh0t9XYmloCQ6DnNmntsRavv+10Ekpw1HdVCH3L4VKGn
 GmYoehWJwcjml5pHrTKni4mUWp2TBFOFjBfmLycJpSYKZs6fl4NmKd2Ur8G0OUpQMROT
 UNSg==
X-Gm-Message-State: AOAM533hzJ6lpYAZwt+0EKslKRr+20g1PZdj5DbsOY6u0ntXrOjqd1CU
 WvgayHSmkqfBioEnN8CTyQGU6A==
X-Google-Smtp-Source: ABdhPJzyvVblRx20Nb0+M4lqiiWcQd4FDHTeMZG0p9O+KGIhqGeTVjXci+jjWxMcGrDkXaytMx+gUw==
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr3602861ljn.176.1644344147317; 
 Tue, 08 Feb 2022 10:15:47 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id p16sm2125082ljc.86.2022.02.08.10.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 10:15:46 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v3 4/4] drivers/net/virtio_net: Added RSS hash report control.
Date: Tue,  8 Feb 2022 20:15:10 +0200
Message-Id: <20220208181510.787069-5-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208181510.787069-1-andrew@daynix.com>
References: <20220208181510.787069-1-andrew@daynix.com>
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

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 141 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 543da2fbdd2d..88759d5e693c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -231,6 +231,7 @@ struct virtnet_info {
 	u8 rss_key_size;
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
+	u32 rss_hash_types_saved;
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -2272,6 +2273,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
 	int i = 0;
 
 	vi->ctrl->rss.hash_types = vi->rss_hash_types_supported;
+	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
 	vi->ctrl->rss.indirection_table_mask = vi->rss_indir_table_size - 1;
 	vi->ctrl->rss.unclassified_queue = 0;
 
@@ -2286,6 +2288,121 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
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
@@ -2571,6 +2688,27 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
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
@@ -2599,6 +2737,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh = virtnet_get_rxfh,
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxnfc = virtnet_get_rxnfc,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_freeze_down(struct virtio_device *vdev)
@@ -2853,7 +2992,7 @@ static int virtnet_set_features(struct net_device *dev,
 
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
