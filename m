Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA23B7B8A
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408295; cv=none; b=akwHS/+4WfxPY1Rn249tcVErjHK/Piu/wo8KsueW3JswVpN8dHolYMVDBrqUudF37rytMpapda/uxWKUFEbVhSs1VdenigevFJyQRGdRMyS0iAc70GFPswP9tfbBKWzmglA8CDtLqBQ4QNz8pFQuWv+Clo97ppF7O0m8bbGHnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408295; c=relaxed/simple;
	bh=E+4uKCclIfWDh+d9Qc5K0SsZwoX0QZA/3pGmHnVYNbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0CQayc5IR/F4EzA8FY+zuu5JvMJjwoyrVvOnTjC0AigVxbwX3rnvbw6G9N0UrKXvzZXqL/ESs04bpUhL8VZEaNXpufW2ddHXo+C4rNvikJ1120x+FQ/0m1ahMlXob4f819RSoCY87eGm5Xh773Zw81UuxJgWRZZN1PPfBXSp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYrtUZam; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYrtUZam"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4671cbce2feso976075b6e.3
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773408293; x=1774013093; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ves6/eFJLAs0HG68Znj+VH4wZtUdDvx4ZnDak47UPW8=;
        b=MYrtUZam3qFS1FXa0rrggw9b5gtX0eEqRQ20Mfr5ggUz9znqxUJroVwnmPJUoerzkL
         /s+D5EGeUymDZkddoSSdknUpVzWeWC6+WXkbTtV+MFv/axM+CtzjIkQ2su2qf70y4Tri
         ENPyDfei82sv+7SULuVAJHKgMtk9KW7R36Shl2UIlL3AMnT98BrUiu9oNtFtMd5DGJrI
         4AGXEGp088XQ+bB0UJ40ha942B+rblzEETyEToY+fEEo5Mysg0nvSrKxTHSJN9lOJpcP
         +b1InoyH1d4MmPf6CyZlV0tE/6Gp/R+Sa7FycOQl89KdZNqz8UKLsLetjhpRA4wozSDA
         HLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408293; x=1774013093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ves6/eFJLAs0HG68Znj+VH4wZtUdDvx4ZnDak47UPW8=;
        b=KESFpHFe2eCMpzWI74io/Bspa74eApkiah58Wfpxx4kcJgwKcCg/JFZ6OCrAqCKKQ1
         4pORPyAY862w7ks4wSsBKnB5cE8g97dkAYgrIgG+XknqH3Bui+7Zc3pgCxb1zDVMqvQI
         SiSCk/j5MtUmNX3Wcix1XoyetUG95KsHCmpdyEBvIMo/Z3biddP6dMszHQtztZXgOBXy
         5vPojC26Y26kRolYBMrrM5KruirhRlVK52M5Z9fwjrYYNNI/lcdn7gLGk9HQKioot8AC
         q5y1f2GaaToowQbsHIjXXhUSfU1NkdCODEHdRNNca4urdRDK2x6Mi0rmwMOd3QaFOlZP
         qvOA==
X-Forwarded-Encrypted: i=1; AJvYcCWA9Qf5oh3TvUbq+JSi8ztzlPXIUK89V3sHWsrEi2NrCVomT7VJz4e5WLrc04D2O8B3aDmz0cO5+Jhh7a1Lhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZtlLATJpILUM76j+rjEl69bkMTPVEsEThP8UlvoAIJqB70EAi
	658yZwGl/bWvUG78ix/oyX2wLyI3pxDZlfEiewTgBgU/L3Nz6OhFVYar
X-Gm-Gg: ATEYQzyMzrqbUS+YtdVV+NBlNQkWNRG+tF7LQHFjmpGhVXPMvmGLV3t4gerjuqGFD3W
	Lw0/YNpGeNFnmKyRoau50m+yceHKRUfQncYfOX7S1GfP6KVzxL/vEhO2YRwWnUy/ZTJycy3yiNZ
	CRocV+WNlMtrG/Mq7uK5tZ3RDDtj4Tqv54fAnZAJ4in4tZFop/9QQwTkGZ/guUqFhoSiXh4YuBc
	FybK8sNQR90B4CRcLpiallWAjuRxEOk+9jjn631a+0BNDxxsVGZ7kTTd0NfMBl8ksLaixKB2JcG
	V4bVKQDm1Dwq+E2YqcHPZ7CYy1d0N9n2zAgHLY5F6el2rL6BNOmspHoMZgbrwj18n1NUEkyCMkP
	UwHv+C8+R2M7I/FdDKQXd2FN3DYvRg1FTSau+RkOVui7g972C3c0qiqqCA3RvdI0boBeWbA3l8Q
	ZS30YaljrPOcb3Q2TMDRl8188c8DVY4rW3GHr6SnQVRPmdg5aL
X-Received: by 2002:a05:6808:1b10:b0:467:254:b90 with SMTP id 5614622812f47-4675704a335mr1612471b6e.10.1773408293451;
        Fri, 13 Mar 2026 06:24:53 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:24:53 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	christian.koenig@amd.com,
	matthew.auld@intel.com,
	arunpravin.paneerselvam@amd.com,
	louis.chauvet@bootlin.com,
	skhan@linuxfoundation.org,
	pmladek@suse.com,
	ukaszb@chromium.org,
	intel-gfx@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 56/65] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
Date: Fri, 13 Mar 2026 07:20:21 -0600
Message-ID: <20260313132103.2529746-57-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qxl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3ff..73998bb331d9 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -67,6 +67,8 @@ module_param_named(modeset, qxl_modeset, int, 0400);
 MODULE_PARM_DESC(num_heads, "Number of virtual crtcs to expose (default 4)");
 module_param_named(num_heads, qxl_num_crtc, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct drm_driver qxl_driver;
 static struct pci_driver qxl_pci_driver;
 
-- 
2.53.0

