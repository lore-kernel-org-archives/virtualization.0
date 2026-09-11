Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69C411FA7;
	Fri, 11 Sep 2026 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112486; cv=none; b=JTM63RGWUXcj9mqJBv0ZOLUV/K00enZ2oJDvFR3UlFz/UrHSLTVqo526emeo6jfXEfMHOaY6OfvBWbWNXdb4kXDMiw9+01weS0JrdQaCm4lQBCj2z9N3UCSCTc+rKCaqIIpcPGO2XcCvvpeZi+mDMxR/LPbFeOz160StkrufO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112486; c=relaxed/simple;
	bh=xcYnE6/LSXVqirIZAi5Nb66u//g24+ZOxVZnvuRrp4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNhQSERf/yjjCJtiVSQlvgUP/OXToJNfzuKUV0wsm9+gE0M8qahKjDg7pi8rqRfxWd5gxoc39PJxVR0UKN0Imt+Koz0GFzTITcTCzlxJBAe+jeM7qNxMpSE6itwGtlEA3a+8tkzI9ucwjlclGkk2FlLCobMzQ/vifyF5uFrgnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=d+cUFSUo; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="d+cUFSUo"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hh60H2xDQz4JJl;
	Fri, 11 Sep 2026 09:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789112431;
	bh=xcYnE6/LSXVqirIZAi5Nb66u//g24+ZOxVZnvuRrp4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d+cUFSUoEDGscwsJRbDG/SDze3szxjMC2mCF9S+hp8SACn98L2ihT9YLAU0Tm909N
	 OXMsk/cloZYipNDr3oBTUdbnVeYKU8bV/mWNjnVJDusc1tVxNYw2VTLf2dOvtH6l7l
	 A/gYeopK/Fe1xA6YhkWnYXqzUy9x3DzTFX+l69M4/Uv1qaYy2AWiNyreetrOZwFe9f
	 QV8NvR40aR4kWzGkAHdaNnM9ehcuXAbL87CMoOziEI13ZH2OrylYsZsugfUC2WqeK3
	 80oa28zbO6VWypnfQOF7pc17vIbSi6peLQTdEco54cHE3LWU3NO52k5IMYybN3aQGN
	 D1k4OsIawKTSA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hh5zR44d9z7ylk;
	Fri, 11 Sep 2026 09:39:47 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hh5zP3wXWz8sbH;
	Fri, 11 Sep 2026 09:39:45 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 68F7F5FA94;
	Fri, 11 Sep 2026 09:39:37 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ec0c2486-b127-4a47-a81c-499130f268d9@leemhuis.info>
Date: Fri, 11 Sep 2026 09:39:35 +0200
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
 <0600a3f0-b2d2-4a07-ab21-f590c2979612@leemhuis.info>
 <f0e4cc76-5cf3-4fdb-b42c-f405a09c0d2a@suse.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <f0e4cc76-5cf3-4fdb-b42c-f405a09c0d2a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178911237806.1098728.4475708475432056913@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 68F7F5FA94
X-NC-CID: pAeiIysBZsQaVkzJajRrCRoQrYAtTwGF1+O9m4yh/GbgicGiOZo=

Hi Thomas!

On 9/4/26 08:19, Thomas Zimmermann wrote:
> Am 03.09.26 um 16:07 schrieb Thorsten Leemhuis:
>> On 7/3/26 09:26, Thomas Zimmermann wrote:
>>> Am 02.07.26 um 20:23 schrieb Roman Ilin:
>>>> Apologies, I accidentally fired off send-email before saving my final
>>>> changelog notes. Please ignore the changelog and notes in the original
>>>> v3 email.
>>> We want to know when this happens. And user space will only be able to
>>> trigger this once, so there's no risk of spamming the kernel log.
>>>> Hmmm, just wondering: what's the status here?
>>
>> Roman Ilin, did you loose interest? Or was this continued somewhere or
>> maybe even resolved and I just missed that?
>>
>> Thomas: if Roman left this behind, could you maybe handle this, [...]
>
> AFAICT it was almost there except for the error messaging. The v4 then
> never happened. I can finish the patch if Roman is no longer around.

No answer from Roman since then, so yes, that would be great! Tia!

Ciao, Thorsten

>>> So this is not really a problem. drm_WARN_ON_ONCE was ok for that. You
>>> can also use a regular DRM print macro. But instead of drm_dbg_kms()
>>> should use drm_err_once(). But please also output linedur_ns and
>>> framedur_ns in the error. We want to know which of them is incorrect.
>>> You can also add more information to the error message. See [1] for the
>>> mode-formating macros.
>>>
>>> [1] https://elixir.bootlin.com/linux/v7.1.2/source/include/drm/
>>> drm_modes.h#L422
>>>
>>>
>>>> - Updated drm_calc_timestamping_constants with the goto error fallback
>>>>     to clear the stale state.
>>>>
>>>> Also, an automated review bot pointed out an AB-BA deadlock in
>>>> drm_crtc_vblank_start_timer(). But I am leaving this out of the
>>>> patch to
>>>> keep the fixes orthogonal.
>>>>
>>>> Sorry for the noise.
>>>>
>>>>> On Jul 2, 2026, at 21:10, Roman Ilin <me@romanilin.is> wrote:
>>>>>
>>>>> When a CRTC's display mode carries a too small pixel clock,
>>>>> drm_calc_timestamping_constants() computes a frame duration that
>>>>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>>>>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>>>>> interval, after which vblank events are no longer delivered. Pending
>>>>> page flips never complete and the display appears frozen.
>>>>>
>>>>> This could be triggered on virtio-gpu guests that have dynamic
>>>>> resolution
>>>>> enabled: when the SPICE agent or the X server resizes the output, it
>>>>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>>>>>
>>>>>      clock = 406 kHz, htotal = 3152, vtotal = 2148
>>>>>
>>>>>      framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns
>>>>> (~16.7 s)
>>>>>
>>>>> 16675852216 does not fit into an int and wraps to roughly -504000000.
>>>>> ns_to_ktime() then yields a negative interval and the timer stops
>>>>> working.
>>>>>
>>>>> Found by bisection, which pointed at commit a036f5fceedb ("drm/
>>>>> virtgpu:
>>>>> Use vblank timer"). That commit merely made virtio-gpu use the vblank
>>>>> timer and thereby exposed the pre-existing problem in the timer setup
>>>>> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>>>>>
>>>>> To fix this, modify drm_calc_timestamping_constants() to use u64 for
>>>>> calculations, check for INT_MAX overflows, and return an error code.
>>>>> drm_crtc_vblank_start_timer() will then propagate the error, enabling
>>>>> the driver to fall back to immediate vblank events. Valid modes are
>>>>> unaffected, and the timer self-heals on the next mode with a sane
>>>>> clock.
>>>>>
>>>>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>> Signed-off-by: Roman Ilin <me@romanilin.is>
>>>>> ---
>>>>> Changes in v3:
>>>>>
>>>>> - Changed the WARN_ON_ONCE to drm_err_once
>>>>>
>>>>> Notes:
>>>>>
>>>>>
>>>>>
>>>>> drivers/gpu/drm/drm_vblank.c | 71 +++++++++++++++++++++++-------------
>>>>> include/drm/drm_vblank.h     |  4 +-
>>>>> 2 files changed, 48 insertions(+), 27 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/
>>>>> drm_vblank.c
>>>>> index f90fb2d13..629b9fcc7 100644
>>>>> --- a/drivers/gpu/drm/drm_vblank.c
>>>>> +++ b/drivers/gpu/drm/drm_vblank.c
>>>>> @@ -631,42 +631,51 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>>>>>    * drm_crtc_vblank_helper_get_vblank_timestamp(). They are
>>>>> derived from
>>>>>    * CRTC's true scanout timing, so they take things like panel
>>>>> scaling or
>>>>>    * other adjustments into account.
>>>>> + *
>>>>> + * Returns:
>>>>> + * 0 on success, or a negative errno code otherwise.
>>>>>    */
>>>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>> -     const struct drm_display_mode *mode)
>>>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>> +    const struct drm_display_mode *mode)
>>>>> {
>>>>> struct drm_device *dev = crtc->dev;
>>>>> unsigned int pipe = drm_crtc_index(crtc);
>>>>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>>>> - int linedur_ns = 0, framedur_ns = 0;
>>>>> + u64 linedur_ns, framedur_ns;
>>>>> int dotclock = mode->crtc_clock;
>>>>> + unsigned int frame_size;
>>>>>
>>>>> if (!drm_dev_has_vblank(dev))
>>>>> - return;
>>>>> + return 0;
>>>>>
>>>>> if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>>>>> - return;
>>>>> + return -EINVAL;
>>>>>
>>>>> - /* Valid dotclock? */
>>>>> - if (dotclock > 0) {
>>>>> - int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>>>>> + if (dotclock <= 0) {
>>>>> + drm_err(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
>>> Please turn this into drm_err_once() because this call can actually be
>>> triggered repeatedly from userspace.
>>>
>>> Best regards
>>> Thomas
>>>
>>>
>>>>> + crtc->base.id, dotclock);
>>>>> + goto error;
>>>>> + }
>>>>>
>>>>> - /*
>>>>> - * Convert scanline length in pixels and video
>>>>> - * dot clock to line duration and frame duration
>>>>> - * in nanoseconds:
>>>>> - */
>>>>> - linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
>>>>> - framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
>>>>> + frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode-
>>>>>> crtc_vtotal;
>>>>> - /*
>>>>> - * Fields of interlaced scanout modes are only half a frame duration.
>>>>> - */
>>>>> - if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>>>> - framedur_ns /= 2;
>>>>> - } else {
>>>>> - drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
>>>>> - crtc->base.id);
>>>>> + /*
>>>>> + * Convert scanline length in pixels and video dot clock to line
>>>>> duration
>>>>> + * and frame duration in nanoseconds.
>>>>> + */
>>>>> + linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
>>>>> + framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
>>>>> +
>>>>> + /*
>>>>> + * Fields of interlaced scanout modes are only half a frame duration.
>>>>> + */
>>>>> + if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>>>> + framedur_ns /= 2;
>>>>> +
>>>>> + if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
>>>>> + drm_dbg_kms(dev, "crtc %u: Can't calculate constants, mode clock
>>>>> too small!\n",
>>>>> +    crtc->base.id);
>>>>> + goto error;
>>>>> }
>>>>>
>>>>> vblank->linedur_ns  = linedur_ns;
>>>>> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct
>>>>> drm_crtc *crtc,
>>>>>       crtc->base.id, mode->crtc_htotal,
>>>>>       mode->crtc_vtotal, mode->crtc_vdisplay);
>>>>> drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
>>>>> -     crtc->base.id, dotclock, framedur_ns, linedur_ns);
>>>>> +     crtc->base.id, dotclock,
>>>>> +     vblank->framedur_ns, vblank->linedur_ns);
>>>>> +
>>>>> + return 0;
>>>>> +
>>>>> +error:
>>>>> + vblank->linedur_ns  = 0;
>>>>> + vblank->framedur_ns = 0;
>>>>> + drm_mode_copy(&vblank->hwmode, mode);
>>>>> + return -EINVAL;
>>>>> }
>>>>> EXPORT_SYMBOL(drm_calc_timestamping_constants);
>>>>>
>>>>> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc
>>>>> *crtc)
>>>>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>>>> struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
>>>>> unsigned long flags;
>>>>> + int ret;
>>>>>
>>>>> if (!vtimer->crtc) {
>>>>> /*
>>>>> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc
>>>>> *crtc)
>>>>> hrtimer_try_to_cancel(&vtimer->timer);
>>>>> }
>>>>>
>>>>> - drm_calc_timestamping_constants(crtc, &crtc->mode);
>>>>> + ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
>>>>> + if (ret)
>>>>> + return ret;
>>>>>
>>>>> spin_lock_irqsave(&vtimer->interval_lock, flags);
>>>>> vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>>>>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>>>>> index 2fcef9c0f..d99772dfa 100644
>>>>> --- a/include/drm/drm_vblank.h
>>>>> +++ b/include/drm/drm_vblank.h
>>>>> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>>>>> u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>>>>> void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>>>>>
>>>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>> -     const struct drm_display_mode *mode);
>>>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>> +    const struct drm_display_mode *mode);
>>>>> wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>>>>> void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>>>>>     u32 max_vblank_count);
>>>>> -- 
>>>>> 2.54.0
>>>>>
> 

