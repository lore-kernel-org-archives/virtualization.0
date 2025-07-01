Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBE26C3B5
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360948; cv=none; b=DwxT8G8ZyTGhhXPEMwErqSZtEcOjffr+Fn3F2FzALXX4hKl6BiaD4p3qcfgK2TSFMMJvTE0NzvGVuFlJhB5Jwx9kF/NfgYJnFBNqf7pYJJwblSspR4kmY2yliLNto4fZ6UlmVUu0zejvB7AUzZ85Nsll2apD0oRmZPM2vOmCoDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360948; c=relaxed/simple;
	bh=Jt2ApwNqfavW55auceHwA5TLYIKUOAikN5TF+uNBWCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHIRq2dUjY/c0asAHWM+5+LykKUh1CrpgHkj04dQrCclFdmdIPVq7P+gSiDBUpXDCZg9JQWZEGGbCmzF6JExVXhwttM1mnuvNAXlXIvYX3Zsy/jF8CVYSodpjyfDzUj6dHFywiRPqDZM6jKoPwy2DAjwuS0mXkpTUX/rSazvbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyDe2jbE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyDe2jbE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751360947; x=1782896947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jt2ApwNqfavW55auceHwA5TLYIKUOAikN5TF+uNBWCY=;
  b=DyDe2jbEaqY6rfMEQ9YWy6kBT180Dp1TqObrG4y7hxFV+n4uCuB7+/la
   L0M2DwuuS53p08twlTKIeSInP63BvJlMps4+t3ujqXRCqlnrBLRWaDbiG
   rn8djHXLjWSt0xCe5guvlhnQf4NXwapaPqfyWrFN+vjeOSdbB+ZXD2obz
   B/5OPDAwISVAk7amtB7pS5uMtZH5GqLoSC5xJOSqq88SHhr1JrIBA2Ig3
   MhC/XCiugj4tY/cOZOcW+gFX2d2e6Dj+BZAid+cnqrIpY+po3ZKDKAsbR
   93HW47nwMSof5oUwlc/9itlJcUqfcsEEMb7P6bfYsRZfwqy6sL8HTxgeC
   Q==;
X-CSE-ConnectionGUID: EwsFy6ppQU+rxaPo2FK1KQ==
X-CSE-MsgGUID: Vjnha/HWQDaSUNcdSFtMPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64218622"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="64218622"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:09:06 -0700
X-CSE-ConnectionGUID: vYTyN2iZRhu/uYquNnsiFQ==
X-CSE-MsgGUID: yr16gSiyR/6JbNwgcyxdnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="159427347"
Received: from zzombora-mobl1.ger.corp.intel.com (HELO stinkbox) ([10.245.245.11])
  by orviesa005.jf.intel.com with SMTP; 01 Jul 2025 02:09:03 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 01 Jul 2025 12:09:01 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 17/19] drm/virtio: Pass along the format info from .fb_create() to drm_helper_mode_fill_fb_struct()
Date: Tue,  1 Jul 2025 12:07:20 +0300
Message-ID: <20250701090722.13645-18-ville.syrjala@linux.intel.com>
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

Plumb the format info from .fb_create() all the way to
drm_helper_mode_fill_fb_struct() to avoid the redundant
lookup.

Cc: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: virtualization@lists.linux.dev
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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

