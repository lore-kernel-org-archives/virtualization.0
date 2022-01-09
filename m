Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF58C433F5
	for <virtualization@archiver.kernel.org>; Sun,  9 Jan 2022 21:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77C5E4088D;
	Sun,  9 Jan 2022 21:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vB53JeMlSV39; Sun,  9 Jan 2022 21:07:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4E20402D4;
	Sun,  9 Jan 2022 21:07:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6AF9C0030;
	Sun,  9 Jan 2022 21:07:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6F19C0030
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A515B60BF4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kW6bOHgzb97d
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBF6760BBB
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:20 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id d3so11145570lfv.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gPMwCL078ECJkrlQTrRDDMNXwBo1Y+lA8nTpGMji1Wg=;
 b=jxWccFhpO5rk3jHyiLzmvF/kyhq/XU78LlunysVItkpbWP+nNSO2rgRGekjjqsuWpv
 9BEcOCD0MdXnHrglMH+zDrU9LTjpcTvYCYhg3LBhRZgZxpgQE1/oRgkdjzXwFYXCyqRS
 fdsAKd59ou0LUqZNzK1+7hdpgbZmuOADY6Xziy7yWtdtcBKsiME4F3f6NdyEmjznmOIB
 jELoyra4mxTsQk69kfLiEUI0hpxImfazWWTWQugLqLoXHlLhQ6DFqe7OMjvUmwU+Zs35
 FKHTmf7sGZigM73fDkyzukEeGaGndMscOyP7Vrhyc0+Y20+Wt7+tIkpbCtm08dFz4S1V
 yleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gPMwCL078ECJkrlQTrRDDMNXwBo1Y+lA8nTpGMji1Wg=;
 b=c2Cp5ohja7gE1PRoB33C3Zvv/u7zEWhmRi+zbbM5AWyXTA3nJE4X7Zqh5M4JHal6Aa
 O/T5T4bgDteHPym8FmuTfTWQkdVsOhbWVqdaMoH7A5aLFbV9jbHIMNhG18ZZxzofTDxB
 RWCwpF9juCPHEYmnNWT71SfAu4lbfCd/tVbOPcYRc98EdT1Y7fx5AYjfiWaXXaVj4xaN
 ncb4kQK1G50Hr0xiIm89SKgGpVzZjvssBV2QKGUwfhZ0/0Qs94YQSS2/2uwYwF8yhj2p
 Is1JzwXqceYdVBKAuUtoGf+dplnkd2CWE8Zy7qIIfxYDIhswMieKY9cMofUkaNfSoe00
 7fPQ==
X-Gm-Message-State: AOAM5315tllHlKsz4DL4VLZYAK8NmYpX0XVxHUNCJK7Ubn203OBAy+x9
 yzl4th15X8pKttVTKfFnP16ozQ==
X-Google-Smtp-Source: ABdhPJzkLZ3kLE4tJ7kFEzPFPXa4NfnIE1rfj++1VSELHsF9723jYLQDF2/21JeeE3d2RoZJNYR1yQ==
X-Received: by 2002:a2e:5d1:: with SMTP id 200mr56438738ljf.272.1641762438526; 
 Sun, 09 Jan 2022 13:07:18 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id p17sm766129lfu.233.2022.01.09.13.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jan 2022 13:07:17 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH 3/4] drivers/net/virtio_net: Added RSS hash report.
Date: Sun,  9 Jan 2022 23:06:58 +0200
Message-Id: <20220109210659.2866740-4-andrew@daynix.com>
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

Added features for RSS hash report.
If hash is provided - it sets to skb.
Added checks if rss and/or hash are enabled together.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 21794731fc75..6e7461b01f87 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -231,6 +231,7 @@ struct virtnet_info {
 
 	/* Host supports rss and/or hash report */
 	bool has_rss;
+	bool has_rss_hash_report;
 	u8 rss_key_size;
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
@@ -424,7 +425,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	hdr_p = p;
 
 	hdr_len = vi->hdr_len;
-	if (vi->mergeable_rx_bufs)
+	if (vi->has_rss_hash_report)
+		hdr_padded_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (vi->mergeable_rx_bufs)
 		hdr_padded_len = sizeof(*hdr);
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
@@ -1160,6 +1163,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+	enum pkt_hash_types rss_hash_type;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -1186,6 +1191,29 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 
 	hdr = skb_vnet_hdr(skb);
+	if (dev->features & NETIF_F_RXHASH) {
+		hdr_hash = (struct virtio_net_hdr_v1_hash *)(hdr);
+
+		switch (hdr_hash->hash_report) {
+		case VIRTIO_NET_HASH_REPORT_TCPv4:
+		case VIRTIO_NET_HASH_REPORT_UDPv4:
+		case VIRTIO_NET_HASH_REPORT_TCPv6:
+		case VIRTIO_NET_HASH_REPORT_UDPv6:
+		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+			rss_hash_type = PKT_HASH_TYPE_L4;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv4:
+		case VIRTIO_NET_HASH_REPORT_IPv6:
+		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+			rss_hash_type = PKT_HASH_TYPE_L3;
+			break;
+		case VIRTIO_NET_HASH_REPORT_NONE:
+		default:
+			rss_hash_type = PKT_HASH_TYPE_NONE;
+		}
+		skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
+	}
 
 	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -2233,7 +2261,8 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
-				  VIRTIO_NET_CTRL_MQ_RSS_CONFIG, sgs)) {
+				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
+				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
 		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
 		return false;
 	}
@@ -3220,7 +3249,9 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_MQ, "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
-	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_RSS, "VIRTIO_NET_F_RSS"))) {
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_RSS, "VIRTIO_NET_F_RSS") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
+			     "VIRTIO_NET_F_HASH_REPORT"))) {
 		return false;
 	}
 
@@ -3355,6 +3386,12 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi->mergeable_rx_bufs = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
+		vi->has_rss_hash_report = true;
+		vi->rss_indir_table_size = 1;
+		vi->rss_key_size = VIRTIO_NET_RSS_MAX_KEY_SIZE;
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 		vi->rss_indir_table_size =
@@ -3364,7 +3401,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 	}
 
-	if (vi->has_rss) {
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_hash_types_supported =
 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
 		vi->rss_hash_types_supported &=
@@ -3374,8 +3411,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		dev->hw_features |= NETIF_F_RXHASH;
 	}
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
-	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+
+	if (vi->has_rss_hash_report)
+		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
+		 virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
 	else
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
@@ -3442,7 +3482,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
-	if (vi->has_rss) {
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		rtnl_lock();
 		virtnet_init_default_rss(vi);
 		rtnl_unlock();
@@ -3580,7 +3620,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_RSS
+	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
