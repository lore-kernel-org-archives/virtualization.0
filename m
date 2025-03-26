Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3633F1E1E0B
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992219; cv=none; b=Pk3PaPKQsRKw9yLXdPjDWuvJAodbVHcEJ24qYXqE9nNhIsl8c36uN2FgzWTzfb72uEJpTkZK2P4Ehs+8Q8j822ZtudqZUe63ths1uICdT/y31HozV5fwhyoAWcZhsBdfN8zbgmyN5NsTYAmB5rSAqN1DdU/WS4Ku3jyJGp+E2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992219; c=relaxed/simple;
	bh=d3AdQbX6+21yO9I0lZEWLjA8CqykrpbhEOYrbgYWDXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSFH8KEuGK0Y3knNLi88Z9GAufozE1ZlHv8toG/5BTFcbsrU1gO1FtAFeqoWBgVyl6jgU2yIudj2/QtT5HAUPI7qujBwu13s8SbOX85lMbVbtJuhoHBPCFtA3d+PdlvjnFSQ0435Nqp9R/ybkaDzGcLv6ovq1KrlD4jrcp6g9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMEvzozd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMEvzozd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKrPdf2nzn9LCA7q7bksrLyi2C1TjMNZM33BA9TF6fI=;
	b=VMEvzozdVmnUaX2H7jpsGYjRTFOzv/JIoBoxMkuODivefRZQpLBh5gL1UIc7NYoo3YsV8Q
	LYpa1I9LDRLGt5R6jpEs+fE2W+3mbHcmt1y4zZ3c0pByN6O5VC2pRh1vF3YKYcoYrLWk+f
	/3Rd3A0th0emS6gL+iMOe+NOQe0fNXc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-k9KU8TZeM2mJr5GCnzo6AA-1; Wed, 26 Mar 2025 08:30:09 -0400
X-MC-Unique: k9KU8TZeM2mJr5GCnzo6AA-1
X-Mimecast-MFC-AGG-ID: k9KU8TZeM2mJr5GCnzo6AA_1742992203
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso13087621a91.0
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992203; x=1743597003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKrPdf2nzn9LCA7q7bksrLyi2C1TjMNZM33BA9TF6fI=;
        b=oevb31L+If/p1ybAxAJa6+qPXPshvh2hFlyket9xxD35kLZ8V7VL1At7yvrzSlPCbf
         pLuxg20z2FaH8jv26M+8UnAUirn+eBXTUuby2iyRDYhZZtGzxTCHtyDCLQCe8OrNPaOe
         7XMW8NFYxqnZA46IpiaWvE2cBBNktXSHgXn71nSDpUNvO7cnWDcGhc1CdOS1dZ+cUdaJ
         /SRC+7F81lBzEM2BVQ6ap8lQkoEsfgzIciSMCsIHCBvagaJNW4fqtbljtCJlOJ5qafsW
         GHsgloqlxOWNgsYxCwoyvI2LXnVmfJallJLfyADCmGeLDmuxG/EI963pIKjj42CGkbTA
         a5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUY0HlvSirEkytvMspyxaEWyYPCZJLAhJCucrexF4sVx8NiEFnW6G063kkYmn7TotjE9ayy5WPSsQclcdcQzw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6MSLtcl/lXXCW/BWVaBOLJgqhwF4FwbKxdZ9bzaQEpfxWq6Kq
	7j3qUpKSKbcM8xhHQKxVOhM875esTWH31anFKvvl/rVIeNR9mOn8bUlV65Ha4XDzJz9MZT59G3F
	3oBOl/EUe0iZcfMx7lj9ytvSPS2WVtGgz2g690ypBHR3+zXFAWOIlkuXMC2M0//I2hUYzNAnz+S
	waH/7ThUtrLSDbGGr70CsMSQbbz5JPuM0TvNyGYVU=
X-Gm-Gg: ASbGnct9qAcKlu0XitTelCBnr2WqXefbAo0e7p5P3mm9JjAXjjT1JsHO03K2q60dxyl
	z4LhTukU1bN1zCzeHwiYyHdqoxlg7yavi9Bw7Vg4pdB+f1YqVNivjJKi32uqhvA4lL7LsBF4=
X-Received: by 2002:a17:90b:3c05:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-3030fe942bbmr30995250a91.13.1742992202777;
        Wed, 26 Mar 2025 05:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu3cHxPcatuuTyqBCWGB3gzPe/fhmRdkU7i14jGqyFMfRIpt5USxNqs6aDQz2tnygSegRETNiozfuDkTsXBLM=
X-Received: by 2002:a17:90b:3c05:b0:2fe:99cf:f566 with SMTP id
 98e67ed59e1d1-3030fe942bbmr30995177a91.13.1742992202219; Wed, 26 Mar 2025
 05:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-6-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-6-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:29:24 +0100
X-Gm-Features: AQ5f1JqA5rnmUJvxpY2lTSb7DtsHpn-R_THV-oHmmvfjcTfm35K1wGa3qO_Bi3M
Message-ID: <CAJaqyWehLxjOhPtXjDJUV7JrC2v40s-FqmtgsO_Ae1YkLHrQiA@mail.gmail.com>
Subject: Re: [PATCH 05/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue_kick_prepare variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T-jAxN_T8YX-VYFgAu-FlNuEP9b14mgvJdAjmy07aGc_1742992203
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
> index 94ce711963e6..cf3ab6404698 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -713,9 +713,8 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         return -ENOMEM;
>  }
>
> -static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 new, old;
>         bool needs_kick;
>
> @@ -732,12 +731,12 @@ static bool virtqueue_kick_prepare_split(struct vir=
tqueue *_vq)
>         LAST_ADD_TIME_INVALID(vq);
>
>         if (vq->event) {
> -               needs_kick =3D vring_need_event(virtio16_to_cpu(_vq->vdev=
,
> +               needs_kick =3D vring_need_event(virtio16_to_cpu(vq->vq.vd=
ev,
>                                         vring_avail_event(&vq->split.vrin=
g)),
>                                               new, old);
>         } else {
>                 needs_kick =3D !(vq->split.vring.used->flags &
> -                                       cpu_to_virtio16(_vq->vdev,
> +                                       cpu_to_virtio16(vq->vq.vdev,
>                                                 VRING_USED_F_NO_NOTIFY));
>         }
>         END_USE(vq);
> @@ -1597,9 +1596,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>         return -EIO;
>  }
>
> -static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 new, old, off_wrap, flags, wrap_counter, event_idx;
>         bool needs_kick;
>         union {
> @@ -2454,8 +2452,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
> -                                virtqueue_kick_prepare_split(_vq);
> +       return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> +                                virtqueue_kick_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>
> --
> 2.42.0
>

