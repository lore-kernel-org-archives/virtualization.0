Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8BBC00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 09:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3E1860F1B;
	Mon, 15 Aug 2022 09:17:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3E1860F1B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KoqsX+Hx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01r_4wJjfGaG; Mon, 15 Aug 2022 09:17:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C128360BC2;
	Mon, 15 Aug 2022 09:17:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C128360BC2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84984C0033;
	Mon, 15 Aug 2022 09:17:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F289DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 09:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8143408D0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 09:17:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8143408D0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KoqsX+Hx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZe_MwN8HwEr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 09:17:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9927740146
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9927740146
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660555021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=+lgH1hBRD1m/mzbQi1aYCWsf/2qMXaicGixcF+IMRPc=;
 b=KoqsX+Hx+/OsLZ98dyu6MVmoAOlultSiJ4MUjiRfyTYH/0js45wKLxEbKEVFfCt1/c8ceC
 8LfmCU1ox/jZJecq0Dggx7MLQMRBxDpHEe0PF0yX2LzX8dL8BHlzPgjmjtDsc8WCP5nVgM
 YOtUQq/+nlDgFVJpkKUQvqU8v6A+7Cc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-yf0fwPiYPASBDS56aHHHzA-1; Mon, 15 Aug 2022 05:16:58 -0400
X-MC-Unique: yf0fwPiYPASBDS56aHHHzA-1
Received: by mail-ej1-f71.google.com with SMTP id
 oz39-20020a1709077da700b007313bf43f0dso971292ejc.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 02:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=+lgH1hBRD1m/mzbQi1aYCWsf/2qMXaicGixcF+IMRPc=;
 b=ov5q/jY9sA2FcMDtZ8LYyJcIF5E72qbSbZk01lenng1GTLqfI8rGqeMTKulQVwPIg4
 0s1USLWqC2GPNIoYBIcCRNGocoDnEcM20Ql6SLf7TXOw09MPcj8Xd17wo9CNysg9rwJP
 Fzn+ZaEdfsLfEQU/LRbIu2ti+zJVsP82Vi9/8ejxMidK8uLli/Kqv+oqSow6VhLOipV4
 dCWRbjsoaUGLv1XfF5PVOFxZLf29bhd13YBBi2HDSlagf7NUlv3g3F/W6ycKWA5r+PmU
 7jpQ1pAdLNInHDsYpYLgaCW9IKjizIn745cwAHuuuyshJk+ZN4FSmkU1XQxW8V2g8Cvs
 G7aQ==
X-Gm-Message-State: ACgBeo0TdxCKeoy69nzibYXaNuJsKoLqbSL3GhDjksUYAQKDBDDRys18
 CL0Aq67ezC0abQJEBiQId3TrwU/HBZbGoZsqpL06lpwYLXpwe7B3whHS2VynYdJzFadqkt1lf91
 niGquhOGl2kJ0U99elgh64pASHPSBhvxygJn5a1ubxg==
X-Received: by 2002:a05:6402:1e8d:b0:441:58db:b6a2 with SMTP id
 f13-20020a0564021e8d00b0044158dbb6a2mr13472962edf.277.1660555017049; 
 Mon, 15 Aug 2022 02:16:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4TUuxXLf4X9ZxvGDLmurzNR+B1PhAkCo7uKtZy520YFWqKHF1q3eDJtrRUZuNuy6tNLwZeog==
X-Received: by 2002:a05:6402:1e8d:b0:441:58db:b6a2 with SMTP id
 f13-20020a0564021e8d00b0044158dbb6a2mr13472939edf.277.1660555016769; 
 Mon, 15 Aug 2022 02:16:56 -0700 (PDT)
Received: from redhat.com ([2.54.169.49]) by smtp.gmail.com with ESMTPSA id
 i20-20020a17090685d400b00722e50dab2csm3817610ejy.109.2022.08.15.02.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 02:16:56 -0700 (PDT)
Date: Mon, 15 Aug 2022 05:16:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815090521.127607-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andres Freund <andres@anarazel.de>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.

This has been reported to trip up guests on GCP (Google Cloud).  Why is
not yet clear - to be debugged, but the patch itself has several other
issues:

- It treats unknown speed as < 10G
- It leaves userspace no way to find out the ring size set by hypervisor
- It tests speed when link is down
- It ignores the virtio spec advice:
        Both \field{speed} and \field{duplex} can change, thus the driver
        is expected to re-read these values after receiving a
        configuration change notification.
- It is not clear the performance impact has been tested properly

Revert the patch for now.

Link: https://lore.kernel.org/r/20220814212610.GA3690074%40roeck-us.net
Link: https://lore.kernel.org/r/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de
Link: https://lore.kernel.org/r/3df6bb82-1951-455d-a768-e9e1513eb667%40www.fastmail.com
Link: https://lore.kernel.org/r/FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE%40anarazel.de
Fixes: 762faee5a267 ("virtio_net: set the default max ring size by find_vqs()")
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Andres Freund <andres@anarazel.de>
---
 drivers/net/virtio_net.c | 42 ++++------------------------------------
 1 file changed, 4 insertions(+), 38 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d934774e9733..ece00b84e3a7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3432,29 +3432,6 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
 		   (unsigned int)GOOD_PACKET_LEN);
 }
 
-static void virtnet_config_sizes(struct virtnet_info *vi, u32 *sizes)
-{
-	u32 i, rx_size, tx_size;
-
-	if (vi->speed == SPEED_UNKNOWN || vi->speed < SPEED_10000) {
-		rx_size = 1024;
-		tx_size = 1024;
-
-	} else if (vi->speed < SPEED_40000) {
-		rx_size = 1024 * 4;
-		tx_size = 1024 * 4;
-
-	} else {
-		rx_size = 1024 * 8;
-		tx_size = 1024 * 8;
-	}
-
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		sizes[rxq2vq(i)] = rx_size;
-		sizes[txq2vq(i)] = tx_size;
-	}
-}
-
 static int virtnet_find_vqs(struct virtnet_info *vi)
 {
 	vq_callback_t **callbacks;
@@ -3462,7 +3439,6 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	int ret = -ENOMEM;
 	int i, total_vqs;
 	const char **names;
-	u32 *sizes;
 	bool *ctx;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
@@ -3490,15 +3466,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 		ctx = NULL;
 	}
 
-	sizes = kmalloc_array(total_vqs, sizeof(*sizes), GFP_KERNEL);
-	if (!sizes)
-		goto err_sizes;
-
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
 		callbacks[total_vqs - 1] = NULL;
 		names[total_vqs - 1] = "control";
-		sizes[total_vqs - 1] = 64;
 	}
 
 	/* Allocate/initialize parameters for send/receive virtqueues */
@@ -3513,10 +3484,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 			ctx[rxq2vq(i)] = true;
 	}
 
-	virtnet_config_sizes(vi, sizes);
-
-	ret = virtio_find_vqs_ctx_size(vi->vdev, total_vqs, vqs, callbacks,
-				       names, sizes, ctx, NULL);
+	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
+				  names, ctx, NULL);
 	if (ret)
 		goto err_find;
 
@@ -3536,8 +3505,6 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 
 err_find:
-	kfree(sizes);
-err_sizes:
 	kfree(ctx);
 err_ctx:
 	kfree(names);
@@ -3897,9 +3864,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->curr_queue_pairs = num_online_cpus();
 	vi->max_queue_pairs = max_queue_pairs;
 
-	virtnet_init_settings(dev);
-	virtnet_update_settings(vi);
-
 	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
 	err = init_vqs(vi);
 	if (err)
@@ -3912,6 +3876,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	netif_set_real_num_tx_queues(dev, vi->curr_queue_pairs);
 	netif_set_real_num_rx_queues(dev, vi->curr_queue_pairs);
 
+	virtnet_init_settings(dev);
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
 		vi->failover = net_failover_create(vi->dev);
 		if (IS_ERR(vi->failover)) {
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
