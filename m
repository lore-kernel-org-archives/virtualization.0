Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA91ADFFB
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991024; cv=none; b=X4IHTvzXHvUmclYIgG38PXUckQiENpcGHIVh0KnsuU9L4IjAZIb6YD6O6jiyUV34BxFDX4apC/YEkXysWZHHtpRAd2dNzfRaikSwcnAIKbbApctBu/F0gin6LN9/u+2/oiNp27mxPm+WZYwdBXepsSvTk+A9d59AQa7EYpHtwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991024; c=relaxed/simple;
	bh=F9NkXN3+3mSxqFATL7Ique1FBSyTWtcZ9Qx0/UUpSjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9Y1jpjIxQB7dbfZFU6b/1oZ7sTFC3VTwag3XRo9sUP9zTz5t66sMidBzksik6BJShiABjv8urj7lSNzB21v+wLLwOMDKOiYfDokjDmo4mOUH3JNbzQf86eJY68fM4Yr06B+uWt6K9cSoRYT/tuQujZR7dTsI8MhEjwbF1ZRLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xd2O5Amk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd2O5Amk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742991021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcGJWpgvB7cR9K8awWQvPQUtNpQ+EuhR+/yBYj13d7I=;
	b=Xd2O5AmklAQy43ni8nFuRPiWcF5yW+CRypXLBR3Kaj9CwZD8dqaFUgW5MHMxdZQvDQRElO
	P/MXBScBlytvhFwIthccVdfnUMSRpy2IF1s7jyYaFX8kdM/7JgBWqzRIyJuNkC3YE5o2i+
	3iB41u+7bloas2BCjdQ4ljj56bXR8Ns=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-q6zcOUWTP5yFL2oBX6YNqQ-1; Wed, 26 Mar 2025 08:10:20 -0400
X-MC-Unique: q6zcOUWTP5yFL2oBX6YNqQ-1
X-Mimecast-MFC-AGG-ID: q6zcOUWTP5yFL2oBX6YNqQ_1742991019
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22651aca434so116808245ad.1
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742991019; x=1743595819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcGJWpgvB7cR9K8awWQvPQUtNpQ+EuhR+/yBYj13d7I=;
        b=hl0nNBPT8ecSOqdQWxFJ3CeN6Zs+52JFmWMO1rLBiYuvv8HS4Um7zt1DDJ5kl/IlEf
         ub01OJJeagOtVUiHzS/CjbrKGgXi3xSIIecVhPsQhbvEMyGdGWXmALx073vJ9fSpHkgq
         4Sar4rIqf8xUAJeN2IVkug0rcsHhUg6LNKLU9nBKDPDiXaU4WN5SORYgjxD0KxSWPvz8
         PHpAse+TCirh+AEvM9P2XgbrJDO4mF8mbkrGdSiyGytE9g5lvLobXhKKVn27ZDLhCJA4
         UuxqGUg2BiN8C6YEQVkyppUHLB6phatQuKSs2reU41xaA4IojmAmStehr9sPT2aoO87A
         QMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp/pGIobCsKgZwQADmEZJmoRkdskjnYR5Tr+DyhL+nBSLTwGGd9M0KH0xRBYltfjUmaxNU0BXfBf2My6izyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlfY9pjkXDh0X2mC8kkexzVdmnWX0xeqE3zzBnnMzN8b8Qo5M9
	JY1vwst8Z66rzIdDDUbvpEr77rMWlL7bt6IKfEW3ndcsaurspv0H3hfERJtu9f4v7asx5bsX/q1
	nfYp6kfRI7zd5uTqGk0b/5ICgO5eGZg61ebCMyCgcF/7UQ1AmJI4wO77eyGztA+s2cM3wZQ6221
	BCvr4vktyVssl3qx9A/kwyLln8zwc0Y5QRPmB61Cs=
X-Gm-Gg: ASbGncshkS0qDNzGhcE1c1riUcryeyFVrMHVIP0qNlh/81jaOLx65BWgH8bVKLGISrM
	90alGX0PxvusQJT8zzqBWvPsLDo6pMqkqoSwp4W1JOlHduWp9Sd584bykndGKB+bSGhPbJyc=
X-Received: by 2002:a17:90b:51c1:b0:2f7:e201:a8cc with SMTP id 98e67ed59e1d1-3030fe9813fmr36183348a91.18.1742991018904;
        Wed, 26 Mar 2025 05:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtQfTAGm5C6XOVxYYLBpmI7+04qg80NAMnokLPeZTq/I7QFAdx4qLkUYRkyuFtlbrk/t60xlA5loC8rlTSNUI=
X-Received: by 2002:a17:90b:51c1:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-3030fe9813fmr36183302a91.18.1742991018383; Wed, 26 Mar 2025
 05:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-3-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-3-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:09:40 +0100
X-Gm-Features: AQ5f1JqC0hnrWGaA3sp3od-ThhHz9TM4qIjLtia-sBN2x974Y_RgMTmcnH5DHDU
Message-ID: <CAJaqyWe5LxgVGj-g0yeEgQ-_r-+z4OnBaGkdy-VcqTjxV9hRBQ@mail.gmail.com>
Subject: Re: [PATCH 02/19] virtio_ring: switch to use vring_virtqueue in
 virtqueue_poll variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mNPZVRz9GOCun1dNLKouFsPRNyvlNDpmzYAsPbAk7Lk_1742991019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:43=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1bdfd5d617a7..1c6b63812bf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -915,11 +915,10 @@ static unsigned int virtqueue_enable_cb_prepare_spl=
it(struct virtqueue *_vq)
>         return last_used_idx;
>  }
>
> -static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int las=
t_used_idx)
> +static bool virtqueue_poll_split(struct vring_virtqueue *vq,
> +                                unsigned int last_used_idx)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
> -       return (u16)last_used_idx !=3D virtio16_to_cpu(_vq->vdev,
> +       return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,
>                         vq->split.vring.used->idx);
>  }
>
> @@ -1845,9 +1844,8 @@ static unsigned int virtqueue_enable_cb_prepare_pac=
ked(struct virtqueue *_vq)
>         return vq->last_used_idx;
>  }
>
> -static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> +static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wr=
ap)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         bool wrap_counter;
>         u16 used_idx;
>
> @@ -2608,8 +2606,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned=
 int last_used_idx)
>                 return false;
>
>         virtio_mb(vq->weak_barriers);
> -       return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx=
) :
> -                                virtqueue_poll_split(_vq, last_used_idx)=
;
> +       return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx)=
 :
> +                                virtqueue_poll_split(vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>
> --
> 2.42.0
>

