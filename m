Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C0184540
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907748; cv=none; b=q1kGrqge4rkkVVfzwhKNG7iH0ke9B+4GyKEefX4hzVSnFjZJJNUzB7SSZJJWYIWOMo4WZEZf79LrKFbI56vY6qkUKrALjfSTbsNJ99sCzXLQthMf5GH9vVVG/nL/uM1XsNOAQyyEES26vTgl8l1HyhVP78XPH+1QNc8+Litj0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907748; c=relaxed/simple;
	bh=5L+8iMVNX6IQUUlsU3thAK9rhZX6D34E4mPEYocAmeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhDQ1EWK3jLmp1+XEwutW1H7ws7UtNgOjo1n7UAACQzIrbVIAIeXcTfyPnOBEjgdVtCc4bEaLw21rY45eP8464ApsIToawdJ1kSy5eMBrchpRW2idGpKNZsntIdBQ6UvuBYlJ8tF3ygnUzWk612IAl+R3bl9IyPLXdHEjakuPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DffHrHIo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DffHrHIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ug
	CMS/t4pT54t04r48wccbBM2NCtY6+PmK6XmdHCxWk=; b=DffHrHIouN45sCIF7v
	h2MUlrcebTPVJwgwcZSh+29Os7TXCk2qZ4K3Dr2COLLe8eAd8qT0mqCOxYYsm2FE
	LxK3NDcDiRs1r9Lc7sRrTkoW8XPhIhx8IO6k8f38jJM5ixoDzhsp/7SMLffNhsBB
	LyZrpLRpzePklLrUjlmcWpD7U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnB+NlTpFqmR5iSg--.32532S2;
	Fri, 28 Aug 2026 17:01:27 +0800 (CST)
From: oushixiong1025@163.com
To: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH] drm/virtio: Add pixel blend mode property to cursor plane
Date: Fri, 28 Aug 2026 17:01:23 +0800
Message-Id: <20260828090123.784944-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnB+NlTpFqmR5iSg--.32532S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1UWry7WFyrurW3KFW5trb_yoW5GFWxpF
	43CFZIyrWrArsrJayxtayj939Ivan3KF4xKry5Zwsagwn0kry7Ar15A34xurW7JrWUGw4f
	Jr1kuF1q9FZ8uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn2-5UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4QerumqRTmfkigAA3L

From: Shixiong Ou <oushixiong@kylinos.cn>

The cursor plane exposes a format with an alpha channel
(DRM_FORMAT_ARGB8888) without a pixel blend mode property. Since
commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed") this triggers a warning during
drm_mode_config_validate():

[    0.649020] ------------[ cut here ]------------
[    0.649040] [PLANE:36:plane-1] pixel format with alpha exposed but blend mode not setup
[    0.649081] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate
......
[    0.649761] Call trace:
[    0.649764]  drm_mode_config_validate+0x398/0x558 [drm] (P)
[    0.649912]  drm_dev_register+0x1cc/0x2a0 [drm]
[    0.650058]  virtio_gpu_probe+0xd4/0x1c0 [virtio_gpu]
[    0.650088]  virtio_dev_probe+0x1c8/0x310
......
[    0.650261] ---[ end trace 0000000000000000 ]---


Create the property with the only supported blend mode,
DRM_MODE_BLEND_PREMULTI, which is also the property's default and
matches what userspace had to assume before the property existed.

Reported-by: Ye Liu <liuye@kylinos.cn>
Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 1d1b27ece62a..11771c943ea6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -24,6 +24,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -588,6 +589,7 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 	struct drm_plane *plane;
 	const uint32_t *formats;
 	int nformats;
+	int ret;
 
 	if (type == DRM_PLANE_TYPE_CURSOR) {
 		formats = virtio_gpu_cursor_formats;
@@ -610,5 +612,17 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 	if (type == DRM_PLANE_TYPE_PRIMARY)
 		drm_plane_enable_fb_damage_clips(plane);
 
+	if (type == DRM_PLANE_TYPE_CURSOR) {
+		/*
+		 * The cursor plane exposes a format with an alpha channel,
+		 * which requires a blend mode property. The host blends
+		 * premultiplied alpha, matching the property's default.
+		 */
+		ret = drm_plane_create_blend_mode_property(plane,
+							   BIT(DRM_MODE_BLEND_PREMULTI));
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	return plane;
 }
-- 
2.25.1

No virus found
		Checked by Hillstone Network AntiVirus

