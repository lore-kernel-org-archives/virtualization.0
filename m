Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112374B04B4
	for <virtualization@lists.linux.dev>; Sat,  8 Aug 2026 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786230604; cv=none; b=lnp6583D5RKtvFYsNaAYK9gs0xrNbvFtLe/qBGhAvLqEHGA7hU6+lD5vSn4BSfTqyGBp9SXSDQ7yuy6+MmJlBq2vAHSpghgDN3g8/btYPGURQ54PQGwfjN1kkb2+y50fkb7qFNZ/fVTuoVzirY8crCQEV7DdiQB83DTQXnva7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786230604; c=relaxed/simple;
	bh=veI2S5AkKBecHOHYnAhkOXWI5HAFW6XLJIyvcYMukME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aL9H6T2AkJkzB4/qIFA/ZGULiBKORcko4m5oDidHdRccT6tz4u6OVm7Mi8pSG+1VdCLbqqK70eo63toP8R/oOYrenm/o+QfJuhkn1ZXoC/pBQl/omVFqzd+KSsZ71TeeAUXbpzPA7IHoFpSaKrmMKlVOSqbnq2/Aj0uh9TdkNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHlqXSb9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHlqXSb9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso6978695ad.2
        for <virtualization@lists.linux.dev>; Sat, 08 Aug 2026 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786230602; x=1786835402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rH2W1wopjxMu7bNPTu3XbUp0wkIuNWweLs/V8E2Ud3Y=;
        b=gHlqXSb94vUnNyKxFv17SkuAHX8BDeNUqtm0GYXJ/2RXKvWHI3mMgThSta1Z8Xe87J
         /5SV8WpEXw4YYxtX8EeFPHhy4gmqQhMTYiwKCAz8J8ocQQduKciydGM3Zx6wvkH1EeDO
         cRm71TYc+I/uxx424OO94PmOHVZPAb2N81jBKR7TPMWzUTL3t754hhn5dv5hIeU0SqcO
         fjGNEeaxMKerneVjjO7AeOqr5+vUzIe0RdbOB1cF0Q93BryDRo/z7hdGXETJQXd9PW+w
         Ew5slJXaP0K/XMg1CadBjwC4ArGxugEVivRgkVRY7Y8/zVWufhRR1Zay3cTQiioJZpLE
         JWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786230602; x=1786835402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rH2W1wopjxMu7bNPTu3XbUp0wkIuNWweLs/V8E2Ud3Y=;
        b=VTWnGumcm/XRYgal3Rogb8sKcEWSqUEpuf8JoGYj0lYprb1T8/KsRyCIFxJvQaLJ/J
         YEym4S+ROkS6nDW5VdM9xvhu1s7Q+PMSEwsC3j+VWmjlnE7ssoUeBbVO+HgvajCVjIk6
         +vlLmZ6bIyhoFRDYPGTnvg3Nx9ezRJb5Q6DnhdHHlTptfaVir35VppNY3c+EN81PfPzA
         qACZIj6OGLud56zx3NQCUhoSqjvL64AwTWB/Dz7yTaalK4bPBKgZKCT6hKPLgyzjhaH+
         0+D5NDCbpWtu9Inf6yCH86S1XLTRcFYlc6j0zhI4ta8XBTwFNe3mek3SRNFo1YdDYjk1
         Es3w==
X-Forwarded-Encrypted: i=1; AHgh+RpN6IM78pwZ5cZ0dexQPI52QxXrFZItJFx0/wSaiuvhyGdLGJJUrJNNHrATWgwyUEOol5b0c9MkVy3BbyVjxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbaOs+K3+J8GQohCBAnOMYM+U1FUk7BkIFRFZyJUkREMbLVMJQ
	7kGOzc/mx/QE8C+FtXvEAxTbMMyer4wK7alUoQHiFV8Bomqkyk1GkFeu
X-Gm-Gg: AR+sD12FFm1VZGdySnA+WHDGzhfc1xuEC7/Sv66eShb+avUYcaXwiboeZSpwwwsnG3Q
	maaz5WALPfW4kgqNtICe1hYG19YBTJ09maKGZOJkvT2x+7jZnsT6KpOvFVnJWPkSpRCcT7umtrb
	EVD5vtJ5TB63VEDmKHYTBZECFFECZ7Wz2mubDcon60wib3gdJgyBks4gXupQFDppuinLag1wxjE
	Cr+++clRUg//sfLs5nidl9S/K4GuOzD+CDRP+ZoezX7WJTxMZI7pQiwEOAYcnhhvyVA/x15GAJP
	wjG4rIBOhOgbzOGBDbx1DIdRvp98lsf9Z+r7M+yBXrPGbpmEG8nWKfukuooHF6EfNrERgMHw2uP
	cjnRsqiIbcLxdXjSiL5mB8gL13vSSHSIMcFnlIhACkkthLNvCuweNJWjHppQMmXuZtQ21WZVVpb
	gP9pCoQO40tIt+M+8CNhO8v2VigTCfiNdm8J76KWbp96i8+qCuQpoJ
X-Received: by 2002:a05:6a20:9c17:b0:3c4:397a:69b0 with SMTP id adf61e73a8af0-3cbadc17561mr24004662637.21.1786230602271;
        Sat, 08 Aug 2026 16:10:02 -0700 (PDT)
Received: from beelink.. ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec26a5dsm23319791eec.26.2026.08.08.16.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 16:10:01 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size computation
Date: Sat,  8 Aug 2026 20:09:45 -0300
Message-ID: <20260808230945.67525-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qxl_alloc_surf_ioctl() works out the backing size of a surface with

	actual_stride = param->stride < 0 ? -param->stride : param->stride;
	size = actual_stride * param->height + actual_stride;

where size and actual_stride are int and param->height is __u32.  Every
operand comes straight from userspace through DRM_IOCTL_QXL_ALLOC_SURF,
which is DRM_AUTH, and the expression is evaluated modulo 2^32 with no
overflow check.

The wrapped value is what reaches qxl_bo_create(), which only rounds it
up to a page.  The original width, height and stride are kept verbatim
in bo->surf and are later handed to the device by qxl_hw_surface_alloc()
together with the address of that undersized allocation, so the driver
tells the host about a surface far larger than the memory backing it.

For example stride=4096, height=1048576 gives
4096 * (1048576 + 1) = 0x1_0000_1000, which truncates to 4096: a
one-page buffer object described to the device as a 4 GiB surface.
Measured on 6.12.101 by probing mmap() lengths against the resulting
GEM object, the backing is 4096 bytes while the surface declared to the
device is 4294967296 bytes.

Two smaller problems are fixed at the same time.  Negating param->stride
is undefined for INT_MIN, and unlike QXL_ALLOC there is no rejection of
a zero-sized request.

Compute the size in a type that cannot wrap, reject INT_MIN and zero
dimensions, and bound the result so it still fits the int parameter of
qxl_gem_object_create().

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -23,6 +23,7 @@
  *          Alon Levy
  */
 
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
@@ -386,12 +387,26 @@
 	struct drm_qxl_alloc_surf *param = data;
 	int handle;
 	int ret;
-	int size, actual_stride;
+	int actual_stride;
+	size_t size;
 	struct qxl_surface surf;
 
 	/* work out size allocate bo with handle */
+	if (param->stride == INT_MIN)
+		return -EINVAL;
 	actual_stride = param->stride < 0 ? -param->stride : param->stride;
-	size = actual_stride * param->height + actual_stride;
+	if (!actual_stride || !param->width || !param->height)
+		return -EINVAL;
+	/*
+	 * size = actual_stride * (height + 1), evaluated in a type that cannot
+	 * wrap, then bounded so it survives the int parameter of
+	 * qxl_gem_object_create().
+	 */
+	if (check_mul_overflow((size_t)actual_stride,
+			       (size_t)param->height + 1, &size))
+		return -EINVAL;
+	if (size > INT_MAX)
+		return -EINVAL;
 
 	surf.format = param->format;
 	surf.width = param->width;
