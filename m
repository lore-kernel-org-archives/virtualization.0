Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD341E7660
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354745; cv=none; b=at9cpCd5g9RMnoYwhq+hQUsBJeg1EaSwV/LAt4NoJdD+LdKgaU9Ie4jjkL/24Gjuq1PUDuEfdaIceDfUUiJVydRI3YzM1MGo5LCjq6T6V5XiHS+5hYkjKz5KmnINLou92iBQg54HIg8Q0zpxLamgrln0lGfB6ZHejUCBQ8BGvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354745; c=relaxed/simple;
	bh=zli4l6+3Cz6XqiZS68d2p3HIE0BKInGPc9eQIG4Kzvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEZPj3bpl5yHZgta4mOzwrJ8vVg9KHA/PxJj8pjiSbO2u45csFpPSi3r3Ie07xbJ2XdZJuD87kvDZ6ZeZKCN7yv0Ee4UtLjUNb0NWgXicpo0mMuvpzGvHp4/jEbxeVQogOySP725xk4YIBDST8x5Cy7JuatQ80hQILbqihyKgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWOJN0vX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWOJN0vX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751354743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqfjgkpvPqfNyTCCIdxVSSiYliy/Ldo4Tby8Qm2Lb+I=;
	b=HWOJN0vXMCMnMom1eWBpOfZ50SKkK3GHQJ7Q0uyVQeCqxo7fY8eI7Mv3lapUqYrPHXlY5i
	AKDBHf3ystQs1P6Ywpt4hX8FKuDxlDh3Q/3Z4n9/O1BwJbjscS0kHmqpYT7wB3qYHlFGmc
	CsJ8gD18QenU/zA+s2T6C091qsi0o6c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-cZWH9jZgMeq0-dEN8Tn2Jw-1; Tue, 01 Jul 2025 03:25:40 -0400
X-MC-Unique: cZWH9jZgMeq0-dEN8Tn2Jw-1
X-Mimecast-MFC-AGG-ID: cZWH9jZgMeq0-dEN8Tn2Jw_1751354739
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313f702d37fso2880306a91.3
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 00:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751354739; x=1751959539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqfjgkpvPqfNyTCCIdxVSSiYliy/Ldo4Tby8Qm2Lb+I=;
        b=i2Rzl2z/Pw09vR7vilyqBhZm+AOnkLt4Pmk+BuMJmH5ggqfizBJWsBy1Ke85zkpCyx
         a6z6kuctqkhXNuONT4SpPqtrs0K0vy3u3Gx2+H9OS+1/TGiu61CnpQyNdkEmRu1w5OW1
         8W4nPeezvDABOq5iwAAV547exRGaeOiWYCoCJ4465vGDNC3dbA642jQOFjvfnS74QVx5
         ycDXCeyRwJERAhXXkF53LLwt/wKP2aCaDnGqNTLlUUfCT1JjXnxl201Agrtz9uGSCir1
         udJ/iXPXwkbZCT0nKUpB7q6sBPaB3c7M2iamkItMla5r/q7mNFUnKi1AF1G172pLKZtj
         vHNw==
X-Forwarded-Encrypted: i=1; AJvYcCW5r5pgcT3+dZtMUtgIdGWjiY0zdCE+AHBtcPOkDs9jA2Sr1S9qZ9ZLDan6ahfr2yCzv4cOXaBfsprCxNDJKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi3/Iain2RKT8f6BI49UV/GPJIRipSCS8reTkoMjQaCpsUItAP
	w6CMmbyPyBqqfeFftLfzwDVJrFkUJY6JgbJCji9gHo0seRF4upIKYkvBLYhF0and9O1Lr9SFYOi
	MrR2jy6oqteByhJN8NVnx5ECCG+NaoEvEMwwDHkqpClZdYF3K3nO5ls363O24mUZ+dXn1By1400
	55vlQZTPrE/71UpIg6/ZA4jdve27G8pZ0gjrS4hsjdY84=
X-Gm-Gg: ASbGncvtHzUeGrE3udyjuFL5DsMh1nbatDEyVB/4bX5UFCA3ImnOK/bYhS4FyzyOoiB
	NFHPnePNIUVxL9wvq9bwVfOxzhKIUwE2Rbeud4SUL2FczmnwyZhw71I4+qUz6EXsCjPG1SfV51a
	o1
X-Received: by 2002:a17:90b:1c0f:b0:30c:540b:9ba with SMTP id 98e67ed59e1d1-318c8ee5649mr22932470a91.10.1751354738657;
        Tue, 01 Jul 2025 00:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOq+uG0FaUURtz7jeSaS2hmgJsfIY1SbLYfvpWWdj22laRnsWVajTqtVC9jWNJzKXroXYApr8VhD3fK3IByrw=
X-Received: by 2002:a17:90b:1c0f:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-318c8ee5649mr22932441a91.10.1751354738143; Tue, 01 Jul 2025
 00:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616082518.10411-1-jasowang@redhat.com> <20250616082518.10411-15-jasowang@redhat.com>
 <20250701023157-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250701023157-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 15:25:26 +0800
X-Gm-Features: Ac12FXxqBoyRRVzktN6qu-dSbPSkI2Sh4uKMEzaFGTTMmSWmu6MM19PxRao70Rk
Message-ID: <CACGkMEu=BC5eYoExaUqLp-QZFKq31BrGvvEy0xvAwfCg28690Q@mail.gmail.com>
Subject: Re: [PATCH V3 14/19] virtio_ring: determine descriptor flags at one time
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _3UhkRW4HRRNahstRQrROd6MhsqjzH11xQNkIuKkA6c_1751354739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jun 16, 2025 at 04:25:12PM +0800, Jason Wang wrote:
> > Let's determine the last descriptor by counting the number of sg. This
> > would be consistent with packed virtqueue implementation and ease the
> > future in-order implementation.
> >
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index af32d1a1a1db..d5e4d4cd2487 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -570,7 +570,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > -     unsigned int i, n, avail, descs_used, prev, err_idx;
> > +     unsigned int i, n, c, avail, descs_used, err_idx;
> >       int head;
> >       bool indirect;
> >
> > @@ -626,46 +626,47 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> >               return -ENOSPC;
> >       }
> >
> > +     c =3D 0;
>
> initialize at point of declaration?

Fine.

>
> >       for (n =3D 0; n < out_sgs; n++) {
> > +             sg =3D sgs[n];
> >               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> >                       dma_addr_t addr;
> >                       u32 len;
> > +                     u16 flags =3D 0;
> >
> >                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
, &len, premapped))
> >                               goto unmap_release;
> >
> > -                     prev =3D i;
> > +                     if (++c !=3D total_sg)
> > +                             flags =3D VRING_DESC_F_NEXT;
> > +
>
> Don't like it how the logic is split.
> flags isn't used before that.
> So I prefer:
>
>         flags =3D ++c =3D=3D total_sg ? 0 : VRING_DESC_F_NEXT;
>
> and at that point, we do not really need flags anymore:
>
>
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> >                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> > -                                                  VRING_DESC_F_NEXT,
> > +                                                  flags,
>
> So just:
>
>
>         i =3D virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
>                                      ++c =3D=3D total_sg ? 0 : VRING_DESC=
_F_NEXT,
>
> here and we are done.
>
>
> >                                                    premapped);
> >               }
> >       }
> >       for (; n < (out_sgs + in_sgs); n++) {
> >               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > +                     u16 flags =3D VRING_DESC_F_WRITE;
> >                       dma_addr_t addr;
> >                       u32 len;
> >
> >                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr, &len, premapped))
> >                               goto unmap_release;
> >
> > -                     prev =3D i;
> > +                     if (++c !=3D total_sg)
> > +                             flags |=3D VRING_DESC_F_NEXT;
> > +
>
> Don't like it that above it's "=3D" here it is "|=3D".
> And flags isn't used before that.
> So I prefer:
>
>         flags =3D ++c =3D=3D total_sg ? VRING_DESC_F_WRITE : VRING_DESC_F=
_WRITE | VRING_DESC_F_NEXT;
>
> and again we don't really need the variable:
>
>
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> >                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> > -                                                  VRING_DESC_F_NEXT |
> > -                                                  VRING_DESC_F_WRITE,
>
>
> so just:
>
>                 i =3D virtqueue_add_desc_split(vq, desc, extra, i, addr, =
len,
>                                              (++c =3D=3D total_sg ? 0 : V=
RING_DESC_F_NEXT) |
>                                              VRING_DESC_F_WRITE,
>
>
> is clearer, and the patch smaller.

Right, I just copy the logic of packed.

Let me do that for both split and packed for the next version.

Thanks

>
>
>
> > -                                                  premapped);
> > +                                                  flags, premapped);
> >               }
> >       }
> > -     /* Last one doesn't continue. */
> > -     desc[prev].flags &=3D cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_=
NEXT);
> > -     if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> > -             vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
> > -                     ~VRING_DESC_F_NEXT;
> >
> >       if (indirect) {
> >               /* Now that the indirect table is filled in, map it. */
> > --
> > 2.34.1
>

