Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FCD1DAC97
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992190; cv=none; b=HccSvZqy7Yj2zL329e/N/99cKAW3xzkOndbROWf6Mrlfb3crgiKUteNmN9SC+elCMbkrNVQmMDMOFaPtvGg7dgIbLmdqd1IDImFeT4ANEjzh5WnXEu0jab/t5u7+uoXN4aWBdNb8Wz+Qa+FFQQeM4xTM1TebMLROCHuu3EhVq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992190; c=relaxed/simple;
	bh=ntVumSwhaJ/AJSMq5lpMKpcEKGQpH4Ew1NM6spf4jqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtXh19lhHgDYHHE0mai+OSXjUCd1gA/Ky2T2Ej/7oZHrg/xvEApatOyX6tTQkQXOj0QVPjckmCUQrc3ZlWrjni26CX6e+zsIL6Cld0VvrzCTL/ZkrifYnBUBCNe/PQRkwGTbRMoq9zLGEGbJ+kxGnm6cRsnXfzZkOE2mNcnzUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2CNW+ud; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2CNW+ud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMRlHmUYWwaHNNEginoHKvAMYufYyBuH8PvxpVgns5s=;
	b=U2CNW+udHHiZftBbokhauff/yBdOUSeoRukI5VG5lb1Hnt6VTGz4KBdsnuBQkP++epHZuf
	AMCi7ImMLie2Eb2lge7Gc/cqldIL0d8X1ec3hzTwPzP8lMge2rspVVRh+gvJ4ogEuNmgOC
	cLV3drFZF22xRkUxRULBAd+COJhMfWk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-soh24Yv6N5uCC7X2-TjYGw-1; Wed, 26 Mar 2025 08:29:45 -0400
X-MC-Unique: soh24Yv6N5uCC7X2-TjYGw-1
X-Mimecast-MFC-AGG-ID: soh24Yv6N5uCC7X2-TjYGw_1742992184
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22412127fd7so87244855ad.0
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992184; x=1743596984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMRlHmUYWwaHNNEginoHKvAMYufYyBuH8PvxpVgns5s=;
        b=oKnCTgRt3F61oF/qZy2yp6C6f+Xt+GEyNFe08j5+JF5Z432EK0zycAHbteu8M1qlqm
         CeoBSGJvPPJpxLzTEprPzSDqzr8PJRtEu6QAT2qFnjfDcP1vSQInN8OnqWoE0sL+1sZF
         eUn6ipP3SiwoYlVkkeHVV/cjYT2o+Fz2dFOVpwS3FXInQZKAoj5p5oCTt1tl4gshGacf
         XeDRLf62Kvm64yEyvDS+8CWun+DDimns+4hGdPSaiev6v+iz5JE6gBnoLHQeJDU8GJGE
         M4V8t+Qbz0+W4yjSmYLfGvSfkOgACZMNqvZvEErmaYzTrsQaOjAH5obd7gFORKm5+5Jf
         fQLA==
X-Forwarded-Encrypted: i=1; AJvYcCUCmW4/XzWat5p/oa0dMudXBsX8vzvq1NmjlK9MvZnDAo0UrNes2ybwJf/B31vFwp/5Zlz9AgMn3vBnPCZakg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQQGJTf9+TCZjyml7pwmsV8HseFGzmhrFsI8XmtG0fbxKkGHsm
	/GTsy7lwu6vMMS4MJExuQTyNVmLCUUbpfQa/WHvcQQftAiBe58LiFZzCDMOyUCwAX3b7grgScYG
	P155RET7IpEw+aKOI2DGfMT17GNx+9dz2JCE5AEjnEVgldEnvtyepBkc2XIp4BiPDQqzJqaudZl
	59k/8OfgTFZfQZL9J4BdNdmMq8tEGdfFwB0GgsVls=
X-Gm-Gg: ASbGncvG/OfcfGyz8Rj3mHCIQZ9nOlaZGSC3utpXUEjZPy8Aq6mQi5VwJAYmGqO6jo7
	dwSnkAoiCgu/lUtHRiEpWu0pOo0SZCZWVsKN0QX9vw9cSHZPSMD5Q1pL8s/zoOd1zTAs+4Fg=
X-Received: by 2002:a17:903:22c1:b0:224:721:ed9 with SMTP id d9443c01a7336-22780e2446amr321983785ad.44.1742992183758;
        Wed, 26 Mar 2025 05:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/BScA6obxdH+fi5lo6OhP5kjsw9PXw8Acc3gi2RtNXREI+ba2oImLfY8+smoyPTigQHyCWHLgNMaZmFDw/XM=
X-Received: by 2002:a17:903:22c1:b0:224:721:ed9 with SMTP id
 d9443c01a7336-22780e2446amr321983575ad.44.1742992183420; Wed, 26 Mar 2025
 05:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-5-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-5-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:29:07 +0100
X-Gm-Features: AQ5f1JrI0fIIFk1dBlcZsQDwykZsIVajlZDNhFlQj02eOsxui9idNYaN5yrAcfc
Message-ID: <CAJaqyWexSxnJXEDWQnYi8mnfyWRbfpnr1UP+HV-Sh4HPshC5_A@mail.gmail.com>
Subject: Re: [PATCH 04/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue resize variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fDbC0KA6mkarZKri0zWpzd01gDgk4aBF614dQ8iSuBw_1742992184
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
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
> index 9172f3a089a0..94ce711963e6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1216,11 +1216,10 @@ static struct virtqueue *vring_create_virtqueue_s=
plit(
>         return vq;
>  }
>
> -static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
> +static int virtqueue_resize_split(struct vring_virtqueue *vq, u32 num)
>  {
>         struct vring_virtqueue_split vring_split =3D {};
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       struct virtio_device *vdev =3D _vq->vdev;
> +       struct virtio_device *vdev =3D vq->vq.vdev;
>         int err;
>
>         err =3D vring_alloc_queue_split(&vring_split, vdev, num,
> @@ -2183,11 +2182,10 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
>         return vq;
>  }
>
> -static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
> +static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
>  {
>         struct vring_virtqueue_packed vring_packed =3D {};
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       struct virtio_device *vdev =3D _vq->vdev;
> +       struct virtio_device *vdev =3D vq->vq.vdev;
>         int err;
>
>         if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_=
dev(vq)))
> @@ -2805,9 +2803,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num=
,
>                 recycle_done(_vq);
>
>         if (vq->packed_ring)
> -               err =3D virtqueue_resize_packed(_vq, num);
> +               err =3D virtqueue_resize_packed(vq, num);
>         else
> -               err =3D virtqueue_resize_split(_vq, num);
> +               err =3D virtqueue_resize_split(vq, num);
>
>         return virtqueue_enable_after_reset(_vq);
>  }
> --
> 2.42.0
>

