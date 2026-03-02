Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AD40B6DC
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460961; cv=none; b=WFERX4PjLcc8aEHAYVclFgU4N6U9WiGP5L0ZF3T11ejQ8EcKwustOA0d2TwVZxVeiHvEeQYXuzzt7JcDv2ceNP8Aq5tOvUGQIu39YEZIsaehGPNnPgyVitQmo2tXk1z1fgJMHIb4o4nYhb+sqVfFWR3l4sHGMq5dC96ALQX3nRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460961; c=relaxed/simple;
	bh=g/Z+wdHu+PqoPGQj4+huAE6nvG/tw23oixQKZ0Jh9z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unctI+at88C4IchX0QcHtVpj2IRXyCg+unfDsXu6RrUVJlOczbSTKe2x5cTW7NH29PWWfyZz3533pbRQa/lhbY73D1+bidLfirUPmKfAoE3V0vaypcQDy11e/3Kwg/WvoBJOh7T4spTtgSURzIEBnEVzomKXF9h7QUNzcaB6YOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J0IIxqhj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GEbcmjhy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P3HQwOAY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q6juDwGy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J0IIxqhj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GEbcmjhy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P3HQwOAY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q6juDwGy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68CC75BD2D;
	Mon,  2 Mar 2026 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H00ppj7E7EkcKb+pbe6zT+acgeD4F5dNGj0YwelGl60=;
	b=J0IIxqhjWprhTDORvIC6Ji6zS9YBEDX8CE20hSz+hPbeMRqWoIXhcZGOLKy41+p2Dkh/5W
	yfekC6HvM9mlWX+Yjf33wmIaTvPnWr2u5OH5NhH56BUFNUkhl795VmyZqR4v1Ben+B7yfv
	ZnahEj1DP9X9K60AcW4m7LArXVXmr8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H00ppj7E7EkcKb+pbe6zT+acgeD4F5dNGj0YwelGl60=;
	b=GEbcmjhyZjFaUrymyyZJBO+B+Qoi9Hwyo/uK0qXC0rIf8wNRTzXdVB9U7ZmRylRQUJbbu1
	tfrU1ShaoiQdeUCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P3HQwOAY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q6juDwGy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H00ppj7E7EkcKb+pbe6zT+acgeD4F5dNGj0YwelGl60=;
	b=P3HQwOAY8CPpZt+6iAycfLdiq0cjkqqEh60xTV2OuZekZTH30M+2k54mXspC/KmkXKiXKO
	c0ew5f67lMgYDWQT08oeFDLd5M0tVXNc6sBGRBZqVxJiEtvgYOLAiyQClyfeqmF9Hao/JP
	5KOUOMrdnH6uaSMm5DAwg3scmyZ6qGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H00ppj7E7EkcKb+pbe6zT+acgeD4F5dNGj0YwelGl60=;
	b=q6juDwGyMPKUwNgViD9Y3myGTppOJSgZuirr6PiFLrckZ/U9VTOmrQJY4fdmyNFUu+gaiC
	if8SG7y/llQXboDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12DCC3EA69;
	Mon,  2 Mar 2026 14:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sf4tA52bpWmVLAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 14:15:57 +0000
Message-ID: <cf8cb929-2339-46a9-8b76-e76778787b9d@suse.de>
Date: Mon, 2 Mar 2026 15:15:56 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Open-code drm_simple_encoder_init()
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Hardik Phalet <hardik.phalet@pm.me>
Cc: Hardik Phalet <hardik.phalet@gmail.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260227103515.413685-1-hardik.phalet@pm.me>
 <5cdb4e34-7964-4456-9311-eac8b3d37371@suse.de>
 <4fa6bc36-3507-4171-8955-29c90db9254b@collabora.com>
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
In-Reply-To: <4fa6bc36-3507-4171-8955-29c90db9254b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[pm.me:email,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,chromium.org,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 68CC75BD2D
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hi

Am 02.03.26 um 14:57 schrieb Dmitry Osipenko:
> On 3/2/26 16:48, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 27.02.26 um 11:35 schrieb Hardik Phalet:
>>> drm_simple_encoder_init() is a thin wrapper around drm_encoder_init()
>>> that only provides a minimal drm_encoder_funcs instance with
>>> .destroy = drm_encoder_cleanup.
>>>
>>> Inline the helper in virtgpu_display.c and provide a local
>>> drm_encoder_funcs instance instead. This removes the unnecessary
>>> indirection and prepares for the eventual removal of
>>> drm_simple_encoder_init().
>>>
>>> No functional changes intended.
>>>
>>> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
>>> ---
>>>    drivers/gpu/drm/virtio/virtgpu_display.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/
>>> drm/virtio/virtgpu_display.c
>>> index f1dae9569805..8bd6cdc6c16e 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
>>> @@ -232,6 +232,10 @@ static enum drm_mode_status
>>> virtio_gpu_conn_mode_valid(struct drm_connector *con
>>>        return MODE_BAD;
>>>    }
>>>    +static const struct drm_encoder_funcs virtio_gpu_enc_cleanup_funcs = {
>>> +    .destroy = drm_encoder_cleanup
>>> +};
>>> +
>>>    static const struct drm_encoder_helper_funcs
>>> virtio_gpu_enc_helper_funcs = {
>>>        .mode_set   = virtio_gpu_enc_mode_set,
>>>        .enable     = virtio_gpu_enc_enable,
>>> @@ -306,7 +310,8 @@ static int vgdev_output_init(struct
>>> virtio_gpu_device *vgdev, int index)
>>>        if (vgdev->has_edid)
>>>            drm_connector_attach_edid_property(connector);
>>>    -    drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
>>> +    drm_encoder_init(dev, encoder, &virtio_gpu_enc_cleanup_funcs,
>>> +             DRM_MODE_ENCODER_VIRTUAL, NULL);
>> This looks correct, but you should also remove the include statement at [1]
>>
>> [1] https://elixir.bootlin.com/linux/v6.19/source/drivers/gpu/drm/
>> virtio/virtgpu_display.c#L35
> The patch adds more lines than removes. What's wrong with
> drm_simple_encoder_init() and why it needs to be removed eventually?

I added it myself a few years ago in an attempt to save some lines of 
code. That was a mistake. It's a helper without any purpose. Helpers 
should do something.

Best regards
Thomas


>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


