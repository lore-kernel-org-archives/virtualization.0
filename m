Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DDFC4332F
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 02:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D28F60BC8;
	Tue, 27 Dec 2022 02:25:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D28F60BC8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7HVylYQ0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y9MDs3GlE0E7; Tue, 27 Dec 2022 02:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E42860BD7;
	Tue, 27 Dec 2022 02:25:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E42860BD7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E501C0035;
	Tue, 27 Dec 2022 02:25:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3A26C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1301404CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1301404CC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=7HVylYQ0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OMRkUYaFCZug
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C631F402C0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C631F402C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:50 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 c8-20020a17090a4d0800b00225c3614161so8896690pjg.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 18:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvMG7HI+MNWsEUIqh/BKpMAFptkHeZ7mWrh2CvuyciY=;
 b=7HVylYQ0632scSj+HTgHmiMQ9nmof478HLpvsoucgyabAEQZNGTPT3Z/qsis+kC59W
 z35iuuygucSkTPXxU2rQzouhhLGAIzGkvF3m7pk5+8xBSsGt+CbSN0lbq8ILUybz57yy
 cLyKQLDjZ6MgxEg4kRt1+iYywQ7HR8xyrDuFAzQVwnJcLNyWbuKPoxsVqhr721slS4Za
 O9+JHGODB/C27e+6KSmMqvmV9uRuZbcKyXuSTupy/YfskVRR+/DQMQ21jpFiz/NpFOp6
 qAegzBRb6C6gPU9eBEYbHN/r+zXNOUUvJ1CgMxl8Ye95yh50MnJl1XQGHGC7x49OYu+h
 WUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvMG7HI+MNWsEUIqh/BKpMAFptkHeZ7mWrh2CvuyciY=;
 b=60zioGTZFw2YAwQe+M6FqBZrAjQAKEfJsbOcako9rTawolp17SrFRVjFz9U5pcSp4R
 DgJRwsUYQ+PlS3g3XTbVp/ruYV1Q1bYRERvP5DRcropdOcEPdjBTGmAmT8bf0EQxh8Tu
 zxQscCc5giZIU0FwlEgBU0N/By0w46+kAM/ORFZ4/wfnmqNP54floyxK2aZ54UufgZ5/
 4OHDFve7EV2RSXDmBhKeLy95aAG4KJZFqbLQHOOv9gFucHmjGZhMvhzAXQvTQkgOoSeJ
 yZYgY6xxKSw2k4eR0rAztntV7uPMUl0CZpR1gI3n4KWdRgcVgSYfdZkMsTjta4JRVFAk
 oWxA==
X-Gm-Message-State: AFqh2koyP4qqX8zKiOQ7l0fgrWfjNk4/IK856PMnRnsvDigTJ68nepDB
 qnAZwQqle69WiWXQTXMdiwqf+A==
X-Google-Smtp-Source: AMrXdXsCQQEPIYOXi9oM5ZYP8gBVlj2VmXkt8bjfLAfaQc9Y/meV2EpOLBa5VvOmiNYjdHQCuyrHug==
X-Received: by 2002:a17:902:a584:b0:18f:ac9f:29f6 with SMTP id
 az4-20020a170902a58400b0018fac9f29f6mr21116232plb.50.1672107950201; 
 Mon, 26 Dec 2022 18:25:50 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a1709026f0f00b001870dc3b4c0sm2465014plk.74.2022.12.26.18.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 18:25:49 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 6/9] caif_virtio: convert to new unified vringh APIs
Date: Tue, 27 Dec 2022 11:25:28 +0900
Message-Id: <20221227022528.609839-7-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227022528.609839-1-mie@igel.co.jp>
References: <20221227022528.609839-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

vringh_*_kern APIs are being removed without vringh_init_kern(), so change
to use new APIs.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/net/caif/caif_virtio.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 0b0f234b0b50..f9dd79807afa 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -265,18 +265,12 @@ static int cfv_rx_poll(struct napi_struct *napi, int quota)
 		 */
 		if (riov->i == riov->used) {
 			if (cfv->ctx.head != USHRT_MAX) {
-				vringh_complete_kern(cfv->vr_rx,
-						     cfv->ctx.head,
-						     0);
+				vringh_complete(cfv->vr_rx, cfv->ctx.head, 0);
 				cfv->ctx.head = USHRT_MAX;
 			}
 
-			err = vringh_getdesc_kern(
-				cfv->vr_rx,
-				riov,
-				NULL,
-				&cfv->ctx.head,
-				GFP_ATOMIC);
+			err = vringh_getdesc(cfv->vr_rx, riov, NULL,
+					     &cfv->ctx.head);
 
 			if (err <= 0)
 				goto exit;
@@ -317,9 +311,9 @@ static int cfv_rx_poll(struct napi_struct *napi, int quota)
 
 		/* Really out of packets? (stolen from virtio_net)*/
 		napi_complete(napi);
-		if (unlikely(!vringh_notify_enable_kern(cfv->vr_rx)) &&
+		if (unlikely(!vringh_notify_enable(cfv->vr_rx)) &&
 		    napi_schedule_prep(napi)) {
-			vringh_notify_disable_kern(cfv->vr_rx);
+			vringh_notify_disable(cfv->vr_rx);
 			__napi_schedule(napi);
 		}
 		break;
@@ -329,7 +323,7 @@ static int cfv_rx_poll(struct napi_struct *napi, int quota)
 		dev_kfree_skb(skb);
 		/* Stop NAPI poll on OOM, we hope to be polled later */
 		napi_complete(napi);
-		vringh_notify_enable_kern(cfv->vr_rx);
+		vringh_notify_enable(cfv->vr_rx);
 		break;
 
 	default:
@@ -337,12 +331,12 @@ static int cfv_rx_poll(struct napi_struct *napi, int quota)
 		netdev_warn(cfv->ndev, "Bad ring, disable device\n");
 		cfv->ndev->stats.rx_dropped = riov->used - riov->i;
 		napi_complete(napi);
-		vringh_notify_disable_kern(cfv->vr_rx);
+		vringh_notify_disable(cfv->vr_rx);
 		netif_carrier_off(cfv->ndev);
 		break;
 	}
 out:
-	if (rxcnt && vringh_need_notify_kern(cfv->vr_rx) > 0)
+	if (rxcnt && vringh_need_notify(cfv->vr_rx) > 0)
 		vringh_notify(cfv->vr_rx);
 	return rxcnt;
 }
@@ -352,7 +346,7 @@ static void cfv_recv(struct virtio_device *vdev, struct vringh *vr_rx)
 	struct cfv_info *cfv = vdev->priv;
 
 	++cfv->stats.rx_kicks;
-	vringh_notify_disable_kern(cfv->vr_rx);
+	vringh_notify_disable(cfv->vr_rx);
 	napi_schedule(&cfv->napi);
 }
 
@@ -460,7 +454,7 @@ static int cfv_netdev_close(struct net_device *netdev)
 	/* Disable interrupts, queues and NAPI polling */
 	netif_carrier_off(netdev);
 	virtqueue_disable_cb(cfv->vq_tx);
-	vringh_notify_disable_kern(cfv->vr_rx);
+	vringh_notify_disable(cfv->vr_rx);
 	napi_disable(&cfv->napi);
 
 	/* Release any TX buffers on both used and available rings */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
