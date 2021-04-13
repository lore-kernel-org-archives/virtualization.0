Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB6C43461
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:48:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAA0613AF
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAA0613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4968984338;
	Tue, 13 Apr 2021 05:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gV6DxOktd8vC; Tue, 13 Apr 2021 05:48:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA3338432F;
	Tue, 13 Apr 2021 05:48:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2E04C000B;
	Tue, 13 Apr 2021 05:48:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF4A6C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1CFF8432F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id viJiiBsjnYWA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4476D8432E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618292877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OW6XlN+3Md7fOqRvuUIIBXiaDESq3bj/UWHZYxmw3rg=;
 b=eiynUwC3PY3ItsZWcw3qo0Svlr+Z1ENmI7JDySzS6H/s8MfVkqCiquXF5AtijUV6zM/B0Y
 DLqtwo0yQllAl/q6WA6AiUwpm+uMMEtXlx0SjcpXaahQpsCFy1XvEpPh/En6EuLnHDGM3D
 L6r2oMT9x8NWfCtisPW6xSSJSt7cg3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-8HrShVvlO16fW2WTx58qcg-1; Tue, 13 Apr 2021 01:47:53 -0400
X-MC-Unique: 8HrShVvlO16fW2WTx58qcg-1
Received: by mail-wr1-f72.google.com with SMTP id z7so305214wrs.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OW6XlN+3Md7fOqRvuUIIBXiaDESq3bj/UWHZYxmw3rg=;
 b=LUYaYCsZHl3SK5PcT+txZ50Ku+UYpt2vYOXsJyvOdefEloR2rLFP7NkqHhSK5C788S
 y/Y5tZlXbBtp+rt/dVxN9pkod1HQ4qsZiL0juFi9ufh8xhFw+ZCL8yyIsCgFklzzethy
 EMs+A6rJ7Qz/VnIAojTxEoo/yhgb5oydGOVHg0IBRcIQInAuKo4gzE1O6w+094iaKjng
 34WwcLDMObphjee8EqRph3dGAC/YDoaY6Y1lkUaeqO3Fl6D0fUa0YWoHAb3kMHFjitXq
 61mlTamaryaojTrjUWRH89gZNkYU1wOVYKWvjcJKYqohlLjaKTYVCWPeDIJ47e8vUUfe
 7dZQ==
X-Gm-Message-State: AOAM5339lqZ3y2KZzBgAXtR1Ck3OnBr3uXSTrtMz8pD54dQdg7WrhFyn
 O7OeyFqqdx9Qr/Rg+IgnSxPqu+ThYRX8yyNDrGAGrGKWuLXtWqydROc/wzJD3E8I5Vn/3DkBPnj
 JVJFBHFXpGGwpvIv0GsqwvNAtyuTOZVbFLqPosetQhQ==
X-Received: by 2002:adf:a119:: with SMTP id o25mr3698464wro.36.1618292872353; 
 Mon, 12 Apr 2021 22:47:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzugrMCgHzBRCH7TNerR9Wptk76ORGx3gbjK146NAkH2Klahpt7Wxc88266ddtl1FWE9ool+Q==
X-Received: by 2002:adf:a119:: with SMTP id o25mr3698453wro.36.1618292872241; 
 Mon, 12 Apr 2021 22:47:52 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id a7sm20378241wrn.50.2021.04.12.22.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 22:47:51 -0700 (PDT)
Date: Tue, 13 Apr 2021 01:47:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/4] virtio_net: disable cb aggressively
Message-ID: <20210413054733.36363-3-mst@redhat.com>
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

There are currently two cases where we poll TX vq not in response to a
callback: start xmit and rx napi.  We currently do this with callbacks
enabled which can cause extra interrupts from the card.  Used not to be
a big issue as we run with interrupts disabled but that is no longer the
case, and in some cases the rate of spurious interrupts is so high
linux detects this and actually kills the interrupt.

Fix up by disabling the callbacks before polling the tx vq.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 82e520d2cb12..16d5abed582c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1429,6 +1429,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
+		virtqueue_disable_cb(sq->vq);
 		free_old_xmit_skbs(sq, true);
 		__netif_tx_unlock(txq);
 	}
@@ -1582,6 +1583,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool use_napi = sq->napi.weight;
 
 	/* Free up any pending old buffers before queueing new ones. */
+	virtqueue_disable_cb(sq->vq);
 	free_old_xmit_skbs(sq, false);
 
 	if (use_napi && kick)
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
