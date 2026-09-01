Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC54CCDE7
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245457; cv=none; b=LX2rtRg8wsNIddN6c+cGi0RNdDXASR8ANKeDdQbhriToibb3ntBYpvvEI+xJcatD0xwqV3dWO49g0bYuNyqBmtnFpfW+t0MLysTq716XJkOWzFHCWBZO6UtpHsBDXND7S4Ea77lTQmS8kGMmjlK+S348vm7Zpe6r1AmckjPELJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245457; c=relaxed/simple;
	bh=LCCZuwWc+pikfTw2kfVqDazB4NpaxPix7k99DTIhjUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXGx+gQj9nmQ2gw0YVviLaiz1f3+JG3hSFhkXldmJKLKWiFadUUAyJ0oCaZ0qEPahyHIlYZihIvaJXkyphIAXqbLMrzxYNXZG3HKQFY3Z9R0zIor/oy1tQdM4s3dbf+mJxfwiCco2qeP5V6TGMfCDtqG5acO8FmZrhHZCzZ4Cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C1nyb4rk; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C1nyb4rk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788245451; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pK0k8hPLuxnI36PnvewidhRB8OWPpE5AE3xyR1ehLOg=;
	b=C1nyb4rkMKZD56EAJY+myYQ+FB24ip6AQd1f2++Q8ZeywLYqrXmjW3TTejtXkQKsWeDeGZ1uvO9OMUZndJOJPXuEcvDe2ffiiIir/IaUUg72AT67a7JA9wmwdERPeRIuTCjmjlX59y4fB4sEdwGT+FmMSrYYDxGYsQgpOckyoLc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XA4XWSz_1788245449;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA4XWSz_1788245449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 14:50:50 +0800
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
Subject: [PATCH 1/4] drm/ast: create blend mode property on cursor plane
Date: Tue,  1 Sep 2026 14:50:42 +0800
Message-ID: <20260901065045.1152136-2-qinyuntan@linux.alibaba.com>
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
property. The ast cursor plane (ARGB4444, ARGB8888) trips this on
driver load:

  [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
  WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x48f/0x510 [drm]
  ...
  Call Trace:
   drm_dev_register+0x1ce/0x290 [drm]
   ast_pci_probe+0x19d/0x3f0 [ast]
   local_pci_probe+0x41/0x90

The hardware cursor has always blended with pre-multiplied alpha and
userspace assumes that blend mode when the property is not attached.
Expose a "pixel blend mode" property advertising only
DRM_MODE_BLEND_PREMULTI to make the existing semantics explicit and
silence the warning. No functional change.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 drivers/gpu/drm/ast/ast_cursor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
index fd19c45f2abe2..08d93ac7f7cb8 100644
--- a/drivers/gpu/drm/ast/ast_cursor.c
+++ b/drivers/gpu/drm/ast/ast_cursor.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -355,6 +356,8 @@ int ast_cursor_plane_init(struct ast_device *ast)
 	}
 	drm_plane_helper_add(cursor_plane, &ast_cursor_plane_helper_funcs);
 	drm_plane_enable_fb_damage_clips(cursor_plane);
+	drm_plane_create_blend_mode_property(cursor_plane,
+					     BIT(DRM_MODE_BLEND_PREMULTI));
 
 	return 0;
 }
-- 
2.43.7

