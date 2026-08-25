Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EF3DB337;
	Tue, 25 Aug 2026 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645290; cv=none; b=mgNEFFulLXHRsEuqC744ATy0vvQjMKbDBRpeuAFxPAmBIcHH5XwVi2sEYdcqNwdrkzWeZ369259+WlSBiR4LEv0WZ8CMxib+TBpYTMCuqg39ZLHKHKyO5YPYQYRmarilBwmEM+nH+Z2f0AMZnIIt/3T9f8VapvJD9KRXwRQ3K0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645290; c=relaxed/simple;
	bh=Ul3FGDKjBRPHwVKW8bK4lJDUlQtQMKy+8szv5WSLCY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMxawlO/jnyDaACKuxTnm1Zl7PKgG7321i1ZY5snQ/yxWstbkf5n3bAyZ9BVXfFlEgFcJZNcOdtc48Yl9auO5tyRoST/jK1iK9lJb1hzbOPgpjeOAquCr0VHsRgucXrNgk8RXk3bNFN/X4oRQhdy08QBltmhjDyDIb+aNoFkvp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IQAgRM8B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lz48kjJy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NaOJKmg8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qF8jGasF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IQAgRM8B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lz48kjJy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NaOJKmg8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qF8jGasF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9810086CDC;
	Tue, 25 Aug 2026 08:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787645278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MDJ3jw29gkr7CXJOmn+O4FQkSRmuVB8deXVafri3TZo=;
	b=IQAgRM8BPMUn5sHFI1grgs4nJQTd6F3Rx2whrXFyjtSvTBSo4RNud4zSbNMWjrjUCtHbTH
	HzbGP8BFF3Hqzpp/O5ayOaQU8p14eAK94kvzygmYEhRWEFfrN38BsloEdCH5oNnY2mW0Kf
	mEJMeCcfT8xtnvPLDLUC0H9f3NFXdcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787645278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MDJ3jw29gkr7CXJOmn+O4FQkSRmuVB8deXVafri3TZo=;
	b=lz48kjJy+seOuVlUp+acwQRZVTZ2iA60K+m54O/ej3Ln/0b2/ql0P1JR5aCCbGu5HPLw3p
	FDCglF2avAag9RCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787645274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MDJ3jw29gkr7CXJOmn+O4FQkSRmuVB8deXVafri3TZo=;
	b=NaOJKmg8/6Jtc9UrizZTFae3bZZvxq7jJdGL+hrZgri9FuewUeGvVBWhJNPGTdIHplWTbv
	MiHphBABFps99GP3HDGC6Q1QiutfEqTD16qr4ngJ5g4s9kbMd8a7ChwUHkUddYWVnSOXbW
	z2buJYwztzuZszI10ZCXL/AHk3WOQ4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787645274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MDJ3jw29gkr7CXJOmn+O4FQkSRmuVB8deXVafri3TZo=;
	b=qF8jGasF5tDU5HpAPDHta87N+gATgr1VtRSt4MiBP2zDZ3Oc5cPfp6DxD6W70pdnom0/6e
	RBON95eh7BsISVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FBF713332;
	Tue, 25 Aug 2026 08:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id svAVEllNjWrMeAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Aug 2026 08:07:53 +0000
Message-ID: <e393996a-3ef1-4c43-b762-af8cd0f2a4b6@suse.de>
Date: Tue, 25 Aug 2026 10:07:52 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] drm/drm_simple: remove drm_simple_encoder_init
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
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
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
In-Reply-To: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,ffwll.ch,kernel.org,linaro.org,ideasonboard.com,linux.intel.com,amd.com,nvidia.com,agner.ch,nxp.com,intel.com,redhat.com,collabora.com,chromium.org,iki.fi,pengutronix.de,glider.be,google.com,arm.com,baylibre.com,googlemail.com,lwn.net,linuxfoundation.org];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL6e75e7xiqh135443e1d3zo16)];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi

Am 20.07.26 um 17:40 schrieb Diogo Silva:
> The simple KMS helpers are deprecated because they only add an
> intermediate layer between drivers and atomic modesetting.
>
> This series open-codes all remaining drm_simple_encoder_init() users by
> calling drm_encoder_init() directly and providing driver-local
> drm_encoder_funcs where needed. After the driver conversions, the helper
> is removed and the completed DRM todo item is dropped.
>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

For the whole series:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Diogo, do you want to send out another revision? Otherwise it's time to 
get these patches merged.

Best regards
Thomas



> ---
> Changes in v2:
> - Change logging to consistently use drm_err()
> - Link to v1: https://patch.msgid.link/20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com
>
> To: Jingoo Han <jingoohan1@gmail.com>
> To: Inki Dae <inki.dae@samsung.com>
> To: Seung-Woo Kim <sw0312.kim@samsung.com>
> To: Kyungmin Park <kyungmin.park@samsung.com>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Krzysztof Kozlowski <krzk@kernel.org>
> To: Peter Griffin <peter.griffin@linaro.org>
> To: Alim Akhtar <alim.akhtar@samsung.com>
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: Michal Simek <michal.simek@amd.com>
> To: Thierry Reding <thierry.reding@kernel.org>
> To: Mikko Perttunen <mperttunen@nvidia.com>
> To: Jonathan Hunter <jonathanh@nvidia.com>
> To: Stefan Agner <stefan@agner.ch>
> To: Alison Wang <alison.wang@nxp.com>
> To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
> To: David Airlie <airlied@redhat.com>
> To: Gerd Hoffmann <kraxel@redhat.com>
> To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> To: Gurchetan Singh <gurchetansingh@chromium.org>
> To: Chia-I Wu <olvaffe@gmail.com>
> To: Jyri Sarha <jyri.sarha@iki.fi>
> To: Liu Ying <victor.liu@nxp.com>
> To: Frank Li <Frank.Li@nxp.com>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> To: Geert Uytterhoeven <geert+renesas@glider.be>
> To: Xinliang Liu <xinliang.liu@linaro.org>
> To: Sumit Semwal <sumit.semwal@linaro.org>
> To: Yongqin Liu <yongqin.liu@linaro.org>
> To: John Stultz <jstultz@google.com>
> To: Liviu Dudau <liviu.dudau@arm.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Kevin Hilman <khilman@baylibre.com>
> To: Jerome Brunet <jbrunet@baylibre.com>
> To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> To: Jonathan Corbet <corbet@lwn.net>
> To: Shuah Khan <skhan@linuxfoundation.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: virtualization@lists.linux.dev
> Cc: imx@lists.linux.dev
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
>
> ---
> Diogo Silva (15):
>        drm/exynos: remove dependency on DRM simple helpers
>        drm/xlnx/zynqmp_dpsub: remove dependency on DRM simple helpers
>        drm/tegra: remove dependency on DRM simple helpers
>        drm/fsl-dcu: remove dependency on DRM simple helpers
>        drm/kmb: remove dependency on DRM simple helpers
>        drm/virtio: remove dependency on DRM simple helpers
>        drm/tidss: remove dependency on DRM simple helpers
>        drm/imx: remove dependency on DRM simple helpers
>        drm/mediatek: remove dependency on DRM simple helpers
>        drm/renesas/shmobile: remove dependency on DRM simple helpers
>        drm/hisilicon/kirin: remove dependency on DRM simple helpers
>        drm/arm/komeda: remove dependency on DRM simple helpers
>        drm/meson: remove dependency on DRM simple helpers
>        drm/drm_simple: remove deprecated drm_simple_encoder_init function
>        Documentation/gpu: remove completed drm_simple_encoder_init() todo
>
>   Documentation/gpu/todo.rst                        | 15 ---------------
>   drivers/gpu/drm/arm/display/komeda/komeda_crtc.c  |  9 +++++++--
>   drivers/gpu/drm/drm_simple_kms_helper.c           | 13 ++-----------
>   drivers/gpu/drm/exynos/exynos_dp.c                | 13 +++++++++++--
>   drivers/gpu/drm/exynos/exynos_drm_dpi.c           | 13 +++++++++++--
>   drivers/gpu/drm/exynos/exynos_drm_dsi.c           | 11 +++++++++--
>   drivers/gpu/drm/exynos/exynos_drm_vidi.c          | 13 +++++++++++--
>   drivers/gpu/drm/exynos/exynos_hdmi.c              | 14 ++++++++++++--
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c         | 10 +++++++---
>   drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c      |  9 +++++++--
>   drivers/gpu/drm/imx/dc/dc-kms.c                   |  8 ++++++--
>   drivers/gpu/drm/kmb/kmb_dsi.c                     |  9 +++++++--
>   drivers/gpu/drm/mediatek/mtk_dsi.c                | 10 +++++++---
>   drivers/gpu/drm/meson/meson_encoder_cvbs.c        | 11 ++++++++---
>   drivers/gpu/drm/meson/meson_encoder_dsi.c         | 11 ++++++++---
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c        | 11 ++++++++---
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 10 +++++++---
>   drivers/gpu/drm/tegra/dsi.c                       | 16 +++++++++++++---
>   drivers/gpu/drm/tegra/rgb.c                       | 15 +++++++++++++--
>   drivers/gpu/drm/tidss/tidss_encoder.c             | 10 +++++++---
>   drivers/gpu/drm/virtio/virtgpu_display.c          | 12 ++++++++++--
>   drivers/gpu/drm/xlnx/zynqmp_kms.c                 | 14 ++++++++++++--
>   include/drm/drm_simple_kms_helper.h               |  4 ----
>   23 files changed, 183 insertions(+), 78 deletions(-)
> ---
> base-commit: e1113c37ba4f166e37dec74a729e6dfd8cba1687
> change-id: 20260718-drm_simple_encoder_init-d069a4cc7f8b
>
> Best regards,
> --
> Diogo Silva <diogompaissilva@gmail.com>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


