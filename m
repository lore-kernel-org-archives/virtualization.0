Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E73AB498
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267095; cv=none; b=Li6kejgEF9u4Jc+RnLA+Y4njHiYOZEsqdFdEGd4XgYH31i/hMu2Se/SAvF4ULKHJSP4q7rhl9rohXCP2ICYfaMYsBDIyEELfpnHQJ13GXUsUAj3Q3GGw9EwgA3354M1zBreYeQvEFDp0jK4KDqET/kluSXqMq32sWhjC33vopDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267095; c=relaxed/simple;
	bh=LPaZmEQ6mWw4jItsJmVWxKZ239DkgKqW0OUsppUlIuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCGY2Glp8T/l2oB7FjdyDx7++Ka8yA4ejNmFXJlqtl1y2qeEzi0wD1fVk5OIXMkME1q/V4DOC7BudvkEB/WjHxK4PIHOqtdYRP6GbgWmaERsmXkRvEWRyiuIi+stBun3UahcXg93fAwdOFugWIr1lnHnPVd5gN6wwTeHnLthJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hy/2SxLs; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hy/2SxLs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788267088; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lTOlsDQ4+47U/45ixyptCvDQ1ryhv/HPtsz8TRQdczo=;
	b=Hy/2SxLsKrBZ8g4+UM5AcO9ba2y2cWU6wj0zJRSTq75Vjrv4L7G7RjWvPRavLJrofVB3BdyC2APA2GjfvC6CQg5pEPjOOvRzQqS2U/Xwx8JYk2QqpQMBpDD/iz4W2pdpuE6uLj5iETA7QbNTjs7yYVG8AIjniP+n/A8kd6a4H7E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0XA8VHYm_1788267080;
Received: from 30.178.69.13(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XA8VHYm_1788267080 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 20:51:27 +0800
Message-ID: <8c6ef5d2-1f85-4dad-b426-143d490e1114@linux.alibaba.com>
Date: Tue, 1 Sep 2026 20:51:18 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/ast: create blend mode property on cursor
 plane
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
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
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
In-Reply-To: <15f87b4e-3da8-4ce9-9cde-b4c8cefe1d80@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 9/1/26 8:30 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 01.09.26 um 13:54 schrieb Thomas Zimmermann:
>> Hi,
>>
>> thanks for the updated patch.
>>
>> Did you see the review from the Sashiko bot?  The default value is PRE_MULTI, but the driver only supports COVERAGE.  This needs to be changed as part of this patch. The default assignment is at [1] in __drm_atomic_helper_plane_state_init().
>>
>> The ast driver needs to override drm_plane_funcs.atomic_create_state for the cursor plane to update the value pixel_blend to COVERAGE for new plane states. Same goes for vbox.
> 
> Or even better: I just sent out a patch to pick the right default value for the plane state. Let's first see what comes out of this. Patch is at [1].
> 
> [1] https://lore.kernel.org/dri-devel/20260901122731.83854-1-tzimmermann@suse.de/
> 
> Best regards
> Thomas
> 
 
Thanks! I did see the Sashiko bot report and had started on a v3 that
overrides drm_plane_funcs.atomic_create_state in ast and vboxvideo
(for vboxvideo on both the primary and cursor planes).

But your approach looks better to me: drm_plane_create_blend_mode_property()
already picks DRM_MODE_BLEND_COVERAGE as the property default when
PREMULTI is not supported, so initializing the plane state from the
property default fixes this for every COVERAGE-only plane without
per-driver boilerplate.

I'll hold off on v3 until your patch has settled.

Best regards,
Qinyun


>>
>> [1] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/drm_atomic_state_helper.c?ref_type=heads#L281
>>
>> Best regards
>> Thomas
>>
>>
>> Am 01.09.26 um 10:32 schrieb Qinyun Tan:
>>> Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
>>> format with alpha exposed"), drm_mode_config_validate() warns when a
>>> plane exposes an alpha pixel format but not the "pixel blend mode"
>>> property. The ast cursor plane (ARGB4444, ARGB8888) trips this on
>>> driver load:
>>>
>>>    [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
>>>    WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x48f/0x510 [drm]
>>>    ...
>>>    Call Trace:
>>>     drm_dev_register+0x1ce/0x290 [drm]
>>>     ast_pci_probe+0x19d/0x3f0 [ast]
>>>     local_pci_probe+0x41/0x90
>>>
>>> Per Thomas Zimmermann's review, the ASPEED documentation describes the
>>> hardware cursor as blending with straight (non-pre-multiplied) alpha,
>>> which corresponds to DRM_MODE_BLEND_COVERAGE. Expose a "pixel blend
>>> mode" property advertising only DRM_MODE_BLEND_COVERAGE to make the
>>> hardware semantics explicit and silence the warning.
>>>
>>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
>>> ---
>>> v2: advertise DRM_MODE_BLEND_COVERAGE instead of PREMULTI, per Thomas
>>> Zimmermann's review and the ASPEED documentation.
>>>
>>>   drivers/gpu/drm/ast/ast_cursor.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
>>> index fd19c45f2abe2..690d4cd1db5ee 100644
>>> --- a/drivers/gpu/drm/ast/ast_cursor.c
>>> +++ b/drivers/gpu/drm/ast/ast_cursor.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/sizes.h>
>>>     #include <drm/drm_atomic.h>
>>> +#include <drm/drm_blend.h>
>>>   #include <drm/drm_damage_helper.h>
>>>   #include <drm/drm_format_helper.h>
>>>   #include <drm/drm_gem_atomic_helper.h>
>>> @@ -355,6 +356,8 @@ int ast_cursor_plane_init(struct ast_device *ast)
>>>       }
>>>       drm_plane_helper_add(cursor_plane, &ast_cursor_plane_helper_funcs);
>>>       drm_plane_enable_fb_damage_clips(cursor_plane);
>>> +    drm_plane_create_blend_mode_property(cursor_plane,
>>> +                         BIT(DRM_MODE_BLEND_COVERAGE));
>>>         return 0;
>>>   }
>>
> 

