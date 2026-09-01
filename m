Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2336197E
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245457; cv=none; b=gZyhNmG5hEZORZiUyQH3n0JxxkToFYw9LtlutbWn2GmTJ9jRGOo+on4bKt+FLPnirayuwa5mwmKtSEMCMt6nFcQ/36XOgAQjGTJSDgEX0cqSksjgdnJKip+lYugrrVqYX1QvhpDe4BI2WTLYd+y2/yo9GtHzQmSH0q7P2fUKSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245457; c=relaxed/simple;
	bh=vccdml3Gx5UYhkiDMlgryGSZgbpoUs2zfDs5PCxuhkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP1kMQNtneTiEllNi0q3IrfV5w5dDokCRglimiQCEcl+tYOomcn8Gr7n8rLq9bTt0ECfiAudmiFmsP9XnRHINWgxTZanDIa7Wg1+FaObgk4CNzpq4IxiX1WPdU4u5Q8s9o424WNTTnBV/Lghj2i9y6WrEYjD98jFKIsYPygDxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BQONdtUX; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BQONdtUX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788245453; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rf4WK0KdwAQ6jr0zJzFS4FpQKho5BAQcjv37Xsync5k=;
	b=BQONdtUXvOwZz9kI5RfwFFsTNCqE4b5P+VPTQc7NkFKnH+ZhZZAo/WqF/SyTIRnhfeg7NkyhuuQ1BqimTn5Edb9VZo42t6bupwwxctj4hABxDoowNh5/YwNEGZfy0ElxzXFIfJZLFfIkrt4P4oWnUIfhMDAPNbgTM5wve6MYDOs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XA4XWTg_1788245451;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA4XWTg_1788245451 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 14:50:52 +0800
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
Subject: [PATCH 3/4] drm/virtio: create blend mode property on cursor plane
Date: Tue,  1 Sep 2026 14:50:44 +0800
Message-ID: <20260901065045.1152136-4-qinyuntan@linux.alibaba.com>
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
property. The virtio-gpu cursor plane (HOST_ARGB8888) trips this.

The cursor has always blended with pre-multiplied alpha and userspace
assumes that blend mode when the property is not attached. Expose a
"pixel blend mode" property advertising only DRM_MODE_BLEND_PREMULTI
to make the existing semantics explicit and silence the warning. The
primary plane only exposes HOST_XRGB8888, so the call is gated to the
cursor. No functional change.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 1d1b27ece62a7..640815af40980 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -24,6 +24,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -609,6 +610,9 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 
 	if (type == DRM_PLANE_TYPE_PRIMARY)
 		drm_plane_enable_fb_damage_clips(plane);
+	else if (type == DRM_PLANE_TYPE_CURSOR)
+		drm_plane_create_blend_mode_property(plane,
+						     BIT(DRM_MODE_BLEND_PREMULTI));
 
 	return plane;
 }
-- 
2.43.7

