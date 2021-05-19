Return-Path: <SRS0=KlxN=KO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2173EC433ED
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 08:36:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B041E610A8
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 08:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B041E610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6103C40122;
	Wed, 19 May 2021 08:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GbzowL2ygg3j; Wed, 19 May 2021 08:35:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01DD940106;
	Wed, 19 May 2021 08:35:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBA94C000D;
	Wed, 19 May 2021 08:35:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A643FC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 08:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D12E40558
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 08:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g6zAiG8-o-VT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 08:35:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66A2840513
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621413355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kBWJsOxt7zpLvOsF815LxI3UC9m1OTmAuh6Ryt/JE9E=;
 b=Wgzexkd2mMWHq6HKlwG9cqJaM9eLLTxDvXPJgX1QLYOvpDMO6AmEwaXtWSXk/eDE8HpWsb
 3SajCNE43wECF8qax1RTtPEDBcAaAzoTG/Qnp6Vqpt9o+/OdRDJJSAEwEFpmFu5jmjyPYk
 Yq6UvEIFt3/MSVr/pWtw6wEnIAfJofQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-zJ8Xfrv9ONy0cxRgqE09IA-1; Wed, 19 May 2021 04:35:53 -0400
X-MC-Unique: zJ8Xfrv9ONy0cxRgqE09IA-1
Received: by mail-wr1-f72.google.com with SMTP id
 p11-20020adfc38b0000b0290111f48b8adfso3367704wrf.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 01:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kBWJsOxt7zpLvOsF815LxI3UC9m1OTmAuh6Ryt/JE9E=;
 b=PJ0rsKgBh4SuY5nQLm8GJ6F2rNIdRscvSNKR2zv2F56yTOwe3bbNRHXSV41ublmZyV
 BgFUQD09DrK9Ooo7vsQOH5+HSh6yzZ2KsIIiCmYwfIsglo+q4CI6Anlhqn5cskJEVPpb
 MhtNXa1HOuPDEJjOE/NLiHg9ao3sdqy3opZwNiGExPNryQZzWDvseqqiXcOczg0AWDkz
 PTGMKBndXkkTth6LD53sBtB8zx0OYwu5DmC6LdS2DEvAUJP/TNqVp5DoLoSFzJm5fF9c
 SFdHeAjRUljS2lGWS/01U9HspZPvwUQPSt+DGwwnmJNyU8FWDqByKKFZnG6xnRtncKNX
 nl/g==
X-Gm-Message-State: AOAM531g8tv46KJ0FXTpe3BX6zAkwikjsEgnNbakxyQHimH7eX/xwYMm
 NIRabouVDNmnejPzHmX6q1RYZ2zRIiJjPpGISV9hueKV4fajN45EMmxKOnyLWlvXZfj8GsX6LrE
 /N3evSyPYcvZsgL/XyvF5LCo9rfDuORwvI+0k+HHYkQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr12654210wrq.44.1621413352512; 
 Wed, 19 May 2021 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnuhdYturThgXAIn2AgmdXSkMy9No+V7eGDQOMjqtANuqtHMvDVHRKxvBEyVM2mlWEq2nttw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr12654194wrq.44.1621413352319; 
 Wed, 19 May 2021 01:35:52 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id y2sm5892806wmq.45.2021.05.19.01.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 01:35:51 -0700 (PDT)
Date: Wed, 19 May 2021 04:35:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dave Taht <dave.taht@gmail.com>
Subject: Re: virtio_net: BQL?
Message-ID: <20210519043201-mutt-send-email-mst@kernel.org>
References: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
 <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Mon, May 17, 2021 at 11:43:43AM -0700, Dave Taht wrote:
> Not really related to this patch, but is there some reason why virtio
> has no support for BQL?

So just so you can try it out, I rebased my old patch.
XDP is handled incorrectly by it so we shouldn't apply it as is,
but should be good enough for you to see whether it helps.
Completely untested!

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7be93ca01650..4bfb682a20b2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -556,6 +556,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			kicks = 1;
 	}
 out:
+	/* TODO: netdev_tx_completed_queue? */
 	u64_stats_update_begin(&sq->stats.syncp);
 	sq->stats.bytes += bytes;
 	sq->stats.packets += packets;
@@ -1376,7 +1377,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return stats.packets;
 }
 
-static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
+static void free_old_xmit_skbs(struct netdev_queue *txq, struct send_queue *sq, bool in_napi)
 {
 	unsigned int len;
 	unsigned int packets = 0;
@@ -1406,6 +1407,8 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 	if (!packets)
 		return;
 
+	netdev_tx_completed_queue(txq, packets, bytes);
+
 	u64_stats_update_begin(&sq->stats.syncp);
 	sq->stats.bytes += bytes;
 	sq->stats.packets += packets;
@@ -1434,7 +1437,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 	if (__netif_tx_trylock(txq)) {
 		virtqueue_disable_cb(sq->vq);
-		free_old_xmit_skbs(sq, true);
+		free_old_xmit_skbs(txq, sq, true);
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 			netif_tx_wake_queue(txq);
@@ -1522,7 +1525,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(txq, sq, true);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
@@ -1606,10 +1609,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
 	bool kick = !netdev_xmit_more();
 	bool use_napi = sq->napi.weight;
+	unsigned int bytes = skb->len;
 
 	/* Free up any pending old buffers before queueing new ones. */
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, false);
+	free_old_xmit_skbs(txq, sq, false);
 
 	if (use_napi && kick)
 		virtqueue_enable_cb_delayed(sq->vq);
@@ -1638,6 +1642,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		nf_reset_ct(skb);
 	}
 
+	netdev_tx_sent_queue(txq, bytes);
+
 	/* If running out of space, stop queue to avoid getting packets that we
 	 * are then unable to transmit.
 	 * An alternative would be to force queuing layer to requeue the skb by
@@ -1653,7 +1659,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (!use_napi &&
 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq, false);
+			free_old_xmit_skbs(txq, sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
