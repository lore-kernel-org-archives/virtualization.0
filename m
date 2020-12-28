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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF67C433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:22:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E452084D
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E452084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5C3A86D13;
	Mon, 28 Dec 2020 16:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LTQddDMap5hk; Mon, 28 Dec 2020 16:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F42786C65;
	Mon, 28 Dec 2020 16:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10B2EC1833;
	Mon, 28 Dec 2020 16:22:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22025C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 11966865F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HMf0rlI86oII
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6DF8C87028
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:39 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id az16so5149892qvb.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E+P5deBgMfEMNVf0vB1e6Pyaa3lRUXorz/FFexYbRww=;
 b=p+sxNA67eY0qGzrr2ZW6sQAHd9YD0jBivT9ziHSrGJMTY4UrjK4ppFohD1CVbPCzxZ
 WI/Ex9/QF5cywFlBBJ5ZPgKp58cgSI9ffH5PbjMk7oHXQMoN2sJf5IB5eAjUSsdAwDDo
 u3KQTI2/2KRBWvhoP5wVuJk9Np8K0XSbe1H2kBEKYScpCUsfuJgusA+9dX9oOuYNbaIj
 Nuxnf9A/oCB3j61hFK7ONtm78MzDSFseEGs2GkUOuRiHAE8whBocmAoezYr7C/ln+ObI
 d3fySF12MrE0fO3LrJfOY8sxx2RM+u18qN/5D1mMcWdrgxccRHvpFFlp5VU3EKApVs4w
 CBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E+P5deBgMfEMNVf0vB1e6Pyaa3lRUXorz/FFexYbRww=;
 b=oTvk2NJpzt7eJA7ovmYhbJknzioi2gP6ytuAGy3hC8H30fz92F+uMpj/Nc73yBHiWz
 SyvaiCCgAY0Wps6xsTxZrJgRDj7EvyacMwfyV1Uwzsgd7bicUxsGF+CptuFE31OsG6DV
 g4+6+kHrdu1rR8vtV+XGgORwZdipFamS8eAOokir2sVYJjfDSiekC1pR02HZvOXn47e+
 kmdS9W30lmtcGKZP40Yf0HxQm37oyS8/GBUuUDeFKn/CGAFsi7fbVzr5/S350U1iqkoW
 1jp0rObThWPyEx5vB9OBsBhyNhwBPAfLxIJJ/ajha4EfGtjk/aAFE8F404mivrnMay9C
 8dQg==
X-Gm-Message-State: AOAM532h2TH4gISK0a5mMmPb23nEDJ/2D0soaJubMFUjP23ea4I8L52T
 WaEIvE2sZTjb6Ku/TKP+MgnG/wlnj5s=
X-Google-Smtp-Source: ABdhPJyzCEi17L8Bqx+W7irotxFVqlBZ0ufvsoQmL1pqrzYK2d80AdgiRcapqv28GPFkJFMeEo0uMA==
X-Received: by 2002:a0c:fe90:: with SMTP id d16mr48310260qvs.13.1609172558271; 
 Mon, 28 Dec 2020 08:22:38 -0800 (PST)
Received: from willemb.nyc.corp.google.com
 ([2620:0:1003:312:f693:9fff:fef4:3e8a])
 by smtp.gmail.com with ESMTPSA id u65sm24005556qkb.58.2020.12.28.08.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 08:22:37 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH rfc 1/3] virtio-net: support transmit hash report
Date: Mon, 28 Dec 2020 11:22:31 -0500
Message-Id: <20201228162233.2032571-2-willemdebruijn.kernel@gmail.com>
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

Virtio-net supports sharing the flow hash from host to guest on rx.
Do the same on transmit, to allow the host to infer connection state
for more robust routing and telemetry.

Linux derives ipv6 flowlabel and ECMP multipath from sk->sk_txhash,
and updates these fields on error with sk_rethink_txhash. This feature
allows the host to make similar decisions.

Besides the raw hash, optionally also convey connection state for
this hash. Specifically, the hash rotates on transmit timeout. To
avoid having to keep a stateful table in the host to detect flow
changes, explicitly notify when a hash changed due to timeout.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c        | 24 +++++++++++++++++++++---
 include/uapi/linux/virtio_net.h | 10 +++++++++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 21b71148c532..b917b7333928 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -201,6 +201,9 @@ struct virtnet_info {
 	/* Host will merge rx buffers for big packets (shake it! shake it!) */
 	bool mergeable_rx_bufs;
 
+	/* Guest will pass tx path info to the host */
+	bool has_tx_hash;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -394,9 +397,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	hdr_len = vi->hdr_len;
 	if (vi->mergeable_rx_bufs)
-		hdr_padded_len = sizeof(*hdr);
+		hdr_padded_len = max_t(unsigned int, hdr_len, sizeof(*hdr));
 	else
-		hdr_padded_len = sizeof(struct padded_vnet_hdr);
+		hdr_padded_len = ALIGN(hdr_len, 16);
 
 	/* hdr_valid means no XDP, so we can copy the vnet header */
 	if (hdr_valid)
@@ -1534,6 +1537,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct virtio_net_hdr_v1_hash *ht;
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
 	bool can_push;
@@ -1558,6 +1562,14 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	if (vi->mergeable_rx_bufs)
 		hdr->num_buffers = 0;
 
+	ht = (void *)hdr;
+	if (vi->has_tx_hash) {
+		ht->hash_value = cpu_to_virtio32(vi->vdev, skb->hash);
+		ht->hash_report = skb->l4_hash ? VIRTIO_NET_HASH_REPORT_L4 :
+						 VIRTIO_NET_HASH_REPORT_OTHER;
+		ht->hash_state = VIRTIO_NET_HASH_STATE_DEFAULT;
+	}
+
 	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
 		__skb_push(skb, hdr_len);
@@ -3054,6 +3066,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 	else
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_TX_HASH)) {
+		vi->has_tx_hash = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -3243,7 +3260,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
-	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
+	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
+	VIRTIO_NET_F_TX_HASH
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 3f55a4215f11..f6881b5b77ee 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_TX_HASH	  56	/* Guest sends hash report */
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
@@ -170,8 +171,15 @@ struct virtio_net_hdr_v1_hash {
 #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
 #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
 #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+#define VIRTIO_NET_HASH_REPORT_L4              10
+#define VIRTIO_NET_HASH_REPORT_OTHER           11
 	__le16 hash_report;
-	__le16 padding;
+	union {
+		__le16 padding;
+#define VIRTIO_NET_HASH_STATE_DEFAULT          0
+#define VIRTIO_NET_HASH_STATE_TIMEOUT_BIT      0x1
+		__le16 hash_state;
+	};
 };
 
 #ifndef VIRTIO_NET_NO_LEGACY
-- 
2.29.2.729.g45daf8777d-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
