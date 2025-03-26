Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F441C84A3
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992291; cv=none; b=kG5qz6FRvwR+zPOi81rbLbRHdr2Wd7BXhJ92vPkKQmN6ylc+n5/sMa2+yT5OfUJKHQ5aakHCIgdQS10Z2P35s6z3IcUI28UEl0t69hs5QW+ZZaeMyHpf2v7rqXSKthET98NU7l/tC1QV5Co55l1EaOy6VhnCxDVEfsr/9AZkH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992291; c=relaxed/simple;
	bh=t74iHA+M4wl4kWnwqstGGM0qACSyeEe/IR5GMJWVfMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBSv4QfkCKgYWc2a+yWYnzSU9NZ6OFiF+hLNYE1og56UktcbOShj+zbQrP0PSLgHjL2BGL9g/92s5nhoOyht8Vj/SgElyIVezE2ISnTgT2JAfsm5DCJUnQ7kiTcygfQiXgKqadtpgoNfxEZni3uF/j9plWEUtv60YupJNdGZYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hplSWUKv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hplSWUKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxzZXRNdXQx6t4R5itiH8YDImrhRWKf4Xk6yoiwedLI=;
	b=hplSWUKvoNArLc2VaG2zgS6iPvgZkqwpExWJQoafj4jpSnChqwWPvI47l4mt7caYBBS0Lj
	n6QwTpoRTen5VaTYly5tetrGbjJ+NyBtGws6AYmqSAqdFz9sKUv9v2tEZ+In+PcIaCxfD9
	3AigQKLE6u/yB6zYvd9NjYG5hvZIVGg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-OrcaTBXyPi-aKUS9d3Bu8w-1; Wed, 26 Mar 2025 08:31:27 -0400
X-MC-Unique: OrcaTBXyPi-aKUS9d3Bu8w-1
X-Mimecast-MFC-AGG-ID: OrcaTBXyPi-aKUS9d3Bu8w_1742992287
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff69646218so17834509a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992287; x=1743597087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxzZXRNdXQx6t4R5itiH8YDImrhRWKf4Xk6yoiwedLI=;
        b=ANSttwXA+kYdBbz0YfKekQUxFZA/AYbsKely9paTGqtpGdWJUx9QePBlJJKv4wal4J
         4PGCXwENIe8/Rzc1PR+oZpoKQW2a1T1UM+9JVxDJKZmi+ZhSzxNA/nbthLAxM0Hkrrfv
         GNLjeJMKDNDEBPxK/zz6PaCEsK1v3y5KteaVEJy5pcGVKPfjCejsFVpyBs2WnPeujnG5
         EM7bFYqyDn07tuHk3jXk3DswRnsUHBD11FACec1zZPtIpe1i9YpGolL/bQGOOIsPKGBW
         LacHA5c4LnczI63TL7gg8ahJ61Iwz0WhcZr69XF2V/GhdQeCcaJ/s6nvo8HKyxrQvxkN
         QDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYtxq+YbwsM2kNEOoOoXNcvxTzTqHbeDOJJGUX17c9u5HOWZ8AejWM5v04T9Lyz9ko0AT0s5PA6Jiwm6Cq1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtWMtJGNuqQn6FxQ6IdM4ox7czIKV0w7bAVkUDqQuygnyXxQk8
	ZqypTHErP5fjvdPhYBJ55GoMdrYgQacRWZlVBSi+xQBDuy9s7/y8ePwi3At1NkXuGtnVKefvMup
	+rqtRfmfjeHLqyGScPeKHT+HScHHd3L+HjiZvKdUAbUX35Z9fjqLgkl7yAKt7vN/060NddxMLoN
	wJz67Qql5VnMRXTUSeHuetXBJaWSWEUQMHSyDzFgw=
X-Gm-Gg: ASbGncsmvLzO7JLvFcdGrlYcFFdzYZSuTNYVtm712eQCeafIQB1SehCwNik/3EYSqwA
	jMWKlwdoxZsbpuYQDHkDwnXMxHSV+SSVEjWKjk8iXAdLQNgeChaettToYErlbkI9fob/GrQY=
X-Received: by 2002:a17:90b:3947:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-3030fe8f4cemr34792338a91.10.1742992286599;
        Wed, 26 Mar 2025 05:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQa+dEBw3ucGCR/0q+QuWfL8BtEzdB9rSPV8AV8eO3X1snIMfP4GQqIXxffOzgvCVRbKJR7J+8/tCPfod5dbo=
X-Received: by 2002:a17:90b:3947:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-3030fe8f4cemr34792267a91.10.1742992285996; Wed, 26 Mar 2025
 05:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-11-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-11-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:30:49 +0100
X-Gm-Features: AQ5f1Jqwb1hNU78UMFS7JSyJZVaJiMHV0bnJ1MJ05P9-Npacc4KDXKJyITVgW0s
Message-ID: <CAJaqyWdxAcHT+C4LRY6uq84jSa6C5oem=CUD3GJTHd5+KkXvMw@mail.gmail.com>
Subject: Re: [PATCH 10/19] virtio_ring: switch to use vring_virtqueue for
 disable_cb variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l-UpBKwlLIeW3I9x6hqSUCPTVyVFQiTx-0kCY2XGBUs_1742992287
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
>  drivers/virtio/virtio_ring.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index af8ce6e9d892..f754da8c2ac6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -869,10 +869,8 @@ static void *virtqueue_get_buf_ctx_split(struct vrin=
g_virtqueue *vq,
>         return ret;
>  }
>
> -static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))=
 {
>                 vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERR=
UPT;
>
> @@ -888,7 +886,7 @@ static void virtqueue_disable_cb_split(struct virtque=
ue *_vq)
>                         vring_used_event(&vq->split.vring) =3D 0x0;
>                 else
>                         vq->split.vring.avail->flags =3D
> -                               cpu_to_virtio16(_vq->vdev,
> +                               cpu_to_virtio16(vq->vq.vdev,
>                                                 vq->split.avail_flags_sha=
dow);
>         }
>  }
> @@ -1786,10 +1784,8 @@ static void *virtqueue_get_buf_ctx_packed(struct v=
ring_virtqueue *vq,
>         return ret;
>  }
>
> -static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>         if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DI=
SABLE) {
>                 vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FLAG=
_DISABLE;
>
> @@ -2538,9 +2534,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (vq->packed_ring)
> -               virtqueue_disable_cb_packed(_vq);
> +               virtqueue_disable_cb_packed(vq);
>         else
> -               virtqueue_disable_cb_split(_vq);
> +               virtqueue_disable_cb_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>
> --
> 2.42.0
>

