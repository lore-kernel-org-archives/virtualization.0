Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F69361DC1
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977697; cv=none; b=CgFf3H9I7ciw9/Z4xSuX12wVcx7ZQVqNk+eRB85+JhCWyb3pThGvnnPpMgjFkyh3Nr6zQnLe9sAbGzAsyAEFUFDY7eA7nD71oRqJ7537GvDF5HyPiwW3fsy+CNyAeKKstA0/Q2Yqr63V+d4jZSZu5SUYtQhvynczI3v+RUcCFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977697; c=relaxed/simple;
	bh=4QM3LS2xsg7RLYgSN87KN0NOYRoI2SlINH0Xj+sS9wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1Uv1AZZOcCVz0Ft4e8+VmGohLC4HAIp86YYUs9XRD16sdUCdF4RFAF7PjfLQoCDj1JhxgD6XdUoijOI05bYLIj+yeYchq+V/wqltmzN2MfIUfqJplEL6XiwOjm2jNKnjj1KtnuqG14RQRn3Oq2/5UO5lKO9XALFhbnfpVFRsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUgTX56v; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUgTX56v"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4756e74f8edso4894554b6e.1
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776977693; x=1777582493; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OHbRsO14nacRj9UKrh+9hs7l7M/scZ1A9iLFCIgQ2w=;
        b=mUgTX56v4G4L355x0mqnBRVGYHzYdNosmtTATudjiq93hWIMrDHdzuixmhYJ3mplPa
         mB6LZkTIY0NehZjUZ4MV2B52vA1Qxbvh+m4ilmFsyfYw+vH+gfFrOhwmlBYMNvP1DA2N
         PGol79XiDIXvjC8h5hpykH7z+Zs6FTG7gE7NlZXl8mo/3hvCHm3AzcEsxt1vZ3ROVaLm
         8NogJvW7+uNkoNScY14EeqzpP421PLpb9p/0ioKSxYm7dI4ehicSmg57zQ1jV8e3/mj1
         4Lrj2jupWqgflOMV+oClEp98kV9ll4BoLXtgFp8An2TLugohxmG8QRDXq5gePuzcx/GS
         cjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776977693; x=1777582493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3OHbRsO14nacRj9UKrh+9hs7l7M/scZ1A9iLFCIgQ2w=;
        b=DMLhEyvALidGX4rrpxuXOVRq/b2UWYOMhOtRk6VZ01+9kRfm2DZOGtvIa/11b0pxuX
         av0RSJnzMw+mB1lT5n2ZBX29XVpbUkuhgaNKxxOSven/q0mPDMI1HRCL9e/xw0WPB0z3
         k0IsasxCGhc25YXNdbBvFQ4BS8kAQmH6Z7R0h2s9j0BjTgjZj3Vy68Qo0OmNHKP5PF/m
         MYVzuTeLH0ezLMc7cuSmZEBNbA6ABLIRbdrVk3g3TcoYdq3W+WU5sSSDzGhh9VFh2wKx
         1NysM2WWvCQswtwQ6Hqcoa52DQRu7EDOaRQhJuBlIYIABhevOvJLulrm9GgdqEKGU8Oj
         roAA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZqZKq2zGbKQZ2dKNgNpNbqMGVdjUlqjpqWvnKZPSVAFxZssIsalS5SKMiSKkgLFRGPJz5vJEuxx6CKxX/DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMTHTmh5i6P0R8mGxdUtubeFGQ+IarfsVuGWyFHYVTaYgD963t
	huITd2K2OK2OJPXB0QVxjArvCH4WoSsaq7x55oeoeIXanZv5pROd/yWP
X-Gm-Gg: AeBDievU0kSQ7dzp/Oo/kRZXuwgVitxmZl/fpeqkYjq83NG3B0B3685yIA/c/4n44CB
	YrV1I+O2GEU4WKEmrnj8z+IcvEsX/iRpa1228E+4VZHANm57a9lp0Grm57qW2T8ndAzMbt6EpK1
	VuHnrZZAXIhZiqOzCzmAFvHFxkGSOhNZK1nBNxXF7MC76rjAK9Lx2JCfy7kxNg9mwaJljdf8oX/
	3DKvlp040MXfPKMrBXTrNzqPe6eSqE6WiQRsvnKukZSZpqfZLDMUJje2hQXu+B0p7s+AFUXmMQD
	BKeYfsS1VKqFIayWMNF7/f5cgK9EF6Y3W9lHQmVyPsam5i+AnoHv+QLpGQEwrOhGlfBvsyxNVKD
	F2MJ33dJtGbREQg6PfVnw5Yl1+q263NZJP025iC2jYlv9lz5HQzpTDbuefY1D+NaaQzIJfMbKDK
	AVjBivEd9S0fWGT+UsDWiGScFLgDe/URrLiZEmZE8a2FpmTvYFAL8nl5ySTamAE4bhU+92Yqag2
	ClvVA+M4E4=
X-Received: by 2002:a05:6808:d4a:b0:467:49c0:5f6d with SMTP id 5614622812f47-4799ca893f0mr15678939b6e.23.1776977692926;
        Thu, 23 Apr 2026 13:54:52 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4799fead505sm14329744b6e.2.2026.04.23.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:54:52 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 23 Apr 2026 14:53:51 -0600
Subject: [PATCH v14 10/92] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-submit-dyndbg-classmap-foundation-v14-10-2b809a8019d0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776977636; l=1024;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=4QM3LS2xsg7RLYgSN87KN0NOYRoI2SlINH0Xj+sS9wE=;
 b=zEZMT0WhA4tazHE8iUsJRCDfWjq/snV5y5Ucebwf2eD2LMkQH1VD4rtB+5MLgRCm4kUHuVv2l
 mCQ8zw3QDM0CpaAyRTte6a4hImlzDdBhTb6cuX8iNQbekmlAYqZ0f+w
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b1e983cfedc..a9caf84ddb22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1166,7 +1166,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.53.0

