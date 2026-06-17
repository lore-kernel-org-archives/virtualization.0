Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156953BCD0A
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687499; cv=none; b=C4tG+iQpjxuav+BVje/oYvT01+wupOoWQ7ntmsY8Tb4/2sEKN7S/4VvX9RaQvd3qrzHbAYiU3Bv7yxxIezD4ZtZ4MEV/OpJ1Vthl/3FSUmcH2RgYUvKadTrZGkJxxWd5TGGX0WGXiksxe1mfRJqXx7gdK/UpLRyWaFIHRdm/gn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687499; c=relaxed/simple;
	bh=UNb7LWtwqfoJ1mjwqqnXZONFWVBxHEeWJVmeYTH9EgI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FDKjSeBJYnI8u6Zg4CN2RD7oMr/FDh6R/dqNtdT6H6IufhDiv+POmOtfqcHG75Z/8mI/iZKnmH/ls7wmwgRDkNo5+GV3a7hurVpHhXxu2Unc8YRN5ncbGxZ6MwsvQlfoOzjl1G4GBlvcetrh7E/MN3xggJjmzgj4gruuTbVVOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xlUD3X3C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6K5B6Ytl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xlUD3X3C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6K5B6Ytl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xlUD3X3C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6K5B6Ytl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xlUD3X3C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6K5B6Ytl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3708F75D65;
	Wed, 17 Jun 2026 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781687493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kyVVw7kLx/njqL6Kv647VkU2YvGvQh/a6dysWC7xAZA=;
	b=xlUD3X3Cxx+xZzEPCbb5xPXFcEijFzwl0O3LNvj3IrLabxy8d0jZxS4DKpxp/Y82kMAeci
	XYB6Rr9ydnO5Yr6mZZqm2qGniDjwhGnJcNtGtUcKOHsL8pmv85IL3RHgvT7ogEdg4n4p6X
	m3/4Qsdn3yf9Bu3MRSGuMOpIpa62f1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781687493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kyVVw7kLx/njqL6Kv647VkU2YvGvQh/a6dysWC7xAZA=;
	b=6K5B6YtlTHaKbHF1R7lnnzVc24ksWW/8ycZVST47+Whd+Tloif2zpSNoTz5ZgTQabDa5WA
	YgmjI0cRW4R1rNCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781687493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kyVVw7kLx/njqL6Kv647VkU2YvGvQh/a6dysWC7xAZA=;
	b=xlUD3X3Cxx+xZzEPCbb5xPXFcEijFzwl0O3LNvj3IrLabxy8d0jZxS4DKpxp/Y82kMAeci
	XYB6Rr9ydnO5Yr6mZZqm2qGniDjwhGnJcNtGtUcKOHsL8pmv85IL3RHgvT7ogEdg4n4p6X
	m3/4Qsdn3yf9Bu3MRSGuMOpIpa62f1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781687493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kyVVw7kLx/njqL6Kv647VkU2YvGvQh/a6dysWC7xAZA=;
	b=6K5B6YtlTHaKbHF1R7lnnzVc24ksWW/8ycZVST47+Whd+Tloif2zpSNoTz5ZgTQabDa5WA
	YgmjI0cRW4R1rNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8303779A8;
	Wed, 17 Jun 2026 09:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SQLUJ8RkMmriVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jun 2026 09:11:32 +0000
Message-ID: <bc89deb2-2a2e-41c5-8cd9-28b794020972@suse.de>
Date: Wed, 17 Jun 2026 11:11:32 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
From: Thomas Zimmermann <tzimmermann@suse.de>
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
 <b13678d8-1159-457a-bcab-ade06bea0cf8@suse.de>
Content-Language: en-US
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
In-Reply-To: <b13678d8-1159-457a-bcab-ade06bea0cf8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,gmail.com,loongson.cn,kernel.org,aosc.io,xry111.site,iscas.ac.cn,redhat.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	FREEMAIL_TO(0.00)[baylibre.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -2.80



Am 12.06.26 um 14:10 schrieb Thomas Zimmermann:
> Hi
>
> Am 04.05.26 um 17:05 schrieb Uwe Kleine-König (The Capable Hub):
>> The .driver_data member of the various struct pci_device_id arrays were
>> initialized by list expressions. This isn't easily readable if you're
>> not into PCI. Using the PCI_DEVICE macro and named initializers is more
>> explicit and thus easier to parse. Also skip explicit assignments of 0
>> (which the compiler then takes care of).
>>
>> This change doesn't introduce changes to the compiled pci_device_id
>> arrays. Tested on x86 and arm64.
>>
>> Signed-off-by: Uwe Kleine-König (The Capable Hub) 
>> <u.kleine-koenig@baylibre.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> I'll merge the patch into drm-misc-next.

Merged with a minor change to coding style in gma500.

>
> Best regards
> Thomas
>
>> ---
>> Hello,
>>
>> The secret plan is to make struct pci_device_id::driver_data an
>> anonymous union (similar to
>> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/) 
>>
>> and that requires named initializers. But IMHO it's also a nice cleanup
>> on its own.
>>
>> The anonymous union will allow changes like the following:
>>
>> -    { PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) 
>> &psb_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x8108), .driver_data_ptr = &psb_chip_ops },
>>
>> (together with the respective change in the code when the value is
>> used). This gets rid of a bunch of casts and thus slightly improves
>> type safety.
>>
>> Best regards
>> Uwe
>>
>>   drivers/gpu/drm/gma500/psb_drv.c      | 56 +++++++++++++--------------
>>   drivers/gpu/drm/loongson/lsdc_drv.c   |  4 +-
>>   drivers/gpu/drm/mgag200/mgag200_drv.c | 24 ++++++------
>>   drivers/gpu/drm/qxl/qxl_drv.c         | 15 ++++---
>>   4 files changed, 52 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/gma500/psb_drv.c 
>> b/drivers/gpu/drm/gma500/psb_drv.c
>> index 005ab7f5355f..039da26ef24d 100644
>> --- a/drivers/gpu/drm/gma500/psb_drv.c
>> +++ b/drivers/gpu/drm/gma500/psb_drv.c
>> @@ -56,36 +56,36 @@ static int psb_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *ent);
>>    */
>>   static const struct pci_device_id pciidlist[] = {
>>       /* Poulsbo */
>> -    { 0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &psb_chip_ops },
>> -    { 0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &psb_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) 
>> &psb_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x8109), .driver_data = (long) 
>> &psb_chip_ops },
>>       /* Oak Trail */
>> -    { 0x8086, 0x4100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> -    { 0x8086, 0x4101, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> -    { 0x8086, 0x4102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> -    { 0x8086, 0x4103, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> -    { 0x8086, 0x4104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> -    { 0x8086, 0x4105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> -    { 0x8086, 0x4106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> -    { 0x8086, 0x4107, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> -    { 0x8086, 0x4108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4100), .driver_data = (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4101), .driver_data = (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4102), .driver_data = (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4103), .driver_data = (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4104), .driver_data = (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4105), .driver_data = (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4106), .driver_data = (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4107), .driver_data = (long) 
>> &oaktrail_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x4108), .driver_data = (long) 
>> &oaktrail_chip_ops },
>>       /* Cedar Trail */
>> -    { 0x8086, 0x0be0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0be9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0bea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0beb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0bec, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0bed, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0bee, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0x8086, 0x0bef, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) 
>> &cdv_chip_ops },
>> -    { 0, }
>> +    { PCI_DEVICE(0x8086, 0x0be0), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be1), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be2), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be3), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be4), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be5), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be6), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be7), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be8), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0be9), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0bea), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0beb), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0bec), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0bed), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0bee), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { PCI_DEVICE(0x8086, 0x0bef), .driver_data = (long) 
>> &cdv_chip_ops },
>> +    { }
>>   };
>>   MODULE_DEVICE_TABLE(pci, pciidlist);
>>   diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c 
>> b/drivers/gpu/drm/loongson/lsdc_drv.c
>> index 1ece1ea42f78..f9f7271ddbff 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
>> @@ -444,8 +444,8 @@ static const struct dev_pm_ops lsdc_pm_ops = {
>>   };
>>     static const struct pci_device_id lsdc_pciid_list[] = {
>> -    {PCI_VDEVICE(LOONGSON, 0x7a06), CHIP_LS7A1000},
>> -    {PCI_VDEVICE(LOONGSON, 0x7a36), CHIP_LS7A2000},
>> +    { PCI_VDEVICE(LOONGSON, 0x7a06), .driver_data = CHIP_LS7A1000 },
>> +    { PCI_VDEVICE(LOONGSON, 0x7a36), .driver_data = CHIP_LS7A2000 },
>>       { }
>>   };
>>   diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c 
>> b/drivers/gpu/drm/mgag200/mgag200_drv.c
>> index a32be27c39e8..8ad4ddb60ee6 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
>> @@ -205,18 +205,18 @@ int mgag200_device_init(struct mga_device *mdev,
>>    */
>>     static const struct pci_device_id mgag200_pciidlist[] = {
>> -    { PCI_VENDOR_ID_MATROX, 0x520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_PCI },
>> -    { PCI_VENDOR_ID_MATROX, 0x521, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_AGP },
>> -    { PCI_VENDOR_ID_MATROX, 0x522, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_SE_A },
>> -    { PCI_VENDOR_ID_MATROX, 0x524, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_SE_B },
>> -    { PCI_VENDOR_ID_MATROX, 0x530, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_EV },
>> -    { PCI_VENDOR_ID_MATROX, 0x532, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_WB },
>> -    { PCI_VENDOR_ID_MATROX, 0x533, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_EH },
>> -    { PCI_VENDOR_ID_MATROX, 0x534, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_ER },
>> -    { PCI_VENDOR_ID_MATROX, 0x536, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_EW3 },
>> -    { PCI_VENDOR_ID_MATROX, 0x538, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_EH3 },
>> -    { PCI_VENDOR_ID_MATROX, 0x53a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
>> G200_EH5 },
>> -    {0,}
>> +    { PCI_VDEVICE(MATROX, 0x0520), .driver_data = G200_PCI },
>> +    { PCI_VDEVICE(MATROX, 0x0521), .driver_data = G200_AGP },
>> +    { PCI_VDEVICE(MATROX, 0x0522), .driver_data = G200_SE_A },
>> +    { PCI_VDEVICE(MATROX, 0x0524), .driver_data = G200_SE_B },
>> +    { PCI_VDEVICE(MATROX, 0x0530), .driver_data = G200_EV },
>> +    { PCI_VDEVICE(MATROX, 0x0532), .driver_data = G200_WB },
>> +    { PCI_VDEVICE(MATROX, 0x0533), .driver_data = G200_EH },
>> +    { PCI_VDEVICE(MATROX, 0x0534), .driver_data = G200_ER },
>> +    { PCI_VDEVICE(MATROX, 0x0536), .driver_data = G200_EW3 },
>> +    { PCI_VDEVICE(MATROX, 0x0538), .driver_data = G200_EH3 },
>> +    { PCI_VDEVICE(MATROX, 0x053a), .driver_data = G200_EH5 },
>> +    { }
>>   };
>>     MODULE_DEVICE_TABLE(pci, mgag200_pciidlist);
>> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c 
>> b/drivers/gpu/drm/qxl/qxl_drv.c
>> index 2bbb1168a3ff..6c3c309b8e4d 100644
>> --- a/drivers/gpu/drm/qxl/qxl_drv.c
>> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
>> @@ -50,11 +50,16 @@
>>   #include "qxl_object.h"
>>     static const struct pci_device_id pciidlist[] = {
>> -    { 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA 
>> << 8,
>> -      0xffff00, 0 },
>> -    { 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_OTHER 
>> << 8,
>> -      0xffff00, 0 },
>> -    { 0, 0, 0 },
>> +    {
>> +        PCI_DEVICE(0x1b36, 0x0100),
>> +        .class = PCI_CLASS_DISPLAY_VGA << 8,
>> +        .class_mask = 0xffff00
>> +    }, {
>> +        PCI_DEVICE(0x1b36, 0x0100),
>> +        .class = PCI_CLASS_DISPLAY_OTHER << 8,
>> +        .class_mask = 0xffff00
>> +    },
>> +    { },
>>   };
>>   MODULE_DEVICE_TABLE(pci, pciidlist);
>>
>> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


