Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1903CAE84
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037160; cv=none; b=N9SNJwD+AZvQyT8YjMGV0ebiCyNu9uZJL1E111S6kTohRd8rw1glXACvDvDIzmzGqqzsTcj6OAceESIKloRLUIosiJiGZzejrhYaNCBNyi6VLEYckeqgkRFNYKx6SKcXZ2KE5gG3m0kYhmzFeKA0K2X7hGnefq6QvE71ckrae3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037160; c=relaxed/simple;
	bh=okaP1QHWhxsOEkL1jNs5dFzjpmTXkHbWuPKNePO8FOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxApox/ppJ5OlQVoLKM76oP77R4EQsdUpW4FDYg7Dew9T4mnidUiX+G+fkasMaAN15VB2GUl7gAbcrbJzgS3wyvJG/fJeLdB4KlsxMoVj+mIfZE/x+qH5ivVcV5/ciZ2YTRI44FyQFPVEwuUWjLD99q04NcDA4Iuf4Gxd2Q+1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JuW5JPhU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rUmLqfuc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KsCDSP1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UiYJwB1y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JuW5JPhU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rUmLqfuc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KsCDSP1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UiYJwB1y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3CAB6A843;
	Fri, 24 Apr 2026 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777037157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hXzxoW/FhdDOvsaLZ/AVSa7KkcUrVFugO8vdPWzUuwM=;
	b=JuW5JPhUfo38juPBMiWU/1o5pbzOQ5kuMrwfHnooT1ebjL1L7+A102VwPaoSVcyWWJQXll
	NVuLhXSB5LDe/SyLiayZcQZ+SZwIED8mIdHGb6lSVYSOgFI0x3jau/8JTzaLPitlhCgvX/
	5KOz2Tsh1gRhdNeKquqzY0Bfso+fe3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777037157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hXzxoW/FhdDOvsaLZ/AVSa7KkcUrVFugO8vdPWzUuwM=;
	b=rUmLqfucZbSPEl2XKmLsknTYR+uXMBCtvDduDZ9Qmsclix1lawz+vFuhzcdEExZ0oSOsh9
	qCqXop9wkLYv24Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KsCDSP1f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UiYJwB1y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777037156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hXzxoW/FhdDOvsaLZ/AVSa7KkcUrVFugO8vdPWzUuwM=;
	b=KsCDSP1fgUBkbw3MI0MMybI8pwTEfq9B1a1QlEg8zN8mA3L50U15YckjRSpvF5wQ74yC9C
	Mao6ssk/pZ0CjIlfU0cDq82db2v9lkN4LkTi2JQlKt7OYBCOkYHowS5OfQQ0iMnGXT0WAW
	Zz2AFJn7QVsehrTCekmBYFiqK39VnWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777037156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hXzxoW/FhdDOvsaLZ/AVSa7KkcUrVFugO8vdPWzUuwM=;
	b=UiYJwB1yy7fpr1w9GlcLgzm4tw1dX8lqWQKGH41E+y7LJ48GfRUT3tCUNTPLTgoqllkqP2
	/0X+YvSJxNsa98Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EA2F593A4;
	Fri, 24 Apr 2026 13:25:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cP4+JWRv62lGMwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 24 Apr 2026 13:25:56 +0000
Message-ID: <43bbfbcf-4a8d-4039-9ebf-24672b7e6d0a@suse.de>
Date: Fri, 24 Apr 2026 15:25:56 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bochs: Drop manual put on probe error path
To: Myeonghun Pak <mhun512@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260424123506.32275-1-mhun512@gmail.com>
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
In-Reply-To: <20260424123506.32275-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,linux.intel.com,kernel.org,ffwll.ch];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E3CAB6A843

Hi,

please add fixes tags to all these patches you're sending. You also need 
to CC stable so that they can be backported easily. Also list the AI 
you're using to find and create these patches.

Best regards
Thomas

Am 24.04.26 um 14:34 schrieb Myeonghun Pak:
> bochs_pci_probe() allocates the DRM device with devm_drm_dev_alloc(),
> which registers a devres action to drop the initial DRM device reference
> on driver detach or probe failure.
>
> The error path currently calls drm_dev_put() manually. If probe then
> returns an error, devres will run the registered release action and put
> the same device again, after the first put may already have released it.
>
> Return the probe error directly and let devres own the final put.
>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/gpu/drm/tiny/bochs.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 222e4ae1ab..5d8dc5efec 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
>   
>   	ret = pcim_enable_device(pdev);
>   	if (ret)
> -		goto err_free_dev;
> +		return ret;
>   
>   	pci_set_drvdata(pdev, dev);
>   
>   	ret = bochs_load(bochs);
>   	if (ret)
> -		goto err_free_dev;
> +		return ret;
>   
>   	ret = drm_dev_register(dev, 0);
>   	if (ret)
> -		goto err_free_dev;
> +		return ret;
>   
>   	drm_client_setup(dev, NULL);
>   
>   	return ret;
> -
> -err_free_dev:
> -	drm_dev_put(dev);
> -	return ret;
>   }
>   
>   static void bochs_pci_remove(struct pci_dev *pdev)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


