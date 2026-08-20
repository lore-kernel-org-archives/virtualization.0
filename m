Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC746D091
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245830; cv=none; b=O5LQVqBEVF0Gk0nLzmxjJopj1ug7hJHqi22iEpJ5MNaaaTh5bYpWXvETI6gN0dWWT3ilTO+EE5KTWmCSOXGcv4ZtRFoyjXDd6Ngpke+LI3h5DsndXx4DzKPWXZ8PJkK2WOTzFyYYk+uLTBynIyQijDoE/xuX0Z9BKOSIyR/jxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245830; c=relaxed/simple;
	bh=jnaTZjotwBm1xZ9HP6h3dDXEkOJupBhQaF95iCJctKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+33Oj9d4xkU5wYgwKXj2Zntyq0JKDh5Aox2JJmjH9K/U9oOWFT6WwBvx7tvZHCmMvqj4xxGf9rV5REwYi2phTv5D6b8Pl8BD4dCxyqK9+tebk1YfLGWv2i//+0ddaccpeJGQHOnw9qWhvP/VQjELVYKKzL9esK8xrwmSnadhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8t/Lks4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8t/Lks4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787245827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RFOFNhe8dD42ULPXJPC0m4cGSa+x0bKLYsWhLafPUQ=;
	b=F8t/Lks4zOGc3AeBDRn+f2I9q1eTbuiedIb4iqpTO5Z8CIrO6LT3qxj8zucCMqQN7aZBTE
	Iv0hDltVx+FX1d1yVQ5/xuc7OL1O3mlOsozHBT5L/01eLyaZ4ncxT7wniNvdAV+DOHLLtn
	JZhUKSXJ7tLuxYnk6CbBWXjJ7uLr/Ik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-pBIWBxb4NDyceSqVZK9gKw-1; Thu, 20 Aug 2026 13:10:25 -0400
X-MC-Unique: pBIWBxb4NDyceSqVZK9gKw-1
X-Mimecast-MFC-AGG-ID: pBIWBxb4NDyceSqVZK9gKw_1787245824
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4957287363bso462965e9.0
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 10:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245824; x=1787850624;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RFOFNhe8dD42ULPXJPC0m4cGSa+x0bKLYsWhLafPUQ=;
        b=fCvw9mIVXFLYorgWtX2wmRw7MUQk2bBxEzzfTrY6b/w8NQZKjXb3JpMmiXzGxfD8wF
         zVS33CebtvnKsQA3+By8rGtUhdGL5teF5Ll3yBzdOocRwkUeFE/KwgzBmKzK0YGIGWtW
         FWsjV6ASGeQt4vchHr7cZ06A4dXmrxbw7X0s1YzZzFekO2wmGRvjb6+4o+jVIZsrIFRC
         dkN48eLdyVXK1Y7OvLwOL+fkHGHt0BObbQLsHSe9emfeH8dXyTMtHHYP2nEC9DiEGdA1
         sGxWNmYXOwXDy3rQAZcGpg3Ffoz39229PiayMpIqXCvXrbXD2QCyixzGUjMUIIbKh4o8
         fd2w==
X-Forwarded-Encrypted: i=1; AHgh+Rrz7rEb3ftD4FsEPr/rmkPOlK/a4S90N+HdX+0PFEkVhpk4DK5DxfB+E+auuF4Yq2nhuJaUUebdsHBAQRKqSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmPYei4LhTncbAydjNCaNkWRbgjm/w76PpnUOlRtyjmbjcV8Dt
	xP3djHDY5jCGPKdaMLW4GAmZEICpGh192yxAuQ8D+1WMeraxrwL+krxSkI0JgAtwnb3guI3dfQU
	QRQV6+VOPD0WXF1lMhPlmUbFHF+13ODldbGAgo4PYUgaN7jIkNtOK5XdYcfQYIpz+f9At
X-Gm-Gg: AR+sD12bXJtmLnIleUnVy7wGotlutZFjEslACExKN7Ul8+aoQ+s9ynM+Xrqp5H9ptDz
	N3vznR3j4RRW+zpxKRXuydlVoYS63WvviQNYm3VFYXo22TDa/BstRFb0YZes4aP9xKgZjtZ1AM5
	99pqHtYa21wdQO2edkcDqbqrosJv49WLQY/kKEMJKGfOdjCZwTvovcNhlXZD1VgPFqLIYHIkEQ0
	zG2mmlyRE7DOX3PnETznnwBgJlezHjfOKo/EAymn9JArquiLhyCeH/kHsP4gCLgbtlMyZXNkTfp
	n3cMtRVc1Pv1CAdZCrRhDb/UByLGxFwAIX2V7XIjKTlW0OKzxjsWlppJo6dGXGZ0owTp3wV72Q5
	xfquUGBqjTGG2kmVAJb0yRyER2CZ873C0s/ykMuHoESPlhw==
X-Received: by 2002:a05:600c:4744:b0:499:93b3:91ea with SMTP id 5b1f17b1804b1-499b831c0b1mr6516325e9.15.1787245824373;
        Thu, 20 Aug 2026 10:10:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:499:93b3:91ea with SMTP id 5b1f17b1804b1-499b831c0b1mr6515045e9.15.1787245823921;
        Thu, 20 Aug 2026 10:10:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb? ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e805a4sm169531595e9.4.2026.08.20.10.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:10:23 -0700 (PDT)
Message-ID: <deba971f-7f8b-4c91-86c5-e3cf0e3c4bdd@redhat.com>
Date: Thu, 20 Aug 2026 19:10:19 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] drm/panic: Pass global module parameters to
 drm_panic_dispatch()
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-7-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-7-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q3xtqHj0P5H54CneDaCVBmB4y3X6JUvAJJ5CTI90-Ts_1787245824
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> Set the panic type and QR version in draw_panic_plane() as a single
> point of truth. Pass the values into the individual drawing functions.
> 
> In the test case, always create a QR code with version 40 (i.e., the
> highest supported version).

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c            | 39 ++++++++++++++++----------
>   drivers/gpu/drm/tests/drm_panic_test.c |  2 +-
>   2 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ede620b27515..12c39217cbcb 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -657,7 +657,7 @@ static void drm_panic_qr_exit(void)
>   	stream.workspace = NULL;
>   }
>   
> -static int drm_panic_get_qr_code_url(u8 **qr_image)
> +static int drm_panic_get_qr_code_url(u8 **qr_image, unsigned int qr_version)
>   {
>   	struct kmsg_dump_iter iter;
>   	char url[256];
> @@ -672,7 +672,7 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
>   		return -EINVAL;
>   	url_len = ret;
>   
> -	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);
> +	max_qr_data_size = drm_panic_qr_max_data_size(qr_version, url_len);
>   	max_kmsg_size = min(MAX_ZLIB_RATIO * max_qr_data_size, sizeof(qrbuf1));
>   
>   	/* get kmsg to buffer 1 */
> @@ -718,11 +718,11 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
>   				     qrbuf1, sizeof(qrbuf1));
>   }
>   
> -static int drm_panic_get_qr_code_raw(u8 **qr_image)
> +static int drm_panic_get_qr_code_raw(u8 **qr_image, unsigned int qr_version)
>   {
>   	struct kmsg_dump_iter iter;
>   	size_t kmsg_len;
> -	size_t max_kmsg_size = min(drm_panic_qr_max_data_size(panic_qr_version, 0),
> +	size_t max_kmsg_size = min(drm_panic_qr_max_data_size(qr_version, 0),
>   				   sizeof(qrbuf1));
>   
>   	kmsg_dump_rewind(&iter);
> @@ -735,19 +735,20 @@ static int drm_panic_get_qr_code_raw(u8 **qr_image)
>   				     qrbuf2, sizeof(qrbuf2));
>   }
>   
> -static int drm_panic_get_qr_code(u8 **qr_image)
> +static int drm_panic_get_qr_code(u8 **qr_image, unsigned int qr_version)
>   {
>   	if (strlen(CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL) > 0)
> -		return drm_panic_get_qr_code_url(qr_image);
> +		return drm_panic_get_qr_code_url(qr_image, qr_version);
>   	else
> -		return drm_panic_get_qr_code_raw(qr_image);
> +		return drm_panic_get_qr_code_raw(qr_image, qr_version);
>   }
>   
>   /*
>    * Draw the panic message at the center of the screen, with a QR Code
>    */
>   static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				      u32 fg_color, u32 bg_color)
> +				      u32 fg_color, u32 bg_color,
> +				      unsigned int qr_version)
>   {
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
> @@ -774,7 +775,7 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
>   
>   	max_qr_size = min(3 * sb->width / 4, 3 * sb->height / 4);
>   
> -	qr_width = drm_panic_get_qr_code(&qr_image);
> +	qr_width = drm_panic_get_qr_code(&qr_image, qr_version);
>   	if (qr_width <= 0)
>   		return -ENOSPC;
>   
> @@ -816,9 +817,11 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
>   	return 0;
>   }
>   
> -static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> +				     u32 fg_color, u32 bg_color,
> +				     unsigned int qr_version)
>   {
> -	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color))
> +	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
>   		draw_panic_screen_user(sb, fg_color, bg_color);
>   	return 0;
>   }
> @@ -891,17 +894,18 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
>   	return drm_draw_can_convert_from_xrgb8888(format->format);
>   }
>   
> -static int draw_panic_dispatch(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
> +static int draw_panic_dispatch(struct drm_scanout_buffer *sb, enum drm_panic_type panic_type,
> +			       u32 fg_color, u32 bg_color, unsigned int qr_version)
>   {
>   	int ret;
>   
> -	switch (drm_panic_type) {
> +	switch (panic_type) {
>   	case DRM_PANIC_TYPE_KMSG:
>   		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
>   		break;
>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   	case DRM_PANIC_TYPE_QR:
> -		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color);
> +		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version);
>   		break;
>   #endif
>   	case DRM_PANIC_TYPE_USER:
> @@ -951,6 +955,11 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
>   #else
>   	u32 bg_color = 0x00000000;
>   #endif
> +#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +	unsigned int qr_version = panic_qr_version;
> +#else
> +	unsigned int qr_version = 0;
> +#endif
>   
>   	if (!drm_panic_trylock(plane->dev, flags))
>   		return;
> @@ -966,7 +975,7 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
>   
>   	drm_panic_set_description(description);
>   
> -	ret = draw_panic_dispatch(&sb, fg_color, bg_color);
> +	ret = draw_panic_dispatch(&sb, drm_panic_type, fg_color, bg_color, qr_version);
>   	if (!ret) {
>   		/*
>   		 * Only flush if we have a panic screen to display. Otherwise
> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
> index 969a096ec840..196496238d23 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
> @@ -58,7 +58,7 @@ static int draw_panic_screen_kmsg_default(struct drm_scanout_buffer *sb)
>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *sb)
>   {
> -	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000);
> +	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000, 40);
>   }
>   #endif
>   

