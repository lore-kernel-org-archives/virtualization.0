Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC0377A89
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245504; cv=none; b=Q2PgmDEgXNMdx54edJaL3d6gT8vMpzI7WDZ5cqDsEhHm0NSxkeN6OT9H+zufoETVHxNNi3/FNxhbpLb+hNT5cES+dm3BYPeKYVKSTdMSaVXZVOE68aIdlqrVEsszSY7aGNgv2aczPcavAmDV/CK2LYfN5pUn+xs0UtjnK5SxW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245504; c=relaxed/simple;
	bh=OOvAhEjtRhOw0a+UjXxcotOqI4sqWEFsEYl3cZ0ejEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgsFlE1xXN+8FkoU5AbvQlxba2X0pgslFkogZf+WTrdE3CnHhB4bjyBiBr/zFKk0JqXtKg38miFjUwUHZ8CJ5MCasl8TsaW0gzHyWWb5LugIYVu+AyeoRrTiwXYPP1yJrTMSb/N/ebbgWMTbHUUXrLrPrWdw+LyHI2J4lLqdPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VT3MNaw1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT3MNaw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787245501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
	b=VT3MNaw1PWbotehwX0vuAXoeYQmzYimt6gxj0aBL11nHU+2lEIKLsSKHbCH0r+Ab2Y44gS
	MWIze5ArnjLmYqt0knQWSfuP/oz/BX6WoXDZZFwxKduQ0S3DZ+OftitT1IGNuzZIGMv+Na
	wpQ+k883sJrORu99zRMZPu5WGjWP3ok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ky5LCCdZMS6NwImSS0Ntlg-1; Thu, 20 Aug 2026 13:05:00 -0400
X-MC-Unique: ky5LCCdZMS6NwImSS0Ntlg-1
X-Mimecast-MFC-AGG-ID: ky5LCCdZMS6NwImSS0Ntlg_1787245499
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso393715e9.0
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 10:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245499; x=1787850299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
        b=WRaLOIfSWhorHQue5WsRN2xdTPJrbDP7/R2nwkl6mns2sjXJ2aRaWON02R8ZkHgNjb
         7r9iNC0xIDJWN2A/mvH4WjGG1lcbImvmtIbiHnK2nwcGaZRyz/UxQBiIcK4ibq5GeT2n
         hTCXBZVS7CUwOCFWmz11lOqIGbTrG+ygvHdQoKwcvH7mtNvPD3MYa8ByzZRZRqtyQoLh
         I8lL8yCHcOuz6o8p2oEp6QQibgtfBN7zQUIr/sB+xVw68HTpvtNtQk3+O0okDNcaqMfr
         RuMlf/RSsl7dTmZC0QzgCb/+VpLATUAEO7z23fkmTkVer0j9eqxzVfA6kA+h2M3CjL34
         ULJA==
X-Forwarded-Encrypted: i=1; AHgh+Roea8vMSUfyVT91wjy2brURUVuRJwuT+nyeJANidkXVVbQHu9ZdWXCd6+eWc7WwlnZggTjQRbA71zjhr38rew==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIUgNPgdNvU+jzLK3ch5wEJe0ro+wvECDBA6CgDGxiYsICZ/x4
	80iImAA+3P8j+dqOfxUdF/kVFFD9pmR5hy9CkTs5/GSBQif32Z5lTe5JydEKqfiXd6FkDuRiWY5
	boIE1QiKDUgyO4E9vmeqHCHt0IMu8+J8KT3ECtOJPXy5y8TbX4upUp5/RwVqrmrKlJl9z
X-Gm-Gg: AR+sD12JqmXcKIPeR3SsskuoqbHRtbChOKX8P7CrU5hEMv6pTxiNQg6Ij4raRbiJ9CZ
	TMe4q0ZMx9I6Yvj4UXEdY1Uz1BEuI40ep1qUh5jhEcxdjiNczUx7pvY6nHZv/9Gtn9KKI7HWfon
	EelRYQ9EUaAVfy7HFVgN7cn2EuBKlrydKPbbbSTx2Mn6ZpibG0vm7NFibooSd+pEmfRPao63BoR
	n3Us6TbPyAfHw1Sn1sojUUX/+blpKXso3tBi3uwaIE7NyQmqbYln6oGCXat0Cm7LsPaeAJkeJvt
	hfXaHmakxljtOhKo0VlyGBvhVddLrB1lRCmAB7ZDOd29E9PLOYw3S5nQ44DmK1Ma3JXOvXsx0HU
	L7UPln8wJTj0u11X8zCCA22i4f9G4UdT3nECZ9Ovn565zVg==
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499b8465f7dmr5016955e9.10.1787245499089;
        Thu, 20 Aug 2026 10:04:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499b8465f7dmr5015695e9.10.1787245498659;
        Thu, 20 Aug 2026 10:04:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb? ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c33b3sm13157002f8f.27.2026.08.20.10.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:04:58 -0700 (PDT)
Message-ID: <cb784cf6-f3d8-41aa-9f71-c197a5eba7f2@redhat.com>
Date: Thu, 20 Aug 2026 19:04:51 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] drm/panic: Return -EINVAL if font is not available
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
 <20260818125012.468092-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DkbdLxX-EFotxth_djeXrt5Y4_9mot0iee0-1_EXKpY_1787245499
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> Font lookup does not allocate memory. Hence reporting ENOMEM on
> failed lookups is misleading. Report EINVAL instead.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 705b72bf0d83..96d238bfceee 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -757,8 +757,10 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>   	int qr_width, qr_canvas_width, qr_pitch, v_margin;
>   	u8 *qr_image;
>   
> -	if (!font || !stream.workspace)
> +	if (!stream.workspace)
>   		return -ENOMEM;
> +	if (!font)
> +		return -EINVAL;
>   
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   

