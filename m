Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719643F4B6
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514007; cv=none; b=CgkZNtUtQ0kng+BAcqB005OjEvTJylmEYYH4z2MYztzIgzUctrAbCoeURG90m71CwQT8ftBe8LbdoyFNkppybGL27crE5YK/ST3fMe9PsjMUQN1ocSlOTBtqqhQcUPPQfkprV+WIBLqTe/ZWK6tET7HzIjCnvqCjyhyfFfH7E1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514007; c=relaxed/simple;
	bh=9YtJmlDhcnNB1iMkkSr+F8fgM2n7i595KR/kP1BUEMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhPCgu4QqFC93PbWhvFXulBUuBdJazstRHdeQaRVpEoi7TY9/P8LrYdJFOYHrF+0erMe/NPZYE1KsF8mhu/Mz3TFpt0FyVJ+lq6pJtZQCC3M3/CS7iXCYOh8prDQ9SdwqONyV/iGGnS2OhSWP0/M0/pvXQYY812Z2tJzzXN4KPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fpUP1fUv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N/00ZjrS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fpUP1fUv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N/00ZjrS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fpUP1fUv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N/00ZjrS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fpUP1fUv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N/00ZjrS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0573C7606C;
	Wed,  8 Jul 2026 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783514004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LnIMlJN8bZMskGaqaOWtdDs6MgXMXSgLEVEHHFk5mL4=;
	b=fpUP1fUvYH1ULVvelHMDhUALjXoqHlhv8lGuMtRihZllu6rcasy/cdGHP7YruTKS8AFAHJ
	3vjPL68n3Nisxb5X0O80M7uMdxrBUKPWg9OmHvhY9egFVD4I6WZNoo4KHTYs+F2+s/HDaf
	fSnWy9ytQ8HGW1GYCqnr4m5zMMVs+6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783514004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LnIMlJN8bZMskGaqaOWtdDs6MgXMXSgLEVEHHFk5mL4=;
	b=N/00ZjrS2SfVVHxq0kWPa6zRNcLRaKSs5G3k/o/Iz3e5lsAHVr25TeXXDLSqyRmWtM8622
	LpJOx0trP+eTD0Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fpUP1fUv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="N/00ZjrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783514004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LnIMlJN8bZMskGaqaOWtdDs6MgXMXSgLEVEHHFk5mL4=;
	b=fpUP1fUvYH1ULVvelHMDhUALjXoqHlhv8lGuMtRihZllu6rcasy/cdGHP7YruTKS8AFAHJ
	3vjPL68n3Nisxb5X0O80M7uMdxrBUKPWg9OmHvhY9egFVD4I6WZNoo4KHTYs+F2+s/HDaf
	fSnWy9ytQ8HGW1GYCqnr4m5zMMVs+6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783514004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LnIMlJN8bZMskGaqaOWtdDs6MgXMXSgLEVEHHFk5mL4=;
	b=N/00ZjrS2SfVVHxq0kWPa6zRNcLRaKSs5G3k/o/Iz3e5lsAHVr25TeXXDLSqyRmWtM8622
	LpJOx0trP+eTD0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8A05779AE;
	Wed,  8 Jul 2026 12:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fHPnJ5NDTmrODQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 08 Jul 2026 12:33:23 +0000
Message-ID: <18186cbc-a60c-4a1a-95f5-46e392faa997@suse.de>
Date: Wed, 8 Jul 2026 14:33:23 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/qxl: remove dependency on DRM simple helpers
To: Diogo Silva <diogompaissilva@gmail.com>, Dave Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260707-qxl-simple-v2-1-08d21bc74a41@gmail.com>
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
In-Reply-To: <20260707-qxl-simple-v2-1-08d21bc74a41@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0573C7606C
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,linux.intel.com,kernel.org,ffwll.ch];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org



Am 07.07.26 um 18:14 schrieb Diogo Silva:
> Simple KMS helper are deprecated since they only add an intermediate
> layer between drivers and the atomic modesetting.
> This patch removes the drm_simple_encoder_init() helper usage in the
> qxl display driver by open coding it and using the encoder atomic
> helpers directly. This is a step to eventually get rid of this simple
> KMS helper, once all drivers that use it have been converted.
>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> Changes in v2:
> - fix type error
> - Link to v1: https://lore.kernel.org/r/20260707-qxl-simple-v1-1-524f6316b5d5@gmail.com
> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index a026bd35ef485..7f4178800afd7 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -31,12 +31,12 @@
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_plane_helper.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <drm/drm_gem_atomic_helper.h>
>   #include <drm/drm_vblank.h>
>   #include <drm/drm_vblank_helper.h>
> @@ -1095,6 +1095,10 @@ static const struct drm_connector_helper_funcs qxl_connector_helper_funcs = {
>   	.best_encoder = qxl_best_encoder,
>   };
>   
> +static const struct drm_encoder_funcs qxl_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static enum drm_connector_status qxl_conn_detect(
>   			struct drm_connector *connector,
>   			bool force)
> @@ -1169,10 +1173,10 @@ static int qdev_output_init(struct drm_device *dev, int num_output)
>   	drm_connector_init(dev, &qxl_output->base,
>   			   &qxl_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
>   
> -	ret = drm_simple_encoder_init(dev, &qxl_output->enc,
> -				      DRM_MODE_ENCODER_VIRTUAL);
> +	ret = drm_encoder_init(dev, &qxl_output->enc, &qxl_encoder_funcs,
> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>   	if (ret) {
> -		drm_err(dev, "drm_simple_encoder_init() failed, error %d\n",
> +		drm_err(dev, "drm_encoder_init() failed, error %d\n",
>   			ret);
>   		goto err_drm_connector_cleanup;
>   	}
>
> ---
> base-commit: ee2867b79f9bac3a6fc3221139b09598ce79099c
> change-id: 20260707-qxl-simple-c01aa1a5c4eb
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


