Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257A512BF21
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347609; cv=none; b=aWGt4ttGRWbJU355JGj9N078w6bYB+iwhAE0MwS9wPQC48cxoeICWVFPCzkcsyMUv5NhYZqvZosfwf26Et6/Ber0ZbV2ER+kOGCU3NoeFx1gJ47cOh/JzTMV6fZxbMJR1LaECic1xIGic10eZsEnzLQA/RY7TGPa4u08A+NQqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347609; c=relaxed/simple;
	bh=qbGksS+c77n27GaUMP1vp6e/Bg5X8SWyvezjtiDsHHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MePl8pdKDlzO199wxAWOO48y6/YwPPU60F6Wh2WEZgNO8RgHYVbzbiIpEGJ2MM9LQHL0/sxQwSQfiqrSdNzug+Ro63msD1UN4n294tw9MCNVFc2AKCQGAS1DjhnwrfK16327yYSMIe0SckBkmgDbJhqbSQLhUfKIIOXklPM9Saw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwYeLfs8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwYeLfs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347606; x=1746883606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qbGksS+c77n27GaUMP1vp6e/Bg5X8SWyvezjtiDsHHg=;
  b=hwYeLfs88UbYa6lac5Pc/JFGgUcWE9saD3xTADc1EoxvLfTFr3vroB2z
   PseXZqHbW5y5ofxywCIYeFGBSv+o9/F2RxSsna/npjb50J1jZrOzNheGn
   eYbEabo9rE2TpngF+UAHqrloJMnuOgyQvxEWc9lasVcSvvBi9ERkcBjg4
   CS6sXiwc7v1XFrMsoIjp5ET/V+k5ACqhIZ/RzBRz8bDnitNsbfKYFQCZU
   jWFhEaPnoQyfOWxIXhOKWsHzY//aAVcjK4L4Li3Pq/zbevvyHqYqNO7Y4
   stZe3OOQajtzq5Y9ev9E/JCsmgTEgwx3K7yI1AhgyxVJI+Q+jgOTNq6oo
   Q==;
X-CSE-ConnectionGUID: WFDZoE9KTmG6c8zpmpN3Sg==
X-CSE-MsgGUID: UuLav5J1Ra+smusU+mH4LA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11489979"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11489979"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:26:44 -0700
X-CSE-ConnectionGUID: ewdiqt6QT9yM8csIhcPWzQ==
X-CSE-MsgGUID: yPxnscI1SpCkr7huABmVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30168809"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:26:43 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Gerd Hoffmann <kraxel@redhat.com>,
	virtualization@lists.linux.dev
Subject: [RESEND 5/6] drm/bochs: switch to struct drm_edid
Date: Fri, 10 May 2024 16:26:08 +0300
Message-Id: <24536f4a1a12af7b43ba86e9761dfeef179b72df.1715347488.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1715347488.git.jani.nikula@intel.com>
References: <cover.1715347488.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Prefer struct drm_edid based functions over struct edid.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/bochs.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 2d7ad808cc0e..d12d6e0bf3df 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -85,7 +85,7 @@ struct bochs_device {
 	u16 yres_virtual;
 	u32 stride;
 	u32 bpp;
-	struct edid *edid;
+	const struct drm_edid *drm_edid;
 
 	/* drm */
 	struct drm_device *dev;
@@ -199,10 +199,10 @@ static int bochs_hw_load_edid(struct bochs_device *bochs)
 	if (drm_edid_header_is_valid(header) != 8)
 		return -1;
 
-	kfree(bochs->edid);
-	bochs->edid = drm_do_get_edid(&bochs->connector,
-				      bochs_get_edid_block, bochs);
-	if (bochs->edid == NULL)
+	drm_edid_free(bochs->drm_edid);
+	bochs->drm_edid = drm_edid_read_custom(&bochs->connector,
+					       bochs_get_edid_block, bochs);
+	if (bochs->drm_edid == NULL)
 		return -1;
 
 	return 0;
@@ -303,7 +303,7 @@ static void bochs_hw_fini(struct drm_device *dev)
 	if (bochs->fb_map)
 		iounmap(bochs->fb_map);
 	pci_release_regions(to_pci_dev(dev->dev));
-	kfree(bochs->edid);
+	drm_edid_free(bochs->drm_edid);
 }
 
 static void bochs_hw_blank(struct bochs_device *bochs, bool blank)
@@ -471,12 +471,9 @@ static const struct drm_simple_display_pipe_funcs bochs_pipe_funcs = {
 
 static int bochs_connector_get_modes(struct drm_connector *connector)
 {
-	struct bochs_device *bochs =
-		container_of(connector, struct bochs_device, connector);
-	int count = 0;
+	int count;
 
-	if (bochs->edid)
-		count = drm_add_edid_modes(connector, bochs->edid);
+	count = drm_edid_connector_add_modes(connector);
 
 	if (!count) {
 		count = drm_add_modes_noedid(connector, 8192, 8192);
@@ -507,10 +504,10 @@ static void bochs_connector_init(struct drm_device *dev)
 	drm_connector_helper_add(connector, &bochs_connector_connector_helper_funcs);
 
 	bochs_hw_load_edid(bochs);
-	if (bochs->edid) {
+	if (bochs->drm_edid) {
 		DRM_INFO("Found EDID data blob.\n");
 		drm_connector_attach_edid_property(connector);
-		drm_connector_update_edid_property(connector, bochs->edid);
+		drm_edid_connector_update(&bochs->connector, bochs->drm_edid);
 	}
 }
 
-- 
2.39.2

