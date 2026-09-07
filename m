Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFF41D111
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814868; cv=none; b=X13dEV2xeB2x5x1N9iDq8kir4kjyErF16N/N8rSf+sayhio45ulRRlBPFZJVSZLQtaApN87Gx48+fx9N8KtwyFIfZO3EYexg1CubBnnu+/lli44Pl8TH0t27hCe774o/VJo0uzbxuSDrJwWT090njmvNnjInoYanPuTDMXXj/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814868; c=relaxed/simple;
	bh=Pfp4fHaGp3DYNoQNsq++Hih2POFfdEHNA9k/g4/DYlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bi8j5lflmeWKA8L7odyxo3zkWZO7PJMpkeYtVaBZDOws6/Em4nQHLaqDeRwVl2J/uiPnmEsnokTgRMjcSR5tljWCNcTR38cJEzTbBAVbOhvltxT81YxBFej7I1aYQs4YMMC7u4Y7riB2TtK5K4hYhuWDnRSD3xQ5h5XtltuB2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgI1rcg1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgI1rcg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788814866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=km54XNA3pesnlH9MUSOEbKUzj91GMmwN/4bvXZLN1Qw=;
	b=LgI1rcg1cbsuNW1oWevjWdKuRypXCfEXJFDufDhqSoD/ozQUByaVtEOx26PO0heKbPIxwF
	HFJ3/8hrTelO+HrnpL2F+oQaHcbQx9MopFoM/lAdBrnukfvSL7/zKM6ri0diot2OXkaRqP
	JtvMBjIKQZiVIwvztxq2gu4R/AII3Fw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-_i__Ww0iMq2_hl93TH8SQg-1; Mon, 07 Sep 2026 17:01:02 -0400
X-MC-Unique: _i__Ww0iMq2_hl93TH8SQg-1
X-Mimecast-MFC-AGG-ID: _i__Ww0iMq2_hl93TH8SQg_1788814862
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cd74fc1aaso22325075e9.1
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 14:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814862; x=1789419662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=km54XNA3pesnlH9MUSOEbKUzj91GMmwN/4bvXZLN1Qw=;
        b=GLCFmJupMNACktYXi7zLF3I9A4moXdjpVMynaX/HGVhpqLApY/ugjsLjZi2tP1Vjlh
         /0rluKUwEIWVaazNsIL5iv1dIF4ljEPRI69NUg5y0xJJUMgYYdh+goSIqsD7oilouxiN
         Oybu0TQd6gmDzJER1dmPsMOYP9NFDtvAcKcnAUbyUB1mjC62ayFoyiKlmUPAKhDKXEjo
         XNczz1bJoQazQYvRQ/3JuDom8fDc+41qfxKEA3NJkRduEigELFf16m1PdI2nbnnB2IVS
         /AurPWOsrXynMx1mTg2cQL29c9/C8o2cRcfqk8ZR4HYpHxmxJy5VYtZbLnYUJo+L/1A9
         Fv9A==
X-Forwarded-Encrypted: i=1; AKwUvBzWifWpAqz32yLbtV11xKopHbRbR5VaJeTD7XXgmMGHSm0tsxcgjOmYWrtqexM4yqjgVVG6h6LmC9Nd6yW8LA==@lists.linux.dev
X-Gm-Message-State: AFuF++ly1fvJNWe4j+X/kyr+3o8YgWimuEjUryOP3lCG2KOUU91M5eNE
	4PuR4gtxpvsaIrtZjnGjuGdfnhqa554/hgEQjC3cs9JZ11FENeSx6+K0/tBLZTP8ORWeXHQN6ua
	EOMALPr3KTknFOlg7ugsYdfDwRhaxSAc/NVLtUCsM6VDtKKFGga2kWgWhybGWrhx2ZzZF
X-Gm-Gg: AYBFou148TTyjR5U5oqKIsV5XvR5vbNx2HhKPC0Kfz24XRatuMNQjeNw4VX0j4TdzAu
	USiax3HI+57vf6uuJJDdX01TSwPgCGO4yv0LeDZthCVHBIsuakKrrfiUgytfBkFPSFVMzcqRMjw
	fs0gmZvE9wEhd5OUWUDDzj2inFZjZs6hxXN+6BseR27wiEG3KHkVrRZsnCwWBptqQStg060kBbY
	xmn31qIuvWFJQK4KNCfQr1gEXy3A1y112k0MOHpWggygU8rqeBmGNwZQAKhczuAAdCfIPOHpbZ9
	dyTnTt2jDwVXarodnq8IjvtdvsV/Yz7OCVfN4KJy78IKe4a608xtEnIMVYa3gYw2ZlDU3QRfH5w
	RG6fsXEMcXoThlPvjgz1QvgWnpkKPnbJr07TQEBXUd9Jv+32O
X-Received: by 2002:a05:600d:8649:10b0:49c:fa20:cc0a with SMTP id 5b1f17b1804b1-49cfa20cd58mr167275135e9.33.1788814861724;
        Mon, 07 Sep 2026 14:01:01 -0700 (PDT)
X-Received: by 2002:a05:600d:8649:10b0:49c:fa20:cc0a with SMTP id 5b1f17b1804b1-49cfa20cd58mr167274945e9.33.1788814861409;
        Mon, 07 Sep 2026 14:01:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9? ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm458086515e9.5.2026.09.07.14.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 14:01:00 -0700 (PDT)
Message-ID: <b34807ad-6390-4804-ba29-43a407b3d9fb@redhat.com>
Date: Mon, 7 Sep 2026 23:00:54 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] drm/panic: Do not use un-escaped URL as format
 string
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
References: <20260902121930.597222-1-tzimmermann@suse.de>
 <20260902121930.597222-2-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260902121930.597222-2-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 56irsnIYnuy2QiXNEEchT2oo-bhU4rbD9Kdf2uSZjwg_1788814862
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 14:13, Thomas Zimmermann wrote:
> Replace the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in snprintf()
> with a %s conversion specifier. Avoids a possible vulnerabilty from
> a crafted URL string.
> 
> As the attacker needs to control the kernel at the Kconfig level, the
> potential for an exploit is likely low.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.12+
> ---
>   drivers/gpu/drm/drm_panic.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index e576c4791861..ba21df4be338 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -658,7 +658,8 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
>   	char *kmsg;
>   	int max_qr_data_size, url_len;
>   
> -	url_len = snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL "?a=%s&v=%s&z=",
> +	url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&z=",
> +			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
>   			   utsname()->machine, utsname()->release);
>   
>   	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);

