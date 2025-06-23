Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E2238C1A
	for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673532; cv=none; b=K5aCzz2gtqEkV9+kvGz/t2bXma+msVrg3g9R61MnFl9UUbSBYA1Vjj2X+2dlJOI9BvJCULtBrdbtxkt4qsGdDU/EHvpuk+Dq+rsIi9Af0cNw+8p+yhAZuwHPU7zN6m1Ia9rHwdyONmc8FWj3mADe4yhuxnSjBPsiqd/B/gMC0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673532; c=relaxed/simple;
	bh=ZyqSs9lshWYc06L8xxKgqIUaV+hzxhbDO1cuH0KIYa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvRY9o/sbm/xN/TcAwgYNzNOo2ix0mAU12tiR/+vjENOm/cbC9tbBjuqDwcsamr6OIsba0HiWXzT67av+3CUw6u8bXJVcoeorP2vsQk9HSuiHKWGNAEGkXe7EhboqOVh6Y6ZlcJJVKivUpQ6FromzO+5zz3RjlBBE6klJqTbiUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+xW7cbi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+xW7cbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750673530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYLo8wP+y+o3VIS7TqC+HJOW2Pflfi59Nw4T7VkfABc=;
	b=L+xW7cbiEVwgHhnlqtRl7ZD0ifcEaWRFz3ELbvvswsP+BPSOr8AC+nakdSj/+2KRiZBmy6
	f2KzySFER/T7xNxwceo7L9PuSyC0+jgVvfGEWzhXEjPZeaLE1T/CaLCoo/0BSwhPzEdeTy
	TeccD01NzBqnxhOan07whQR1mSS246o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-qItyNqVGMqqxKoHuO_ZunA-1; Mon, 23 Jun 2025 06:12:09 -0400
X-MC-Unique: qItyNqVGMqqxKoHuO_ZunA-1
X-Mimecast-MFC-AGG-ID: qItyNqVGMqqxKoHuO_ZunA_1750673528
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a579058758so1680151f8f.1
        for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 03:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750673528; x=1751278328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYLo8wP+y+o3VIS7TqC+HJOW2Pflfi59Nw4T7VkfABc=;
        b=iLuvKYdAzoe98QCtf4fblw72jbfe9TZaT1idV9HluT4ON5MHEu9UBeMxGITPP+5LlV
         UaKFY55a1i55vjZ7HiyTTCgzyZjL9J1ZRdvBcUpwoZYb++34MWWRhHeJZM1gUEE/4z89
         P+kt78nqd/qu0iawK42b0Z3acrMLFdSz11zHjURLnpCliuwBeAzWZJAotPRQhOKt+H3a
         8PppAoKclmp+1P9Ybx1i1TOOh2wxzxUrii2JzlpF0ND3ySYKaqaqflNp0+odVGnihsqN
         zEI9/VazvxJGjYQoTH7E+2hrsExwUiFL8wAsp1sgqwv5kTfNSidiwde3sJUjhxRF7ZNd
         MQfg==
X-Gm-Message-State: AOJu0YyAkXH7hyT9FRtZ5jMgSsRgVpR70f+Od5JIZAPTcnQjA1za3gLW
	9D6f891EtaWjVRhQjx8BPGG5Ee/FVBDwFoKCyCjmt1lhgZmCCDelpIt1bCih5sjnOJU/+6tUn9e
	SjfHG3vYtjazhjyXvDv6VIOcXFQcrmCKavZj//qr/+3/rknypH8Y5jwf4sEQS+uOfdeO1
X-Gm-Gg: ASbGncuEH5gYX5j4W3P+JWCZfsey0A9SDftYb82j9urOkjCLWganMfFMOKMbSxjZM+1
	F5jWz6BKVECi175lqZI+e8tIoUkkIUY364uxgYwhB042uJ1F8vjNLn0eN+C9r+iTxF2sQX12htF
	KAWABdMo1aTqqOtaWIMV/s+oEgjsi1M66ypZC0Hb/KpCTMbC2yrIgJtOVEJrRToxhU0qxI9gcq/
	Fprtiqndq3rs4gcYv5Nqv9GSya78nc8g+74sG4WZVLa+3nQgFq/lGIH4oarwR8DvcfGUDIs4AL/
	Dcl1iHaNfs5YTsZpD8+h40NRpAKe7jiWlSdDp6XiEGHYviBlag/GGAm/VisNjw==
X-Received: by 2002:a5d:64c4:0:b0:3a5:2b75:56cc with SMTP id ffacd0b85a97d-3a6d12a595emr9714563f8f.23.1750673527770;
        Mon, 23 Jun 2025 03:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCL4na2uglOQFNEUAANK+zA52+SQuukZvQq//WUH0f114XAeIMlx0mcV3sqHLNJE6Ahlk+RQ==
X-Received: by 2002:a5d:64c4:0:b0:3a5:2b75:56cc with SMTP id ffacd0b85a97d-3a6d12a595emr9714535f8f.23.1750673527348;
        Mon, 23 Jun 2025 03:12:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d2236452sm8895293f8f.59.2025.06.23.03.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 03:12:06 -0700 (PDT)
Message-ID: <acbb1b02-593f-4a46-b4cb-99781d595e33@redhat.com>
Date: Mon, 23 Jun 2025 12:12:05 +0200
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
X-Mimecast-MFC-PROC-ID: D5uQxNYdlIcD5420pqJZ8HlPlCGK3Ra-SYBGRIIaTBs_1750673528
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2025 15:20, Ryosuke Yasuoka wrote:
> Add drm_panic moudle for bochs drm so that panic screen can be displayed
> on panic.

I just pushed it to drm-misc-next, with the typo in the commit message 
fixed.

Thanks,

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

