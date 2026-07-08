Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6243802C
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529420; cv=none; b=eSDSHEyzQ+30+BqIUOTSATOO1pd/+nCmsFtl3zmnCfso72eW+pYFR1GOAysTgwPOgyh221CSQaZMjc8JNpb0QYu3CPftBt33V5kxch0Hv16Ni66i/ogqn7uBuJCfxpc+uMFMPHdQ+kmIhPcXtCltI0azBxbOTG/ms7MTLya0HE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529420; c=relaxed/simple;
	bh=HEXCS7+2myohc1YZaELPgANH9OaRCUzaJ5f7a6XuwhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h1bBXRZ40lZSMEO4kIZfEgqTunyHFN8OQtbGHPLsV+3ZsBb95qjUqV45pTRkd5iDzpvvTa3TZlSi/LjisSDGeCYxDwFbwTDM/XuuyVhHgOMYnupTieheyGAe2VsCA0XysBZmY5gKpNTz8L0kZyVivt7qB6w6yDl7+1BXQpe+iJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CR4kgh28; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CR4kgh28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783529413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iOZxF9JBJJ0HTV1hxdJ54Cs/JFpZYK6OhfeE5DF280s=;
	b=CR4kgh28GW2JJuQiQCOVOVDhBPPPsmGORpuY/MW4mG3wuiv0heukWHxKbFlw/xkVJDtt/T
	bKGnoa385Lg3sZvqbdRCx1HcmMSoZk08nIhLhBns/2aGWhjzszl4dNOuJtzVFHrd6h3jFc
	cHnaDydv4JPObgpL4tlCbJZmCHtI9as=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-gxU6T0IZMQqm_K5TjTOxJg-1; Wed, 08 Jul 2026 12:50:11 -0400
X-MC-Unique: gxU6T0IZMQqm_K5TjTOxJg-1
X-Mimecast-MFC-AGG-ID: gxU6T0IZMQqm_K5TjTOxJg_1783529410
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-475e540a0ffso624408f8f.3
        for <virtualization@lists.linux.dev>; Wed, 08 Jul 2026 09:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783529410; x=1784134210;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOZxF9JBJJ0HTV1hxdJ54Cs/JFpZYK6OhfeE5DF280s=;
        b=Bl0+n/CUA9IwmYCnsJj7fB9YMURx+kmlHa3MmYbZX/oIrDl1B2kI6Mxsg+zbhq4K8Q
         E0SXW0VEw13M0nKvfmiIKSQTSYasDdpg+UpCS/uwfbuJ59DALItI7myAeHgpFAQgzcLx
         JFeoAGwGCHwJlF9tuAH/EN7j9Y6fY7qW5M22qtI96rSV7rVZZ/BE43xi2ZyoCmRladC4
         QoZp7jgQ4ztH0GGzAK+M6IhkbkejZcobxT9ooX+S+gL+Ouhaam3IRs01g68vmgVQr36f
         7mRFzvfUPJouzSFikXInNFaIOCVK4cXUY6zO9HSJHAeQuCbVLnrW6DrjTjmBCZgKs2jH
         itsg==
X-Forwarded-Encrypted: i=1; AHgh+RpHXP5jV21ER5/jzmHVYIvpLRQ6tBjw7ctjTCBiGBDrS/J7rcSX49+tk+gFJy6Xq3VsDea4iX6Becaxp4lOGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOFaa/QIdxZ6vEbO1gRNVq61nmrwzjfnkiqSOiJkFec8emJBJ/
	m8bgQKsAuDvsLn5VeIyeaBbAEzB5FfrNovl2aBnfEmfnOh/+6/Q8wYXIQ6HtaNrJM+RSRiRrZqK
	jfOFPIlsZ3Z4kxYgxWcl+EbL0cJf0oPdc3iDmlEDpiR2jcImYQPu7qIfV1ZR9BKPxB5Hy
X-Gm-Gg: AfdE7cmpDGOBcx2EzEWOJWk4QxSO+1qpyFwt5jZceqe5Wb0l/Sc0MPN2FEXxIUCLEkS
	uMyMGVwJHsmAERT48YDQsi2hsiStbZ04O8CGBAyan2z5maZTjZSd+mGJs05A43hJ2f2kfnwdAJO
	+hIxqHhsjCrRJTvox6TOJMf/Zqd+nO9yBQeFgu/TCkjMk/6jF82jJke6D6m1LSlKLwrL1p7MIlM
	dOc+C5NHJw8ItTdS0KlSqFYnZLg92io7HGEY1DmsL02KHoSGnffcNG2nokgma42ExPHjdCiBl44
	lrcvMq+iu3e9okUfxb6kYOl6o2//JrXN/45cmUwGdjRXNVxFuwNtL8yqzP+RF+wWOsu411mxqk/
	/zoXnsxsGGDmezFNIzaq69t0TxGZFmcKF
X-Received: by 2002:a05:600c:19d0:b0:493:cce0:3724 with SMTP id 5b1f17b1804b1-493e68aed4dmr30880615e9.4.1783529410080;
        Wed, 08 Jul 2026 09:50:10 -0700 (PDT)
X-Received: by 2002:a05:600c:19d0:b0:493:cce0:3724 with SMTP id 5b1f17b1804b1-493e68aed4dmr30880225e9.4.1783529409552;
        Wed, 08 Jul 2026 09:50:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm44408115f8f.22.2026.07.08.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:50:08 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:50:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: enrico.zanda@arm.com
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, eperezma@redhat.com, nd@arm.com
Subject: Re: [PATCH net] vhost-net: fix TX stall when vhost owns virtio-net
 header
Message-ID: <20260708124901-mutt-send-email-mst@kernel.org>
References: <20260708152242.2268848-1-enrico.zanda@arm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260708152242.2268848-1-enrico.zanda@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pVa2JNqEe0_Oz8xgrpO3pVbI4zDN_CFbh81OZJ6bvSQ_1783529410
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 04:22:42PM +0100, enrico.zanda@arm.com wrote:
> From: Enrico Zanda <enrico.zanda@arm.com>
> 
> When vhost owns the virtio-net header, i.e. when
> VHOST_NET_F_VIRTIO_NET_HDR is negotiated, sock_hlen is 0,
> meaning that no header will be forwarded to the TAP device.
> 
> In the current vhost_net_build_xdp() implementation,
> when sock_hlen == 0, the gso pointer can point at the start of the
> Ethernet frame instead of a virtio-net header.
> This results in a wrong interpretation of the destination MAC address
> bytes as struct virtio_net_hdr fields.
> 
> This can, for some MAC addresses, trigger -EINVAL and return early
> before the TX descriptor is completed, which can stall vhost-net TX.
> 
> Before 97b2409f28e0, the gso pointer was set to the zeroed padding area,
> using it as a synthetic virtio-net header. Restore that behavior.
> 
> Fixes: 97b2409f28e0 ("vhost-net: reduce one userspace copy when building XDP buff")
> Signed-off-by: Enrico Zanda <enrico.zanda@arm.com>


The fix looks good:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko thinks there's something something security here, but I think
it is misguided. It's just guest hurting itself. driver breaks the
device it gets to keep both pieces.

> ---
>  drivers/vhost/net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 77b59f49bddb..3e72b9c6af0c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -731,10 +731,12 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  		goto err;
>  	}
>  
> -	gso = buf + pad - sock_hlen;
> -
> -	if (!sock_hlen)
> +	if (!sock_hlen) {
>  		memset(buf, 0, pad);
> +		gso = buf;
> +	} else {
> +		gso = buf + pad - sock_hlen;
> +	}
>  
>  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>  	    vhost16_to_cpu(vq, gso->csum_start) +
> -- 
> 2.43.0

