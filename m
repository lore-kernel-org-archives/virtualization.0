Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365451;
	b=vzeeXFhIofukQ5uK5q2+fbWbW6tb9nE5WcmRuZzJJIb6O4ps+r9MNE4C2mrFCj6KmCU/
	 Jh5WPBeYtqrNq0Zs2J4Ilgh2362P6ZwVKK+sFKF7jX+DFAM/FAGZbeT9/ssIbLfDDRozO
	 2mvQmKdOIodVjgAt7qgqU0fZX4tMK882xTPGqK6OCVs0gk9y30oGjTN5tQezAKyYV6IfA
	 b9BWK5JrdQE73brtddi5ymX+lvUznJlWBMJhXXx0iu7BAoWbEF7mbDFv/xKzsA8J3RVgD
	 gfWe5XKh0Q7GPJ2TZny/ir+luaHJTVY8STCruGGG1hLmky1sZFawCX82CeTAQpQciyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365451;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=5pEfW2FITx/V3rz0KF7+o+h1SMnNPm1e/jyTsq0WtzY=;
	b=Wu322j4WXBNTpOkvQwrwAn7s7rqGUIArBzfZEHmKRT1oGkBs/oOKwAwwcFZSaNYMBlV7
	 j758FLaszmQVg7VmaR8wcbAfhPM8xG4XevQ1+NmNd1w//Wynfzo8joA63CUkfi2uVbqLJ
	 TReQdgqvRhHH2liN6dcioXPY78I5daFzV2iZIocJWeGrRV9rVMQkcJQGrDQTXGpdk1r3D
	 N0+hEqJdxmV5QjxPZLktyDDB7a4sekABIwFd9/pYe7xGu0iPVyX3XurSt6oo3SSr23e5x
	 MGsZfl4Tklcy9t7A0oJS6t3pcU8gfv1yUzUnbgcxdjXWJA6uLv6fer1GsQZkAkbj6Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oqmwwFya;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cdGDvU0t;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oqmwwFya;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cdGDvU0t;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB69606A31A;
	Fri, 30 Oct 2026 13:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB69606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oqmwwFya;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cdGDvU0t;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oqmwwFya;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cdGDvU0t
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52E0A21E34;
	Fri, 30 Oct 2026 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793365447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5pEfW2FITx/V3rz0KF7+o+h1SMnNPm1e/jyTsq0WtzY=;
	b=oqmwwFyamKSaOll6AlCfeGVpiONZW9vuTJZEurA93lkN5aibMYItl3hhiY3Wfn9Acxlqi0
	OD+WFYo7Gca4oC0Du54mV+zqM/mZPCRp2MCiXlAn2FCK2FuHppQ2qvdgFNrVG+Phv4vJnO
	7x0uyywtYDnKpWhLDqGmaUAFdSBbBgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793365447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5pEfW2FITx/V3rz0KF7+o+h1SMnNPm1e/jyTsq0WtzY=;
	b=cdGDvU0t34fmsXDQZ5aDJOCzAsMtIEjr6xLjp4fgK+5jh0Y5c8VM9BE08NKxjyG9/q5q9f
	gq3cQ/afzLgW3nBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oqmwwFya;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cdGDvU0t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793365447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5pEfW2FITx/V3rz0KF7+o+h1SMnNPm1e/jyTsq0WtzY=;
	b=oqmwwFyamKSaOll6AlCfeGVpiONZW9vuTJZEurA93lkN5aibMYItl3hhiY3Wfn9Acxlqi0
	OD+WFYo7Gca4oC0Du54mV+zqM/mZPCRp2MCiXlAn2FCK2FuHppQ2qvdgFNrVG+Phv4vJnO
	7x0uyywtYDnKpWhLDqGmaUAFdSBbBgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793365447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5pEfW2FITx/V3rz0KF7+o+h1SMnNPm1e/jyTsq0WtzY=;
	b=cdGDvU0t34fmsXDQZ5aDJOCzAsMtIEjr6xLjp4fgK+5jh0Y5c8VM9BE08NKxjyG9/q5q9f
	gq3cQ/afzLgW3nBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC011132C9;
	Fri, 30 Oct 2026 13:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +8v3F8WV5GrgPgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 30 Oct 2026 13:04:05 +0000
Message-ID: <be8e41da-5ef1-4c37-a044-171ab1f32c6d@suse.de>
Date: Fri, 30 Oct 2026 14:04:04 +0100
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
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: me@romanilin.is, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, javierm@redhat.com, dmitry.osipenko@collabora.com,
 regressions@leemhuis.info, peter.m.arnesen@gmail.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260914110004.211027-1-tzimmermann@suse.de>
 <auIMt8XmmaVykZTC@intel.com> <2c2f33cf-da6f-4e31-84bb-768778d7b063@suse.de>
 <auSIZNhP4DTj8Nb2@intel.com>
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
In-Reply-To: <auSIZNhP4DTj8Nb2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52E0A21E34
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[romanilin.is,bootlin.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,collabora.com,leemhuis.info,lists.freedesktop.org,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:url];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -12.00

Hi

Am 30.10.26 um 13:07 schrieb Ville Syrjälä:
> On Thu, Oct 29, 2026 at 12:35:52PM +0100, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 28.10.26 um 15:54 schrieb Ville Syrjälä:
>>> On Mon, Sep 14, 2026 at 12:57:26PM +0200, Thomas Zimmermann wrote:
>>>> From: Roman Ilin <me@romanilin.is>
>>>>
>>>> When a CRTC's display mode carries a too small pixel clock,
>>>> drm_calc_timestamping_constants() computes a frame duration that
>>>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>>>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>>>> interval, after which vblank events are no longer delivered. Pending
>>>> page flips never complete and the display appears frozen.
>>>>
>>>> This could be triggered on virtio-gpu guests that have dynamic resolution
>>>> enabled: when the SPICE agent or the X server resizes the output, it
>>>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>>>>
>>>>       clock = 406 kHz, htotal = 3152, vtotal = 2148
>>> How about actually "fixing" the clock in the driver?
>> It's not a broken driver, but user space. There is a bug report open for
>> spice to replace the incorrect units with correct ones. [1] The fix here
>> is supposed to resolve the kernel problem this triggers.
> Life becomes much simpler if you don't let garbage userspace input
> past some initial sanity checks. So technically the driver should
> just reject these modes. But in this case since you need to keep
> the broken userspace working the driver should just fix it up,
> and do so early so you don't have to deal with it anywhere else.

Not that I disagree, with the statement in general. But doing this here 
seems like whack-a-mole if we leave it to individual drivers. And the 
userspace is already dis-functional, no need to keep supporting it, I think.

And how would drivers know that the values are garbage before processing 
them? Even if a driver could program them to hardware, the vblank 
helpers could still not process them correctly. Thus leaving the 
userspace dis-functional.

I see that we might want a common test function 
drm_vblank_check_display_mode() and put it in some central place in the 
atomic_check pipeline. At least we'd separate the testing from the 
calculation.

Best regards
Thomas



>
>> [1] https://gitlab.freedesktop.org/spice/linux/vd_agent/-/work_items/52
>>
>> Best regards
>> Thomas
>>
>>
>>>>       framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
>>>>
>>>> 16675852216 does not fit into an int and wraps to roughly -504000000.
>>>> ns_to_ktime() then yields a negative interval and the timer stops working.
>>>>
>>>> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
>>>> Use vblank timer"). That commit merely made virtio-gpu use the vblank
>>>> timer and thereby exposed the pre-existing problem in the timer setup
>>>> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>>>>
>>>> To fix this, modify drm_calc_timestamping_constants() to use u64 for
>>>> calculations, check for INT_MAX overflows, and return an error code.
>>>> drm_crtc_vblank_start_timer() will then propagate the error, enabling
>>>> the driver to fall back to immediate vblank events. Valid modes are
>>>> unaffected, and the timer self-heals on the next mode with a sane clock.
>>>>
>>>> v4:
>>>> - avoid log spamming with drm_warn_once()
>>>>
>>>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Signed-off-by: Roman Ilin <me@romanilin.is>
>>>> ---
>>>> I took Roman's patch from [1] and replaced the error messages with
>>>> warn_once, as suggestde in my review.
>>>>
>>>> [1] https://lore.kernel.org/dri-devel/20260702181027.98526-1-me@romanilin.is/
>>>> ---
>>>>    drivers/gpu/drm/drm_vblank.c | 73 +++++++++++++++++++++++-------------
>>>>    include/drm/drm_vblank.h     |  4 +-
>>>>    2 files changed, 49 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>>>> index f90fb2d13e42..72b543bca9e3 100644
>>>> --- a/drivers/gpu/drm/drm_vblank.c
>>>> +++ b/drivers/gpu/drm/drm_vblank.c
>>>> @@ -631,45 +631,54 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>>>>     * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
>>>>     * CRTC's true scanout timing, so they take things like panel scaling or
>>>>     * other adjustments into account.
>>>> + *
>>>> + * Returns:
>>>> + * 0 on success, or a negative errno code otherwise.
>>>>     */
>>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>> -				     const struct drm_display_mode *mode)
>>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>> +				    const struct drm_display_mode *mode)
>>>>    {
>>>>    	struct drm_device *dev = crtc->dev;
>>>>    	unsigned int pipe = drm_crtc_index(crtc);
>>>>    	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>>> -	int linedur_ns = 0, framedur_ns = 0;
>>>> +	u64 linedur_ns, framedur_ns;
>>>>    	int dotclock = mode->crtc_clock;
>>>> +	unsigned int frame_size;
>>>>    
>>>>    	if (!drm_dev_has_vblank(dev))
>>>> -		return;
>>>> +		return 0;
>>>>    
>>>>    	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>>>> -		return;
>>>> +		return -EINVAL;
>>>>    
>>>> -	/* Valid dotclock? */
>>>> -	if (dotclock > 0) {
>>>> -		int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>>>> +	if (dotclock <= 0) {
>>>> +		drm_err_once(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
>>>> +			     crtc->base.id, dotclock);
>>>> +		goto error;
>>>> +	}
>>>>    
>>>> -		/*
>>>> -		 * Convert scanline length in pixels and video
>>>> -		 * dot clock to line duration and frame duration
>>>> -		 * in nanoseconds:
>>>> -		 */
>>>> -		linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
>>>> -		framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
>>>> +	frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode->crtc_vtotal;
>>>>    
>>>> -		/*
>>>> -		 * Fields of interlaced scanout modes are only half a frame duration.
>>>> -		 */
>>>> -		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>>> -			framedur_ns /= 2;
>>>> -	} else {
>>>> -		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
>>>> -			crtc->base.id);
>>>> +	/*
>>>> +	 * Convert scanline length in pixels and video dot clock to line duration
>>>> +	 * and frame duration in nanoseconds.
>>>> +	 */
>>>> +	linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
>>>> +	framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
>>>> +
>>>> +	/*
>>>> +	 * Fields of interlaced scanout modes are only half a frame duration.
>>>> +	 */
>>>> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>>> +		framedur_ns /= 2;
>>>> +
>>>> +	if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
>>>> +		drm_err_once(dev, "crtc %u: Can't calculate constants, mode clock too small!\n",
>>>> +			     crtc->base.id);
>>>> +		goto error;
>>>>    	}
>>>>    
>>>> -	vblank->linedur_ns  = linedur_ns;
>>>> +	vblank->linedur_ns = linedur_ns;
>>>>    	vblank->framedur_ns = framedur_ns;
>>>>    	drm_mode_copy(&vblank->hwmode, mode);
>>>>    
>>>> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>    		     crtc->base.id, mode->crtc_htotal,
>>>>    		     mode->crtc_vtotal, mode->crtc_vdisplay);
>>>>    	drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
>>>> -		     crtc->base.id, dotclock, framedur_ns, linedur_ns);
>>>> +		     crtc->base.id, dotclock,
>>>> +		     vblank->framedur_ns, vblank->linedur_ns);
>>>> +
>>>> +	return 0;
>>>> +
>>>> +error:
>>>> +	vblank->linedur_ns = 0;
>>>> +	vblank->framedur_ns = 0;
>>>> +	drm_mode_copy(&vblank->hwmode, mode);
>>>> +	return -EINVAL;
>>>>    }
>>>>    EXPORT_SYMBOL(drm_calc_timestamping_constants);
>>>>    
>>>> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>>>>    	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>>>    	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
>>>>    	unsigned long flags;
>>>> +	int ret;
>>>>    
>>>>    	if (!vtimer->crtc) {
>>>>    		/*
>>>> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>>>>    			hrtimer_try_to_cancel(&vtimer->timer);
>>>>    	}
>>>>    
>>>> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
>>>> +	ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
>>>> +	if (ret)
>>>> +		return ret;
>>>>    
>>>>    	spin_lock_irqsave(&vtimer->interval_lock, flags);
>>>>    	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>>>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>>>> index 2fcef9c0f5b1..d99772dfa034 100644
>>>> --- a/include/drm/drm_vblank.h
>>>> +++ b/include/drm/drm_vblank.h
>>>> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>>>>    u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>>>>    void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>>>>    
>>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>> -				     const struct drm_display_mode *mode);
>>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>> +				    const struct drm_display_mode *mode);
>>>>    wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>>>>    void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>>>>    				   u32 max_vblank_count);
>>>>
>>>> base-commit: 06576c2b43750d990297b8ff1989b94ac72e855f
>>>> prerequisite-patch-id: 6729bb10d5e338678e78ccda2dd24f232a13cd22
>>>> prerequisite-patch-id: 9d94d20bd45967493b4dc339b58082e1c8da0f4f
>>>> prerequisite-patch-id: 6ac8d22df34db9e7d467b1ab95ad30f94841d5db
>>>> prerequisite-patch-id: f548dbde3f944ca3415c808be628719acebe898a
>>>> prerequisite-patch-id: 2ae91ee8e2bbcd33b8325be046e7214185aba6aa
>>>> prerequisite-patch-id: f97bbde08a9996d7c62ca3e3ebfcd387e50bc5c3
>>>> prerequisite-patch-id: ecc3c825277bc9978c6979455517249a074c0cb1
>>>> prerequisite-patch-id: 0449925cca36664b566f614bfb7d573a11f0575f
>>>> prerequisite-patch-id: 9fb2c2787244e9621847af09bea03e575e6276c7
>>>> prerequisite-patch-id: eb4384d581805e1178d22e7df45f134223c38305
>>>> prerequisite-patch-id: 1a7a529e4b2864abe8071aa44598d28ce72483f4
>>>> prerequisite-patch-id: 844a85f4c2fe2f72209b82d46614004c3cfe4123
>>>> prerequisite-patch-id: 13f7cb22114c648d35f8c9fa74e9165656ce31eb
>>>> prerequisite-patch-id: 20ee46bd6fdd91e39f71d22f52ef6682a4e41512
>>>> prerequisite-patch-id: 1d26c0ff91796ff1e62d3831d00bee18723788ef
>>>> prerequisite-patch-id: 007f6ea0d09bef54b689bae0eb5abeb497bdfaad
>>>> prerequisite-patch-id: 2d89c1507c909520adf9bfb1a137d458a819ae8f
>>>> prerequisite-patch-id: d90dc4134468870ab8ccbd71547c9552dff74fbd
>>>> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
>>>> prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
>>>> prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
>>>> prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
>>>> -- 
>>>> 2.55.0
>> -- 
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


