Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B563C3F4C
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423087; cv=none; b=Bb03K6dDFL9D63eMgDugGSlOALwqbc978LBSkdDgPs2x9yrN9rqYiEGewfEg9kovVeEG+dkT00hS13nHGzFNi1aVi5V8f6Sf5vTZJ36KWKOCAdM5wozeA+TM1hHV4prFuys4TTjPaz0Rdxle8qibMZYnZY/UcwrtA9QjXm3KYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423087; c=relaxed/simple;
	bh=tUIAFR2ZSygyso4Eb9U1hdNssTpLdhR2q00ylJ7K4MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tll94upZD/50BYwP1YnW3MCsi9H33NGUpbSJIcDUiLri8Va9JOfh+IeclaXrx6cO7K8TWE+27fLH2f98tqAjb4xCCNbk+A48JOP0k7KshX1xsP3IElg6j87e3dSjlMfu3MSAfOFx6tyBEijM8Xig/3IJMMrEyGspn+wH6H9MUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euq+Skny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euq+Skny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785423084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3zt6XkOgWd+IfIfzdQFphbvcN6LQXkbPFo9WHWQNv0=;
	b=euq+Skny6kDVpsPxKeiEKTU4l2HLgL85DbDYe9KbPdKDcfjxmeqakGVM1Ohb3oa1hMfGKo
	kZzTZZ+Nv/ZBYwdOqZ4Ri0w8+G6GFnpCYAw8dzj/rta/Tj7I5cHUX9ebapaoXqoaDMFoRf
	8E1dUqZLd45GTBZXUlhsBTmNyMB6hJI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-SlVaZVeXMPCLG6W-BDfSVw-1; Thu, 30 Jul 2026 10:51:20 -0400
X-MC-Unique: SlVaZVeXMPCLG6W-BDfSVw-1
X-Mimecast-MFC-AGG-ID: SlVaZVeXMPCLG6W-BDfSVw_1785423079
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496b6f97676so24573875e9.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 07:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785423079; x=1786027879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3zt6XkOgWd+IfIfzdQFphbvcN6LQXkbPFo9WHWQNv0=;
        b=Bl12nYEGem4UwbWyOjyh945omVuXRs4vPdX/nBv+ga5xFDRrBI6MR9tPraEFnXjoki
         huJHUFlK0DcINWQAYn8HQ4IzwMhlYbK6wGKf31cjmJL8vaMDqP9V5mYw0C9CAQ1fYMkE
         lCSq9a7D+7cOfzfZv0fkfENxkQkFn8ASrXifFwaT1pzuZyFiNsaD9vp5s3DK/Wmeqjr4
         /WxdsqMPye8EFFjvGPlHdggdSEgOwZsPOdySuGAnMoo2FVaIOmvvdKtEeS3jjbs4Hhge
         WxM9GkzZozWx4LooPXqcbYTaElLRBnrhkKxi07pAXcx/7ZLax4Iw2Xf21t//63BsOl8V
         EhnA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3pMmFEj6sKKHZQCrRG48WvuQf7xasJEhBRovtKnDBKrHmy3xs87KhMsHMREROPI0ZsivIqP3yU1gbAQuxxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7WbL5G2epYD90b85EO7S/pTAesqtr12W+I8GqLhLT6fz+Rr0K
	hSS/LUAZBF0JPwyVdhb0Y8E/EbsGhkiOic6hioqQAxFW0p6wbsrJKemqxxpPlzzMhKpI1P20YKu
	7LhGentkBKWY7aE25gaj7s0wWx2e7YhnLvYmdnXk5rSvTOv0V0s5Y6TePJnFa1gdyrvdO
X-Gm-Gg: AR+sD12Qwo6PhYPgQjFuzvX5KXYtPtOg/oFVn3XmJA6h32JK2hlECVjJV5sAWRsBKvI
	UsY84rd2T//J6/15Pa/kNEK3kgF7Lv6Qn3V+kx5+F7WQcTpkT+ADfs8VfyrB8LDogm12h+BD+VD
	PrpSavWbEO40hO7onkZOmNzWAhUbok9dejZf+7WhJWBp1YrKTBlSk7pkR0ugrdm0FB46ds3wEbB
	7xEBet5lvb64zd3l2/wyWq1QP8FMJrPQON0csUphSV7jFmTiPdZdjYzqr1m4d6yKkZXqMknx0CB
	9rLEVDvSLy1YwjVm/oMY4e7u7iyfcmnax8jx4t18AtPDfNhkrVXRrBpdTeP+mJKoA2pam6JFSQy
	XFlC0OJ837BlTYEr1XllTlc0=
X-Received: by 2002:a05:600d:8444:20b0:495:46dd:e238 with SMTP id 5b1f17b1804b1-49800ebd355mr30260675e9.30.1785423079321;
        Thu, 30 Jul 2026 07:51:19 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:495:46dd:e238 with SMTP id 5b1f17b1804b1-49800ebd355mr30260275e9.30.1785423078800;
        Thu, 30 Jul 2026 07:51:18 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011f2b45sm65069295e9.4.2026.07.30.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:51:18 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:51:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, jasowang@gmail.com,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM
 changes
Message-ID: <20260730104857-mutt-send-email-mst@kernel.org>
References: <20260730040938.1725757-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260730040938.1725757-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PS6c2vZeRT-ddcegvrfNbw2uDenFxUXPYwt9jyJIxow_1785423079
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2026 at 12:09:38PM +0800, Jia Jia wrote:
> vhost_vsock_set_features() initializes dev->iotlb when
> VIRTIO_F_ACCESS_PLATFORM is enabled. It does not remove that IOTLB
> when the feature is later cleared. The virtqueue still points at the
> old IOTLB, and vhost_vsock_handle_tx_kick() passes descriptors to
> vhost_get_vq_desc(), which translates them through that mapping.
> 
> A userspace backend can enable ACCESS_PLATFORM, install an IOTLB entry
> for a payload GPA, start the device, clear ACCESS_PLATFORM, replace the
> memory table, and reuse the old HVA before submitting the same GPA
> again. The feature state then says direct memory access is in use
> while the TX path still uses the old IOTLB HVA.
> 
> Reject clearing ACCESS_PLATFORM while the device IOTLB exists. Also
> keep the existing IOTLB when a feature update leaves ACCESS_PLATFORM
> enabled; VHOST_SET_FEATURES is used for runtime log updates and must
> not discard the current translations by allocating an empty IOTLB.
> 
> Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Thanks for the patch! yet something to improve:

> ---
>  drivers/vhost/vsock.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ae01457ea2cd..57e8fd1eb670 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -798,6 +798,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>  static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  {
>  	struct vhost_virtqueue *vq;
> +	int ret = -EFAULT;
>  	int i;
>  
>  	if (features & ~VHOST_VSOCK_FEATURES)
> @@ -809,7 +810,14 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  		goto err;
>  	}
>  
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    vsock->dev.iotlb) {
> +		ret = -EBUSY;
> +		goto err;
> +	}


I don't know if this will break anything. Why not just blow
out the iotlb? kernel will rebuild it if it needs it afterwards
for some reason.



> +
> +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    !vsock->dev.iotlb) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
>  	}


This part you are fixing is harmless. Let's make it a separate patch
and document the motivation.

> @@ -827,7 +835,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  
>  err:
>  	mutex_unlock(&vsock->dev.mutex);
> -	return -EFAULT;
> +	return ret;
>  }
>  
>  static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> -- 
> 2.34.1

