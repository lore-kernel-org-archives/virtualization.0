Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF93FA5E6
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419154; cv=none; b=gSXPrq89ANEqUaCpjV9bLBIj/Sh8UPOFki9HyABS7CE1qcuzjGluu+g+oF9LJ6Ps7FtZNT1YF0RAIb/+3j0vqoSivzHbNsKRtf/xoT2FSxzTbgvCdf88Cq/XMtJ7w1GSgj0Wq7l9g3X2QFs/HzEDGypTO9LfwYuEDg/83qQ2x/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419154; c=relaxed/simple;
	bh=LlAMlP+97p642+vTkYe1nur34+sfv5WuTm91cghfWbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERrbJy8qgpGcu/kwcC+LMaX2C17NZll3S3AdTJ+mKhXbjjGGcY3lsGc1tIH3me45VshyE92YzfQ+bICCha7xH2T3lLnObJkFR+rR1zzaSoaNsargR/CSkMsnO1mddpmCbKAN2qgmXIbbRkz2UKSPgEMn0uHxy++5fIIcNbIn9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CdNJUDNb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IViBhly6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nfAbY0OF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Llu4vaO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CdNJUDNb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IViBhly6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nfAbY0OF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Llu4vaO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D7461FDB1;
	Thu,  3 Sep 2026 07:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788419142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gSEKYt2/zjQTKtJUGFCNZFh08qwXo2HshuPbHCVvJ2o=;
	b=CdNJUDNboHBXEvq3NQJwGI5Efovl4zG4tZI0Woyu05bT+466YY/E5Uf2jcNdggCrP0bc3i
	C8qlPx7h67iQHbddH7l5Bzihh1lxiDbVKCHRdS/qt2YeLIy1EagSrYhXPrOBhz4nL72dw0
	/vNiWkvbocvptr7Ctg8gJrj3osJ+Waw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788419142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gSEKYt2/zjQTKtJUGFCNZFh08qwXo2HshuPbHCVvJ2o=;
	b=IViBhly6RiAY015Wd01W+rE8JUPsscTy6pVLuVLIT5LySCLgOTfx3ZD62/cXpJxru6upDf
	nXcieLsQcKraZHDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nfAbY0OF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1Llu4vaO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788419138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gSEKYt2/zjQTKtJUGFCNZFh08qwXo2HshuPbHCVvJ2o=;
	b=nfAbY0OFTAmO1zKGnJ0I76xDrth2wZEQlQ2Hms/EmxiZ/SjcV9DAtvXW3b+JyZcegEE94u
	F6EuQ93zRXZ6r19CwsqI0Tg4QmIn9Joh/S0NGf1XEoF+gdaxbQH405pvSamxawAvDmsMmq
	Dio8VP84nqwDZ427hKFoIhtuCHE1160=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788419138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gSEKYt2/zjQTKtJUGFCNZFh08qwXo2HshuPbHCVvJ2o=;
	b=1Llu4vaOxIlG8RAbNGbxGky8+z+s0E0YTyggnnHlFdpChebVFflFs+NY4jLR2p1wTkEEcs
	+JNiQ7/EtWXiEOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1536136E6;
	Thu,  3 Sep 2026 07:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +gYVNUEcmWp8UwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 03 Sep 2026 07:05:37 +0000
Message-ID: <153a2ba3-0dfc-45a0-ac48-04842da970f3@suse.de>
Date: Thu, 3 Sep 2026 09:05:37 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/ast: create blend mode property on cursor
 plane
To: Qinyun Tan <qinyuntan@linux.alibaba.com>, dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, jfalempe@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
 <20260901083234.1828755-2-qinyuntan@linux.alibaba.com>
 <1f7a2056-825b-4b18-ac60-94f13ee40212@suse.de>
 <15f87b4e-3da8-4ce9-9cde-b4c8cefe1d80@suse.de>
 <8c6ef5d2-1f85-4dad-b426-143d490e1114@linux.alibaba.com>
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
In-Reply-To: <8c6ef5d2-1f85-4dad-b426-143d490e1114@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8D7461FDB1
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,alibaba.com:email,suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

Hi

Am 01.09.26 um 14:51 schrieb Qinyun Tan:
> Hi Thomas,
>
> On 9/1/26 8:30 PM, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 01.09.26 um 13:54 schrieb Thomas Zimmermann:
>>> Hi,
>>>
>>> thanks for the updated patch.
>>>
>>> Did you see the review from the Sashiko bot?  The default value is PRE_MULTI, but the driver only supports COVERAGE.  This needs to be changed as part of this patch. The default assignment is at [1] in __drm_atomic_helper_plane_state_init().
>>>
>>> The ast driver needs to override drm_plane_funcs.atomic_create_state for the cursor plane to update the value pixel_blend to COVERAGE for new plane states. Same goes for vbox.
>> Or even better: I just sent out a patch to pick the right default value for the plane state. Let's first see what comes out of this. Patch is at [1].
>>
>> [1] https://lore.kernel.org/dri-devel/20260901122731.83854-1-tzimmermann@suse.de/
>>
>> Best regards
>> Thomas
>>
>   
> Thanks! I did see the Sashiko bot report and had started on a v3 that
> overrides drm_plane_funcs.atomic_create_state in ast and vboxvideo
> (for vboxvideo on both the primary and cursor planes).
>
> But your approach looks better to me: drm_plane_create_blend_mode_property()
> already picks DRM_MODE_BLEND_COVERAGE as the property default when
> PREMULTI is not supported, so initializing the plane state from the
> property default fixes this for every COVERAGE-only plane without
> per-driver boilerplate.
>
> I'll hold off on v3 until your patch has settled.

Another patch just landed that fixes the problem:

https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c3080b58d81d3699cbf4dfd5ba860630fca96f4a

So I acked the rest of your series and I'll merge it in a few days. 
Thanks again for taking care of these drivers.

Best regards
Thomas


>
> Best regards,
> Qinyun
>
>
>>> [1] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/drm_atomic_state_helper.c?ref_type=heads#L281
>>>
>>> Best regards
>>> Thomas
>>>
>>>
>>> Am 01.09.26 um 10:32 schrieb Qinyun Tan:
>>>> Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
>>>> format with alpha exposed"), drm_mode_config_validate() warns when a
>>>> plane exposes an alpha pixel format but not the "pixel blend mode"
>>>> property. The ast cursor plane (ARGB4444, ARGB8888) trips this on
>>>> driver load:
>>>>
>>>>     [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
>>>>     WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x48f/0x510 [drm]
>>>>     ...
>>>>     Call Trace:
>>>>      drm_dev_register+0x1ce/0x290 [drm]
>>>>      ast_pci_probe+0x19d/0x3f0 [ast]
>>>>      local_pci_probe+0x41/0x90
>>>>
>>>> Per Thomas Zimmermann's review, the ASPEED documentation describes the
>>>> hardware cursor as blending with straight (non-pre-multiplied) alpha,
>>>> which corresponds to DRM_MODE_BLEND_COVERAGE. Expose a "pixel blend
>>>> mode" property advertising only DRM_MODE_BLEND_COVERAGE to make the
>>>> hardware semantics explicit and silence the warning.
>>>>
>>>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
>>>> ---
>>>> v2: advertise DRM_MODE_BLEND_COVERAGE instead of PREMULTI, per Thomas
>>>> Zimmermann's review and the ASPEED documentation.
>>>>
>>>>    drivers/gpu/drm/ast/ast_cursor.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
>>>> index fd19c45f2abe2..690d4cd1db5ee 100644
>>>> --- a/drivers/gpu/drm/ast/ast_cursor.c
>>>> +++ b/drivers/gpu/drm/ast/ast_cursor.c
>>>> @@ -25,6 +25,7 @@
>>>>    #include <linux/sizes.h>
>>>>      #include <drm/drm_atomic.h>
>>>> +#include <drm/drm_blend.h>
>>>>    #include <drm/drm_damage_helper.h>
>>>>    #include <drm/drm_format_helper.h>
>>>>    #include <drm/drm_gem_atomic_helper.h>
>>>> @@ -355,6 +356,8 @@ int ast_cursor_plane_init(struct ast_device *ast)
>>>>        }
>>>>        drm_plane_helper_add(cursor_plane, &ast_cursor_plane_helper_funcs);
>>>>        drm_plane_enable_fb_damage_clips(cursor_plane);
>>>> +    drm_plane_create_blend_mode_property(cursor_plane,
>>>> +                         BIT(DRM_MODE_BLEND_COVERAGE));
>>>>          return 0;
>>>>    }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


