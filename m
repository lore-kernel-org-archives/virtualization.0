Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32DDC7EE2D
	for <virtualization@archiver.kernel.org>; Fri, 24 Feb 2023 18:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14DE74160B;
	Fri, 24 Feb 2023 18:02:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14DE74160B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MH6aam4w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QY5L2YhGKfez; Fri, 24 Feb 2023 18:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C99341604;
	Fri, 24 Feb 2023 18:02:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C99341604
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEC77C0032;
	Fri, 24 Feb 2023 18:02:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92940C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 18:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72BA760D90
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 18:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72BA760D90
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=MH6aam4w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3x3c0wr1L4QT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 18:02:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 364D060BE9
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 364D060BE9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 18:02:30 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 y15-20020a17090aa40f00b00237ad8ee3a0so20667pjp.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dIetUbx7EIF3EVZI4uWomKEyBANtRstOQ9q276wzqdo=;
 b=MH6aam4wwxxCOP8F74s6Ll3IKPas17IyPHqfjrU5DRqREcp574aRJL7kZZuGLwFtVM
 5qjwEkw++dNg3OMCh2Mtk6meGfZ10SKB8U9bSt0sReAXqCuRh6EfFKMsMx+c1OC4Pgon
 wyvgbEPrwlEVV0Ru6arZDsOe/vb+k7/8o0RqOFWHBPQbxxeg9MRI6yg0BjX8HvWZ4JI6
 Vk8Tlb6Dr9bOk3jtTS3WAGohoRkn3p82EsApeWBwGCjmaO4fkDPz8AbSPi9uGOJTPktK
 Njh3v40YmDl2P0NXJLECxSCJKbMnE20Pcn+zoMIpaP3w9hWNsgQacWC49zFUwiIuY6Gn
 +Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIetUbx7EIF3EVZI4uWomKEyBANtRstOQ9q276wzqdo=;
 b=UetZTYiQ+2zNlOfOzUn32FX23Ylpvz6gVPOjBtcXRaG6FI/GyWdHvh63kkRmqzvlg3
 VJ0TKhEtzpivwO0VAPL4HkJm07ICLqNdUKvP5l8hPZwofSN6JNuneV1LRTnISRp7b5v+
 b8WfilC9UpKgzQ7pHrvPSFXhxOXqXiJJJXW5Eu3pr0jEYW1IIkKitSEpLLgkBgE0/qSc
 ngRQEpnZOhTCOJPiZw00SZhfFiKsvHf87aqMTcZ9tbNqfPL+jBLAc6n7Lokpv37b9f4i
 HnQezDEQEZqUodPYK457UVlAA1bxqM1wdRE3HdzNujj+tSHJaPRmv4mCWVpFoJJykcpX
 eugg==
X-Gm-Message-State: AO0yUKWzflDbvWhMGCP5Q+QH/EWGdVmh4WziH9lY4HAIx9BrXwVv/eNI
 QH0Ilsge3eXhePay9BcNYFE=
X-Google-Smtp-Source: AK7set9P5Feo6a4/0yoFYK8d+lC8D6mrYWoq7w/KhB+AYtuzYRizJ3vRuhh03PSshTB20wmkY0jxxA==
X-Received: by 2002:a17:902:ba83:b0:19c:be07:4af2 with SMTP id
 k3-20020a170902ba8300b0019cbe074af2mr4714336pls.45.1677261749322; 
 Fri, 24 Feb 2023 10:02:29 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902704500b00198ff118fd3sm1108105plt.101.2023.02.24.10.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Feb 2023 10:02:28 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Add option to disable KMS support
Date: Fri, 24 Feb 2023 10:02:24 -0800
Message-Id: <20230224180225.2477641-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Ryan Neph <ryanneph@chromium.org>, open list <linux-kernel@vger.kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/Kconfig       | 11 +++++++++++
 drivers/gpu/drm/virtio/Makefile      |  5 ++++-
 drivers/gpu/drm/virtio/virtgpu_drv.c |  6 +++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h | 10 ++++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c |  6 ++++++
 5 files changed, 36 insertions(+), 2 deletions(-)

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
index 27b7f14dae89..293e6f0bf133 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -161,9 +161,11 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
 #endif
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
 		vgdev->has_edid = true;
 	}
+#endif
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
 		vgdev->has_indirect = true;
 	}
@@ -218,6 +220,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		goto err_vbufs;
 	}
 
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
 	/* get display info */
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_scanouts, &num_scanouts);
@@ -229,6 +232,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		goto err_scanouts;
 	}
 	DRM_INFO("number of scanouts: %d\n", num_scanouts);
+#endif
 
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_capsets, &num_capsets);
@@ -246,10 +250,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
 	if (vgdev->has_edid)
 		virtio_gpu_cmd_get_edids(vgdev);
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
 	virtio_gpu_cmd_get_display_info(vgdev);
 	virtio_gpu_notify(vgdev);
 	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
 			   5 * HZ);
+#endif
 	return 0;
 
 err_scanouts:
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
