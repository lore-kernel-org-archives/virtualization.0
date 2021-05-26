Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034BFC47088
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE65613C7
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE65613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 947EE60A55;
	Wed, 26 May 2021 08:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdE2bqJ6W_xL; Wed, 26 May 2021 08:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B44A6080C;
	Wed, 26 May 2021 08:24:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16663C000E;
	Wed, 26 May 2021 08:24:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64801C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46C3F83C47
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XEo-S1f9Ga4B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91D31839DB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622017490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o40Fmid6nNIkbFe8iYePDZhpBrn8pMAYTwjh787uFdE=;
 b=bMgWZzvxoCCUOHiqAt0w139I9D42aQf9cd8BYUDxKX/uDjIEkOzpeo62tkp5FvqyWDP7Aa
 rm3CPN2Qp+lzFBggvoHlokDF1QVUFH9JQyXMZbeqpgWtE4xc36908E1BjbXIIrrgdrujnt
 iKk9y9eolWhyG7h//Rh6E2PzNDkgCno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-kBSzwGxyOV-lZr1MFEJ0HQ-1; Wed, 26 May 2021 04:24:46 -0400
X-MC-Unique: kBSzwGxyOV-lZr1MFEJ0HQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 q2-20020a05600c2e42b0290192cdd9d918so238866wmf.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o40Fmid6nNIkbFe8iYePDZhpBrn8pMAYTwjh787uFdE=;
 b=LduHz8Kw8UV8foIGHQdeUopVIe9ljk1V9XlT0GsnBX5UxBpHFwz8DumjJ5uyNRwnKX
 H98b2yRf4u7nRw2jL9Ih1iUVqn5QnFD1lr2W+ky23lR1S/c1OUoibL25//WTueDXzVEj
 ipzN1DzFJHi1GETEURK9lzkGHKGZNw1Qu3zAZv0JH2FsQJoAJrJ0IEFFPOZUhazvV4BH
 A9nfvLkvc2Go45xuozBzQ/FKgP3lEwwrUVM9OVtveqTdx32+7BBMNEnYIsdbOP+ifxJf
 J0gySV1HjeYEHJq4J9Wv8i+TtV2TA/1J3dSwliQQV9Pgkd7zO8cIvhFsxRz304bRwNKQ
 txxw==
X-Gm-Message-State: AOAM531s+rm/A0Ky2NgAIyymoauBudq1MONh0bKBr0i6yiE4475/iTja
 X6dn/wvDOamQpe2Mhwbl/S3A2mQqjhpyVw6Gp1dvr4BRN2oSCqI+R2mWITiDa4vpUfo/D/23mtK
 U2xNYA6w7kDFnS7tGrxUsw85wHC5TljuWs+uJ9sjk4w==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr2246263wmq.9.1622017485573;
 Wed, 26 May 2021 01:24:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3YaY8d7OxUasPPsyIXLBzSHdDVjW4txQgjFtjWKP91pjY4SLYxtZjAEHxMjzrOAh+TdWZzQ==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr2246253wmq.9.1622017485441;
 Wed, 26 May 2021 01:24:45 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
 by smtp.gmail.com with ESMTPSA id l188sm769420wmf.27.2021.05.26.01.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:24:45 -0700 (PDT)
Date: Wed, 26 May 2021 04:24:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] virtio_net: disable cb aggressively
Message-ID: <20210526082423.47837-5-mst@redhat.com>
References: <20210526082423.47837-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210526082423.47837-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

There are currently two cases where we poll TX vq not in response to a
callback: start xmit and rx napi.  We currently do this with callbacks
enabled which can cause extra interrupts from the card.  Used not to be
a big issue as we run with interrupts disabled but that is no longer the
case, and in some cases the rate of spurious interrupts is so high
linux detects this and actually kills the interrupt.

Fix up by disabling the callbacks before polling the tx vq.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c29f42d1e04f..a83dc038d8af 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1433,7 +1433,10 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq, true);
+		do {
+			virtqueue_disable_cb(sq->vq);
+			free_old_xmit_skbs(sq, true);
+		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 			netif_tx_wake_queue(txq);
@@ -1605,12 +1608,17 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
 	bool kick = !netdev_xmit_more();
 	bool use_napi = sq->napi.weight;
+	unsigned int bytes = skb->len;
 
 	/* Free up any pending old buffers before queueing new ones. */
-	free_old_xmit_skbs(sq, false);
+	do {
+		if (use_napi)
+			virtqueue_disable_cb(sq->vq);
 
-	if (use_napi && kick)
-		virtqueue_enable_cb_delayed(sq->vq);
+		free_old_xmit_skbs(sq, false);
+
+	} while (use_napi && kick &&
+	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
