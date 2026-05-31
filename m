Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6415377EA1
	for <virtualization@lists.linux.dev>; Sun, 31 May 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780213047; cv=none; b=NU68cdkZdsY45w1oYwjRLT6hyrLDOW/c1rk7FZfKcnIzrTCYvuXyp8vfDzYZPqKXyTMnaHfp/+WGHCGNuwifxsT4tOgq3bfkXBHtKc36RdBYRUrPpRJmzN3coetkC7R2QGUJ8Y/kmKlNvFOr/AhNHHtwa5jz2W/uKoZSpztD7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780213047; c=relaxed/simple;
	bh=408VAmBF5WtOD1c3gHIMaQowaolX31ztM3e8rOwAkmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5JRyZ+mBEXR5WILbHpSYExJFqohbiPj7+KqdLug+X3DqE8dnIUR6KKBD7HV6C9BHqLFAq95fYaWyZjkZCJkqTXbJrlT7Vcoo309EVKM8vp0AfOeFezdi6qr3j6B5BnjyWQ+8791tv7UOvk1NIHYD+kNxju4Gt3z/In2sMpSDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2PcQxNa; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2PcQxNa"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85822059d8so950293a12.1
        for <virtualization@lists.linux.dev>; Sun, 31 May 2026 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780213045; x=1780817845; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7Nfdh9lJmyo73Y+RAkYTNq+7+iO9zy7FykzaU5yHn8=;
        b=C2PcQxNawKV60eLXacMZhS1bVT9XzxNpZaJh/BPU7EAiPEChsXT4WaUAqoqBkMmofi
         sKCAfdeJiNlNQc9itvAx19tbpz7SG1B4ZAbHBRTfqJqOPeQW+zR1g3M3VDOjdmi7T5wi
         92uHi15pg2mJGRyJZaRBAK//44Vg7VAdp4aAsH+CnoXQ0rQSzI36NuaYs4DDTk2RJBfe
         4ccgGAowi1Ly/FSs9lPlX2lyFRNs6ld+aOgmP7b+KN4A0/CYJhdHJ4gkc5HzYIF47jFa
         G311K+FgrcKVOuErUBmUkhFhOWOq4uJSOvOQdTAioowe0kZDiDn+CrGvd8VHTh9BqJpK
         OeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780213045; x=1780817845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g7Nfdh9lJmyo73Y+RAkYTNq+7+iO9zy7FykzaU5yHn8=;
        b=G1UQ2o7FksXX+l30b8EV9lH4ZKbBr/MBgVH6Bjb1pl26hMmR7dGiTX1wEGAEdJahW9
         6bt9IP6Ov5csYbydLjn0jt8ckLMAwbDLz7h4pe0Q9MwrbzgPkADylZiMhXfEFnyxVeyI
         O2lPpnazZXl3YqTvQuwQOhKDdV8SeuaRkMBKOk11mK5HKsJjBUir2OkmIe+6nyusLYJh
         QXEaxCy9zJUE2DlYBRxrLoPDM47LDv0djsSvtr/+Ibju59YcSeJNWUqnfJojk9LMcy4X
         l37M7r3SQRCaNa4g5zyGIj/Y8Qof/F/KwlkuraHa2Amza48idqCoJZvVAN1OAzLDQG+p
         u6zw==
X-Forwarded-Encrypted: i=1; AFNElJ9TjKzjieC91C5HIeR+S3Ca/SZqf251CfbZvhc7atYBaGZ48+++hQmJzm9HVGoK3LCjLSEcMYkIfkkmqUfr2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxATtNIc+gXTfOOyhHLOWmy6Zd8mB97aM/+VEIlA26Yz+niuqBb
	pgSx81QMNGBXsJI403a/jKV9X/ZIoro008iR0fuxyNiR66oA/oi9rLRT
X-Gm-Gg: Acq92OGO/BzclPxYrdKpzyEORNsQqeqELH3Hi+m6YpwStgZKhFO688mshIJyneT3Y4O
	Ts1MbanY2FjEQLUGQP+Q4eFUaeoMTyQdIGHxStqbEfIlPlTD8znNtUcWD2FvRA4SC3PbCNbd6S8
	vUlbUK8Vwo7umcQPC2QhVY6UiZEZ/PNY9nyPVq9tSkYBVNDwKGssgfu6LaEeGzMoVGpTWGzTyfq
	PtW/V5WfZHiSH1yWltHO5AGlGaKgYWs/+eWjPxSNhiJX8bDd7wII+hfccdf+3iznmLH0W0BOEau
	c6JAo9zdOKuDrqJRMCcD72RjDGJuOJVielopTeCGq/ek2WZQl16LqW/aSgqn4KrKQ7cA7+4rOmN
	d62VeyU4CYy8qt9bsOSWzqMpCPBnJk3LlwYSZyvSzlerLxCYocgH5kvWBWYgGjb+TkL39hIl1Yu
	GmlrpO5ljKC0ugdL2rALSK/+iSgEribPIkBrzSX5bBSQ==
X-Received: by 2002:a05:6a20:d04e:b0:39f:3ca8:a33b with SMTP id adf61e73a8af0-3b427fe4d91mr6837181637.17.1780213044907;
        Sun, 31 May 2026 00:37:24 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8422e712309sm3760709b3a.59.2026.05.31.00.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 00:37:23 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	stefan@agner.ch,
	alison.wang@nxp.com,
	jyri.sarha@iki.fi,
	tomi.valkeinen@ideasonboard.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 3/6] drm/virtio: Open-code drm_simple_encoder_init()
Date: Sun, 31 May 2026 13:05:29 +0530
Message-Id: <20260531073532.8609-4-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260531073532.8609-1-namanarora029@gmail.com>
References: <20260531073532.8609-1-namanarora029@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper drm_simple_encoder_init() is a thin wrapper around
drm_encoder_init() with a simple destroy-only encoder funcs struct.
Remove the dependency on drm_simple_kms_helper by open-coding the
encoder initialization directly in the driver.

Signed-off-by: Naman Arora <namanarora029@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index f1dae9569..5b99cce17 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -32,7 +32,6 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
 
@@ -271,6 +270,10 @@ static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static const struct drm_encoder_funcs virtio_gpu_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 {
 	struct drm_device *dev = vgdev->ddev;
@@ -306,7 +309,8 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	drm_encoder_init(dev, encoder, &virtio_gpu_drm_encoder_funcs,
+			 DRM_MODE_ENCODER_VIRTUAL, NULL);
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.20.1

