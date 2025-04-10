Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139528D82E
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302836; cv=none; b=jk7z4J/Sl/rWKNeK6xM3XxMe+9Qnstrl04OaI4qovYaLUyMePAzYjO9Y5EumX13QBcZiEbVJs0EVisPTbBmCbdRCBNuXuFAjyHWr0s6HAgo5SkxW55/itMzrwnn+TXRHuJeTlalIpAbPivvpO6iUMRisGwPjhCiGAPJ6ilcpLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302836; c=relaxed/simple;
	bh=ci23s2yV7joLO42Fmxs4iQxQok0ZlXRvmX/Awh5Boe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xxuel6at6oCK3qelxuPQSHLWA/YPhzhXTfG7AR4P27tBCDDrb3by7NwqXFQhstvpBxA/AZbhdvv+9IKhs0dTFEC0f6HjkacxC5oQ60ebEnsU86Phj1ULNkzvLX0PPLGyGm0rYtvquEh4CEWqcbKQeJ5n+Y7wu4UC3ACVgLO5kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPtBhL1A; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPtBhL1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744302834; x=1775838834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ci23s2yV7joLO42Fmxs4iQxQok0ZlXRvmX/Awh5Boe4=;
  b=EPtBhL1AoAQUsqyxQQBjd7bA8CJqJ885JHlYACVRG2g8t2Iz/uT4l+rD
   GNepHHe0pX23bO3J/3UfY0MRSX8hd5q7Kk4KS8dyUP3VpAr6JxRO2IH/l
   F6NXAYb14PiGmT1B62ca1BohInB+LRCmijqc4+5LyOTF3l5ZskNoBQDHy
   Dxb6+SlRGLSChdTpoIiWv4DFUU4x86d2IVZEVouIb2B784xOU9PdtjuI0
   1k8usS95+3HzjHuEfnjAwITX4VNOGCoKaFnJTmr22NocvtDEL+Obl3vjh
   QUh37CkPvMBozO0vIUOCsyfxtr1yFHB+nexLRlvKPbksRrNAvXp5Ak0f3
   g==;
X-CSE-ConnectionGUID: 8UNhXyyDQDe+kdBp1YiyLA==
X-CSE-MsgGUID: 4T1jFPHZSJe8MxTEEkxq7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="57220154"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="57220154"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:33:53 -0700
X-CSE-ConnectionGUID: ply9cMZVTZStZJCamCh4UQ==
X-CSE-MsgGUID: guMNP9+ATVOLzYSdgdd5CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="134129404"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 10 Apr 2025 09:33:50 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 10 Apr 2025 19:33:49 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 17/19] drm/virtio: Pass along the format info from .fb_create() to drm_helper_mode_fill_fb_struct()
Date: Thu, 10 Apr 2025 19:32:16 +0300
Message-ID: <20250410163218.15130-18-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410163218.15130-1-ville.syrjala@linux.intel.com>
References: <20250410163218.15130-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Plumb the format info from .fb_create() all the way to
drm_helper_mode_fill_fb_struct() to avoid the redundant
lookup.

Cc: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: virtualization@lists.linux.dev
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 93763b91bab5..e5805ca646c7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -66,6 +66,7 @@ static const struct drm_framebuffer_funcs virtio_gpu_fb_funcs = {
 static int
 virtio_gpu_framebuffer_init(struct drm_device *dev,
 			    struct virtio_gpu_framebuffer *vgfb,
+			    const struct drm_format_info *info,
 			    const struct drm_mode_fb_cmd2 *mode_cmd,
 			    struct drm_gem_object *obj)
 {
@@ -73,7 +74,7 @@ virtio_gpu_framebuffer_init(struct drm_device *dev,
 
 	vgfb->base.obj[0] = obj;
 
-	drm_helper_mode_fill_fb_struct(dev, &vgfb->base, NULL, mode_cmd);
+	drm_helper_mode_fill_fb_struct(dev, &vgfb->base, info, mode_cmd);
 
 	ret = drm_framebuffer_init(dev, &vgfb->base, &virtio_gpu_fb_funcs);
 	if (ret) {
@@ -315,7 +316,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	ret = virtio_gpu_framebuffer_init(dev, virtio_gpu_fb, mode_cmd, obj);
+	ret = virtio_gpu_framebuffer_init(dev, virtio_gpu_fb, info, mode_cmd, obj);
 	if (ret) {
 		kfree(virtio_gpu_fb);
 		drm_gem_object_put(obj);
-- 
2.49.0

