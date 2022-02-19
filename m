Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ECBC4332F
	for <virtualization@archiver.kernel.org>; Sat, 19 Feb 2022 17:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9798181D4F;
	Sat, 19 Feb 2022 17:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gYegPBXxsFWw; Sat, 19 Feb 2022 17:02:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B8ED81BC6;
	Sat, 19 Feb 2022 17:02:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3E42C0011;
	Sat, 19 Feb 2022 17:02:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4D37C000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 17:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBE474020B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 17:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gl_9HwRtPlNo
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 17:02:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54392400B8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 17:02:34 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 cp23-20020a17090afb9700b001bbfe0fbe94so1288621pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JDxmYIM8I0UHDFtNzfKhVrh+LAL9uJ//iBVpmzyjpD8=;
 b=bfkvqTNbGC0DdhOwIPwSY1qRb5B76PXNb+SxqNRNze7cN4qBNLEeT8w6zuE3/mnqZ3
 kFid1tcwL7jpwjSkXTnqiwAZewoU205uGxuOTAXWKfEGjxcKHhlo4uGdsl0X9xYWSy7O
 pcR6hGH8Gj2w104R5RudiEEdh5FwOr2AawvwM2teKU/syLKY/mPHG0x01Nzt7Tli1XZ7
 ag4X2mFLvKpXVNkB34OEWmWl9EEQiVHgt3x6nVEF9S5NaSTUmKH2IMqjSCGyB6sUoORz
 S3zZqQAjGK13Uonrb8g6bKGEOZ6gP4zV+OwooUgHOWrrDwHfBIdyqzmEJJQSpvNXgclS
 xSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JDxmYIM8I0UHDFtNzfKhVrh+LAL9uJ//iBVpmzyjpD8=;
 b=bm2YGRcVr3yRUqEAf2e6qsY28lYBN7XCOm1yVe/3IhV/1fwdHA6iewKkdOtMfmRgVz
 xKwFBLm5cdeESnBXM0mdeIGOq8U73LRoM8rYZt8koE4LWe+Az9XsHrZ35PXGKpVWF55L
 3iMACnxjQAOgsedt+fUDtZSZcsQ2XLZZYArYgmGgzGC0lerNMG8jYpisWDRHX0Rm7ZlT
 ihy+5y20L5r0MHDwOx/dPgVZUl4hRde0fJ6Z4fRnM8m4dIS23+FrwD4WuwLFNcp9C+SR
 IRvEBZszCLR6WP1TOCa+J4oJyQmi2r2MHhNHesm4C+t1m+ocnTc0fajZiuFNib+wYCif
 D5vQ==
X-Gm-Message-State: AOAM532df7MfHvTi9irwGea144a9rAJkvW7iBoeXoA4sh+6vsnpa3LfZ
 vAbXOqjbW/wMqLyBpZQYbvA=
X-Google-Smtp-Source: ABdhPJwNFTzgFD5Dxvg2t7x24UnqKLQIqCny6cm/SHjHpm8VoDCpT63w7lHReOZLzg/mrOjXulYbaA==
X-Received: by 2002:a17:90b:117:b0:1b8:e632:c589 with SMTP id
 p23-20020a17090b011700b001b8e632c589mr13581026pjz.26.1645290153686; 
 Sat, 19 Feb 2022 09:02:33 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 z16sm6244371pfw.159.2022.02.19.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Feb 2022 09:02:32 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Remove restriction of non-zero blob_flags
Date: Sat, 19 Feb 2022 09:03:01 -0800
Message-Id: <20220219170301.545432-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

With native userspace drivers in guest, a lot of GEM objects need to be
neither shared nor mappable.  And in fact making everything mappable
and/or sharable results in unreasonably high fd usage in host VMM.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
This is for a thing I'm working on, a new virtgpu context type that
allows for running native userspace driver in the guest, with a
thin shim in the host VMM.  In this case, the guest has a lot of
GEM buffer objects which need to be neither shared nor mappable.

This supersedes https://patchwork.freedesktop.org/patch/475127/

 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 69f1952f3144..3a8078f2ee27 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -617,8 +617,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	if (!vgdev->has_resource_blob)
 		return -EINVAL;
 
-	if ((rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK) ||
-	    !rc_blob->blob_flags)
+	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
 		return -EINVAL;
 
 	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
