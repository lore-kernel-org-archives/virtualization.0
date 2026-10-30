Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370318;
	b=Cbdc1et9gcW5+UCBkY4jrsmKERdn4EQ76ZA4zlKszvxLho/89Rh4XH4SZxn1Zlapym8L
	 O+QsKugs5Uby/7olRK3Q+u1i88JTkE8Ms6CHEaj1TQOo+4wPfhBu7aU8aJpmwJm637vle
	 fBTFDCsipo9xPMhIzQwJOW09kkMLV8jyFyz7QnkAJzT/Rr4azoZALMjLqa7M3erLaBwrS
	 cby5SaiQsoC3RocV3ZjXHGKevL7/zZMx1habV16ln87LRSN6/2YeDxlkjzh6yQ3hfktgh
	 mLzDoxV4wicCCpVzSjKvrRjxXg5D2O2fO++MTst8IMJhAc/9K4CC3cFBYuzDl6nvs4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370318;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=NQaH/NEfSkFuRRvRaZMoOWTcku/Rk16IqqeHK0Sg+lQ=;
	b=5WYRYQr4EnKP5zBD75epQFeiAFRNPA9rBL8sfdit71mBdKAJRI/m9VjDtRwJt6ULNY+a
	 WZRDtv536/gl+i6HGqqQaQXXD5kvxh1XQvWv/oZUaFSA2v5tFwgcqvOdzz+oBLE5V1YHq
	 6zFPCjLlqLOMFpwEGCfCCF4qEQXTXgo8YqVaWZSM/tY9DF4qlQipszwZlAz+o0FK6uEDs
	 Zhw2Y/kRGEp+tXaeuguwrjymwKPmRF4fLTqfrO0VKiOlt2L8IhzkVx0GYlRJcEITP4Ru+
	 beBm4NbBdB+rS/ZB9PZDrPnhr3y7ikK8GD7yPh7Hf7GPK5etSXTG5e8vWor1kJBrPKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Zp56ReRB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7JNS7Ue9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Zp56ReRB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7JNS7Ue9;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC2606A31D;
	Fri, 30 Oct 2026 14:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0BC2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Zp56ReRB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7JNS7Ue9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Zp56ReRB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7JNS7Ue9
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDFA52224B;
	Fri, 30 Oct 2026 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793370315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NQaH/NEfSkFuRRvRaZMoOWTcku/Rk16IqqeHK0Sg+lQ=;
	b=Zp56ReRBoDYBXqzqljsdhcwB3pMAlmCmcATEK+l8m00q/opT5Tikjf5IBMeGVAbi8cVzBi
	vxdp50jQAAP2eu/7tj4j+7n7fz51a+B6TgYGkyD9e4uMNpckT9uNWKkwMnCkaF7eFvob2c
	pUiTpVJh2tR1YA9wcc1LTN/Q+3B7iNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793370315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NQaH/NEfSkFuRRvRaZMoOWTcku/Rk16IqqeHK0Sg+lQ=;
	b=7JNS7Ue9u5YGzpxjWdj+/8qOqbOIeW9TYa1T2gnNGy6V5JVxOmxXlF/KTUApWckV2dEErv
	mmwhKhwN3jtTvOAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793370315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NQaH/NEfSkFuRRvRaZMoOWTcku/Rk16IqqeHK0Sg+lQ=;
	b=Zp56ReRBoDYBXqzqljsdhcwB3pMAlmCmcATEK+l8m00q/opT5Tikjf5IBMeGVAbi8cVzBi
	vxdp50jQAAP2eu/7tj4j+7n7fz51a+B6TgYGkyD9e4uMNpckT9uNWKkwMnCkaF7eFvob2c
	pUiTpVJh2tR1YA9wcc1LTN/Q+3B7iNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793370315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NQaH/NEfSkFuRRvRaZMoOWTcku/Rk16IqqeHK0Sg+lQ=;
	b=7JNS7Ue9u5YGzpxjWdj+/8qOqbOIeW9TYa1T2gnNGy6V5JVxOmxXlF/KTUApWckV2dEErv
	mmwhKhwN3jtTvOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1041313419;
	Fri, 30 Oct 2026 14:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4A3pK8qo5GpfFQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 30 Oct 2026 14:25:14 +0000
Message-ID: <f406b2f6-cad9-411f-941a-7e4f26af3947@suse.de>
Date: Fri, 30 Oct 2026 15:25:14 +0100
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
 <auSIZNhP4DTj8Nb2@intel.com> <be8e41da-5ef1-4c37-a044-171ab1f32c6d@suse.de>
 <auSgII_W-FJJz44W@intel.com>
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
In-Reply-To: <auSgII_W-FJJz44W@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[romanilin.is,bootlin.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,collabora.com,leemhuis.info,lists.freedesktop.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,bootlin.com:url]
X-Spam-Score: -11.79

Hi

Am 30.10.26 um 14:48 schrieb Ville Syrjälä:
[...]
>> And how would drivers know that the values are garbage before processing
>> them?
> That's why I added the device wide mode_valid hook. Drivers can
> use that to reject garbage before it reaches anything more
> sensitive. I have somewhat hard time believing a mode that is
> acceptable/reasonable to some real world hardware would fail
> in the vblank calculations.

I can think of some drivers with fixed display mode, such as a panel or 
the sysfb drivers. If they use vblank timers they might run into that 
situation.  But it's really a corner case.

>
> Hmm, and I just realized that I haven't actually added any low limit
> for the dotclock in i915. I'll go do that now. I think ~10 MHz is
> probably a reasonable enough number I can use there.
>
>> Even if a driver could program them to hardware, the vblank
>> helpers could still not process them correctly. Thus leaving the
>> userspace dis-functional.
>>
>> I see that we might want a common test function
>> drm_vblank_check_display_mode() and put it in some central place in the
>> atomic_check pipeline. At least we'd separate the testing from the
>> calculation.
> Yeah, something like that could work. Though I still
> think it'd be better to do it from the driver's mode_valid
> hook to reject the bogus stuff even earlier.
>
> That would also filter them out from the connectors' mode
> lists. But I suppose you could do the vblank check in
> the connector mode filtering unconditionally without
> having the driver do it. Or does the buggy userspace also
> need the kernel to return bogus modes from getconnector?

How about we add a dedicated mode_fixup helper for vblank validation? It 
would run after new CRTC's mode_fixup callback. [1] There we could try 
to adapt the CRTC's adjusted_mode.  Since we know the bug exactly, we 
can try to detect it, fix it, and document it.

[1] 
https://elixir.bootlin.com/linux/v7.3/source/drivers/gpu/drm/drm_atomic_helper.c#L508

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


