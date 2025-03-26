Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B41E1E16
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992309; cv=none; b=L0oBWD+bGLypH/U8yY/9BGOZ+8hM++EbGab+oKXAVEgpLDDYkVFWZJ58qe8SV0XctaMfOcPC6kan9Fz2Bmx8diXBDnh+TrQ7SCIz2/tnpVRR+DNb+7S0GJCCkQ6uIIB/JeqITJFl9uTZxhDCRh3/+0lGz/JiKrUhKLxYJSDoCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992309; c=relaxed/simple;
	bh=j1PgJNIW3viI9aUjPkcKwLkz/LrCzWVeZgttB5sdsZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBY6EAF9UoraKOxIgFUyGWmBhZlHPVpC0MuAHK9CUC+8JEuzA1bEL1gZFSoDzQKiTYfGFoZXcQ51t9ROWCfQJ+3zJegPkXSYBVwB/fqEzwi3yObe89NWaK5BwHcGr6CyPWQKpvTKZboKSHd/UaKtE5QPYJwO8As2jgs2n+3armw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDnx6/Tg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDnx6/Tg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iml6swh0i7lBeQVcG26hls4lzAH12sEjWHyxF8tp8XU=;
	b=JDnx6/TgpRh4Db0Y9ZZ4SXtpi8FV1LS0yzmaCd2zdhXVhUIsJxmQhjoDwu/IMW+lZLprKS
	y1ilUOVXnM5qxyDnqccV9HNkDDihGxy9O409lXEJWPOR4ok3NFe8OkYMonEcaLm9xpLkli
	AmCs48zGcJmFuyDV3OO5Ul2hZlLej0s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-TVqkzycRPrmqNwAgk2f_uQ-1; Wed, 26 Mar 2025 08:31:44 -0400
X-MC-Unique: TVqkzycRPrmqNwAgk2f_uQ-1
X-Mimecast-MFC-AGG-ID: TVqkzycRPrmqNwAgk2f_uQ_1742992303
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so19207231a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992303; x=1743597103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iml6swh0i7lBeQVcG26hls4lzAH12sEjWHyxF8tp8XU=;
        b=kM67igdlkwpOWFyKjIq+vmSUhxgpKmT6pbEGi+U2s6jPUzCb9ZZ0CNOCiTlOPoswFt
         X9KNiFX2Eb3uXbhPvlxybSFABjNnurG+ycir5mtEIFBpRmRS3zQmdw41Vj/VWqY8VceI
         EpkEL/fn11/4bhqazT/V8wgOtSjKfz08jBldgRDzaS6tY5ju9Eok6cRz5TYeUxSYwQKs
         sDPnFM0rfXIP7BqdVsBhjaM3AZ2v69eVRIEiuivowovpsw9rz6TltgzouYHSvKXDmqBv
         FqpDr4oFIbrjhdWvYaiaxPTmuxEaABVV4Jrp/scC6EoYw+UjVsDcDxSrQYpTVICpFqJN
         EXJA==
X-Forwarded-Encrypted: i=1; AJvYcCVoXeBw9QS6sRuPUvCSlyGrOyMiGmjdb86wgY8Fmu6mCjWVgFfIuELnL+rP1kpxvvAJ172/KbbSXTpmw8m1BQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq9vPgYcBn6fGAEzj0VjoZYy7pfEROS0yz9FoXGgGVT8xWZicJ
	lqU2Ih5g38WLt1Ow4q/0e0x9GdGxdnSC37We+HC5Z+Oqt5jMLZsPq/NyIDkDQ3s+NE2yDxEIXhQ
	SlNjWedKiONF7Vt7YEaE7BQZpUrs4mFJdQE3tREpX0+AQ/UrsP8AU7MiH0AIN8XbieXmPVHNCjz
	wO++an0d7MzXSymOB2F7H5aDnW5JGuKxRlDpx4iEM=
X-Gm-Gg: ASbGncvFM2i1/x+lzgcOlPVcTMz3dhlI5w1J58jkfmoJOl7dnvlpKVYvxrUumEKGeXu
	BlN84sRLpFfHotiTqCOllWUL4BeUllBc8xk/Kq3qS+bhCvtnG1oD9K9lv0RAd8ak2gMBNxA4=
X-Received: by 2002:a17:90b:2647:b0:2ff:592d:23bc with SMTP id 98e67ed59e1d1-3030fe58cc6mr32759829a91.4.1742992303327;
        Wed, 26 Mar 2025 05:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGVFQzn+Y0z6JNs/or65j22c6R82kHGtishESvAExGqtxlwrwA8tRNSq9MhfHCoOvDPTzRqP6kI11gRu69gT8=
X-Received: by 2002:a17:90b:2647:b0:2ff:592d:23bc with SMTP id
 98e67ed59e1d1-3030fe58cc6mr32759796a91.4.1742992302862; Wed, 26 Mar 2025
 05:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-12-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-12-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:31:06 +0100
X-Gm-Features: AQ5f1JpmUSjk9F5tsDREnBeJZ7NTPykh0XX2gC-sNmEouR7JUIoBSu8q5nZyCJs
Message-ID: <CAJaqyWf-=xnNvO3SjCEH1wBd+es3GJEOEdGsi=sndPkGwtcQpQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] virtio_ring: switch to use vring_virtqueue for
 detach_unused_buf variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ruIxpn-YznkVMDdVFXUJkIPdjIYL6KNniytVp1EM-Wk_1742992303
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

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f754da8c2ac6..19aa24d62d20 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -950,9 +950,8 @@ static bool virtqueue_enable_cb_delayed_split(struct =
vring_virtqueue *vq)
>         return true;
>  }
>
> -static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *v=
q)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         unsigned int i;
>         void *buf;
>
> @@ -965,7 +964,7 @@ static void *virtqueue_detach_unused_buf_split(struct=
 virtqueue *_vq)
>                 buf =3D vq->split.desc_state[i].data;
>                 detach_buf_split(vq, i, NULL);
>                 vq->split.avail_idx_shadow--;
> -               vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> +               vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vde=
v,
>                                 vq->split.avail_idx_shadow);
>                 END_USE(vq);
>                 return buf;
> @@ -1892,9 +1891,8 @@ static bool virtqueue_enable_cb_delayed_packed(stru=
ct vring_virtqueue *vq)
>         return true;
>  }
>
> -static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *=
vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         unsigned int i;
>         void *buf;
>
> @@ -2642,8 +2640,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue =
*_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) =
:
> -                                virtqueue_detach_unused_buf_split(_vq);
> +       return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> +                                virtqueue_detach_unused_buf_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>
> --
> 2.42.0
>

