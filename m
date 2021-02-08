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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E16C433E6
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADD664E59
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADD664E59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 950BF85E69;
	Mon,  8 Feb 2021 18:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UR3ABIBZnrHT; Mon,  8 Feb 2021 18:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 14C6085E6E;
	Mon,  8 Feb 2021 18:56:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F00E1C1E6F;
	Mon,  8 Feb 2021 18:56:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A536C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 20EC386963
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRk24LOpxNVl
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C6B2F869A4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:07 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id u20so15516004qku.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 10:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V5SXxqRn9iChNkelA4Lz5t2Lq5FsheIFJl6lMmqNafs=;
 b=k1RlK0+rIiwKwfG+r9ciIyMYKAWET+IcMxexNzwQ+6z4uvYmVm0UL9tmzMKzLCn0r5
 MENfN1EXiEQTscopjRumoVdOW1lKWWj4fEVTwe2Hqrf9FD08Cp6diJio+rxvIxngxUCC
 m6pes9Awe+fNvUqENRRffwYQHGecfMZ4Qmn46xJvm+oFVCGJrZlnfHj9RLogA5D0ZQEz
 onLIh5gMZg5ENRcaSB5EcFMY0OIoMLlmgFhBl8NWczXYnHyCNPfiARsRf1wlTIXDs1rt
 CYuyUQgOa2xHtTfCgnCzjNDo1hiiLpBXscWeJQV5KOrUgPLho2xqhVhXRizC9D+VJMma
 cJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V5SXxqRn9iChNkelA4Lz5t2Lq5FsheIFJl6lMmqNafs=;
 b=YKXZ2myR+DtXZJI6ruz14v7J8FTr+T05w0wmYEYTdNafHuhTxVCRqMFGZNvWYfX9o3
 2H5uvyhEhWuzbFE+NLwtYiJTyua97oVDVaBZKqItjjROpVhd73zSJT2zMJEwY9yHvJM9
 IYy5iVWlfFhkuWpCOw56Wpx49iyJk3zN7vkCTvXTXElg2Bw2IoUc0X4JrR6n0yCbHq3r
 SksV4O1JX6Qee7RJiUSxFjLyW0CH9lcrvE2ItHUYL+0FeWGtmbvr8+RFdvOdAFuBiWfC
 s3/yUSomDDu3L8sMr4Js5M2STfhWd/qlDeG66L3LnOU3zFR6dXJqFH53nyNKbJoWMapx
 tBKw==
X-Gm-Message-State: AOAM532/yGNEP+bp4HVb+gcm69Ovg+kdjJW2XQgArUt7B3LXnNFjBGbp
 gdlOTk95irKu+gBB3HFS7nnGM3yw8Iw=
X-Google-Smtp-Source: ABdhPJx2Vzz3BN3fufrvFs0gfLszLO304XiNcsw2UEPhzqYAxQtPHMyuALjvbbug6pZAp9GoEaItqw==
X-Received: by 2002:a05:620a:8dc:: with SMTP id
 z28mr1023748qkz.404.1612810566558; 
 Mon, 08 Feb 2021 10:56:06 -0800 (PST)
Received: from willemb.nyc.corp.google.com
 ([2620:0:1003:312:f109:45d3:805f:3b83])
 by smtp.gmail.com with ESMTPSA id q25sm17370744qkq.32.2021.02.08.10.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 10:56:05 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 4/4] virtio-net: support future packet transmit time
Date: Mon,  8 Feb 2021 13:55:58 -0500
Message-Id: <20210208185558.995292-5-willemdebruijn.kernel@gmail.com>
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

Add optional transmit time (SO_TXTIME) offload for virtio-net.

The Linux TCP/IP stack tries to avoid bursty transmission and network
congestion through pacing: computing an skb delivery time based on
congestion information. Userspace protocol implementations can achieve
the same with SO_TXTIME. This may also reduce scheduling jitter and
improve RTT estimation.

Pacing can be implemented in ETF or FQ qdiscs or offloaded to NIC
hardware. Allow virtio-net driver to offload for the same reasons.

The timestamp straddles (virtual) hardware domains. Like PTP, use
international atomic time (CLOCK_TAI) as global clock base. The driver
must sync with the device, e.g., through kvm-clock.

Changes RFC - RFCv2
  - rename from transmit timestamp to future packet transmit time
  - convert cpu_to_virtioXX to cpu_to_leXX

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c        | 13 ++++++++++++-
 include/uapi/linux/virtio_net.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fc8ecd3a333a..c09d19b97f42 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -216,6 +216,9 @@ struct virtnet_info {
 	/* Device will pass tx timestamp. Requires has_tx_tstamp */
 	bool enable_tx_tstamp;
 
+	/* Driver will pass CLOCK_TAI delivery time to the device */
+	bool has_tx_time;
+
 	/* Has control virtqueue */
 	bool has_cvq;
 
@@ -1616,6 +1619,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	}
 	if (vi->enable_tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
 		ht->hdr.flags |= VIRTIO_NET_HDR_F_TSTAMP;
+	if (vi->has_tx_time && skb->tstamp)
+		ht->tstamp = cpu_to_le64(skb->tstamp);
 
 	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
@@ -3221,6 +3226,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_hash_ts);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_TX_TIME)) {
+		vi->has_tx_time = true;
+		vi->hdr_len = sizeof(struct virtio_net_hdr_hash_ts);
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -3412,7 +3422,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP, VIRTIO_NET_F_TX_TSTAMP
+	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP, VIRTIO_NET_F_TX_TSTAMP, \
+	VIRTIO_NET_F_TX_TIME
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index b5d6f0c6cead..7ca99a2ee1a3 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_TX_TIME	  53	/* Driver sets TAI delivery time */
 #define VIRTIO_NET_F_TX_TSTAMP	  54	/* Device sends TAI transmit time */
 #define VIRTIO_NET_F_RX_TSTAMP	  55	/* Device sends TAI receive time */
 #define VIRTIO_NET_F_TX_HASH	  56	/* Driver sends hash report */
-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
