Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44003C2B9F7
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23A361440
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23A361440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B959B83963;
	Wed, 26 May 2021 08:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UItA9l7hStku; Wed, 26 May 2021 08:24:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65E2D83926;
	Wed, 26 May 2021 08:24:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42389C000E;
	Wed, 26 May 2021 08:24:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 990B3C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 868A4605C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Xxv0GaRilvp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB7986069B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622017481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7hXo1aGEjC6ReUwtGmib1qGT2W6hQwxMtry8MQ3+Q5s=;
 b=U47H+rRtJmY8DaAWHr8udjajhdh1IzezqaeIFgZt8SOxSuPmxbgKF5QahW2EgYocOyLCXn
 jo0QQTm69X2Nf8T3PAat0VzW6shreM2w2rjwo5hVGACBCXZXcZXzalnkBWTMLL9oKo29G6
 f972H5GzY5iG1Kz7Pwn95hHOUNiAllg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-9gmAntqhOJCxN9gkMVG-kg-1; Wed, 26 May 2021 04:24:39 -0400
X-MC-Unique: 9gmAntqhOJCxN9gkMVG-kg-1
Received: by mail-wr1-f71.google.com with SMTP id
 u5-20020adf9e050000b029010df603f280so26879wre.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7hXo1aGEjC6ReUwtGmib1qGT2W6hQwxMtry8MQ3+Q5s=;
 b=LAHV5vSF8H+Y4XW6BjMx19GtMjRSPDV+1G6OJ4c+dem1BW/q2JlSxZZfGEynrprB6p
 qa2dMnHu9QJS0ymtJ5A/0ZXE1Lsk4xfxOGH9jzGz9kzKK7QowpWmKktwoq/C+URaloPq
 S1OMDQazEEqg4RWhx8OExx160swieOzcb4Knh9I56ZkGKMtxT/kMiYj7vxcuKUDDn8Z0
 k4OrFxZ2YB4RLGPeQ0bz7CtnMkBDuQNIiUDuupTIojag6m5s7D8ralZvq7d+XsdSju79
 7JcGr+x7zuBlP7c2Y1w5bU9ea2XWm65oGVoSfLS626hM+94JInq7heWJzNjJVuR9MdtW
 UMiA==
X-Gm-Message-State: AOAM533GbRcaHzQ3X/8KlsOhH+cL3r/txRFlt/a70GbUjbnpyI+BEdLv
 ZdkYcVIO2P3nRpm9iBRyP60BY4Bf7lYVJMvOHPaWCN+s19PbNVZ9X1JwMhdjFGuK7lYoLeMKRTJ
 wcC4DYLkOI0qFdrQUZRl5Z5WWOcwQCNyTQRlxFmCA5w==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr1578837wma.9.1622017477883;
 Wed, 26 May 2021 01:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU85p8gyLrf0vuWCAB2u049QkVe1v5Zh6lkfS/y/mIz9iaRTlYd6RVbAfTvvyvkld+1u+lAw==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr1578819wma.9.1622017477718;
 Wed, 26 May 2021 01:24:37 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
 by smtp.gmail.com with ESMTPSA id g6sm5469484wmg.10.2021.05.26.01.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:24:37 -0700 (PDT)
Date: Wed, 26 May 2021 04:24:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] virtio_net: move tx vq operation under tx queue lock
Message-ID: <20210526082423.47837-2-mst@redhat.com>
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

It's unsafe to operate a vq from multiple threads.
Unfortunately this is exactly what we do when invoking
clean tx poll from rx napi.
Same happens with napi-tx even without the
opportunistic cleaning from the receive interrupt: that races
with processing the vq in start_xmit.

As a fix move everything that deals with the vq to under tx lock.

Fixes: b92f1e6751a6 ("virtio-net: transmit napi")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac0c143f97b4..12512d1002ec 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1508,6 +1508,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
+	int opaque;
+	bool done;
 
 	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
 		/* We don't need to enable cb for XDP */
@@ -1517,10 +1519,28 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 
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
