Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E8BC433EF
	for <virtualization@archiver.kernel.org>; Sun,  9 Jan 2022 21:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA0B182433;
	Sun,  9 Jan 2022 21:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v7YEtM7nD5Re; Sun,  9 Jan 2022 21:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1239D82422;
	Sun,  9 Jan 2022 21:07:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC7A8C0030;
	Sun,  9 Jan 2022 21:07:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63C3CC001E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 377DC60BFD
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZI6sR8H2nXd
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 890B160BF3
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id g11so37523066lfu.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FP2HV+KB9S2snMgVXESVBDFeX2fn1V4rp/jz+fcXOVc=;
 b=dLABM+LnIWptARKU4HIg3R4viKD91mq4dzwmMwGvXrbqA3OmUjU7Mbd4GhxPS7Akq4
 T0NblkNwn0poZnnDQ1wGZA5+dWq/KUs89JMpvrn1FvsV23FTZUyC2GILxp9dicG2tPz0
 LcAIp53ZTj1kSmuDqrJ6lwci7XPaOoEOOY6mqT7hxdvPiigh7O5c6zrQfn3PQE8hrUGj
 o76LrrofZxhlVe5+F7MJbqmYO9zpKDKn+/YjSKvjzMJkG0WbF/+HZSG6xygfkQWcKWhY
 7XxTbmdzbH461TYvKjrY5qAo+/B85Mc2GmlHZbL0OiSm2nCRWNdiA8k7X88JnobcuTyi
 3+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FP2HV+KB9S2snMgVXESVBDFeX2fn1V4rp/jz+fcXOVc=;
 b=E08/6Qmvqno0ud3ykePDrP/U1t1C3xoQGNcKvxH6vv6PrAtVStWf9BLKVBOLNRiKS3
 uq1XXMZQZPkoEWjGrB3fP74iy1O6XI+FNRuJOGg/3Pb7X2YC8qoD4ZnPJa5/Itm+ZJdL
 UdFE17wfMoGQo0ulw/hrMh/UFwSBwZCy2dyeHAp0CcPZjIpUKvVWDFJC3yPLBv6dnX7t
 0pysxaqtO2qScuj0rrUBdE1Kj5jw2dE1l2Xbtqv7wbNMHi5j3vnAu63O9GUCse0DMoX1
 6k+fe040LY2VPLIl5vVJ7d57EWIohoe+JY4aW6EBPgNW4yAbv4oQxSlZ6kREjOk4ccKF
 8sJA==
X-Gm-Message-State: AOAM5327H1Uz2pLOGIkYw4kOoT4WrA9X2Wrignufc8Hn5Rg+q0c5wx7j
 naj31WueuQXg+iNVsxEvhwDNKg==
X-Google-Smtp-Source: ABdhPJxFZAP8N5kCFdbxXfhRLVT0qaqLJZf7SKzRTUkgwUUByj41Xjj78polbwvu1TkMIH49DWPtvw==
X-Received: by 2002:a2e:a230:: with SMTP id i16mr49431274ljm.494.1641762439527; 
 Sun, 09 Jan 2022 13:07:19 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id p17sm766129lfu.233.2022.01.09.13.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jan 2022 13:07:19 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH 4/4] drivers/net/virtio_net: Added RSS hash report control.
Date: Sun,  9 Jan 2022 23:06:59 +0200
Message-Id: <20220109210659.2866740-5-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220109210659.2866740-1-andrew@daynix.com>
References: <20220109210659.2866740-1-andrew@daynix.com>
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
Also added hashflow set/get callbacks.
Also, disabling RXH_IP_SRC/DST for TCP would disable then for UDP.
TCP and UDP supports only:
ethtool -U eth0 rx-flow-hash tcp4 sd
    RXH_IP_SRC + RXH_IP_DST
ethtool -U eth0 rx-flow-hash tcp4 sdfn
    RXH_IP_SRC + RXH_IP_DST + RXH_L4_B_0_1 + RXH_L4_B_2_3

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 159 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6e7461b01f87..1b8dd384483c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -235,6 +235,7 @@ struct virtnet_info {
 	u8 rss_key_size;
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
+	u32 rss_hash_types_saved;
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -2275,6 +2276,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
 	int i = 0;
 
 	vi->ctrl->rss.table_info.hash_types = vi->rss_hash_types_supported;
+	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
 	vi->ctrl->rss.table_info.indirection_table_mask = vi->rss_indir_table_size - 1;
 	vi->ctrl->rss.table_info.unclassified_queue = 0;
 
@@ -2289,6 +2291,131 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
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
+		if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
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
+	u64 is_iphash = info->data & (RXH_IP_SRC | RXH_IP_DST);
+	u64 is_porthash = info->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3);
+	u32 new_hashtypes = vi->rss_hash_types_saved;
+
+	if ((is_iphash && (is_iphash != (RXH_IP_SRC | RXH_IP_DST))) ||
+	    (is_porthash && (is_porthash != (RXH_L4_B_0_1 | RXH_L4_B_2_3)))) {
+		return false;
+	}
+
+	if (!is_iphash && is_porthash)
+		return false;
+
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case IPV4_FLOW:
+		new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv4;
+		if (is_iphash)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4;
+
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case IPV6_FLOW:
+		new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv6;
+		if (is_iphash)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6;
+
+		break;
+	default:
+		break;
+	}
+
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+		new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_TCPv4;
+		if (is_porthash)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_TCPv4;
+
+		break;
+	case UDP_V4_FLOW:
+		new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_UDPv4;
+		if (is_porthash)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_UDPv4;
+
+		break;
+	case TCP_V6_FLOW:
+		new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
+		if (is_porthash)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
+
+		break;
+	case UDP_V6_FLOW:
+		new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
+		if (is_porthash)
+			new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
+
+		break;
+	default:
+		break;
+	}
+
+	if (new_hashtypes != vi->rss_hash_types_saved) {
+		vi->rss_hash_types_saved = new_hashtypes;
+		vi->ctrl->rss.table_info.hash_types = vi->rss_hash_types_saved;
+		if (vi->dev->features & NETIF_F_RXHASH)
+			return virtnet_commit_rss_command(vi);
+	}
+
+	return true;
+}
 
 static void virtnet_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
@@ -2574,6 +2701,27 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
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
@@ -2602,6 +2750,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh = virtnet_get_rxfh,
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxnfc = virtnet_get_rxnfc,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_freeze_down(struct virtio_device *vdev)
@@ -2854,6 +3003,16 @@ static int virtnet_set_features(struct net_device *dev,
 		vi->guest_offloads = offloads;
 	}
 
+	if ((dev->features ^ features) & NETIF_F_RXHASH) {
+		if (features & NETIF_F_RXHASH)
+			vi->ctrl->rss.table_info.hash_types = vi->rss_hash_types_saved;
+		else
+			vi->ctrl->rss.table_info.hash_types = 0;
+
+		if (!virtnet_commit_rss_command(vi))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
