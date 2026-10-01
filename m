Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDB377AA7
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861526; cv=none; b=gkeeoTSWxwjjejr9OnMNBW+Q4Jg3rTVS/uK3cMy6QEbxnZbM1osMb0tYMRvT3HbMIj3keQVOyn50SxBjLjy2TGZssGfRIOkpd17DMqh4+90IOO1GnRlDVSBbkftKUuSKgaBJgahKGcRnliPAwUqBOWv180cdRI6wMR12vlAqv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861526; c=relaxed/simple;
	bh=VvJRAGgJtTAVdV8lZhiI7PYtJOHw9+Qde5Abnh4cGcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTImEKCAoPAZuSdIUQnGw74pcu3gS3NxP5oIJ1iZldFNIwSXUOA6WN6LDT2zhSPEXWaDfjNXvSrmIqdXDhkma66F+PdffgOTRTUUaqpOIiB/S3k/oVaphg6ejYWOqGV9iCnxJ30NTBtgOdxcSkI1I2ar01o+WczKUnzVHZtxFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kaL7u6iW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=djilZshW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ej3W9TlK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o2uZgkBj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kaL7u6iW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="djilZshW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ej3W9TlK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o2uZgkBj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D20CB21E12;
	Thu,  1 Oct 2026 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vv3pggW5gTjEwGmDFZGHtA9x8pwZYxunJguuvJPpvsA=;
	b=kaL7u6iWf8sotKKPaoe6fU8Sb1XKx21Pf79Iv2dRTK9PvQT/8LttQ9AgKiYb12HQ6TGxUF
	ZSs2kKxyLiKPJ7+A+vLe3wKHR9oXi9xMG7E19qp/kPo5rKooWhU5DA/YvvHMrCz7fLbKIb
	kSgnfn2LGQNCkueLw/zYZ1oX78eEXmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vv3pggW5gTjEwGmDFZGHtA9x8pwZYxunJguuvJPpvsA=;
	b=djilZshWooWkUUp/BBTA46AWBtaJ2hsf5bieBJv6h5VJLtweuF8V4pCoNwLvpRB8yJLBc1
	NqIjjsq/Ekff/ECg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vv3pggW5gTjEwGmDFZGHtA9x8pwZYxunJguuvJPpvsA=;
	b=ej3W9TlKotkEQfzPZLbIRy5zjKrFFCIe3mVTnp2tUPEjVk2y+N1skbS3cHTewyY3rWrwJa
	zXnWqqEzg0a+HroLdgGOqQyXiQsa2jOYVQc5qzF0qVenkOTzIt3jEX4Q7IE8klMWHdsSCM
	EiJqF/nHo6PDHRqEGP2IAmKBI2O/t0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vv3pggW5gTjEwGmDFZGHtA9x8pwZYxunJguuvJPpvsA=;
	b=o2uZgkBjUxaMuvIUaYIWxeX3L6dzp4w9hzvCrhYSBp1MZ71H9J05IrMgXAX/U2ByL9fv/x
	gxFn4tVZuavMGJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6355E13B78;
	Thu,  1 Oct 2026 13:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RzS0EMpgvmoENAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 01 Oct 2026 13:31:54 +0000
Message-ID: <067c22f6-206a-421f-8837-1f8a88f55299@suse.de>
Date: Thu, 1 Oct 2026 15:31:53 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add ARGB8888 support for primary planes
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Dorinda Bassey <dbassey@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Cc: kraxel@redhat.com, airlied@redhat.com, slp@redhat.com, mhrica@redhat.com,
 gurchetansingh@chromium.org, mripard@kernel.org, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
References: <20260930132707.500748-1-dbassey@redhat.com>
 <94f11a7e-7563-4480-8b00-6e3374865669@suse.de>
 <b8064104-99dd-472d-883d-56b362d60371@collabora.com>
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
In-Reply-To: <b8064104-99dd-472d-883d-56b362d60371@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.950];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO

Hi

Am 01.10.26 um 12:46 schrieb Dmitry Osipenko:
> On 9/30/26 18:03, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 30.09.26 um 15:27 schrieb Dorinda Bassey:
>>> Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
>>> virtio-gpu primary planes. Without this, glmark2-drm fails at
>>> startup because it selects ARGB visual configs by default, which
>>> don't match the XRGB-only plane capabilities. This causes
>>> drmModeSetCrtc to fail with EINVAL.
>> But does the host also support ARGB on the primary plane? We usually
>> don't export formats that are not available in (virtual) hardware.
>>
>> Best regards
>> Thomas
>>
>>> The virtio_gpu_translate_format() function already handles
>>> ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
>>> so this just exposes the existing capability to userspace.
>>>
>>> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>>> ---
>>>    drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
>>>    1 file changed, 1 insertion(+)
> For primary plane, alpha channel often doesn't matter as primary has
> fixed z=0 order and a usual alpha blending mode would account only
> overlay's alpha channel. Many real hw drivers expose alpha-channel
> formats for primary plane for compatibility with userspace, even though
> for them the alpha has no meaning for the primary plane.

We decidedly do not offer formats that are not native to the hardware; 
except for adding XRGB888.


>
> QEMU is most popular VMM using virtio-gpu, but there are others. For a
> stricter compatibility we can translate B8G8R8A8 to X8R8G8B8 for the
> primary plane in the driver code, but I assume in practice it's very
> unlike this will be necessary and we can always do it later on if will
> be needed.

No in-kernel format conversion please; again except for adding XRGB8888.

Best regards
Thomas


>
> The change looks okay, will apply after testing.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


