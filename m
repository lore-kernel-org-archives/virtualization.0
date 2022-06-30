Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED09CCA47B
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 15:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2E95411AA;
	Thu, 30 Jun 2022 15:32:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2E95411AA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OQ4u4Nh0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pp2mwUORCEHW; Thu, 30 Jun 2022 15:32:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 303DE411B9;
	Thu, 30 Jun 2022 15:32:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 303DE411B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC52FC0039;
	Thu, 30 Jun 2022 15:32:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 443F0C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2DBD981B35
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DBD981B35
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OQ4u4Nh0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvslDl-zpgy0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FD1A8144F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FD1A8144F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656603151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRre2mmiUkpHj1mcdypLppTGL5vL6JLZXVbGfJnDALg=;
 b=OQ4u4Nh0FDZDABTecc6CHcgtW+jyslG3ctatVGBLz9NZT2Dlh1iefhCduo9m8evMbxLdMh
 mGkiTXtV4FrbW7T4Ho5GKXLC7aTz2l0YL7YmeDR/5Dg52Idm9v8yVJAZA/MUyQb2CpnHNP
 uRZBUNNRYR3/PVT0eTwS9wNFmglYHLM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-i51Arf-lO0ed8wVo_zZhvw-1; Thu, 30 Jun 2022 11:32:30 -0400
X-MC-Unique: i51Arf-lO0ed8wVo_zZhvw-1
Received: by mail-qk1-f199.google.com with SMTP id
 bk12-20020a05620a1a0c00b006b194656099so3583805qkb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rRre2mmiUkpHj1mcdypLppTGL5vL6JLZXVbGfJnDALg=;
 b=2iu5LaQOoqHwfak5ybwjolVg5Zs+TZSUuswMbZOw7S49gf4w3f+d43dFaKN+tCEcsL
 3CLCyMLkiWLTzIGrKzGH7mlSKTA8/BvjQnabjXPk7RsUIOOTTp5HbV7KLHcg7OYGc/9f
 n8yAVcycaPnrKmOyjA23GmP2s8vB+3nUMat0FpQQOmcOjF3JK340TmB8aVsO64kA3+9Z
 EY64Jh9N5hf4ii/sg0FvR4vYvzLMuIbx4fFPRMrfQ3kXZI6oKCniuxRZVrU+pxHoufdV
 sK06qmFZ+QBi4ASQdh69DUEB+qqWU/bTISs8Ak8VkbJZty8g8BcUc9gdLhq0G2ysFwNL
 8aPA==
X-Gm-Message-State: AJIora8VtgITNof/CRgJxda+9LlczTN9Pky+USC7L0DAVeWQmZYdYddl
 WtN0Ez9OhAuPOY04HouYxfbTPcQE2f02PB/9ACH44zCWEVT2QSEKDs6ksIs/wLE39UuRZv30GFW
 KLbYyPxqvF8UiG2x1FSYV1qW/d8OJ/GV89ujkXNb1e8jUeqeAWyMbbkjiPKbRdoBma/xN1Y1jdh
 ZsSp4NzD/f6rs/6v0QcA==
X-Received: by 2002:a05:620a:40cf:b0:6b1:41dd:9710 with SMTP id
 g15-20020a05620a40cf00b006b141dd9710mr6329778qko.727.1656603149436; 
 Thu, 30 Jun 2022 08:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAcFYzWpyw+b6fujbaqZt6VZhUiFDHom86OOiiyoqB6cQlPZGEL6VrqMoaZqdOzN2T9zXkXA==
X-Received: by 2002:a05:620a:40cf:b0:6b1:41dd:9710 with SMTP id
 g15-20020a05620a40cf00b006b141dd9710mr6329749qko.727.1656603149110; 
 Thu, 30 Jun 2022 08:32:29 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-149.retail.telecomitalia.it.
 [87.11.6.149]) by smtp.gmail.com with ESMTPSA id
 y20-20020a05620a44d400b006af0639f7casm16089325qkp.12.2022.06.30.08.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 08:32:28 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/3] vdpa_sim_blk: use dev_dbg() to print errors
Date: Thu, 30 Jun 2022 17:32:19 +0200
Message-Id: <20220630153221.83371-2-sgarzare@redhat.com>
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

Use dev_dbg() instead of dev_err()/dev_warn() to avoid flooding the
host with prints, when the guest driver is misbehaving.
In this way, prints can be dynamically enabled when the vDPA block
simulator is used to validate a driver.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 42d401d43911..a83a5c76f620 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -76,13 +76,13 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		return false;
 
 	if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
-		dev_err(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
+		dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
 			vq->out_iov.used, vq->in_iov.used);
 		return false;
 	}
 
 	if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
-		dev_err(&vdpasim->vdpa.dev, "request in header too short\n");
+		dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
 		return false;
 	}
 
@@ -96,7 +96,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
 				      sizeof(hdr));
 	if (bytes != sizeof(hdr)) {
-		dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
+		dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
 		return false;
 	}
 
@@ -110,7 +110,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
 		if (!vdpasim_blk_check_range(sector, to_push)) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"reading over the capacity - offset: 0x%llx len: 0x%zx\n",
 				offset, to_push);
 			status = VIRTIO_BLK_S_IOERR;
@@ -121,7 +121,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim->buffer + offset,
 					      to_push);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
 				bytes, offset, to_push);
 			status = VIRTIO_BLK_S_IOERR;
@@ -133,7 +133,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 
 	case VIRTIO_BLK_T_OUT:
 		if (!vdpasim_blk_check_range(sector, to_pull)) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"writing over the capacity - offset: 0x%llx len: 0x%zx\n",
 				offset, to_pull);
 			status = VIRTIO_BLK_S_IOERR;
@@ -144,7 +144,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim->buffer + offset,
 					      to_pull);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
 				bytes, offset, to_pull);
 			status = VIRTIO_BLK_S_IOERR;
@@ -157,7 +157,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim_blk_id,
 					      VIRTIO_BLK_ID_BYTES);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd\n", bytes);
 			status = VIRTIO_BLK_S_IOERR;
 			break;
@@ -167,8 +167,8 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 
 	default:
-		dev_warn(&vdpasim->vdpa.dev,
-			 "Unsupported request type %d\n", type);
+		dev_dbg(&vdpasim->vdpa.dev,
+			"Unsupported request type %d\n", type);
 		status = VIRTIO_BLK_S_IOERR;
 		break;
 	}
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
