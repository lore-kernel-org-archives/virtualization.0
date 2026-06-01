Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762573DD53E
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335063; cv=none; b=fnw8vj48MQQI8C+PUgC7hChXhr2qECkEPoNY2SwQLKSDNz5ds1PldfRc60fUeC2zsAdx3wxZGlcTmWFXcuJ/BQYow5po319Z8m0irQ0LCn0aDSShBUi2UC/Vs0t/2uYygVGCYA4VuiuyiGMs8lp3Ra6ORjF9fW3lGqJvnz1OVUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335063; c=relaxed/simple;
	bh=5KdHiFvIla2hvHjDWKLy/AoYymCMXSucZA1NLwshGmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUhRJkhyuQB45psbqKmKukZoqVIQz8UIKADmbYGEC7KwO30RPybMtp7CaOta3ZiJBX6rmU2Ubj3k/cbsURZYt3JhbOiHQ11RcAfxeiG/voxR7T/87arSvyTIZEYeDPmAYYk7eMxnLIz4mgyRVJkr7sMmlzzCylTfi/OPLcHWZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xvxkyi9l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BmqnsQqC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GmMEXqc5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y6n3p1wY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xvxkyi9l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BmqnsQqC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GmMEXqc5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y6n3p1wY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A51576BB9C;
	Mon,  1 Jun 2026 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780335050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WjdbQ4xJezVp9Wa3jVVta4lyj8SRlbZm5FieCr1jNJs=;
	b=xvxkyi9l7YN8NRCNgaI8OGqa6igpVr3uy6FzMBE2jPkUwPiZF7jrRBO1GmqPCqVD/wqKf1
	+fDpT5/39IF/USECix80yh/WVejKwlg/XlJszQ8f8etTpbeBq6emjJJA83vbVaSNzIVH/L
	tdDsHII4N/jTb2cxutZJlZ9/K6P9gvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780335050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WjdbQ4xJezVp9Wa3jVVta4lyj8SRlbZm5FieCr1jNJs=;
	b=BmqnsQqCiC3H4w/mmGv5haZnp/RxGC2fc71TRRfYUKnnZR87/R9qpbPy0gPpBaLJ9UqeAR
	+axiGpuvDUhAThBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780335046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WjdbQ4xJezVp9Wa3jVVta4lyj8SRlbZm5FieCr1jNJs=;
	b=GmMEXqc5Tgih2c1LpKPudFZkBJfGYQo4FS+WxxFursq3LS1KINZwGs3MAQqFem/S2P87NW
	L1nG3Tf/lKeSb4EtywHNUzax35G/91a9nJELhJqHv/0TB6I4pSE4e7nihRiuFa2N+UQoU4
	cuZMPT2ScXb+jBCst5k0sAw2F8wqOiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780335046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WjdbQ4xJezVp9Wa3jVVta4lyj8SRlbZm5FieCr1jNJs=;
	b=y6n3p1wY7NSghx27drpSWVFnVpGJsClAaIYIlSZP4svJWW3EaQ3dPZIZfaMDyijjTq9XvC
	J4wW+nGQgd72UABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52347779A7;
	Mon,  1 Jun 2026 17:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WjJrEsbBHWpnOgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 17:30:46 +0000
Message-ID: <f7f53f9b-2576-4488-b0c1-35b6998d123c@suse.de>
Date: Mon, 1 Jun 2026 19:30:45 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/vblank: timer: Fix timestamp calculation
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 simona@ffwll.ch, louis.chauvet@bootlin.com, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, mhklkml@zohomail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20260601141922.91498-1-tzimmermann@suse.de>
 <20260601141922.91498-3-tzimmermann@suse.de>
 <c048fbcb-d318-414f-805f-18816cfa86f3@mailbox.org>
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
In-Reply-To: <c048fbcb-d318-414f-805f-18816cfa86f3@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[mailbox.org,ffwll.ch,bootlin.com,linux.intel.com,intel.com,zohomail.com,kernel.org,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -4.30

Hi

Am 01.06.26 um 18:24 schrieb Michel Dänzer:
> On 6/1/26 16:08, Thomas Zimmermann wrote:
>> In drm_crtc_vblank_get_vblank_timeout(), return the timestamp of the
>> first visible scanline after the last vblank timeout. This is what the
>> caller expects.
>>
>> A vblank phase starts with a vblank timeout. At this point the display
>> is blanked for several scanlines. Afterwards the display is unblanked
>> until the next vblank timeout occurs. The display content is only visible
>> during that second part.
>>
>> The current implementation of drm_crtc_vblank_get_vblank_timeout()
>> returns the timestamp of the last vblank timeout that started the current
>> vblank phase. But the display only unblanks after 20 to 30 percent of
>> the overall frame duration. The returned timestamp is therefore too early.
>>
>> The next vblank timeout is already known when calculating the returned
>> timestamp. Instead of subtracting the duration of a full frame from the
>> value, only subtract the duration of the active, visible part. The result
>> is the timestamp of the first visible scanline, as expected by the caller.
>>
>> This bug was not introduced by the generic vblank timer. It appears that
>> the get_vblank_timeout logic has always been buggy since it was first
>> added in commit 3a0709928b17 ("drm/vkms: Add vblank events simulated by
>> hrtimers").
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/drm_vblank.c | 32 +++++++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index 96d70c3d4522..d52df247d04e 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> [...]
>> @@ -2312,17 +2321,26 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
>>   		*vblank_time = READ_ONCE(vtimer->timer.node.expires);
>>   	} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
>>   
>> -	if (drm_WARN_ON(crtc->dev, !ktime_compare(*vblank_time, cur_time)))
>> +	if (drm_WARN_ON(dev, !ktime_compare(*vblank_time, cur_time)))
>>   		return false; /* Already expired */
>>   
>> +	framedur_ns = vblank->framedur_ns;
>> +
>>   	/*
>> -	 * To prevent races we roll the hrtimer forward before we do any
>> -	 * interrupt processing - this is how real hw works (the interrupt
>> -	 * is only generated after all the vblank registers are updated)
>> -	 * and what the vblank core expects. Therefore we need to always
>> -	 * correct the timestamp by one frame.
>> +	 * To prevent races we rolled the hrtimer forward before we did any
>> +	 * timeout processing - this is how real hw works (the interrupt is
>> +	 * only generated after all the vblank registers are updated) and what
>> +	 * the vblank core expects.
>> +	 *
>> +	 * Therefore we always need to correct the timestamp. The returned
>> +	 * time should be the time of the first active scanline after the
>> +	 * previous vblank. Hence subtract the active phase's duration from
>> +	 * the next expiration time.
>>   	 */
>> -	*vblank_time = ktime_sub(*vblank_time, vtimer->interval);
>> +	if (drm_WARN_ON(dev, !mode->crtc_vtotal))
>> +		return false;
>> +	activedur_ns = div_s64(framedur_ns * mode->crtc_vdisplay, mode->crtc_vtotal);
>> +	*vblank_time = ktime_sub_ns(*vblank_time, activedur_ns);
> Normally the timestamp returned by drm_crtc_vblank_count_and_time is supposed to correspond to the end of vertical blank / start of active, in which case the new code here looks wrong.
>
> Also, while the current time is inside an active area, it's supposed to return the timestamp corresponding to the start of the current active area, not the next one.

The initial value of *vblank_time is when the vblank timer fires _next_ 
and the display blanks. Subtracting the length of the active period 
should give the time of the first active scanline within the current 
vblank phase.

Isn't that exactly what you describe?

Best regards
Thomas

>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


