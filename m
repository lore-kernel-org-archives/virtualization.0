Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D8C433E9
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC7C64E84
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC7C64E84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F0608699E;
	Mon,  8 Feb 2021 18:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sDXqzyvpHjD4; Mon,  8 Feb 2021 18:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6EA3C86963;
	Mon,  8 Feb 2021 18:56:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66E73C0891;
	Mon,  8 Feb 2021 18:56:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 050CAC1E70
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9EB25214E9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ndvkmzuQUqK
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by silver.osuosl.org (Postfix) with ESMTPS id 04E0F21080
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:05 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id s77so15522620qke.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 10:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6yp0IdRYkYzaakKnjWKVwWGjwkouMnyOp2X0i4UzkZ0=;
 b=YZ7pq/JELCAMrvVF/yN1Bn3gZ66+44ob9zGxCVxpgwsu/pfqezXRPJaYyUY5iqnO1j
 33+XJ/5u2iBfg09D+VXHbcI7moHy59uyDmlmJKkGZmJwRmNQ4NWjuUpIk7WrQDjF2ztz
 qemTAaaJ1MOks2gLOtxcrHHMOPSXB8/GvVIa1+gjkV0+Tru+Hm6io7nE0e06lKlfEFse
 TVm9U9C7580imrSt9o3+eLYkHVf9aJKk7Bku9O05QwuAwu2574yO5WlXiwOy1xJqfhP9
 NIvlV9kuQS4zSlJlXHFkvoikvFB9Z6AYFMxBdcvLazVl1srR5Ea3xcSjdtQRwiJR9uLQ
 Qe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6yp0IdRYkYzaakKnjWKVwWGjwkouMnyOp2X0i4UzkZ0=;
 b=gwgU+H73r/D2azZqmB17YBrOHVfvAv12A5O8XopV6Cbhl2XtdC/4isWVtfMgPkcXoc
 Y86+oR7BD1mJvHIu5W2h8T1Ayw2eHqAzaxFee8DBN1zksAcaM+jD6dplmoi51E0ugXuq
 XWwQFORdEpffkRlIzoJpoXwB6s4lVPtuVuPRAQsfC087IiWmapm/6xU371WubkGz6wdo
 o23dibLSeC6JRtix14/KA2SESHhGYOdIDCAm0iiUDrHB5QtDInNg95YQnpwZ1x4r1AH8
 a9dIMTUHpi0OdSUrPQ/kVFVKWevUxOZY/NsRTFnjnVQCF5vKdcjx0V9iqGqyP8lPM+II
 Th8A==
X-Gm-Message-State: AOAM532pWm6XuWvyVegktdGSAhSkBR+mVhvPRYnl/UmaPtsZMeCYR/qN
 piKyeQy8H3WDQs7MmlSsWu1CTQiBPB4=
X-Google-Smtp-Source: ABdhPJzV/bknCKSI+lU+s+mQaoJmC0IkuL4JRBp8F4sjN9v2OAZi6u7eW43q1hmKSGDPcc/OwtwpwQ==
X-Received: by 2002:a37:aa09:: with SMTP id t9mr17716911qke.214.1612810563753; 
 Mon, 08 Feb 2021 10:56:03 -0800 (PST)
Received: from willemb.nyc.corp.google.com
 ([2620:0:1003:312:f109:45d3:805f:3b83])
 by smtp.gmail.com with ESMTPSA id q25sm17370744qkq.32.2021.02.08.10.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 10:56:02 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 2/4] virtio-net: support receive timestamp
Date: Mon,  8 Feb 2021 13:55:56 -0500
Message-Id: <20210208185558.995292-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 richardcochran@gmail.com, mst@redhat.com
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

From: Willem de Bruijn <willemb@google.com>

Add optional PTP hardware rx timestamp offload for virtio-net.

Accurate RTT measurement requires timestamps close to the wire.
Introduce virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
virtio-net header is expanded with room for a timestamp.

A device may pass receive timestamps for all or some packets. Flag
VIRTIO_NET_HDR_F_TSTAMP signals whether a timestamp is recorded.

A driver that supports hardware timestamping must also support
ioctl SIOCSHWTSTAMP. Implement that, as well as information getters
ioctl SIOCGHWTSTAMP and ethtool get_ts_info (`ethtool -T $DEV`).

The timestamp straddles (virtual) hardware domains. Like PTP, use
international atomic time (CLOCK_TAI) as global clock base. The driver
must sync with the device, e.g., through kvm-clock.

Tested:
  guest: ./timestamping eth0 \
          SOF_TIMESTAMPING_RAW_HARDWARE \
          SOF_TIMESTAMPING_RX_HARDWARE
  host: nc -4 -u 192.168.1.1 319

Changes RFC -> RFCv2
  - rename virtio_net_hdr_v12 to virtio_net_hdr_hash_ts
  - add ethtool .get_ts_info to query capabilities
  - add ioctl SIOC[GS]HWTSTAMP to configure feature
  - add vi->enable_rx_tstamp to store configuration
  - convert virtioXX_to_cpu to leXX_to_cpu
  - convert reserved to __u32

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c        | 113 +++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h |  13 ++++
 2 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7f822b2a5205..ac44c5efa0bc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -204,6 +204,12 @@ struct virtnet_info {
 	/* Driver will pass tx path info to the device */
 	bool has_tx_hash;
 
+	/* Device can pass CLOCK_TAI receive time to the driver */
+	bool has_rx_tstamp;
+
+	/* Device will pass rx timestamp. Requires has_rx_tstamp */
+	bool enable_rx_tstamp;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -292,6 +298,13 @@ static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
 	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
 }
 
+static inline struct virtio_net_hdr_hash_ts *skb_vnet_hdr_ht(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct virtio_net_hdr_hash_ts) > sizeof(skb->cb));
+
+	return (void *)skb->cb;
+}
+
 /*
  * private is used to chain pages for big packets, put the whole
  * most recent used list in the beginning for reuse
@@ -1030,6 +1043,19 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return NULL;
 }
 
+static inline void virtnet_record_rx_tstamp(const struct virtnet_info *vi,
+					    struct sk_buff *skb)
+{
+	const struct virtio_net_hdr_hash_ts *h = skb_vnet_hdr_ht(skb);
+
+	if (h->hdr.flags & VIRTIO_NET_HDR_F_TSTAMP &&
+	    vi->enable_rx_tstamp) {
+		u64 ts = le64_to_cpu(h->tstamp);
+
+		skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ts);
+	}
+}
+
 static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 			void *buf, unsigned int len, void **ctx,
 			unsigned int *xdp_xmit,
@@ -1076,6 +1102,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		goto frame_err;
 	}
 
+	virtnet_record_rx_tstamp(vi, skb);
 	skb_record_rx_queue(skb, vq2rxq(rq->vq));
 	skb->protocol = eth_type_trans(skb, dev);
 	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
@@ -2263,6 +2290,28 @@ static int virtnet_get_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static int virtnet_get_ts_info(struct net_device *dev,
+			       struct ethtool_ts_info *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	/* setup default software timestamp */
+	ethtool_op_get_ts_info(dev, info);
+
+	/* return rx capabilities (which may differ from current enable) */
+	if (vi->has_rx_tstamp) {
+		info->so_timestamping |= SOF_TIMESTAMPING_RX_HARDWARE |
+					 SOF_TIMESTAMPING_RAW_HARDWARE;
+		info->rx_filters = HWTSTAMP_FILTER_ALL;
+	} else {
+		info->rx_filters = HWTSTAMP_FILTER_NONE;
+	}
+
+	info->tx_types = HWTSTAMP_TX_OFF;
+
+	return 0;
+}
+
 static void virtnet_init_settings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2300,7 +2349,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_ethtool_stats = virtnet_get_ethtool_stats,
 	.set_channels = virtnet_set_channels,
 	.get_channels = virtnet_get_channels,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = virtnet_get_ts_info,
 	.get_link_ksettings = virtnet_get_link_ksettings,
 	.set_link_ksettings = virtnet_set_link_ksettings,
 	.set_coalesce = virtnet_set_coalesce,
@@ -2558,6 +2607,60 @@ static int virtnet_set_features(struct net_device *dev,
 	return 0;
 }
 
+static int virtnet_ioctl_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct hwtstamp_config tsconf;
+
+	if (copy_from_user(&tsconf, ifr->ifr_data, sizeof(tsconf)))
+		return -EFAULT;
+	if (tsconf.flags)
+		return -EINVAL;
+	if (tsconf.tx_type != HWTSTAMP_TX_OFF)
+		return -ERANGE;
+	if (tsconf.rx_filter != HWTSTAMP_FILTER_NONE &&
+	    tsconf.rx_filter != HWTSTAMP_FILTER_ALL)
+		tsconf.rx_filter = HWTSTAMP_FILTER_ALL;
+
+	if (!vi->has_rx_tstamp)
+		tsconf.rx_filter = HWTSTAMP_FILTER_NONE;
+	else
+		vi->enable_rx_tstamp = tsconf.rx_filter == HWTSTAMP_FILTER_ALL;
+
+	if (copy_to_user(ifr->ifr_data, &tsconf, sizeof(tsconf)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int virtnet_ioctl_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct hwtstamp_config tsconf;
+
+	tsconf.flags = 0;
+	tsconf.rx_filter = vi->enable_rx_tstamp ? HWTSTAMP_FILTER_ALL :
+						  HWTSTAMP_FILTER_NONE;
+	tsconf.tx_type = HWTSTAMP_TX_OFF;
+
+	if (copy_to_user(ifr->ifr_data, &tsconf, sizeof(tsconf)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int virtnet_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		return virtnet_ioctl_set_hwtstamp(dev, ifr);
+
+	case SIOCGHWTSTAMP:
+		return virtnet_ioctl_get_hwtstamp(dev, ifr);
+	}
+	return -EOPNOTSUPP;
+}
+
 static const struct net_device_ops virtnet_netdev = {
 	.ndo_open            = virtnet_open,
 	.ndo_stop   	     = virtnet_close,
@@ -2573,6 +2676,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
+	.ndo_do_ioctl		= virtnet_ioctl,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -3069,6 +3173,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RX_TSTAMP)) {
+		vi->has_rx_tstamp = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_hash_ts);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -3260,7 +3369,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_TX_HASH
+	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 273d43c35f59..a5c84410cf92 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_RX_TSTAMP	  55	/* Device sends TAI receive time */
 #define VIRTIO_NET_F_TX_HASH	  56	/* Driver sends hash report */
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
@@ -126,6 +127,7 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
 #define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc info in csum_ fields */
+#define VIRTIO_NET_HDR_F_TSTAMP		8	/* timestamp is recorded */
 	__u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
@@ -181,6 +183,17 @@ struct virtio_net_hdr_v1_hash {
 	};
 };
 
+struct virtio_net_hdr_hash_ts {
+	struct virtio_net_hdr_v1 hdr;
+	struct {
+		__le32 value;
+		__le16 report;
+		__le16 flow_state;
+	} hash;
+	__u32 reserved;
+	__le64 tstamp;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
