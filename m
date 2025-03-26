Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6F18EB0
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997779; cv=none; b=RZ0FYghCQkfVNv74snsWXU57htd9dsbL7ov1pVUzQr+n1gbjrqN5pxpUKyp+k3MdBu3Nk/kHO2qTbClOuvyEzQh51qa/bXySVpKgbwvzs8OFz7GYwPEJ2CzKONm7iaAUnvlm9RjKCkky8D8nLkMcbfGdArHo6oughAgp3Ou5G3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997779; c=relaxed/simple;
	bh=3qzzuciwFiHhgnR+NjBWc+rKPxYkw4M3p/jQtmvaWSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr4u5l4TMqsEjedd2BNlXJ6oLbZZ7erutgd+sUq2mRSFicVI23Ealsg1R88Iys9phI71i5huB/6lTf6BoWLaZvYV8SyaT4/nzLB7yNdErz23zJwqFq0WUd7JRh4I1EoB/LZ6K3Fpxf+rcN5Fb9VO03FYkNT6JdUmqNeNwsxnbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PywAU2AP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PywAU2AP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnbLFSfaVr4Q22ZcBNrQlalkQrGvDzjjby77ROH2VlI=;
	b=PywAU2APf63i5vzARGdfimCi7pq4AULnxD9LmJVD8v2H0tkAOaStug9NOmHl4SChyx4dCy
	u5OpZOPUsrL1k+E9zv9ZzTqgshsIttzGKKgE+RQQz/omb6kDZUOXw2ltvvx5RPQJ9d+dIn
	LE1DhZCz9Ac5kKFA2Yo2sRrlWBtRnFI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-VSFK2Mt0P3WuOjXWN0B2GQ-1; Wed, 26 Mar 2025 10:02:55 -0400
X-MC-Unique: VSFK2Mt0P3WuOjXWN0B2GQ-1
X-Mimecast-MFC-AGG-ID: VSFK2Mt0P3WuOjXWN0B2GQ_1742997774
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so5650760a12.0
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997773; x=1743602573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnbLFSfaVr4Q22ZcBNrQlalkQrGvDzjjby77ROH2VlI=;
        b=Ipe40XT8ZyTjunqXa2AiTnJzdLlDxAw4mFmBqpACb1xOx5Cu0dG/fMlVOj3K86MM1r
         yxIeqOROnkphTIw17AlPemA7cfIAYBZS7P8D7Mwzox+dOgPe+W/XQpaVqQzORVh6azi5
         pM1DmkUzCs96f9FruS2g/77zMba0AqNfaJpBza0wtjwkRj6cYj+yHTDc9lJVLahI6R8c
         WZz4JzG7EbJz8wAj5rRNHi3/bThtXheU0HloTpThJqeIa0FZlXh5uJmYVBdWojIdxd0W
         7skMVAWNuTx/pwgcYp3dwdcmd74RG5151XGjuEabG5CxvTF+ZWQkIcqWpFLxWjAsD/To
         LGqg==
X-Forwarded-Encrypted: i=1; AJvYcCUyDfCe3rfeZgNxfLqDGvr+bfPvF2C9e057tJ1YW0/yl7HPefJP0CaJPneVFM5XDaJABJz0PWgMIogUDyqwFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHyCOQXc4lsaYch6seMvNxs8vf6fuy4IImgOvRFGvN20wMaPs/
	3L8FKtbB+wX5AwD5Jr70E2obZ1HqVV/iTaAE42seSOumetUkAW0Q43h7gDPaYPGdKTecdii0Zav
	iQumQlYomHiE0uPkYzhiDcvDo3lZCw01ihtziECfHSVgP3LEWcaLLPzQYUwYjQ+8Pb7qYPYMX2p
	LxFVS0KfVoJ/SAzLcqSYweF8IsPpdaUcomnawVTmTtDHIrU2lnSw==
X-Gm-Gg: ASbGnculwuWXTTdAPLl7ivDwP3TppdZ0fRJwbJYkCexkjsX9Hq/KhydLkYq9aLtmdum
	6UcjXSNF2WBcjpaK//Ioq1GXc8KN/l8WSLahYVac9Vd0ipjRxo8wpQ98F4dfu/eIYFFQRyhI=
X-Received: by 2002:a05:6402:50ce:b0:5ed:6192:3759 with SMTP id 4fb4d7f45d1cf-5ed61923892mr795745a12.0.1742997772943;
        Wed, 26 Mar 2025 07:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNz4NecBFhHtJh14xuH66vPEkf/EqjvhB0U+5xZoM1iUladqkUX08Zn44oe38tBlmrzjNvm4QWreip61547JM=
X-Received: by 2002:a05:6402:50ce:b0:5ed:6192:3759 with SMTP id
 4fb4d7f45d1cf-5ed61923892mr795482a12.0.1742997770904; Wed, 26 Mar 2025
 07:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-6-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-6-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 15:02:12 +0100
X-Gm-Features: AQ5f1JrzMmqRzjZ2QP_VVFzie1zTkK-Q3AUK4a9ZoX6-xBZKdIqB5CZikFJJcDk
Message-ID: <CAJaqyWeDOjsJ1wv7PvXt86JztEVMuwKSR1-g9NS35DUbopK8ag@mail.gmail.com>
Subject: Re: [PATCH 18/19] virtio_ring: factor out split indirect detaching logic
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qyRv05Uh_NWDy0Nh4sMmgQEY22MkhxlppIKsowAw-3E_1742997774
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:02=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Factor out the split indirect descriptor detaching logic in order to
> make it be reused by the in order support.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a1a8cd931052..0fad8e8419c8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -765,11 +765,42 @@ static bool virtqueue_kick_prepare_split(struct vri=
ng_virtqueue *vq)
>         return needs_kick;
>  }
>
> +static void detach_indirect_split(struct vring_virtqueue *vq,
> +                                 unsigned int head)
> +{
> +       struct vring_desc_extra *extra =3D vq->split.desc_extra;
> +       struct vring_desc *indir_desc =3D
> +              vq->split.desc_state[head].indir_desc;
> +       unsigned int j;
> +       u32 len, num;
> +
> +       /* Free the indirect table, if any, now that it's unmapped. */
> +       if (!indir_desc)
> +               return;
> +       len =3D vq->split.desc_extra[head].len;
> +
> +       BUG_ON(!(vq->split.desc_extra[head].flags &
> +                       VRING_DESC_F_INDIRECT));
> +       BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
> +
> +       num =3D len / sizeof(struct vring_desc);
> +
> +       extra =3D (struct vring_desc_extra *)&indir_desc[num];
> +
> +       if (vq->use_dma_api) {
> +               for (j =3D 0; j < num; j++)
> +                       vring_unmap_one_split(vq, &extra[j]);
> +       }
> +
> +       kfree(indir_desc);
> +       vq->split.desc_state[head].indir_desc =3D NULL;
> +}
> +
>  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int he=
ad,
>                              void **ctx)
>  {
>         struct vring_desc_extra *extra;
> -       unsigned int i, j;
> +       unsigned int i;
>         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F=
_NEXT);
>
>         /* Clear data ptr. */
> @@ -793,34 +824,10 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
>         /* Plus final descriptor */
>         vq->vq.num_free++;
>
> -       if (vq->indirect) {
> -               struct vring_desc *indir_desc =3D
> -                               vq->split.desc_state[head].indir_desc;
> -               u32 len, num;
> -
> -               /* Free the indirect table, if any, now that it's unmappe=
d. */
> -               if (!indir_desc)
> -                       return;
> -               len =3D vq->split.desc_extra[head].len;
> -
> -               BUG_ON(!(vq->split.desc_extra[head].flags &
> -                               VRING_DESC_F_INDIRECT));
> -               BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
> -
> -               num =3D len / sizeof(struct vring_desc);
> -
> -               extra =3D (struct vring_desc_extra *)&indir_desc[num];
> -
> -               if (vq->use_dma_api) {
> -                       for (j =3D 0; j < num; j++)
> -                               vring_unmap_one_split(vq, &extra[j]);
> -               }
> -
> -               kfree(indir_desc);
> -               vq->split.desc_state[head].indir_desc =3D NULL;
> -       } else if (ctx) {
> +       if (vq->indirect)
> +               detach_indirect_split(vq, head);
> +       else if (ctx)
>                 *ctx =3D vq->split.desc_state[head].indir_desc;
> -       }
>  }
>
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> --
> 2.42.0
>

