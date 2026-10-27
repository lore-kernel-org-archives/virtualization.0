Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.244.194.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087440;
	b=DYT6AeKkwYfWxSsLu9mdE9xiMMgXxhh4RNX9K7gA3k2wNUj77GTUfnan3pjDADwZIuG3
	 4iR+u6B8W+fHpcXNG0GkAW7s+Sxlv7AGyJYZqJ5lYk8b1GEcBXg10TJpaqzPtQg1Laiqi
	 UlTkdCWpHOsdXjF3sDjnbP7J3GVz+wQQSpF96U873c13YsdWRS3OTYEVo3PwTNzdPZ/29
	 2xZ0zt40Jhb2JCBEu/dNymTW89q1PTJW+XXrxENBq5KO5GtxS+MebfWkW53sT5HTZKZGW
	 TWMaREiVf4PzSMjmnaLrrKE10/Um0dIiyW9ZXlineM7AIMyFFc6kwKkfDjGvQPbBlEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087440;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=uBFlnf4zZWU6cOTbN86hfRAP6AeoL9i7Ja6BGfaY0Ro=;
	b=ccXkHcD6xzkptU+f+KYibNgVsQyYEK7Bg7wjpkSbXGOHc7ncyMAy+SQaXQpJ0D3p2Rex
	 mZAkEBy+XryaJ+FPUj9qExi38+zRLsTBR7Ky/TUIQfjDG3qEe3aQOjpjokMNcVSK7cKhT
	 mDu2MZd/L+D1VmtTaQ3FzILi81AHYu+1OmmpzrPDOQCbJsV0E7SIOg/eOf0C+L9Uesya1
	 MA//8VLYjToMzaCZlo9nYu/kEyVMlWQe/EWaRFW//f5JBqHih0IRF9lbkj7OhXdnFGLV9
	 27KsDeKJcr+sIFz18X/V15jS5qQIgvGuzOuiZ8jMeLNlJ8+NNVzq18YZAHt7/evSF+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=HkZ4V1IB;
	arc=none smtp.remote-ip=185.244.194.184
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BC606A31B;
	Tue, 27 Oct 2026 07:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 633BC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=HkZ4V1IB
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4jDN2M2bgnz9Vp6;
	Tue, 27 Oct 2026 08:50:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793087419;
	bh=csswwopQr0L6Iq80y+T2GffvxU9tazEIvHHPF/uJQv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HkZ4V1IBXdbR8zIBbXo0biyKDXITZj3lEUomkG8fLcUGk6y8uJFdNlqNeWnHr2wfh
	 jwjIEjA/8pY66iUUCzX4TCsKM7EQXVwqvFqIir4wcOUq6yvwazRrLoC4TpA6XRMWAe
	 Hdbb07jovHsIT/ojDa0yxSzVpO/47Emx+8tG3dNS/QloU8wZCGfn+PkcEy7Gn4cnGz
	 Ml8Y4bcuZYI3g8cI8iSEj2/t/9DkfraTyrYBkpmV/2b+Vt/B75/XGtEhZFUN5fBYrX
	 Z3GbqqbEKWhU5Rpg8RzRcay56rXb3GkhUXUZMXdy/EKAV83ubGQ8gdwoPAD+iI0lSA
	 hsD/3Ey4Y6chQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4jDN151s5pz7wqj;
	Tue, 27 Oct 2026 08:49:13 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jDN150GL9z8svC;
	Tue, 27 Oct 2026 08:49:13 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 168085F98B;
	Tue, 27 Oct 2026 08:49:08 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <7f21f160-f637-4b63-aa15-066d7b18e2ed@leemhuis.info>
Date: Tue, 27 Oct 2026 08:49:07 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: Thomas Zimmermann <tzimmermann@suse.de>, Roman Ilin <me@romanilin.is>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>, Louis Chauvet
 <louis.chauvet@bootlin.com>, Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Peter Arnesen <peter.m.arnesen@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260613224434.96501-1-me@romanilin.is>
 <20260702181027.98526-1-me@romanilin.is>
 <E697A2AE-5413-48AE-BFD6-3383819B388B@romanilin.is>
 <3b192119-9709-4f21-841f-a4706cc85e4a@suse.de>
 <0600a3f0-b2d2-4a07-ab21-f590c2979612@leemhuis.info>
 <f0e4cc76-5cf3-4fdb-b42c-f405a09c0d2a@suse.de>
 <ec0c2486-b127-4a47-a81c-499130f268d9@leemhuis.info>
 <d106ad8a-78d4-45be-95da-0222c44107c5@suse.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <d106ad8a-78d4-45be-95da-0222c44107c5@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179308734871.898318.4642876887831960881@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 168085F98B
X-NC-CID: 03+Wsu/eo55EKoo4FpYSMVEN9eFUU4u2SjKgZFAKQ8+/Avnxn6c=

On 9/14/26 13:00, Thomas Zimmermann wrote:
> Am 11.09.26 um 09:39 schrieb Thorsten Leemhuis:
>> On 9/4/26 08:19, Thomas Zimmermann wrote:
>>> Am 03.09.26 um 16:07 schrieb Thorsten Leemhuis:
>>>> On 7/3/26 09:26, Thomas Zimmermann wrote:
>>>>> Am 02.07.26 um 20:23 schrieb Roman Ilin:
>>>>>> Apologies, I accidentally fired off send-email before saving my final
>>>>>> changelog notes. Please ignore the changelog and notes in the
>>>>>> original
>>>>>> v3 email.
>>>>> We want to know when this happens. And user space will only be able to
>>>>> trigger this once, so there's no risk of spamming the kernel log.
>>>>>> Hmmm, just wondering: what's the status here?
>>>> Roman Ilin, did you loose interest? Or was this continued somewhere or
>>>> maybe even resolved and I just missed that?
>>>>
>>>> Thomas: if Roman left this behind, could you maybe handle this, [...]
>>> AFAICT it was almost there except for the error messaging. The v4 then
>>> never happened. I can finish the patch if Roman is no longer around.
>> No answer from Roman since then, so yes, that would be great! Tia!
> 
> I've now sent out an update with minor changes.

Many thx again. But the thing is: it still sits on the list waiting for
review afaics:

https://lore.kernel.org/all/20260914110004.211027-1-tzimmermann@suse.de/

Can you maybe prod the right people to finally get this resolved? Or
what should be do instead?

Ciao, Thorsten

>>>>> So this is not really a problem. drm_WARN_ON_ONCE was ok for that. You
>>>>> can also use a regular DRM print macro. But instead of drm_dbg_kms()
>>>>> should use drm_err_once(). But please also output linedur_ns and
>>>>> framedur_ns in the error. We want to know which of them is incorrect.
>>>>> You can also add more information to the error message. See [1] for
>>>>> the
>>>>> mode-formating macros.
>>>>>
>>>>> [1] https://elixir.bootlin.com/linux/v7.1.2/source/include/drm/
>>>>> drm_modes.h#L422
>>>>>
>>>>>
>>>>>> - Updated drm_calc_timestamping_constants with the goto error
>>>>>> fallback
>>>>>>      to clear the stale state.
>>>>>>
>>>>>> Also, an automated review bot pointed out an AB-BA deadlock in
>>>>>> drm_crtc_vblank_start_timer(). But I am leaving this out of the
>>>>>> patch to
>>>>>> keep the fixes orthogonal.
>>>>>>
>>>>>> Sorry for the noise.
>>>>>>
>>>>>>> On Jul 2, 2026, at 21:10, Roman Ilin <me@romanilin.is> wrote:
>>>>>>>
>>>>>>> When a CRTC's display mode carries a too small pixel clock,
>>>>>>> drm_calc_timestamping_constants() computes a frame duration that
>>>>>>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>>>>>>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>>>>>>> interval, after which vblank events are no longer delivered. Pending
>>>>>>> page flips never complete and the display appears frozen.
>>>>>>>
>>>>>>> This could be triggered on virtio-gpu guests that have dynamic
>>>>>>> resolution
>>>>>>> enabled: when the SPICE agent or the X server resizes the output, it
>>>>>>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>>>>>>>
>>>>>>>       clock = 406 kHz, htotal = 3152, vtotal = 2148
>>>>>>>
>>>>>>>       framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns
>>>>>>> (~16.7 s)
>>>>>>>
>>>>>>> 16675852216 does not fit into an int and wraps to roughly
>>>>>>> -504000000.
>>>>>>> ns_to_ktime() then yields a negative interval and the timer stops
>>>>>>> working.
>>>>>>>
>>>>>>> Found by bisection, which pointed at commit a036f5fceedb ("drm/
>>>>>>> virtgpu:
>>>>>>> Use vblank timer"). That commit merely made virtio-gpu use the
>>>>>>> vblank
>>>>>>> timer and thereby exposed the pre-existing problem in the timer
>>>>>>> setup
>>>>>>> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>>>>>>>
>>>>>>> To fix this, modify drm_calc_timestamping_constants() to use u64 for
>>>>>>> calculations, check for INT_MAX overflows, and return an error code.
>>>>>>> drm_crtc_vblank_start_timer() will then propagate the error,
>>>>>>> enabling
>>>>>>> the driver to fall back to immediate vblank events. Valid modes are
>>>>>>> unaffected, and the timer self-heals on the next mode with a sane
>>>>>>> clock.
>>>>>>>
>>>>>>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>>>>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>>> Signed-off-by: Roman Ilin <me@romanilin.is>
>>>>>>> ---
>>>>>>> Changes in v3:
>>>>>>>
>>>>>>> - Changed the WARN_ON_ONCE to drm_err_once
>>>>>>>
>>>>>>> Notes:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> drivers/gpu/drm/drm_vblank.c | 71 ++++++++++++++++++++++
>>>>>>> +-------------
>>>>>>> include/drm/drm_vblank.h     |  4 +-
>>>>>>> 2 files changed, 48 insertions(+), 27 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/
>>>>>>> drm_vblank.c
>>>>>>> index f90fb2d13..629b9fcc7 100644
>>>>>>> --- a/drivers/gpu/drm/drm_vblank.c
>>>>>>> +++ b/drivers/gpu/drm/drm_vblank.c
>>>>>>> @@ -631,42 +631,51 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>>>>>>>     * drm_crtc_vblank_helper_get_vblank_timestamp(). They are
>>>>>>> derived from
>>>>>>>     * CRTC's true scanout timing, so they take things like panel
>>>>>>> scaling or
>>>>>>>     * other adjustments into account.
>>>>>>> + *
>>>>>>> + * Returns:
>>>>>>> + * 0 on success, or a negative errno code otherwise.
>>>>>>>     */
>>>>>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>>>> -     const struct drm_display_mode *mode)
>>>>>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>>>> +    const struct drm_display_mode *mode)
>>>>>>> {
>>>>>>> struct drm_device *dev = crtc->dev;
>>>>>>> unsigned int pipe = drm_crtc_index(crtc);
>>>>>>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>>>>>> - int linedur_ns = 0, framedur_ns = 0;
>>>>>>> + u64 linedur_ns, framedur_ns;
>>>>>>> int dotclock = mode->crtc_clock;
>>>>>>> + unsigned int frame_size;
>>>>>>>
>>>>>>> if (!drm_dev_has_vblank(dev))
>>>>>>> - return;
>>>>>>> + return 0;
>>>>>>>
>>>>>>> if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>>>>>>> - return;
>>>>>>> + return -EINVAL;
>>>>>>>
>>>>>>> - /* Valid dotclock? */
>>>>>>> - if (dotclock > 0) {
>>>>>>> - int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>>>>>>> + if (dotclock <= 0) {
>>>>>>> + drm_err(dev, "crtc %u: Can't calculate constants, dotclock =
>>>>>>> %d!\n",
>>>>> Please turn this into drm_err_once() because this call can actually be
>>>>> triggered repeatedly from userspace.
>>>>>
>>>>> Best regards
>>>>> Thomas
>>>>>
>>>>>
>>>>>>> + crtc->base.id, dotclock);
>>>>>>> + goto error;
>>>>>>> + }
>>>>>>>
>>>>>>> - /*
>>>>>>> - * Convert scanline length in pixels and video
>>>>>>> - * dot clock to line duration and frame duration
>>>>>>> - * in nanoseconds:
>>>>>>> - */
>>>>>>> - linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000,
>>>>>>> dotclock);
>>>>>>> - framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
>>>>>>> + frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode-
>>>>>>>> crtc_vtotal;
>>>>>>> - /*
>>>>>>> - * Fields of interlaced scanout modes are only half a frame
>>>>>>> duration.
>>>>>>> - */
>>>>>>> - if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>>>>>> - framedur_ns /= 2;
>>>>>>> - } else {
>>>>>>> - drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!
>>>>>>> \n",
>>>>>>> - crtc->base.id);
>>>>>>> + /*
>>>>>>> + * Convert scanline length in pixels and video dot clock to line
>>>>>>> duration
>>>>>>> + * and frame duration in nanoseconds.
>>>>>>> + */
>>>>>>> + linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
>>>>>>> + framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
>>>>>>> +
>>>>>>> + /*
>>>>>>> + * Fields of interlaced scanout modes are only half a frame
>>>>>>> duration.
>>>>>>> + */
>>>>>>> + if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>>>>>> + framedur_ns /= 2;
>>>>>>> +
>>>>>>> + if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
>>>>>>> + drm_dbg_kms(dev, "crtc %u: Can't calculate constants, mode clock
>>>>>>> too small!\n",
>>>>>>> +    crtc->base.id);
>>>>>>> + goto error;
>>>>>>> }
>>>>>>>
>>>>>>> vblank->linedur_ns  = linedur_ns;
>>>>>>> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct
>>>>>>> drm_crtc *crtc,
>>>>>>>        crtc->base.id, mode->crtc_htotal,
>>>>>>>        mode->crtc_vtotal, mode->crtc_vdisplay);
>>>>>>> drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
>>>>>>> -     crtc->base.id, dotclock, framedur_ns, linedur_ns);
>>>>>>> +     crtc->base.id, dotclock,
>>>>>>> +     vblank->framedur_ns, vblank->linedur_ns);
>>>>>>> +
>>>>>>> + return 0;
>>>>>>> +
>>>>>>> +error:
>>>>>>> + vblank->linedur_ns  = 0;
>>>>>>> + vblank->framedur_ns = 0;
>>>>>>> + drm_mode_copy(&vblank->hwmode, mode);
>>>>>>> + return -EINVAL;
>>>>>>> }
>>>>>>> EXPORT_SYMBOL(drm_calc_timestamping_constants);
>>>>>>>
>>>>>>> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct
>>>>>>> drm_crtc
>>>>>>> *crtc)
>>>>>>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>>>>>> struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
>>>>>>> unsigned long flags;
>>>>>>> + int ret;
>>>>>>>
>>>>>>> if (!vtimer->crtc) {
>>>>>>> /*
>>>>>>> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct
>>>>>>> drm_crtc
>>>>>>> *crtc)
>>>>>>> hrtimer_try_to_cancel(&vtimer->timer);
>>>>>>> }
>>>>>>>
>>>>>>> - drm_calc_timestamping_constants(crtc, &crtc->mode);
>>>>>>> + ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
>>>>>>> + if (ret)
>>>>>>> + return ret;
>>>>>>>
>>>>>>> spin_lock_irqsave(&vtimer->interval_lock, flags);
>>>>>>> vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>>>>>>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>>>>>>> index 2fcef9c0f..d99772dfa 100644
>>>>>>> --- a/include/drm/drm_vblank.h
>>>>>>> +++ b/include/drm/drm_vblank.h
>>>>>>> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>>>>>>> u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>>>>>>> void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>>>>>>>
>>>>>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>>>> -     const struct drm_display_mode *mode);
>>>>>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>>>> +    const struct drm_display_mode *mode);
>>>>>>> wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>>>>>>> void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>>>>>>>      u32 max_vblank_count);
>>>>>>> -- 
>>>>>>> 2.54.0
>>>>>>>
> 

