Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAF3EE1EE
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861293; cv=none; b=Es8E9oar9aNVqgjVpFzInocXgLN5IztwdfAFaLHOCbVkp2YVXHUkSJTT1y2KdVrBY01jAvm/Q4uyYavM3cs8YET5NObf4l79YVyxR651TljKzy0lsxaFzlDh3k2HxdqOa4eCbhSZSZPcNejMuYC6LAKtuFHyG/TY6ufE9qnNTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861293; c=relaxed/simple;
	bh=uagDcLSu2Xq9LNZqI+wi8MufVseDSVrv8g4PPkyr8nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIIprP5j2jcakGJ1P/A+gpi2+qHVdjvJa836wIwJCOGjGt+Rx07dP41euGd4fatCsEaXtkunQ4xfGK1y/71IFOks7g2F1+3VatjCUQkFYMdXEF2FKrxEXL/oSF83B+g1XpBBzivjyb1p1CZ9g1hdBajQ5NtveDnJu54K9U+ZMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t5N+vBWa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KkVmLzgX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VacwlJFT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HnCSd4vi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t5N+vBWa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KkVmLzgX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VacwlJFT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HnCSd4vi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8D3321E96;
	Thu,  1 Oct 2026 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2H/NZBWjFTv8O0H9rCKJNdFt49hZ1jNPai3IJ6u/Q7E=;
	b=t5N+vBWamfLjXv3sAFlSCNyC+UtL43XN9BoFneF/NVb8WdKRr3HuwQhEpSeSqf4fkMsYtU
	BMJLQyGNag+J7s0LV317X6aGJR2T4YxfdHyfJtgR2hP8fTGPtG3cGwqWUsFpcuYWB97ELv
	0dFhXEZfBpbm/myw1EJaJ46fScOm5fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2H/NZBWjFTv8O0H9rCKJNdFt49hZ1jNPai3IJ6u/Q7E=;
	b=KkVmLzgXeKU1f6Nxz6lwH7gJ2qdT30U5uWasqbWfMVccz42H2eA+FsxHc3sYi3NqLXM4T3
	FcPeKiGniH3S8RCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VacwlJFT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HnCSd4vi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2H/NZBWjFTv8O0H9rCKJNdFt49hZ1jNPai3IJ6u/Q7E=;
	b=VacwlJFTa3l2XzqvmoCXJES4ukT1+mkFUcdAHkEoLbWDgpE9yol7lcEcFY0ktt84D4Fsr3
	zuchHPvohH7FPqvX7Rm84+v1pVQISUmWPUD7lVZP0llrLaSCVrFmN81b/kjYiJBKXvy8dG
	2LQtgjDO6jIz+/paICBITmUiEMVTvXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2H/NZBWjFTv8O0H9rCKJNdFt49hZ1jNPai3IJ6u/Q7E=;
	b=HnCSd4viH4sA79lB35HRwUb+nlcK6twXrs95/vHFSxDqG08l/aPcdWLWTmDOyWFutLibFF
	Q/cyqAv71fvp16DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4757113B7A;
	Thu,  1 Oct 2026 13:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w8ROAeFfvmr2LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 01 Oct 2026 13:28:01 +0000
Message-ID: <35bb93e1-3c26-4025-a714-9cbe66a0e483@suse.de>
Date: Thu, 1 Oct 2026 15:28:00 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add ARGB8888 support for primary planes
To: Dorinda Bassey <dbassey@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 kraxel@redhat.com, airlied@redhat.com, dmitry.osipenko@collabora.com,
 slp@redhat.com, mhrica@redhat.com, gurchetansingh@chromium.org,
 mripard@kernel.org, simona@ffwll.ch, linux-kernel@vger.kernel.org
References: <20260930132707.500748-1-dbassey@redhat.com>
 <94f11a7e-7563-4480-8b00-6e3374865669@suse.de>
 <CACzuRywG=AcFkXp6vw4ExzBz1Z2SA=mr7oJBEKB3_zTnTMsh0w@mail.gmail.com>
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
In-Reply-To: <CACzuRywG=AcFkXp6vw4ExzBz1Z2SA=mr7oJBEKB3_zTnTMsh0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:url];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B8D3321E96
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO



Am 30.09.26 um 18:12 schrieb Dorinda Bassey:
> Hi Thomas,
>
>     But does the host also support ARGB on the primary plane? We usually
>     don't export formats that are not available in (virtual) hardware.
>
>
> If you're asking about the hypervisor side providing the Virtual GPU,
> Yes the host supports ARGB on primary plane. QEMU's virtio-gpu

Ok, thanks.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>


> supports this see qemu's include/hw/virtio/virtio-gpu-pixman.h:26
> libkrun's virtio-gpu includes `B8G8R8A8_UNORM` in its
> ResourceFormat enum and maps it to display backend formats.
> Virglrenderer, which vhost-device-gpu also uses, maps
> `GBM_FORMAT_ARGB8888` to `VIRGL_FORMAT_B8G8R8A8_UNORM`.
> Other VMMs I've tested also support this format.
>
> Also I see the cursor plane in the virtio-gpu driver already exposes
> `DRM_FORMAT_HOST_ARGB8888`, confirming existing ARGB support
> in backends. I tested this with the vhost-user-gpu backend from -
> https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-gpu
> and the libkrun guest, glmark2-drm renders correctly with it.
>
> BR,
> Dorinda.
>
>
> On Wed, Sep 30, 2026 at 5:04 PM Thomas Zimmermann 
> <tzimmermann@suse.de> wrote:
>
>     Hi
>
>     Am 30.09.26 um 15:27 schrieb Dorinda Bassey:
>     > Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
>     > virtio-gpu primary planes. Without this, glmark2-drm fails at
>     > startup because it selects ARGB visual configs by default, which
>     > don't match the XRGB-only plane capabilities. This causes
>     > drmModeSetCrtc to fail with EINVAL.
>
>     But does the host also support ARGB on the primary plane? We usually
>     don't export formats that are not available in (virtual) hardware.
>
>     Best regards
>     Thomas
>
>     >
>     > The virtio_gpu_translate_format() function already handles
>     > ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
>     > so this just exposes the existing capability to userspace.
>     >
>     > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>     > ---
>     >   drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
>     >   1 file changed, 1 insertion(+)
>     >
>     > diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c
>     b/drivers/gpu/drm/virtio/virtgpu_plane.c
>     > index b422eba42a5f..5f0bc1b1931b 100644
>     > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>     > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>     > @@ -37,6 +37,7 @@
>     >
>     >   static const uint32_t virtio_gpu_formats[] = {
>     >       DRM_FORMAT_HOST_XRGB8888,
>     > +     DRM_FORMAT_HOST_ARGB8888,
>     >   };
>     >
>     >   static const uint32_t virtio_gpu_cursor_formats[] = {
>
>     -- 
>     --
>     Thomas Zimmermann
>     Graphics Driver Developer
>     SUSE Software Solutions Germany GmbH
>     Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>     <http://www.suse.com>
>     GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG
>     Nürnberg)
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


