Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718A25DB12
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265820; cv=none; b=fJFVciBRTlyBs6xYl/JDoTxjVsJJt0v8LHc804Z/R3oMwpJ9xiAe7Ho9vK05/sca8qn90peRh0GEP6SbvzNo+/VF6YY5NrbWSlvoDOIes5BYAxq1Rrzj+3HGj53T9+Fwi9/j9exj1CXOUit+8NLPyiyuMM5wCCZMjDs0S97Vc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265820; c=relaxed/simple;
	bh=nlg3WBk2ec3/NurVUYhGTSV46PIxlHIIMRw3wKTUlas=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jFhtrljtM2Ih19Fu+vr5W+FVU6Bnbb083Bg7mK8CGnCPfsZjn5k3Xe9eImnOuCxXUOjvf6bbtuO7j99Rp9qzoC2Pa1jlpvi5+C7E+qgxtjbaSWmKn3kFHdVoccl/FYNkrOabgQ0/dKXovgRKmR/9BYPI1Cwj9QTBoC2aSfBZtWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LvZQqepB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u4C4JFrk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZkSbTe3x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7z3o5mZY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LvZQqepB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u4C4JFrk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZkSbTe3x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7z3o5mZY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77C8E1F395;
	Tue,  1 Sep 2026 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788265812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fZ9O2oTpRFA/QOxlvi8pyz2VulyemIQm/ZJCat9dZms=;
	b=LvZQqepBCuNVssJ8YmcVrQqpDB43RexotGdEHFj82wzAsgdMV38Eou3An18k0KnXcfGX9m
	fe+z6iXCFLDNHbWMe2EPVXbr7POdBtJMSl5GeUqD95yA+THditkJlNwGpoAqLh7vqOGobz
	/d72GTMfIm1dvHAJ3/h7y6za2DPoPDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788265812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fZ9O2oTpRFA/QOxlvi8pyz2VulyemIQm/ZJCat9dZms=;
	b=u4C4JFrkC1utI8ltMiQzPl7IfuIAlYgFsc8e8Oe4EQz35p+S0dJpV5Uy03H85Bj+W69/9Q
	qhLGlftmOjehbrAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZkSbTe3x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7z3o5mZY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788265808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fZ9O2oTpRFA/QOxlvi8pyz2VulyemIQm/ZJCat9dZms=;
	b=ZkSbTe3x8/uwV6zDUVDlvr+r6lhSxqOPhgWOCy/XJs246TL7HGsNeOFGgIXo+4Dnv7YfoU
	C+Mmn4C8hWWfsWfUI7gdHhGxuFlswW8d4IqDkg/UDMuZop2HO4wPoFPxeGetEbJh7al4kS
	PnkJf+hV5v5TA0jg6GPVbZWk92LSJxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788265808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fZ9O2oTpRFA/QOxlvi8pyz2VulyemIQm/ZJCat9dZms=;
	b=7z3o5mZYUH+cFs9hA2b6LFG9Gno5wlggDhENEWlv5M5wSHPWJfdHI7tMRc95ISz/fcbqoX
	IvISnWSNgCe9ZhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F16191369E;
	Tue,  1 Sep 2026 12:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xl6yOU/FlmpQeQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 01 Sep 2026 12:30:07 +0000
Message-ID: <15f87b4e-3da8-4ce9-9cde-b4c8cefe1d80@suse.de>
Date: Tue, 1 Sep 2026 14:30:07 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/ast: create blend mode property on cursor
 plane
From: Thomas Zimmermann <tzimmermann@suse.de>
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
In-Reply-To: <1f7a2056-825b-4b18-ac60-94f13ee40212@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 77C8E1F395
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,gitlab.freedesktop.org:url,suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Hi

Am 01.09.26 um 13:54 schrieb Thomas Zimmermann:
> Hi,
>
> thanks for the updated patch.
>
> Did you see the review from the Sashiko bot?  The default value is 
> PRE_MULTI, but the driver only supports COVERAGE.  This needs to be 
> changed as part of this patch. The default assignment is at [1] in 
> __drm_atomic_helper_plane_state_init().
>
> The ast driver needs to override drm_plane_funcs.atomic_create_state 
> for the cursor plane to update the value pixel_blend to COVERAGE for 
> new plane states. Same goes for vbox.

Or even better: I just sent out a patch to pick the right default value 
for the plane state. Let's first see what comes out of this. Patch is at 
[1].

[1] 
https://lore.kernel.org/dri-devel/20260901122731.83854-1-tzimmermann@suse.de/

Best regards
Thomas

>
> [1] 
> https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/drm_atomic_state_helper.c?ref_type=heads#L281
>
> Best regards
> Thomas
>
>
> Am 01.09.26 um 10:32 schrieb Qinyun Tan:
>> Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
>> format with alpha exposed"), drm_mode_config_validate() warns when a
>> plane exposes an alpha pixel format but not the "pixel blend mode"
>> property. The ast cursor plane (ARGB4444, ARGB8888) trips this on
>> driver load:
>>
>>    [PLANE:37:plane-1] pixel format with alpha exposed but blend mode 
>> not setup
>>    WARNING: drivers/gpu/drm/drm_mode_config.c:872 at 
>> drm_mode_config_validate+0x48f/0x510 [drm]
>>    ...
>>    Call Trace:
>>     drm_dev_register+0x1ce/0x290 [drm]
>>     ast_pci_probe+0x19d/0x3f0 [ast]
>>     local_pci_probe+0x41/0x90
>>
>> Per Thomas Zimmermann's review, the ASPEED documentation describes the
>> hardware cursor as blending with straight (non-pre-multiplied) alpha,
>> which corresponds to DRM_MODE_BLEND_COVERAGE. Expose a "pixel blend
>> mode" property advertising only DRM_MODE_BLEND_COVERAGE to make the
>> hardware semantics explicit and silence the warning.
>>
>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel 
>> format with alpha exposed")
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
>> ---
>> v2: advertise DRM_MODE_BLEND_COVERAGE instead of PREMULTI, per Thomas
>> Zimmermann's review and the ASPEED documentation.
>>
>>   drivers/gpu/drm/ast/ast_cursor.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_cursor.c 
>> b/drivers/gpu/drm/ast/ast_cursor.c
>> index fd19c45f2abe2..690d4cd1db5ee 100644
>> --- a/drivers/gpu/drm/ast/ast_cursor.c
>> +++ b/drivers/gpu/drm/ast/ast_cursor.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/sizes.h>
>>     #include <drm/drm_atomic.h>
>> +#include <drm/drm_blend.h>
>>   #include <drm/drm_damage_helper.h>
>>   #include <drm/drm_format_helper.h>
>>   #include <drm/drm_gem_atomic_helper.h>
>> @@ -355,6 +356,8 @@ int ast_cursor_plane_init(struct ast_device *ast)
>>       }
>>       drm_plane_helper_add(cursor_plane, 
>> &ast_cursor_plane_helper_funcs);
>>       drm_plane_enable_fb_damage_clips(cursor_plane);
>> +    drm_plane_create_blend_mode_property(cursor_plane,
>> +                         BIT(DRM_MODE_BLEND_COVERAGE));
>>         return 0;
>>   }
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


