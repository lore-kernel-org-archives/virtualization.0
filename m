Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B136F905
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245458; cv=none; b=UA9q/KKM76lBNcpzx9YdlGb5mTSXnhEwZpsTPv53EQR7bSCCwh33KcePqQqKA18SqPwGsuGg6RSi7FbUjqDaGLgmIQsrbpt+wBH7WcsckRLh0wfTNQvIvcLo6oWH20pbjuAXHjyuW1/8cOm26ZJJU4KAxU91pzpHa3C2rgQxxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245458; c=relaxed/simple;
	bh=l4qPUdF5gMC4SWcl2LWA30GYYDiZd1cXPeYkdqRR2C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6lQIswb75jIizLHCC1bu3WeA39mxABNHJTMMH3lLosxOAoduokvZOhlsnQtvdZKyiTo5x8yOrhs9i5kD1vngDPWZ7gyfE1rh/qrluNl/S6VYFcgYr57flMeDx0oc0EjGwM2KYm3hCHl1+yTIFakMJHbzWysjJWlMIZbMeA8nsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jYB3kvES; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jYB3kvES"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788245454; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=juHd+ouhFgJwiNTAO4tV9VXgtlspbyaULj5na1/0bi4=;
	b=jYB3kvESIIAhLdSq17EnzBi2LAczfGtelitayfkVv3gFC0xqsyXXEqU6U2PUH9IdWBcusPC7j46zhYfd0FNy9al/xjWC4d+8rDOYv48R5qd8f5d5zuSMZju0FSVbOSaL5Re3sYft7JucN+g/U7WbSmnvh7agVc1oUHhy12svux4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XA4XWTv_1788245452;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA4XWTv_1788245452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 14:50:53 +0800
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
Subject: [PATCH 4/4] drm/vboxvideo: create blend mode property on planes
Date: Tue,  1 Sep 2026 14:50:45 +0800
Message-ID: <20260901065045.1152136-5-qinyuntan@linux.alibaba.com>
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
property. Both the vboxvideo primary and cursor planes expose ARGB8888
and trip this on driver load.

The planes have always blended with pre-multiplied alpha and userspace
assumes that blend mode when the property is not attached. Expose a
"pixel blend mode" property advertising only DRM_MODE_BLEND_PREMULTI
to make the existing semantics explicit and silence the warning. No
functional change.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 drivers/gpu/drm/vboxvideo/vbox_mode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index 8e4e5fc9d3c5a..658803646eee2 100644
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
+					     BIT(DRM_MODE_BLEND_PREMULTI));
+
 	return plane;
 
 free_plane:
-- 
2.43.7

