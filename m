Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C8438476
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562107; cv=none; b=LlHkr4Db0yEDqpx4ro4s7QG7VyrN0FIO3iAn0rmxE+h6s+q+xfAmg9e6aPPBM+C0YNMP5J8yk3dO9yjO6QbnpVS7iFAvjLMwHr1ay7QNcJZZa6AybubJ42Eim84pearMqH7kuADTIXw4HW2XuvslgBviNQFIR1OQ2XeRnqBLlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562107; c=relaxed/simple;
	bh=EhmF3j+M4AduWGCg7EqLVWPIxAwmTTCxT2Gz0yXqaxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scvsGOFWCsRUDu/gD+tllTspY5Zhs4BG6k4hXzAz3DQMoHdIZmW83DMAuUQmACkCfgaGlPARKhAdUmknzUNEtpGFFTGOsYAhyZt2bOyhJR1ox6SmutqFDJX2tFyMCmlXwmQ81rI5Is1oxxBXa8Fr6ynsspPrZHyIsQRAy07v7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7seNkDz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7seNkDz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so9023459f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562104; x=1785166904; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=77r3PWO7yo5+W5LQS9FlqiYUpbSGXMMaR8d5GZmSOF4=;
        b=V7seNkDz8MovfkKgpaU426MLms33MZa0zBRbLjtgPzNvGE9G7vIAJULdW1P4YEXYHm
         TaOyGHkGedOKWO2kwwJFHZkEvBS5xt+q3nSN6r9egFI92uF8pysIP91t388oakKxksZo
         vCU4f6ieBaEazBXGHpS4xJvveNC5RCbHLsZJNV5dWO1xWVcwAWQFS8uViOFRz4a6/AQx
         ni9d8zVkiA7dnrXy5LQ2D8v6HdAgYhlXQX2jIbmCdjiNsN0AfGk/pxCub/LzTQryI8OQ
         A7GUZR7orKtLtS2/AKFoAfC5GUEJJDd+H14cg2U6Jv94UwmddhD6ywOUtl10az8Axwym
         tmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562104; x=1785166904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77r3PWO7yo5+W5LQS9FlqiYUpbSGXMMaR8d5GZmSOF4=;
        b=T1FOgasHuMOHqW7G3V0xAnh2fuRJi2roGnRymr1sAa4dmVoruYYkUuyakyHddz79r/
         1NjJ+YZqpNZKrudCzvljfIqFaKm9W+a2azAByFD4lwJlT74LLh8RnOZVM1vzqmeL176h
         Vt8457JdOgiakuVIRoC1osFB5OUGUEUtgnc5ahtjOUriVrUNBU+RQF6cG12hJ22ZUMNc
         NQo0tMnk/Pkbr8kr+1QKmLGrp2T8m/px5hcCHbADBc4jQ50sEwq3PvWS8aS/zZTjBh0Z
         3bPiDSBTfcM3Y/txHM9VrjX7NLl/R+MMKUHmiN6zOzwhqFYs0VZN7jCINrraShQguF04
         Wgog==
X-Forwarded-Encrypted: i=1; AHgh+Rp/6sgLTWYUZ2Teldu9ik5J4TEL+sV30zSDQfvwkNlA8iQ8US/02GAg51WHNyhOYvG2HBohv3GiD6W5GEBzvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzalkoV7I1Yi8RLZfPTmPKm1RELRDlZrBElB7gRBhoIcXf5VuQz
	gI1u9t1y56KMPRMjYQ/Mtq4DySnl+IPn1owxM/eJ+W26H6cZDkJ8wVqL
X-Gm-Gg: AR+sD104FAyTf+F7RQpVaf2dQT0fiUOg/hDYy+jP1T3i7mtcb97Z863s3ewr+hCYHOM
	jt+RuMRGZ4QDeW2M84Q/F/N4Vau64BWpLDsW3ObaCzFfcpse6/zEXKBb2eFLkdIXhmR5nKyv9K3
	p5CqETZmIxPsDS5zyEuW48D702e6L0J+pV0c3ObLWAUG3KRDq+Z1PvdLA6J4mAfUsh5Ys4X5cLk
	i8fH+ZDVXxvAV3wb7eL0Y5NdmzInXNCLDTcdIKw57sGBM36tlV2D3FV1/GFQsOeFmc4ZiBAsuAn
	8ktXboa0HvOrdYC6TI0uqVq4JJjcMqzKonQ4TpIeMH+oTMFIGwstuw3y1cIol8wV9bNzHe8sTIS
	qNCTN5/k51ZBr2CHDlczAALyYXc3gXZ+rYE/NWXESQNuIZ1/1Tp7cDL/nAYWUl4aM910KhYyTEn
	YsHLVr1aP10w==
X-Received: by 2002:a5d:584f:0:b0:47f:6d57:5a93 with SMTP id ffacd0b85a97d-47f6d575ccbmr10955450f8f.38.1784562103442;
        Mon, 20 Jul 2026 08:41:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:41:42 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:47 +0200
Subject: [PATCH v2 15/15] Documentation/gpu: remove completed
 drm_simple_encoder_init() todo
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-15-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
In-Reply-To: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
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

