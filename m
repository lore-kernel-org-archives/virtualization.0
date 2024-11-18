Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE01DED69;
	Mon, 18 Nov 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957961; cv=none; b=cbL3yxTVDUgKins/9EBmCdtH2yeAiyuP7qtTN+9eQ2/KTKt6j6W77rU46eFhts9V5C5FkIauUIk215li7B4BRthLbcjm9tT+NYHstKL5Govg2QvZTmAxNlh+ElSk0WzmhL2Kdynqa+AxQfEsmi2ZVM9qbZV2gBz5zqsQbrsXtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957961; c=relaxed/simple;
	bh=IvvPfEQx8+njDlP7eg+rVy3Zr9WN9X65JlqiJMcGRGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8yVNIaDoC8sQxtB1RpqO1a+X7lJ0+OXZue99KmK5XuPEtuZfPGiFSCse1lBcgMp9XhwX68CwGHgHBu3vhaQsxYoQ6YbYziiCmuYDC2BJN0yetqoDQkK7FYoLG39mNrrgEqAQz5cpzWUJetNHBqRGLGFILcBM9E3WxWHAeAGj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9+E7XcQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9+E7XcQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so34253155e9.2;
        Mon, 18 Nov 2024 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731957958; x=1732562758; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pD0Ic6pq3x9QjpEUEJLIp8QMqGQFkQZMFW6bkNDgUM=;
        b=S9+E7XcQKRxz3ChAeMgW8wyOf+0LHgTc75hkXDNks5OxtHkfgAxXj9t0iHfWqCZJFu
         pWQyNTvuROoDrCyXozRYvQzKZMOOl6eQJGzHawm11efQgtThny7TxHGXpLcbQ4/kdUda
         Q8fw8fdVasyHeFvE5730Z0lxvxukk+GUQN0iXLMHOlG7vPhCVLGg8zpSz2AzhULitW7j
         e13WwkBqNsRy7tmBnCLVR6XZK5Kpjm9zTwFK7ybUQNCMH9cMkOVRvXq8b2PdYK4lkDqT
         JvynMwBNpa87lKqne/rbxwgaHWjF2MoxPZNmZYTxeRUwQZ480CtqK0KFsVq9Cy/TXuio
         Bmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731957958; x=1732562758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pD0Ic6pq3x9QjpEUEJLIp8QMqGQFkQZMFW6bkNDgUM=;
        b=HgTMxj2M8pGnpQwyKHzYAtTBpH+Pbcnk+0IrCqzBs+qq74W9kgd1rFoIyLMqBw3Itf
         UueI6iylXYJfv5V+xKWFE5oDujXMi66kz77hymX/UlJsqwGiU7Y1l41TUBJ15J/hpF3E
         4zSumEhEL0u7fUZwZ63ZuDz4XTQWJx5bQA0GGiw73j+TalCG6DN57s8shlUhVUgK9PED
         PDLIa7OyxuSHtiKN45gFvrMiHf4syGrsBEUtBSoTF1h61GXqiNLSDQ6D1ErLDLDYQRnf
         5LtA0EBS6PJfx0YlcWGAOQ1KUQVdvV3zxp3084Xo9SFjd8s1cP75k9Rh7XoqAVBd+K+Z
         uKyg==
X-Forwarded-Encrypted: i=1; AJvYcCUJSUYLZAj/1htsxyPip36mKh7eYDzqfqTG2Z774INV8zS0P5ilSlGKfRyEvfv5p0ptuVg=@lists.linux.dev, AJvYcCVcBm5tE4cHc4WAPCqvOWxwFvBCGZbuOL5+CIVr/GNzAAp1eWKdjjcaiXTTLU0FGYpZzqR8OrBc56+5YCUIm1I=@lists.linux.dev, AJvYcCXyimsk6Ee9XFW/M98xA/ur7pB12bFfQLxYoCK/zNWe+EM4Yvihg/l8yaIl17s75FScfv7w/UZILTS6jg4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyMgEftdROscZH5OK087tqybQyLoIVQfqYSfukOsNVrOLlP5IJ5
	++ASSruwMizNhpwcbirwQUgVc2Ct6hF4/xiJnnHT3mN+0VgjKBoY
X-Google-Smtp-Source: AGHT+IH+lcOQ8Rj8oM11CtrUWBNXK6zZA1wltL3ZBTXjDjqXIpvoTVhgtssacVRTup7RXCuDYGl00g==
X-Received: by 2002:a05:600c:1d97:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-432df78f3demr130180715e9.26.1731957957571;
        Mon, 18 Nov 2024 11:25:57 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298c81sm172023915e9.39.2024.11.18.11.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 11:25:57 -0800 (PST)
Message-ID: <8a4f69dd-b393-4e84-be3c-58f8b33bd59d@gmail.com>
Date: Mon, 18 Nov 2024 20:25:49 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/sti: hda: pass const struct drm_display_mode* to
 hda_get_mode_idx()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Alain Volmat <alain.volmat@foss.st.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>, Inki Dae
 <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Stefan Agner <stefan@agner.ch>,
 Alison Wang <alison.wang@nxp.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
References: <20241115-drm-connector-mode-valid-const-v1-0-b1b523156f71@linaro.org>
 <20241115-drm-connector-mode-valid-const-v1-3-b1b523156f71@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20241115-drm-connector-mode-valid-const-v1-3-b1b523156f71@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



> Make hda_get_mode_idx() accept const struct drm_display_mode pointer
> instead of just raw struct drm_display_mode.  This is a preparation to
> converting the mode_valid() callback of drm_connector to accept const
> struct drm_display_mode argument.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Hi Dmitry,

Thank you for the patch.

Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>


Regards,
Raphaël
