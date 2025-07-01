Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793449620
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360901; cv=none; b=CNjGVQspRyEAp8vndQgeG6DUAWtWUqVKczqsICPp+p3+rwqQvX6W4aonrqe0B5AGwa0X1df2HYd2QOAVIK1rTIfZqv2ANPybPP4Ru0dt1WkAx69nwgXVZtnYU+GmW9/i2h+KA2zwbktdab1mvXSZ8HRMkzDGstkG5nifqOalBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360901; c=relaxed/simple;
	bh=WfMFzYblpT0MAhAylmf9xkigbPNMUabifTB+flTxoQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmjSLI9IcD7t4g5ev+hgSPlsOqmFMG2KIhQibcH5z5Jg+cXIi+zYe0w3BeHE1ks3vzL21oGClUiTG5R6Cw8xoCI6L1fqj2pkb2stomRNvGXRlCNAg2ylw+P+zQePb7RIOPsXV7bsOspO7B+Zvd8/ExWF87VDpfWppaK7t0QCqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R78Ixwgx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R78Ixwgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751360900; x=1782896900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WfMFzYblpT0MAhAylmf9xkigbPNMUabifTB+flTxoQk=;
  b=R78IxwgxZUAw6No+QPkK2a6J7L0KKcIsITyU2DMJdnXASGT20yUZitaW
   sg1OkEzKB8eKUjY0WvJYMQPJKFCTF4q20lU+/NsdlZr7wiVZO7GRooequ
   m7HHfuUB0nYZ2+rUb5igvC2SbBuiiKyOuou0ecD16y5g9LUeWOQajQIz0
   ddtGTN3HeBQv0nJdBYgpQiGymi+Zl3UoKfFyEFmWeqbsWyA3TEJaUzbWe
   6/PXDJRZKNKE+Wfdj3WoD8FNMM9kazfrc8K0uRT1a09eMI7TfrmwkNqI8
   OxXaNzqijAhi4lKudaADAC2/00G/LkTg8mdr0qdT9GHjHLeclVvbZUYc6
   g==;
X-CSE-ConnectionGUID: 9mmX1jGWRBit7lpD04cLZw==
X-CSE-MsgGUID: BFReObt5QP+hp8QMVdZLpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64218455"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="64218455"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:08:19 -0700
X-CSE-ConnectionGUID: ztC/T4PnSkudFjjyEI/bMg==
X-CSE-MsgGUID: NXa1ei8CSxefjOfSad66aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="159427106"
Received: from zzombora-mobl1.ger.corp.intel.com (HELO stinkbox) ([10.245.245.11])
  by orviesa005.jf.intel.com with SMTP; 01 Jul 2025 02:08:15 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 01 Jul 2025 12:08:13 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 07/19] drm/gem: Pass along the format info from .fb_create() to drm_helper_mode_fill_fb_struct()
Date: Tue,  1 Jul 2025 12:07:10 +0300
Message-ID: <20250701090722.13645-8-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701090722.13645-1-ville.syrjala@linux.intel.com>
References: <20250701090722.13645-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Pass along the format info from .fb_create() to aliminate the
redundant drm_get_format_info() calls from the gem fb code.

v2: Fix kernel docs (Laurent)

Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: virtualization@lists.linux.dev
Cc: spice-devel@lists.freedesktop.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 23 +++++++++-----------
 drivers/gpu/drm/qxl/qxl_display.c            |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c   |  3 ++-
 drivers/gpu/drm/xen/xen_drm_front_kms.c      |  2 +-
 include/drm/drm_gem_framebuffer_helper.h     |  2 ++
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 6fe4094bd0fe..1d58b0259df4 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -68,6 +68,7 @@ EXPORT_SYMBOL_GPL(drm_gem_fb_get_obj);
 static int
 drm_gem_fb_init(struct drm_device *dev,
 		 struct drm_framebuffer *fb,
+		 const struct drm_format_info *info,
 		 const struct drm_mode_fb_cmd2 *mode_cmd,
 		 struct drm_gem_object **obj, unsigned int num_planes,
 		 const struct drm_framebuffer_funcs *funcs)
@@ -75,7 +76,7 @@ drm_gem_fb_init(struct drm_device *dev,
 	unsigned int i;
 	int ret;
 
-	drm_helper_mode_fill_fb_struct(dev, fb, NULL, mode_cmd);
+	drm_helper_mode_fill_fb_struct(dev, fb, info, mode_cmd);
 
 	for (i = 0; i < num_planes; i++)
 		fb->obj[i] = obj[i];
@@ -136,6 +137,7 @@ EXPORT_SYMBOL(drm_gem_fb_create_handle);
  * @dev: DRM device
  * @fb: framebuffer object
  * @file: DRM file that holds the GEM handle(s) backing the framebuffer
+ * @info: pixel format information
  * @mode_cmd: Metadata from the userspace framebuffer creation request
  * @funcs: vtable to be used for the new framebuffer object
  *
@@ -152,21 +154,14 @@ EXPORT_SYMBOL(drm_gem_fb_create_handle);
 int drm_gem_fb_init_with_funcs(struct drm_device *dev,
 			       struct drm_framebuffer *fb,
 			       struct drm_file *file,
+			       const struct drm_format_info *info,
 			       const struct drm_mode_fb_cmd2 *mode_cmd,
 			       const struct drm_framebuffer_funcs *funcs)
 {
-	const struct drm_format_info *info;
 	struct drm_gem_object *objs[DRM_FORMAT_MAX_PLANES];
 	unsigned int i;
 	int ret;
 
-	info = drm_get_format_info(dev, mode_cmd->pixel_format,
-				   mode_cmd->modifier[0]);
-	if (!info) {
-		drm_dbg_kms(dev, "Failed to get FB format info\n");
-		return -EINVAL;
-	}
-
 	if (drm_drv_uses_atomic_modeset(dev) &&
 	    !drm_any_plane_has_format(dev, mode_cmd->pixel_format,
 				      mode_cmd->modifier[0])) {
@@ -201,7 +196,7 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
 		}
 	}
 
-	ret = drm_gem_fb_init(dev, fb, mode_cmd, objs, i, funcs);
+	ret = drm_gem_fb_init(dev, fb, info, mode_cmd, objs, i, funcs);
 	if (ret)
 		goto err_gem_object_put;
 
@@ -222,6 +217,7 @@ EXPORT_SYMBOL_GPL(drm_gem_fb_init_with_funcs);
  *                                  callback
  * @dev: DRM device
  * @file: DRM file that holds the GEM handle(s) backing the framebuffer
+ * @info: pixel format information
  * @mode_cmd: Metadata from the userspace framebuffer creation request
  * @funcs: vtable to be used for the new framebuffer object
  *
@@ -234,6 +230,7 @@ EXPORT_SYMBOL_GPL(drm_gem_fb_init_with_funcs);
  */
 struct drm_framebuffer *
 drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
+			     const struct drm_format_info *info,
 			     const struct drm_mode_fb_cmd2 *mode_cmd,
 			     const struct drm_framebuffer_funcs *funcs)
 {
@@ -244,7 +241,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
 	if (!fb)
 		return ERR_PTR(-ENOMEM);
 
-	ret = drm_gem_fb_init_with_funcs(dev, fb, file, mode_cmd, funcs);
+	ret = drm_gem_fb_init_with_funcs(dev, fb, file, info, mode_cmd, funcs);
 	if (ret) {
 		kfree(fb);
 		return ERR_PTR(ret);
@@ -287,7 +284,7 @@ drm_gem_fb_create(struct drm_device *dev, struct drm_file *file,
 		  const struct drm_format_info *info,
 		  const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	return drm_gem_fb_create_with_funcs(dev, file, mode_cmd,
+	return drm_gem_fb_create_with_funcs(dev, file, info, mode_cmd,
 					    &drm_gem_fb_funcs);
 }
 EXPORT_SYMBOL_GPL(drm_gem_fb_create);
@@ -327,7 +324,7 @@ drm_gem_fb_create_with_dirty(struct drm_device *dev, struct drm_file *file,
 			     const struct drm_format_info *info,
 			     const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	return drm_gem_fb_create_with_funcs(dev, file, mode_cmd,
+	return drm_gem_fb_create_with_funcs(dev, file, info, mode_cmd,
 					    &drm_gem_fb_funcs_dirtyfb);
 }
 EXPORT_SYMBOL_GPL(drm_gem_fb_create_with_dirty);
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index f7bc83f2d489..ae7e572b1b4a 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1179,7 +1179,7 @@ qxl_user_framebuffer_create(struct drm_device *dev,
 			    const struct drm_format_info *info,
 			    const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	return drm_gem_fb_create_with_funcs(dev, file_priv, mode_cmd,
+	return drm_gem_fb_create_with_funcs(dev, file_priv, info, mode_cmd,
 					    &qxl_fb_funcs);
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index f19113e5ae8f..d496ac0feb08 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -40,7 +40,8 @@ rockchip_fb_create(struct drm_device *dev, struct drm_file *file,
 	if (!afbc_fb)
 		return ERR_PTR(-ENOMEM);
 
-	ret = drm_gem_fb_init_with_funcs(dev, &afbc_fb->base, file, mode_cmd,
+	ret = drm_gem_fb_init_with_funcs(dev, &afbc_fb->base,
+					 file, info, mode_cmd,
 					 &rockchip_drm_fb_funcs);
 	if (ret) {
 		kfree(afbc_fb);
diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index a360003bee47..806ec66ee7f7 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -62,7 +62,7 @@ fb_create(struct drm_device *dev, struct drm_file *filp,
 	struct drm_gem_object *gem_obj;
 	int ret;
 
-	fb = drm_gem_fb_create_with_funcs(dev, filp, mode_cmd, &fb_funcs);
+	fb = drm_gem_fb_create_with_funcs(dev, filp, info, mode_cmd, &fb_funcs);
 	if (IS_ERR(fb))
 		return fb;
 
diff --git a/include/drm/drm_gem_framebuffer_helper.h b/include/drm/drm_gem_framebuffer_helper.h
index 4fdf9d3d1863..971d266ab1ba 100644
--- a/include/drm/drm_gem_framebuffer_helper.h
+++ b/include/drm/drm_gem_framebuffer_helper.h
@@ -25,10 +25,12 @@ int drm_gem_fb_create_handle(struct drm_framebuffer *fb, struct drm_file *file,
 int drm_gem_fb_init_with_funcs(struct drm_device *dev,
 			       struct drm_framebuffer *fb,
 			       struct drm_file *file,
+			       const struct drm_format_info *info,
 			       const struct drm_mode_fb_cmd2 *mode_cmd,
 			       const struct drm_framebuffer_funcs *funcs);
 struct drm_framebuffer *
 drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
+			     const struct drm_format_info *info,
 			     const struct drm_mode_fb_cmd2 *mode_cmd,
 			     const struct drm_framebuffer_funcs *funcs);
 struct drm_framebuffer *
-- 
2.49.0

