Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD4433BD8
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440913; cv=none; b=hwiNigu2qfQozcw4TAlD05zosUo//HNUH0NYdKiaRA0Ws/IUXoqJuqzcFANXp4aHE9Ge5kqa7NIoR8EklGJJkezjEOhCALAbNWV1LRBE8lANdCOxr1KcPrD39/48WDplE/HZ3N5eK2gGQfaMjBek4szlLshUyixklMmDehqI17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440913; c=relaxed/simple;
	bh=+9DjxzJb1EEsSI5UvFVj0386A6Mwd7uFCfcOmD8h/PQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WZcDbDGkK0SrQQbT8Cb/9ePnix9QqOUYgotiKCBEJpv5RgovagYuhrKwMqbmSFrr670KJRpSMVFjD1a9blmO1nnwx1SPFwDz0OUkl0Nv0Cl/JtrHTodKOuCZEBqWASyQOmGLl/mlndlHef+YGLwOC8CQ9WtUM8mKk+BHsDFp/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFa5L2y7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFa5L2y7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b6f1b14bso17679225e9.0
        for <virtualization@lists.linux.dev>; Tue, 07 Jul 2026 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783440910; x=1784045710; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MSvgov09ILFDklrc/PmKMunoi1XsfbW6pFLyZtQc8b4=;
        b=gFa5L2y7zoj4SgjnRWDO8U8Zixdb2UYW0lJXNHrdUGowUo3MB2Fv8ovfzFjAvbzTSQ
         0hM4zDPkbGZLEJtP6Vj/OLjeOiQBP2cojpf4ZtUzKdyY/q5oX+sSJGn/2uClhXJr6+1n
         v2TtNf7wyn8ofLHen3LMmskgP3bd2N+jkOOgHbpC/qQTgb7+rWU70Wjra+64CpUZB9ss
         PNSa0t61QBSEYhMCYAj9z04s4zUbRypg/y4zh6DRsdm9r06f3ZnDUCRpRu8+8dLz+eAn
         i0u06fbfOJ3JP4E0m4uXQK/B6cI1WKcif9cvKqHmeUFP0sblQAhLds9zZuBifyt8gmcA
         fOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440910; x=1784045710;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MSvgov09ILFDklrc/PmKMunoi1XsfbW6pFLyZtQc8b4=;
        b=JNDJwIJs6miX3acrMpkyEZXJYIDK+us22mIEaGprW5JG+ufOgLFPAn2Z0vOn9tAnxD
         wuBHEyoBqWO6bHwCsHUFsOqtt+tIzKSh1bQxuxruN0AZ9SZTEVg3ZgcHimtSKwSD8akZ
         wp6OBFGyfllIAzINXTlw8pLwOeKgQvHDP+2bgy1G6cIN7+K0ZmMRGKjuknJ9cDT7RIxt
         x3plmjeY0jZYMQ/l2tnNHSdh7Y4NPsiCiTHkigZtOy18iZ7vhaZI0+PpJ7qgrSiCd1UG
         hCGIM8aO9exLV6/3fACWab9xLk1pd1odJeJSZ94NJURtUA7YUjghHLntfjxaDBRyrVtQ
         nWIg==
X-Gm-Message-State: AOJu0YwzTzRb52FevG8G4kbL7kl1ZE73331s09lFECFIQQlFcgelKxFZ
	pQ7SuOnBepUuZDq/8Sm4/iz7P3187mi41AoSVrT9R13fTVFCqTn/2td0
X-Gm-Gg: AfdE7cnLSb/knV/IwSzDalGFCOmaDYF+03X65ODZx78kRJbewSzyJa+tAv83w8FzXf3
	6O/WvkWgeftzzyQZ/y4nUxA70+GXW2Ymfs9SXVhx952+Vx8jPGrJjT3O/qfm2QWsS2L9e4pVCzZ
	AgDk8zeKYEGw1LoCk9KOlbco530lIo1enBiTwxNaOfKjtuQIBTibbwmFndFz24l9Ps/hPZNGC82
	0imt3za/F9OUco3bd8SgbAJc8rLW2i1+8ChGwMdHzHwC1iXRcYnR2dkzWBCOwHPWVLzgBqjB/JN
	ZNWKkeS8dwZ0oHOsOAxmahFLY5aCFh0L9AMO/yyZQpVE9lAWqr4PmP8YX5Ngb2MdwJ5AzLyAA1K
	/Z4/KijwGeF3memd/l/FDAWOOZMW8By45Y92wPGYauDo8NgNJP9heEcvH/sOrBRemQQYWphc2vK
	0bAcs1KlWI8PpU9q0WpEcM
X-Received: by 2002:a05:600c:548d:b0:492:45a0:dcef with SMTP id 5b1f17b1804b1-493df062168mr67021255e9.5.1783440910098;
        Tue, 07 Jul 2026 09:15:10 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm75376865e9.7.2026.07.07.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:15:09 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 07 Jul 2026 18:14:55 +0200
Subject: [PATCH v2] drm/qxl: remove dependency on DRM simple helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qxl-simple-v2-1-08d21bc74a41@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP4lTWoC/23MQQ6DIBCF4auYWZcGqGDSVe/RuEAcdRIQCw2xM
 dy91HWX/0ved0DCSJjg3hwQMVOisNaQlwbsYtYZGY21QXKpecc79todS+Q3h8xyYYwwyrY4QD1
 sESfaT+zZ114ovUP8nHYWv/UvkwUTTMl20jehBzWqx+wNuasNHvpSyheO1v51pAAAAA==
X-Change-ID: 20260707-qxl-simple-c01aa1a5c4eb
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting.
This patch removes the drm_simple_encoder_init() helper usage in the
qxl display driver by open coding it and using the encoder atomic
helpers directly. This is a step to eventually get rid of this simple
KMS helper, once all drivers that use it have been converted.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
Changes in v2:
- fix type error
- Link to v1: https://lore.kernel.org/r/20260707-qxl-simple-v1-1-524f6316b5d5@gmail.com
---
 drivers/gpu/drm/qxl/qxl_display.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index a026bd35ef485..7f4178800afd7 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -31,12 +31,12 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
@@ -1095,6 +1095,10 @@ static const struct drm_connector_helper_funcs qxl_connector_helper_funcs = {
 	.best_encoder = qxl_best_encoder,
 };
 
+static const struct drm_encoder_funcs qxl_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static enum drm_connector_status qxl_conn_detect(
 			struct drm_connector *connector,
 			bool force)
@@ -1169,10 +1173,10 @@ static int qdev_output_init(struct drm_device *dev, int num_output)
 	drm_connector_init(dev, &qxl_output->base,
 			   &qxl_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
 
-	ret = drm_simple_encoder_init(dev, &qxl_output->enc,
-				      DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, &qxl_output->enc, &qxl_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
-		drm_err(dev, "drm_simple_encoder_init() failed, error %d\n",
+		drm_err(dev, "drm_encoder_init() failed, error %d\n",
 			ret);
 		goto err_drm_connector_cleanup;
 	}

---
base-commit: ee2867b79f9bac3a6fc3221139b09598ce79099c
change-id: 20260707-qxl-simple-c01aa1a5c4eb

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

