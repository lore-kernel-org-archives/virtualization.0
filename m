Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD1C43214
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 17:55:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B27561101
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 17:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B27561101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E46E60C02;
	Wed, 18 Aug 2021 17:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xll4za0zYGbZ; Wed, 18 Aug 2021 17:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30EA860C15;
	Wed, 18 Aug 2021 17:55:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C802C001A;
	Wed, 18 Aug 2021 17:55:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0B65C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BCAEB4049E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MP-UnjuLPzmD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:55:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB1B6402CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:55:05 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id y7so6637369ljp.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FDZPSj82vJSIqNRbjRn5ddf373T0TpM4lEOoyZlVBZQ=;
 b=gmyLLI7JXpGj/OVBAN+uSzWOdMfP5YgfaXsgxzkz64Wd+OYKX0wQXGC4jGag2WE7uY
 E8hA6Bemu37meaMUVtI6ps1/8pzZlwoGMjjoQ1HwzZPKh4p+YRSTqKhC2JWXFtYN2pZ/
 3tT5kqRRQdkRabE9aLIDVQ0njaXIiaSuvtBwo830lK9kZf0ZXWJGMYK3WgOS0A6NisxV
 AoDISwFNEovUT4P+kNpxPKbcunxMTHOUq/oo+R28Cyp2kIBycmoQ+/kyP6+ujRCMp9z2
 HWZrecThca/8NfhVX5ktgC+IyuNH20vloG9nP/IkJlW/COuF1n9z4/OeZare6qDrIWR2
 xVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FDZPSj82vJSIqNRbjRn5ddf373T0TpM4lEOoyZlVBZQ=;
 b=IuUjs+/jMegdpDZPArR3WiPTYpA1Ey8dV6bG2ZpfNjZg2teUXu/131YQvoSwbLulF9
 q5wtRmS5+2WA0i8yiv/xTNM+iVSwYlEDAUc5pMrbms6mro5h866wKb8KXF52L2bk/s9Z
 ATjKhyXCeaKjKmLV8UJONv1PHUeJ391GWIMWH6ZMFlTcpjbhW0cQNW8ZTAwFY9ZSKJ6K
 uRCgSt4+RZZ3ZfBRfdtXpyz9FogbYlgAse9h33UB3cXAcdB1dUmdLhK27rXz0wy8Kubk
 WvzVhwo38avlarBkAHiXA7gTeiqluU2j1YrkWisLOYa+YpdzgYfRGfUdq98BKB02i1v5
 OJTQ==
X-Gm-Message-State: AOAM5339MbjzqWmke3xG+vkJ6aTWACl66471icyvnNCB9DaFnh2o2BKs
 2CHLp+qetYN/wLsZH6AU7d6mpw==
X-Google-Smtp-Source: ABdhPJzgju0iGClDUhJIg1bfxppQKWWT8UaYgKfcmAPRfVZg8FN3K6bHCLVQKa9pnbW8D41Y9+GRVw==
X-Received: by 2002:a2e:a606:: with SMTP id v6mr8840863ljp.366.1629309303836; 
 Wed, 18 Aug 2021 10:55:03 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id c5sm55820lji.67.2021.08.18.10.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 10:55:03 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org
Subject: [RFC PATCH 1/3] drivers/net/virtio_net: Fixed vheader to use v1.
Date: Wed, 18 Aug 2021 20:54:38 +0300
Message-Id: <20210818175440.128691-2-andrew@daynix.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818175440.128691-1-andrew@daynix.com>
References: <20210818175440.128691-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

The header v1 provides additional info about RSS.
Added changes to computing proper header length.
In the next patches, the header may contain RSS hash info
for the hash population.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 56c3f8519093..85427b4f51bc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -240,13 +240,13 @@ struct virtnet_info {
 };
 
 struct padded_vnet_hdr {
-	struct virtio_net_hdr_mrg_rxbuf hdr;
+	struct virtio_net_hdr_v1_hash hdr;
 	/*
 	 * hdr is in a separate sg buffer, and data sg buffer shares same page
 	 * with this header sg. This padding makes next sg 16 byte aligned
 	 * after the header.
 	 */
-	char padding[4];
+	char padding[12];
 };
 
 static bool is_xdp_frame(void *ptr)
@@ -1258,7 +1258,7 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 					  struct ewma_pkt_len *avg_pkt_len,
 					  unsigned int room)
 {
-	const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	const size_t hdr_len = ((struct virtnet_info *)(rq->vq->vdev->priv))->hdr_len;
 	unsigned int len;
 
 	if (room)
@@ -1642,7 +1642,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	int num_sg;
-	unsigned hdr_len = vi->hdr_len;
+	unsigned int hdr_len = vi->hdr_len;
 	bool can_push;
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
@@ -2819,7 +2819,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
  */
 static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqueue *vq)
 {
-	const unsigned int hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	const unsigned int hdr_len = vi->hdr_len;
 	unsigned int rq_size = virtqueue_get_vring_size(vq);
 	unsigned int packet_len = vi->big_packets ? IP_MAX_MTU : vi->dev->max_mtu;
 	unsigned int buf_len = hdr_len + ETH_HLEN + VLAN_HLEN + packet_len;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
