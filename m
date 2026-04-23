Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1933F5A4
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977652; cv=none; b=BAdvHRGYKifATDtgMROcMSz1ULhj2LavBC3fvm+wKiGP/uJmGiXDaZ7OynjHnzPjaBBCtglQ+D1Us3h6OWE1eXJAhzHqgm+G2LAkwzuQ8cfgakBIitCNvkiHko/UKPoKOL2OS65HnY4XKpvrMsPLTgD39CWEppKtWLj9YtfgWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977652; c=relaxed/simple;
	bh=YvI+c+2Ph7G01gY6UA2wVrmrHHoi2nJdOmOI4+tqFF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DrhUTjtzpq60sco77nxVNtaoImpF0kQexo8BUaJ8733sslvSVXZSvO3xMwkT0oX77q8urE0oEemoETnyOgW9O7rIcfBhcg3xINhbMoJcymdxlIoFwlHuJdoBsq2HvMwk9m3JNNIbXbTWAXLDzB02z/ZGEdkvC6WP7JogVJbB+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxZ4zfO4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxZ4zfO4"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-463a0e14abfso3604666b6e.2
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776977648; x=1777582448; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh+dAS21x3C6ulKovRegxLPmO53GnqH/AjpAPmkhI+c=;
        b=oxZ4zfO4us7AIZ+RLN1uAw8JghFxQzQ8G9jQxt8eMrKamUdgPYHIlW3JRqteEFksee
         QMD2ehtj1TbNhPpE25a1Fy3NHvUBE9DrljhKGbxVE64ckbDItweiCMEFJmwMtc0jUue7
         rEREm79dKKOLvC8eh9QWjm6F75FzmqBIVyMmpFPfUcgdDUJN5H7eK1iiBm9ujTEaX1VD
         5ZJXMJIJaf6f52sb6ZBAT4a26ad3HcjiLAwSLHHhd7eHp5ildExtEzeY6YSYnSsbOyiJ
         UZGpkGDVq+56bmdMWr4c8eCzQu/eLXYSRDBr3Er0fx2Ts1n6A11n/8V1F+k3ikCQ0aEd
         BDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776977648; x=1777582448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vh+dAS21x3C6ulKovRegxLPmO53GnqH/AjpAPmkhI+c=;
        b=eBvTqJoTWJlRjJa6pnTsswDXO1FtgUeWf7eTnGPCevsCGp2NdIHxMyPLwJwBP9xMO/
         khiEG/u6Cjgja+8aDCxGW5JCCR44kFigS66LPWuoH4hudtX1mksTRKr3jCAp+5vJYjzr
         5E58Sqp3doqmcI0lUZOnVKDQM71q0lI/ttLyg9Cvs+Ypzdv0lA5J/Bu2kUX5zH1ErYxu
         LrMH1rl9rpS84FvxjUeCiRQEBQPLTxS7GkPnpAlU6lIRGdqStcNQJuz5IiEkmcSwcME9
         YgTy9XBNPMzVvJV52XyoA0kwYw3Bz097L/iBxKE3ZxuqSymGjN90scduiIpuYQ0qEWFQ
         pqWw==
X-Forwarded-Encrypted: i=1; AFNElJ//nf1EymAZ472qvkWffAWkrIXYHm1L8SVxz/EikXlC3RheY0pNNUPJO5H/xJrXkEO5YB6xXYDaUvDLp1p2dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTj5h7LiMLf2+7BUorHfT+rrmgcaGL8RaqtNnF0migeGGT4rV0
	Z8+p6ZPuEgH1zZ//HrIr1BIrBu8EPgz0RDAEzRskOfBJNsm/yG1bPuW0
X-Gm-Gg: AeBDievEtxMaomiT/aNQH0i6KNp5cWzoWTJVudLBAtuw7+bHzcLiaLlBPtp157r0Mlr
	M3Fgdu+VjgnJ+AZdE/A8X/JPTM3NGeWMKcCErreVwKaRMYW3fBiE4cbRYJsRLhEXbJUnVpAnERm
	OUaXjU7/FkB3Rekiy06gz67Xz1v8MkWa8hziZg5eGyrWrrqPoB/GCZXUEfn+elt/4rtLEig6TjJ
	wTyXgZjTAgsPfOFQADtNXItSxU41Q4Pgu62A23xQXgZ5oGERCvtYlI3E9vGREMHJtygRDneMuXC
	V9kA5kWdlsszIC0N2V3uwfLqE2di41xUVU3GcHNBJJ773eJX6MeWZboduXVx4Dbq9dJb1Z9dq4u
	0ImDOBq2l55x+7sU7SXX3WslpSTfeufRZKKdvHWRfcwqe8awi3815VNM3MWjPZa3/6kyH6MYBQ+
	HSuXJLBNh8pew81ASsjrTwwLSisquIB/bKrvvyLEmEODNOLMvjffKSjBRK5opze04WxV9Ip4xqF
	uC9tCowcIU=
X-Received: by 2002:a05:6808:138b:b0:45f:59e:1e06 with SMTP id 5614622812f47-4799c8711e1mr17988935b6e.4.1776977647783;
        Thu, 23 Apr 2026 13:54:07 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4799fead505sm14329744b6e.2.2026.04.23.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:54:07 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 23 Apr 2026 14:53:42 -0600
Subject: [PATCH v14 01/92] dyndbg: fix NULL ptr on i386 due to section
 mis-alignment
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-submit-dyndbg-classmap-foundation-v14-1-2b809a8019d0@gmail.com>
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
 etnaviv@lists.freedesktop.org, Jim Cromie <jim.cromie@gmail.com>, 
 kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776977636; l=2644;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=YvI+c+2Ph7G01gY6UA2wVrmrHHoi2nJdOmOI4+tqFF4=;
 b=JyTcuYLHHiwHBHDMwQ80bkTwG2D19eoKHDE+tl83KcpGRfh3fZenxZ7q9Sw+M3I1crSkiEMPL
 U/h1shBkXbNDxTVmN1qvPMSBm5G8hxuK6TqMgzZBBZXdklZASPjpC8F
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When dyndbg classmaps get used (later in this series), the
__dyndbg_classes section (which has 28 byte structs on i386), causes
mis-alignment of the following __dyndbg section, resulting in a NULL
pointer deref in dynamic_debug_init().

Fix this by:

Adding ALIGN(8) to the BOUNDED_SECTION* macros.  This aligns all
sections using those macros, including the problem section above.
Almost all the other macro uses are already ALIGN(8), either
directly or by being below one.

Removing BOUNDED_SECTION* uses in ORC_UNWINDER sections.  These
explicitly have smaller alignments, and using the modified macros here
would override that alignment, which scripts/sorttable.c does not
tolerate.

Move __dyndbg section back above __dyndbg_classes, restoring its
original position.  This is cosmetic, given the alignment added to the
macros.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601211325.7e1f336-lkp@intel.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 60c8c22fd3e4..db38f52035f3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -212,11 +212,13 @@
 #endif
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
 	_END_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
 	_label_##_END_ = .;
@@ -862,15 +864,21 @@
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
 	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+		__start_orc_header = .;					\
+		KEEP(*(.orc_header))					\
+		__stop_orc_header = .;					\
 	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
+		__start_orc_unwind_ip = .;				\
+		KEEP(*(.orc_unwind_ip))					\
+		__stop_orc_unwind_ip = .;				\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
+		__start_orc_unwind = .;					\
+		KEEP(*(.orc_unwind))					\
+		__stop_orc_unwind = .;					\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\

-- 
2.53.0

