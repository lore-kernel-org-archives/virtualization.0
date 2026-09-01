Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CF471404
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251573; cv=none; b=FZZ/+DUHfQrhOrNQguDwzyoTM9bcxGg3wjs+iaeLMQHyTkaHd+Drzr+lSmSUfNMuUCW39y5nCRmU9b6NXg4EdETPZABUX4wXuCuOmxu5oPL5m2iFgDhJMCz3S+ji0pwJaK6oKISitg6Xj1yeg+wZk8vtHveLZHBoFE0kEzL44xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251573; c=relaxed/simple;
	bh=c7hLF8s75SQmy1mnFWEw16SZ5RYfB506Y1oqIjhsX68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VneWOukuLyBCbsKuUpKOvcH0PzluuUejvkKLgbOjfhoXK3DOf/h0nzmfiYer0NuWqNdPQN11SPDQZcxU4TaaijyuDbAfFqwrfFdI2uwvaRJVN9A13mChno4AuHJrW1TZ3n2AasKE5uVxCq0sFrq3gOVzc2gIbNVjFCw8/1e5DEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AVo9IXD/; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AVo9IXD/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788251568; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cVNdgupGJDSpCiWNjr1klyxvUhhBKQDFzP2h81TiiYQ=;
	b=AVo9IXD/DG3SUrMRU1IFmRkhDrr36uLcGHN2KbhH5zN08qCnIL6fRfXtIPZf7oH67AivH+G7lKAS2HXs0qTzBTegZRBlsnfI5qwU92gqUF6sJ41yRUYT+uIRTtTuPq+4GIJ+JnUHkpfSMkE/H0mptLwXG7OdILEgeIftnuGi9ko=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XA5o3t._1788251566;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA5o3t._1788251566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 16:32:47 +0800
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
Subject: [PATCH v2 2/4] drm/qxl: create blend mode property on primary and cursor planes
Date: Tue,  1 Sep 2026 16:32:32 +0800
Message-ID: <20260901083234.1828755-3-qinyuntan@linux.alibaba.com>
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
property. Both the qxl primary and cursor planes expose ARGB8888 and
trip this on driver load.

qxl submits cursors as SPICE_CURSOR_TYPE_ALPHA, which the SPICE
protocol explicitly defines as a "pre-multiplied ARGB8888 pixmap"
(Spice Protocol, "Cursor channel definition" section [1]). This
matches the blend mode userspace has always assumed when the property
is not attached. Expose a "pixel blend mode" property advertising only
DRM_MODE_BLEND_PREMULTI to make these semantics explicit and silence
the warning. The primary plane is the bottom-most plane so its blend
mode has no visible effect; advertise the same value there for
consistency. No functional change.

[1] https://www.spice-space.org/spice-protocol.html

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
v2: no code change; cite the SPICE protocol definition of the ALPHA
cursor type in the commit message.

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

