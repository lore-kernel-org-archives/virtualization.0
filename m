Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35FA3AD529
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408282; cv=none; b=UUe4DId/ZDL4wn2ULzajnuA4w33rzVJGn6pPEyytuGACLu/S84SkcYdaK5dFYF55q7eBIzYeJuEgJBMb29YbuDpNLzRy8+1AMF1JN5DO0j+LbUnIfuuIGWOIYXVd/lHyYC6WrHNrShowOveDK0TAt2T4Q8MbOte+LxdpnYCiC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408282; c=relaxed/simple;
	bh=UoBL10SvM0bLgaLHkjX8LJvaOP7DJ9ez9zUGRPln8S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqHe33tptv/356VRbGJ3rCZTrBb9/aI7XTPLGX0jS5P2I8LxrGHGwdTseYaqyIpv2cz3GB2gUKJQ9yAik2GxvukhoEko41HwsZEvijgwOBVkfIz8M7sojuuIlrboy50noFhs31npCjtRKwJziTazwV9yx880crL9v92xpkCq7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvqoQjTn; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvqoQjTn"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-46704177543so1451420b6e.2
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773408277; x=1774013077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7n8LRPhTnKwHNdLKddxIC02c+MckVOPZFH0J7I21NQ=;
        b=LvqoQjTnS6MVrNQt1jWrgvNe4y7Kf1lzK4t5GM7cOHKsiS4df3yLuhQgv+A3PhaEFV
         bytPfC+T8Ch3Qh8iNtNa0V+TVXEU6E73ub8xWZw1AIHe9NdBsb0xMZprvjAlQdm78BWg
         nbXeUcTh5Uy/p+8n/dUZc4YtVMPCBF9bBWfaRFBK/3+FeYArFWFY5NoYTZSMGx4vUXdQ
         qL5fgA5xYIWa+ge3RdaMHSeNGoQ7CNrHyoWeEALPmUJaPWJUX4+NQAwgAxRAbaTyK4GX
         GmrrFSigQ+HgfXqq9Apc4gNvuHXdIj3Z6Itbckn83TMRRxhIqk8XNn3lsSUGqOm/8dxY
         H73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408277; x=1774013077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v7n8LRPhTnKwHNdLKddxIC02c+MckVOPZFH0J7I21NQ=;
        b=hsPblSz0iJiZ3JsHzo2PeJ64xupVlzGY/aC4LUzwEShPMum/ra10w6uXIbigoLEAvU
         0Mwp6joHjXb81GWeeZGQmT6TLHXgba769NcrmiOFIxCzoLFFLoBTL1bs2D/mSteIOxNa
         9sjYpWVKTPmqJ7P22MWVfVMtrKNBGc16fBlJ/pg05H+PtniLkW2nyYQE+3HZbiuH5UWp
         CwIghF52Yi0hjs4JUZbr3WIEW8G0mSzyORKb1/iPRP0u3jP9KfGADgS0oh+34Weaggfm
         YZigl+z03t/uQEQaJ4QZfQtMRnlOD5OYXxlfEKi0xXCRkkpQ0Dj+G5HCtZF6o2ixnq1S
         PNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlx8nqUtKHjFgfZt7DaGz/MpS7sslSRpmahLvBooFBbJ4QbCzEQebn1F/3TK9+vhR1js4L3yBLJH4kCvuDiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwolZ17Wcx0hkZBqSgpGLJ0FGARKtflA6Jdn9/ZMaL3nnbtLYMA
	1QsfJ/YYgOs6fuRYkw+Id8A2II15jQoQWBOwrZuaVm1WChPR7QrQh+EC
X-Gm-Gg: ATEYQzzTsmYsiiS4K4q0Y+eDSPjFVTOdjsgZQ6juKbE5ldjKy7lpslgL768jkY4Bs56
	4DfdsqzZB2Ak0O/lyg1MmlzI3lKvTJZA+JF0h1PKziqR2Q6Td/XCuOgadv8HAIyXoWctotqPVxG
	XBmfKokYPsRYZ0Ngwvtcv12BpX7YnuIvxHcYyRLiY6nMt4pQMrK4JELxkG0hyqMffeIG0weeN+r
	OKHop9Nf1DFrwajkaqiuwjzoOsw8YtSwA6rqJOsRk7Ea/mtSPab5nfSM2oeMLjYbl01KmlOn5vF
	NjxHvl1Ke+Q5UAXf/NbxtTQeMwH3645TZCU1BWmkQJUF7oodYV9vZqCfnEJvR4cO4a7522EKCWM
	DPqG4SfOd6s2wMbm+9xA/OfqOfG+82c23WyJGVVJEZtPGNTMbVMajptyY3j21UGy+1Fc/XRtx4L
	yRhmVQH2mWX4yvsC69QG8d+vB44lBoDT60TIMWoM4pKiY7rD5a
X-Received: by 2002:a05:6808:c2ba:b0:467:100d:22ba with SMTP id 5614622812f47-467570a534fmr1774878b6e.18.1773408277147;
        Fri, 13 Mar 2026 06:24:37 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:24:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	virtualization@lists.linux.dev,
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
Subject: [PATCH v11 47/65] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
Date: Fri, 13 Mar 2026 07:20:12 -0600
Message-ID: <20260313132103.2529746-48-jim.cromie@gmail.com>
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

tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1abbd..8f04666e7def 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -63,6 +63,8 @@ static int bochs_modeset = -1;
 static int defx = 1024;
 static int defy = 768;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-- 
2.53.0

