Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC3EC7EE23
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 16:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7BBC81F2C;
	Mon, 27 Feb 2023 16:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7BBC81F2C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KOw+Ok8U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fITHdl8R5UBd; Mon, 27 Feb 2023 16:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D98A81ED5;
	Mon, 27 Feb 2023 16:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D98A81ED5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06853C0032;
	Mon, 27 Feb 2023 16:01:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4732CC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1388A6100C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1388A6100C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=KOw+Ok8U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V0SdFYDWJ_KK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:01:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3E0360FE4
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3E0360FE4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:01:20 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id l1so6633436pjt.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 08:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gjTwJPBli3bVW7BSYmp/MLmUOGFtVANWMeLDc2BTS7w=;
 b=KOw+Ok8UcEGfwBWBgnnHrAWBMI1r7rJJHiaHQDQ43lJyLYMIHvYoTfg0+MQwxJHiDM
 +VO1VcVrmP+Y2FYaLPfAw0CZhr3H5h0PcJ3nMkrXe/eulXo2oRdEsk/ycpUSRqBqR/UD
 Ap5dzfWZADqmvPXDK1Uq1ct72gdykfdnZnf+h2PeLibYxsFRqpIkyF4Eu20Ti+sFkByy
 QkWAk1mDwv4ss204gpkp05SMKpiQfXcUw8hDSmmCOsJP99EdP7d2tV0KN3hrkgnj0Za8
 8wiVMSL4G1XDxJVt3QcgR61j4tt4wKdw0QQzW1+vu1MYkYZuc+pZ4zXH5/eDbFdY+CJR
 yAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjTwJPBli3bVW7BSYmp/MLmUOGFtVANWMeLDc2BTS7w=;
 b=wZuHwjmZP6LWaiggRKmlKRBbTeiuG+c6EJWknsZ/uyPwo8JK6pReEPb23QCsUr0Te3
 Jgt6OgIvuGNU9yu5Mrl9RwrJwvzjdsPnAq0Zn90ZtKL+d+5QVR4PKAfIDQlIfjMCd25k
 JoX0VxMgaxPaHUIAzYZunv0WlS4weuj1yzZa8DkD5rbNMSZ2F7xOaEekTBrIwkH3fcnl
 NVZrmiYO6R8S+Xss0nccf7qiXF13vTc+pfaYbUJNVW/FhXAWrxwUgFtQW8S1hQrg5OwC
 bGrXcs+O0O8Nr9OjZn9XQbc25Q6Ni65TI0XXherX2nFtmpD4uUs9QNw83KlmtrKh4pf9
 pp+g==
X-Gm-Message-State: AO0yUKX4LUnWxTyN85gTKUQC3NXtkyn83dUz0dmUxB+f2/uN5DtEwN8e
 XAcqKbJ0BlxsKsHro5LQx4c=
X-Google-Smtp-Source: AK7set+Yi+CDKBpYhZODZ5eydyky0qyXDuXPMFlX8Bbuh5Z1gJwIFnECChJNzq6H3xSq7+jChoSMeQ==
X-Received: by 2002:a17:902:db12:b0:19a:7622:23e5 with SMTP id
 m18-20020a170902db1200b0019a762223e5mr33386106plx.4.1677513680037; 
 Mon, 27 Feb 2023 08:01:20 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a1709029a9200b0019af9a6bf8dsm4831526plp.19.2023.02.27.08.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Feb 2023 08:01:19 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/virtio: Add option to disable KMS support
Date: Mon, 27 Feb 2023 08:01:13 -0800
Message-Id: <20230227160114.2799001-1-robdclark@gmail.com>
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

v2: Use more if (IS_ENABLED(...))

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/Kconfig       | 11 +++++++++
 drivers/gpu/drm/virtio/Makefile      |  5 +++-
 drivers/gpu/drm/virtio/virtgpu_drv.c |  6 ++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h | 10 ++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c | 35 ++++++++++++++++------------
 5 files changed, 50 insertions(+), 17 deletions(-)

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
index 27b7f14dae89..70d87e653d07 100644
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
@@ -218,17 +219,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
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
+			DRM_ERROR("num_scanouts is zero\n");
+			ret = -EINVAL;
+			goto err_scanouts;
+		}
+		DRM_INFO("number of scanouts: %d\n", num_scanouts);
 	}
-	DRM_INFO("number of scanouts: %d\n", num_scanouts);
 
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_capsets, &num_capsets);
@@ -246,10 +249,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
 	if (vgdev->has_edid)
 		virtio_gpu_cmd_get_edids(vgdev);
-	virtio_gpu_cmd_get_display_info(vgdev);
-	virtio_gpu_notify(vgdev);
-	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
-			   5 * HZ);
+	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
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
