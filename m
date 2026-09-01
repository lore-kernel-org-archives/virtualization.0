Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937637BE63
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249591; cv=none; b=AofypSHpDiwgfp2NlzJ4obiHl34yn3IrkL/KYw07KE40C0BRf18H06k5SJo2Z59PmxZECBD1/2gch9vsT2vLKb3jfouVv7cAXf7Jkt5htKaRIVWdCWvWlZb5Reg3vihew7dvTSA2YZCbJMactVsCYRbwyxcZ9fZ9rEUduT5Hd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249591; c=relaxed/simple;
	bh=4L0HiuUlsGrJN/A/CxrOcUFYYsjKsRJV2pTvUhGxf6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYJvl1iS8Ng7surykoX3Ruyv9teOcdwgfVbobJkTkG9jBnYFbyF2LxKIZJBA64uZXIoBiLqtKwUBLXlcwR27rSpJC7jnFj/ahDLM8wOyoMThduXU9wFlO9pcpijq6iTjRaN0H5ssvoKbECtHFChHtizwKEc4pnMCr1omSPUSDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VA5euC3p; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VA5euC3p"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788249586; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l5Io5tBdjPe5sz7QW4brV92jKRETGgCK1EVRYlKXs20=;
	b=VA5euC3pr4Q80q5+cbqhY+4XJQpje+pExcJIwsijsvPx/uzUB8enbkttuhuk5n0gZz6O5F8qJjQCEVAv14fuPQk2de8W7y4tDDweD4TGEQ6us2DKp0KpubCMP25F8Ry597r/2w7csGu8a4jkctt9hqiRO0oDj6LCklWN6FKbeAw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0XA5ntIS_1788249571;
Received: from 30.178.69.13(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA5ntIS_1788249571 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 15:59:45 +0800
Message-ID: <3a29ca77-fe8e-4bbb-b4d7-49011981351a@linux.alibaba.com>
Date: Tue, 1 Sep 2026 15:59:43 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/ast: create blend mode property on cursor plane
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, jfalempe@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260901065045.1152136-1-qinyuntan@linux.alibaba.com>
 <20260901065045.1152136-2-qinyuntan@linux.alibaba.com>
 <3dcac5c3-cdb1-438b-9ba9-789ad9777ad4@suse.de>
From: =?UTF-8?B?6ZKm5LqR6LCt?= <qinyuntan@linux.alibaba.com>
In-Reply-To: <3dcac5c3-cdb1-438b-9ba9-789ad9777ad4@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

在 2026/9/1 15:03, Thomas Zimmermann 写道:
> Hi
> 
> Am 01.09.26 um 08:50 schrieb Qinyun Tan:
>> Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
>> format with alpha exposed"), drm_mode_config_validate() warns when a
>> plane exposes an alpha pixel format but not the "pixel blend mode"
>> property. The ast cursor plane (ARGB4444, ARGB8888) trips this on
>> driver load:
>>
>>    [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
>>    WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x48f/0x510 [drm]
>>    ...
>>    Call Trace:
>>     drm_dev_register+0x1ce/0x290 [drm]
>>     ast_pci_probe+0x19d/0x3f0 [ast]
>>     local_pci_probe+0x41/0x90
>>
>> The hardware cursor has always blended with pre-multiplied alpha and
>> userspace assumes that blend mode when the property is not attached.
>> Expose a "pixel blend mode" property advertising only
>> DRM_MODE_BLEND_PREMULTI to make the existing semantics explicit and
>> silence the warning. No functional change.
>>
>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
>> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
>> ---
>>   drivers/gpu/drm/ast/ast_cursor.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
>> index fd19c45f2abe2..08d93ac7f7cb8 100644
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
>>       drm_plane_helper_add(cursor_plane, &ast_cursor_plane_helper_funcs);
>>       drm_plane_enable_fb_damage_clips(cursor_plane);
>> +    drm_plane_create_blend_mode_property(cursor_plane,
>> +                         BIT(DRM_MODE_BLEND_PREMULTI));
> 
> AFAIU the available documentation, AST hardware corresponds to DRM_MODE_BLEND_COVERAGE.
> 

Thanks for the correction.

I'll send a v2 that declares DRM_MODE_BLEND_COVERAGE for the ast
cursor plane instead.

> Best regards
> Thomas
> 
>>         return 0;
>>   }
> 

