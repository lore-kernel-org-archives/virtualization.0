Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172459;
	b=vOtCTzayfNvTtwGWerL8PWdS0w5+SaX65IcRkEnZJsuDM5mt/MukKeEfmki/hMcvVz7t
	 WNpj8a0kOtIcgBWqKU/zS+clalPCyY5xsDfQGya8ClPufANRFsk2wkxYGmjHRTdEs3E7P
	 Gv809UzywGGBnEQVliVmInU9epdlgRH78cfy9keG4VJM4YBjdn3awui2c6LzXKbrxpqi0
	 pCIHGLT5JvotCY/rqaJIhzqQxF/LRLX74rDBeeG1Em+INwrGKUABtukE4FcFJKwn5tzh0
	 cedpWeHUziZsF7SIPgtgm2OQ/SJ7NK3qCmFAB8pb6lddW491mtolPefo69fc1aztV1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172459;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=mbGa7/pJLqNh9s5lB1eARfC8HZvlkVr7AS4gBr7kAhI=;
	b=lD4t7jrR4y5knCp2gH2QuyiwtP3fuEy5t6iU2EFlK3aT94JfrR9RT4/JU7ALjp/mPYld
	 7H3oZKX4VTfbKEVTWfp+Y39a7DYNifnYd1LWxNYrqP4fgwy9m5SSTlLPmUI4obtiS+htR
	 sNS6xG/CKsaZSFC/S5lIM1VN+L4z+GNUh2W4vY1P32q8pTm+mhizzxiecdaMWq6pUFAf6
	 2LSSBQgWwPO6zCmXovKrVqzpVBUAMy2yxKJsZpmqPSMx0/QA7ACeyZLpHs8gfeKk/KBR8
	 cKtyA4LS9f08jiITyaz/KfWQOUxXZN077J8XPfhM9LrgtX9haGkf0l+TLitnMoC+6Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=haRmA17N;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sDIkijTX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=haRmA17N;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sDIkijTX;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497A606A31D;
	Wed, 28 Oct 2026 07:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E497A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=haRmA17N;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sDIkijTX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=haRmA17N;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sDIkijTX
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09E312210B;
	Wed, 28 Oct 2026 07:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793172456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mbGa7/pJLqNh9s5lB1eARfC8HZvlkVr7AS4gBr7kAhI=;
	b=haRmA17NVxVr/JiFYm/O6+mOC+/ctud0hBrGljNy0Zbdo+YDgJan6LujjLB7fSVLb/Zjua
	//c8RtmOK+RhsuGA8qLQz754oXGa+h6UEV7FHzLng2sv1n1CWhsDWA5X0uR2ZzfkjwcEOR
	PCi/rx/LBVb792i7FnFuNKkHUddhvIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793172456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mbGa7/pJLqNh9s5lB1eARfC8HZvlkVr7AS4gBr7kAhI=;
	b=sDIkijTXOHEuKluliVY5fBgXxuB1WncaOrvU0jFMAjrrRt9oL1i9kCnpvxx8x6YZhUVriY
	fvziUnSPvecZKvDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=haRmA17N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sDIkijTX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793172456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mbGa7/pJLqNh9s5lB1eARfC8HZvlkVr7AS4gBr7kAhI=;
	b=haRmA17NVxVr/JiFYm/O6+mOC+/ctud0hBrGljNy0Zbdo+YDgJan6LujjLB7fSVLb/Zjua
	//c8RtmOK+RhsuGA8qLQz754oXGa+h6UEV7FHzLng2sv1n1CWhsDWA5X0uR2ZzfkjwcEOR
	PCi/rx/LBVb792i7FnFuNKkHUddhvIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793172456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mbGa7/pJLqNh9s5lB1eARfC8HZvlkVr7AS4gBr7kAhI=;
	b=sDIkijTXOHEuKluliVY5fBgXxuB1WncaOrvU0jFMAjrrRt9oL1i9kCnpvxx8x6YZhUVriY
	fvziUnSPvecZKvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 821931321C;
	Wed, 28 Oct 2026 07:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0//wCeej4Wp8PwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 28 Oct 2026 07:27:35 +0000
Message-ID: <2b2f1c04-4638-4622-9816-639d4fffa51d@suse.de>
Date: Wed, 28 Oct 2026 08:27:34 +0100
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
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Roman Ilin <me@romanilin.is>
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
 <7f21f160-f637-4b63-aa15-066d7b18e2ed@leemhuis.info>
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
In-Reply-To: <7f21f160-f637-4b63-aa15-066d7b18e2ed@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09E312210B
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	URIBL_BLOCKED(0.00)[romanilin.is:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,bootlin.com:url,suse.com:url,suse.de:dkim,suse.de:email];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,kernel.org,bootlin.com,redhat.com,collabora.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,linux.intel.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.com:url]
X-Spam-Score: -12.00

Hi

Am 27.10.26 um 08:49 schrieb Thorsten Leemhuis:
> On 9/14/26 13:00, Thomas Zimmermann wrote:
>> Am 11.09.26 um 09:39 schrieb Thorsten Leemhuis:
>>> On 9/4/26 08:19, Thomas Zimmermann wrote:
>>>> Am 03.09.26 um 16:07 schrieb Thorsten Leemhuis:
>>>>> On 7/3/26 09:26, Thomas Zimmermann wrote:
>>>>>> Am 02.07.26 um 20:23 schrieb Roman Ilin:
>>>>>>> Apologies, I accidentally fired off send-email before saving my final
>>>>>>> changelog notes. Please ignore the changelog and notes in the
>>>>>>> original
>>>>>>> v3 email.
>>>>>> We want to know when this happens. And user space will only be able to
>>>>>> trigger this once, so there's no risk of spamming the kernel log.
>>>>>>> Hmmm, just wondering: what's the status here?
>>>>> Roman Ilin, did you loose interest? Or was this continued somewhere or
>>>>> maybe even resolved and I just missed that?
>>>>>
>>>>> Thomas: if Roman left this behind, could you maybe handle this, [...]
>>>> AFAICT it was almost there except for the error messaging. The v4 then
>>>> never happened. I can finish the patch if Roman is no longer around.
>>> No answer from Roman since then, so yes, that would be great! Tia!
>> I've now sent out an update with minor changes.
> Many thx again. But the thing is: it still sits on the list waiting for
> review afaics:
>
> https://lore.kernel.org/all/20260914110004.211027-1-tzimmermann@suse.de/
>
> Can you maybe prod the right people to finally get this resolved? Or
> what should be do instead?

The right people are in cc already. It's just that no one reviewed. I'll 
ping them to get this resolved.

Best regards
Thomas

>
> Ciao, Thorsten
>
>>>>>> So this is not really a problem. drm_WARN_ON_ONCE was ok for that. You
>>>>>> can also use a regular DRM print macro. But instead of drm_dbg_kms()
>>>>>> should use drm_err_once(). But please also output linedur_ns and
>>>>>> framedur_ns in the error. We want to know which of them is incorrect.
>>>>>> You can also add more information to the error message. See [1] for
>>>>>> the
>>>>>> mode-formating macros.
>>>>>>
>>>>>> [1] https://elixir.bootlin.com/linux/v7.1.2/source/include/drm/
>>>>>> drm_modes.h#L422
>>>>>>
>>>>>>
>>>>>>> - Updated drm_calc_timestamping_constants with the goto error
>>>>>>> fallback
>>>>>>>       to clear the stale state.
>>>>>>>
>>>>>>> Also, an automated review bot pointed out an AB-BA deadlock in
>>>>>>> drm_crtc_vblank_start_timer(). But I am leaving this out of the
>>>>>>> patch to
>>>>>>> keep the fixes orthogonal.
>>>>>>>
>>>>>>> Sorry for the noise.
>>>>>>>
>>>>>>>> On Jul 2, 2026, at 21:10, Roman Ilin <me@romanilin.is> wrote:
>>>>>>>>
>>>>>>>> When a CRTC's display mode carries a too small pixel clock,
>>>>>>>> drm_calc_timestamping_constants() computes a frame duration that
>>>>>>>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>>>>>>>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>>>>>>>> interval, after which vblank events are no longer delivered. Pending
>>>>>>>> page flips never complete and the display appears frozen.
>>>>>>>>
>>>>>>>> This could be triggered on virtio-gpu guests that have dynamic
>>>>>>>> resolution
>>>>>>>> enabled: when the SPICE agent or the X server resizes the output, it
>>>>>>>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>>>>>>>>
>>>>>>>>        clock = 406 kHz, htotal = 3152, vtotal = 2148
>>>>>>>>
>>>>>>>>        framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns
>>>>>>>> (~16.7 s)
>>>>>>>>
>>>>>>>> 16675852216 does not fit into an int and wraps to roughly
>>>>>>>> -504000000.
>>>>>>>> ns_to_ktime() then yields a negative interval and the timer stops
>>>>>>>> working.
>>>>>>>>
>>>>>>>> Found by bisection, which pointed at commit a036f5fceedb ("drm/
>>>>>>>> virtgpu:
>>>>>>>> Use vblank timer"). That commit merely made virtio-gpu use the
>>>>>>>> vblank
>>>>>>>> timer and thereby exposed the pre-existing problem in the timer
>>>>>>>> setup
>>>>>>>> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>>>>>>>>
>>>>>>>> To fix this, modify drm_calc_timestamping_constants() to use u64 for
>>>>>>>> calculations, check for INT_MAX overflows, and return an error code.
>>>>>>>> drm_crtc_vblank_start_timer() will then propagate the error,
>>>>>>>> enabling
>>>>>>>> the driver to fall back to immediate vblank events. Valid modes are
>>>>>>>> unaffected, and the timer self-heals on the next mode with a sane
>>>>>>>> clock.
>>>>>>>>
>>>>>>>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>>>>>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>>>> Signed-off-by: Roman Ilin <me@romanilin.is>
>>>>>>>> ---
>>>>>>>> Changes in v3:
>>>>>>>>
>>>>>>>> - Changed the WARN_ON_ONCE to drm_err_once
>>>>>>>>
>>>>>>>> Notes:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> drivers/gpu/drm/drm_vblank.c | 71 ++++++++++++++++++++++
>>>>>>>> +-------------
>>>>>>>> include/drm/drm_vblank.h     |  4 +-
>>>>>>>> 2 files changed, 48 insertions(+), 27 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/
>>>>>>>> drm_vblank.c
>>>>>>>> index f90fb2d13..629b9fcc7 100644
>>>>>>>> --- a/drivers/gpu/drm/drm_vblank.c
>>>>>>>> +++ b/drivers/gpu/drm/drm_vblank.c
>>>>>>>> @@ -631,42 +631,51 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>>>>>>>>      * drm_crtc_vblank_helper_get_vblank_timestamp(). They are
>>>>>>>> derived from
>>>>>>>>      * CRTC's true scanout timing, so they take things like panel
>>>>>>>> scaling or
>>>>>>>>      * other adjustments into account.
>>>>>>>> + *
>>>>>>>> + * Returns:
>>>>>>>> + * 0 on success, or a negative errno code otherwise.
>>>>>>>>      */
>>>>>>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>>>>> -     const struct drm_display_mode *mode)
>>>>>>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>>>>> +    const struct drm_display_mode *mode)
>>>>>>>> {
>>>>>>>> struct drm_device *dev = crtc->dev;
>>>>>>>> unsigned int pipe = drm_crtc_index(crtc);
>>>>>>>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>>>>>>> - int linedur_ns = 0, framedur_ns = 0;
>>>>>>>> + u64 linedur_ns, framedur_ns;
>>>>>>>> int dotclock = mode->crtc_clock;
>>>>>>>> + unsigned int frame_size;
>>>>>>>>
>>>>>>>> if (!drm_dev_has_vblank(dev))
>>>>>>>> - return;
>>>>>>>> + return 0;
>>>>>>>>
>>>>>>>> if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>>>>>>>> - return;
>>>>>>>> + return -EINVAL;
>>>>>>>>
>>>>>>>> - /* Valid dotclock? */
>>>>>>>> - if (dotclock > 0) {
>>>>>>>> - int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>>>>>>>> + if (dotclock <= 0) {
>>>>>>>> + drm_err(dev, "crtc %u: Can't calculate constants, dotclock =
>>>>>>>> %d!\n",
>>>>>> Please turn this into drm_err_once() because this call can actually be
>>>>>> triggered repeatedly from userspace.
>>>>>>
>>>>>> Best regards
>>>>>> Thomas
>>>>>>
>>>>>>
>>>>>>>> + crtc->base.id, dotclock);
>>>>>>>> + goto error;
>>>>>>>> + }
>>>>>>>>
>>>>>>>> - /*
>>>>>>>> - * Convert scanline length in pixels and video
>>>>>>>> - * dot clock to line duration and frame duration
>>>>>>>> - * in nanoseconds:
>>>>>>>> - */
>>>>>>>> - linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000,
>>>>>>>> dotclock);
>>>>>>>> - framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
>>>>>>>> + frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode-
>>>>>>>>> crtc_vtotal;
>>>>>>>> - /*
>>>>>>>> - * Fields of interlaced scanout modes are only half a frame
>>>>>>>> duration.
>>>>>>>> - */
>>>>>>>> - if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>>>>>>> - framedur_ns /= 2;
>>>>>>>> - } else {
>>>>>>>> - drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!
>>>>>>>> \n",
>>>>>>>> - crtc->base.id);
>>>>>>>> + /*
>>>>>>>> + * Convert scanline length in pixels and video dot clock to line
>>>>>>>> duration
>>>>>>>> + * and frame duration in nanoseconds.
>>>>>>>> + */
>>>>>>>> + linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
>>>>>>>> + framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
>>>>>>>> +
>>>>>>>> + /*
>>>>>>>> + * Fields of interlaced scanout modes are only half a frame
>>>>>>>> duration.
>>>>>>>> + */
>>>>>>>> + if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>>>>>>> + framedur_ns /= 2;
>>>>>>>> +
>>>>>>>> + if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
>>>>>>>> + drm_dbg_kms(dev, "crtc %u: Can't calculate constants, mode clock
>>>>>>>> too small!\n",
>>>>>>>> +    crtc->base.id);
>>>>>>>> + goto error;
>>>>>>>> }
>>>>>>>>
>>>>>>>> vblank->linedur_ns  = linedur_ns;
>>>>>>>> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct
>>>>>>>> drm_crtc *crtc,
>>>>>>>>         crtc->base.id, mode->crtc_htotal,
>>>>>>>>         mode->crtc_vtotal, mode->crtc_vdisplay);
>>>>>>>> drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
>>>>>>>> -     crtc->base.id, dotclock, framedur_ns, linedur_ns);
>>>>>>>> +     crtc->base.id, dotclock,
>>>>>>>> +     vblank->framedur_ns, vblank->linedur_ns);
>>>>>>>> +
>>>>>>>> + return 0;
>>>>>>>> +
>>>>>>>> +error:
>>>>>>>> + vblank->linedur_ns  = 0;
>>>>>>>> + vblank->framedur_ns = 0;
>>>>>>>> + drm_mode_copy(&vblank->hwmode, mode);
>>>>>>>> + return -EINVAL;
>>>>>>>> }
>>>>>>>> EXPORT_SYMBOL(drm_calc_timestamping_constants);
>>>>>>>>
>>>>>>>> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct
>>>>>>>> drm_crtc
>>>>>>>> *crtc)
>>>>>>>> struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>>>>>>> struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
>>>>>>>> unsigned long flags;
>>>>>>>> + int ret;
>>>>>>>>
>>>>>>>> if (!vtimer->crtc) {
>>>>>>>> /*
>>>>>>>> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct
>>>>>>>> drm_crtc
>>>>>>>> *crtc)
>>>>>>>> hrtimer_try_to_cancel(&vtimer->timer);
>>>>>>>> }
>>>>>>>>
>>>>>>>> - drm_calc_timestamping_constants(crtc, &crtc->mode);
>>>>>>>> + ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
>>>>>>>> + if (ret)
>>>>>>>> + return ret;
>>>>>>>>
>>>>>>>> spin_lock_irqsave(&vtimer->interval_lock, flags);
>>>>>>>> vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>>>>>>>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>>>>>>>> index 2fcef9c0f..d99772dfa 100644
>>>>>>>> --- a/include/drm/drm_vblank.h
>>>>>>>> +++ b/include/drm/drm_vblank.h
>>>>>>>> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>>>>>>>> u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>>>>>>>> void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>>>>>>>>
>>>>>>>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>>>>> -     const struct drm_display_mode *mode);
>>>>>>>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>>>>>>>> +    const struct drm_display_mode *mode);
>>>>>>>> wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>>>>>>>> void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>>>>>>>>       u32 max_vblank_count);
>>>>>>>> -- 
>>>>>>>> 2.54.0
>>>>>>>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


