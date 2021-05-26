Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB344C47088
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B0D613C7
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B0D613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EADC401FD;
	Wed, 26 May 2021 08:24:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SEEZl1MuG2R3; Wed, 26 May 2021 08:24:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B94B8404BC;
	Wed, 26 May 2021 08:24:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90A22C000E;
	Wed, 26 May 2021 08:24:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84346C0023
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61603402CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q_Y9guqrn1of
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C01C40306
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622017483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZS7ZD35dU/eELTvMx06tUPCxlf74xPaW7VsnOKz2lgA=;
 b=YoXA9nNFldikGUcYUNr161UObTN2s2JqW8GjgSmskkTkjKjZhbAKJ3vyF6LAtXIsSBM8mN
 IJ690VeOpN0Ve4gmmbjerq5ZpH+k+sz2PQh2yxQylUh2ik/2NUZhrXc7u3DzTNk1veHr1L
 QjPZdyXfe3kW3DMU2ZdovObzLygKjZE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-l_zqpHdtPA-cokpUkgtrrw-1; Wed, 26 May 2021 04:24:41 -0400
X-MC-Unique: l_zqpHdtPA-cokpUkgtrrw-1
Received: by mail-wm1-f71.google.com with SMTP id
 n127-20020a1c27850000b02901717a27c785so6949134wmn.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZS7ZD35dU/eELTvMx06tUPCxlf74xPaW7VsnOKz2lgA=;
 b=O6Newxeknw0Qd0zH7tcENxQlNBmxbSwWJpMP8pOB7cXhrPubq+xpD9UBM+EPBmgOTy
 ZF3UYMYSue2TWgryBlE0S9RDbQ9ZenI0q2UuKgCBBH9KpUIIT8pJfk3m9YYZYGhtyg2h
 nsLUI4ac3E9ZZZuBidYUDNhnezURfDSHZgzC768danbttV3aI6I8S+fwPxSsY8cATma+
 uLXPMbxCxscAu8SVNbzIgxQPPa1KQnD6CcY3RkdgXWFm/Kra/r3QbTl6788X2WvQ83eX
 NPs8jdgeBYmCMq+9g/oFOd6HCKAfhI5cr+jzlzsdKD4j/W0X45+ff4tpnQ1qdpuTbnCx
 yCMw==
X-Gm-Message-State: AOAM532MkWyZwcU3DC0EkzyusOw+oLO4XsOBhkArsCyk6EoCr+w7QfIu
 Dggu5W9/stYSrLx/ZaVRZslvsQwQ4J0iYs+UsapZBJfqpdy8JyFBEN46W7Kss8D6xmUd6L26dim
 2RvGiorhnTy/nAS8nUip5EipSujWZcgWRqB/SoJhpXg==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr2151373wma.127.1622017480213; 
 Wed, 26 May 2021 01:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXdpzBs/WOwiOoCYBUHQSDzRAcpfSmL78loNWZAQmEL/+Swns93afcI95zX4GVL88WJjsVEw==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr2151356wma.127.1622017480077; 
 Wed, 26 May 2021 01:24:40 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
 by smtp.gmail.com with ESMTPSA id n20sm13641956wmk.12.2021.05.26.01.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:24:39 -0700 (PDT)
Date: Wed, 26 May 2021 04:24:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] virtio_net: move txq wakeups under tx q lock
Message-ID: <20210526082423.47837-3-mst@redhat.com>
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

We currently check num_free outside tx q lock
which is unsafe: new packets can arrive meanwhile
and there won't be space in the queue.
Thus a spurious queue wakeup causing overhead
and even packet drops.

Move the check under the lock to fix that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 12512d1002ec..c29f42d1e04f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1434,11 +1434,12 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 	if (__netif_tx_trylock(txq)) {
 		free_old_xmit_skbs(sq, true);
+
+		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+			netif_tx_wake_queue(txq);
+
 		__netif_tx_unlock(txq);
 	}
-
-	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
-		netif_tx_wake_queue(txq);
 }
 
 static int virtnet_poll(struct napi_struct *napi, int budget)
@@ -1522,6 +1523,9 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	virtqueue_disable_cb(sq->vq);
 	free_old_xmit_skbs(sq, true);
 
+	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+		netif_tx_wake_queue(txq);
+
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
 	done = napi_complete_done(napi, 0);
@@ -1542,9 +1546,6 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 		}
 	}
 
-	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
-		netif_tx_wake_queue(txq);
-
 	return 0;
 }
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
