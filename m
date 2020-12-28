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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F24C433E6
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:22:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A1E2084D
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A1E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8263087028;
	Mon, 28 Dec 2020 16:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BQCXBqHoqwmr; Mon, 28 Dec 2020 16:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 88DF68703C;
	Mon, 28 Dec 2020 16:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 654C5C1833;
	Mon, 28 Dec 2020 16:22:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DB0BC1787
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2A23E86BF9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wobawt++kvk8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5B14886C51
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:41 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id 22so9174032qkf.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uPsSfUcgHKgBzIXc3fN7YUqB8K9nJMunTZsde3ErHn4=;
 b=Xf0U70enwHW9IE8UGZVUnVIVEA0/1QMa+Unw2Hvs5voiItNagr8wOqb3rTN6qtLyyM
 2ADTZISRtDDTotVM/uwXgEPL23oP1/cusS33uE6wGl8QeZwRQ+3+JYlWuZb/zWAesI3m
 7JfTQsiGGjhJIAqky4jzDVjlH1LoiEPLMvBLOGDiA2GWIV73XXw1pMnkufdYO6/wdk8Y
 qTPP9EorAaSNWuEhFKTcqkzidcQjWghsBc+WxyVA9O7ZUwvCJ1EIxyMSnJT5AJB+lARJ
 4fq4yhWzH4y55tOWWNCjYFb6e0WCSqMHlb4GrIIbfgcqGBKfuYkK1kjW8BmsElawttUB
 k7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uPsSfUcgHKgBzIXc3fN7YUqB8K9nJMunTZsde3ErHn4=;
 b=TxSmd6lhxRqP2i58JT3wWRpJljGoJgg2TFAlEkKJOVASFF276oq5VsVmTlux90ER1u
 dhiN8xC45kudvE4X3ST3WUgCcYDBSUFaoYf30wmJCjDppFztiQowlsQyBstONT9FRTGg
 mdG0KbNYBFKy5yZx/6rnVRu/0KyGmko5EET9b7ETNmT7+do1aozVSndvCfisTIdWBN6k
 5Qh0RBeudKsQlYXaa/MPvNcMI5+PRarppETGRaJUtu7M6KjZYtpPFKSKkfj0PnwJXiEX
 C0TnT6ERNiF5YRGIw+ZDkC3Jy/NA8MdRon3kWeyDUgQFjgEavR64RkqM8oGzV1LqAra2
 P/jQ==
X-Gm-Message-State: AOAM532P1n3LBMJZ+3TrZrAE51ODKq4TdbgJPjVnSxpRDLqDPoOwMHOh
 IUrNdYLRDBysClMGDXmaZ9IX+hQl9/Y=
X-Google-Smtp-Source: ABdhPJxplx0oHVIyDzXmxBVOqgqLZvlzZAjkoslvEhIVjuqNIZ1evoBz2Od6TWBfCKaXMkzVsnsl/g==
X-Received: by 2002:a37:8204:: with SMTP id e4mr40690939qkd.351.1609172560145; 
 Mon, 28 Dec 2020 08:22:40 -0800 (PST)
Received: from willemb.nyc.corp.google.com
 ([2620:0:1003:312:f693:9fff:fef4:3e8a])
 by smtp.gmail.com with ESMTPSA id u65sm24005556qkb.58.2020.12.28.08.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 08:22:39 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH rfc 3/3] virtio-net: support transmit timestamp
Date: Mon, 28 Dec 2020 11:22:33 -0500
Message-Id: <20201228162233.2032571-4-willemdebruijn.kernel@gmail.com>
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

Add optional delivery time (SO_TXTIME) offload for virtio-net.

The Linux TCP/IP stack tries to avoid bursty transmission and network
congestion through pacing: computing an skb delivery time based on
congestion information. Userspace protocol implementations can achieve
the same with SO_TXTIME. This may also reduce scheduling jitter and
improve RTT estimation.

Pacing can be implemented in ETF or FQ qdiscs or offloaded to NIC
hardware. Allow guests to offload for the same reasons.

The timestamp straddles (virtual) hardware domains. Like PTP, use
international atomic time (CLOCK_TAI) as global clock base. It is
guest responsibility to sync with host, e.g., through kvm-clock.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c        | 24 +++++++++++++++++-------
 include/uapi/linux/virtio_net.h |  1 +
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 57744bb6a141..d40be688aed0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -207,6 +207,9 @@ struct virtnet_info {
 	/* Host will pass CLOCK_TAI receive time to the guest */
 	bool has_rx_tstamp;
 
+	/* Guest will pass CLOCK_TAI delivery time to the host */
+	bool has_tx_tstamp;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -1550,7 +1553,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
-	struct virtio_net_hdr_v1_hash *ht;
+	struct virtio_net_hdr_v12 *h12;
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
 	bool can_push;
@@ -1575,13 +1578,15 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	if (vi->mergeable_rx_bufs)
 		hdr->num_buffers = 0;
 
-	ht = (void *)hdr;
+	h12 = (void *)hdr;
 	if (vi->has_tx_hash) {
-		ht->hash_value = cpu_to_virtio32(vi->vdev, skb->hash);
-		ht->hash_report = skb->l4_hash ? VIRTIO_NET_HASH_REPORT_L4 :
-						 VIRTIO_NET_HASH_REPORT_OTHER;
-		ht->hash_state = VIRTIO_NET_HASH_STATE_DEFAULT;
+		h12->hash.value = cpu_to_virtio32(vi->vdev, skb->hash);
+		h12->hash.report = skb->l4_hash ? VIRTIO_NET_HASH_REPORT_L4 :
+						  VIRTIO_NET_HASH_REPORT_OTHER;
+		h12->hash.flow_state = VIRTIO_NET_HASH_STATE_DEFAULT;
 	}
+	if (vi->has_tx_tstamp)
+		h12->tstamp = cpu_to_virtio64(vi->vdev, skb->tstamp);
 
 	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
@@ -3089,6 +3094,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v12);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_TX_TSTAMP)) {
+		vi->has_tx_tstamp = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_v12);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -3279,7 +3289,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP
+	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP, VIRTIO_NET_F_TX_TSTAMP
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 0ffe2eeebd4a..da017a47791d 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_TX_TSTAMP	  54	/* Guest sets TAI delivery time */
 #define VIRTIO_NET_F_RX_TSTAMP	  55	/* Host sends TAI receive time */
 #define VIRTIO_NET_F_TX_HASH	  56	/* Guest sends hash report */
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
-- 
2.29.2.729.g45daf8777d-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
