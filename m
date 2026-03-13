Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADA3B19C5
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408277; cv=none; b=GyOf56n0ZUAddwz0MqQmg9lnYE3IsL5bKL8VKFMK0Oe+JhhD3Mr8RDlQP2HLxog52Ruu2EDzuYbfonM/DCzZGsCA0tia69BMpnA4Qbez05il8abrX9XwuF4EH7LUHXqP0x5AhdjaJFanzLinioWvjsLtuB/TbN8QgQ6H3/b0cY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408277; c=relaxed/simple;
	bh=rIbhSa28GWK8AGaDe/Qk6pwqJANdKpFi8pxj1zud7jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cg8XA5nEdZ1d+oscRLYH1Vno468mIirDQdWY8T1OCgEmgvpVX3v5oCa1kxTT7NMLbdL5Sxt/hggOG1tfKO8trfDulTPzIdTYV0MaqTopiUSvJTgpdaCu2zl0ng6FY5t67QQXGRu7VY0RILZqZgg7w/ReuxqHDz5yTbE3G/tU+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SERGDzb5; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SERGDzb5"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-467161c4ba7so1424115b6e.0
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773408273; x=1774013073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCYC336WoUNdVp8/EmNZcTjPfopk7zVSApVc86osLdY=;
        b=SERGDzb550qBcesiMQFAMiU2O8JzFaXp3YJn6dZPxPG9savaLufbeHgCzJ/cpFS+IT
         tpkRKGCAz2bWpYieNJsP/Mv9nsr8oLO71Szwp4UKAOYmEbG8PGKmE4cq15i97Bf3Cb0H
         YzA3EX1KMYpaeOSVJA1lQ8CcMVvrv3iHR7SwSCPXOEI+YAe0aTP32w3Y69cRj2UrqW03
         Sm20qzYvSaFpQQGJvLG9jJpBZBwIY3KsubuVJEu3C0pDJ3oVN/ahudoRpZGjbiZ1ohBB
         on8B9htkI3iGxxpNIUsP1Tugs9NYQtCi42YMsXEujGUmhiGvCBfTS3I7IVHTsTnK9IUq
         4mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408273; x=1774013073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCYC336WoUNdVp8/EmNZcTjPfopk7zVSApVc86osLdY=;
        b=kC+ayu41fwGOFgqxUI3258aEQNiY1ZboaxQyW/V+caDoXB5JGx0LGL9L1PCjEs/vXu
         hiqsASzqRGxqdmfLM3VYPkxzYcEYQl0mfVN/BMfB1PyVO0rviXeHQdmZXGXwdpKkJcpl
         MFoh/9tzc4hluJ0a36HZntCXcxc6hYOts6MpiT+oraQT/AfsxBqXCXxB/4IuQu/uHbd1
         Ha2CJ8MWLfydg7s5WkJw/P8vVJoLrc5lWBAdRT71V5pAwtOokeN5p3XQLZKPuPE9d13M
         tRaciS+BzftCZe42YuPMI0f2HS8jHZfBxeDDLcA486Crl4BOuBErRmlCkrSP9Y1yuq55
         3FDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRJdIimvE/rsURYTZKYgh3EbR1pLg5LBJk4yBQYP9Wa9O6UuTiMBMsPt+bANDPx9Opt1SLGuCGJ0eJEk1Nlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUoL5sDcrfzQVOxWTSV/YOgZzzn4JULbH9aTyT/o7ly18Nqh/X
	gGdJ3Zvha9OEGzDlh/jGD+MugBYme81q6o3s5d22TCrGLesZp0iLifnF
X-Gm-Gg: ATEYQzwOMAAqsMN/UOjKDNWWRvebOa6+gk0tB+KiWJgBC7Mw3ZgtQNwPZDPyni0gY5e
	ZyCFNSgEa2SiK+Fpoz1D7VnVIdMa+yY7ssPvnl8hyWuMcjCQaoIhgwmDtZN4nyv2jP7WRqFAQVM
	MCL080ESxGifq/CaTd7Z1j6OLtVKbeC6WrCi0/a7zUrbCQ2S6cmzOMtT3gY9MARZq/Y1e1pTF+F
	4npIWL95PQ7W7sTP+h92O42JSIe1qKHo3UeGPfDnU5/lCDm4wGwQellIRgwU7PqBS276ys1FqDY
	VegSP+1E6YHxgnlcpetIaUOzSM8FWfpbHhNQMcDQPIcoklYsbaXXVlBMLso1ouCtIk0wVeriMiA
	3osyeegtL6FP2ZO1A/ltc26iIslF3OTf3xcjryI5TmaFtrXewBbLBbvvEblMF4bRI47b3OGqoIJ
	KgQ+WC4r3S0wDqMyFFSDSqjzHMxYUGuqk2tvxbIlps3xx43+nG
X-Received: by 2002:a05:6808:1383:b0:466:f4cc:2b3c with SMTP id 5614622812f47-467555834cdmr2362487b6e.8.1773408272824;
        Fri, 13 Mar 2026 06:24:32 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:24:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
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
Subject: [PATCH v11 45/65] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
Date: Fri, 13 Mar 2026 07:20:10 -0600
Message-ID: <20260313132103.2529746-46-jim.cromie@gmail.com>
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

virtio_gpu has 10 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5ce96fb8a1d..aea4c117b006 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -49,6 +49,8 @@ static const struct drm_driver driver;
 
 static int virtio_gpu_modeset = -1;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, virtio_gpu_modeset, int, 0400);
 
-- 
2.53.0

