Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005D455622
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940353; cv=none; b=ifUQTDA+p7BABT3rJ5SB1SghDzvidtSZ9ZnJypy7OU0p3tmp1dEsdAz34e6Zm3WamFa8Xrpy0B4dJ4VLlsTyPlpsgv2yOIflmkYjosIyCT+BgD5jc7qWXu3DrY/eIyzZMNDRiTmvQVsxJXHJ5iL0w+BPXYL7keMd1/V7ekzaabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940353; c=relaxed/simple;
	bh=wY+VwZWmcRKKB+ZvpxHjwSJqDlcSjbdqm5YSFfxOYcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QywCyn2c2Cv66pDS/FHyVX//Q6WYLfSxSBFLQau8z1rl9cGgIC3F1ojEOtufW8gPkbK9C+XYsErrN3AydpwDQ+EVkj2Pq+l6C8751O0jceqjauc9POGusLrKbF1yoM7VcocnKw8AmOmMlyC7S+INTOlpf+YP/4+1yNR3JS7gync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UBSuUl5s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7NXnywFD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wIxIS+6b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v9Nirji0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UBSuUl5s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7NXnywFD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wIxIS+6b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v9Nirji0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3D2E21AA0;
	Wed,  9 Sep 2026 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788940346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGkjE73TWu9g+HP+ZuC9uznjGwrqnGNRLA0oskmj2ik=;
	b=UBSuUl5sjG5j7BUcUhPo42UR3JDeB107INaTeAukrB7vbSySbqp+KVWiVByJBAZ61EsE4L
	zC0QynRzcZ1ggdATTiaplN3Zi0g3DhF7K3cJVLBsjd6X3B+VG5SWGrsee6zEBpS5oTRSlM
	2YnK/lWYQK3U7UhD5AoamT+LBVejBig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788940346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGkjE73TWu9g+HP+ZuC9uznjGwrqnGNRLA0oskmj2ik=;
	b=7NXnywFDZhMkXkn4ZtGbR0+FlPqVniaqjL0X+YtKsutEtbjBNtwQ5Q4kVQz9ufPcWdrElF
	y/GlCja6gFRsIXCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788940341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGkjE73TWu9g+HP+ZuC9uznjGwrqnGNRLA0oskmj2ik=;
	b=wIxIS+6bU7AfQz8uPlsc1Cazp0CfGY0lDlWcGi1SL+0uK57Y/OYmGm5+J83JxPzvycFel+
	+iChohZvGXegiUaHVz6TYoScG0kcRrJHNvJHpCCziGIdQEYsm0dGAhJhBNd42QcMN8TRN7
	mNQCG+Z3t56D+/g1o35VBsJ/tzSyR3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788940341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGkjE73TWu9g+HP+ZuC9uznjGwrqnGNRLA0oskmj2ik=;
	b=v9Nirji0OGL3EgTSOSv9a1GVwhPy9Uy6QmYoNccG8ybACzoChirNMhI1TDIxNsBQRm6BrP
	ERSH0unNW8ljw/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D35013354;
	Wed,  9 Sep 2026 07:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id An3vIDUQoWpEEAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 07:52:21 +0000
Message-ID: <c5eef215-6f2e-4807-8b9e-5356b3978f8b@suse.de>
Date: Wed, 9 Sep 2026 09:52:20 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Replace deprecated drm_simple_encoder_init()
To: Davide Bonatto <bonatto.davide@gmail.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260909073440.52641-1-bonatto.davide@gmail.com>
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
In-Reply-To: <20260909073440.52641-1-bonatto.davide@gmail.com>
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
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,collabora.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

Hi

Am 09.09.26 um 09:34 schrieb Davide Bonatto:
> drm_simple_encoder_init() is deprecated as it introduces an unnecessary
> intermediate layer between atomic modesetting and DRM drivers.

This helper has meanwhile been removed entirely.

Best regards
Thomas

>
> Inline the helper call in virtgpu_display by defining
> virtio_gpu_encoder_funcs with the default drm_encoder_cleanup callback,
> and migrate directly to drm_encoder_init()
>
> Signed-off-by: Davide Bonatto <bonatto.davide@gmail.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_display.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index a1a875a0c706..85986578001f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -67,6 +67,10 @@ static const struct drm_framebuffer_funcs virtio_gpu_fb_funcs = {
>   	.dirty = drm_atomic_helper_dirtyfb,
>   };
>   
> +static const struct drm_encoder_funcs virtio_gpu_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static int
>   virtio_gpu_framebuffer_init(struct drm_device *dev,
>   			    struct virtio_gpu_framebuffer *vgfb,
> @@ -306,7 +310,9 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>   	if (vgdev->has_edid)
>   		drm_connector_attach_edid_property(connector);
>   
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
> +	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
> +		DRM_MODE_ENCODER_VIRTUAL, NULL);
> +
>   	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
>   	encoder->possible_crtcs = 1 << index;
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


