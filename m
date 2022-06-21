Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EE9C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 16:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF32A404F4;
	Tue, 21 Jun 2022 16:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF32A404F4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GsxuVcuU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PbzyRRL7HS8a; Tue, 21 Jun 2022 16:13:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4CB7B4090D;
	Tue, 21 Jun 2022 16:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CB7B4090D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0DCEC0039;
	Tue, 21 Jun 2022 16:13:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B118EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8AE934061D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AE934061D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ofMdeg4ydneR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:13:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D13BD404F4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D13BD404F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655827981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us38wkS1w1HtLwDGe0amETwreFLuOach8d2EKXd31Cw=;
 b=GsxuVcuUVajaIt6OwoHzXwOFIwWpMwsca4qTB/IV7xw40N/9J90p4vpJp4mpW/C1z5vqpd
 360bUErhkUx9SXmVwvwU2atspAc5WgP3IdANAWmHBU+OOJVOhtnqpzNfEuTidIXCErFY7L
 D7yD2WZbuB8XOTmXnwRVi2gXusX7vig=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-s8FiYA2iMgOcLr49-bwsUg-1; Tue, 21 Jun 2022 12:13:00 -0400
X-MC-Unique: s8FiYA2iMgOcLr49-bwsUg-1
Received: by mail-qk1-f200.google.com with SMTP id
 bj2-20020a05620a190200b005084968bb24so16848914qkb.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Us38wkS1w1HtLwDGe0amETwreFLuOach8d2EKXd31Cw=;
 b=If3PGWxNsmUQalVi1abfLS0JVfj6mzjvDNF4OjTvnUOi4S/4Q3oGGD+8Y+uylGRB/V
 hRpTCsKhdY6IJBcP82mj+BdBxJfQY4FVIi9snGMmx5EFqYWlH0KiGcB28tTxFmapmTEL
 awYGrAgcHqY1Sk7Yjbl7vv/BvYNKxsmhLFQd9lJq5qDQxP1+k/9pl7Lwlg4bkh/rJGs6
 3fOUHdty7xhPV9n9rpJ7NqiQksXOoZ3d0u5ugZwUgboeSTy8xBHUWPfJe77xopCTNuzx
 pwxe04pBNEtjy95THvnMQ7aWo4lGxcgKbDKjta+jp4880/wPBnF3WghYfQJcibQbrfxc
 o6sA==
X-Gm-Message-State: AJIora9+rohV8PB4VlyG5GeWX7Lwja3ywU+KsxG9uH7FbIMMUj4MTxyt
 S3eMJPd1Gk2uH+wZ9wqfvzGK0IZep/hl6K9+pjehaE+GvXu9rYMHGGM05+hWs1fIyTltFVeLukv
 2OJfTsw21k+BZwndZbLR3mqpucLrhAVYIZTdOEqlJR/5dx3mVAM6hR4IqrrnXs+ulrTa5JwM+Cx
 71cC47xFg2X4p8hF/FLg==
X-Received: by 2002:a05:6214:260c:b0:470:4ef5:7148 with SMTP id
 gu12-20020a056214260c00b004704ef57148mr5662135qvb.64.1655827978898; 
 Tue, 21 Jun 2022 09:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvrFRrNcJ+au4R/VYre6s+gKDS5BiaCvxaBCHNWnLGeGFqTWc18xHBZcCYjImLqyQYkzHdrQ==
X-Received: by 2002:a05:6214:260c:b0:470:4ef5:7148 with SMTP id
 gu12-20020a056214260c00b004704ef57148mr5662096qvb.64.1655827978503; 
 Tue, 21 Jun 2022 09:12:58 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 20-20020ac85754000000b002f93554c009sm11663915qtx.59.2022.06.21.09.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 09:12:57 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 3/3] vdpa_sim_blk: call vringh_complete_iotlb() also in the
 error path
Date: Tue, 21 Jun 2022 18:12:52 +0200
Message-Id: <20220621161252.197173-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621160859.196646-1-sgarzare@redhat.com>
References: <20220621160859.196646-1-sgarzare@redhat.com>
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

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index ac86478845b6..de9cd9843143 100644
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
