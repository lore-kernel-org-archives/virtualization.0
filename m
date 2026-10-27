Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087275;
	b=Pqq/UGd06YlK2WurRrRxCAwlq5ekm5rxbT24SalQy1ZhihO+PSi59mUiRKuWl/056+Cu
	 4FoLWwlD2PrdcFdChJPKvj4wLunGF35l1BSYsrIXHan2+exH1OtjToEwEssMafl/R9sPo
	 asGO6ClikVOkqK/AdenU7Z8FLrLxFvcauTO+WL4WV1KUIFA/QLFK/r4Xhxhegvf16RG0B
	 cpDwetgrLiowBkXTErJXd+CWqyFu18+8qaxIxNgJNIYXaLELQ4mCKc1ILVWcv9ChsSSka
	 ql2R2V5gcvOdJ8eFmrpePYaxE9yY8L7ls2inNNFOZacEGHXq78c+aXotYK+xV4O3p2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087275;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=aKhDAgzXXUmG46ol/nzjlLM0rzeGHEiKNZ1GatfrbYk=;
	b=ARQTpdrmWNg9rWukY/I9LKxs2h6kGED/0NXZxZn0i0klltPmqZbc2GCjELbaQFqXN1oF
	 GxZlVU5O+ELPbMXLY215XQPr4dXAzRYKFNmGVvjboaLBuoThITYcIvsefNOpDgVHMIm44
	 jqYobC0jrG7k8vfHlJs/WKGEkLcl6oY0+jKdEZasqN6qH7cJ9sxJ9roXEDfqwotXH9qvA
	 utQEH+KRRostYUs7FcRTwXjJxutgpsS7xingoTKmiUeNE1sBcmthsBb9lRAoRRq1vjwmn
	 nni+yFxEk1ri5r4LreADkCficr3oCSeQxXOT0rc3nfZEr1Bya+WUDH3AwPxD6gxVLSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b="eldrP/xP";
	arc=none smtp.remote-ip=188.68.63.174
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE091606A31A;
	Tue, 27 Oct 2026 07:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE091606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=eldrP/xP
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4jDMzN6HmYz8tt6;
	Tue, 27 Oct 2026 07:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793087264;
	bh=jvH5rmcNh//J8ryzh9aICY7L0QAJcN8DwFIlF0b0dRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eldrP/xPXhDKLrDwUdZmFUxTy5je/eM7Mk7uPx1hMxzejC/E+/kQqkEZnV4YjvWF6
	 NAfOr+NEpCmWCVig/1w/P8OxFBgkW4VQvTM67ogv63cipqMJuuhyI3JmFZlZgdCUPj
	 tui5X3n75IWjPe70/OYu8lGPIDqNAklbVoyhXCllwOtiQHGcNo3XSQ+e8vVL4tK7oi
	 UzjY8V/cLogqxx+NogI5D0X7/F786u7sm0T60bmoxjVwOKGJfh07J5E5nR7HmtMyeT
	 DaP/kKljpIcrZzrpkcGLApoBOsHuw/OByzuPS5UoxflqIphYqC/88aHahDQXLmnUh1
	 2nOkL16SayRhA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4jDMzN5YPnz8tt1;
	Tue, 27 Oct 2026 07:47:44 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jDMzM0cMgz8sZN;
	Tue, 27 Oct 2026 08:47:42 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 56B0E5FA40;
	Tue, 27 Oct 2026 08:47:35 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b9284046-be28-4f80-81e9-d800e2d4204a@leemhuis.info>
Date: Tue, 27 Oct 2026 08:47:34 +0100
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
X-PPP-Message-ID: <179308725599.897684.6626675984855169399@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 56B0E5FA40
X-NC-CID: M6CcPbjGK/UHjI05l20YNEahmWfau3KE3EWN7F4qWvaP7iQOPC0=

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

Many thx again. But the thing is: it still s	



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

