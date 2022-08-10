Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B7FC00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2924402AA;
	Wed, 10 Aug 2022 09:44:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2924402AA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g6d+2kmn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSgV9yU932Zj; Wed, 10 Aug 2022 09:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4EBD2402D2;
	Wed, 10 Aug 2022 09:44:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EBD2402D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 265C9C0033;
	Wed, 10 Aug 2022 09:44:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8062EC0033
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A15A402BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A15A402BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u7hIqYrT3q_F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5340140289
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5340140289
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660124638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2PRyz9SGjKoLZlYF6JLzg9mzaDVsgEeEMI7cjuKE+0=;
 b=g6d+2kmnbpU+XRHrLhl5UCgqPqPjfHibfiADYpHaHU23kdsPBy2QWnoxxTutypr82XFh8W
 WG8iA66rinu/H+Tz7FqgGDpYddgT4xwvGAiKdgzGqxR4KlgQmRYdAItXNObAVKNFQH5ZRB
 aTwn+gDGji1Rz39Ky9Dtvy7DWW0r3AE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652--KLc3Q05Nq6-dsb_izImZA-1; Wed, 10 Aug 2022 05:43:57 -0400
X-MC-Unique: -KLc3Q05Nq6-dsb_izImZA-1
Received: by mail-wm1-f70.google.com with SMTP id
 a17-20020a05600c349100b003a545125f6eso844721wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 02:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=b2PRyz9SGjKoLZlYF6JLzg9mzaDVsgEeEMI7cjuKE+0=;
 b=qLpHuriwuNq359fQ3PZqtpElPtVT4H0tRmCaoafcj4SmO8vEE1BRP04dgrddGdnF5F
 XveuOCgjYVuyB2e4NP4MFbrKYzMF+60VUiDzlr4e9bb3uXAVPKc/PPDLciRyuO3iv0+q
 SxSKau7xZpm4GXx5SF3atD8OdUOQeJAH84krotPbdYRwrRwTu838Xy48LSHs1HvhxtT/
 nksP+PagThOj4FTy4BMrgxqIb5eBXD/0RG1guY3sh/a/yKIuuf3R0jmYlEbn8q0lovhl
 TL8wyQtrj6bRod1XaQllkqLjDpAic+iENjzpD/XAZhkVQwtvAJtHFniQ5sHfN6p1cK+g
 Uh7w==
X-Gm-Message-State: ACgBeo01VDF5LQuVMxdg5ed07Tt7nW9fy+XH2jiEN3+jDs9tx7d5DSkc
 V7PBMymRnQlWjdnVy0l1Eq/wsXZTJ4YfTyKunvf1cHZMIEE32rRD2f3Kb5z9Mt08yALjzz9cfoN
 1aHN/eWJQ3ahyCOGibPVWxA6gAKqHb58QqgEME+rtPpt97BrsL/sQ8wYrTJiAPtukZaqE1GCm3j
 ZIw5WZ4Iajjaf0/TcKtQ==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id
 b9-20020adfd1c9000000b0020fc3dce980mr16506754wrd.552.1660124635515; 
 Wed, 10 Aug 2022 02:43:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5G624psAQ0CDHz/tX9HGp8fAwlc2Q6jgDrVstRV8Ex4w7YsTXeGAp2caKRmTJ7VelfCf8tkg==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id
 b9-20020adfd1c9000000b0020fc3dce980mr16506738wrd.552.1660124635306; 
 Wed, 10 Aug 2022 02:43:55 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 q11-20020a5d658b000000b0021e4bc9edbfsm12921743wru.112.2022.08.10.02.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 02:43:54 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/4] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Date: Wed, 10 Aug 2022 11:43:46 +0200
Message-Id: <20220810094347.20449-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810094347.20449-1-sgarzare@redhat.com>
References: <20220810094347.20449-1-sgarzare@redhat.com>
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
