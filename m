Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E73CB2F8
	for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023833; cv=none; b=cLyx9aJEIsJjFnfluQeeiexRbJlxBBDUo2lEM9SenPg71N+U07F8xQan7Pbi9PO2dkNRmZzkWODFRSwn6NI76HAmdv+HM5/7sRLJFRijniFbRIrs93HCw5KAxdoVCFbkUMWQVVV4wejE7Coq2BFQT8QNr6/TBXKmvLBWf+9VvcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023833; c=relaxed/simple;
	bh=RxZySMR2RvrEigGsQNhpoN5yrqofPSoEZKa15sewMJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnmBq92MzV6bXHr455a9VJIyzONG7YZd2/p+NP2/pWA2tKhZRYQiYsCAqKx0AjKpHvT0ZoRH0NhNTCmmFcvuFzSj/Uf2kL4LDCSrOXbpHkjgTz56DtlxCrpmqH+ehCGxKBRGIhSBBBEbeSndmqH04njIPcOMfthCWCtfwmQTAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L8SGqx6K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cgde5xHN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gULVbAzq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=af5KKfRi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L8SGqx6K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cgde5xHN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gULVbAzq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="af5KKfRi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E47B21BB3;
	Thu, 10 Sep 2026 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789023803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V8y88EkP6ps9ehHOSpLcLPBRb/4bJdYWxdlvkIUXm5U=;
	b=L8SGqx6KEAyU0nVQHDYPbod/uXFGF9NqdSVZ2Dg9F9uYZzN4v+D91WsglDCVbkRV3c3vld
	gFzkVDpe6yJCr9H7UvRxADZW/CYIltyfWsQNVdkZvyolzvp0fL/0Pai4m7QBMkLoRuztgG
	eCO+FyyY8706kNdadCTTc8ZbI+4O87o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789023803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V8y88EkP6ps9ehHOSpLcLPBRb/4bJdYWxdlvkIUXm5U=;
	b=cgde5xHNi9RXh+i3NQDL985sugdrr1iIDY7RejpEJyX2gDgybVlH6WD9g1LFcWQBxY6kLL
	nLkuEwO7MxpGiqCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789023798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V8y88EkP6ps9ehHOSpLcLPBRb/4bJdYWxdlvkIUXm5U=;
	b=gULVbAzqaSg4g0zfqn6xxiDbV37p41SWB/dofbZ2CfVrnT1vvlZGc7jP9hD0/x/lKvSwgM
	C1nKPsWVBnDD6WAcgew/7nxWaLXVQIGIUVhhcrfSsEE/w2Qe44OhjeuqZESlUdwsv1I+wd
	gl+ZnNsWVV4KvOTRdv191UtU4w3AOcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789023798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V8y88EkP6ps9ehHOSpLcLPBRb/4bJdYWxdlvkIUXm5U=;
	b=af5KKfRim3o9PJ+u8rD5U2uAsT2GI8OEfXqNkKtoW8H1rlqluv95uWWPDTT4HFi4fH+weP
	WS5z2fQMsoFcA+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBD6713185;
	Thu, 10 Sep 2026 07:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xJaNIzNWomrwSwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 07:03:15 +0000
Message-ID: <a85f3b74-5172-4e2a-ad0e-6bddddbe1e33@suse.de>
Date: Thu, 10 Sep 2026 09:03:14 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/41] drm/plane: Convert all drivers to
 atomic_create_state and remove reset
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
 louis.chauvet@bootlin.com, melissa.srw@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 alison.wang@nxp.com, stefan@agner.ch, John Stultz <jstultz@google.com>,
 sumit.semwal@linaro.org, xinliang.liu@linaro.org, yongqin.liu@linaro.org,
 Frank.Li@nxp.com, Sascha Hauer <s.hauer@pengutronix.de>, festevam@gmail.com,
 imx@lists.linux.dev, kernel@pengutronix.de, victor.liu@nxp.com,
 anitha.chrisanthus@intel.com, paulk@sys-base.io, chenhuacai@kernel.org,
 jeffbai@aosc.io, lvjianmin@loongson.cn, wuqianhai@loongson.cn,
 xry111@xry111.site, zhengxingda@iscas.ac.cn, marex@denx.de,
 airlied@redhat.com, kraxel@redhat.com, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, andy.yan@rock-chips.com, heiko@sntech.de,
 hjc@rock-chips.com, linux-rockchip@lists.infradead.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>, orsonzhai@gmail.com,
 zhang.lyra@gmail.com, alain.volmat@foss.st.com, rgallaispou@gmail.com,
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
 philippe.cornu@foss.st.com, raphael.gallais-pou@foss.st.com,
 yannick.fertre@foss.st.com, jyri.sarha@iki.fi,
 tomi.valkeinen@ideasonboard.com, hansg@kernel.org,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com, michal.simek@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, sunpeng.li@amd.com, linux@armlinux.org.uk,
 Dharma Balasubiramani <dharma.b@microchip.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 nicolas.ferre@microchip.com, alim.akhtar@samsung.com, inki.dae@samsung.com,
 krzk@kernel.org, kyungmin.park@samsung.com,
 linux-samsung-soc@vger.kernel.org, sw0312.kim@samsung.com,
 p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
 chunkuang.hu@kernel.org, matthias.bgg@gmail.com,
 Lyude Paul <lyude@redhat.com>, dakr@kernel.org,
 nouveau@lists.freedesktop.org, geert+renesas@glider.be,
 kieran.bingham+renesas@ideasonboard.com,
 laurent.pinchart+renesas@ideasonboard.com,
 linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 Biju Das <biju.das.jz@bp.renesas.com>, linux-sunxi@lists.linux.dev,
 samuel@sholland.org, wens@kernel.org, Zack Rusin <zack.rusin@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
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
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,bootlin.com,amd.com,nxp.com,agner.ch,google.com,linaro.org,pengutronix.de,lists.linux.dev,intel.com,sys-base.io,kernel.org,aosc.io,loongson.cn,xry111.site,iscas.ac.cn,denx.de,redhat.com,rock-chips.com,sntech.de,lists.infradead.org,linux.alibaba.com,foss.st.com,iki.fi,ideasonboard.com,collabora.com,chromium.org,igalia.com,armlinux.org.uk,microchip.com,tuxon.dev,samsung.com,vger.kernel.org,glider.be,bp.renesas.com,sholland.org,broadcom.com];
	R_RATELIMIT(0.00)[to_ip_from(RLzrpdgd8h57p4t6jqxd7odphf)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[92];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

Hi Maxime,

nice series. I looked through all the patches.  For those patches where 
I did not respond specifically, you can add

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

Am 08.09.26 um 16:46 schrieb Maxime Ripard:
> This is a follow-up to the bridge reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
>
> The plane reset hook is overloaded: it is called both at probe time
> to create the initial software state and during suspend/resume to
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
> This series first adds the necessary infrastructure in the simple-kms
> and GEM atomic helpers, then converts all 51 plane drivers tree-wide
> from the reset hook to atomic_create_state. The conversions were done
> using a combination of Coccinelle semantic patches and manual
> adjustments. Once all drivers are converted, the old helpers and the
> reset hook itself are removed from struct drm_plane_funcs.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Changes in v4:
> - Fix a NULL pointer dereference with vkms
> - Rebase on drm-misc-next-2026-09-03
> - Link to v3: https://lore.kernel.org/r/20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org
>
> Changes in v3:
> - Drop leftover state destruction in sun4i
> - Rebase on current drm-misc-next
> - Link to v2: https://lore.kernel.org/r/20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org
>
> Changes in v2:
> - Rebase on latest drm-misc-next tag
> - Fix sashiko reviews
> - Fix atmel-hlcdc breakage
> - Link to v1: https://lore.kernel.org/r/20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org
>
> ---
> Maxime Ripard (41):
>        drm/simple-kms: Remove unused reset_plane hook
>        drm/vkms: Move frame_info into vkms_plane_state
>        drm/vkms: Convert to atomic_create_state
>        drm/gem-atomic-helper: Remove __drm_gem_reset_shadow_plane()
>        drm/amdgpu: Convert to atomic_create_state
>        drm/fsl-dcu: Convert to atomic_create_state
>        drm/hisilicon/kirin: Convert to atomic_create_state
>        drm/imx/dc: Convert to atomic_create_state
>        drm/kmb: Convert to atomic_create_state
>        drm/logicvc: Convert to atomic_create_state
>        drm/loongson: Convert to atomic_create_state
>        drm/lcdif: Convert to atomic_create_state
>        drm/mxsfb: Convert to atomic_create_state
>        drm/qxl: Convert to atomic_create_state
>        drm/rockchip: Convert to atomic_create_state
>        drm/sprd: Convert to atomic_create_state
>        drm/sti: Convert to atomic_create_state
>        drm/stm: Convert to atomic_create_state
>        drm/tests: kunit: Convert to atomic_create_state
>        drm/tilcdc: Convert to atomic_create_state
>        drm/vboxvideo: Convert to atomic_create_state
>        drm/verisilicon: Convert to atomic_create_state
>        drm/virtio: Convert to atomic_create_state
>        drm/xlnx: Convert to atomic_create_state
>        drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()
>        drm/amdgpu_dm: Convert to atomic_create_state
>        drm/armada: Convert to atomic_create_state
>        drm/atmel-hlcdc: Drop spurious csc_init call from reset
>        drm/atmel-hlcdc: Convert to atomic_create_state
>        drm/exynos: Convert to atomic_create_state
>        drm/imx/ipuv3: Convert to atomic_create_state
>        drm/mediatek: Convert to atomic_create_state
>        drm/nouveau: Convert to atomic_create_state
>        drm/omap: Convert to atomic_create_state
>        drm/rcar-du: Convert to atomic_create_state
>        drm/rz-du: Convert to atomic_create_state
>        drm/shmobile: Convert to atomic_create_state
>        drm/sun4i: layer: Convert to atomic_create_state
>        drm/vmwgfx: Convert to atomic_create_state
>        drm/atomic-state-helper: Remove __drm_atomic_helper_plane_reset()
>        drm/plane: Remove reset
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 28 ++++++++-----
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |  2 +-
>   .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c | 30 +++++---------
>   drivers/gpu/drm/armada/armada_overlay.c            | 39 ++++++++----------
>   drivers/gpu/drm/armada/armada_plane.c              | 15 +++----
>   drivers/gpu/drm/armada/armada_plane.h              |  2 +-
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    | 33 +++++++--------
>   drivers/gpu/drm/drm_atomic_state_helper.c          | 41 ------------------
>   drivers/gpu/drm/drm_gem_atomic_helper.c            | 20 ---------
>   drivers/gpu/drm/drm_mode_config.c                  |  4 +-
>   drivers/gpu/drm/exynos/exynos_drm_plane.c          | 22 ++++------
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |  2 +-
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |  2 +-
>   drivers/gpu/drm/imx/dc/dc-plane.c                  |  2 +-
>   drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            | 19 ++++-----
>   drivers/gpu/drm/kmb/kmb_plane.c                    |  2 +-
>   drivers/gpu/drm/logicvc/logicvc_layer.c            |  2 +-
>   drivers/gpu/drm/loongson/lsdc_plane.c              |  2 +-
>   drivers/gpu/drm/mediatek/mtk_plane.c               | 22 ++++------
>   drivers/gpu/drm/mxsfb/lcdif_kms.c                  |  2 +-
>   drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  2 +-
>   drivers/gpu/drm/nouveau/dispnv50/wndw.c            | 15 ++++---
>   drivers/gpu/drm/omapdrm/omap_plane.c               | 13 +++---
>   drivers/gpu/drm/qxl/qxl_display.c                  |  4 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c    | 15 +++----
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      | 15 +++----
>   drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c       | 15 +++----
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 15 +++----
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  2 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  2 +-
>   drivers/gpu/drm/sprd/sprd_dpu.c                    |  2 +-
>   drivers/gpu/drm/sti/sti_cursor.c                   |  2 +-
>   drivers/gpu/drm/sti/sti_gdp.c                      |  2 +-
>   drivers/gpu/drm/sti/sti_hqvdp.c                    |  2 +-
>   drivers/gpu/drm/stm/ltdc.c                         |  2 +-
>   drivers/gpu/drm/sun4i/sun4i_layer.c                | 21 ++++------
>   drivers/gpu/drm/tests/drm_kunit_helpers.c          |  2 +-
>   drivers/gpu/drm/tilcdc/tilcdc_plane.c              |  2 +-
>   drivers/gpu/drm/vboxvideo/vbox_mode.c              |  2 +-
>   drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |  2 +-
>   drivers/gpu/drm/verisilicon/vs_plane.c             | 14 +++----
>   drivers/gpu/drm/verisilicon/vs_plane.h             |  2 +-
>   drivers/gpu/drm/verisilicon/vs_primary_plane.c     |  2 +-
>   drivers/gpu/drm/virtio/virtgpu_plane.c             |  2 +-
>   drivers/gpu/drm/vkms/vkms_composer.c               | 30 +++++++-------
>   drivers/gpu/drm/vkms/vkms_drv.h                    |  2 +-
>   drivers/gpu/drm/vkms/vkms_formats.c                | 48 +++++++++++-----------
>   drivers/gpu/drm/vkms/vkms_plane.c                  | 36 +++++-----------
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 17 ++++----
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  4 +-
>   drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  2 +-
>   include/drm/drm_atomic_state_helper.h              |  3 --
>   include/drm/drm_gem_atomic_helper.h                |  2 -
>   include/drm/drm_plane.h                            | 12 ------
>   include/drm/drm_simple_kms_helper.h                |  1 -
>   59 files changed, 236 insertions(+), 381 deletions(-)
> ---
> base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
> change-id: 20260629-drm-no-more-plane-reset-04950f42e07f
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


