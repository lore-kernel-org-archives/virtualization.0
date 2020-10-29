Return-Path: <SRS0=2X6m=EE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A7FC55179
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 10:14:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FA22076E
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 10:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Hkxe6zs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FA22076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 84C7286B33;
	Thu, 29 Oct 2020 10:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lxbi2reFlHQL; Thu, 29 Oct 2020 10:14:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C55A86964;
	Thu, 29 Oct 2020 10:14:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED5EC0859;
	Thu, 29 Oct 2020 10:14:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62C0FC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 10:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 565B887593
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 10:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eQMS7GpxzB94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 10:14:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 15C8487590
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 10:14:37 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id a9so2066479wrg.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NH1wgxZzmNr+f4f/izYOW3Kn2sqLIMMHcPJO+vFYPj8=;
 b=Hkxe6zs+S5dTbcwUFC1+X5+n49A/SNSvIY83JbI54r1aawzTNDh5eYWpvB4WVQ91tB
 krPLqS63geCdVbXeMPHR+G6sOa+/n9rlBSdBs0haU3LWOIezU0gcsY0Jqby2ilee5eJt
 lLT7Oth/y1jCjqPGrmzJ0jBhsSuR5H3bwiXjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NH1wgxZzmNr+f4f/izYOW3Kn2sqLIMMHcPJO+vFYPj8=;
 b=CnMTEEirFuEACCgCPVCUvplr0ZOIOwUbD7MLN9gbt1pRYOxa8arE7+4rKocx3bbD7V
 erGSTkuSu7+/j/hO0XcsLqtTvNUBOstFzQbnNOqRlkCex3rvL/+VkVZNFvVl92rBwHSj
 VdIB/7h3zlyWXPUZxeKy2UoALvnGisQVHVUxnhvt0s+vXFOZFCyx+CbffvfkfeGYdFqY
 H7SVH124IiErs2uwR5fBcSnRjOIwEeuwl+C+NhkJK1I+2V/HOwCxiJZujbGkaO8Biq4x
 LTE2Q6Pn3sQdZlt50TVuj2+eNYFtFoW4NQlCps/Dkm8sNC8TCT1rcZO9+1hfI3P95Da6
 1NJw==
X-Gm-Message-State: AOAM530U52YlQZodI7FLjKAnP2SWfD94B58GyEkA+Zj9T8KsTWfFWEUy
 yAiu8txMJi+a2iPhop0/PMc4aA==
X-Google-Smtp-Source: ABdhPJwKhZUv0/sxV9eMLtbW41ionD/GZOnsN7WT3fFy3s7vVW47Q/DgBSrBxSdS4kDGU3LeYplh0A==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr4370597wro.328.1603966476296; 
 Thu, 29 Oct 2020 03:14:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id e5sm3897753wrw.93.2020.10.29.03.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 03:14:35 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/qxl: Remove fbcon acceleration leftovers
Date: Thu, 29 Oct 2020 11:14:28 +0100
Message-Id: <20201029101428.4058311-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029101428.4058311-1-daniel.vetter@ffwll.ch>
References: <20201029101428.4058311-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Cc: spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@redhat.com>
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

These are leftovers from 13aff184ed9f ("drm/qxl: remove dead qxl fbdev
emulation code").

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
---
 drivers/gpu/drm/qxl/qxl_drv.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 3602e8b34189..86eee66ecbad 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -166,20 +166,6 @@ struct qxl_drm_image {
 	struct list_head chunk_list;
 };
 
-struct qxl_fb_image {
-	struct qxl_device *qdev;
-	uint32_t pseudo_palette[16];
-	struct fb_image fb_image;
-	uint32_t visual;
-};
-
-struct qxl_draw_fill {
-	struct qxl_device *qdev;
-	struct qxl_rect rect;
-	uint32_t color;
-	uint16_t rop;
-};
-
 /*
  * Debugfs
  */
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
