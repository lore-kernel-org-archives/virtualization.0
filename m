Return-Path: <SRS0=2X6m=EE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AF4C2D0A3
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 13:34:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6169020759
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 13:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="D2WwOWKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6169020759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA4C8875E0;
	Thu, 29 Oct 2020 13:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id souUCH38LYSp; Thu, 29 Oct 2020 13:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD971875DA;
	Thu, 29 Oct 2020 13:34:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A03C5C088B;
	Thu, 29 Oct 2020 13:34:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03D32C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 13:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DFAF48641E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 13:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qFhdmxioEekj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 13:33:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B482586243
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 13:33:57 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id k10so1455016wrw.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=okqbNzFdwZPuRMdjzbPQXLm8pTjJ9aJfiEX+wWumIls=;
 b=D2WwOWKrdQmWDWCUjvY9eaPf2zDAMYB8TdU/SSTxil33av6cJkfaWCZX2s581e6tNv
 Gi/x9Ygo45uTti508Wan9u5R+7NTaJ0/1nRb/nS5nk7gJFuoIhhw7sT4LwUYHF7ZHYYa
 FuyG8xrrbEkRPL76kkl3fEmX4Z5tMrJqhMU0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=okqbNzFdwZPuRMdjzbPQXLm8pTjJ9aJfiEX+wWumIls=;
 b=J1bFhKJQZaWG77FzU1CHDHLm5crVhDHerH9GslVy4BaZwggQGcMZxGFBhWBbNGep0K
 zXfN2E7cmIUe20k8UFf539mh14QI7muPA/lBEaWr64qZotGGOrE81MtmJCyEN7aJK8+D
 C1VwDuXro3DIYBbaY5/DgQn+fsWmUL0yF2frR9bZ1mzEVcCvt8o4IkmTnHbLqfm0e20Z
 PJOMHzAgdEJdnRBGysxjNTRD7x3CLyHgVhIQEoVA49bnTm77rU/73WQVfNlSNZAsq30p
 ILoKMMOFpBcgP2U7Ckqp03gTvU+7DuW4aUl9dxTVi2ZRMzNOC9b8A+bBIQres5VKuOWk
 X95g==
X-Gm-Message-State: AOAM533AD54rxM7ImAwBFxCQvpudrnAUiB9qHh9t/ZO04qoGbhnMSM9d
 Z6qV6u2GUQrTnxhjlzMuKrNweg==
X-Google-Smtp-Source: ABdhPJwECelWl0Q5uLtp0RD46KHIttYNX4xjJA8dHiXIyessUl0H/6RZq/tvKmoSh2GysP6jYNFH8w==
X-Received: by 2002:adf:db51:: with SMTP id f17mr5651935wrj.126.1603978435680; 
 Thu, 29 Oct 2020 06:33:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l3sm5576804wmg.32.2020.10.29.06.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 06:33:55 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/qxl: Remove fbcon acceleration leftovers
Date: Thu, 29 Oct 2020 14:33:47 +0100
Message-Id: <20201029133347.4088884-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029101428.4058311-3-daniel.vetter@ffwll.ch>
References: <20201029101428.4058311-3-daniel.vetter@ffwll.ch>
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

v2: Somehow these structs provided the struct qxl_device pre-decl,
reorder the header to not anger compilers.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
---
 drivers/gpu/drm/qxl/qxl_drv.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 3602e8b34189..6239626503ef 100644
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
@@ -188,8 +174,6 @@ struct qxl_debugfs {
 	unsigned int num_files;
 };
 
-int qxl_debugfs_fence_init(struct qxl_device *rdev);
-
 struct qxl_device {
 	struct drm_device ddev;
 
@@ -271,6 +255,8 @@ struct qxl_device {
 
 #define to_qxl(dev) container_of(dev, struct qxl_device, ddev)
 
+int qxl_debugfs_fence_init(struct qxl_device *rdev);
+
 extern const struct drm_ioctl_desc qxl_ioctls[];
 extern int qxl_max_ioctl;
 
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
