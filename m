Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1BD410D30
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824297; cv=none; b=AOO8s/9NE2uAcMocngN0K35TTroSON+VKoHPrfyh/jQ3uBoxAQA7k4Ob9WewtGCaaKQQGugBAlgSO+VnUhncnzzRLiYjJhcLbRZlWVU8wFHZ2tABUqPjDQlVuqzv7Ygx4Oy4nVULYzaYnPFQir1JaglSGbZBdHUP2U86gpD9K8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824297; c=relaxed/simple;
	bh=K9ZQh0DNkfrQhHfJ/RjYFdNEttKvRkk6KoKUGBG80MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFiwxBCQDnawzG55b5BjLiViscwjmpD7PouSj5frG2HSopKhbfDixXeb+l/iv9TMXP4FUtoRyWaFGAP4rAj09f9+HlBPk51J/x8BoW+yBM56A+q7gWYGakKukEW9gE6Q+NbkqE2IzbbGsxkdZucYq/4EQN+lSKLHEEZHB2/cBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NR8XoWNV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jCi+hwfW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1xQxQlMg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uP7mQjVf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NR8XoWNV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jCi+hwfW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1xQxQlMg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uP7mQjVf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5D33719E7;
	Tue, 30 Jun 2026 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782824293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VTry0q6GcbnFe1RAtyQviCwwb31sORraLMwHy2cHfq4=;
	b=NR8XoWNVDouv0SkIMYbzHltmbvBecvzDfzts5IXOxeODDV4N36SQfa1L50s5cJRKbAMNVw
	0clY4PmjpqITwudcSkgFrSEPeeWxQY2NZoyhdkwOJ2diQApCmnAkov/mvBFtuXK424fj7i
	Axns+iguHS6TCJP7sA3dRLlFTDtqHMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782824293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VTry0q6GcbnFe1RAtyQviCwwb31sORraLMwHy2cHfq4=;
	b=jCi+hwfWdfd+Cb7Tl2ps4XLmEFmdkV1sFM8g/IOgrYsdQH4INJ0T4mPdtqFB331JJsrHsX
	qafgsC71h8Gy4IDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1xQxQlMg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uP7mQjVf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782824292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VTry0q6GcbnFe1RAtyQviCwwb31sORraLMwHy2cHfq4=;
	b=1xQxQlMgk3xi2gMIKO6Njj5ad1ZtnTu7nlxtnpDjrRUfYBcTvKSs3tPbkwomKWn0kzeRok
	GfTVJVbtymJ9DXegimIENaCNtKL5cQN91T9jL35Uf1Q4NMkfTcWqaU3XA5P6dLO0gItGsL
	gBe8/sfrlIl4vG6GA6oYF9dbTY+AIDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782824292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VTry0q6GcbnFe1RAtyQviCwwb31sORraLMwHy2cHfq4=;
	b=uP7mQjVf+o2ak0+5617h2cL0E3cM1JVuMFEJnZ0SB3z5QjybtKcLYCOo3s1vajR2xDPaPV
	0SA1oiDoSUSYzQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73815779A8;
	Tue, 30 Jun 2026 12:58:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rGH+GmS9Q2o9JQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 30 Jun 2026 12:58:12 +0000
Message-ID: <3e92dfd1-2979-4246-9aac-09e21ec43704@suse.de>
Date: Tue, 30 Jun 2026 14:58:11 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: Roman Ilin <me@romanilin.is>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260613224434.96501-1-me@romanilin.is>
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
In-Reply-To: <20260613224434.96501-1-me@romanilin.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D5D33719E7
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[romanilin.is,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid,suse.de:dkim,bootlin.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

(cc Ville)

Hi,

thanks for addressing the issue.

Am 14.06.26 um 00:44 schrieb Roman Ilin:
> When a CRTC's display mode carries a too small pixel clock,
> drm_calc_timestamping_constants() computes a frame duration that
> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
> interval, after which vblank events are no longer delivered. Pending
> page flips never complete and the display appears frozen.
>
> This could be triggered on virtio-gpu guests that have dynamic resolution
> enabled: when the SPICE agent or the X server resizes the output, it
> submits a mode whose pixel clock is off by a factor of 1000, e.g.:

'off by' as in it should be in Hz rather than kHz.

>
>      clock = 406 kHz, htotal = 3152, vtotal = 2148
>
>      framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
>
> 16675852216 does not fit into an int and wraps to roughly -504000000.
> ns_to_ktime() then yields a negative interval and the timer stops working.
>
> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
> Use vblank timer"). That commit merely made virtio-gpu use the vblank
> timer and thereby exposed the pre-existing problem in the timer setup
> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>
> Reject a non-positive frame duration in drm_crtc_vblank_start_timer() and
> return an error. enable_vblank then fails and the driver falls back to
> sending the vblank event immediately, as it did before the vblank timer
> was introduced. Valid modes are unaffected, and the timer self-heals on
> the next mode that has a sane clock.
>
> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Roman Ilin <me@romanilin.is>
> ---
> Notes:
>
> Based on v7.1-rc7. Tested on 6.19 and 7.1-rc7.
>
> Open questions:
>
> This relies on the int overflow producing a negative value. The deeper
> issue is that drm_calc_timestamping_constants() truncates framedur_ns to
> int. Would you prefer to widen framedur_ns to s64, or to bound the
> interval here (e.g. reject framedur_ns above one second) so that any
> bogus interval is rejected regardless of sign?

Generally speaking, I think we should not accept such a bugos mode in 
the first place. But this would require changes to the mode-setting code 
that are too invasive for a bug fix.

So, if anything, we should try to detect the problem in 
drm_calc_timestamping_constants(). Let's make the helper return errno 
codes instead of failing silently. Within the helper, let's do the 
following changes:

- declare frame_size an unsigned int
- declare linedur_ns and framedur_ns of type u64

This should avoid possible overflows in the code.  And before assigning 
linedur_ns and framedur_ns to the vblank fields, test them against INT_MAX.

Maybe at [1]. Using drm_WARN_ON_ONCE is likely a good idea for future 
debugging.

if (drm_WARN_ON_ONCE(dev, linedur_ns > INT_MAX) || drm_WARN_ON_ONCE(dev, 
framedur_ns > INT_MAX))
    return -EINVAL

[1] 
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/drm_vblank.c#L662


>
> Should virtio-gpu additionally sanitize the user-supplied clock in its
> atomic_check (similar to vmwgfx for the clock==0 case) so the
> vblank-timer throttling is preserved for these resizes, instead of
> falling back to immediate events?
>
>   drivers/gpu/drm/drm_vblank.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f78bf37f1..557cd0bc8 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -2235,7 +2235,13 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>   
>   	drm_calc_timestamping_constants(crtc, &crtc->mode);
>   
> +	/*
> +	 * Return an error so the driver falls back to sending vblank events
> +	 * when a small mode clock yields a frame duration exceeding INT_MAX.
> +	 */
> +	if (vblank->framedur_ns <= 0)
> +		return -EINVAL;

Here, you would just forward the error upwards in the call stack.

Best regards
Thomas

> +
>   	spin_lock_irqsave(&vtimer->interval_lock, flags);
>   	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>   	spin_unlock_irqrestore(&vtimer->interval_lock, flags);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


