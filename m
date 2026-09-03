Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BD3264D5;
	Thu,  3 Sep 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444464; cv=none; b=TZlhQTuVO4hTBwQlcaAqS72Z7Bqk8UD13uXQLxCbIbfaGgvVN0z8HBmszUn0wdpMzG5jBiIPoRmYCTssbXCH2hB0eHXkjokqTmnf+mi+wANxX2eOs4iRWVQoqlEEEofz5FC1G/dgsAiNtwMWOnE5T2GqWEj9FgpcRDeIPAsJTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444464; c=relaxed/simple;
	bh=3JVcJdyW+KzKM09ayMr/cSlvghtbjv5LFmv0rpwNFII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsX29QkT+naKiZOuebr7tXvEJ9V+MQgAM57HfCl2ozrjO/w4HKnsEC5Krkx7MM5I6OhLe4b8ZNFDn+kmyNg4J/fmFlb8im04myl5UnZRVRs5Y71ENfjqFp5VBvAQDpawzUMtlm75ilkj85aNmbgOYpKMoPc01vVWM798llUPrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Hyp0gggJ; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Hyp0gggJ"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4hbLyK0ZQQz8kyp;
	Thu,  3 Sep 2026 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1788444441;
	bh=3JVcJdyW+KzKM09ayMr/cSlvghtbjv5LFmv0rpwNFII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hyp0gggJ6Y/kCMq53XZ9/nu7aQ6YuQ8DiUon1EbzK2A/R4CatF7NkEm+ivj1iug3a
	 dLwNlWS+G1u22qgOJlxD8nuvLRxsqkcWSsVwT+6lYuPKxofwlCB9mQ5ECLH5nLb1VR
	 q0mb6736J4cqV6ftXksX0v3wVMhgyaxAC8JoQo9VbhFQEQD0GjJDrtMuExBAig5itQ
	 fIYS0TbJ0zoU7c3pI4HA2WxG6BjWx0jmo7ejqm9iUi4nPKhb9meyfb/ZMcehdruSHO
	 eDqATWmOj1nfVIjK6Hn9GLFZRcNv/nHONYcUNl9P8mnp6BpSBYSMDkZMccFvfOshLJ
	 yJbJL8g8bKnvQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4hbLyJ6ycjz8k0P;
	Thu,  3 Sep 2026 14:07:20 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hbLyG6dWdz8svZ;
	Thu,  3 Sep 2026 16:07:18 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7B1D75F98C;
	Thu,  3 Sep 2026 16:07:17 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <0600a3f0-b2d2-4a07-ab21-f590c2979612@leemhuis.info>
Date: Thu, 3 Sep 2026 16:07:17 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <3b192119-9709-4f21-841f-a4706cc85e4a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178844443809.4107117.9364314680688868683@mxe9fb.netcup.net>
X-NC-CID: MeO2IRxoOEpTD/j4x3it0MhCtIXgmIlb7HzlQlo+BCdoA5uKCTM=

On 7/3/26 09:26, Thomas Zimmermann wrote:
> Am 02.07.26 um 20:23 schrieb Roman Ilin:
>> Apologies, I accidentally fired off send-email before saving my final
>> changelog notes. Please ignore the changelog and notes in the original
>> v3 email.
>>
>> The actual changes in v3 are:
>>
>> - Changed the WARN_ON_ONCE to drm_dbg_kms (to avoid user-triggerable
>>    panics).
> 
> We want to know when this happens. And user space will only be able to
> trigger this once, so there's no risk of spamming the kernel log.

Hmmm, just wondering: what's the status here?

Roman Ilin, did you loose interest? Or was this continued somewhere or
maybe even resolved and I just missed that?

Thomas: if Roman left this behind, could you maybe handle this, as it
fixes a regressions that iirc is caused by a change of yours? Or is it
fine for some reason to ignore this, even if the userland problem that
triggers this is still unfixed afaics? Side note: I by chance saw that
the latter a few days ago got a new comment from someone that ran into it.
https://gitlab.freedesktop.org/spice/linux/vd_agent/-/work_items/52

Ciao, Thorsten
> So this is not really a problem. drm_WARN_ON_ONCE was ok for that. You
> can also use a regular DRM print macro. But instead of drm_dbg_kms()
> should use drm_err_once(). But please also output linedur_ns and
> framedur_ns in the error. We want to know which of them is incorrect.
> You can also add more information to the error message. See [1] for the
> mode-formating macros.
> 
> [1] https://elixir.bootlin.com/linux/v7.1.2/source/include/drm/
> drm_modes.h#L422
> 
> 
>> - Updated drm_calc_timestamping_constants with the goto error fallback
>>    to clear the stale state.
>>
>> Also, an automated review bot pointed out an AB-BA deadlock in
>> drm_crtc_vblank_start_timer(). But I am leaving this out of the patch to
>> keep the fixes orthogonal.
>>
>> Sorry for the noise.
>>
>>> On Jul 2, 2026, at 21:10, Roman Ilin <me@romanilin.is> wrote:
>>>
>>> When a CRTC's display mode carries a too small pixel clock,
>>> drm_calc_timestamping_constants() computes a frame duration that
>>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>>> interval, after which vblank events are no longer delivered. Pending
>>> page flips never complete and the display appears frozen.
>>>
>>> This could be triggered on virtio-gpu guests that have dynamic
>>> resolution
>>> enabled: when the SPICE agent or the X server resizes the output, it
>>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>>>
>>>     clock = 406 kHz, htotal = 3152, vtotal = 2148
>>>
>>>     framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
>>>
>>> 16675852216 does not fit into an int and wraps to roughly -504000000.
>>> ns_to_ktime() then yields a negative interval and the timer stops
>>> working.
>>>
>>> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
>>> Use vblank timer"). That commit merely made virtio-gpu use the vblank
>>> timer and thereby exposed the pre-existing problem in the timer setup
>>> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>>>
>>> To fix this, modify drm_calc_timestamping_constants() to use u64 for
>>> calculations, check for INT_MAX overflows, and return an error code.
>>> drm_crtc_vblank_start_timer() will then propagate the error, enabling
>>> the driver to fall back to immediate vblank events. Valid modes are
>>> unaffected, and the timer self-heals on the next mode with a sane clock.
>>>
>>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Signed-off-by: Roman Ilin <me@romanilin.is>
>>> ---
>>> Changes in v3:
>>>
>>> - Changed the WARN_ON_ONCE to drm_err_once
>>>
>>> Notes:
>>>
>>>
>>>
>>> drivers/gpu/drm/drm_vblank.c | 71 +++++++++++++++++++++++-------------
>>> include/drm/drm_vblank.h     |  4 +-
>>> 2 files changed, 48 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>>> index f90fb2d13..629b9fcc7 100644
>>> --- a/drivers/gpu/drm/drm_vblank.c
>>> +++ b/drivers/gpu/drm/drm_vblank.c
>>> @@ -631,42 +631,51 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>>>   * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
>>>   * CRTC's true scanout timing, so they take things like panel
>>> scaling or
>>>   * other adjustments into account.
>>> + *
>>> + * Returns:
>>> + * 0 on success, or a negative errno code otherwise.
>>>   */
>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>> -     const struct drm_display_mode *mode)
>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>> +    const struct drm_display_mode *mode)
>>> {
>>> struct drm_device *dev = crtc->dev;
>>> unsigned int pipe = drm_crtc_index(crtc);
>>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>> - int linedur_ns = 0, framedur_ns = 0;
>>> + u64 linedur_ns, framedur_ns;
>>> int dotclock = mode->crtc_clock;
>>> + unsigned int frame_size;
>>>
>>> if (!drm_dev_has_vblank(dev))
>>> - return;
>>> + return 0;
>>>
>>> if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>>> - return;
>>> + return -EINVAL;
>>>
>>> - /* Valid dotclock? */
>>> - if (dotclock > 0) {
>>> - int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>>> + if (dotclock <= 0) {
>>> + drm_err(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
> 
> Please turn this into drm_err_once() because this call can actually be
> triggered repeatedly from userspace.
> 
> Best regards
> Thomas
> 
> 
>>> + crtc->base.id, dotclock);
>>> + goto error;
>>> + }
>>>
>>> - /*
>>> - * Convert scanline length in pixels and video
>>> - * dot clock to line duration and frame duration
>>> - * in nanoseconds:
>>> - */
>>> - linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
>>> - framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
>>> + frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode-
>>> >crtc_vtotal;
>>>
>>> - /*
>>> - * Fields of interlaced scanout modes are only half a frame duration.
>>> - */
>>> - if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>> - framedur_ns /= 2;
>>> - } else {
>>> - drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
>>> - crtc->base.id);
>>> + /*
>>> + * Convert scanline length in pixels and video dot clock to line
>>> duration
>>> + * and frame duration in nanoseconds.
>>> + */
>>> + linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
>>> + framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
>>> +
>>> + /*
>>> + * Fields of interlaced scanout modes are only half a frame duration.
>>> + */
>>> + if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>> + framedur_ns /= 2;
>>> +
>>> + if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
>>> + drm_dbg_kms(dev, "crtc %u: Can't calculate constants, mode clock
>>> too small!\n",
>>> +    crtc->base.id);
>>> + goto error;
>>> }
>>>
>>> vblank->linedur_ns  = linedur_ns;
>>> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct
>>> drm_crtc *crtc,
>>>      crtc->base.id, mode->crtc_htotal,
>>>      mode->crtc_vtotal, mode->crtc_vdisplay);
>>> drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
>>> -     crtc->base.id, dotclock, framedur_ns, linedur_ns);
>>> +     crtc->base.id, dotclock,
>>> +     vblank->framedur_ns, vblank->linedur_ns);
>>> +
>>> + return 0;
>>> +
>>> +error:
>>> + vblank->linedur_ns  = 0;
>>> + vblank->framedur_ns = 0;
>>> + drm_mode_copy(&vblank->hwmode, mode);
>>> + return -EINVAL;
>>> }
>>> EXPORT_SYMBOL(drm_calc_timestamping_constants);
>>>
>>> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc
>>> *crtc)
>>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>> struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
>>> unsigned long flags;
>>> + int ret;
>>>
>>> if (!vtimer->crtc) {
>>> /*
>>> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc
>>> *crtc)
>>> hrtimer_try_to_cancel(&vtimer->timer);
>>> }
>>>
>>> - drm_calc_timestamping_constants(crtc, &crtc->mode);
>>> + ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
>>> + if (ret)
>>> + return ret;
>>>
>>> spin_lock_irqsave(&vtimer->interval_lock, flags);
>>> vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>>> index 2fcef9c0f..d99772dfa 100644
>>> --- a/include/drm/drm_vblank.h
>>> +++ b/include/drm/drm_vblank.h
>>> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>>> u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>>> void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>>>
>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>> -     const struct drm_display_mode *mode);
>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>> +    const struct drm_display_mode *mode);
>>> wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>>> void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>>>    u32 max_vblank_count);
>>> -- 
>>> 2.54.0
>>>
> 

