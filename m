Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013CF364935
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977705; cv=none; b=gorL8C9KuoxbuGFdURHuH0ZKpK/czu7clStdtPV1cGqBK+KNBY/bp4L4h5A30Jopj0agCFRAH0XZpQTelE7kqXlgHQPB4qdDu2A3tFO7YT+pd+Eja/llrtjiq1w+2LVO4mM2ax5Ca0lcK0I5gbvbFeS687o2D7fa+d6h5HcEA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977705; c=relaxed/simple;
	bh=y0aqiZzD4/dauxqWGWZpTeZQeDGgmhoKACp8yCx31Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LO0bjkW+6XvCikkXV1wIiS3FTzZOWfxA7x++e9LG1d9SFT+Mm5v4mIkntCPzwxtS7b83yFIfjUYFWK7QxMkkz6LuIx4+bk3TUscfXanBwSJJExnGOtgPHoE3LlPewUhBaxXjeh0Qt0adfeSafr68OnBOCHIjfnE6Zh1/56HN7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VthpUP7s; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VthpUP7s"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479ae363aaeso4066928b6e.1
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776977703; x=1777582503; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqO5/EH/UF1TE1Yyx5zB/rmOp92tEJKuB03COKwdtP4=;
        b=VthpUP7senZP5v5+8U9fS5tPedFC7KH4EmtlhT4c3vC9j8ICzn9U/Cok3T+WdJAu0m
         bJ7d2pBXnUqcwG81QvtOEdt29qTPCAvb4Am2nlBQgXQ1ITyRt0r840TMbLQtmfZ3NDRf
         Lrysm5Tz2kcREZd52L6QHU0YkEChRDBGLvpOOv0As58BX2MpsBVufMgvAMmqAJDbZvda
         5uEBxmYl29cpAhP7826XpEWWdu7D4Qgc9x8v1JNPtn0vyk5T8A4yI8j7MrnjdwAH2dIx
         xjPnLnpV7IXreaPybZkm35gNg4u313dz6bYfongKmyr5Xl0MRMpqRJ9i6gXJPFUmqhr7
         kpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776977703; x=1777582503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MqO5/EH/UF1TE1Yyx5zB/rmOp92tEJKuB03COKwdtP4=;
        b=RIJtotpWGE0QEMv+yTxzxKzouptBaMcGtQN0ibOi/0EWDUlC2UKPe/VxLgIas1bhDQ
         A59CpBdX0DPp3bYawFUgxt0Druch6KAoC5tIBsZEiGM+MOTqUskLXBeDdoJL1uH6Pc5O
         RsyXD8GVWhYpJvUBXSE+Orxfc3LxFgt8RmhHRckS4+QSj5QgICspM5lYqDfG9D3K0yX7
         Fbl/yBhctFYHYP9JSUO1DujourSPwAxkdip4pbvCo9h6l4uJ2y5EWwX/ZpfaoLnLAXok
         ERq5Ccy7ZgWU9nZ9QSO+VlpKA3MJ1dpqv+Nx0tKDwFWxpIb5fvFxNtRPjj8GAaHEnqOi
         6yrg==
X-Forwarded-Encrypted: i=1; AFNElJ+N9RX6vQv0nykAco2F7lYNbwb89bHhCcaAhE0CpBQe8RkmoLcBrCE2yZOmxN8JgG8gUYel8iBse3ylfI36RA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTWeoPC3M4Z64+HzQTRPsGq68PvHbeckXXlzAxIpa9ub5IzAxT
	oawOtt8P96cqCJgJkjQ6fZ7q1gDZbh4g4mexaBae3lDbeCsTDmvDh+3t
X-Gm-Gg: AeBDiesF/vis40iOvpAqwgBn/PLwry3T3hqM8oPF+8hdwJwlRpcRA8dLQnpoqIEH5KL
	c0pGFhihPUmqC/yI7xWaLIlMA4yXbzKIWNBxg6fzhVQ2aKn6hoVHA8PaDbTy7hlzGtIvxhlRgID
	oVflD6zACAAzz3CmT/7GhZfApGnqOpA25j3tPAeiNiK5iagwZwD7gkhXNcknPN+D84whXncBA4p
	8QGScaNLvOPghzYcqb+2He6eJHoO466HMUmFf1//RVWcyPbiLwqVGxRYHTnEjTRsPAQiZj9Bfxi
	Z8sgiSzKnMzKJysE3sx8ZXnoeTLNgdLxxKL7whU9ipoXjAPPEPqQLFBZaAalCdhLFQ88WGlBjIy
	REdMSi1FCEb+TT5AdkTA9yc068p4dO1Xj/Auydo8X17AZgsNZtsuydx5sSSYMS5hV4JRWLbx9zX
	PORBVuoPIoB0HEE3ch6311Vsecd6FCwn4T5Ewkq8mTCm9rF0TnypthblFc/opRZsjn8M6YWHmj
X-Received: by 2002:a05:6808:4f0a:b0:468:698:a626 with SMTP id 5614622812f47-4799bf4b93dmr13762368b6e.22.1776977702799;
        Thu, 23 Apr 2026 13:55:02 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4799fead505sm14329744b6e.2.2026.04.23.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:55:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 23 Apr 2026 14:53:53 -0600
Subject: [PATCH v14 12/92] dyndbg: drop NUM_TYPE_ARRAY
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-submit-dyndbg-classmap-foundation-v14-12-2b809a8019d0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776977637; l=982;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=y0aqiZzD4/dauxqWGWZpTeZQeDGgmhoKACp8yCx31Lc=;
 b=0ylBEG5Zr2L9JzVM3p0QOGGNJYPJlqcvdgDfrferqn+IIjg0mF/DXa7yY98RemD0Q77UWcis8
 afOWJy3fK3tDbGja7wdbkN+8vIczS7ipTPRP52IXbHMq4ogKAy8+JGS
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE works here, since array decl is complete.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 441305277914..92627a03b4d1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -132,11 +132,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.53.0

