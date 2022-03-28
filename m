Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4EEC4332F
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 18:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A62DE40A9B;
	Mon, 28 Mar 2022 18:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTsuDdYawCSS; Mon, 28 Mar 2022 18:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E04A940A93;
	Mon, 28 Mar 2022 18:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9CE4C001D;
	Mon, 28 Mar 2022 18:01:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 713C9C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D03DB60ABB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMZEPJ6jdZ6O
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04EDC60B20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:45 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id h11so20301944ljb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ebBwZz+tPMFcNWlsXOiLh/rBq0m4vokTaCikxzbWZ+I=;
 b=X5IbPxKrawXidzt0MnlIlNI+6UIZPt+h4/uLtZpoPcDRK3/mblcLBLtig7VDNFv0qW
 d1AWci999VtlSKMSQLLwwJPMAvmK9T4JEgkOv6Rs3uZCQwL6RHdHArZvM8LuJveaYnX8
 XUeNnDbCi81y3FNC5HeeoJtIayhklwbXAUwtWbB/IA18+l/LQmDYqmh1REMnVeridmMw
 ZEM/vVUNoRlYR/XGP0JaB9AcwpoYqILQLe2TW6qAHlG8fplf4fjMlq1l/eMgJyz7KjYO
 0lFhtW32UBhAZFXejxggIipsUsubUwWhBEOwL8UJ/mYR9nC0o0YqdZqUcR/NlirC9pAq
 uNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ebBwZz+tPMFcNWlsXOiLh/rBq0m4vokTaCikxzbWZ+I=;
 b=iE8bO3yHI7K/+KqPbvN+LO/Uiqx4N+I4P/nMJ2YYyxoAOhorbx+t3KEZaJgyDw0a1s
 UDEvpeLpx855FgYXYMhNaYZz0n86JHHU9efyK2DiMokC9fmvmAxRuUAo2KC200h8hi4e
 pJVHrKOjELjmSv//TAqhsnAXc2dbe32HcENvBURMujdBZL0bnOTix2CH7X+3PqgzbYck
 k/gLeLEAczS2+yC/XL2e5c937N8WdqALrQkzi/cNp8VvKqtsIzABhP1DaIpmcW9w6FdD
 fyJTyph4Uw/h1qnPm3FsNmNQMzWn3I53Qz371alUJmOdlhZn9UH1jYge5N+ziYsULovo
 vrlg==
X-Gm-Message-State: AOAM532ZmVqEczRj8XYsixe4dOIyHKXU1x76/6Kmhy61CEZypNfii7sz
 wNRc7r5BSVk7oJPwSpMZzPjbFA==
X-Google-Smtp-Source: ABdhPJyANN2qk7qYtHOYQkQvlPtHqN9Y/L2X1B7fu4pz3Gp3gU0xyGflALuEDFEqbKW6LbQNUvTwUA==
X-Received: by 2002:a2e:9045:0:b0:249:78ba:fbf8 with SMTP id
 n5-20020a2e9045000000b0024978bafbf8mr21358898ljg.218.1648490504041; 
 Mon, 28 Mar 2022 11:01:44 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 a4-20020a2eb164000000b0024988e1cfb6sm1801559ljm.94.2022.03.28.11.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 11:01:43 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v5 3/4] drivers/net/virtio_net: Added RSS hash report.
Date: Mon, 28 Mar 2022 20:53:35 +0300
Message-Id: <20220328175336.10802-4-andrew@daynix.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328175336.10802-1-andrew@daynix.com>
References: <20220328175336.10802-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: mst@redhat.com, yuri.benditovich@daynix.com, yan@daynix.com,
 kuba@kernel.org, davem@davemloft.net
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
 drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b5f2bb426a7b..c9472c30e8a2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -227,6 +227,7 @@ struct virtnet_info {
 
 	/* Host supports rss and/or hash report */
 	bool has_rss;
+	bool has_rss_hash_report;
 	u8 rss_key_size;
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
@@ -1148,6 +1149,35 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return NULL;
 }
 
+static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
+				struct sk_buff *skb)
+{
+	enum pkt_hash_types rss_hash_type;
+
+	if (!hdr_hash || !skb)
+		return;
+
+	switch ((int)hdr_hash->hash_report) {
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+		rss_hash_type = PKT_HASH_TYPE_L4;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+		rss_hash_type = PKT_HASH_TYPE_L3;
+		break;
+	case VIRTIO_NET_HASH_REPORT_NONE:
+	default:
+		rss_hash_type = PKT_HASH_TYPE_NONE;
+	}
+	skb_set_hash(skb, (unsigned int)hdr_hash->hash_value, rss_hash_type);
+}
+
 static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 			void *buf, unsigned int len, void **ctx,
 			unsigned int *xdp_xmit,
@@ -1182,6 +1212,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 
 	hdr = skb_vnet_hdr(skb);
+	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
+		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
 
 	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -2232,7 +2264,8 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
-				  VIRTIO_NET_CTRL_MQ_RSS_CONFIG, sgs)) {
+				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
+				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
 		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
 		return false;
 	}
@@ -3231,6 +3264,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_RSS,
+			     "VIRTIO_NET_F_CTRL_VQ") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
 			     "VIRTIO_NET_F_CTRL_VQ"))) {
 		return false;
 	}
@@ -3366,8 +3401,13 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi->mergeable_rx_bufs = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
+		vi->has_rss_hash_report = true;
+
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
 		vi->has_rss = true;
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
@@ -3383,8 +3423,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 
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
@@ -3451,7 +3494,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
-	if (vi->has_rss)
+	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
 	err = register_netdev(dev);
@@ -3586,7 +3629,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_RSS
+	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
