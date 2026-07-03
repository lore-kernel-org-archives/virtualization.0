Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD59353A71
	for <virtualization@lists.linux.dev>; Fri,  3 Jul 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063588; cv=none; b=Bmm6O8KWNNkc9maJYkGqNEpwkhxfd/I4N0cqq5BST/lmuaokeFAaSP/x7zsOKATxzvkN3QbyC3tc5Qe3vI4jBpewdA6ld8EHDCOBkAT/tT2Bh3H4KRfgbp9XXJZZiXiPCt2raYUsWxErP4094Ilnm4q0rSzCL5Rbp7RfdaV1CVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063588; c=relaxed/simple;
	bh=37AqsWWIOFl+M7xRMXp9PmLubBEGFkqbw4xNr7p7gIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvaHfzTkSdkLDNk74RuQ+4OShvqpCm/UaUGojbgbkh7X4IDhUQlGPHTO5py4WI1L5SI1hrnY4bx94svaEtQGyX437noAVIUwE+7AjKBkJJ6+cn1xx3T7puw0/njTyBdcEh/jrdqYjBm0gwlHuodz6P3ldBshZPKo3IS5100SyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MYNsAChM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4iSYiX3O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MYNsAChM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4iSYiX3O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MYNsAChM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4iSYiX3O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MYNsAChM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4iSYiX3O"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 823B7747A1;
	Fri,  3 Jul 2026 07:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783063584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MmLI7YRYrWrGvjWrJYSSmDPsMivgSqlLvyhn40gpqes=;
	b=MYNsAChMFJfNozLrnG5K6oip935Xl69QjFjGBCX7VT7FmYkCNS7PlSQ6AbWutwCZMrAqbd
	u5y3skH9GCsOc3oe7MEoSX3dyaJQxc6n/qK7cgTlIHNC4Y3j2KA64O0BsXJxcLW6bPc90y
	hfW7M6RW66w082kF9OdeH9AFicmIIeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783063584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MmLI7YRYrWrGvjWrJYSSmDPsMivgSqlLvyhn40gpqes=;
	b=4iSYiX3Op+p4+ZHWG44/8StvvFtOV5Q39skjur0BuFefvUBd7FJkPzeTSv4bNM386NhUVt
	rFuyiF93hULSK/Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MYNsAChM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4iSYiX3O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783063584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MmLI7YRYrWrGvjWrJYSSmDPsMivgSqlLvyhn40gpqes=;
	b=MYNsAChMFJfNozLrnG5K6oip935Xl69QjFjGBCX7VT7FmYkCNS7PlSQ6AbWutwCZMrAqbd
	u5y3skH9GCsOc3oe7MEoSX3dyaJQxc6n/qK7cgTlIHNC4Y3j2KA64O0BsXJxcLW6bPc90y
	hfW7M6RW66w082kF9OdeH9AFicmIIeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783063584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MmLI7YRYrWrGvjWrJYSSmDPsMivgSqlLvyhn40gpqes=;
	b=4iSYiX3Op+p4+ZHWG44/8StvvFtOV5Q39skjur0BuFefvUBd7FJkPzeTSv4bNM386NhUVt
	rFuyiF93hULSK/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BF98779AA;
	Fri,  3 Jul 2026 07:26:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HIz6BCBkR2pmeAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 03 Jul 2026 07:26:24 +0000
Message-ID: <3b192119-9709-4f21-841f-a4706cc85e4a@suse.de>
Date: Fri, 3 Jul 2026 09:26:23 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: Roman Ilin <me@romanilin.is>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Peter Arnesen <peter.m.arnesen@gmail.com>
References: <20260613224434.96501-1-me@romanilin.is>
 <20260702181027.98526-1-me@romanilin.is>
 <E697A2AE-5413-48AE-BFD6-3383819B388B@romanilin.is>
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
In-Reply-To: <E697A2AE-5413-48AE-BFD6-3383819B388B@romanilin.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 823B7747A1
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[romanilin.is,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[bootlin.com,redhat.com,collabora.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,linux.intel.com,leemhuis.info,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[romanilin.is:email,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:url,bootlin.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi

Am 02.07.26 um 20:23 schrieb Roman Ilin:
> Apologies, I accidentally fired off send-email before saving my final
> changelog notes. Please ignore the changelog and notes in the original
> v3 email.
>
> The actual changes in v3 are:
>
> - Changed the WARN_ON_ONCE to drm_dbg_kms (to avoid user-triggerable
>    panics).

We want to know when this happens. And user space will only be able to 
trigger this once, so there's no risk of spamming the kernel log.

So this is not really a problem. drm_WARN_ON_ONCE was ok for that. You 
can also use a regular DRM print macro. But instead of drm_dbg_kms() 
should use drm_err_once(). But please also output linedur_ns and 
framedur_ns in the error. We want to know which of them is incorrect. 
You can also add more information to the error message. See [1] for the 
mode-formating macros.

[1] 
https://elixir.bootlin.com/linux/v7.1.2/source/include/drm/drm_modes.h#L422


> - Updated drm_calc_timestamping_constants with the goto error fallback
>    to clear the stale state.
>
> Also, an automated review bot pointed out an AB-BA deadlock in
> drm_crtc_vblank_start_timer(). But I am leaving this out of the patch to
> keep the fixes orthogonal.
>
> Sorry for the noise.
>
>> On Jul 2, 2026, at 21:10, Roman Ilin <me@romanilin.is> wrote:
>>
>> When a CRTC's display mode carries a too small pixel clock,
>> drm_calc_timestamping_constants() computes a frame duration that
>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>> interval, after which vblank events are no longer delivered. Pending
>> page flips never complete and the display appears frozen.
>>
>> This could be triggered on virtio-gpu guests that have dynamic resolution
>> enabled: when the SPICE agent or the X server resizes the output, it
>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>>
>>     clock = 406 kHz, htotal = 3152, vtotal = 2148
>>
>>     framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
>>
>> 16675852216 does not fit into an int and wraps to roughly -504000000.
>> ns_to_ktime() then yields a negative interval and the timer stops working.
>>
>> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
>> Use vblank timer"). That commit merely made virtio-gpu use the vblank
>> timer and thereby exposed the pre-existing problem in the timer setup
>> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>>
>> To fix this, modify drm_calc_timestamping_constants() to use u64 for
>> calculations, check for INT_MAX overflows, and return an error code.
>> drm_crtc_vblank_start_timer() will then propagate the error, enabling
>> the driver to fall back to immediate vblank events. Valid modes are
>> unaffected, and the timer self-heals on the next mode with a sane clock.
>>
>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Roman Ilin <me@romanilin.is>
>> ---
>> Changes in v3:
>>
>> - Changed the WARN_ON_ONCE to drm_err_once
>>
>> Notes:
>>
>>
>>
>> drivers/gpu/drm/drm_vblank.c | 71 +++++++++++++++++++++++-------------
>> include/drm/drm_vblank.h     |  4 +-
>> 2 files changed, 48 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index f90fb2d13..629b9fcc7 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -631,42 +631,51 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>>   * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
>>   * CRTC's true scanout timing, so they take things like panel scaling or
>>   * other adjustments into account.
>> + *
>> + * Returns:
>> + * 0 on success, or a negative errno code otherwise.
>>   */
>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>> -     const struct drm_display_mode *mode)
>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>> +    const struct drm_display_mode *mode)
>> {
>> struct drm_device *dev = crtc->dev;
>> unsigned int pipe = drm_crtc_index(crtc);
>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>> - int linedur_ns = 0, framedur_ns = 0;
>> + u64 linedur_ns, framedur_ns;
>> int dotclock = mode->crtc_clock;
>> + unsigned int frame_size;
>>
>> if (!drm_dev_has_vblank(dev))
>> - return;
>> + return 0;
>>
>> if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>> - return;
>> + return -EINVAL;
>>
>> - /* Valid dotclock? */
>> - if (dotclock > 0) {
>> - int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>> + if (dotclock <= 0) {
>> + drm_err(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",

Please turn this into drm_err_once() because this call can actually be 
triggered repeatedly from userspace.

Best regards
Thomas


>> + crtc->base.id, dotclock);
>> + goto error;
>> + }
>>
>> - /*
>> - * Convert scanline length in pixels and video
>> - * dot clock to line duration and frame duration
>> - * in nanoseconds:
>> - */
>> - linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
>> - framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
>> + frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode->crtc_vtotal;
>>
>> - /*
>> - * Fields of interlaced scanout modes are only half a frame duration.
>> - */
>> - if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>> - framedur_ns /= 2;
>> - } else {
>> - drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
>> - crtc->base.id);
>> + /*
>> + * Convert scanline length in pixels and video dot clock to line duration
>> + * and frame duration in nanoseconds.
>> + */
>> + linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
>> + framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
>> +
>> + /*
>> + * Fields of interlaced scanout modes are only half a frame duration.
>> + */
>> + if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>> + framedur_ns /= 2;
>> +
>> + if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
>> + drm_dbg_kms(dev, "crtc %u: Can't calculate constants, mode clock too small!\n",
>> +    crtc->base.id);
>> + goto error;
>> }
>>
>> vblank->linedur_ns  = linedur_ns;
>> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>      crtc->base.id, mode->crtc_htotal,
>>      mode->crtc_vtotal, mode->crtc_vdisplay);
>> drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
>> -     crtc->base.id, dotclock, framedur_ns, linedur_ns);
>> +     crtc->base.id, dotclock,
>> +     vblank->framedur_ns, vblank->linedur_ns);
>> +
>> + return 0;
>> +
>> +error:
>> + vblank->linedur_ns  = 0;
>> + vblank->framedur_ns = 0;
>> + drm_mode_copy(&vblank->hwmode, mode);
>> + return -EINVAL;
>> }
>> EXPORT_SYMBOL(drm_calc_timestamping_constants);
>>
>> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>> struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
>> unsigned long flags;
>> + int ret;
>>
>> if (!vtimer->crtc) {
>> /*
>> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>> hrtimer_try_to_cancel(&vtimer->timer);
>> }
>>
>> - drm_calc_timestamping_constants(crtc, &crtc->mode);
>> + ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
>> + if (ret)
>> + return ret;
>>
>> spin_lock_irqsave(&vtimer->interval_lock, flags);
>> vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>> index 2fcef9c0f..d99772dfa 100644
>> --- a/include/drm/drm_vblank.h
>> +++ b/include/drm/drm_vblank.h
>> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>> u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>> void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>>
>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>> -     const struct drm_display_mode *mode);
>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>> +    const struct drm_display_mode *mode);
>> wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>> void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>>    u32 max_vblank_count);
>> -- 
>> 2.54.0
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


