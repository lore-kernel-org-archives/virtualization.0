Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75C375ACB
	for <virtualization@lists.linux.dev>; Sun, 31 May 2026 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780212984; cv=none; b=rvMCw4w3Ih/3e1lcmTUB8QGWbuQsnLes699oS9Czwdc0fuaLL7aVAWyJbU7ow2jb/wH4s8fhS4/VvC1gwBNUM7dUmdy6D9bqtnwCDzNWWwGgwTBsM1v+J4c2meJ/YxjPr4yELrt4B1038lv1A7rUaRi3q1pSejWhZgnHTqaXpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780212984; c=relaxed/simple;
	bh=k6wBULCYIiyk0FUjY0yuvrexV74Nvw8GP0L3zD9RVk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jyd0JvF59Pr8CDPs5kHYGBcU/7YVURBz0OWtEDrkSnxqDVCzDWF2BGHKLUcuQsWZFtlYrlUrn9R0QH4GDerTdGsrFJj5r6UtRbNC7zJWwbEux90zizSBeNuFQdYBJL4Ncjtj/duUcocUtlwpmWZVVoOIKinYZOaRR1PSZVXAIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyQOQnAW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyQOQnAW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8424b6792efso5225b3a.3
        for <virtualization@lists.linux.dev>; Sun, 31 May 2026 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780212982; x=1780817782; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4UPEtYv85DDTxdGxZ3GOa4tyKg7+fMqKk+6YoXF2Fw=;
        b=EyQOQnAWXt0Ha+ZmdkPPMhRcAvk0HVOwCAiGdbhcLudGWVNBNZGL7sTwiCw836uwy5
         P/tk2C2N3+84cgt1QJvEZw50ZK1x8oodMUp9MtzcraCQXvm4vxp1Nw65tSBdcbGUXh/Q
         +/DdB6wAX1ZeJcAXlOSkgGJUQ5X1FxDqTFDMgoVC2jGA6OLuaqJAcB4+ZN77qTf1Ge7+
         P/qYDXhpjA3/gMZlxbRfIso8C54mS5P89CwJI703yM53qU+2wp+0kp16tANYdHfddjTb
         YV8re9scQzaYg7LTfKICan5Vq1fiu/gTDFOqVqX8AXrYkI3HSqyo4q67cK5vKKGaKmFl
         NQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780212982; x=1780817782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4UPEtYv85DDTxdGxZ3GOa4tyKg7+fMqKk+6YoXF2Fw=;
        b=lHDp8PGbzV0P2fDsEW5PnAIwvvmo+Of/wJ/5fUX2PpmYaoMU8DLuuOuih4Tu99NkOV
         U+M0VYBy7godysDCra7qlB66q5wZxZsI6gYy+0kESq20Ut2r8rFRb1XnCYUW1ggqJg99
         trBqQvdr5ArpQg34XpXsbVK9CyU7BdxfxJD5aDvgg5oWoa2QC1WnuaeWT6+xVdAzUoag
         CYfKW4RYZSOvFI5i9vg75SFY8jIWeW28OyQBntzqVB5geryX3Gc+PuIfBbMjEzFahXwL
         vCuaNmODFnegU+ZZ+6d8N2653ZhJpCZeW0S7DwjP7CJKk87hvTAL9mVqz4FWFov6BQN+
         4/Lw==
X-Forwarded-Encrypted: i=1; AFNElJ+7jI9g7U2ZkN2O/9xQKmCCqVgpAEvxWv2XSuFYW7ARLi1x3/trZMzXR3yVT3E29teuH1Uhd4NA/8MyCwO74g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRFckwDplk5VFlscaDLo8Qp0kkXIJeGI7Y3MdIvQp6ogYsxU9k
	CfhJV4jF7WxrdgV0zzNb5u6DbOK2MgvQiZFMFkNtkjlpI5XYjhMqQpu6
X-Gm-Gg: Acq92OHJEXeCLmbtrdZsV0JEs6naJ8osnLoBPzWljn5t5VkWIv5gtC5u6nHyebzGJEl
	e4Al0FiVRhFkJ5zwZxpc5ajGDh4U6fLax1zq++9ZqTS+cje8SAGdr48NltKNwbxNbhFn1z64v9m
	L9WjsvSzXT0AOSLYdTpc0CjT2WgOajerey3do+zo9jiqIIAgQKROpGFIPhSL3175O+p6+8kr6F9
	jL4CGZ6CvBoM9K5giSpke5D6bzmwGGZoceh624v2QnggSa9LcuQvNHgro/Bt73mVPKXlE0Rhf1t
	D+yUvwavxG+g67UTEFxdaTLKBWY68RJhzbPXW9UTRs6XxjSP4ffNxQeSIM8tn+EfD0kLIBYR/ns
	iCh0h+SGFr3qNTUJ36JrEfMSBILXG6WeYj8PQ11zK6Tvs+RVtEVUw3spele///uoyGlst9Kwt90
	nGO7LAbV9RBJ5OWendUeTSAytYjwiW1f24azqELZybJA==
X-Received: by 2002:a05:6a00:1d15:b0:835:3d5e:1dd3 with SMTP id d2e1a72fcca58-8422579f2c6mr6160781b3a.42.1780212982185;
        Sun, 31 May 2026 00:36:22 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8422e712309sm3760709b3a.59.2026.05.31.00.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 00:36:21 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	stefan@agner.ch,
	alison.wang@nxp.com,
	jyri.sarha@iki.fi,
	tomi.valkeinen@ideasonboard.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 0/6] drm: Open-code drm_simple_encoder_init() in several drivers
Date: Sun, 31 May 2026 13:05:26 +0530
Message-Id: <20260531073532.8609-1-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_simple_encoder_init() is a thin wrapper around drm_encoder_init()
that provides a simple destroy-only encoder funcs struct. This series
removes the dependency on drm_simple_kms_helper in six drivers by
open-coding the encoder initialization directly.

Each patch adds a static drm_encoder_funcs struct with a destroy
callback and replaces drm_simple_encoder_init() with drm_encoder_init().
The drm_simple_kms_helper.h include is removed where it is no longer
needed.

Drivers converted in this series:
- fsl-dcu
- tidss
- virtio
- meson (encoder_cvbs, encoder_hdmi, encoder_dsi)

Naman Arora (6):
  drm/fsl-dcu: Open-code drm_simple_encoder_init()
  drm/tidss: Open-code drm_simple_encoder_init()
  drm/virtio: Open-code drm_simple_encoder_init()
  drm/meson: Open-code drm_simple_encoder_init() in encoder_cvbs
  drm/meson: Open-code drm_simple_encoder_init() in encoder_hdmi
  drm/meson: Open-code drm_simple_encoder_init() in encoder_dsi

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c  | 10 +++++++---
 drivers/gpu/drm/meson/meson_encoder_cvbs.c | 10 +++++++---
 drivers/gpu/drm/meson/meson_encoder_dsi.c  | 10 +++++++---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 10 +++++++---
 drivers/gpu/drm/tidss/tidss_encoder.c      | 10 +++++++---
 drivers/gpu/drm/virtio/virtgpu_display.c   |  8 ++++++--
 6 files changed, 41 insertions(+), 17 deletions(-)

-- 
2.20.1

