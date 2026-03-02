Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F33FB05B
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459288; cv=none; b=XSSzl/YMVkv8suW4qvsPvt1zI+ju0/q9P+szeMXH2Bn1IdRecT58TFTjTwtbeAowb+oQXoxh4ErPY555Zlqo5pyFXWs871+ynUSJLonlPzVjxrOv5WrJc4qdtEqKmr3EoTWL37C2Pk2J7cduO9tAMGMfWBo+1hrXdVEeSq6I5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459288; c=relaxed/simple;
	bh=fAb41BoMbvoz54NmplyMRopvAtnfQB+szht7zQ5z3Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2yVe0Qw42PMFLabAhLuu/e64wv7oj6otOYZEd/dth4j9KBIx5eOYiOFulNRgINYMnXC6UeIwFVuEBaRkZK6fn1etcgV4i496hjcWVX7cj3NiXQKKWe8F4UQHaI4vvNexWM/nKi5YgVtSryxhUkyf4ptnmtfFYcn/y7nd5Ubo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RGcDp//K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ak8gp2yw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RGcDp//K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ak8gp2yw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RGcDp//K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ak8gp2yw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RGcDp//K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ak8gp2yw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D82A3F754;
	Mon,  2 Mar 2026 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772459285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/N3wFtUySN2LVJGj8z/oDsOLK5MHkmKhqtsN4t0gl8Y=;
	b=RGcDp//KAi67AJkTHEgfcTwsspcOv0fC4X5IJEtqdz1RgZ1FFM+vz6qnDX6yLISDGr37sH
	DwrzvZpeDW82aOnqjN+93Di/wm7coLC2ppI6FF2pJ/MdRsOE2jGzN0yODcp8TEI57eF03r
	0nKXRzSlhMXOf3M3kS0MX6oau2aLv9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772459285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/N3wFtUySN2LVJGj8z/oDsOLK5MHkmKhqtsN4t0gl8Y=;
	b=Ak8gp2ywp2KqS7togkXVHpnLj68iBSeXgcN6fpOeVTK63gbTy7dx5MX9IqlvEcKW/NoZtc
	ZOBtNcnm+m1yjXDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772459285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/N3wFtUySN2LVJGj8z/oDsOLK5MHkmKhqtsN4t0gl8Y=;
	b=RGcDp//KAi67AJkTHEgfcTwsspcOv0fC4X5IJEtqdz1RgZ1FFM+vz6qnDX6yLISDGr37sH
	DwrzvZpeDW82aOnqjN+93Di/wm7coLC2ppI6FF2pJ/MdRsOE2jGzN0yODcp8TEI57eF03r
	0nKXRzSlhMXOf3M3kS0MX6oau2aLv9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772459285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/N3wFtUySN2LVJGj8z/oDsOLK5MHkmKhqtsN4t0gl8Y=;
	b=Ak8gp2ywp2KqS7togkXVHpnLj68iBSeXgcN6fpOeVTK63gbTy7dx5MX9IqlvEcKW/NoZtc
	ZOBtNcnm+m1yjXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED4733EA69;
	Mon,  2 Mar 2026 13:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z/RwOBSVpWmhDgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 13:48:04 +0000
Message-ID: <5cdb4e34-7964-4456-9311-eac8b3d37371@suse.de>
Date: Mon, 2 Mar 2026 14:48:04 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Open-code drm_simple_encoder_init()
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: Hardik Phalet <hardik.phalet@gmail.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260227103515.413685-1-hardik.phalet@pm.me>
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
In-Reply-To: <20260227103515.413685-1-hardik.phalet@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,collabora.com,chromium.org,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi

Am 27.02.26 um 11:35 schrieb Hardik Phalet:
> drm_simple_encoder_init() is a thin wrapper around drm_encoder_init()
> that only provides a minimal drm_encoder_funcs instance with
> .destroy = drm_encoder_cleanup.
>
> Inline the helper in virtgpu_display.c and provide a local
> drm_encoder_funcs instance instead. This removes the unnecessary
> indirection and prepares for the eventual removal of
> drm_simple_encoder_init().
>
> No functional changes intended.
>
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---
>   drivers/gpu/drm/virtio/virtgpu_display.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index f1dae9569805..8bd6cdc6c16e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -232,6 +232,10 @@ static enum drm_mode_status virtio_gpu_conn_mode_valid(struct drm_connector *con
>   	return MODE_BAD;
>   }
>   
> +static const struct drm_encoder_funcs virtio_gpu_enc_cleanup_funcs = {
> +	.destroy = drm_encoder_cleanup
> +};
> +
>   static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
>   	.mode_set   = virtio_gpu_enc_mode_set,
>   	.enable     = virtio_gpu_enc_enable,
> @@ -306,7 +310,8 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>   	if (vgdev->has_edid)
>   		drm_connector_attach_edid_property(connector);
>   
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
> +	drm_encoder_init(dev, encoder, &virtio_gpu_enc_cleanup_funcs,
> +			 DRM_MODE_ENCODER_VIRTUAL, NULL);

This looks correct, but you should also remove the include statement at [1]

[1] 
https://elixir.bootlin.com/linux/v6.19/source/drivers/gpu/drm/virtio/virtgpu_display.c#L35

Best regards
Thomas

>   	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
>   	encoder->possible_crtcs = 1 << index;
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


