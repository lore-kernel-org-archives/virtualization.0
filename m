Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9846D0A8
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836499; cv=none; b=jdIl5N4Z3jU6vXgqlaWGU9IONNgcQnfROqV+jEMHrC8OsS9Be8greziEki2th3xHqlYLspimlyvJWKjM7vfEdZb6CEUjC+vSXLN1WKR7ktDvVva5r2AHklzoZ2k3RX/rNNhLlMaHlAZpnZwOCkh6bnvpHv3yQvFXSrvq3Ohi294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836499; c=relaxed/simple;
	bh=UzHdqiNq8jEC4E7lvvyncOiwmnK8IKzUOir0go+BhtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQVmy/Qsp+bx64bej/U62EVgyLysHaO+c0FPheEdQoSY8OW6JAzmXCh9rQMSgK3kk0ng2gCqZJKxGXyTuiyu6LxJZsrPOSM4epDPXw+JTfnnM5yFQO/eZm10DWRMKDPIWjnBnykEbqt+0kweZHVFV4H5sE8qNGU9aKMFgbaRWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xmw7i+fN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7G5PfiZC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lh3TKrC1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bSdW+A1k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xmw7i+fN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7G5PfiZC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lh3TKrC1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bSdW+A1k"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3ABE1FCE0;
	Thu,  1 Oct 2026 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790836491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4D94+aD2lxb4ojHdj7SPcqQJjAlLd/kctVG9KVw8hcU=;
	b=Xmw7i+fNdkhXPieHqMW3SiMl/2GZyxhoXHY9k75gBULA7euGjBPMFspQjmDVzZR6zPmbij
	yOup6mBJtOc/sKzb1ttXUcYhloinw1uBAJxPar5tWl1YxPZ018Y4DCXJQ3dyQwLFxQ2708
	eHimu0oobSpymXCt6lel++SzdX7iBQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790836491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4D94+aD2lxb4ojHdj7SPcqQJjAlLd/kctVG9KVw8hcU=;
	b=7G5PfiZChxZB9Lcy+U48Xb31Q3PaicXw27oyl5HxB4TD67EWsf1KBo/8UXlJt+i5K+/hSO
	fcB08A4gm27g7wDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790836487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4D94+aD2lxb4ojHdj7SPcqQJjAlLd/kctVG9KVw8hcU=;
	b=Lh3TKrC1z/6mi1+I9rWuCMDxGGfF3RPTRw9ARdODh3LFgW4BNFKZcktB7CfEz5ZJsKZ37b
	wwL/kEu4x9ksOA/Lkw2+48bN3BvqL3ElC4G/Zrcrdd/RE4SCoHN2DkhiA/rTak5ZX9VG99
	5tOEXK4sxvRriXSS8bIlEn2ii4SStNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790836487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4D94+aD2lxb4ojHdj7SPcqQJjAlLd/kctVG9KVw8hcU=;
	b=bSdW+A1kvm1x0HLqwpblX0QPwiPXmJS2+CV2etU1lK515XKj65kUKezMjnlkpkt33u6vld
	LVnFnPaS1seskOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42FF11368E;
	Thu,  1 Oct 2026 06:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4sAxBgf/vWoeawAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 01 Oct 2026 06:34:47 +0000
Message-ID: <82a6538d-a401-403b-b10d-0abae6ca5e8a@suse.de>
Date: Thu, 1 Oct 2026 08:34:46 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/qxl: return -ENODEV for unsupported revisions
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alon Levy <alevy@redhat.com>,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260930222214.69443-1-matheus.aalmeida@inf.ufrgs.br>
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
In-Reply-To: <20260930222214.69443-1-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,lists.linux.dev,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO

Hi

Am 01.10.26 um 00:22 schrieb Matheus Alves de Almeida:
> The qxl driver currently returns -EINVAL when the emulated qxl revision
> is too old. This is not a driver initialization failure but rather a
> match rejection, which should return -ENODEV.
>
> Change the value returned when the qxl revision is below 4 to -ENODEV.
> Switch the xf86-video-qxl suggestion log to be info level, as this is
> not an error.
>
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>   drivers/gpu/drm/qxl/qxl_drv.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 97df9d3d6..35b83b1bb 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -82,9 +82,9 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	int ret;
>   
>   	if (pdev->revision < 4) {
> -		DRM_ERROR("qxl too old, doesn't support client_monitors_config,"
> -			  " use xf86-video-qxl in user mode");
> -		return -EINVAL; /* TODO: ENODEV ? */
> +		dev_info(&pdev->dev,
> +			 "qxl too old, doesn't support client_monitors_config, use xf86-video-qxl in user mode\n");

This call should become dev_err() instead.

Best regards
Thomas

> +		return -ENODEV;
>   	}
>   
>   	qdev = devm_drm_dev_alloc(&pdev->dev, &qxl_driver,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


