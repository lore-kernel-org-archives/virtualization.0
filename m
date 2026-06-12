Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB73D5C3C
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266226; cv=none; b=AZiO7spa4Zu5C0/ayDBdQSHTEIvF3tJKuR+KwK0LiJVY3JKE1AEbLmO8fqigcHWSOYO4jNxmoGCFyR8GZ/hQk8UiNJmQH4SefmFmocphUaichzlSBmuqDbTFs72OXMeWE6m/8AHbUecliiRxXXoP9geZbvH9EByzbfqKCBOXrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266226; c=relaxed/simple;
	bh=crDnTLS2Z46Avke1kmjZmdVjH3Vz568mm0rAzHYT3E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wbaw2IJOp2KHqUQiiq4OzgvPR3CS7GflbLM6EDjwqy3a+KmTkBOxOUFWoOZ7OZSpD7n828te6op6Z5dZSsQ2cZtTDBnQ1umCVssDz4+0+opCmiZm0EOoX2Fg5use9z8ZvbjKZ4tiJ+29G/5M0cAg5egLA/+/Iy/JUDjlDu05aQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LGV+EzUI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGG/IGuR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CRXdyTX7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=szETWPRS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LGV+EzUI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGG/IGuR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CRXdyTX7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="szETWPRS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBE25716C5;
	Fri, 12 Jun 2026 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781266221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=295xzW8JjQNETsFZM+BNIV6/yGBLuUn9J0NUYA2oEks=;
	b=LGV+EzUIpSp15lRgCjnK4uNJh9OsBYB7uXnEIp3733Heksp6aGlywRv2rq1QSPQVeyp1yC
	a7LsvutXAhbgtT5M6BkYiaGE5s2QJ4hhTobkUJFzba3fl1q6hySBA2Vke9gXysnF1YEalb
	X6xwPMe48XWxkrBUIOH9+gbLBU6zc/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781266221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=295xzW8JjQNETsFZM+BNIV6/yGBLuUn9J0NUYA2oEks=;
	b=IGG/IGuRqz1AwbCCd6ERGTfl3VFPuLpr1gZw7IDGPunoqSp0gKlRztWl2VG4tul2KrR0Pr
	ecXFaJ9c1+xXeEDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CRXdyTX7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=szETWPRS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781266219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=295xzW8JjQNETsFZM+BNIV6/yGBLuUn9J0NUYA2oEks=;
	b=CRXdyTX79gtueA2MCjPna9AzF+2+kDkqMRl6P6cN8io7VXu2i1WibNhVwpLQHYxkndhzkV
	Jb9H5CCun7sAHXSxUbCGKm6X6G50P/Go4uxGI64uktmrpvU4K/ChaY/kbARah/8z/1/Tts
	b/tslS4+bj09/ev/58+HIEg2bYNP1is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781266219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=295xzW8JjQNETsFZM+BNIV6/yGBLuUn9J0NUYA2oEks=;
	b=szETWPRSfTCZjWHRjdTpUcf8gO6Z9xJnjajRbNnjkY1OwvTYqXqZgBGvrCoJ43Gpqak9Qe
	DNWyZHZXCundEyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E51D9779A7;
	Fri, 12 Jun 2026 12:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6VmGNir3K2p1HQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 12 Jun 2026 12:10:18 +0000
Message-ID: <b13678d8-1159-457a-bcab-ade06bea0cf8@suse.de>
Date: Fri, 12 Jun 2026 14:10:17 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
References: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
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
In-Reply-To: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[baylibre.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[baylibre.com,gmail.com,loongson.cn,kernel.org,aosc.io,xry111.site,iscas.ac.cn,redhat.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,suse.de:email,suse.de:dkim,suse.de:mid,baylibre.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CBE25716C5
X-Spam-Score: -3.01

Hi

Am 04.05.26 um 17:05 schrieb Uwe Kleine-König (The Capable Hub):
> The .driver_data member of the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using the PCI_DEVICE macro and named initializers is more
> explicit and thus easier to parse. Also skip explicit assignments of 0
> (which the compiler then takes care of).
>
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I'll merge the patch into drm-misc-next.

Best regards
Thomas

> ---
> Hello,
>
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> and that requires named initializers. But IMHO it's also a nice cleanup
> on its own.
>
> The anonymous union will allow changes like the following:
>
> -	{ PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) &psb_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x8108), .driver_data_ptr = &psb_chip_ops },
>
> (together with the respective change in the code when the value is
> used). This gets rid of a bunch of casts and thus slightly improves
> type safety.
>
> Best regards
> Uwe
>
>   drivers/gpu/drm/gma500/psb_drv.c      | 56 +++++++++++++--------------
>   drivers/gpu/drm/loongson/lsdc_drv.c   |  4 +-
>   drivers/gpu/drm/mgag200/mgag200_drv.c | 24 ++++++------
>   drivers/gpu/drm/qxl/qxl_drv.c         | 15 ++++---
>   4 files changed, 52 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 005ab7f5355f..039da26ef24d 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -56,36 +56,36 @@ static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
>    */
>   static const struct pci_device_id pciidlist[] = {
>   	/* Poulsbo */
> -	{ 0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_ops },
> -	{ 0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) &psb_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x8109), .driver_data = (long) &psb_chip_ops },
>   	/* Oak Trail */
> -	{ 0x8086, 0x4100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> -	{ 0x8086, 0x4101, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> -	{ 0x8086, 0x4102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> -	{ 0x8086, 0x4103, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> -	{ 0x8086, 0x4104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> -	{ 0x8086, 0x4105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> -	{ 0x8086, 0x4106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> -	{ 0x8086, 0x4107, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> -	{ 0x8086, 0x4108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4100), .driver_data = (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4101), .driver_data = (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4102), .driver_data = (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4103), .driver_data = (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4104), .driver_data = (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4105), .driver_data = (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4106), .driver_data = (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4107), .driver_data = (long) &oaktrail_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x4108), .driver_data = (long) &oaktrail_chip_ops },
>   	/* Cedar Trail */
> -	{ 0x8086, 0x0be0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0be9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0bea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0beb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0bec, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0bed, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0bee, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0x8086, 0x0bef, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
> -	{ 0, }
> +	{ PCI_DEVICE(0x8086, 0x0be0), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be1), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be2), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be3), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be4), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be5), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be6), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be7), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be8), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0be9), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0bea), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0beb), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0bec), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0bed), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0bee), .driver_data = (long) &cdv_chip_ops },
> +	{ PCI_DEVICE(0x8086, 0x0bef), .driver_data = (long) &cdv_chip_ops },
> +	{ }
>   };
>   MODULE_DEVICE_TABLE(pci, pciidlist);
>   
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
> index 1ece1ea42f78..f9f7271ddbff 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -444,8 +444,8 @@ static const struct dev_pm_ops lsdc_pm_ops = {
>   };
>   
>   static const struct pci_device_id lsdc_pciid_list[] = {
> -	{PCI_VDEVICE(LOONGSON, 0x7a06), CHIP_LS7A1000},
> -	{PCI_VDEVICE(LOONGSON, 0x7a36), CHIP_LS7A2000},
> +	{ PCI_VDEVICE(LOONGSON, 0x7a06), .driver_data = CHIP_LS7A1000 },
> +	{ PCI_VDEVICE(LOONGSON, 0x7a36), .driver_data = CHIP_LS7A2000 },
>   	{ }
>   };
>   
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
> index a32be27c39e8..8ad4ddb60ee6 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -205,18 +205,18 @@ int mgag200_device_init(struct mga_device *mdev,
>    */
>   
>   static const struct pci_device_id mgag200_pciidlist[] = {
> -	{ PCI_VENDOR_ID_MATROX, 0x520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_PCI },
> -	{ PCI_VENDOR_ID_MATROX, 0x521, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_AGP },
> -	{ PCI_VENDOR_ID_MATROX, 0x522, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_SE_A },
> -	{ PCI_VENDOR_ID_MATROX, 0x524, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_SE_B },
> -	{ PCI_VENDOR_ID_MATROX, 0x530, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EV },
> -	{ PCI_VENDOR_ID_MATROX, 0x532, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_WB },
> -	{ PCI_VENDOR_ID_MATROX, 0x533, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH },
> -	{ PCI_VENDOR_ID_MATROX, 0x534, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_ER },
> -	{ PCI_VENDOR_ID_MATROX, 0x536, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EW3 },
> -	{ PCI_VENDOR_ID_MATROX, 0x538, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH3 },
> -	{ PCI_VENDOR_ID_MATROX, 0x53a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH5 },
> -	{0,}
> +	{ PCI_VDEVICE(MATROX, 0x0520), .driver_data = G200_PCI },
> +	{ PCI_VDEVICE(MATROX, 0x0521), .driver_data = G200_AGP },
> +	{ PCI_VDEVICE(MATROX, 0x0522), .driver_data = G200_SE_A },
> +	{ PCI_VDEVICE(MATROX, 0x0524), .driver_data = G200_SE_B },
> +	{ PCI_VDEVICE(MATROX, 0x0530), .driver_data = G200_EV },
> +	{ PCI_VDEVICE(MATROX, 0x0532), .driver_data = G200_WB },
> +	{ PCI_VDEVICE(MATROX, 0x0533), .driver_data = G200_EH },
> +	{ PCI_VDEVICE(MATROX, 0x0534), .driver_data = G200_ER },
> +	{ PCI_VDEVICE(MATROX, 0x0536), .driver_data = G200_EW3 },
> +	{ PCI_VDEVICE(MATROX, 0x0538), .driver_data = G200_EH3 },
> +	{ PCI_VDEVICE(MATROX, 0x053a), .driver_data = G200_EH5 },
> +	{ }
>   };
>   
>   MODULE_DEVICE_TABLE(pci, mgag200_pciidlist);
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 2bbb1168a3ff..6c3c309b8e4d 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -50,11 +50,16 @@
>   #include "qxl_object.h"
>   
>   static const struct pci_device_id pciidlist[] = {
> -	{ 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8,
> -	  0xffff00, 0 },
> -	{ 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_OTHER << 8,
> -	  0xffff00, 0 },
> -	{ 0, 0, 0 },
> +	{
> +		PCI_DEVICE(0x1b36, 0x0100),
> +		.class = PCI_CLASS_DISPLAY_VGA << 8,
> +		.class_mask = 0xffff00
> +	}, {
> +		PCI_DEVICE(0x1b36, 0x0100),
> +		.class = PCI_CLASS_DISPLAY_OTHER << 8,
> +		.class_mask = 0xffff00
> +	},
> +	{ },
>   };
>   MODULE_DEVICE_TABLE(pci, pciidlist);
>   
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


