Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDE1E1DF5
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992280; cv=none; b=sF/aOv31TRjgqUdRHYbTwj4cSAh3RCy3BdIiU9gjf+6yGn5YqczxQ5Nqao4cUD3cDhgoo7UWRrxasO+UzlENtdUb3uKJkgUhpvj/JN9kjD7VaBxHT3Y8ek3B8UJFLtu8UhhOGw59bqcPzuMGLJLFddB1j9JErYe/gw5xBNjUsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992280; c=relaxed/simple;
	bh=5XOHgQ9Ffo4lzFeWHbShfU3wyeLpR2N854J29ellPv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/SOMhZ4/Vzk60bl9O8y63uyQImw7iXPxB5UNMLNwjQqB2zxntwPUfW/xvXv+EdHqWI7p23Ol+stNNNEyZ9XnsUsyoVucqE79NuIkFliMg4eAJK5U4zxVy/iWWeTrhT2i8JAuJpyhAQ8wKd/rBZLtmDa8dMly/fJd4VMggBFtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWBRoaCX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWBRoaCX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAdSAVacBxue1TmQqDLcTFCwkP1xo1pi83cchMmsOwE=;
	b=EWBRoaCXotmWbb2y2U+zk6rbK9mjM8TpCMyOgiiJMwNOMdDURIIkvorUeMJ0b8F5oowvZt
	Zg4XVsuPXZr0kG7+iLfrbpfc0v79IzSpgyFMUXlD3J1GYjBjzn2lYSUiS2/PnYp/K8ux/e
	H84Jn2Kh2Dfc+J1LYmekrAED83cSE/A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-99s349YrOCW95SRsGi6S6Q-1; Wed, 26 Mar 2025 08:31:15 -0400
X-MC-Unique: 99s349YrOCW95SRsGi6S6Q-1
X-Mimecast-MFC-AGG-ID: 99s349YrOCW95SRsGi6S6Q_1742992274
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30364fc706fso4380849a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992274; x=1743597074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAdSAVacBxue1TmQqDLcTFCwkP1xo1pi83cchMmsOwE=;
        b=iNdNQxrVFJAM6fO4AlWhd0wSJjSswSF7zEbwTbbGXBmHH1hh6VfRZN/JxuAy9pV2tY
         SpN2EUEXxRoIdxGI6+tHEJvJOmQtR1g51elLOffQpphAMEGDY8bw3qrwdhbqjo6VPccS
         cKz/YRFF9T0N2dHfN7UBCN+TyeYxhbpIu1DhsD9Xi46puC3m9Dm1U5Egidy8k1lzrI/Z
         jyYsW5OgS2grjhFHQp3ARou8NovncV5L0xYXoCejIr196C+UcngNABmU1RBMeb6BJ5oc
         +FNqM1ImLyRU3AKGwZbvyMZHTYnDkbQpwtD2jc3IpoR8O+xNMOYE8E7x+DwtaU1i8tXk
         xeeg==
X-Forwarded-Encrypted: i=1; AJvYcCUX/KAeBYJj3elR2XWe2vM4gluu9BFSupAYlRApUj6AgcRewg4Yb0dAOobKQgMILNIhtdvnzS3etVBJGk7xbg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqzqdc4IAxCegIDw85QiEcVPArK407eP9hlUuF3tbz1ZsyIorL
	V2tiTm2htETWi/9wOjB1PCDDvDf9Lmwnzmmjw/uTqVkhs5zVtzBMSJ1IzsbPS642aQeyWBuUWoY
	3UsjOUmDk+bhC+Ed+66M+AYceKJvvDHrRS36wqpXBQDFGxxU60D1WCeu7coOznKyY+FvSiEogf/
	cCz0yaSbS+OkiO874oPUccFOYby8IeOeq/gS5SnXA=
X-Gm-Gg: ASbGncuu3tnYlkb2GPDmfF4MOD1VNkltCRUU7yfaZ6EKFKWpIYk+VJqp1CZyVyHgMqh
	6UJF7uozLAYG5Jr5v4N+oHv0EbGxcFZ2udWU8IvJWqQNak8BNx5gsLFnX0c0AFS02bFFeXB4=
X-Received: by 2002:a17:90b:554e:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-3030fea0d35mr35854786a91.15.1742992274366;
        Wed, 26 Mar 2025 05:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMBiUpX7u1Oi46XXoPSaCW+cpt4tUKFjelSQIwtkx21BmzYxC7k6NWIAAx2C1zOmu3fzfgNqk032hM0TVme1E=
X-Received: by 2002:a17:90b:554e:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-3030fea0d35mr35854736a91.15.1742992273959; Wed, 26 Mar 2025
 05:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-10-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-10-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:30:37 +0100
X-Gm-Features: AQ5f1JoCUWH6yktmmruAjai5d907SFhCX-z2GsZ94SM96jfry_2r0BVObMP-5IU
Message-ID: <CAJaqyWdjgx8d0Si-Qdzv1xKQoQDHBiQ3QBRwYnHmOQO3gf8uEg@mail.gmail.com>
Subject: Re: [PATCH 09/19] virtio_ring: use vring_virtqueue for
 enable_cb_delayed variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QgZ7dNK9PnQKCD83UgH_HIPirrjvXBv0D5qt82ytphs_1742992274
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
>  drivers/virtio/virtio_ring.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a414e66915d9..af8ce6e9d892 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -917,9 +917,8 @@ static unsigned int virtqueue_enable_cb_prepare_split=
(struct vring_virtqueue *vq
>         return last_used_idx;
>  }
>
> -static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq=
)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 bufs;
>
>         START_USE(vq);
> @@ -933,7 +932,7 @@ static bool virtqueue_enable_cb_delayed_split(struct =
virtqueue *_vq)
>                 vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTER=
RUPT;
>                 if (!vq->event)
>                         vq->split.vring.avail->flags =3D
> -                               cpu_to_virtio16(_vq->vdev,
> +                               cpu_to_virtio16(vq->vq.vdev,
>                                                 vq->split.avail_flags_sha=
dow);
>         }
>         /* TODO: tune this threshold */
> @@ -941,9 +940,9 @@ static bool virtqueue_enable_cb_delayed_split(struct =
virtqueue *_vq)
>
>         virtio_store_mb(vq->weak_barriers,
>                         &vring_used_event(&vq->split.vring),
> -                       cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bu=
fs));
> +                       cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + =
bufs));
>
> -       if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->split.vring.use=
d->idx)
> +       if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.u=
sed->idx)
>                                         - vq->last_used_idx) > bufs)) {
>                 END_USE(vq);
>                 return false;
> @@ -1837,9 +1836,8 @@ static unsigned int virtqueue_enable_cb_prepare_pac=
ked(struct vring_virtqueue *v
>         return vq->last_used_idx;
>  }
>
> -static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *v=
q)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 used_idx, wrap_counter, last_used_idx;
>         u16 bufs;
>
> @@ -2631,8 +2629,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *=
_vq)
>         if (vq->event_triggered)
>                 vq->event_triggered =3D false;
>
> -       return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) =
:
> -                                virtqueue_enable_cb_delayed_split(_vq);
> +       return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> +                                virtqueue_enable_cb_delayed_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>
> --
> 2.42.0
>

