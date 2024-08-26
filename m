Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90965473E
	for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659700; cv=none; b=Zd2RNqFr1ju3U1nmAWjVKR/chbdeRy65NnAGiBzMUP4KHOgMt6ao7kiUpq950WFWzn5nuTio6TNmR71rzoix/9DgzbqLMlPjg2MLUtQR9XU6sPRau4hLneI+EvT5x+QgmGCqRHDuT3p/ZCtlp5Jh/x4x7qtv9CJs3CQaKgn8MLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659700; c=relaxed/simple;
	bh=7Fn+vVX6XqLwkOKDzIhGYvNf4sbXjthnSN+OVAXYP9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4dkWOffxVF0ZBOA+cb1Z7oBrhl8otpgcx4sTJhF25DbFrNNkWBGSrGObniqCXqDstFWOXnH3IHe3caMvJEECaMdod5LNiy9N/ZvO2MDH9YWm8KqL6lmdMY54l9N4//F5yoUELSu7h9vxzZQIGAkLQmPJbR2aD95+6471r5Ta/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yjFD1dDi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jnwk4KB0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yjFD1dDi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jnwk4KB0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yjFD1dDi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jnwk4KB0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yjFD1dDi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jnwk4KB0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 893801F842;
	Mon, 26 Aug 2024 08:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724659696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kcVCZvaSME5ZxW/Kqo7l7+A69o+OPD2x/snzchAvSjI=;
	b=yjFD1dDij9LBSikENs6wS1/DOZu8ejKCFrU2BYctU4X2ZPYeNHHxHfuuj6ruIyIWuWXU/j
	F9KWQozxJCaXrbbnPlzmKS7nBpP1DGJnuFZxsVG2cXauRiQqmzgFpU3gJU+QOt4tLkmIzY
	39mJbOCRZ7k/kOF1SD0x/EOWt00qIGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724659696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kcVCZvaSME5ZxW/Kqo7l7+A69o+OPD2x/snzchAvSjI=;
	b=jnwk4KB0y+EUUcsxdY1cuu727YOluxTub5ZGpkR5ek/masNDKHMZTc6EHrE/tZY7gBK3+u
	fWoXVGgEkMONXRCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yjFD1dDi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jnwk4KB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724659696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kcVCZvaSME5ZxW/Kqo7l7+A69o+OPD2x/snzchAvSjI=;
	b=yjFD1dDij9LBSikENs6wS1/DOZu8ejKCFrU2BYctU4X2ZPYeNHHxHfuuj6ruIyIWuWXU/j
	F9KWQozxJCaXrbbnPlzmKS7nBpP1DGJnuFZxsVG2cXauRiQqmzgFpU3gJU+QOt4tLkmIzY
	39mJbOCRZ7k/kOF1SD0x/EOWt00qIGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724659696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kcVCZvaSME5ZxW/Kqo7l7+A69o+OPD2x/snzchAvSjI=;
	b=jnwk4KB0y+EUUcsxdY1cuu727YOluxTub5ZGpkR5ek/masNDKHMZTc6EHrE/tZY7gBK3+u
	fWoXVGgEkMONXRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5070413724;
	Mon, 26 Aug 2024 08:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qXj3EfA3zGaLVQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 26 Aug 2024 08:08:16 +0000
Message-ID: <fb8e3938-c9ef-4a7b-996e-0df9394b67a9@suse.de>
Date: Mon, 26 Aug 2024 10:08:15 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] rm/bochs: Modernize driver
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20240823124422.286989-1-tzimmermann@suse.de>
 <sksjddgidfrk4bvcxvb46khevp4a4nfvl2holgdw636wld7oov@vdbcvdf3ch6m>
 <42389f21-1ddb-428d-8471-92eae5a5f45a@suse.de>
 <zh63tmpp57ou4y3j54grngvqwqpls7hyw2eb44a6qjcpx6sb24@v5n7ri6aa6ny>
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
In-Reply-To: <zh63tmpp57ou4y3j54grngvqwqpls7hyw2eb44a6qjcpx6sb24@v5n7ri6aa6ny>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 893801F842
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,linux.intel.com,lists.freedesktop.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

Hi

Am 26.08.24 um 09:32 schrieb Gerd Hoffmann:
>    Hi,
>
>>> So this probably makes sense, but I'd like to see a bit more background
>>> information ...
>> The difference is in damage handling.
>>
>> The old code had two BOs in video memory and flipped between them. IDK the
>> details of the old rendering, but from the massive flickering of the cursor,
>> I assume that X11's internal either copies a full buffer during each redraw,
>> or doesn't really handle damage well. It could also happen that X didn't use
>> a shadow buffer for rendering. Bochs didn't request one. Without, drawing to
>> I/O memory is really slow. If that applies to virtual I/O memory as well
>> IDK.
>>
>> The new driver code only copies areas that have been changed from rendering.
>> The flickering is gone and the overall update performance is acceptable.
> Thanks.
>
> Have you tried wayland and fbcon too?

Fbcon is ok for text at least. I've yet to try wayland.

>
>>> On vram sizes:  The default qemu vram size (16M) should be fine for the
>>> default display resolution (1280x800).  For FullHD vram size should be
>>> doubled (-device VGA,vgamem_mb=32).
>> Right. Bochs never really tested that.  So I saw something like 5k by
>> 3k resolutions on my test setup with 16 MiB.
> IIRC there used to be a check in the past, limiting resolutions to
> buffer sizes which fit into vram twice (to allow for double buffering).
>
> Crude heuristic.  I do not remember when and why it went away.  Also
> I've seen wayland use three not two buffers ...

IDK where that test went.

The problem with TTM pinning/unpinning and eviction is that it requires 
3 times the maximum consumption of physical video memory, because there 
is fragmentation in some corner cases. So the 16 MiB default size seem 
really low.

Best regards
Thomas

>
>> Now that video-memory requirements for each mode can be calculated
>> easily, we can sort out the invalid modes.
> Yes.  Also I think trading higher main memory (shmem) usage for lower
> vram usage is good overall.  Main memory can be uses for something else
> if not needed whereas vram sits around unused.
>
> take care,
>    Gerd
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

