Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2C40863B
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821355; cv=none; b=WiiQMg6sjxRpK6ffFAVgh9n3YsM2gvxF/PtqV6+Z2xt13JD36CyX3k6kUbmWpkVryFZDbmWnpgt/MFGNefV+wpflkk8aljV7eeT4rf81qx9vV2cc2BGrtF8ikJtMHvaCYwpmCidVfBwm1PucCdnI3RY8XoO8UwnAplZktBFhMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821355; c=relaxed/simple;
	bh=u9Z/3Dt5/H9G0cYU8hr9EkL3VAUTmYkPplPjUGQUZx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og/SplTntPwgtzsbg4h4Lx3jD527dgFqGoAC0hUQ4p4JVOhRNj1ZHyo6UeNTlcg/f6DUvnwUDPpDF8Ixp5cL4ZuJjJxt4pFZrb8u3VMMZjICLIGhMp+CJkUWpNAjiGl9SB48wVFo8m9uf07oBEDOjWP1KLSSvWFBku43pB2oDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qpPHXIjL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XLH3gCuV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qpPHXIjL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XLH3gCuV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qpPHXIjL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XLH3gCuV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qpPHXIjL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XLH3gCuV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AED7E71938;
	Tue, 30 Jun 2026 12:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782821351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZpaDpcLlwVcj1oknT8SoM2jRn99ha0Mdp+5STBUWoss=;
	b=qpPHXIjLoaTOfpzCH48WCRx3kHzuuaJ61GmYkGc+5IqDd8/NNKj/Z3KEE8Wvgx9Vw6Rkjr
	KKWAt30UNxWaZlG5CZr6igC9T8OzCKVsRBH5QAhDsAyUXBQDy8MLwdlXM96jhtlzIBKjDp
	w9CLLYi7lHA0O67wurngWfk6VfF15Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782821351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZpaDpcLlwVcj1oknT8SoM2jRn99ha0Mdp+5STBUWoss=;
	b=XLH3gCuV3Q8ucsapvDl9IB4EbvNQ9qxiEMVW1w5z1H043Xqs4f1gKOnTXvPEI9CzvHBUkx
	aVu3gqi/dJQraGAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782821351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZpaDpcLlwVcj1oknT8SoM2jRn99ha0Mdp+5STBUWoss=;
	b=qpPHXIjLoaTOfpzCH48WCRx3kHzuuaJ61GmYkGc+5IqDd8/NNKj/Z3KEE8Wvgx9Vw6Rkjr
	KKWAt30UNxWaZlG5CZr6igC9T8OzCKVsRBH5QAhDsAyUXBQDy8MLwdlXM96jhtlzIBKjDp
	w9CLLYi7lHA0O67wurngWfk6VfF15Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782821351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZpaDpcLlwVcj1oknT8SoM2jRn99ha0Mdp+5STBUWoss=;
	b=XLH3gCuV3Q8ucsapvDl9IB4EbvNQ9qxiEMVW1w5z1H043Xqs4f1gKOnTXvPEI9CzvHBUkx
	aVu3gqi/dJQraGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56DFB779A8;
	Tue, 30 Jun 2026 12:09:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 34QXFOexQ2o5cgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 30 Jun 2026 12:09:11 +0000
Message-ID: <af9febad-fe27-4040-b78e-9f2cfc53c38c@suse.de>
Date: Tue, 30 Jun 2026 14:09:10 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Roman Ilin <me@romanilin.is>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Peter Arnesen <peter.m.arnesen@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260613224434.96501-1-me@romanilin.is>
 <ef53342b-7c63-4681-8c5d-de86d9ee5541@leemhuis.info>
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
In-Reply-To: <ef53342b-7c63-4681-8c5d-de86d9ee5541@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,redhat.com,collabora.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,romanilin.is:email,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Level: 
X-Spam-Score: -2.80

Hi,

please also see this bug report:

https://gitlab.freedesktop.org/spice/linux/vd_agent/-/work_items/52

Am 30.06.26 um 14:06 schrieb Thorsten Leemhuis:
> On 6/14/26 00:44, Roman Ilin wrote:
>> When a CRTC's display mode carries a too small pixel clock,
>> drm_calc_timestamping_constants() computes a frame duration that
>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>> interval, after which vblank events are no longer delivered. Pending
>> page flips never complete and the display appears frozen.
> Roman, what's the status here? Does the problem still happen with
> 7.2-rc1? Sounds like it likely will, just want to make sure before
> prodding Thomas about it, who authored and committed the change that
> causes this regression.
>
> Side note: CCing Peter Arnesen, who seems to be affected as well.
> Quoting a message that was CCed to the regression list, but apparently
> was rejected there:
>
> """
> Hi everyone,
>
> I am experiencing a similar Wayland display freeze on Kernel 7.0
> described in Roman Ilin's recent patch thread ("drm/vblank: Don't arm
> vblank timer with invalid frame duration").
>
> Since my laptop consistently reproduces this freeze on boot, I am
> reaching out to offer my hardware for testing if you need verification
> that this patch resolves the issue on the newer Ryzen AI architectures.
>
> My System:
> * CPU / iGPU: AMD Ryzen AI 9 HX
> * dGPU: NVIDIA GeForce RTX 5070
> * OS: Fedora 44, Kubuntu 26.04 and Nobara Linux (Fedora-based) / Wayland
> * Regression Status: Works perfectly on Kernel 6.19. Fails on Kernel 7.0.
> * Tested Workarounds: Kernel parameters amdgpu.dcdebugmask=0x10, 0x410,
> and amdgpu.sg_display=0 do not bypass the freeze.
>
> Please let me know if you need me to pull specific dmesg logs or similar
> from the frozen state, or if there is a specific patched branch you
> would like me to compile and boot to verify the fix.
>
> Regards
>
> Peter
> """
>
> Peter, would be great if you could test 7.2-rc1, too. And if you really
> think the problem is the same, it might be worth trying Roman's patch.
> Ciao, Thorsten
>
>> This could be triggered on virtio-gpu guests that have dynamic resolution
>> enabled: when the SPICE agent or the X server resizes the output, it
>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>>
>>      clock = 406 kHz, htotal = 3152, vtotal = 2148
>>
>>      framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
>>
>> 16675852216 does not fit into an int and wraps to roughly -504000000.
>> ns_to_ktime() then yields a negative interval and the timer stops working.
>>
>> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
>> Use vblank timer"). That commit merely made virtio-gpu use the vblank
>> timer and thereby exposed the pre-existing problem in the timer setup
>> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>>
>> Reject a non-positive frame duration in drm_crtc_vblank_start_timer() and
>> return an error. enable_vblank then fails and the driver falls back to
>> sending the vblank event immediately, as it did before the vblank timer
>> was introduced. Valid modes are unaffected, and the timer self-heals on
>> the next mode that has a sane clock.
>>
>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Roman Ilin <me@romanilin.is>
>> ---
>> Notes:
>>
>> Based on v7.1-rc7. Tested on 6.19 and 7.1-rc7.
>>
>> Open questions:
>>
>> This relies on the int overflow producing a negative value. The deeper
>> issue is that drm_calc_timestamping_constants() truncates framedur_ns to
>> int. Would you prefer to widen framedur_ns to s64, or to bound the
>> interval here (e.g. reject framedur_ns above one second) so that any
>> bogus interval is rejected regardless of sign?
>>
>> Should virtio-gpu additionally sanitize the user-supplied clock in its
>> atomic_check (similar to vmwgfx for the clock==0 case) so the
>> vblank-timer throttling is preserved for these resizes, instead of
>> falling back to immediate events?
>>
>>   drivers/gpu/drm/drm_vblank.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index f78bf37f1..557cd0bc8 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -2235,7 +2235,13 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>>   
>>   	drm_calc_timestamping_constants(crtc, &crtc->mode);
>>   
>> +	/*
>> +	 * Return an error so the driver falls back to sending vblank events
>> +	 * when a small mode clock yields a frame duration exceeding INT_MAX.
>> +	 */
>> +	if (vblank->framedur_ns <= 0)
>> +		return -EINVAL;
>> +
>>   	spin_lock_irqsave(&vtimer->interval_lock, flags);
>>   	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>>   	spin_unlock_irqrestore(&vtimer->interval_lock, flags);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


