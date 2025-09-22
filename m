Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FA27FB18
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552265; cv=none; b=INl6JQxDk81KFPMfOgU4sjJlh07Rd4qcsKFPbnkBgQOmBXOwsvB0yDH6oX5s1vxLIwzdq08qx1QkHccWsZS0y7vS7VbSlqgqcy1mSlnYSAYJukFitcyHNamsmY7lUZstw9HeO5QsGY7ZVGwSS2qiUFK9j8+Hri17zICwP9OrD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552265; c=relaxed/simple;
	bh=Owm7uoG16GhFiqt84WOs9tZArrF9kHcl/090AAZOz1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxczgzTe+1gyHYTqJuK6cPayDqgTTDeYuQJBROK5NMdkTXgkrnW3Rt1qPKukoAZhszSmYeyQlrIHmwlgLqLj8kwze77ms1b37ImGcpBZqoofnMHVEnjt+R3ISkOKhUEWI6DrE0rdkX7SLh71IiCkSmiYXYrlA/9BBwRm7E7kluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRG5CeFe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRG5CeFe"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36ba647ac9fso6532541fa.0
        for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758552262; x=1759157062; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X13cIlFTvAxBl+tOf4PGIxbGkobbYOGLrZfNc3Etiw4=;
        b=KRG5CeFeArKmfSRlbutCrOxUQRB7q9/GqB3YprUpUm78RnO8zb8t34SEnAZElzU61K
         7KCm8rOpkCHPNSqmIQPhxp+r02IIfWnNL0RmnMecM3VVOyWnEsgOfAGQq8ZIa5YSeSXo
         +lL8l6erlL9c/3d8ACTlyJSoCY6K6jx7bRignVwK3C5UIrlGSGXiSyu2wIUuuDoQSJmF
         iUrvcB3/0wXSOYEyoOLzOYB9BzAMeuLwUuHl7rgr5s8ixwo3t5xp0pMPv3hYKfnBhQhX
         5bVhVFJljbnlMH1mbD8GP7mn0XEc5qushxk2eb3wbqGMtR9ReE/zBis7y3PQ42JutVYv
         h43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552262; x=1759157062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X13cIlFTvAxBl+tOf4PGIxbGkobbYOGLrZfNc3Etiw4=;
        b=UKBhkfwA2UfFLq98MB2fmPcV8xCzmy9gNmm0nIJ/3vkWVY/D/9ZaExTvheolChDL9c
         6+yIentCOk5qmSA/2QDXHdrTIE8rh3XmrAEkF93XUdmVCYzj9H4jARosdhBQnIJc6EdR
         nsizC5hJxTlFuSDFxPPhjNMy0xxtpL1bELL8OeiPLNEIdUaHgPHdpBbVekLCgovoiDqm
         ddrCfKg4oWEc09xmCc7cIH87BsCacOu8VeLGP1kRgG+Bl+AN7ZcakM18z0raTQqXWKBL
         wmhiOtZSj7yXmSpz+cO5KOmHYCX2PUULV5ePPpMDnbBAzB8wwlegJhb0c5x7fy72561d
         yUVw==
X-Forwarded-Encrypted: i=1; AJvYcCXghAerMEc4MC59s+LhzTDejfiUZxbCVoR2Ve3N89d24t+WDWxYdoZSaAklxZa2X+xrwi6NOTm/oc3YE4trMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKmHFLFCpNvunmN3XoXc3Foc8eO98lwaCeDmPl//V/icIdOYc7
	I2QVoW9YjDgiNaqQ8RM86Hagl8G5V15uRMloiFh112HUEJgbd2jwt5bT
X-Gm-Gg: ASbGncuG3x7d3fBT0vKKJ8EMdY/TRqaBnN1DHP0y7IgtqjGsJhppJhdACI69UpXwf/B
	3+ftcQ3x8q2p6tqzvdqr1r7vJfZXVOZrXLH+h3PJFuntEOINh1fY6lJUVf21jxxhJ4qNlTbDJ68
	S9m7jqb3MghEttYgbOYW38GlBsclkiC5O2246oyQapu7xXKw0mm+e9Cuc4iQio/FY4iXtGY6Q8T
	VcWDKtqlgl7d1UkfUOaComON4eCdq6CQ5/zLDd6qth228fOtU/nmsjVhonp7qIt6H2rVkJNmCZc
	l54/9unY1UoUUrS+vnoYw80j5w724I7JQiAENxwW4zj4vND0pjVujyzmR3gPdFFU2bRaHdWe7lm
	hNufFlAifb6lE8CJM+v8xD3Sa2l5+VRmH4WdyxYKALVDpgIFhohybozZ/mGZF4YZZnM4vpUuBBk
	16D0/8Vxwy5XE5VwFM
X-Google-Smtp-Source: AGHT+IFBWwEOq3lIzOIm0ZMJkCph7Cxz3rME74SktJraASmJ9clEOIZJfSRHzAxaW3f19H0CEY3msA==
X-Received: by 2002:a2e:bc06:0:b0:336:ba05:b07f with SMTP id 38308e7fff4ca-3641afb9821mr41441221fa.21.1758552262175;
        Mon, 22 Sep 2025 07:44:22 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361aa1a1041sm31416821fa.60.2025.09.22.07.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:44:21 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] gpu/drm/virtio: fix error return in vgdev_output_init()
Date: Mon, 22 Sep 2025 17:44:13 +0300
Message-ID: <20250922144418.41-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

Return value of function drm_crtc_init_with_planes(), 
called at virtgpu_display.c:276, is not checked, 
but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index ad924a8502e9..59b652e8a630 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -253,6 +253,7 @@ static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
 
 static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 {
+	int ret;
 	struct drm_device *dev = vgdev->ddev;
 	struct virtio_gpu_output *output = vgdev->outputs + index;
 	struct drm_connector *connector = &output->conn;
@@ -273,8 +274,10 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	cursor = virtio_gpu_plane_init(vgdev, DRM_PLANE_TYPE_CURSOR, index);
 	if (IS_ERR(cursor))
 		return PTR_ERR(cursor);
-	drm_crtc_init_with_planes(dev, crtc, primary, cursor,
+	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
 				  &virtio_gpu_crtc_funcs, NULL);
+	if (ret)
+		return ret;
 	drm_crtc_helper_add(crtc, &virtio_gpu_crtc_helper_funcs);
 
 	drm_connector_init(dev, connector, &virtio_gpu_connector_funcs,
-- 
2.43.0

