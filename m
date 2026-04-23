Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281E366042
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977711; cv=none; b=BdU+FHPwKiRihpw1SU0nHkewjMpE4G8Q4yi5NU8m/uSbb4NA6T8OTEGMT3cFeP+LMz9Y8eyYXqlJs3aBzNdxCfPIowUy4ooWkvK7zXp4TzV5h6LnZyOFgmHtCf4YSQ9SqSRw7dTW1f7cPvI58zizUNhxz/1+0hsTGUtz8xqZEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977711; c=relaxed/simple;
	bh=Lx8Le50+nsjiQgeV6zgGG9hZjacD3w46irda8Vp6AWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNRK1lZyt2GL3hlWLPK8OSyVO+qiAiHYxk9e88UmZd7qpiFy01+YE0xgCPUhb/AiX/mT7gMElSVjeuKG+EypnmOanpgTEogj+gvE0kgnkujxYA2AKUhH7Ao9P7osmG367SHXB6lflPBr8uhYjQlNKlmCXbwkWLtjY4DxU+ByRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCHXIvmV; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCHXIvmV"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479aa2dbea2so2588166b6e.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776977708; x=1777582508; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXxdsOArU9ZJHRv0gxhcPUMG6BfjYVh32ZwNXW3DQls=;
        b=KCHXIvmVfj1rP3zYLOOVApVN4VpFq0JaGi5j9J10Dgjh23TOI5NCqtj57o8ezaMHEW
         gLFJ693WOzugdmYJ9ralIMZfsSNWrXTRTk33uum9/vt9qQT579f3vTqhFKEK96uhE8nU
         jfzYx/+NFY+LbP5JphPa4FH470TOOOzB0XFKOC+53++RMPLjxpiZN1TjB9C+aT8JFjpU
         akf8zPxtPFQxXnMzoZYabCjPjKiNEGCket1m1o6E40e2mYeW3mWc9EnrYaYiAb46pSzb
         CwYNEnXnn9PPtzvAx739secOlf9tv9usqCRthabYf3Cw92K/B61/u1qsDW7K62F67jnO
         4RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776977708; x=1777582508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qXxdsOArU9ZJHRv0gxhcPUMG6BfjYVh32ZwNXW3DQls=;
        b=KKytyEH1SinWxRRHmZSF2ySsRoiv+9fuwBHZjdk0XAXX5j5FGsQdnhGMCbHF/ZP3Zl
         mBgLNErAdOgMiRoM93VBPoZtBP20c5V36ajtVqInNkrFaOY0deQV1bpfPPsdJS+q49ZK
         DJ16Sq/Z/2xxydOKy30s1sad+VGuOmnr2x6Qq9a5K/G2DYgxnaMis/HtlsEYf6btps9D
         +JgYlGRBh/2Twu5wjiSkJQ370Ny54b+rPKJ64tbKfou8HpwTZzzfPbhrmPD/2X8GdCpI
         RKInXS8RiYyjrHQFiYHQQzKLFY6McGEGdGMiTGOxbaS4OqLY7vdG98oiviVBwUr8/X+l
         SG4w==
X-Forwarded-Encrypted: i=1; AFNElJ9KjpB2zFSUqOiUHZavMIwz4+ISx2HDQOt54XpPkTEPzzYySI/J4iKYaz3j2RTJn11H8ped5JwZh+f8Edr8Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhoQufTc54XMQPPRX/8s1aSQsbOpEMntsxgzLvzId7C5LbNyK5
	l+vo1vOzzHOuiFDSuWwv9Co88U4RvDTBHwBBf0aEPhE76yO6xJ3XgrsQ
X-Gm-Gg: AeBDiet416kpR9dG7h0lZ/4vE+YSSgg5HuGHy7+ygqoRBqMJJbVOv2ldKLZ67uvrXof
	BtIsKOoo2nxDByfhfLmgHFeJwuwhHuvWDJlOEN2cldWsdujhoxxwjksqrXtptYdGha9Q2DaYfH/
	6pW5Y+N29PlCVLM2hw6z3/orN6iRaSxCPQJU0zZTbRtsPbDQpdKaFjfFCgqgu9+fZgpK/0NDntq
	cxONwRmEMvcjmI1WYtz+L5OVBLlWscgfiyb6FbKrCiL3s145SLu0baP3/J+tQmSnDAd1MSVDwfT
	s6aGmp/ovd0pJYPV514ojLyQlFw4RZwW8EQsAmBvCzKvpmdqv3VMlFu0DSTxn7RFOjNgAsUJTPD
	XlIntRgCXJY1FEelCxXWNuQ0fLdiRSylr4/9FIvNMpdouhIC5vNCSuuc+krFUZNDktCY6VNkLq2
	zmXNoKUARnbxk74P+6zaBHR+Bwi3BkPJ46HvvbgB22EpG5guKUBfz97trAGBZW9nJHBmpi9G07E
	zrWOMDN6tQ=
X-Received: by 2002:a05:6808:2381:b0:467:f567:d609 with SMTP id 5614622812f47-4799cacba8amr15988443b6e.34.1776977708127;
        Thu, 23 Apr 2026 13:55:08 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4799fead505sm14329744b6e.2.2026.04.23.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:55:07 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 23 Apr 2026 14:53:54 -0600
Subject: [PATCH v14 13/92] dyndbg: tweak pr_fmt to avoid expansion
 conflicts
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-submit-dyndbg-classmap-foundation-v14-13-2b809a8019d0@gmail.com>
References: <20260423-submit-dyndbg-classmap-foundation-v14-0-2b809a8019d0@gmail.com>
In-Reply-To: <20260423-submit-dyndbg-classmap-foundation-v14-0-2b809a8019d0@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Sean Paul <sean@poorly.run>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Paul Kocialkowski <paulk@sys-base.io>, 
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, 
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Jani Nikula <jani.nikula@intel.com>, Luca Coelho <luciano.coelho@intel.com>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776977637; l=739;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Lx8Le50+nsjiQgeV6zgGG9hZjacD3w46irda8Vp6AWc=;
 b=SnpdcS+23XSjrZpeLIyoz7fp4858ZuhNdkUZ3gyhPRKYDKkKBaruLmuYi2tS21h9vU8M8wWZE
 Y5Q7mlfCnULCyFEZyjXTXMc7I7vQ1FQTWqcfAQXyvf5zEOLG4FrW4jT
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Disambiguate pr_fmt(fmt) arg, by changing it to _FMT_, to avoid naming
confusion with many later macros also using that argname.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ffa1cf7c2c72..9575b92a8deb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2013 Du, Changbin <changbin.du@gmail.com>
  */
 
-#define pr_fmt(fmt) "dyndbg: " fmt
+#define pr_fmt(_FMT_) "dyndbg: " _FMT_
 
 #include <linux/kernel.h>
 #include <linux/module.h>

-- 
2.53.0

