Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA04F55B3
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780644; cv=none; b=l0D0I03huQ/jCJ7CacYsnmQ7pyO5y2rcWMDHEom9Oxmxchwl3aR02GSaW7i1hLVED0Y7QQpYaLCj6LlOHR8np/BBxNuRf3DSkoOX7OY+RMUaXY92dFwg9kzZF995IsQNJ+88AakhKvGhcZuTxpPlTUjSZgs+wUITIghgV0YhsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780644; c=relaxed/simple;
	bh=3aFqyZGK0tmbyOFf3wCRH4HSB4lkZ4z6wSX7rtK37ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXxwFJFl7M5l5sJyxVNuh975Z/JKbKZj96quTF52/SZS2mnafqgOYBWeVImbY5BcFFpsnvgi1V/RDR/YJZX2Q2YEPKCWq+e6zOV1Wsh+KvIv7//4K1nWtEROU8QPbGmvnRqErcDsjEwGaWVw9dAv5CoYuGZDVrWr++Sd67Kd52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hXAyY75A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qOeRiN3H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bMtoRBs9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2kZ8xr85; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hXAyY75A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qOeRiN3H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bMtoRBs9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2kZ8xr85"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 949071F74C;
	Wed, 30 Sep 2026 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790780630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rkx0NYyI2w6p6HwAnGuOmn3OxWooUjXVkmFrvel6pAg=;
	b=hXAyY75AaAwkJ0VZIQFFgrLZ7Y2KzEgxETO+AT08oYZG3WYfEuTHt0iDB74PbdZlKQGQPL
	8FHnhMQ95VvTGlWXLbjdJbkBStkqsDXdK3EUYrRHQbSH8/6t3LKQBLQJT8z7T+qAPhQ11a
	edExXzF4/4WY/1YrcDhB1n8L0ndny28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790780630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rkx0NYyI2w6p6HwAnGuOmn3OxWooUjXVkmFrvel6pAg=;
	b=qOeRiN3HSIHor81FYPYBB0CInxKHKb5hcMhGUjT3ERdTXNCPFBTmyuUJ/TwkSax8vS1UMS
	/hRLbsG6Cou5F3Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790780626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rkx0NYyI2w6p6HwAnGuOmn3OxWooUjXVkmFrvel6pAg=;
	b=bMtoRBs9bUhcjPQPnuPmB8PvzpVMu5frAUg57rj/5vEzCJHoAoIExo5XxxFUs9BbIr+EEp
	o5eeYmY20RFkdbynZbthB38kJ9qR3ix0oPuXpXFybzGGDauaoUxruGTWM92Q0+Y2d0uphs
	rHYVG90gS/00tBKOe2/WGOUGDJyFE+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790780626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rkx0NYyI2w6p6HwAnGuOmn3OxWooUjXVkmFrvel6pAg=;
	b=2kZ8xr85W1X+I5D7jjFR8qfs7M7AezEYEdoaQ+DLu1cw1zWnNK07CQalr9tM9YzWDvaq+y
	ks+bWUYAeZhv4KCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2384313722;
	Wed, 30 Sep 2026 15:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g32wLtEkvWqsIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 30 Sep 2026 15:03:45 +0000
Message-ID: <94f11a7e-7563-4480-8b00-6e3374865669@suse.de>
Date: Wed, 30 Sep 2026 17:03:45 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add ARGB8888 support for primary planes
To: Dorinda Bassey <dbassey@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Cc: kraxel@redhat.com, airlied@redhat.com, dmitry.osipenko@collabora.com,
 slp@redhat.com, mhrica@redhat.com, gurchetansingh@chromium.org,
 mripard@kernel.org, simona@ffwll.ch, linux-kernel@vger.kernel.org
References: <20260930132707.500748-1-dbassey@redhat.com>
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
In-Reply-To: <20260930132707.500748-1-dbassey@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.com:url]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi

Am 30.09.26 um 15:27 schrieb Dorinda Bassey:
> Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
> virtio-gpu primary planes. Without this, glmark2-drm fails at
> startup because it selects ARGB visual configs by default, which
> don't match the XRGB-only plane capabilities. This causes
> drmModeSetCrtc to fail with EINVAL.

But does the host also support ARGB on the primary plane? We usually 
don't export formats that are not available in (virtual) hardware.

Best regards
Thomas

>
> The virtio_gpu_translate_format() function already handles
> ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
> so this just exposes the existing capability to userspace.
>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index b422eba42a5f..5f0bc1b1931b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -37,6 +37,7 @@
>   
>   static const uint32_t virtio_gpu_formats[] = {
>   	DRM_FORMAT_HOST_XRGB8888,
> +	DRM_FORMAT_HOST_ARGB8888,
>   };
>   
>   static const uint32_t virtio_gpu_cursor_formats[] = {

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


