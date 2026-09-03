Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45F33D6E6
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418846; cv=none; b=jvRNcLWw1rK8IgaLE8rtg4EZOHFad9GOTIifNufWejvuq+BfjbaoV67i3+P9gQZglTzmnx4njVwH2R9TYtG7v2bTzgsx+qXYr1hCGB0/UA/y9huyvd8iH0knYZ4ygX9QVAcFkZ83ulu+sCSmzlwGLql1y0DgK6dvpHLiepG2AAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418846; c=relaxed/simple;
	bh=HfSAyLNGvAfTt040f/crFsUGn1kbwdcfpl1RSRwclb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHeaVZQWJWhMn51RUWU7avxTkUhluNohGuu+FAS91N+RCSuQZY/h77bvi3Oii9umJH0yTHEA2jrzvpFzWdDQZ8w8nIwBRT1lmODnvryfoUAfjrrfaee65VaG9Ba4XaUjIlJvb3dMG6oPjzJ95s5urPxHLFZnmrS+Jetihah/XtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ca0ZmIHp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hv15/f+/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yIrtd9u2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gFDhiFRU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ca0ZmIHp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hv15/f+/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yIrtd9u2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gFDhiFRU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F6D41FDB8;
	Thu,  3 Sep 2026 07:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788418837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sAG9cDrf6xBo+FEbVMo3Fg8Oo+JsskIBDIN13dkCH/M=;
	b=ca0ZmIHp/jfxgiC/j0cQM3dO+U/j2f6SzVC8r42KASK1ryPTVaNerbEUx5q04GpeSDDGBS
	FtaI2grx0B9hFYF2FAH9b/+2kDW5rk3LjvB5PR0vvHFAGSiZveS+QDC2lKAjwdUZdQxi/a
	F3fmZtn+yKBcgxHzpbnZ6Gwg1vpBumo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788418837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sAG9cDrf6xBo+FEbVMo3Fg8Oo+JsskIBDIN13dkCH/M=;
	b=Hv15/f+/CcrJiMZr7ujsNyEs7l2J10Gnzo7WAjBLQc9T2GDM0Cj9rRGRfZlG6lMZ7ZPM+N
	4MErsL9DuYzlsGBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788418833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sAG9cDrf6xBo+FEbVMo3Fg8Oo+JsskIBDIN13dkCH/M=;
	b=yIrtd9u2rTlpIKJK6bqWO6CF1l2zjjdnIA/PbX98J9QrASGIC9ibEvd/QBFLpw1eyqMBo0
	TS3ZKhNtxPMOn7njzyPmMO94bBqKFcxaWab0W4A2ZC2Aipfs+o+JANQsrXUs1bOQI63611
	BqfKqLFI7bamXqycRU+tuvp4iMfhSJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788418833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sAG9cDrf6xBo+FEbVMo3Fg8Oo+JsskIBDIN13dkCH/M=;
	b=gFDhiFRUVPzGy2O/Po1f68k+be6dAC/J6rLnJE7bf4flFFqj0J6gPd1WoCGp6F5P3vipDx
	TP3I9V+GiyRwcYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C6E313736;
	Thu,  3 Sep 2026 07:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9wTrHBAbmWqTTgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 03 Sep 2026 07:00:32 +0000
Message-ID: <12087ae2-972a-48fd-932a-89772597f59c@suse.de>
Date: Thu, 3 Sep 2026 09:00:31 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/vboxvideo: create blend mode property on
 planes
To: Qinyun Tan <qinyuntan@linux.alibaba.com>, dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, jfalempe@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
 <20260901083234.1828755-5-qinyuntan@linux.alibaba.com>
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
In-Reply-To: <20260901083234.1828755-5-qinyuntan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.com:url]



Am 01.09.26 um 10:32 schrieb Qinyun Tan:
> Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
> format with alpha exposed"), drm_mode_config_validate() warns when a
> plane exposes an alpha pixel format but not the "pixel blend mode"
> property. Both the vboxvideo primary and cursor planes expose ARGB8888
> and trip this on driver load.
>
> VirtualBox draws the cursor through the host windowing system, which
> treats the guest-supplied pointer shape as straight
> (non-pre-multiplied) alpha: the host frontend loads the pixels
> verbatim into an unpremultiplied ARGB image before handing them to the
> host cursor APIs. This corresponds to DRM_MODE_BLEND_COVERAGE. Expose
> a "pixel blend mode" property advertising only DRM_MODE_BLEND_COVERAGE
> to make these semantics explicit and silence the warning. The primary
> plane's alpha channel is ignored by the host (opaque blit) and it is
> the bottom-most plane anyway; advertise the same value there for
> consistency.
>
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> v2: advertise DRM_MODE_BLEND_COVERAGE instead of PREMULTI after
> checking how the VirtualBox host composites the pointer shape.
>
>   drivers/gpu/drm/vboxvideo/vbox_mode.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> index 8e4e5fc9d3c5a..3c41238a82685 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> @@ -15,6 +15,7 @@
>   
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_fb_helper.h>
>   #include <drm/drm_fourcc.h>
> @@ -540,6 +541,9 @@ static struct drm_plane *vbox_create_plane(struct vbox_private *vbox,
>   
>   	drm_plane_helper_add(plane, helper_funcs);
>   
> +	drm_plane_create_blend_mode_property(plane,
> +					     BIT(DRM_MODE_BLEND_COVERAGE));
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


