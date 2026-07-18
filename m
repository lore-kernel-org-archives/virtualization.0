Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840CE3806D9
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784417813; cv=none; b=HFg0LiJeNrS8yjMVOepoc65QnnsUg2diO5rdDUQmv4J0+9pRABxIlx823bbgRVBCFtQ7FJlCfF+Kiq6eYlguPFTcFiEy1BEM51tCCSzGSeAbaxy2scaHR8Yj8gzO85apJ/dMrOcqahhPo4YluXtMIdVGfdNoItU5Svxe6FtkbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784417813; c=relaxed/simple;
	bh=EhmF3j+M4AduWGCg7EqLVWPIxAwmTTCxT2Gz0yXqaxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zse90nhvlfAMYXB3BnCewbegGIXzpWLETFP1sBEMvw+PyuSKl4jiO7Y9//pgY64/iGDMrq6JDB1CUSFB4TFhtoZDLBNIaqxdWehJUmgZLL19tB4kSeBS9kWafp4aByXWndNDVIO205uKHwFulE+J9mKN051h9J/VQKoCSCsLSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhNt7TWp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhNt7TWp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954df200ddso7183205e9.0
        for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784417810; x=1785022610; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=77r3PWO7yo5+W5LQS9FlqiYUpbSGXMMaR8d5GZmSOF4=;
        b=mhNt7TWpiLft/BBPNjMWafMZlK7FawVl+G9EEf62+pZjSU2CKcfoDio2731g7bhzNV
         PJILYJlGu/Ce2NyXWYtxvkaxyWSRj4xP8ksvqXqrGcZt9wxoxQc/9qGhW1xNyJ/AR9TT
         NDfsQEFkSdqhszVQU+yQ8ZPmf8PqFaAOo560cmLT6qFRaSvaVyDZFZ9DePGjetns9/T5
         Bpt9G6Hc5N0VG5ZTwA4DO6bguE6cDf5NpudgAQECJ58DmdCe512O/tipxu2diFsdlnbr
         b7AWEzsQB/qOfApov+BncxjJg5HYr67GEIjIfqwM7JIov4ojo6x//mcbT2bkzcRL5UfI
         fkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784417810; x=1785022610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77r3PWO7yo5+W5LQS9FlqiYUpbSGXMMaR8d5GZmSOF4=;
        b=UF0Bg1wxF8NqalOdWMV+mb8uCysbYmzZ619YsXK+D0VEXI7krnaJX6fq/v5jNVssk9
         nHjJjZqh2x7aLXbgKoqF4T4M73e1iBDF2v0jFc7k/uV/SKkZIUwkfnjwKrzKJ8Z8Fwh8
         lyKa0nxh2ZgLKJnsOCNwCyHeMdUz1kawiqEr46TCa99sXP4eb9sYTd4FWYufZ/4fSLul
         IoMAbfdT6uvSco26xl04rvapzLpZYtOqWpp/YIPH2JrapVe0Mb+eEUUsviQ5/v+bELIy
         KHEivVi1XPGpRvGN3R+xOZNqvyLWzEr4JDuirIpuVDhzOguVAamc1YIjRaNaTtCCnopD
         1DYw==
X-Forwarded-Encrypted: i=1; AHgh+Rpk0qcSNULU12CyyqqcT8OW/K4NL5x1F3XLsAtf4qAC6isVk+vL7mYtiVYSG/jc+pG+n0yqcL7xZ/GIdgPrWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5g4d2txaTgmp/eHlOF83v/CMxGbJrxG2ICs5gGBBzaFo1J/+7
	O+gBAjMga0i4bGn0KCoxRsMX3BtVxyjrf3+wGS9C/jMR3g16GU8HYnLI
X-Gm-Gg: AfdE7clqmlSQr7kE/ithXU2qbYsnj6c8P68F4S8c0hrgIsOnf07z3m712YIrB+bt5Al
	XJRpNdV+tCPbtFdcgK4yUXUJ1M3N2jB2qBfOmJX1n21ptn2tuo1SFmgrk16JzfegSjYfFDQ2GqR
	cLIzkwh/uJ45cKCbR4eobO7YmVyEYM69fCGPWCfeym1l/w0E5eU/enI39RugMN/lo/lzUtYiCaZ
	5XykB/GCLX4l1L3zC7+/kMuA0UH1hivgoDgHcOoXYUFNDV2eB3WWogmDzizA+TOkZc4FacvINRF
	g7L3AW9PAv+znejQ1ttrTiqwAocal6vuMq5Yiv0ybuo/r6KxWsUSp/zMS5aL4QraS/5hW+Dr3H0
	gESdXWr9e1Sv6LG0Uv3PCaukY8iJCzu1Thi9VIRyadyFqiYZtz8IAATNu+boF8i3hS4EVhaBRUm
	lymrObhimsFA==
X-Received: by 2002:a05:600c:3b28:b0:493:a623:d090 with SMTP id 5b1f17b1804b1-4954a3f36b6mr89247115e9.10.1784417809642;
        Sat, 18 Jul 2026 16:36:49 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:36:49 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:46 +0200
Subject: [PATCH 15/15] Documentation/gpu: remove completed
 drm_simple_encoder_init() todo
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-15-a78c509e3062@gmail.com>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
In-Reply-To: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-doc@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.15.2

All drm_simple_encoder_init() users have been removed, so drop the
completed todo item.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 Documentation/gpu/todo.rst | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 14cf37590fc7..b7351467dc74 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -29,21 +29,6 @@ refactorings already and are an expert in the specific area
 Subsystem-wide refactorings
 ===========================
 
-Open-code drm_simple_encoder_init()
------------------------------------
-
-The helper drm_simple_encoder_init() was supposed to simplify encoder
-initialization. Instead it only added an intermediate layer between atomic
-modesetting and the DRM driver.
-
-The task here is to remove drm_simple_encoder_init(). Search for a driver
-that calls drm_simple_encoder_init() and inline the helper. The driver will
-also need its own instance of drm_encoder_funcs.
-
-Contact: Thomas Zimmermann, respective driver maintainer
-
-Level: Easy
-
 Replace struct drm_simple_display_pipe with regular atomic helpers
 ------------------------------------------------------------------
 

-- 
2.54.0

