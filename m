Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9237D12F
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245456; cv=none; b=FzNZ7gUfkK9uzQuMXG8fm6um7/uwFGboyM826JnsabtLYNrNnz25I4fL8sFLx626BjDc1nL3mKqHKSc58H/mPlYarEj5J7jpwlkgZIGrFwMMy/1IxGLij5lOGOGlmm0Ov+ou/17Af2ZR4mM/5XHKrDnSK3tJLLlEJDwUlRowiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245456; c=relaxed/simple;
	bh=3+oQgQjjB+apiqdYH5utkTP14/+l6+v8Ek2uXcY2qwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7BuDwUWgoPH69MkuAVQJbu352ySmdqH6ECi1dwec4Dx4w3wwqRFZ8AUWacDWlpMTVmvwLQbaT76BFgfLFiMQh7HCo9M3bXid4DlY6gZ8G37MKSMIN3GDT3bzseUNPOB84ixe5XKD+WcSedr1z28jCuFRLrWyxAU4Aww7HoTI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L9UhtQAW; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L9UhtQAW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788245452; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bABm3+xrFKtz5tDE4aE1SofEi8/oUAjtsC5NdfwbKhk=;
	b=L9UhtQAWrUCM6knl5e/lD9GaPqoI6ZiEdIDtFqJEBucbSWy1AeGr4bedfNvxwwcq+2ANANSJ7EvBgaVNsMhktpfl6PsngfkZqstCd1+gfTBvgUxu5/+mtFzQ/LG8BlaciS5ub9eCo9U5TwvAv2JriTU2QWBaCB8D0fkwU+HA0Zo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XA4XWTM_1788245450;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA4XWTM_1788245450 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 14:50:51 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de,
	airlied@redhat.com,
	jfalempe@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	hansg@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	leandro.ribeiro@collabora.com,
	daniels@collabora.com,
	pekka.paalanen@collabora.com,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH 2/4] drm/qxl: create blend mode property on primary and cursor planes
Date: Tue,  1 Sep 2026 14:50:43 +0800
Message-ID: <20260901065045.1152136-3-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260901065045.1152136-1-qinyuntan@linux.alibaba.com>
References: <20260901065045.1152136-1-qinyuntan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed"), drm_mode_config_validate() warns when a
plane exposes an alpha pixel format but not the "pixel blend mode"
property. Both the qxl primary and cursor planes expose ARGB8888 and
trip this on driver load.

The planes have always blended with pre-multiplied alpha and userspace
assumes that blend mode when the property is not attached. Expose a
"pixel blend mode" property advertising only DRM_MODE_BLEND_PREMULTI
to make the existing semantics explicit and silence the warning. No
functional change.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 7f4178800afd7..0cd1456cca347 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -30,6 +30,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_framebuffer.h>
@@ -993,6 +994,9 @@ static struct drm_plane *qxl_create_plane(struct qxl_device *qdev,
 
 	drm_plane_helper_add(plane, helper_funcs);
 
+	drm_plane_create_blend_mode_property(plane,
+					     BIT(DRM_MODE_BLEND_PREMULTI));
+
 	return plane;
 
 free_plane:
-- 
2.43.7

