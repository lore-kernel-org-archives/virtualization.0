Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CA2C11D9
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418917; cv=none; b=iAMNzqnwrkVUG/F8lJ4sCGIXZn0c4Lj9tsinR9hq0u1BYB0R2mQSRXUDsBwyO1aWmNYO0tT84tjzdn81sA6cyMCKBzM+mii8ur8dOmrbwAz+S07yVxsem2gopo2HFbOS9YMUx/ph0KBB87xk8LdT2S7RPrHgM7/KAUI9qrbZe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418917; c=relaxed/simple;
	bh=ZUnSyz4D2YP0plxJGw2C61fVCcFcjzCNf15GuUwdwVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3ZiF6tNsT7xNoyVPri4TX6fuIqzdAbaEMcE4AhTy9yCCOvBH+suM/5f2tpRbP8qWrudsboD/XXXP5Pwt/QNRhV77lyhpCxyWxswyDJ4XSY2Fjyn+w3pY9ydosF7/TuBdN9V502+2dMItd9iMaPm2It7eYcffOYx+WglQR2YZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v5TbxUpg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BxmShbkM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rJ/5UTBO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Avg2jawv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v5TbxUpg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BxmShbkM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rJ/5UTBO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Avg2jawv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F4511FDB8;
	Thu,  3 Sep 2026 07:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788418910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JUTR5sxijmg7vOW5wOYx7mtR28BCkFKSDEihsVuIaDk=;
	b=v5TbxUpgcopnkOLrG31wVjjzmXeH6P4tEr47Vk6E6RtHpwvnFEAyrKy2VzIFHZc8lc56BW
	VafOHixj2WUzycBueRh6eRxbW1/4jBTeK5zwkFiJtXjMaTUZ49pSm9kv1x2SPPAuwxgazH
	g/atfTf/Jn9qTqxFKddyx1oG+TPyKmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788418910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JUTR5sxijmg7vOW5wOYx7mtR28BCkFKSDEihsVuIaDk=;
	b=BxmShbkMMloRRcsn9OMFdOxon1Dt/eRQl5vgNSNjHcmS8WZBwuVhV1Uvcp42MzmR7l4vDn
	2cl0jnNsYWoURUAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788418906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JUTR5sxijmg7vOW5wOYx7mtR28BCkFKSDEihsVuIaDk=;
	b=rJ/5UTBOJkPsMUipl4bsZFV7OluBhn7oXSZxWIv9uIDpeY3bPpudUiymgimP4O+5ptJfvr
	O8eZipM1zfG19sKBQuvGnbzIZlOZOnPh+ssB/5kW4kX3Dto0Pl5GHYOwEtv/qX1yfX8S0w
	S2ZKglnz3qS6c4+2oObeYuc7obuzXUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788418906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JUTR5sxijmg7vOW5wOYx7mtR28BCkFKSDEihsVuIaDk=;
	b=Avg2jawv2b3rqcmGYk+AhZQEIt9xbyyyFK5+Xw2od2Z3XkDyzJ1aXgPucS8CqMsVhhrcNs
	E5vN4gdHuggn2NAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A625A136E6;
	Thu,  3 Sep 2026 07:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ug9XJ1kbmWpUUAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 03 Sep 2026 07:01:45 +0000
Message-ID: <541338db-6a73-4545-8f13-173198bc0a88@suse.de>
Date: Thu, 3 Sep 2026 09:01:45 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/ast: create blend mode property on cursor
 plane
To: Qinyun Tan <qinyuntan@linux.alibaba.com>, dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, jfalempe@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
 <20260901083234.1828755-2-qinyuntan@linux.alibaba.com>
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
In-Reply-To: <20260901083234.1828755-2-qinyuntan@linux.alibaba.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.com:url]



Am 01.09.26 um 10:32 schrieb Qinyun Tan:
> Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
> format with alpha exposed"), drm_mode_config_validate() warns when a
> plane exposes an alpha pixel format but not the "pixel blend mode"
> property. The ast cursor plane (ARGB4444, ARGB8888) trips this on
> driver load:
>
>    [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
>    WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x48f/0x510 [drm]
>    ...
>    Call Trace:
>     drm_dev_register+0x1ce/0x290 [drm]
>     ast_pci_probe+0x19d/0x3f0 [ast]
>     local_pci_probe+0x41/0x90
>
> Per Thomas Zimmermann's review, the ASPEED documentation describes the
> hardware cursor as blending with straight (non-pre-multiplied) alpha,
> which corresponds to DRM_MODE_BLEND_COVERAGE. Expose a "pixel blend
> mode" property advertising only DRM_MODE_BLEND_COVERAGE to make the
> hardware semantics explicit and silence the warning.
>
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> v2: advertise DRM_MODE_BLEND_COVERAGE instead of PREMULTI, per Thomas
> Zimmermann's review and the ASPEED documentation.
>
>   drivers/gpu/drm/ast/ast_cursor.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
> index fd19c45f2abe2..690d4cd1db5ee 100644
> --- a/drivers/gpu/drm/ast/ast_cursor.c
> +++ b/drivers/gpu/drm/ast/ast_cursor.c
> @@ -25,6 +25,7 @@
>   #include <linux/sizes.h>
>   
>   #include <drm/drm_atomic.h>
> +#include <drm/drm_blend.h>
>   #include <drm/drm_damage_helper.h>
>   #include <drm/drm_format_helper.h>
>   #include <drm/drm_gem_atomic_helper.h>
> @@ -355,6 +356,8 @@ int ast_cursor_plane_init(struct ast_device *ast)
>   	}
>   	drm_plane_helper_add(cursor_plane, &ast_cursor_plane_helper_funcs);
>   	drm_plane_enable_fb_damage_clips(cursor_plane);
> +	drm_plane_create_blend_mode_property(cursor_plane,
> +					     BIT(DRM_MODE_BLEND_COVERAGE));
>   
>   	return 0;
>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


