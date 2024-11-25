Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC41426C
	for <virtualization@lists.linux.dev>; Mon, 25 Nov 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531200; cv=none; b=YdTSS5ZFzwkEGgBBTG+AdqVQL04qZD4dnMApQQEqkH+ZMoDttK4LnzmadjmAf2DZaJzNDej4xrkdUtNZu/ZyxJEq36fppoefY1aUcwAkNXFdBwjKFrRQ5cLtVyN2YvCH2K62Z91JT4pbkkGkqcsrCmMySGwr04Ij6XT6K3PxE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531200; c=relaxed/simple;
	bh=9xS52vYa8qP7MwzpxIQpWiHifz/sLzCnVdPAnUriFI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bt6zL1ekxJuH9sqBYG64iyzUf622RwBOAfNUTnnT6taJ/pWAHLt1zGvMAalX9q/pl5k1QOJ/hUOQfbgLoUFJBmTGzJ/bxvMf5l2SuKjp/l+xxXPaAtXz1qEmXnMWSqY0rgXJE9PvI5wctojLHs9B0pnBjth37T09MamvXrWRHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YQ8G6Lzl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dW3qv35q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YQ8G6Lzl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dW3qv35q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YQ8G6Lzl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dW3qv35q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YQ8G6Lzl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dW3qv35q"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C80C71F381;
	Mon, 25 Nov 2024 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732531196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6KZQGGboR1jU1WlTkMsW24bcGWVCT37J1TXj+3zjC5w=;
	b=YQ8G6LzlraUlyuWdsPXKdppLdumZvhpUj4g0ADWEQp4t9cF2q2I2lafTHOQPDs8yVT6CjC
	fwktaZSNZOfk8MXeobuZutgoudFATBeGno/1xQpXNjDkHT93W7dHIfMd3uvXJh93Xhqhcb
	srqaRP/OMsyEJHvyduG3qu8s4dKy6lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732531196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6KZQGGboR1jU1WlTkMsW24bcGWVCT37J1TXj+3zjC5w=;
	b=dW3qv35qDx5lCzoej7tE3CloPgq6X7N+n3w3DMwDkZryXlpwemBS+bNyt7Zvc3jQVN+Dgr
	9hohpP3YnTAdIQCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732531196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6KZQGGboR1jU1WlTkMsW24bcGWVCT37J1TXj+3zjC5w=;
	b=YQ8G6LzlraUlyuWdsPXKdppLdumZvhpUj4g0ADWEQp4t9cF2q2I2lafTHOQPDs8yVT6CjC
	fwktaZSNZOfk8MXeobuZutgoudFATBeGno/1xQpXNjDkHT93W7dHIfMd3uvXJh93Xhqhcb
	srqaRP/OMsyEJHvyduG3qu8s4dKy6lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732531196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6KZQGGboR1jU1WlTkMsW24bcGWVCT37J1TXj+3zjC5w=;
	b=dW3qv35qDx5lCzoej7tE3CloPgq6X7N+n3w3DMwDkZryXlpwemBS+bNyt7Zvc3jQVN+Dgr
	9hohpP3YnTAdIQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C16B137D4;
	Mon, 25 Nov 2024 10:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lNMuJPxTRGc0egAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 25 Nov 2024 10:39:56 +0000
Message-ID: <496c1351-3a74-4dc5-8cb9-bf4749378b1c@suse.de>
Date: Mon, 25 Nov 2024 11:39:56 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/cirrus: Use virtual encoder and connector types
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: airlied@redhat.com, kraxel@redhat.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20241029143928.208349-1-tzimmermann@suse.de>
 <20241029143928.208349-2-tzimmermann@suse.de>
 <y74662j6zqvocvpa3zbig5owhqu2o43xdrwkeswgwd5mak2cx7@esgliauvzkh5>
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
In-Reply-To: <y74662j6zqvocvpa3zbig5owhqu2o43xdrwkeswgwd5mak2cx7@esgliauvzkh5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi


Am 23.11.24 um 17:28 schrieb Dmitry Baryshkov:
> On Tue, Oct 29, 2024 at 03:34:23PM +0100, Thomas Zimmermann wrote:
>> The cirrus driver only works on emulated Cirrus hardware. Use the
>> correct types for encoder and connector.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/tiny/cirrus.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
>> index f06a2be71f60..0231bdf94b8a 100644
>> --- a/drivers/gpu/drm/tiny/cirrus.c
>> +++ b/drivers/gpu/drm/tiny/cirrus.c
>> @@ -587,14 +587,14 @@ static int cirrus_pipe_init(struct cirrus_device *cirrus)
>>   
>>   	encoder = &cirrus->encoder;
>>   	ret = drm_encoder_init(dev, encoder, &cirrus_encoder_funcs,
>> -			       DRM_MODE_ENCODER_DAC, NULL);
>> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>>   	if (ret)
>>   		return ret;
>>   	encoder->possible_crtcs = drm_crtc_mask(crtc);
>>   
>>   	connector = &cirrus->connector;
>>   	ret = drm_connector_init(dev, connector, &cirrus_connector_funcs,
>> -				 DRM_MODE_CONNECTOR_VGA);
>> +				 DRM_MODE_CONNECTOR_VIRTUAL);
> This will also remove the EDID property from this connector. I'm not
> sore if that is an expected behaviour or not.

Indeed. That's a positive side effect IMHO. The cirrus emulation nor 
driver provides an EDID. By removing the property, we stop pretending 
that there could be one. I'll mention this in the changelog before 
committing.

Best regards
Thomas

>
>>   	if (ret)
>>   		return ret;
>>   	drm_connector_helper_add(connector, &cirrus_connector_helper_funcs);
>> -- 
>> 2.46.0
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

