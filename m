Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E747607D
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251577; cv=none; b=Fb/3wc5Srl+1nFYyBtRjfP5TYqQ58RGkUIXzEqrhZYPD/5Wn1F3F49zHxNre8DfxGTItdmECLGRXQfWubqZVfN7TJCgIw3UWQt4XGAh+DpgRio5UbuBZy3v67aZpsi/JBIKtlV85LS8XiI0cdi2eOYrpDj38u8BhRhoROvcsVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251577; c=relaxed/simple;
	bh=QrArlJOpnn1l0C5EPuae51xLAMvuL3hdqe1yfReQiL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8qWTuutYpPkhmGaLWvZ1mFjvhUG44J3/XSgs5Hzf5BRm/1NSDUgwstb1sZiB4+zgii+mh5Whz/kEPcZdowd/jpmX1muyehpXSFs/Y32sDkQs1rTXxYUOz0wtHZ6HNnYhx28tq4Kr5WJfNujlwW/cCH76bZZiq4E0hl7jCIXWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gdhCKrKT; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gdhCKrKT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788251567; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dmsGvnFPGiJMko6TrciY1hQhSYuIL5q33C55EfI8xTo=;
	b=gdhCKrKTlLn8XpACMffzxzykaazJTdOXfyopQYG0ZFH1K/Gk13koFSpRRTQZd0lKH5mAEBOeC4NLGazbHwVcta98tP8bDlFK5DsHYPX03lx6aKRNtvg9zSw2XDC1bbKDd4tt1FvfV3f8jpsvubKLwLj4awygpzD44giKvvWuIMo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XA5o3sc_1788251565;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA5o3sc_1788251565 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 16:32:46 +0800
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
Subject: [PATCH v2 1/4] drm/ast: create blend mode property on cursor plane
Date: Tue,  1 Sep 2026 16:32:31 +0800
Message-ID: <20260901083234.1828755-2-qinyuntan@linux.alibaba.com>
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
property. The ast cursor plane (ARGB4444, ARGB8888) trips this on
driver load:

  [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
  WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x48f/0x510 [drm]
  ...
  Call Trace:
   drm_dev_register+0x1ce/0x290 [drm]
   ast_pci_probe+0x19d/0x3f0 [ast]
   local_pci_probe+0x41/0x90

Per Thomas Zimmermann's review, the ASPEED documentation describes the
hardware cursor as blending with straight (non-pre-multiplied) alpha,
which corresponds to DRM_MODE_BLEND_COVERAGE. Expose a "pixel blend
mode" property advertising only DRM_MODE_BLEND_COVERAGE to make the
hardware semantics explicit and silence the warning.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
v2: advertise DRM_MODE_BLEND_COVERAGE instead of PREMULTI, per Thomas
Zimmermann's review and the ASPEED documentation.

 drivers/gpu/drm/ast/ast_cursor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
index fd19c45f2abe2..690d4cd1db5ee 100644
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
+					     BIT(DRM_MODE_BLEND_COVERAGE));
 
 	return 0;
 }
-- 
2.43.7

