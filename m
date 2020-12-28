Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F41C433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:22:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C302084D
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C302084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A62986D0B;
	Mon, 28 Dec 2020 16:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9KXMrEy2dF7C; Mon, 28 Dec 2020 16:22:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A9CC86C47;
	Mon, 28 Dec 2020 16:22:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64FBDC1787;
	Mon, 28 Dec 2020 16:22:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A2A5C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 68A2986C47
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nu94gk3LPgKm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 841E686BF9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:40 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 4so5164375qvh.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vQsWqZSCnMr1x/EzF/kzhHSUUJGM29HYm08xu/2fjmE=;
 b=a7r3Z2CBMpz7h38KBUNrKg/8UT6W3Yw49Otjw8kRDRqEKPPT2nizEk67WHBHJwVcE6
 57nPbkaGZbWsPM0WCmfWG4zFe11Dh5BdAhO5sKi7rASiHegTjP47BBQ1Y83GlhqQbs/3
 lvRqNBJf1UK9H5ycT8FxGQAoX4uqT6qzXXvPL6UTcD4sgXm1XjT8FlcsHidRqBbx7F86
 PPCDWa8bnXz1GUqNrRN+m1nh43xoqE8MdOqkloYFkR7Tpy3KBI55xSk6HUEDFbcymYvi
 UvMDDR3eem5RXpPiw8Lf6JQxDEmgJ/mco0chJSsU6ZoHXCRNjqcIart4OKSJyveMho3k
 w49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vQsWqZSCnMr1x/EzF/kzhHSUUJGM29HYm08xu/2fjmE=;
 b=F+95PyAD7nA0F/w3534TOie8bFDEdspIZW1ey+Rj7ZxoSkCylz0Rkd/GXOrYvL2+ay
 wbkMhVjtacg7SDWxuPdOTMNlfNDwB8hdmn9crmip3tuh/Uq1yWBuu9uXakpDTCYnKvko
 wuz8sKJoh2b+5NiNXW0FFZJsMraruyCt7+4yAKlRbtHwCh+WaLTrysRT3sJqUyeUNhRh
 cXEsp0YadTRDeo/XWB+xjaWnfeBrFEoWJ5elcygHHKAI4sdQiP2AXO5Btfh7x52iJqRO
 wTyD3z1MgQJO84r4KnkybLRhHAVAMJiPHLHV5kjP0jonYQ31dyGoLqkI32LIxQfv+Lp7
 6rXQ==
X-Gm-Message-State: AOAM531hMrZ+ea8s0VMzpPbFYNhzwFsiTjsMwHHV+6Gbyb2PNWHFqa/z
 4+ImuHvRoySWAeqhUNiBAsSj/w0/oKc=
X-Google-Smtp-Source: ABdhPJx3TAGUQMPRKMmT3Y9uUkxQtN1ZuRA6AKf8I+fo2yanHcrz4Nm9p6V5c4DvbopY8iekLMzsgw==
X-Received: by 2002:ad4:4108:: with SMTP id i8mr47649560qvp.49.1609172559222; 
 Mon, 28 Dec 2020 08:22:39 -0800 (PST)
Received: from willemb.nyc.corp.google.com
 ([2620:0:1003:312:f693:9fff:fef4:3e8a])
 by smtp.gmail.com with ESMTPSA id u65sm24005556qkb.58.2020.12.28.08.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 08:22:38 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH rfc 2/3] virtio-net: support receive timestamp
Date: Mon, 28 Dec 2020 11:22:32 -0500
Message-Id: <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 mst@redhat.com
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

Add optional PTP hardware timestamp offload for virtio-net.

Accurate RTT measurement requires timestamps close to the wire.
Introduce virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
virtio-net header is expanded with room for a timestamp. A host may
pass receive timestamps for all or some packets. A timestamp is valid
if non-zero.

The timestamp straddles (virtual) hardware domains. Like PTP, use
international atomic time (CLOCK_TAI) as global clock base. It is
guest responsibility to sync with host, e.g., through kvm-clock.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c        | 20 +++++++++++++++++++-
 include/uapi/linux/virtio_net.h | 12 ++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b917b7333928..57744bb6a141 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -204,6 +204,9 @@ struct virtnet_info {
 	/* Guest will pass tx path info to the host */
 	bool has_tx_hash;
 
+	/* Host will pass CLOCK_TAI receive time to the guest */
+	bool has_rx_tstamp;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -292,6 +295,13 @@ static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
 	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
 }
 
+static inline struct virtio_net_hdr_v12 *skb_vnet_hdr_12(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct virtio_net_hdr_v12) > sizeof(skb->cb));
+
+	return (void *)skb->cb;
+}
+
 /*
  * private is used to chain pages for big packets, put the whole
  * most recent used list in the beginning for reuse
@@ -1082,6 +1092,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		goto frame_err;
 	}
 
+	if (vi->has_rx_tstamp)
+		skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(skb_vnet_hdr_12(skb)->tstamp);
+
 	skb_record_rx_queue(skb, vq2rxq(rq->vq));
 	skb->protocol = eth_type_trans(skb, dev);
 	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
@@ -3071,6 +3084,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RX_TSTAMP)) {
+		vi->has_rx_tstamp = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_v12);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -3261,7 +3279,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_TX_HASH
+	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index f6881b5b77ee..0ffe2eeebd4a 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_RX_TSTAMP	  55	/* Host sends TAI receive time */
 #define VIRTIO_NET_F_TX_HASH	  56	/* Guest sends hash report */
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
@@ -182,6 +183,17 @@ struct virtio_net_hdr_v1_hash {
 	};
 };
 
+struct virtio_net_hdr_v12 {
+	struct virtio_net_hdr_v1 hdr;
+	struct {
+		__le32 value;
+		__le16 report;
+		__le16 flow_state;
+	} hash;
+	__virtio32 reserved;
+	__virtio64 tstamp;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.29.2.729.g45daf8777d-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
