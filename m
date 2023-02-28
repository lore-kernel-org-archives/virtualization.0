Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BE3C64ED6
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 15:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3C3981F75;
	Tue, 28 Feb 2023 15:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3C3981F75
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=NY9SP6qp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yH6LZOzzxja2; Tue, 28 Feb 2023 15:54:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2ED7181E98;
	Tue, 28 Feb 2023 15:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2ED7181E98
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05CDBC0033;
	Tue, 28 Feb 2023 15:54:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CE8DC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 15:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C249404AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 15:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C249404AF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=NY9SP6qp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vv5bNItID9GU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 15:54:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E215401D5
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E215401D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 15:54:11 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id y11so6767308plg.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xw2WUA8mFvMCKalxYRCZJO97ik9Rv3lPc280o9Y+fdQ=;
 b=NY9SP6qpNOYZLx9fij86g1bqzs4xbAG2fso2og2T3wxOd34OfdmRoXb95G6vCllXGL
 PObC2iguXamZOrzALd1IOlMkgb3UfOcm1SSJ8ixJnSIWP6HQEkRVEI8MdO3Lp3C/7Jgm
 hGLePAqnPzXMproE9miOH26dz4ePn9+5Jnz3Ial8doyAlkztj6ckSy2F6gxf7S+yKag3
 J9jG9+Of9x6z8c5PelYhQNyvLhQh8BSv6HGO/oa0vCPfcVM9MdleizR68DLRfycXp2lv
 ig0Zr7nlUZrhcXfz6ySzd8C5JPjWvCXvVhwGQUHzqvIqukIiwzLR6XI47A0+64gX8XmK
 WlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xw2WUA8mFvMCKalxYRCZJO97ik9Rv3lPc280o9Y+fdQ=;
 b=GNBj1ZUQW92ojx46JSIK3Tiw/JAFkw7DkZZoIBThTbe+t+ivPk7Zeg8lC5HEOYyQYo
 ILudzQU2DRF2UEf3HfVMH+Q1tjQjeEDP7ttPTy3ehWKT2jhR7dz9RlHatOmuFmXJQCeI
 gQOax5U9WtB+QTE5RX/rGdo9yK1IP4M7a37154OVmkz7PFas/netjxVFDGm27M1QO/Vy
 yEzzrJ7+Drm9L/iIS5sXiPfRrPEVcWzBXxnq7qDd9/eSl8K1lFnF7w0gvic+b8CICGSG
 PN18Hz1ufpqRFsoW3FTus2Q6E0a2ywPDiEG7hplh5EyBLUtRYRdHdxbmQYpEummwm9as
 NW0w==
X-Gm-Message-State: AO0yUKUraeQZ8RC1mNDVXl4mxyf3nJBKJ3N/MOZR/eirtiwtgpiyqj9z
 Y7dituORduDA7MOLEAX4pHU=
X-Google-Smtp-Source: AK7set9Jgq9ZQhTADHjg3H6EfnFAKDeu0hMzuI3+D+kLEzZBWjL7xvRjyA9i1WiIEXsFG+bOs7CMjA==
X-Received: by 2002:a05:6a20:3d11:b0:cd:3f69:e15 with SMTP id
 y17-20020a056a203d1100b000cd3f690e15mr4215843pzi.11.1677599650629; 
 Tue, 28 Feb 2023 07:54:10 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b005cd81a74821sm6190301pfm.152.2023.02.28.07.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Feb 2023 07:54:09 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v4] drm/virtio: Add option to disable KMS support
Date: Tue, 28 Feb 2023 07:54:05 -0800
Message-Id: <20230228155406.2881252-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Ryan Neph <ryanneph@chromium.org>, open list <linux-kernel@vger.kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@redhat.com>,
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

Add a build option to disable modesetting support.  This is useful in
cases where the guest only needs to use the GPU in a headless mode, or
(such as in the CrOS usage) window surfaces are proxied to a host
compositor.

As the modesetting ioctls are a big surface area for potential security
bugs to be found (it's happened in the past, we should assume it will
again in the future), it makes sense to have a build option to disable
those ioctls in cases where they serve no legitimate purpose.

v2: Use more if (IS_ENABLED(...))
v3: Also permit the host to advertise no scanouts
v4: Spiff out commit msg

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/Kconfig       | 11 +++++++
 drivers/gpu/drm/virtio/Makefile      |  5 +++-
 drivers/gpu/drm/virtio/virtgpu_drv.c |  6 +++-
 drivers/gpu/drm/virtio/virtgpu_drv.h | 10 +++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c | 44 ++++++++++++++++++----------
 5 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
index 51ec7c3240c9..ea06ff2aa4b4 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -11,3 +11,14 @@ config DRM_VIRTIO_GPU
 	   QEMU based VMMs (like KVM or Xen).
 
 	   If unsure say M.
+
+config DRM_VIRTIO_GPU_KMS
+	bool "Virtio GPU driver modesetting support"
+	depends on DRM_VIRTIO_GPU
+	default y
+	help
+	   Enable modesetting support for virtio GPU driver.  This can be
+	   disabled in cases where only "headless" usage of the GPU is
+	   required.
+
+	   If unsure, say Y.
diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
index b99fa4a73b68..24c7ebe87032 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -4,8 +4,11 @@
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
 virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
-	virtgpu_display.o virtgpu_vq.o \
+	virtgpu_vq.o \
 	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
 	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o
 
+virtio-gpu-$(CONFIG_DRM_VIRTIO_GPU_KMS) += \
+	virtgpu_display.o
+
 obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index ae97b98750b6..9cb7d6dd3da6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -172,7 +172,11 @@ MODULE_AUTHOR("Alon Levy");
 DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
 
 static const struct drm_driver driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
+	.driver_features =
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
+			DRIVER_MODESET | DRIVER_ATOMIC |
+#endif
+			DRIVER_GEM | DRIVER_RENDER,
 	.open = virtio_gpu_driver_open,
 	.postclose = virtio_gpu_driver_postclose,
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index af6ffb696086..ffe8faf67247 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -426,8 +426,18 @@ virtio_gpu_cmd_set_scanout_blob(struct virtio_gpu_device *vgdev,
 				uint32_t x, uint32_t y);
 
 /* virtgpu_display.c */
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
 int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
+#else
+static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
+{
+	return 0;
+}
+static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
+{
+}
+#endif
 
 /* virtgpu_plane.c */
 uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc);
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 27b7f14dae89..1d888e309d6b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -161,7 +161,8 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
 #endif
-	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
+	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) &&
+	    virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
 		vgdev->has_edid = true;
 	}
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
@@ -218,17 +219,28 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		goto err_vbufs;
 	}
 
-	/* get display info */
-	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
-			num_scanouts, &num_scanouts);
-	vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
-				    VIRTIO_GPU_MAX_SCANOUTS);
-	if (!vgdev->num_scanouts) {
-		DRM_ERROR("num_scanouts is zero\n");
-		ret = -EINVAL;
-		goto err_scanouts;
+	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
+		/* get display info */
+		virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+				num_scanouts, &num_scanouts);
+		vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
+					    VIRTIO_GPU_MAX_SCANOUTS);
+		if (!vgdev->num_scanouts) {
+			/*
+			 * Having an EDID but no scanouts is non-sensical,
+			 * but it is permitted to have no scanouts and no
+			 * EDID (in which case DRIVER_MODESET and
+			 * DRIVER_ATOMIC are not advertised)
+			 */
+			if (vgdev->has_edid) {
+				DRM_ERROR("num_scanouts is zero\n");
+				ret = -EINVAL;
+				goto err_scanouts;
+			}
+			dev->driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
+		}
+		DRM_INFO("number of scanouts: %d\n", num_scanouts);
 	}
-	DRM_INFO("number of scanouts: %d\n", num_scanouts);
 
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_capsets, &num_capsets);
@@ -246,10 +258,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
 	if (vgdev->has_edid)
 		virtio_gpu_cmd_get_edids(vgdev);
-	virtio_gpu_cmd_get_display_info(vgdev);
-	virtio_gpu_notify(vgdev);
-	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
-			   5 * HZ);
+	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) && vgdev->num_scanouts) {
+		virtio_gpu_cmd_get_display_info(vgdev);
+		virtio_gpu_notify(vgdev);
+		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
+				   5 * HZ);
+	}
 	return 0;
 
 err_scanouts:
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
