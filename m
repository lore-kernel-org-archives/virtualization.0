Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04F6C25B0D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D48D81A6A;
	Thu, 11 Aug 2022 08:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D48D81A6A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LApbRdDp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iN_0n6zyFYkH; Thu, 11 Aug 2022 08:36:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D521981410;
	Thu, 11 Aug 2022 08:36:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D521981410
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1338C007C;
	Thu, 11 Aug 2022 08:36:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4C9DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D9C040C6B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D9C040C6B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LApbRdDp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tTB_tGbYtnCH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF98240C62
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF98240C62
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660207007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2PRyz9SGjKoLZlYF6JLzg9mzaDVsgEeEMI7cjuKE+0=;
 b=LApbRdDpEOrldF/Mn/eCaUjf9zmI/D0E01G5v6oMoyKepkc/vYeawnTxxwi8sE3RgvsU1N
 D3kc4Xnybncso9OI77/qG6wlK0wYwZafMuWjGIeu/2C47VV19cAuolrXUKrLtYt9mz6UkY
 j+MeWpOfEVSfjSBGIoD9+UpIo6Mymh4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-Y5RU4bwrM5KbI8NAD0D1xw-1; Thu, 11 Aug 2022 04:36:47 -0400
X-MC-Unique: Y5RU4bwrM5KbI8NAD0D1xw-1
Received: by mail-qk1-f199.google.com with SMTP id
 de4-20020a05620a370400b006a9711bd9f8so14224628qkb.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=b2PRyz9SGjKoLZlYF6JLzg9mzaDVsgEeEMI7cjuKE+0=;
 b=IDCPCjZlvl8tjkYqoAa0+W26SXdn2Io0msHAmRfHe72xkJrIYWtbCPJveH6z9PZDwZ
 L4rYWAd4r+a7EjoJErXo1Z0yiofxHEMN88JJW2lx2PnBIWfWJlG6HqyEoj8JrPjSU07c
 cHR1W66twPrVu8M7QdW2Dcvzbfiv6qyCdYRQLNdK4rkWBMHNyGJrHYMyf64/0v4RoiHr
 srMdiYIO+DqPVe+8KsUV96RQJSq/S7zx29kbOB+LqzfZLNaNs1jAMLAeEqnw+6zogeT6
 /0M4yVCdqE5pjElcVJxJpfSbgZ4ZciCycqdGKxJFAZ8TUhs3jkgtg/Ri/wgUtXNsdxQS
 PyTA==
X-Gm-Message-State: ACgBeo2Wx7nGEPLE8gt5gvBIk6QMK/SXU7NVUmM5WqSu72hU5D0fQLGV
 QiOL78jCofY71LxDcZmN+AktEdI6tQrmBXMCIn5j+1SrXTXLb1Hr+hrtm7xD/okRjDl7CKUwVsS
 WZzAxSt6W2dcxah4tzfJ8diKkAK8RZlhPfjwwotRAqBAJZGDWH3069C48nUiN/djm/HGwGre6H4
 7cPxD48fWx44xD/9jCPQ==
X-Received: by 2002:a05:622a:54a:b0:343:5a1a:9acd with SMTP id
 m10-20020a05622a054a00b003435a1a9acdmr5424740qtx.194.1660207006178; 
 Thu, 11 Aug 2022 01:36:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4RFzgc5ALPcjlt3FX7MEe3xJX2GOatlwsfQrEhnbVqaD+RWcWMD5dC4uSCC4mr/t0kzhgpuw==
X-Received: by 2002:a05:622a:54a:b0:343:5a1a:9acd with SMTP id
 m10-20020a05622a054a00b003435a1a9acdmr5424728qtx.194.1660207005928; 
 Thu, 11 Aug 2022 01:36:45 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 ga25-20020a05622a591900b0034361fb2f75sm1343083qtb.22.2022.08.11.01.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:36:45 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 3/4] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Date: Thu, 11 Aug 2022 10:36:31 +0200
Message-Id: <20220811083632.77525-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811083632.77525-1-sgarzare@redhat.com>
References: <20220811083632.77525-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

The simulator behaves like a ramdisk, so we don't have to do
anything when a VIRTIO_BLK_T_FLUSH request is received, but it
could be useful to test driver behavior.

Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
that we support the flush command.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 24dd9cae6450..1f18f336cf0c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -25,6 +25,7 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDPASIM_BLK_FEATURES	(VDPASIM_FEATURES | \
+				 (1ULL << VIRTIO_BLK_F_FLUSH)    | \
 				 (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
 				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
 				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
@@ -188,6 +189,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		pushed += bytes;
 		break;
 
+	case VIRTIO_BLK_T_FLUSH:
+		/* nothing to do */
+		break;
+
 	default:
 		dev_dbg(&vdpasim->vdpa.dev,
 			"Unsupported request type %d\n", type);
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
