Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DE2DF138
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908022; cv=none; b=DFFIOYy/bW55yEps+OTCc99hobm9uQxYB9SyT8iiwT6rzSX/J/hm/8Ot9ZbrQSiYkSjtwx9XZULQ1InKYfcYP73VMb3RyJDV7jB/7ZeZdwpbsy7kXxt9g6Qb0EmjYI8dWgH3r+DOAS7oIvmAOQCAznNrbReRBguuo7WbIMnQQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908022; c=relaxed/simple;
	bh=xVxY45sxyo2kZ1v8r74VlABGlXYg2ltKQ96hThjr30U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kc5QGQicQEqhC3fCNf+YHvuSzRrnlSqdikP7B7Vd99u0JYCJL+SWNB/u3nK1bjW+KahnHXsydnykRLylC7xX6diQFwefT9U6BO+rDS9CLVBqOkcv6Y9fBYQQFWbxtZ8N5TeZ4Q+cab3vQZRKdszZeaYVw3tadWbFFTf4+jSA8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ep2Ot8PB; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ep2Ot8PB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1n
	fvSbyXaygGDA9i7aXU+p5NHnBngMiGbJBtvILo9no=; b=ep2Ot8PBv4cG1dA+XG
	EW/ww9dNvYTLLGRNbuayPsG/f2D8i964U7XfOQYx7oNErd8Sgu1hxBmSUkPQxqxL
	WAPpIEJd3aujYYO+8H1Hs2MldsKJjtA+OcYGB9Xc4TfxvVr8E/cmoTv93yUOuElS
	uSVUzo9IrUhsFIH5jbS6AanHI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnj3CLT5Fq7b3+SQ--.22427S2;
	Fri, 28 Aug 2026 17:06:19 +0800 (CST)
From: oushixiong1025@163.com
To: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH] drm/qxl: Add pixel blend mode property
Date: Fri, 28 Aug 2026 17:06:08 +0800
Message-Id: <20260828090608.792944-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj3CLT5Fq7b3+SQ--.22427S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUXFWDCF4DJF17tF1UKFg_yoW5Jr1rpa
	y3CFWYyrW5Ja13Jay7Arya9rsxXan3Ka48Cry3t3s7Zw1jyrykAr10kr1I9rW5AaykGa1f
	Xas7GFWDCF4UCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8pnQUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-Qv0BGqRT4vpewAA3r

From: Shixiong Ou <oushixiong@kylinos.cn>

The qxl primary and cursor planes expose formats with an alpha
channel but do not create the pixel blend mode property. Since
commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed") this triggers a warning during
drm_mode_config_validate():

[    4.252654] ------------[ cut here ]------------
[    4.252676] [PLANE:38:plane-0] pixel format with alpha exposed but blend mode not setup
[    4.252719] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate
......
[    4.253089] Call trace:
[    4.253091]  drm_mode_config_validate+0x398/0x558 [drm] (P)
[    4.253177]  drm_dev_register+0x1cc/0x2a0 [drm]
[    4.253262]  qxl_pci_probe+0x120/0x1e0 [qxl]
[    4.253277]  local_pci_probe+0x48/0xb8
[    4.253287]  pci_call_probe+0x70/0x190
......

Blending is done by the host with premultiplied alpha, so create
the property with DRM_MODE_BLEND_PREMULTI as the only supported
mode.

Reported-by: Ye Liu <liuye@kylinos.cn>
Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/qxl/qxl_display.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 7f4178800afd..8193d08485f2 100644
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
@@ -991,13 +992,25 @@ static struct drm_plane *qxl_create_plane(struct qxl_device *qdev,
 	if (err)
 		goto free_plane;
 
+	/*
+	 * Both planes expose formats with an alpha channel. Blending is
+	 * done by the host with premultiplied alpha, which is also the
+	 * property's default value.
+	 */
+	err = drm_plane_create_blend_mode_property(plane,
+						   BIT(DRM_MODE_BLEND_PREMULTI));
+	if (err) {
+		drm_plane_cleanup(plane);
+		goto free_plane;
+	}
+
 	drm_plane_helper_add(plane, helper_funcs);
 
 	return plane;
 
 free_plane:
 	kfree(plane);
-	return ERR_PTR(-EINVAL);
+	return ERR_PTR(err);
 }
 
 static int qdev_crtc_init(struct drm_device *dev, int crtc_id)
-- 
2.25.1

No virus found
		Checked by Hillstone Network AntiVirus

