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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E24C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF40164E74
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF40164E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7A3A220797;
	Mon,  8 Feb 2021 18:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IAfpmpDrFixp; Mon,  8 Feb 2021 18:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 91755214EB;
	Mon,  8 Feb 2021 18:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A26EC0891;
	Mon,  8 Feb 2021 18:56:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3456C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 79E30214EB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lpssh-SNldw
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by silver.osuosl.org (Postfix) with ESMTPS id B98BD20797
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:03 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id b14so1944405qkk.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3J632UJbPXnW5jI7wLWLk7WvFrwdIcMwbkqpeY3vEL0=;
 b=Hoeu2zQdI95fmHYt1Fbz/whuJT9ICgJQ4y2smIelFESDm8DEs611ZSYNwf07OvRVEX
 q4iGtBQ6lEoS177Lu/di72pvOwyjmg62sTw9yC08S9HI5XIUmNPTLlnvo1P6SF2oI5To
 HfDmNI9Twgyv+v+vi8HrWiGqf4mV8sp6LP1ekPArBPefX//UduLN9wZCd8HBKJqrkH74
 8MONE6165vfthDl/SpTP9D8FOuh24U5HtlrcUbFItepW9EOPnVbPBU5/tEMvWLRmmNvk
 zVtBjKDMg1ocZ7Mv98jOqMHMS6lUGOeSf04a4N8S3aYPwuGlMqxrqFr+Hq8nJfVKbJGL
 6+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3J632UJbPXnW5jI7wLWLk7WvFrwdIcMwbkqpeY3vEL0=;
 b=hOah2Abuc3S1lM3vsb3DXIJMQ1S7jQqQd44HNZPLemv3E9qyOCtG/jSTj+8nCifd5Y
 sv5ghcsEMdlhg5UKB44x6LUXAeU+HM80cINdsYQTjnQcDsGGBKrUt47DMKwWn3IhqJgs
 SvmQWRwem9rM6tnXoi/0Oq/U+HYVWRJrl2nSm23VcFszzsps3A5eHJgCFagP6PEOar1y
 97DYqx3TMM2JpKV7IJ5YnzqrLX2tIeldDxVbwHZChODqKzR+8xckSzNzQBHMxB1AcnuK
 gFuuB78WW9Dkcd0jh7vg65H8Mr8maBtI8GMkgmgOXaOqKbU1WXLCGiY+agvP+vAWXARw
 7yKw==
X-Gm-Message-State: AOAM531T3mHwS0OfGzSqGrXDO95y9IgjshO/hMCaXwJkAb5keM3eNvN+
 9FVJz9PAihU5i4PO1AJry6u6ESHJQEE=
X-Google-Smtp-Source: ABdhPJxtmh1c+353FOHWeHvBtBodf+fk30pSohJV/0pPlUJ59vA/v8TDJKFt/PU9z5CWg8UXQ9WDIQ==
X-Received: by 2002:a37:434c:: with SMTP id q73mr18683570qka.170.1612810562384; 
 Mon, 08 Feb 2021 10:56:02 -0800 (PST)
Received: from willemb.nyc.corp.google.com
 ([2620:0:1003:312:f109:45d3:805f:3b83])
 by smtp.gmail.com with ESMTPSA id q25sm17370744qkq.32.2021.02.08.10.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 10:56:01 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 1/4] virtio-net: support transmit hash report
Date: Mon,  8 Feb 2021 13:55:55 -0500
Message-Id: <20210208185558.995292-2-willemdebruijn.kernel@gmail.com>
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

Virtio-net supports sharing the flow hash from device to driver on rx.
Do the same in the other direction for robust routing and telemetry.

Linux derives ipv6 flowlabel and ECMP multipath from sk->sk_txhash,
and updates this field on error with sk_rethink_txhash. Allow the host
stack to do the same.

Concrete examples of error conditions that are resolved are
mentioned in the commits that add sk_rethink_txhash calls. Such as
commit 7788174e8726 ("tcp: change IPv6 flow-label upon receiving
spurious retransmission").

Experimental results mirror what the theory suggests: where IPv6
FlowLabel is included in path selection (e.g., LAG/ECMP), flowlabel
rotation on TCP timeout avoids the vast majority of TCP disconnects
that would otherwise have occurred during link failures in long-haul
backbones, when an alternative path is available.

Rotation can be applied to various bad connection signals, such as
timeouts and spurious retransmissions. In aggregate, such flow level
signals can help locate network issues. Reserve field hash_state to
share this info. For now, always set VIRTIO_NET_HASH_STATE_DEFAULT.
Passing information between TCP stack and driver is future work.

Changes RFC->RFCv2
  - drop unused VIRTIO_NET_HASH_STATE_TIMEOUT_BIT
  - convert from cpu_to_virtioXX to cpu_to_leXX

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c        | 26 +++++++++++++++++++++++---
 include/uapi/linux/virtio_net.h |  9 ++++++++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ba8e63792549..7f822b2a5205 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -201,6 +201,9 @@ struct virtnet_info {
 	/* Host will merge rx buffers for big packets (shake it! shake it!) */
 	bool mergeable_rx_bufs;
 
+	/* Driver will pass tx path info to the device */
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
@@ -1528,6 +1531,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct virtio_net_hdr_v1_hash *ht;
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
 	bool can_push;
@@ -1552,6 +1556,16 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	if (vi->mergeable_rx_bufs)
 		hdr->num_buffers = 0;
 
+	ht = (void *)hdr;
+	if (vi->has_tx_hash) {
+		u16 report = skb->l4_hash ? VIRTIO_NET_HASH_REPORT_L4 :
+					    VIRTIO_NET_HASH_REPORT_OTHER;
+
+		ht->hash_value = cpu_to_le32(skb->hash);
+		ht->hash_report = cpu_to_le16(report);
+		ht->hash_state = cpu_to_le16(VIRTIO_NET_HASH_STATE_DEFAULT);
+	}
+
 	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
 		__skb_push(skb, hdr_len);
@@ -3050,6 +3064,11 @@ static int virtnet_probe(struct virtio_device *vdev)
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
@@ -3240,7 +3259,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
-	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
+	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
+	VIRTIO_NET_F_TX_HASH
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 3f55a4215f11..273d43c35f59 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_TX_HASH	  56	/* Driver sends hash report */
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
@@ -170,8 +171,14 @@ struct virtio_net_hdr_v1_hash {
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
+		__le16 hash_state;
+	};
 };
 
 #ifndef VIRTIO_NET_NO_LEGACY
-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
