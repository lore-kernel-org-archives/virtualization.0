Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAE3EFFAE
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545515; cv=none; b=LO1n0g2v7LMQoT63ons7Ch5hoAepPU40ZV7sxZlvTK58RPgj6lgDXfZaNB3m3Z3E1vEB2Gql+b/z33WhWM5vxo315EuIOKJAL0VIqNageXXnyleapi91RpmuXVzuYIeZKqv0sHFGg8UQeQ5T3DYm1aCuXeSmzzKVh2T4HIFUD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545515; c=relaxed/simple;
	bh=Cr0D8IrXdc7M3cfjxvsuMeRGNkhVfxYYqCumwIz6RgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=On21FO4OIw86q4pAKxFnLLiBClvTc7RMO9RjO+hk73BC9Cx7+LuKWPxhjIUSwIn8selpXjrDT9w9tQUNU5ctc8ORc3AMNgQgt0JdKBMOcsb3O+V8Rhuvkh0YlxgboBctekl9/9o5aM8rr73M2yLAL+6Gt2Ktt6xsSz7eVjEP8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y2FwkocI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SF9cBLWT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y2FwkocI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SF9cBLWT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y2FwkocI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SF9cBLWT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y2FwkocI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SF9cBLWT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30D0A3E09;
	Mon, 20 Jul 2026 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784545507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jy7YQBE9HAIVBFE0VOkSBBzLYevZIQzBSEslKdqseyw=;
	b=y2FwkocI3YQIQJFXqrW9ZKICtrgU7bGVS3vz/2uDjZt14w7zVOXlNMnQ4XTNJUK34rzpem
	JLpUktCdpsjMGideeJkQRJwuSLFJDvapFsfvDgZzS0FCBSnObDwNE5QRv++UUjkN1mcj24
	5ZICafeK/+n3gCHZyy4tZSyWy5JZ2yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784545507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jy7YQBE9HAIVBFE0VOkSBBzLYevZIQzBSEslKdqseyw=;
	b=SF9cBLWTd+GoNKIEYOgPttCZT+F5hmFW/zHjyXOkatbqIxXJH/pnUErjpIGt+RTdjV8E6n
	kYPGn/y9Fv7Ta9Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784545507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jy7YQBE9HAIVBFE0VOkSBBzLYevZIQzBSEslKdqseyw=;
	b=y2FwkocI3YQIQJFXqrW9ZKICtrgU7bGVS3vz/2uDjZt14w7zVOXlNMnQ4XTNJUK34rzpem
	JLpUktCdpsjMGideeJkQRJwuSLFJDvapFsfvDgZzS0FCBSnObDwNE5QRv++UUjkN1mcj24
	5ZICafeK/+n3gCHZyy4tZSyWy5JZ2yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784545507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jy7YQBE9HAIVBFE0VOkSBBzLYevZIQzBSEslKdqseyw=;
	b=SF9cBLWTd+GoNKIEYOgPttCZT+F5hmFW/zHjyXOkatbqIxXJH/pnUErjpIGt+RTdjV8E6n
	kYPGn/y9Fv7Ta9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEE11779AA;
	Mon, 20 Jul 2026 11:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cqwbLeEAXmpUBAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 20 Jul 2026 11:05:05 +0000
Message-ID: <4af254a4-beb7-4f77-830f-42d5bacb10a4@suse.de>
Date: Mon, 20 Jul 2026 13:05:03 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] drm/exynos: remove dependency on DRM simple helpers
To: Diogo Silva <diogompaissilva@gmail.com>, Jingoo Han
 <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>,
 Alison Wang <alison.wang@nxp.com>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu
 <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev,
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-doc@vger.kernel.org
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
 <20260719-drm_simple_encoder_init-v1-1-a78c509e3062@gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260719-drm_simple_encoder_init-v1-1-a78c509e3062@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[renesas];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,ffwll.ch,kernel.org,linaro.org,ideasonboard.com,linux.intel.com,amd.com,nvidia.com,agner.ch,nxp.com,intel.com,redhat.com,collabora.com,chromium.org,iki.fi,pengutronix.de,glider.be,google.com,arm.com,baylibre.com,googlemail.com,lwn.net,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL6e75e7xiqh135443e1d3zo16)];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 

Hi

Am 19.07.26 um 01:35 schrieb Diogo Silva:
> The simple KMS helpers are deprecated because they only add an
> intermediate layer between drivers and atomic modesetting.
>
> Open-code drm_simple_encoder_init() by calling drm_encoder_init()
> directly and providing driver-local drm_encoder_funcs.
> Also check the return value from drm_encoder_init() to avoid silent
> failures.
>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> ---
>   drivers/gpu/drm/exynos/exynos_dp.c       | 13 +++++++++++--
>   drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 14 ++++++++++++--
>   drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 11 +++++++++--
>   drivers/gpu/drm/exynos/exynos_drm_vidi.c | 14 ++++++++++++--
>   drivers/gpu/drm/exynos/exynos_hdmi.c     | 15 +++++++++++++--
>   5 files changed, 57 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
> index b80540328150..1598892c602b 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -24,11 +24,11 @@
>   #include <drm/drm_bridge.h>
>   #include <drm/drm_bridge_connector.h>
>   #include <drm/drm_crtc.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_of.h>
>   #include <drm/drm_panel.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <drm/exynos_drm.h>
>   
>   #include "exynos_drm_crtc.h"
> @@ -79,6 +79,10 @@ static void exynos_dp_nop(struct drm_encoder *encoder)
>   	/* do nothing */
>   }
>   
> +static const struct drm_encoder_funcs exynos_dp_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs exynos_dp_encoder_helper_funcs = {
>   	.mode_set = exynos_dp_mode_set,
>   	.enable = exynos_dp_nop,
> @@ -95,7 +99,12 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>   
>   	dp->drm_dev = drm_dev;
>   
> -	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	ret = drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
> +	if (ret) {
> +		dev_err(dp->dev, "Failed to initialize encoder\n");

Preferably use drm_err and drm_dev.

> +		return ret;
> +	}
>   
>   	drm_encoder_helper_add(encoder, &exynos_dp_encoder_helper_funcs);
>   
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> index 0dc36df6ada3..4e42a1da81d1 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> @@ -12,10 +12,10 @@
>   #include <linux/regulator/consumer.h>
>   
>   #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_panel.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include <video/of_videomode.h>
>   #include <video/videomode.h>
> @@ -140,6 +140,10 @@ static void exynos_dpi_disable(struct drm_encoder *encoder)
>   	}
>   }
>   
> +static const struct drm_encoder_funcs exynos_dpi_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs exynos_dpi_encoder_helper_funcs = {
>   	.mode_set = exynos_dpi_mode_set,
>   	.enable = exynos_dpi_enable,
> @@ -194,7 +198,13 @@ int exynos_dpi_bind(struct drm_device *dev, struct drm_encoder *encoder)
>   {
>   	int ret;
>   
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	ret = drm_encoder_init(dev, encoder, &exynos_dpi_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
> +	if (ret) {
> +		DRM_DEV_ERROR(encoder_to_dpi(encoder)->dev,

It just failed to init the encoder, so better not use it here. The 
device should be the same as passed to the function via 'dev'.

> +			      "failed to create encoder ret = %d\n", ret);
> +		return ret;
> +	}
>   
>   	drm_encoder_helper_add(encoder, &exynos_dpi_encoder_helper_funcs);
>   
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index c4d098ab7863..6b7561ac9bb0 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -13,7 +13,7 @@
>   
>   #include <drm/bridge/samsung-dsim.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_encoder.h>
>   
>   #include "exynos_drm_crtc.h"
>   #include "exynos_drm_drv.h"
> @@ -22,6 +22,10 @@ struct exynos_dsi {
>   	struct drm_encoder encoder;
>   };
>   
> +static const struct drm_encoder_funcs exynos_drm_dsi_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static irqreturn_t exynos_dsi_te_irq_handler(struct samsung_dsim *dsim)
>   {
>   	struct exynos_dsi *dsi = dsim->priv;
> @@ -79,7 +83,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master, void *data
>   	struct drm_device *drm_dev = data;
>   	int ret;
>   
> -	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	ret = drm_encoder_init(drm_dev, encoder, &exynos_drm_dsi_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
> +	if (ret)
> +		return ret;
>   
>   	ret = exynos_drm_set_possible_crtcs(encoder, EXYNOS_DISPLAY_TYPE_LCD);
>   	if (ret < 0)
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> index 67bbf9b8bc0e..59dea853d364 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> @@ -13,10 +13,10 @@
>   
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <drm/drm_vblank.h>
>   #include <drm/exynos_drm.h>
>   
> @@ -403,6 +403,10 @@ static void exynos_vidi_disable(struct drm_encoder *encoder)
>   {
>   }
>   
> +static const struct drm_encoder_funcs exynos_vidi_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs exynos_vidi_encoder_helper_funcs = {
>   	.mode_set = exynos_vidi_mode_set,
>   	.enable = exynos_vidi_enable,
> @@ -445,7 +449,13 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
>   		return PTR_ERR(ctx->crtc);
>   	}
>   
> -	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	ret = drm_encoder_init(drm_dev, encoder, &exynos_vidi_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "failed to initialize encoder ret = %d\n",
> +			      ret);

Again, you rather want drm_err() with drm_dev here.

I've briefly looked over the series and many patches seem affected. 
Please prefer drm_ logging functions and DRM devices over the plain 
device equivalents.

Best regards
Thomas


> +		return ret;
> +	}
>   
>   	drm_encoder_helper_add(encoder, &exynos_vidi_encoder_helper_funcs);
>   
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 09b2cabb236f..f44586ce0fdf 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -36,9 +36,9 @@
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_bridge.h>
>   #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   #include "exynos_drm_crtc.h"
>   #include "regs-hdmi.h"
> @@ -1575,6 +1575,11 @@ static void hdmi_disable(struct drm_encoder *encoder)
>   	mutex_unlock(&hdata->mutex);
>   }
>   
> +static const struct drm_encoder_funcs exynos_hdmi_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
> +
>   static const struct drm_encoder_helper_funcs exynos_hdmi_encoder_helper_funcs = {
>   	.mode_fixup	= hdmi_mode_fixup,
>   	.enable		= hdmi_enable,
> @@ -1862,7 +1867,13 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
>   
>   	hdata->phy_clk.enable = hdmiphy_clk_enable;
>   
> -	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	ret = drm_encoder_init(drm_dev, encoder, &exynos_hdmi_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "failed to initialize encoder ret = %d\n",
> +			      ret);
> +		return ret;
> +	}
>   
>   	drm_encoder_helper_add(encoder, &exynos_hdmi_encoder_helper_funcs);
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


