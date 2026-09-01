Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C04766BB
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251579; cv=none; b=JtTYk2F7HVdyXREFrOPuTtR9qorwu4JAHWyndWU7EXG+POihy5By6z4WYkx5+opIsMRLEbGLxFJIpx0ZI5OumSdvSMHN4VFSU36NXuDkClTqF8BQW32PzsO8gMEHlf7F1uY0I/2z6Zd2SXSMIr30graZd/StGbPsb4gKQCEmXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251579; c=relaxed/simple;
	bh=9tgnLdYl3CaRQm0w+UFFTLyy6mC/kMsQ8XZUV4Tmk/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJTSoxXOrE7SaF5Eia76o2nH0/2t3YhLZFFT1GQM8pPxknOwDJamJZPdjwACl+SxlDMfNQ9b17lR3WFTAEQ/HliCFbqV/AryBC5SMPxzyqY1Tz5ZQkGOWIZmz+B0pitqPGh1ZiVzKqR/oblTlPXMLsZkX91P6ur4VLfRGZjyRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wBuGzghW; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wBuGzghW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788251569; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RNx/AB2rEnwXFgZop/G62OeBN0oID8kahxlVtyhWinw=;
	b=wBuGzghWxw+Z8/+X01lsT5vZmJTy+NRvWv40LrQO9BCtQB/4AlBlzIikJG8NtTDOj9eswYZuPdzRQFHZQcSG5xGqVVIKBIXP0N+VjI3kuE9tiKGsY8JdmHYa6WzUTgzRZjUFk6CBSDrtCbXIWoiyGaqrjk0N7Ts+FYeehp8/NuM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XA5o3tj_1788251567;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA5o3tj_1788251567 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 16:32:48 +0800
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
Subject: [PATCH v2 3/4] drm/virtio: create blend mode property on cursor plane
Date: Tue,  1 Sep 2026 16:32:33 +0800
Message-ID: <20260901083234.1828755-4-qinyuntan@linux.alibaba.com>
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
property. The virtio-gpu cursor plane (HOST_ARGB8888) trips this.

The virtio-gpu specification does not define the cursor alpha
semantics. The host forwards the cursor pixels verbatim to its display
frontends, and the remote cursor protocols among them (SPICE alpha
cursors, the VNC "Cursor With Alpha" encoding) both define
pre-multiplied alpha, matching what userspace has always assumed when
the property is not attached. Expose a "pixel blend mode" property
advertising only DRM_MODE_BLEND_PREMULTI to make these semantics
explicit and silence the warning. The primary plane only exposes
HOST_XRGB8888, so the call is gated to the cursor. No functional
change.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
v2: no code change; explain the protocol-level justification for
PREMULTI in the commit message.

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

