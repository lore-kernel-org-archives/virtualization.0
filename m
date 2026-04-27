Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B93559DF
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279599; cv=none; b=fxkqZMY1O6jStE4qs8Sy80Tflapo9nHrJAiiBU/70Zc3/0rS8eQusdL9zSYom3vwkqk1Ux4kyMQ/0ksi2nywQxlzhaJ173XpAH+rpIhwusTdJo313rUYjhbdnuENqlyCI/vg21wA0L3y41SsqGOdawCM7UOU03h6qd9qH/d7tRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279599; c=relaxed/simple;
	bh=BMvt59EtHm8JPFmOATtmckCMLGa5GXi14SvN/NL7Doc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK1s7vS/CnVAmieD8mqVfFj2vYbHOdyWIOZSEnCWTbO7qKuq6G5yCjMdzdRXGRkvfmvFkYjLqdoiqO+4TlZFSLpnSCa+xGnMv8tXM4jX+hDt/wcpMqMU7yKst5l9ULH9chdquJEbt9oAUwxSzbmNVpIa5zLP0AjhsTlAvMgVvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TiaoGW5K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nRdnY5/8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7A8AdDe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xgm3Fxdr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TiaoGW5K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nRdnY5/8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7A8AdDe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xgm3Fxdr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E21A66A90F;
	Mon, 27 Apr 2026 08:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777279596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aT3bWaGty6roAN3aTDjYZz5fOesnLsc8KYSwHlB4jZg=;
	b=TiaoGW5KIpGCK3dJqimJyTZC8+hpBK1WBR+6YmRRPqTMMnIih8sy2nksyEEFYsyVtIUa9H
	jFCyeJKTVHPiqXk6BMdr5kgSk2E2xQVS/0nqPxT9v3qetqyE+/0WHBqd4WSE0tgStHnnoY
	V5aKx3pGP4WR/8BGPAkx43n5wpAoj88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777279596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aT3bWaGty6roAN3aTDjYZz5fOesnLsc8KYSwHlB4jZg=;
	b=nRdnY5/8BqzGi0nxIxVIBhaI9l1K9192rtVjLTvLbK+8m/3buXpjO1uGtw2pEIIhEl+T46
	vDyEzj/1qmPJHgCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k7A8AdDe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xgm3Fxdr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777279595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aT3bWaGty6roAN3aTDjYZz5fOesnLsc8KYSwHlB4jZg=;
	b=k7A8AdDexuwX0UQgFOAVYmGJUqIpDceiDd2+9Vgoj0Q2RBuMZbHkXH+ctF95G1Bx73hy0U
	xBgZptRM56YQ3HR1Ww7YqGmEbOEQhvRyT92siZcL4Ot4bsBQdUy8pAIc2Ohpv1fv/Id3gy
	auGKeWTudXFR0iohnjhuOjSfYFJhnIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777279595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aT3bWaGty6roAN3aTDjYZz5fOesnLsc8KYSwHlB4jZg=;
	b=xgm3Fxdrf62yCdFEYvEdv0vXp3PBMt54R4Wj3FmhPzDwPcuZBl+/K+0twOBEKFplNKBqh1
	py5d3ytA4gy51eBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82487593B0;
	Mon, 27 Apr 2026 08:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ybZXHmsi72kvLAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 08:46:35 +0000
Message-ID: <cd4ef74f-13db-4b4f-8f72-1b675dd19095@suse.de>
Date: Mon, 27 Apr 2026 10:46:35 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/qxl: Fix missing KMS poll cleanup
To: Myeonghun Pak <mhun512@gmail.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260424112543.57819-1-mhun512@gmail.com>
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
In-Reply-To: <20260424112543.57819-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.linux.dev,lists.freedesktop.org,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E21A66A90F

Thanks for your patch.

Am 24.04.26 um 13:25 schrieb Myeonghun Pak:
> drm_kms_helper_poll_init() initializes the output polling work and
> enables polling for the DRM device. qxl enables polling before calling
> drm_dev_register(), but the drm_dev_register() failure path tears down
> the modeset and device state without disabling the polling helper.
>
> The remove path also unregisters and shuts down the DRM device without
> first disabling the polling helper. Add matching drm_kms_helper_poll_fini()
> calls in both paths so the delayed polling work is cancelled before qxl
> tears down the associated modeset/device state.
>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Fixes: 5ff91e442652 ("qxl: use drm helper hotplug support")
Cc: <stable@vger.kernel.org> # v3.11+


> ---
>   drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 2bbb1168a3..1e6a2392d7 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -118,12 +118,13 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	/* Complete initialization. */
>   	ret = drm_dev_register(&qdev->ddev, ent->driver_data);
>   	if (ret)
> -		goto modeset_cleanup;
> +		goto poll_fini;
>   
>   	drm_client_setup(&qdev->ddev, NULL);
>   	return 0;
>   
> -modeset_cleanup:
> +poll_fini:
> +	drm_kms_helper_poll_fini(&qdev->ddev);
>   	qxl_modeset_fini(qdev);
>   unload:
>   	qxl_device_fini(qdev);
> @@ -154,6 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)
>   {
>   	struct drm_device *dev = pci_get_drvdata(pdev);
>   
> +	drm_kms_helper_poll_fini(dev);
>   	drm_dev_unregister(dev);
>   	drm_atomic_helper_shutdown(dev);
>   	if (pci_is_vga(pdev) && pdev->revision < 5)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


