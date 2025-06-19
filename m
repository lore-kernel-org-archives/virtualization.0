Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F0320E711
	for <virtualization@lists.linux.dev>; Thu, 19 Jun 2025 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750313572; cv=none; b=Bl+N93k8eBV84n9xDq2dzBbZ41B9x7tTmUJcUqc8APOdmA16IlR81iEx8g1HG1rbIqQ57F76y8Ol9VI5OLocDSwviatY0TljrhMXeRHP5B4GgSOqMIALieACt6ojWks7vT2eRwEY499E8/lNkHkZPqWQn350I9jg5QqXgLyrkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750313572; c=relaxed/simple;
	bh=JG3nvfiN+nfkKfMXtVntmeqB5dj2FvNfrLBFrwh5UM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YriFnZlG17YVYjmejeJ6f+MqgUIJgJ4kl3op32tlYsnANzZHTddJLSVVKBOeiYuio6h8Kl+vQE0GD8I8SL6oeq84fBcoek9RTcs7hiGlNTI6QiYgcMA9ztSc5D+BMF7YA+ygwT0X4uW8vRGNO82NQX7XOspJHrm6WOTWl3RRNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e06TIMxF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e06TIMxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750313569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfhEtd1jwHhvY5Akc+bs9I+OMHq84rXrBLaKDXZZDvg=;
	b=e06TIMxFZQy091PABR2Kso+Uu6KoOd1Ld6ULeYzzF+nNUx4oXQqKCKbLXa812Kyn59jqgj
	y7wOXlQDdUuDLCZMkoJjQlO3OgcJgQfCDOLTsUJIUMpJMJRfWAgvDILwo1S4+FNIPq+T6P
	MG+OjuDkny1PLcWFGEPpwdrvb0Vh/G8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-lhR07y60MPW8C5s0-dEDzg-1; Thu, 19 Jun 2025 02:12:47 -0400
X-MC-Unique: lhR07y60MPW8C5s0-dEDzg-1
X-Mimecast-MFC-AGG-ID: lhR07y60MPW8C5s0-dEDzg_1750313567
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4530c186394so1740395e9.0
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 23:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750313567; x=1750918367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfhEtd1jwHhvY5Akc+bs9I+OMHq84rXrBLaKDXZZDvg=;
        b=XRR03I9eF4SxftW92I/XM2cmXFrxwOjqYHIEqeEtRHpwjIrJPxp3VPiBjSO6733oxm
         bhwDbi0dvHzRmafpoPeY+8RLwWNBEEomxg2R6eOo532cYTROi92O2627i8TPDC3mZIJa
         njYj1yOXiFr/qYGr+ma9gHtWTeRNL50wGy6zOBrxF7xm1Jy0Cl1QIYJuoo73kUF3AxxG
         bjyjSKxNbOgrIWCC6vuX+SvzqMblCLfD+S7eIHqRyp3OOfzQz5vmpkUGQxmKtI39cnlN
         yX2ISYt8TK0uiVTUT+SpaMOH9Z/oQaTwAihQtJ2jXSvXivJJGX1KfJ+Nv0eVsaY7FUJ2
         ynBA==
X-Gm-Message-State: AOJu0YwFEpvH4qhh+isgHEvROU/S9GPxVdVHRdUY/Gta8ybrhbJFM05n
	505hWwbV5sKwAR1Do/s2mHAknlurFfP593VnRFmNJd9KdERHPyG8O/v7+E/16OlJQ/rVN0m5+7f
	C77l2S63wDGd3KOI+kpwfMbMHrJPKOoP/uExNeHty4DhMo4hjnGasormBUjzeLTjHtFlH
X-Gm-Gg: ASbGncuxCYI+WkAxZEFt5ePLTEoMeGS3KqjBzBa9ilZDQtle7CEyImdG+8kl3o6kHrZ
	nQ0wDRrX2PhzBcW+abrAMXV8HXai6KfP9WHWCIUWQhdWBr+ywqjNDPgL/nq4DX1QQ4GUswvb2cj
	Y2H2oGituc2H6yydcx7V5qj6dv1br+jEoz0UH10JGVVp5gRTvp7goozrIzJZt2dHn63ibi/oqZp
	wgmnBGu6LYj7fv5/vJjOnlirQwBOfQ66qVMPlNJJ6nrjzKFZ/+GQ5sZ3NbWebPtDwDaZPKeyjGg
	lhYhQi0VeAUfa2SabmDoZMbxQJvr
X-Received: by 2002:a05:600c:8012:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-4533cae684fmr198267215e9.11.1750313566740;
        Wed, 18 Jun 2025 23:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv4EqMqSDWgujH3nkvWTbJJTf6ltr+z032AO09GMUBmRwveoEtpo/cuFt1a8jxgEJEJ0WV8A==
X-Received: by 2002:a05:600c:8012:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-4533cae684fmr198266955e9.11.1750313566319;
        Wed, 18 Jun 2025 23:12:46 -0700 (PDT)
Received: from [192.168.190.158] ([37.167.112.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebd02basm17508635e9.39.2025.06.18.23.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 23:12:45 -0700 (PDT)
Message-ID: <30f0ea0c-d8fb-461e-86ab-6e7677beac3c@redhat.com>
Date: Thu, 19 Jun 2025 08:12:41 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, kraxel@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250613132023.106946-1-ryasuoka@redhat.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250613132023.106946-1-ryasuoka@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dQik88mCACqA96M-lmb6BPnrgFLGvsZA-1_LAEKpz-k_1750313567
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2025 15:20, Ryosuke Yasuoka wrote:
> Add drm_panic moudle for bochs drm so that panic screen can be displayed
> on panic.

Thanks for the patch, it's simple and looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

If no objections, I will push it next Monday.

Best regards,

-- 

Jocelyn

> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>   drivers/gpu/drm/tiny/bochs.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 8706763af8fb..ed42ad5c4927 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -19,6 +19,7 @@
>   #include <drm/drm_gem_shmem_helper.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_module.h>
> +#include <drm/drm_panic.h>
>   #include <drm/drm_plane_helper.h>
>   #include <drm/drm_probe_helper.h>
>   
> @@ -469,10 +470,28 @@ static void bochs_primary_plane_helper_atomic_update(struct drm_plane *plane,
>   	bochs_hw_setformat(bochs, fb->format);
>   }
>   
> +static int bochs_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
> +							  struct drm_scanout_buffer *sb)
> +{
> +	struct bochs_device *bochs = to_bochs_device(plane->dev);
> +	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(bochs->fb_map);
> +
> +	if (plane->state && plane->state->fb) {
> +		sb->format = plane->state->fb->format;
> +		sb->width = plane->state->fb->width;
> +		sb->height = plane->state->fb->height;
> +		sb->pitch[0] = plane->state->fb->pitches[0];
> +		sb->map[0] = map;
> +		return 0;
> +	}
> +	return -ENODEV;
> +}
> +
>   static const struct drm_plane_helper_funcs bochs_primary_plane_helper_funcs = {
>   	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>   	.atomic_check = bochs_primary_plane_helper_atomic_check,
>   	.atomic_update = bochs_primary_plane_helper_atomic_update,
> +	.get_scanout_buffer = bochs_primary_plane_helper_get_scanout_buffer,
>   };
>   
>   static const struct drm_plane_funcs bochs_primary_plane_funcs = {
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

