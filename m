Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499344756CB
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251575; cv=none; b=aZJuwpVN5t9S/hPtrschJPHz9D8IZkhMwREpBpLMu/nNW6RqpWVpCUa8WQTr8AKE9GjhdXgHHQYxFyb5AbFv+7z5uKaQd3OD5fUb2bYmkq0J07AlkaNCqayI921JUULUglSIdXEp8F/Mv8Cd8rh2Yrff5WeB6WkptoaRXl3Yplw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251575; c=relaxed/simple;
	bh=LSXZcRQz4fI8+KdMeWPEJ2c2P8ADoq1M6SFkGK8FbEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFwueO7j4/OUQhCZovCcHgDLEJ1/kuUZ9Fa8Mk+9Eyls+n8YRCJGA9VZmpDC5eMps90XVT4mbv+YWzPUAZ7ArEs17gPeOfStvB0K2J5wIDLACH+vMiVVLlFAwTzPPAia2spO0tVAu+jB6b1lItlHuoo4P2VmdQ6nL6DRiQlRKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LI3P477H; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LI3P477H"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788251570; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fycY0Gzv+BVjtODlOSPp5qT0n0vx4mMiqOs7d20mfcw=;
	b=LI3P477HUl7puKRWttrtdzo1wI3JA66WLk4j0n1JP/6WYu/uaSoXTum4mwR1krAOE8VoSxe0x0k5SaGkXZoUVdd58dLWOHyEXID2K0pTbRPR/C+fXler8wPYEoEq+OqRq97QTKMRzRKl3NBiyfJ6u8JhmEbianWttP/VvuRCr04=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XA5o3uM_1788251569;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA5o3uM_1788251569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 16:32:49 +0800
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
Subject: [PATCH v2 4/4] drm/vboxvideo: create blend mode property on planes
Date: Tue,  1 Sep 2026 16:32:34 +0800
Message-ID: <20260901083234.1828755-5-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
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
property. Both the vboxvideo primary and cursor planes expose ARGB8888
and trip this on driver load.

VirtualBox draws the cursor through the host windowing system, which
treats the guest-supplied pointer shape as straight
(non-pre-multiplied) alpha: the host frontend loads the pixels
verbatim into an unpremultiplied ARGB image before handing them to the
host cursor APIs. This corresponds to DRM_MODE_BLEND_COVERAGE. Expose
a "pixel blend mode" property advertising only DRM_MODE_BLEND_COVERAGE
to make these semantics explicit and silence the warning. The primary
plane's alpha channel is ignored by the host (opaque blit) and it is
the bottom-most plane anyway; advertise the same value there for
consistency.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
v2: advertise DRM_MODE_BLEND_COVERAGE instead of PREMULTI after
checking how the VirtualBox host composites the pointer shape.

 drivers/gpu/drm/vboxvideo/vbox_mode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index 8e4e5fc9d3c5a..3c41238a82685 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -15,6 +15,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
@@ -540,6 +541,9 @@ static struct drm_plane *vbox_create_plane(struct vbox_private *vbox,
 
 	drm_plane_helper_add(plane, helper_funcs);
 
+	drm_plane_create_blend_mode_property(plane,
+					     BIT(DRM_MODE_BLEND_COVERAGE));
+
 	return plane;
 
 free_plane:
-- 
2.43.7

