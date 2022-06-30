Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D90C43334
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 15:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C41D84242F;
	Thu, 30 Jun 2022 15:32:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C41D84242F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B/KcYY2s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TAbW6Kkd5-Z; Thu, 30 Jun 2022 15:32:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 019144242A;
	Thu, 30 Jun 2022 15:32:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 019144242A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C404DC002D;
	Thu, 30 Jun 2022 15:32:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A48DEC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CD34415A2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CD34415A2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B/KcYY2s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ekGeLySRApXE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90EEE40B1D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90EEE40B1D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656603157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyBXlP1VN/1Hl0hvlI7YsnhG2HRfml5jOvtsaK2qf2k=;
 b=B/KcYY2shGmNtfcDC2cc0d/vN6gQ6EI07j6yk3ZYPZ5zPRk350+BJIMs4irQxflqwCa67K
 pWuLDIw1e3YNCEaheSlPWaNc/SuRXkcM7xWNv2kyzCIfHUuKqpYiqFCDe4wVLpsuD+bXvd
 s/e1Ayb8HBs2Ezw/JS6mIDow5Tl8DSw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-9iIcL0LPOHG-o-AJNCOP3w-1; Thu, 30 Jun 2022 11:32:36 -0400
X-MC-Unique: 9iIcL0LPOHG-o-AJNCOP3w-1
Received: by mail-qv1-f72.google.com with SMTP id
 mr11-20020a056214348b00b004705c0cb439so18779164qvb.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zyBXlP1VN/1Hl0hvlI7YsnhG2HRfml5jOvtsaK2qf2k=;
 b=K7rplIvyyKzcfBI9J+8EumK4EROIOPFPPEGRzmslDxUlUPPuRQLkNPbH9LwqA0B3+p
 1/FU/4s/Me+u+37d62QWPWEMlix388Bqh4UQOw8ZKCq2uJlie9kmZB2LYIlqqNaDw7It
 Up8R6SUqOFm5FU7ijSmfKg0RdRS2xeV14rnybYnjTBUHBXxC7JbLuocYsnRo7anPrPG/
 bPmDvCBHEEKke4QVJwS3z/t+cZhWljHqLcGSeDMqloncYRV6MLBHt/LhE26sNi98EJc5
 v1IzYxNskRG8rHWQd7WiwwgpE6PfsbTKf6AFdFWsalj2x2uDesLBJzn9BBMMXKi0oZJi
 h6Iw==
X-Gm-Message-State: AJIora9IJfTsLplvNwrXGtlYmHnKuoxl60vjElhjW/xCG3uW95z5xs6Z
 /fpwrlk3ktqbgAWUOdvEGaR/RmTiWyMOjjwbEJFLgCgWtdLQf51TDKwNBxkP+oJYKHFboAcAdRq
 kgo1U9ixqcTwNC1VGU8fjypdyIGrgu7Kt4OagbKzjvYXt+j3mQcs2Dcu0RW7dAg7QN7WJFh5gUJ
 HHIhatxnsux6IyBa/Qtg==
X-Received: by 2002:a05:620a:270b:b0:6af:18bb:277c with SMTP id
 b11-20020a05620a270b00b006af18bb277cmr6751648qkp.510.1656603155470; 
 Thu, 30 Jun 2022 08:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vTc+Nr9zLyCxjBRj8LAHRagLUk1vEK4xwZW8noBEmXngs6Q+g5xoMvq7ks4Sz5hZUgCP5u0A==
X-Received: by 2002:a05:620a:270b:b0:6af:18bb:277c with SMTP id
 b11-20020a05620a270b00b006af18bb277cmr6751612qkp.510.1656603155026; 
 Thu, 30 Jun 2022 08:32:35 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-149.retail.telecomitalia.it.
 [87.11.6.149]) by smtp.gmail.com with ESMTPSA id
 y20-20020a05620a44d400b006af0639f7casm16089325qkp.12.2022.06.30.08.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 08:32:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/3] vdpa_sim_blk: call vringh_complete_iotlb() also in the
 error path
Date: Thu, 30 Jun 2022 17:32:21 +0200
Message-Id: <20220630153221.83371-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630153221.83371-1-sgarzare@redhat.com>
References: <20220630153221.83371-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

Call vringh_complete_iotlb() even when we encounter a serious error
that prevents us from writing the status in the "in" header
(e.g. the header length is incorrect, etc.).

The guest is misbehaving, so maybe the ring is in a bad state, but
let's avoid making things worse.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index b2d75efec63a..43422b3854d2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -63,6 +63,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 {
 	size_t pushed = 0, to_pull, to_push;
 	struct virtio_blk_outhdr hdr;
+	bool handled = false;
 	ssize_t bytes;
 	loff_t offset;
 	u64 sector;
@@ -78,12 +79,12 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
 		dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
 			vq->out_iov.used, vq->in_iov.used);
-		return false;
+		goto err;
 	}
 
 	if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
 		dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
-		return false;
+		goto err;
 	}
 
 	/* The last byte is the status and we checked if the last iov has
@@ -97,7 +98,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 				      sizeof(hdr));
 	if (bytes != sizeof(hdr)) {
 		dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
-		return false;
+		goto err;
 	}
 
 	to_pull -= bytes;
@@ -182,16 +183,19 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	/* Last byte is the status */
 	bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov, &status, 1);
 	if (bytes != 1)
-		return false;
+		goto err;
 
 	pushed += bytes;
 
 	/* Make sure data is wrote before advancing index */
 	smp_wmb();
 
+	handled = true;
+
+err:
 	vringh_complete_iotlb(&vq->vring, vq->head, pushed);
 
-	return true;
+	return handled;
 }
 
 static void vdpasim_blk_work(struct work_struct *work)
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
