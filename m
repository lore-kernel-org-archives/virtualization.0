Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608916;
	b=MRLU/sQyHnfsvtxqocAOIKqaBye+G98n4H66wYMIW/2NjxI0C2/iPS8kYiPgcb2A9l10
	 pxI4vixDistqJWWICiOA0tw6vV7PoYKd6s/QoXe7I1UYK6i8m6jsv11vxzyYQmrHsxTYf
	 S2is2hQee78hcm6GunkjjvznWRPKqFQqIO51SJKuy08mKM0oNCkmE8K7rL58jJH4OYIFn
	 +7cjvOb4JI9D8lCmhyl8cyeo5WxRIsWegPzIU2dV+iRN7ibwky/s0ZxGr2i8UOqbIFoXv
	 cNnFDb4GAbKtQWx/TSL7BCGIAfRe0oC3b45U3ASy4vb8Uz8RoaAHjRM0c46dlFtM38Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608916;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=sLYkZIlajO1RP3a6/sXxM1cwXGCi+Yc63O36rVdHkD0=;
	b=5nKOk37AvaHAtV+C+EEFp+Qk5TQPnyvw7ME07yo3PTU079Lz1LjbLqSSozKaCLKP9cmj
	 KWvxLkWSsAxkunY8SGynmOj0Nhp7TrA52tLqegyXNOdBk1l8lBAsnRY4HvDv1lUnlblYZ
	 kfxg3MtWXFCpxxmDGqMrovqczB/WqQ6gWKQoFSwX+OD+fisQeN/KW2aiZMhrWK//SLNTA
	 O2Kih1PkEGHac/ZxLI/QwZzpPXB0M8A6CY4Sj2QtNbUTAOpcjtLcJ4NjWblbhJpRKmMl5
	 sfA4Qeo0Jx8LQ7zVnJusHyEpXFzgMd3IMu7a0pho328z+hCnvdTOiCAq1HKizkP5U7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aBHI8Bti;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WaP6N4P6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aBHI8Bti;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WaP6N4P6;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47533606A326;
	Mon,  2 Nov 2026 08:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47533606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aBHI8Bti;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WaP6N4P6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aBHI8Bti;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WaP6N4P6
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43FAA21F6F;
	Mon,  2 Nov 2026 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793608913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sLYkZIlajO1RP3a6/sXxM1cwXGCi+Yc63O36rVdHkD0=;
	b=aBHI8Btiv2V3lT1hpQtokRDGhdybXDJ+aalt2MnUuifid0+1yWbNYl3Sk5zpiUWOfb4p6s
	/BBwCLsmjoi1CFs4iy2HYZ8PWTOqb6YcHB6oZzyYxGWINLaTuxfE7K66nU211Dd2+IhWQ5
	kggYNi/7lZnxxzCvHFyn7Vsz/AJxp60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793608913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sLYkZIlajO1RP3a6/sXxM1cwXGCi+Yc63O36rVdHkD0=;
	b=WaP6N4P6oJzoz4X6ExjjjCP40XnZNhue3dENmIYeXKi8fhZ9mEtwTr+oyw/yj0dUPU5Bdi
	+OGUUhPDzruR08CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793608913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sLYkZIlajO1RP3a6/sXxM1cwXGCi+Yc63O36rVdHkD0=;
	b=aBHI8Btiv2V3lT1hpQtokRDGhdybXDJ+aalt2MnUuifid0+1yWbNYl3Sk5zpiUWOfb4p6s
	/BBwCLsmjoi1CFs4iy2HYZ8PWTOqb6YcHB6oZzyYxGWINLaTuxfE7K66nU211Dd2+IhWQ5
	kggYNi/7lZnxxzCvHFyn7Vsz/AJxp60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793608913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sLYkZIlajO1RP3a6/sXxM1cwXGCi+Yc63O36rVdHkD0=;
	b=WaP6N4P6oJzoz4X6ExjjjCP40XnZNhue3dENmIYeXKi8fhZ9mEtwTr+oyw/yj0dUPU5Bdi
	+OGUUhPDzruR08CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B050134B8;
	Mon,  2 Nov 2026 08:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fYQYCs9M6Gq2PwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Nov 2026 08:41:51 +0000
Message-ID: <aa7ea691-03ec-44b0-85fb-9927f3b4a32b@suse.de>
Date: Mon, 2 Nov 2026 09:41:50 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/37] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Russell King <linux@armlinux.org.uk>, Alim Akhtar <alim.akhtar@samsung.com>,
 Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>,
 Huacai Chen <chenhuacai@kernel.org>, Icenowy Zheng
 <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>,
 Xi Ruoyao <xry111@xry111.site>, Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org,
 Alexey Brodkin <abrodkin@synopsys.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 David Airlie <airlied@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 virtualization@lists.linux.dev, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
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
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,armlinux.org.uk,samsung.com,kernel.org,linaro.org,vger.kernel.org,nxp.com,agner.ch,iscas.ac.cn,loongson.cn,aosc.io,xry111.site,glider.be,gmail.com,foss.st.com,sholland.org,lists.linux.dev,nvidia.com,synopsys.com,redhat.com,collabora.com,chromium.org,bootlin.com,epam.com,baylibre.com,googlemail.com,lists.infradead.org,igalia.com,linux.intel.com,intel.com,ursulin.net];
	R_RATELIMIT(0.00)[to_ip_from(RL6e75e7xiqh135443e1d3zo16)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[64];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:email]
X-Spam-Score: -11.79

Hi Maxime

Am 30.10.26 um 16:13 schrieb Maxime Ripard:
> This is a follow-up to the plane and CRTC reset removal series, and
> part of a larger effort to remove the reset hook from all KMS objects.
>
> The connector reset hook is overloaded: it is called both at probe
> time to create the initial software state and during suspend/resume to
> reset hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
>
> While reset has the semantics to reset both the software and hardware
> state, the vast majority of implementations and all the helpers only
> reset the software state, making them equivalent to
> atomic_create_state in practice. The atomic_create_state hook makes
> this explicit: it only allocates and initializes a pristine state
> without any side effect, and returns the state pointer or an ERR_PTR
> on failure.
>
> This series converts all connector drivers tree-wide from the reset hook
> to atomic_create_state, then removes the reset hook from struct
> drm_connector_funcs entirely. The conversions were done using a
> combination of Coccinelle semantic patches, mechanical one-line
> replacements and manual adjustments.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

for the entire series.

Best regards
Thomas


> ---
> Changes in v3:
> - Fix error path in dw-hdmi
> - Fix test error path for amdgpu kunit tests
> - Fix nouveau legacy path
> - Link to v2: https://lore.kernel.org/r/20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org
>
> Changes in v2:
> - Change the parameter order of __drm_atomic_helper_connector_hdmi_state_init
> - Fixed state argument casing for drm_atomic_helper_connector_tv_margins_state_init
>    and drm_atomic_helper_connector_tv_state_init
> - Put atomic_create_state before atomic_duplicate_state
> - Fix state allocation for MST and WB connectors
> - Link to v1:
>    https://lore.kernel.org/r/20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org
>
> ---
> Maxime Ripard (37):
>        drm/amdgpu: vkms: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: analogix-anx6345: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: analogix-anx78xx: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: chrontel-ch7033: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: nxp-ptn3460: Switch to drm_atomic_helper_connector_create_state
>        drm/panel: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: synopsys: dw-hdmi: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: tc358767: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: tda998x: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: ti-tfp410: Switch to drm_atomic_helper_connector_create_state
>        drm/exynos: Switch to drm_atomic_helper_connector_create_state
>        drm/fsl-dcu: Switch to drm_atomic_helper_connector_create_state
>        drm/loongson: Switch to drm_atomic_helper_connector_create_state
>        drm/mipi-dbi: Switch to drm_atomic_helper_connector_create_state
>        drm/renesas: shmobile: Switch to drm_atomic_helper_connector_create_state
>        drm/sitronix: st7571: Switch to drm_atomic_helper_connector_create_state
>        drm/sti: Switch to drm_atomic_helper_connector_create_state
>        drm/sun4i: Switch to drm_atomic_helper_connector_create_state
>        drm/tegra: Switch to drm_atomic_helper_connector_create_state
>        drm/tests: Switch to drm_atomic_helper_connector_create_state
>        drm/tiny: arcpgu: Switch to drm_atomic_helper_connector_create_state
>        drm/tiny: sharp: Switch to drm_atomic_helper_connector_create_state
>        drm/virtio: Switch to drm_atomic_helper_connector_create_state
>        drm/vkms: Switch to drm_atomic_helper_connector_create_state
>        drm/xen: Switch to drm_atomic_helper_connector_create_state
>        drm/bridge: synopsys: dw-hdmi: Convert to atomic_create_state
>        drm/meson: Convert to atomic_create_state
>        drm/sun4i: hdmi: Convert to atomic_create_state
>        drm/sun4i: tv: Convert to atomic_create_state
>        drm/tests: hdmi: Convert to atomic_create_state
>        drm/connector: Remove drm_atomic_helper_connector_reset()
>        drm/amdgpu: dm: Convert to atomic_create_state
>        drm/i915: Convert to atomic_create_state
>        drm/nouveau: Convert to atomic_create_state
>        drm/tegra: Convert to atomic_create_state
>        drm/connector: Remove __drm_atomic_helper_connector_reset()
>        drm/connector: Remove reset
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   2 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  32 ++---
>   .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   3 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  11 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  17 ++-
>   .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 102 +++++++++++-----
>   drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |   2 +-
>   drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |   2 +-
>   drivers/gpu/drm/bridge/chrontel-ch7033.c           |   2 +-
>   drivers/gpu/drm/bridge/nxp-ptn3460.c               |   2 +-
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  14 ++-
>   drivers/gpu/drm/bridge/tc358767.c                  |   2 +-
>   drivers/gpu/drm/bridge/tda998x_drv.c               |   2 +-
>   drivers/gpu/drm/bridge/ti-tfp410.c                 |   2 +-
>   drivers/gpu/drm/display/drm_hdmi_state_helper.c    |   3 +-
>   drivers/gpu/drm/drm_atomic_state_helper.c          |  43 -------
>   drivers/gpu/drm/drm_connector.c                    |   8 --
>   drivers/gpu/drm/drm_mode_config.c                  |   4 +-
>   drivers/gpu/drm/drm_panel.c                        |   4 +-
>   drivers/gpu/drm/exynos/exynos_drm_dpi.c            |   2 +-
>   drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   2 +-
>   drivers/gpu/drm/exynos/exynos_hdmi.c               |   2 +-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |   2 +-
>   drivers/gpu/drm/i915/display/intel_connector.c     |   6 +-
>   drivers/gpu/drm/i915/display/intel_sdvo.c          |   6 +-
>   drivers/gpu/drm/loongson/lsdc_output_7a1000.c      |   2 +-
>   drivers/gpu/drm/loongson/lsdc_output_7a2000.c      |   4 +-
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c         |  12 +-
>   drivers/gpu/drm/nouveau/dispnv50/disp.c            |  25 ++--
>   drivers/gpu/drm/nouveau/nouveau_connector.c        | 129 ++++++++++++++++-----
>   drivers/gpu/drm/nouveau/nouveau_connector.h        |   3 +-
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |   2 +-
>   drivers/gpu/drm/sitronix/st7571.c                  |   2 +-
>   drivers/gpu/drm/sti/sti_dvo.c                      |   2 +-
>   drivers/gpu/drm/sti/sti_hda.c                      |   2 +-
>   drivers/gpu/drm/sti/sti_hdmi.c                     |   2 +-
>   drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  16 ++-
>   drivers/gpu/drm/sun4i/sun4i_lvds.c                 |   2 +-
>   drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   2 +-
>   drivers/gpu/drm/sun4i/sun4i_tv.c                   |  16 ++-
>   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   2 +-
>   drivers/gpu/drm/tegra/dsi.c                        |  17 ++-
>   drivers/gpu/drm/tegra/hdmi.c                       |   2 +-
>   drivers/gpu/drm/tegra/sor.c                        |  13 +--
>   drivers/gpu/drm/tests/drm_atomic_commit_test.c     |   2 +-
>   drivers/gpu/drm/tests/drm_atomic_test.c            |   2 +-
>   drivers/gpu/drm/tests/drm_connector_test.c         |   4 +-
>   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  16 ++-
>   drivers/gpu/drm/tests/drm_probe_helper_test.c      |   2 +-
>   drivers/gpu/drm/tiny/arcpgu.c                      |   2 +-
>   drivers/gpu/drm/tiny/sharp-memory.c                |   2 +-
>   drivers/gpu/drm/virtio/virtgpu_display.c           |   2 +-
>   drivers/gpu/drm/vkms/vkms_connector.c              |   2 +-
>   drivers/gpu/drm/vkms/vkms_writeback.c              |   2 +-
>   drivers/gpu/drm/xen/xen_drm_front_conn.c           |   2 +-
>   include/drm/drm_atomic_state_helper.h              |   3 -
>   include/drm/drm_connector.h                        |  12 --
>   include/drm/drm_mipi_dbi.h                         |   2 +-
>   58 files changed, 351 insertions(+), 236 deletions(-)
> ---
> base-commit: 91f52e99824b0beebb48cad51bbda81437af8664
> change-id: 20260709-drm-no-more-connector-reset-45ee14d7c62c
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


