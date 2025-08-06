Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAA1A08BC
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513342; cv=none; b=HlRrpzlhialPosktjlkgMayLHiRmL+mVBN87rwd4wUwGSEmu8Bl6Z5eGQgxUyTc4fActHFj/P6NhnfFdZabr9+ae/0dmyPi6/6m+3dlLfi6398PK42e2bvYbUtzCUlNxaSoXLW/tZjqDANr8Z9xxkGaQILh1CUtXdl6DITFwYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513342; c=relaxed/simple;
	bh=Z7gnSoFpXMZtZYmB+pSje8VMOdscPp38/iGm9p4yLMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZtMEbnuusbZTKtaqdulrqAt/3/27u+VpsjZRs0EkwHpP028QZEw5mwjbIpmbDjabuaR/ifAghuM7cihNar49xt3dAKA4oL4QaGrv8eeZvbTAwHVqHbxwKiz0kaq9OXtVF2J8TnW+zI4NAtrpnDD1mGQdomoSdSctqDypyTG6Ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4trX4Kc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4trX4Kc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754513340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5CGoQnB77NbGRAfGUH2qulvf4J2jjsKcFyT5XT1q7y8=;
	b=g4trX4KcNtkWGq9WL4hn557oh6Bc3kOIyDqfXnUdk0SdYSAPJJ4emAn7SomSXqqtveHfdX
	ZA+2BzfQjsxpjUOc9pOmb3LaaU+UCRok9tb35KkZoPGU7upxiNKltQsJfhQWt/tKLnUzHP
	kxW2/fFhGtN07nh3idISxSLD/U3TGD4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-BYCBN_WHP4W2m7a0YY94JQ-1; Wed, 06 Aug 2025 16:48:58 -0400
X-MC-Unique: BYCBN_WHP4W2m7a0YY94JQ-1
X-Mimecast-MFC-AGG-ID: BYCBN_WHP4W2m7a0YY94JQ_1754513338
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459de8f00cfso1175505e9.2
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 13:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754513338; x=1755118138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CGoQnB77NbGRAfGUH2qulvf4J2jjsKcFyT5XT1q7y8=;
        b=PtNwRWxHp8xGdv4ZgC61p9vEpreH5asB41tsGnvlVOwk+zWX6SDOcpM2hQOn1NdXjs
         ZRZh0iYDVc7mWWnTgJCtPPMVrSd22KeaB23ToNov4sXoia/UqfSieOOmOTnz/I9+lk3X
         /inpncceRCl7SEH03s8fVHWn39zS4QxCsO/tm70+p1OfJBZ/B5loZsYPQys0YfDlmcU1
         0e/kTsF7KYpPspP7FqgPqkxJaCLORiTW5JQr7/UFgAmqPRlhdwwTVBgGTypyLLawF0DI
         XzcdsExWIDZhyQ4H5DjZHpMeUjqaJGMock0YGV37/b9cVXa0OB5Ix3CYcEhGE3EbKGUX
         ZBNw==
X-Forwarded-Encrypted: i=1; AJvYcCXWyd2uwhcmjsVOAgw3s06GLZplwc8own1eGNUK9SYZ/hw0iRHke67qXJuc3LJEdfEiziZvvfnRYzDqEsjSJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzgw9iGmuIIoByrrBrjs2XZiMvcFc+Lgv1amvhtps19fWjqefaW
	bmh4eppyvzQrVkFY/u8rJ/Sx1pGXC0bt3JOrZg5UIpahVM5VzqX1YDCbj+3rs88tH4YMG39JsSl
	bgdy6wbWRGOxymmHz9qX+srIfQnYJ2N0v+hiETR/Vg5TvRSMdiZWeIP0tovCly6gCBZDZ
X-Gm-Gg: ASbGncsJVL28Bsc/KwOakvPCfJMKHEl93u3+JYBzHcBvr8a+Dxz/ljAu0K9RFrSyPw1
	tys3oenEflMrggAurMxlUpaQXECRmTR9OXMNF/W8fptrw9jP3Hj6E67xMKUhMtMSz6hEAmmjbRi
	aXYRc/wz/Trq/tFU/y3mvY7GizYcGBtNSLq1pnbQChrw/Nd2Tiaw17dYHt16fTnGioypCMtjPG/
	rF1daSdndGJdbSKghIFEIwUUkO7+0ENPmvjpPmmJKRtzkGkUfY2IFQ7cEWF26+zjW/gjtqnsf3L
	oUmU7p4yv0hePqhJQk4467bCaIiFWKN6
X-Received: by 2002:a05:600c:470c:b0:459:e370:d065 with SMTP id 5b1f17b1804b1-459e70b2429mr40363625e9.15.1754513337786;
        Wed, 06 Aug 2025 13:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAWOenh2BJ1jNIk1Hu3XA4xplelNQQj5MxVZI3HYDxDv88AShmWyIFdUMijf06sj2dUKS8qA==
X-Received: by 2002:a05:600c:470c:b0:459:e370:d065 with SMTP id 5b1f17b1804b1-459e70b2429mr40363495e9.15.1754513337417;
        Wed, 06 Aug 2025 13:48:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4532c4sm24061086f8f.36.2025.08.06.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:48:57 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:48:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_ring:  fix uninitialized symbol warnings
Message-ID: <20250806164805-mutt-send-email-mst@kernel.org>
References: <20250806124101.3574834-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250806124101.3574834-1-chelsyratnawat2001@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -CWy-N4GlsN3AJwiViOzNdWiegnqIN4xQsBx0B8cK8A_1754513338
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2025 at 05:41:01AM -0700, Chelsy Ratnawat wrote:
> Fix below smatch warnings:
>   virtio_ring.c:1566 virtqueue_add_packed() error: uninitialized symbol 'prev'.
>   virtio_ring.c:1574 virtqueue_add_packed() error: uninitialized symbol 'head_flags'.
>   virtio_ring.c:635 virtqueue_add_split() error: uninitialized symbol 'prev'.
> 
> No functional changes intended.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>


Sorry we don't mechanically "fix" warnings like this. 
Please analyse the code and report whether the issue is
real or a false positive.


> ---
>  drivers/virtio/virtio_ring.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f5062061c408..03aa08aaebed 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -540,7 +540,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, avail, descs_used, prev = 0, err_idx;
>  	int head;
>  	bool indirect;
>  
> @@ -1459,8 +1459,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
>  	unsigned int i, n, c, descs_used, err_idx, len;
> -	__le16 head_flags, flags;
> -	u16 head, id, prev, curr, avail_used_flags;
> +	__le16 head_flags = 0, flags;
> +	u16 head, id, prev = 0, curr, avail_used_flags;
>  	int err;
>  
>  	START_USE(vq);
> -- 
> 2.47.3

