Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA647DF86
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246138; cv=none; b=gL+qHV/FCOQs/HWQB2hosgWnRwgkxJxHPKnhnad0wwPR7rIEjcYxX2vrNBxWiNs3P0aLpyRPnozUFkP4NpBDoInIR88IRHaVu9c5Ui9f7/EzVppojnEnxeEkFbatede8t4y1syo5hmuIXGTVgBMQLgksm+Z6rpwctN9uO9v4z9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246138; c=relaxed/simple;
	bh=9tk8Sl/tU+k06lyjB+gI117CsAuIPPkNt46ArevX/WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blI5Q6qMRvWVk8IPoQsEhcjDY/5q4Zr7+Z3env0nznEZy2dmTURJDmauxVgpGnXncCVfl5mYNSu/FETO7OoJ4kKbz0YH8vfOT5RzbPjokTN9C6v1cbOO+AcaSDLTFmlrNrcAWfOslSj8xlzriXJnM7vxglUERkAf17i0GPTDKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbvYlM8g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbvYlM8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787246134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
	b=UbvYlM8gQtehnb+mJGkZ770E/RZPmqF7CxIfe6OtQD1aXeTxWjauf90zkThNzXxe/GMf6K
	I+ZvgdL++BwfrJT/09BAzQsqQduEKSt233ECNbiRaAwkOIcxcZY//S9Gan+BnvSQycveDi
	paV+t9bEqZxR9/MWTVQ7mkPqYgd4HLA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-0RQ18B0MOrKV6MvSPSlpKg-1; Thu, 20 Aug 2026 13:15:31 -0400
X-MC-Unique: 0RQ18B0MOrKV6MvSPSlpKg-1
X-Mimecast-MFC-AGG-ID: 0RQ18B0MOrKV6MvSPSlpKg_1787246131
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994aebe932so393975e9.3
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 10:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246131; x=1787850931;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
        b=DBh55Q4MMSW5QraBqdba2N26eG8bPlyYn8rVY5q4Z346qblnqLLhvoSIYNhPc1iZdp
         VhxUivvvoTCT4wV69u/uOpnDe53uUqVYKmwwf+gsrIyjFu8tq2SM9XhLdzIj6SPkQzP0
         n6gI5hoPcnHGjCMylHhvol3LJZeg/VqFqtk/j5OcUshl1yhOZKaFznAW2b/G37oKWR2c
         omF2xuUbb4SmSJ+7C8Y4lOw+Js6HdFmFMN+bpEQkhRvP0OHcI+Fhasie/xGqg3uzWxcB
         yhnZLFXqGGl7v1YW6sYfvsDJlvk3gHLCw+mJ2VyPT0IIaB1mx5c+mbNfljwFliUc6zXa
         t+WQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYh5KIiLjNLqKJc2pcNMbooCpx8a3RHENka9Ko/yx2ZhUyLClLhDVOX9J2b04MYgvB/DFdR+7xtVz5/UtMCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB4/k5FoVfkf2o0zqkn5ZU2UNyF83CsXdyHCDY45CILn/drMwN
	pG6Wgzzr89di5WJ6QOd4RGLutYVe5d04prUAXeMhvH05EF9Go+bo9muUTuQ/1c8g2mjelx+Jl7C
	huyt8tdIPC6wEfJnS2Wcqww6DOjECEWYPowtfx/aaBMJ3Jc7lDfU59a3rXcTGGUxhGYrB
X-Gm-Gg: AR+sD12tAY3KuUSW9VU3y9j2Bg27N+r0D9y2Sa25t58/wf/CpOyqfqK/nHgczI9I/2T
	9b3VpR7Eh4F2YiLFjNMXyCjsvz5JqHGOeZZx5k5X0KBRY0xJHzHh8rSNjLE8Xhgl2fBAINBKzNF
	omloUt9p3libQHJrjSn/t1TAZUfbkD4TQzb5RUudKbq7FpYbBPLMe/QaKNeCSQmb8fggNfQtff0
	cSyrb3wxqPREvWK1IupKu23xzNE/BE3ihKYOmoqQR1RwBVhCJNjFIzwuQzjjceRRYo1afUlvKtY
	EcrMjn9bbvNRRuByx+M6bb0Z4BzoSnDtNcSrLcwg3g/wSxomCYjDxVkAmz9G2wE8TiPH8z2H4b9
	eGc2L4ShyY/DaWKwX4Q+a+v+J+y8eIG7qk6zYPEdcb4ofsw==
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499b845c184mr6845855e9.15.1787246130468;
        Thu, 20 Aug 2026 10:15:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499b845c184mr6843265e9.15.1787246129216;
        Thu, 20 Aug 2026 10:15:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb? ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14514d5sm14505430f8f.10.2026.08.20.10.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:15:28 -0700 (PDT)
Message-ID: <dd1da602-675f-4b63-ace3-a23e55ce549b@redhat.com>
Date: Thu, 20 Aug 2026 19:15:24 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/panic: Retry in dispatch function if panic
 output fails
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
 <20260818125012.468092-8-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-8-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rfKeKPx7stD2XpRXqU_Iks2ysCpxkmTq4ImU9wc-7E0_1787246131
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
> 
> Also pass module parameter drm_panic_type as a parameter to
> drm_panic_dispatch(). This simpifies the implementation. It will later
> allow for moving the function into a helper library.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 12c39217cbcb..0960750bfce2 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -746,9 +746,9 @@ static int drm_panic_get_qr_code(u8 **qr_image, unsigned int qr_version)
>   /*
>    * Draw the panic message at the center of the screen, with a QR Code
>    */
> -static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				      u32 fg_color, u32 bg_color,
> -				      unsigned int qr_version)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> +				     u32 fg_color, u32 bg_color,
> +				     unsigned int qr_version)
>   {
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
> @@ -816,15 +816,6 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
>   	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
>   	return 0;
>   }
> -
> -static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				     u32 fg_color, u32 bg_color,
> -				     unsigned int qr_version)
> -{
> -	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
> -		draw_panic_screen_user(sb, fg_color, bg_color);
> -	return 0;
> -}
>   #else
>   static void drm_panic_qr_init(void) {};
>   static void drm_panic_qr_exit(void) {};
> @@ -899,13 +890,22 @@ static int draw_panic_dispatch(struct drm_scanout_buffer *sb, enum drm_panic_typ
>   {
>   	int ret;
>   
> +retry:
>   	switch (panic_type) {
>   	case DRM_PANIC_TYPE_KMSG:
>   		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
> +		if (ret) {
> +			panic_type = DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}
>   		break;
>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   	case DRM_PANIC_TYPE_QR:
>   		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version);
> +		if (ret) {
> +			panic_type = DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}
>   		break;
>   #endif
>   	case DRM_PANIC_TYPE_USER:

