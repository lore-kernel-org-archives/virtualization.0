Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563873AAF65
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263125; cv=none; b=Ck8ZWXPqKtSI6OBsUsviSKhkih3tRMb29mTwdm3WQ8W2WiaetefmMiEwy66ksDohUa+kI4HgFRiDvKN2bQ9pqbEfPiBpYqp9zAknzt0AgSz6+19mmsicz11fyctA2H45sq9NCmIb39TSFg5XRjC3FsPbmB9jThMYEbUK3Oxe6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263125; c=relaxed/simple;
	bh=oirUtk63Fs9XGvasJNfR+NssltFgo53oSE8KeWWwmAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltzZWmcTjCKRSjAqcezWoXt4OY/wayYhDj+hVWNnLJoMj9vF23mz4N3vUZ87tRLjNaw/1VA0/L8/IZjLBkEYQ4S0DPy6vGGy7g+MiGYKYFP1XbIStb1TCuzsQfIfjneSfBbYfOAQRn4OdIkCaK0/ZK4reJAgf7ub/AGk+kBaiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rtnNG+wC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZKTNlmU/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+Nf2I7Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LCHCYuaV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rtnNG+wC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZKTNlmU/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+Nf2I7Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LCHCYuaV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53C2D1F82C;
	Tue,  1 Sep 2026 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788263118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vf5zXBDiIhSJ+dj0uQLQB4OkGuQfTjrRzTsPedFwQsk=;
	b=rtnNG+wCMNT2+WAqLncLABml6R4motLkWTbu2fJ5nyLLby2EyXM2bZnTRvgeFDFNy0y2o7
	1aJW0z/2FhTZPy7G2HjFojUGCp7ucTmvIjFrvFSADuSAfH25iMWv17Tj7ehy19Ro6g1Vtz
	dY8MH3jkZa2AcAO8Jt08tU4ZhzA1zh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788263118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vf5zXBDiIhSJ+dj0uQLQB4OkGuQfTjrRzTsPedFwQsk=;
	b=ZKTNlmU/YSnRapFrc43H2hbavt2TdDKxTBSZNTzLAmcPBYLe7LgsiOKTyFjjnirSoKSjm9
	uHwQsq9uLbA6RoBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788263114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vf5zXBDiIhSJ+dj0uQLQB4OkGuQfTjrRzTsPedFwQsk=;
	b=o+Nf2I7ZvJQscy+yPR+Hz0m3qzrbX8gApL9h4k2tGdCKPjsfs6dAiTpfuydowKkg08eyfh
	ae2PtDf/EMg+cXoYMDBaec+5stcf6csippPOfSFfQw27oynXuFx2PZ/IGgm4NZTNR2Gmhw
	9Ln2FVkU2sBT7oeQUpPAzGps6ZItMoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788263114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vf5zXBDiIhSJ+dj0uQLQB4OkGuQfTjrRzTsPedFwQsk=;
	b=LCHCYuaV9kwug+0JzOBYl77esuHP45Rr+nTEMhE88OagnjwmfFo32s96LIEauJHDHKlTbB
	6LJJq63QQvapk+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C722A1369E;
	Tue,  1 Sep 2026 11:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sz/ZLsm6lmpOTAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 01 Sep 2026 11:45:13 +0000
Message-ID: <fe7b4018-25fa-4424-9af6-f5922e6b6d0c@suse.de>
Date: Tue, 1 Sep 2026 13:45:13 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/qxl: create blend mode property on primary and
 cursor planes
To: Qinyun Tan <qinyuntan@linux.alibaba.com>, dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, jfalempe@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
 <20260901083234.1828755-3-qinyuntan@linux.alibaba.com>
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
In-Reply-To: <20260901083234.1828755-3-qinyuntan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.com:url]



Am 01.09.26 um 10:32 schrieb Qinyun Tan:
> Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
> format with alpha exposed"), drm_mode_config_validate() warns when a
> plane exposes an alpha pixel format but not the "pixel blend mode"
> property. Both the qxl primary and cursor planes expose ARGB8888 and
> trip this on driver load.
>
> qxl submits cursors as SPICE_CURSOR_TYPE_ALPHA, which the SPICE
> protocol explicitly defines as a "pre-multiplied ARGB8888 pixmap"
> (Spice Protocol, "Cursor channel definition" section [1]). This
> matches the blend mode userspace has always assumed when the property
> is not attached. Expose a "pixel blend mode" property advertising only
> DRM_MODE_BLEND_PREMULTI to make these semantics explicit and silence
> the warning. The primary plane is the bottom-most plane so its blend
> mode has no visible effect; advertise the same value there for
> consistency. No functional change.
>
> [1] https://www.spice-space.org/spice-protocol.html
>
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> v2: no code change; cite the SPICE protocol definition of the ALPHA
> cursor type in the commit message.
>
>   drivers/gpu/drm/qxl/qxl_display.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 7f4178800afd7..0cd1456cca347 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -30,6 +30,7 @@
>   #include <drm/drm_drv.h>
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_encoder.h>
>   #include <drm/drm_framebuffer.h>
> @@ -993,6 +994,9 @@ static struct drm_plane *qxl_create_plane(struct qxl_device *qdev,
>   
>   	drm_plane_helper_add(plane, helper_funcs);
>   
> +	drm_plane_create_blend_mode_property(plane,
> +					     BIT(DRM_MODE_BLEND_PREMULTI));
> +
>   	return plane;
>   
>   free_plane:

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


