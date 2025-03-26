Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5E1E1DFE
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992253; cv=none; b=WRe6Wx+RzaYNtfWxeb4Ba4zjbuKNPkNOWAvC6bjADbL1w4bPmtq0pX0zsG+HK1+pd5SjbpW4dBjFubX1QPJzDqa2hSBx9FkTqy7MCME55augGST9UmRNOG062ToXyGBbs83/T1XfvlDavs5ODgarXL5WBUUSrIip62/Ibf6ly84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992253; c=relaxed/simple;
	bh=t1jAaeK2ABeSg5LQWx2wud9VnSm5B8lPYZn3evgb48A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icfaQNwDZ5FYHI1nQWUetYdplq3crvE5Go4EVijeZAmoDa7g+eqzkljYSVWCqa/2QiIH51UPDKNm2bV3Rozq2rFMCSmRipUuDjAphE25pTvRdfC584xPdtlP9izup1pUD/oRkJiqxzSQQzaktyP0S7V/QB2ql8mSy4t4CaLYdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnvAiiI/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnvAiiI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BofOIcmGmmEYNcMOZrv+oDBXVdFbZpweL97kRPLwA+0=;
	b=fnvAiiI/SXM3R1dMJf1iAOrT9jh85ifvM7PkQprypxHqokZSZp/EUc+Uc33je2HylgPBKB
	smMWdwRdMyiLUCXOCJ6iyzJGInHMyMSUaGnm1vt/HZITOGkv4WKNQ0hBbpMrDmuy9FBOHb
	SIkYJtj/zRovbRgt+zBloZ1UD4CmTp8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312--cuaRngSN3es6uWLMpxwxA-1; Wed, 26 Mar 2025 08:30:49 -0400
X-MC-Unique: -cuaRngSN3es6uWLMpxwxA-1
X-Mimecast-MFC-AGG-ID: -cuaRngSN3es6uWLMpxwxA_1742992248
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso16227732a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992248; x=1743597048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BofOIcmGmmEYNcMOZrv+oDBXVdFbZpweL97kRPLwA+0=;
        b=m30MEBc4OYYkcF+mGt4+kzx+ly2hQl3wBYYnqdu9J+FEcO1pPpmbYAo9s3d6KDt2Nl
         +kszIdk8XmySXVa4ch56wLFJsDz9+eocEFZe7Q1wc+E3wvid0TmZ5otCTpGbKLokOgBW
         yqYqJaNglY/xXi7a3BkrLakzQ3hw27q3BpQY70PaCG48bvuYwuV4cdAlVGhYHxd/skMe
         ZGk7ey1invXyvGqK9QTv+YMHREjXUCq7ky74ptY5TWc9JgIx9f4sMrPin4zf7aBv6kPC
         kgICguAFK6nrYBkwPYiebYO1qwFFv2vbNusNlpreh3oDKq83hwiofUWQ7EAJmQqFOZYg
         FpoA==
X-Forwarded-Encrypted: i=1; AJvYcCV8udilbQCCpxxf3PzmJZ+Tp6Ivvrh607NQgKGzFCzvyEUyoi8vP+WnAdKPaZeuLJLGeiJliBOS0dzOL25MTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6qP0lEyc2fudLbpixG2OKs+45Cu9C8y1BKzs+S1N1NzGaYbWN
	l0PbKYpEiWztbD4A+qrpNk32GlaZwIJQ4sv3NpFNOtQqjnev+GQvJeQ2wB7J9ABbuQDI7rnHv6T
	sfeEGb3M2GuI37HkgG2t+geFfBDu8CD2G61axHDOwl3gTyP8cuQeZ3yS5th9mYf2R8iAKmkzUN2
	wmAJjg3Wd9jpgEZ2NTbo4Q95gXpboFQ0bcF7D4iHs=
X-Gm-Gg: ASbGncuC0njV2+uD84VETtSUKX7j+IK9M8GsOwM4x7j5GGBx+yivkHJJ8lVKev/YTE5
	K0C8byU0/bRXXPpbbIX2JGEsvlnP6nFLFHZrDpuDk1AQhptL0oWj9pCuIn9DSNKhqd6IatUI=
X-Received: by 2002:a17:90b:2647:b0:2ff:592d:23bc with SMTP id 98e67ed59e1d1-3030fe58cc6mr32754806a91.4.1742992248114;
        Wed, 26 Mar 2025 05:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHZspv04CXcu+ey4YOBhN+VJKI5mU2+Jtl12WquvdbY1oIVinT6nMNfzFCcHEY+oJ4kBspf1BZQ2XjZ5Pwcs4=
X-Received: by 2002:a17:90b:2647:b0:2ff:592d:23bc with SMTP id
 98e67ed59e1d1-3030fe58cc6mr32754746a91.4.1742992247541; Wed, 26 Mar 2025
 05:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-8-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-8-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:30:11 +0100
X-Gm-Features: AQ5f1JpRUV94ZzxyW-F1h7s9QroQ6M5Rkq4ahPxn9uzQpE7HmuL0CSIEhSc_E5I
Message-ID: <CAJaqyWdVXNH-W4hbgiLS+8O--atXQDE8bqN23Z5M9rnOFx4g4A@mail.gmail.com>
Subject: Re: [PATCH 07/19] virtio: switch to use vring_virtqueue for
 virtqueue_add variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a1MkQ6D8OGvcpGdRy2-O_0WBYC_Yqec8jXNlb-qm5Pk_1742992248
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
>  drivers/virtio/virtio_ring.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 619869e80309..3fab40648c75 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -812,11 +812,10 @@ static bool more_used_split(const struct vring_virt=
queue *vq)
>         return virtqueue_poll_split(vq, vq->last_used_idx);
>  }
>
> -static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>                                          unsigned int *len,
>                                          void **ctx)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         void *ret;
>         unsigned int i;
>         u16 last_used;
> @@ -838,9 +837,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtq=
ueue *_vq,
>         virtio_rmb(vq->weak_barriers);
>
>         last_used =3D (vq->last_used_idx & (vq->split.vring.num - 1));
> -       i =3D virtio32_to_cpu(_vq->vdev,
> +       i =3D virtio32_to_cpu(vq->vq.vdev,
>                         vq->split.vring.used->ring[last_used].id);
> -       *len =3D virtio32_to_cpu(_vq->vdev,
> +       *len =3D virtio32_to_cpu(vq->vq.vdev,
>                         vq->split.vring.used->ring[last_used].len);
>
>         if (unlikely(i >=3D vq->split.vring.num)) {
> @@ -862,7 +861,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtq=
ueue *_vq,
>         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
>                 virtio_store_mb(vq->weak_barriers,
>                                 &vring_used_event(&vq->split.vring),
> -                               cpu_to_virtio16(_vq->vdev, vq->last_used_=
idx));
> +                               cpu_to_virtio16(vq->vq.vdev, vq->last_use=
d_idx));
>
>         LAST_ADD_TIME_INVALID(vq);
>
> @@ -1721,11 +1720,10 @@ static bool more_used_packed(const struct vring_v=
irtqueue *vq)
>         return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
>  }
>
> -static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>                                           unsigned int *len,
>                                           void **ctx)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 last_used, id, last_used_idx;
>         bool used_wrap_counter;
>         void *ret;
> @@ -2521,8 +2519,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, =
unsigned int *len,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, c=
tx) :
> -                                virtqueue_get_buf_ctx_split(_vq, len, ct=
x);
> +       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ct=
x) :
> +                                virtqueue_get_buf_ctx_split(vq, len, ctx=
);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>
> --
> 2.42.0
>

