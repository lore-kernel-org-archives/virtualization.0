Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76677ECAAD1
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 19:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D454841934;
	Wed, 31 Aug 2022 19:06:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D454841934
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=lRzt2fZi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JPr2mvc5Qu_3; Wed, 31 Aug 2022 19:06:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0995F41931;
	Wed, 31 Aug 2022 19:06:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0995F41931
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4A8DC0033;
	Wed, 31 Aug 2022 19:06:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C00DEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 19:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86A214012D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 19:06:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86A214012D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=lRzt2fZi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zuTbve98z9hm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 19:06:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9350400FB
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9350400FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 19:06:07 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 z3-20020a17090abd8300b001fd803e34f1so203970pjr.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=t9nkfZEyPsyobY4BF8QWflVAKFbRwcQ/dQ/3Tr/GPQ8=;
 b=lRzt2fZiaWLow8SiLm73H9pv8b9cRl7u+7+nwnwQ7Z0mkMQUznYorlPpHABLrcglg8
 InNdPtGVF2+ot1FxG9spMw/8yObsLBUJlA44b20855x8lH1rbSwew57f0eNpUArBZZHB
 QidKd8JfB1Ja0Ap3k9mWLvWGuITfFk27s2LlcH0SarQSxJHxSKheMH1NO0kUnQjmgafP
 eQ2qBkMqx8WOp22UYghY3Hl1pVzcBX4Ebz/IBYURByc3V23Nyz+hUjDv79lsjxunQR5I
 zk0REw/ud1Bu8kR5ZarYEExAhzJcMHuNFxNn7O/ZCe6DhmIPbEYNTZNDuQHzEv77wlY5
 /7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=t9nkfZEyPsyobY4BF8QWflVAKFbRwcQ/dQ/3Tr/GPQ8=;
 b=4cpgzJBHpoRp0YCh12g+FrkkOBUpFQqpdHLIZqbBgL7r3S/lj8Jugivb2Wg5TK4UnU
 exCPPOMwChynK1OYwf5jxQuY+FaztALLOf16V+VjH0JWWXjtiwjbVwUzantf212TkjpQ
 DULKRF1vsBuyHkwDbyyD7/laVa1/OX3olecq4OOIrVaYKbxe89JJrRXm7qb0yuUvigJn
 0OFy4Sh15NU13DdusuJTlP2hMFSViVRueDhZuu8r6M7U971HXrQAVZyDP9dJpPYTK6Nv
 4yx6sW8m0oYyKJVudN4Xl6vqqYQq+Dwey4PqO/SG4V9OdLRREGxfzqBAp4lSMwBuNpSq
 vCzw==
X-Gm-Message-State: ACgBeo0GTeZHxxueF4G9IK7NoN2xMZSTpeHFnUDJrskGt5zWV1oThNgG
 hZWMkm4KBiSiDOf0ECMf+M0=
X-Google-Smtp-Source: AA6agR7SDIMoAlSBJxWQT/X2ybX2wf4K1lJyY9hJUb5G5fk7kiBfspMw3I9UZZXBecrP7I+oYEAnQA==
X-Received: by 2002:a17:90b:1812:b0:1fd:d509:93e5 with SMTP id
 lw18-20020a17090b181200b001fdd50993e5mr4717865pjb.25.1661972767123; 
 Wed, 31 Aug 2022 12:06:07 -0700 (PDT)
Received: from olv-glaptop.corp.google.com
 ([2620:0:1000:2514:7dac:af8e:fd67:5cf7])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a62dec4000000b0053639773ad8sm11686053pfg.119.2022.08.31.12.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Aug 2022 12:06:06 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: set fb_modifiers_not_supported
Date: Wed, 31 Aug 2022 12:06:01 -0700
Message-Id: <20220831190601.1295129-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Cc: Shao-Chuan Lee <shaochuan@chromium.org>, David Airlie <airlied@linux.ie>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 virtualization@lists.linux-foundation.org, Tomohito Esaki <etom@igel.co.jp>
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

Without this, the drm core advertises LINEAR modifier which is
incorrect.

Also userspace virgl does not support modifiers.  For example, it causes
chrome on ozone/drm to fail with "Failed to create scanout buffer".

Fixes: 2af104290da5 ("drm: introduce fb_modifiers_not_supported flag in mode_config")
Suggested-by: Shao-Chuan Lee <shaochuan@chromium.org>
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 5c7f198c0712..9ea7611a9e0f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -349,6 +349,8 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 	vgdev->ddev->mode_config.max_width = XRES_MAX;
 	vgdev->ddev->mode_config.max_height = YRES_MAX;
 
+	vgdev->ddev->mode_config.fb_modifiers_not_supported = true;
+
 	for (i = 0 ; i < vgdev->num_scanouts; ++i)
 		vgdev_output_init(vgdev, i);
 
-- 
2.37.2.789.g6183377224-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
