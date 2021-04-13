Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B5FC433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:48:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A446109D
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A446109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4DD460B02;
	Tue, 13 Apr 2021 05:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yFQ9KcG5tqHx; Tue, 13 Apr 2021 05:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F0B0608E9;
	Tue, 13 Apr 2021 05:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58694C000B;
	Tue, 13 Apr 2021 05:48:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B33A0C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9485260B02
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiDI2IZcpl0y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4EA8608E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618292877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jg8BCGbpMnOAIkNzLWva23V8vKuJlUTOTl6SMonbbA=;
 b=fCcIv0LYgGUpI8R06kINj2Jh34BmCIIfIuoetroiTYty4A2JGQtDL4igiaQWCwOQEFArjc
 bCobrZCu35REpTam5WI06+FGj6zHGb2FaJ2X/fhzEwJma83X87OOoLYSRImFMsHym8QE8W
 ZMcfzjjLtaQ9xTVWJ5VZvR7eGINma8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-W7HKvL7cPA-ZiKalFQ2f4A-1; Tue, 13 Apr 2021 01:47:56 -0400
X-MC-Unique: W7HKvL7cPA-ZiKalFQ2f4A-1
Received: by mail-wr1-f71.google.com with SMTP id b4so309228wrq.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6jg8BCGbpMnOAIkNzLWva23V8vKuJlUTOTl6SMonbbA=;
 b=Ie+txgTbl8VdioRnQOsCt8UYQPRFgnVVQGq3f7AGPofa4CLsUa9EBEjvOO5FF/yXj9
 M+eulTMF/fDkONnpv/bWCK/MvrF9bIUdRgvUE7x3zBcHO+XObnDA6K0LO6p2QY3p+Qvj
 sizAC1cnAd86M/ihUETG673sgACqCwg6G9FziR+Vj9HPUqV6w9f5Z/82xwaCOMd6C1ji
 bUOqeO6YdoH/7r7SeaeXNrobptxHoTxEB4cTwAd9mvp0G33VZ1/nYuO4L+tyhV3EY8Qj
 PPWc32gQ+r4XoSzaMitmBO4yiF0YVLTiufsKEuAfecGZoK+2P/b/Ae9gwSVxXf9UyPc5
 30oA==
X-Gm-Message-State: AOAM531KpmnSOWo9BfsNraVxayLeK54RZaQ0zvf1jtDU4TtR46/rkNOV
 UWWXdN7nGwccFKnecaJhsEPweTYSlWZVtBGtUGqrQ1YlAf6SMkcEd1eJ5ZXkdTJAwPTpE3ot8U4
 ifnjG5/xqv3et4y76YcX551UuKZV7woRfmqYVaAFR1g==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr35572381wrt.4.1618292874759;
 Mon, 12 Apr 2021 22:47:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlOFgyL/tLR6N8M+xp6zE98QryIgkrAWDLF0SSu1myLxGcVLWj/Riydxj6MeQAxcymfF/BrA==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr35572375wrt.4.1618292874631;
 Mon, 12 Apr 2021 22:47:54 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id i4sm1264707wmq.12.2021.04.12.22.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 22:47:54 -0700 (PDT)
Date: Tue, 13 Apr 2021 01:47:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 3/4] virtio_net: move tx vq operation under tx queue
 lock
Message-ID: <20210413054733.36363-4-mst@redhat.com>
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

It's unsafe to operate a vq from multiple threads.
Unfortunately this is exactly what we do when invoking
clean tx poll from rx napi.
As a fix move everything that deals with the vq to under tx lock.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 16d5abed582c..460ccdbb840e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1505,6 +1505,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
+	int opaque;
+	bool done;
 
 	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
 		/* We don't need to enable cb for XDP */
@@ -1514,10 +1516,28 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
+	virtqueue_disable_cb(sq->vq);
 	free_old_xmit_skbs(sq, true);
+
+	opaque = virtqueue_enable_cb_prepare(sq->vq);
+
+	done = napi_complete_done(napi, 0);
+
+	if (!done)
+		virtqueue_disable_cb(sq->vq);
+
 	__netif_tx_unlock(txq);
 
-	virtqueue_napi_complete(napi, sq->vq, 0);
+	if (done) {
+		if (unlikely(virtqueue_poll(sq->vq, opaque))) {
+			if (napi_schedule_prep(napi)) {
+				__netif_tx_lock(txq, raw_smp_processor_id());
+				virtqueue_disable_cb(sq->vq);
+				__netif_tx_unlock(txq);
+				__napi_schedule(napi);
+			}
+		}
+	}
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
