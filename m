Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBE377574
	for <virtualization@lists.linux.dev>; Sun, 31 May 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780213032; cv=none; b=Zv/Mvey/1hh/cq8EQKeDJV/3JHxnA7GYcxj55YHq8vxgN8fxGJuwOfmjaTVanPe14mF6VlHuJ7SiCSBR2K+gpApWlSnBnBPOx5AR7v2Ih4locs5ud36Iau246MNGLSck4cZEX6kqApUBGdEfYEyOb2YoJL3DPVRFpgTUTrzgDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780213032; c=relaxed/simple;
	bh=oY+w3vSzP4EwsS3DqrAbl0ftq8sR3CTRkppY0TR5Xcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVUPZCpCbMkEjC5JAbTKI+MBEmY7oe/2AedVKpiy2p4t6fI89ekMeYIQKTgSqQF/cvNU8oEbz3ShYusdfqSTQgS8x9ZXJ1zZRyvMB6hp4d4s6DENnC0xxxrfO4uGzhiCYxDF/vRm/wqyVFE2Er8yzHkL4ltPleRaieT2WoNcsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZoMJYdF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZoMJYdF"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so296452a12.0
        for <virtualization@lists.linux.dev>; Sun, 31 May 2026 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780213031; x=1780817831; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRd0rxdsonje9jnyvzmzGfqu89ZUVs4w1wFb8uxr/rs=;
        b=fZoMJYdFKNiF6W7FtqvWWWeVwrfRLv0uK1wWRU51TLP0nAv8KNnh2dULX6Xa3qCVQ2
         hiH5pGZ3NSRPOy3U2ui9ldm6ydRYoi1XsvWKXhbrcjeTgQln1o8qsoeByy2ewI537sJV
         rSXW/4sWm5WVeljaucR4w8FYQmfzVfG5hvCwyM+fuBeQp/v5EfjXFIPZQIXeTWZSbXyf
         YTn3wLxkJsYdu1/uGHaqGLCaVej3FnFnKL7VOefel/maIgS2yoXO4x4wwe7CgeYhDR+X
         PBXt3gph46EJGmJ77RhvSWnTp54HSyHonDpEHwNoh2xcvD+jGcJLoAHaV83eMH/TyDdA
         IORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780213031; x=1780817831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRd0rxdsonje9jnyvzmzGfqu89ZUVs4w1wFb8uxr/rs=;
        b=JyyF0/jivA21/IErfq2YOSqmGpS+uyFLgHSYoff40zH/ke0FU0QY9uCymp7kBic7u3
         ov1E2eHxvF7gItsAmST0tQJ85zOPH5iztMoetc20XlSQQj/t6dSq5fUGlopXGS3kIdsg
         V4l1ixhWoGzHQAJ62V9kNRWBvLWlR7cwRgB0ftq12iBBGnjNmqjsdFCY6FhbASfgdgwB
         VPBpwsNv0tnPjXzPPAdBPAcmxdpUJ6iHcE8IHfFFYT5inh/iL26geC6Wth0Z1RMAnOUd
         4UNtXFOCd3db336zVgEb9oNDVY0KImKdg1jkislTBOGRGbFBOTHDGjcHfc8S7oyNgwA7
         Yu0w==
X-Forwarded-Encrypted: i=1; AFNElJ8pf/P1wHE5hownCeOO8NmH7UnqqzZasNbrpO04xTsC7RRwJCfUu14Kfmpnd1wCWH0qJQALmJabVCO0nSFaMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4J9ogSkUlu//qT43TcxrLvZDrZg6BxlY1LNkloG/1gc8MRB8h
	Q4G7DyXtcQBsmIl2F5O+p38xRud1o0bSybltD43DMsD9lkimppnpNL6t
X-Gm-Gg: Acq92OG19C4vb06Rxy9FO8NspAl3BConesCQqTe6yR+x1H+v88L2EDoxNHOAbrGMe7A
	5NEXc0VXbfc286cevREJM1RChu/p/LjqBHqYv/WlIshe5zZ3KesPfUGSM0f3b1sqgWOXUbtkZ1a
	CRUkfhLZo6NrbDunse2ShA6yzlUkJRttsrienszVUU22wE3lTIyFeS6xtApJ7aZQTQtGxeParHD
	9oWhmLkQnanqkK0aTmWBPjnuLu5/OkzDYlFfWcz3c+ZICVb6TGOMrQeAR2PEGlqBkoLhDnX5NgB
	yptwYxWw1Wp+b3vtzFvI3uk0oc7BKDlvbEoVHdFHrko9N1IQFfxJiW/S+z9JRI3kObKyaaVrRrk
	GbXQujERMBUHn5+jtD5oNtWZlwED60tRu3xiUpZrFamV7fxWqTiDHafuXmeWWZ/yksK27FPr13q
	CugdbABXyaWvh0YRdtDmAnz7gOElc6ciXB3ug8EhXJmw==
X-Received: by 2002:a05:6a00:408f:b0:837:e9cc:d465 with SMTP id d2e1a72fcca58-842253a671fmr5468493b3a.20.1780213030642;
        Sun, 31 May 2026 00:37:10 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8422e712309sm3760709b3a.59.2026.05.31.00.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 00:37:10 -0700 (PDT)
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
Subject: [PATCH 2/6] drm/tidss: Open-code drm_simple_encoder_init()
Date: Sun, 31 May 2026 13:05:28 +0530
Message-Id: <20260531073532.8609-3-namanarora029@gmail.com>
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
 drivers/gpu/drm/tidss/tidss_encoder.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 81a04f767..4d73a271c 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -13,7 +13,6 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_of.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "tidss_crtc.h"
 #include "tidss_drv.h"
@@ -81,6 +80,10 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 };
 
+static const struct drm_encoder_funcs tidss_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,
 			 u32 encoder_type, u32 possible_crtcs)
@@ -95,8 +98,9 @@ int tidss_encoder_create(struct tidss_device *tidss,
 	if (IS_ERR(t_enc))
 		return PTR_ERR(t_enc);
 
-	ret = drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
-				      encoder_type);
+	ret = drm_encoder_init(&tidss->ddev, &t_enc->encoder,
+			       &tidss_drm_encoder_funcs,
+			       encoder_type, NULL);
 	if (ret)
 		return ret;
 
-- 
2.20.1

