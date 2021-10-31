Return-Path: <SRS0=Mk6X=PT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B93EC433F5
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 05:00:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C0F60F02
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 05:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91C0F60F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DCDD94019A;
	Sun, 31 Oct 2021 05:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUCGUC4BOYap; Sun, 31 Oct 2021 05:00:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 09ACD40106;
	Sun, 31 Oct 2021 05:00:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB620C0019;
	Sun, 31 Oct 2021 05:00:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A85EBC0021
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9653980CFD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P8M0uDaC6mX5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64A9E80CF8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:14 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id u21so29616397lff.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 30 Oct 2021 22:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P85tINO6/x7BoGgJyTZxyTXKyP4RCHrmV1AQKxfeWJE=;
 b=K3GsKwdH/8LPW8YvS2ThbBMjgIpc/wfSPG9So9Q4zUu0FU+hfJJOhK1NNbsVHmyi5o
 caJNoRHkf0TmBl69GASb4UQWBvcpV7xjQUuB00m0dXNn20DIofK3IlhAFFsM9wmRbgjn
 sox3xNvSnqdRk4/O2/EGNoAbRJwaHII35SDF59vigu8C7LPQOuRf6v9FA9itxOnH77IA
 /lp3dabdM/IGyrPUqISmTCkDUPA6Yamg/SFwShMuovNA4tsx7abmIYZ9NNNyhvAnSLRu
 d3w0oPC7G2eIa8Q83Ka9jXzpwOR/QCB0tQoEhmuO88sNcn2axbHUb6z4y32V5s2KSEgn
 WnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P85tINO6/x7BoGgJyTZxyTXKyP4RCHrmV1AQKxfeWJE=;
 b=1+JG8Y5ku9/P2dXmZQeZG/knQNMySUaa9X+rD2FI3bYe8KwJU60ARhX7ta4K/ZtW5x
 l1uejQ58BefOjiPhmpNSs10sdvJ7WbZ+Ygb698LG2R8Op+4TcS5eYvUxv1theMCQ4IsL
 yGt+YE53/R0BysRnNn11nXeS3UkqSFe/vh+xjy3SMm6OyGVQUCcCPTALIuRT87/WkCK5
 oP1roOLxMkQafsVCZRVjZMZEYOUvMC51fR+LgjpobEBgJGzzb86truOieDfEJMGC5uUl
 +9kEq7WQgi6zET8RteAgvx+xmBUHH0dULFhcrx+f3CjMKdvgQFEzyfrs7aQpSkDhWn3Z
 jxKQ==
X-Gm-Message-State: AOAM5325IohHlDJfmc21frWQLBohpbAD5jiYvTL0PccDN14l+VRnB9Dx
 v6kHgYsmNf4p9jlj72o+w9geGw==
X-Google-Smtp-Source: ABdhPJy4OWZQTeD5aF2yM3mtFrNa3B26deIualH1okDZv1ZHqVGOWFX7pGvlZQuveOHqVFaEGSlQhA==
X-Received: by 2002:a05:6512:31d2:: with SMTP id
 j18mr197221lfe.229.1635656411408; 
 Sat, 30 Oct 2021 22:00:11 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id v26sm444766lfo.125.2021.10.30.22.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Oct 2021 22:00:11 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org
Subject: [RFC PATCH 4/4] drivers/net/virtio_net: Added RSS hash report control.
Date: Sun, 31 Oct 2021 06:59:59 +0200
Message-Id: <20211031045959.143001-5-andrew@daynix.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211031045959.143001-1-andrew@daynix.com>
References: <20211031045959.143001-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, netdev@vger.kernel.org, yuri.benditovich@daynix.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Added set_hash for skb.
Also added hashflow set/get callbacks.
Virtio RSS "IPv6 extensions" hashes disabled.
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
index cff7340f40bb..b1ed373d942b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -232,6 +232,8 @@ struct virtnet_info {
 	bool has_rss_hash_report;
 	u8 rss_key_size;
 	u16 rss_indir_table_size;
+	u32 rss_hash_types_supported;
+	u32 rss_hash_types_saved;
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -2272,6 +2274,131 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
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
@@ -2557,6 +2684,27 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
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
@@ -2585,6 +2733,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh = virtnet_get_rxfh,
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxnfc = virtnet_get_rxnfc,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_freeze_down(struct virtio_device *vdev)
@@ -2837,6 +2986,16 @@ static int virtnet_set_features(struct net_device *dev,
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
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
