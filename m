Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AC9C43460
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:48:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F7A61221
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F7A61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13B4A400B5;
	Tue, 13 Apr 2021 05:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AA6FjVU6de8T; Tue, 13 Apr 2021 05:48:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0655400D8;
	Tue, 13 Apr 2021 05:48:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92C99C000B;
	Tue, 13 Apr 2021 05:48:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4982C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E047184335
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zCcaQfd0SzY5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:48:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3934E84344
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618292880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGJBfGcLgKMi1+/2KjTQyyM9awqMoNgF1ipdHiAyD40=;
 b=KFJmODUs9bg1g3CTvYREH5ojlYv8wpBMibY4n03+MGDQ4x0ZdfqW2aB6oa1tIU6xyz6xZC
 hqI/ORvv2kDqBkdIhbCEDrE7DlARI3ZcZjeHl7R/owlg0xPQte02Xc718/0c7sb8RiAFFr
 Z96hXkDFThtaBW/x4RSb0adlP3OD5Ck=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-R0Oc2LyeO5uUbSkT4ck_nQ-1; Tue, 13 Apr 2021 01:47:58 -0400
X-MC-Unique: R0Oc2LyeO5uUbSkT4ck_nQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 o3-20020a1c75030000b029010f4e02a2f2so666998wmc.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QGJBfGcLgKMi1+/2KjTQyyM9awqMoNgF1ipdHiAyD40=;
 b=QlUohnHjYv7+CAiigfMIcfPYn+lxBtGUNk0fRkZJalkVll59bM4MYHZaPrUMsz9e32
 iqaNUeP5jKYOtW4YlasRGOA5agMqNCEHy6tRfUupiWqkGh4DW49oc/X9V4wnU6y9DMt4
 qfv1yRtGghfvDIyRSA8qsNrJgHQFns5SFvYcxRvzVXtbax1mHs/NrJHF0RE6npQ/z/Av
 bf4IO4LJrmFkNUX2uLew2fMfb+mTX4jzbudy77VTSSxu6XmDX07GsOAbylShcxVrQlSY
 Ijh0ktYOYryke2ap0ncFd63VPNqHwDFcbDv+yZT3waq2SUWFJiITQLq2IcEn+sjzUga2
 qVFA==
X-Gm-Message-State: AOAM531rP0SCfTFF4hkOf2YHkDakVxpdy/6Wl4Bm/nl7MdgVfjNZzGf/
 cB/B+wWdK06yaPsp45tuHx6kNjf7er+czva6qB6nfs605N+nQDZBcd9AWMUhzp+gJVfMVy1GwG+
 Mb3m0+lLKO43zcvNZGP/W5bsjrRvklBAohAcxbAxs4Q==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr2254272wmc.179.1618292877176; 
 Mon, 12 Apr 2021 22:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW5ocyM6oF51LY1hu/Bl53XZpnXsl6/4JelfE4ZTpiVul59teVVfXyx5S11Km6LpSBfopV3w==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr2254249wmc.179.1618292877015; 
 Mon, 12 Apr 2021 22:47:57 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id a8sm20895382wrh.91.2021.04.12.22.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 22:47:56 -0700 (PDT)
Date: Tue, 13 Apr 2021 01:47:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 4/4] virtio_net: move txq wakeups under tx q lock
Message-ID: <20210413054733.36363-5-mst@redhat.com>
References: <20210413054733.36363-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210413054733.36363-1-mst@redhat.com>
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
index 460ccdbb840e..febaf55ec1f6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1431,11 +1431,12 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	if (__netif_tx_trylock(txq)) {
 		virtqueue_disable_cb(sq->vq);
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
@@ -1519,6 +1520,9 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	virtqueue_disable_cb(sq->vq);
 	free_old_xmit_skbs(sq, true);
 
+	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+		netif_tx_wake_queue(txq);
+
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
 	done = napi_complete_done(napi, 0);
@@ -1539,9 +1543,6 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
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
