Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7B3B95E0
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439416; cv=none; b=HxR8a3I/BW2N8ppI7wvfaE+G4PmNA3VlhUOrnGefpn3a1lBv05opzks4bsim615JYWcaOVuHJuYk7lIr7ZJmXqppt1MVWgjbWp52fcUwanZGWFD30omC/90Rhst+wd6mtG7ej1K1RSTNC/UmjbjkusGTqKE1YNGGL55qJo66+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439416; c=relaxed/simple;
	bh=XB4gq37H5hbaz8XnO/PiOXgI2qaD9lgyBNGB6/wCe3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aeiBgVWD52PHwgOp1XKYfRhI8An7PL/kmIpm/JoX+6DeSL9ZdIsjOJhRnA/1Mx2ENFF57tw9UkRVuzzFXcaEW3hpdZRUQwIMZAasODwIid5Zj1KlzH5oBqkpnILo6atfQJhVVkXiIeN+f8nTMg183h/DmlPf9Q885o70o0XOOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVpEZIfP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVpEZIfP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c00f74baso27739225e9.0
        for <virtualization@lists.linux.dev>; Tue, 07 Jul 2026 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783439414; x=1784044214; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JmJOXk4TIuGnk+IJA07RQlg228Mfy9xUbBSKbXjT52U=;
        b=EVpEZIfPn89opAM7LQFFbS0h4/g8ZVwK1v8fWJIOgsrBCfHbr+LtUel3PC2mIyoj30
         fEPIwE9h1mZp3Guw6uq+EaYbiham2Bo18YKA5KQKwtMA5Qyvo3rBYM88T39cvjLazlWT
         qyPfcNULgTMcW0INHWMvdtr4J8h4vraa5aQGdYSQI9Vbv9HXd/zl+HKJA57pPOeEtQkS
         jqGznHReYiKe0l5vlk64e9IrJuB7tbzglI2lf/tWQaWGPz39OTjEQVN3tkEXPsUo8kId
         itqQe9Y03jUuwn7fXfo5hAViUg9I67tv1eYUtAVpaB45+0ULUpTk95zG/gJleb25wExR
         Cr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783439414; x=1784044214;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmJOXk4TIuGnk+IJA07RQlg228Mfy9xUbBSKbXjT52U=;
        b=Yf4Is3au+2l1IOXfUhEo2WgJ3kJSjG26oJ8ATLrZB6zXDIM5Laeigie5GFrEqZnRtT
         GRROl8pTfZ304QoTDJZiagdH4hVwIFiQMQ/qeex0kOTziwg72W3NDLQNLsB4FM4rh1fc
         33MwU9vNiZN11Tqd2CQxYMBxzhU1wCv89zoy22kIwRj2xu4GEqGGYtiENwRJHcZvTp+c
         u4BX8UtE07qu/hmGDcSDrYXPjWHoaf1yCwwPbYI8ibQWk/0hk0NNygLt4Pd+T0ye1Jhc
         5BMmNrYpoAQKDc2iWg/twwpy2jf7Rv3rg0fNIG/zRl8MyhBiTtn09IJxcWtILniSoYgT
         4gSg==
X-Gm-Message-State: AOJu0YxfGUmrPQPsZ+VmWYwqu2MkwRieeFYBHAwy76/3GMXb4+LiExia
	5dMa84zR28FYx5mL2BptAy/zY0yT6c7fhLyjxM/V5tJ0mE6RmqYe1HyR495KUoXc9FzE7g==
X-Gm-Gg: AfdE7ckCNgfe62qigLdCPyGO4hl0NrYj0/FjKPTWCm8D/HACyVkrcOo+tJdIf9uRuIw
	2OJbSfzXCQK7dLJkLbdbAEf7B7BwgHTNsJ4zN372QMu80sFbNG//TcPUStqEFcH7ScAJVPLdjiV
	BAgl+uJhNb8WvUrq85ZLNZmJmpPVmoTov5S6ct+w48BEpsJYRyyedkeMK8OjJaDzcnDFK+wBtqI
	+IbSt7wLjh1YqLbjvJ5uNnWWuQr/ZOYJrTw5n1NnnpZKqdb2K+NbQ7/oqpPi71bX7yAVaGjt22N
	PbshvWL+QmatiWjjRRIsMysJLsNT/eRvpzBCASmoYIh/S54S4l5bRLHuTwOnCB9M2+4MpjDuREI
	eMCWgPT6DowxZCObKBV6sDJ0NGJB0/s/2DOVQTGsROoKSrh1RuxefLTuhMTJ128n+K32cIzYE/z
	6rinc8VITCVZiQjCmRVyYA
X-Received: by 2002:a05:600c:3f16:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-493df08b92fmr66562655e9.15.1783439412445;
        Tue, 07 Jul 2026 08:50:12 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ec6e64sm111676995e9.0.2026.07.07.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:50:12 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 07 Jul 2026 17:49:48 +0200
Subject: [PATCH] drm/qxl: remove dependency on DRM simple helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qxl-simple-v1-1-524f6316b5d5@gmail.com>
X-B4-Tracking: v=1; b=H4sIABsgTWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNz3cKKHN3izNyCnFTdZAPDxETDRNNkk9QkJaCGgqLUtMwKsGHRsbW
 1ABN0/x9cAAAA
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
 drivers/gpu/drm/qxl/qxl_display.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index a026bd35ef485..236d027fbc9fe 100644
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
 
+static const struct drm_connector_funcs qxl_connector_funcs = {
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
+	ret = drm_encoder_init(dev, &qxl_output->enc, &qxl_connector_funcs,
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

