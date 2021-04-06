Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79355C433ED
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 08:29:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06596613C2
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 08:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06596613C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4AF784055;
	Tue,  6 Apr 2021 08:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mXNuM2RWZAvi; Tue,  6 Apr 2021 08:29:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AAF383FB3;
	Tue,  6 Apr 2021 08:29:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02FE0C0014;
	Tue,  6 Apr 2021 08:29:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 355E5C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 08:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D8F840E76
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 08:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QklhyYmkEmAA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 08:29:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53A3A40E6A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 08:29:46 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 962D7B120;
 Tue,  6 Apr 2021 08:29:44 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, bskeggs@redhat.com, kraxel@redhat.com
Subject: [PATCH 1/4] drm/gem-ttm-helper: Provide helper for struct
 drm_driver.dumb_map_offset
Date: Tue,  6 Apr 2021 10:29:39 +0200
Message-Id: <20210406082942.24049-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406082942.24049-1-tzimmermann@suse.de>
References: <20210406082942.24049-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Provides an implementation of struct drm_driver.dumb_map_offset that
can be used by TTM-based GEM drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_ttm_helper.c | 33 ++++++++++++++++++++++++++++
 include/drm/drm_gem_ttm_helper.h     |  5 ++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
index de28720757af..b14bed8be771 100644
--- a/drivers/gpu/drm/drm_gem_ttm_helper.c
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -114,5 +114,38 @@ int drm_gem_ttm_mmap(struct drm_gem_object *gem,
 }
 EXPORT_SYMBOL(drm_gem_ttm_mmap);
 
+/**
+ * drm_gem_ttm_dumb_map_offset() - Implements struct &drm_driver.dumb_map_offset
+ * @file:	DRM file pointer.
+ * @dev:	DRM device.
+ * @handle:	GEM handle
+ * @offset:	Returns the mapping's memory offset on success
+ *
+ * Provides an implementation of struct &drm_driver.dumb_map_offset for
+ * TTM-based GEM drivers. TTM allocates the offset internally and
+ * drm_gem_ttm_dumb_map_offset() returns it for dumb-buffer implementations.
+ *
+ * See struct &drm_driver.dumb_map_offset.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ */
+int drm_gem_ttm_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
+				uint32_t handle, uint64_t *offset)
+{
+	struct drm_gem_object *gem;
+
+	gem = drm_gem_object_lookup(file, handle);
+	if (!gem)
+		return -ENOENT;
+
+	*offset = drm_vma_node_offset_addr(&gem->vma_node);
+
+	drm_gem_object_put(gem);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_gem_ttm_dumb_map_offset);
+
 MODULE_DESCRIPTION("DRM gem ttm helpers");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
index 7c6d874910b8..c1aa02bd4c89 100644
--- a/include/drm/drm_gem_ttm_helper.h
+++ b/include/drm/drm_gem_ttm_helper.h
@@ -5,8 +5,8 @@
 
 #include <linux/kernel.h>
 
-#include <drm/drm_gem.h>
 #include <drm/drm_device.h>
+#include <drm/drm_gem.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
@@ -24,4 +24,7 @@ void drm_gem_ttm_vunmap(struct drm_gem_object *gem,
 int drm_gem_ttm_mmap(struct drm_gem_object *gem,
 		     struct vm_area_struct *vma);
 
+int drm_gem_ttm_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
+				uint32_t handle, uint64_t *offset);
+
 #endif
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
