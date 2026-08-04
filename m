Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C83FBB72
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813659; cv=none; b=hkCZEvGHD/hRpZUrpuPkQio2p/ujxrr1GkVwQNTr78oogqRPF3bmZHZP9jY/1FRFJe2/J1sanygayRRrBBBDjDHi1Lj6cD7y0ZLL4OcnP86WQveWuoocRg6aal5WjlF2sHIbMsSsOBdnG7AXzu/vAexPaxXpF8d1VOcwjW+d1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813659; c=relaxed/simple;
	bh=tqZLOsTLaD2Vkl2fHPJf5w3iLf3P6mTDx2svcOIN6lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TRXecWIme03ZGRhE4gN9BCowEpd/9FiozME6mpv4c+vpqg+gSJm+VuvmYg0f6/c0fWCw1+fUriGGQ+igpDXU2jWkjwQrh4puFbSYSg2Tbr47xBguaZBwZcolJV9Q0lNq2QxwpD6lzQ5jckhicT1g7EAxrRd5eAmombs4ze2rqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agVPE6p3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agVPE6p3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785813655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=En8P5t+/b7u5WFGgCY07au7/iBs4q0cXFNe6Tnkfb0g=;
	b=agVPE6p3YbEixPw22g6NSNNx8UXQStf29ggMqQfvORi7eZKjU9Mo6TyOqCMr5BTSX9BMRd
	ZKy3tWnURvsMXCADp8XPoBejhe2rrlp/umZShZyDzjDu0VLJwWQzSL3LRRsDTW/VcUpmxG
	WOUI4DMbA1LaBrvF1mRHgioT/tJW+ls=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-P8iIGYELNyui4Siz6LNS8g-1; Mon, 03 Aug 2026 23:20:54 -0400
X-MC-Unique: P8iIGYELNyui4Siz6LNS8g-1
X-Mimecast-MFC-AGG-ID: P8iIGYELNyui4Siz6LNS8g_1785813654
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15f0aea084so313521766b.0
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 20:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813653; x=1786418453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=En8P5t+/b7u5WFGgCY07au7/iBs4q0cXFNe6Tnkfb0g=;
        b=Y/vOWZJlBTzLSHP9S1ImTQj2+oUZfAnJVLiVFHR/WMZYpWKvFcpYoLOGqVcAYzifnf
         6bCUG+vL+kkRhAdSVfpGRwGFxTrxulYrl/bcEnOf+9pPrxjEbbPE6CiU2NguJi8p1iHF
         lAoZsLr31OtggBVpEFK2bQ59OXMLLmkxwsFQdXyD9fw37+nXVLiz7W5ePIhXEAoWU1kf
         gnOEsqCGOcG0yuvsQAvwI5exFsZN/un/aJ4V5iyo0K4jzVF8HPKogmENUBC3iTlZGy3j
         GeFO5c5Z1YL+kE1I/7V/knFmjrB12hovtC6yg1UHp3DNI0/JVqHuYs84xk9adrN9oF3H
         Eh7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpJ9Dvxcx1OFql+LTSfSToqqyrmz78QvLsnJVAlpH1AUKdSU2U/sTEHf3wUGFq3swFdPFcFsMPSJC+k7fhZSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWiSQdvoEdmSuc/rIkD5YVnGigvYk95wp4tvLDuTPtTOYlugeY
	D1DsYfHM/AYGyrWtaVsZY4dsuQHqSWo8NUH9GZOaYAId+9d+fGYWZd0XbVACKd4xQYVzixo8F/b
	wl27LwpRYLyLNFbXWtO10tK6GtiiHiVPVvEUrTSiINUAM5iZuktB2069NhxHKTJS4NcCz
X-Gm-Gg: AR+sD11GgH+mmyZvi0xXzx0mJaQhRY86LP97uJrx6ttPO9mBhGbpXTAHAgbC3DZ0FlX
	gz4x64Hf5TYrGLdVyTPsdOKKdWipSzyp17kKC/nmZjx1Wf49UD6LmYGz3ndUIxu3D3LrNcJx3cW
	QISMaTufeI+ytOy3OP2mzHSxmWE0Lj5z2gNV3bpe+n82vMGZWANUAS3jvHllEuAn6/0xWe5/17u
	OkLjrMk3o+ow/FrJ/OC6OLTYmsSY7OXg0tf9eRPZR3d8zqZYD00Wn7UtsTg6nj3C+VJqWf9yDHa
	Dy0mBy4yYKPLCW+ARWuLSDGLJpHnR3x75XA6csW0gbPnJxlxi8eIkrIDo+vydVpRFpg+
X-Received: by 2002:a17:906:fe49:b0:c19:4ea0:f4a3 with SMTP id a640c23a62f3a-c1fe8109d66mr946358066b.22.1785813653529;
        Mon, 03 Aug 2026 20:20:53 -0700 (PDT)
X-Received: by 2002:a17:906:fe49:b0:c19:4ea0:f4a3 with SMTP id a640c23a62f3a-c1fe8109d66mr946355866b.22.1785813653094;
        Mon, 03 Aug 2026 20:20:53 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b8c7sm641983266b.9.2026.08.03.20.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:20:51 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:20:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vhost/vsock: keep IOTLB across feature updates
Message-ID: <20260803232008-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260731103414.1746316-3-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jwBniEptGRtmFKyny07i0Ajs66khA-EOX5pY4x7fbj8_1785813654
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 06:34:14PM +0800, Jia Jia wrote:
> VHOST_SET_FEATURES is also used to update logging while a device is
> running. When ACCESS_PLATFORM stays enabled, allocating a new empty
> IOTLB on every call drops valid translations and forces avoidable
> misses.
> 
> Initialize the device IOTLB only when one does not already exist.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>


You did not CCc all maintainers and lists with this patchset.
./scripts/get_maintainer.pl -f drivers/vhost/vsock.c
will help find out whom to copy.

thanks!

> ---
>  drivers/vhost/vsock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 562b9e139a76..3703fd219039 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -893,7 +893,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  		goto err;
>  	}
>  
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    !vsock->dev.iotlb) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
>  	}
> -- 
> 2.34.1

