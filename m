Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345CB23CB
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502479; cv=none; b=Hvxm2os1mFtZ/c4TlQ34g0hnelDAzOSSpqj4A9rcsp3c9FYy0utreMwt9vRVOYoBqfCMia0Cjco0M/vnW2TlT2hVNH9M3EGbGNxT0TBfgZpFYbRk12pswXa+jybZbAMXFWB6qmuwNTmlwxInDbmS4gxnYl54R3tkwes3NW43K7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502479; c=relaxed/simple;
	bh=9R3BqWjTxU7P5mzQXg5yxNQRwEU/SY4HjKjtRJ5tfks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJzqUcMtIOA2BHxLgGP5hKUI829kOAbsk0DEFzoj6+hVuo9l6M7DEK/ZbEbhkaqpjIWt4aG0Ad9QZsovec+aimG4xhd4c+LV43cbSBSSUj6eGe9ziVzJHnv6RSSm+U/oaU5kvCs6sH90BTSaElUm5eceDVo2Nqq7d10xBJiT3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mr2OWinx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mr2OWinx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3jeEML+hm9B2cxS8JSlOpLThcHP3+emn/qAaz+xaZQ=;
	b=Mr2OWinxSU6xIz/eGJ+jnKqTDhbcWChh1tagEJ4esavwpcFLhQL1qWltD7FOmjz/Usp2Jf
	BF1lK/s4XA+hLE5qN93vnX9Q8leqRNKLfmDcAAlxcQR6K/iqUbHLyKtQHkkkNXjsFFwhA3
	9PrL1dRtTEk8CsKrAos7NvPpGJx9wDc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-n-hQDtPjPNGZFzhMR_uQCg-1; Sun, 21 Sep 2025 20:54:34 -0400
X-MC-Unique: n-hQDtPjPNGZFzhMR_uQCg-1
X-Mimecast-MFC-AGG-ID: n-hQDtPjPNGZFzhMR_uQCg_1758502473
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so5546748a12.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502473; x=1759107273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3jeEML+hm9B2cxS8JSlOpLThcHP3+emn/qAaz+xaZQ=;
        b=j7RpohyhvC8TGq+rknqTeMFZC/6t5dYCrhSDhmJMMvf6ZueD1Lrvu4q9D5OueDppbt
         7RCacD+ZYhiWEDl/3fyyMspWhABO2aYk6USTwzJW8o8uORjfwRrzJW8iUwZn/ansMDCI
         fLcTz86FtRC1VZM1xnZQWgAmq/CDogCsV02CtYFQhwlsxcc84jXkdSFu0SMSX8vqBy9r
         kzQ47xo1i0Ve1/cLdoRRFnlYzr5NOaTwjPUDfjCPGB/b/lF2LiRjuEWCDhiT+sDh097p
         zEcWkrFsygPVycqBqGUAfEffz7Kb4W7sMnHdPpjyaF+JNPFAOlmmxvW11HNcnu0S2fcz
         GVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPyZ1aBNtEOEUPKAmzo9iQyoh49kqIYHkg6lOa2bpmKXfGt7hIDFo/6AZs5SvEhuufhNnOq9cXAw4TaWFpJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw51PA+JIy5RoZ0YWhbRprtPR85XQb2JReOzUB4rcd/+LBhd8d4
	SrEOW3C5Sagnh7aJFxnE+/FvQZFyANMY80d/4niaq/Kd9GoNVRIO4c9O7ytXHDMCPeao5wFp9iM
	UvaPB1BXv6aTEP4zwI1GsjV9FB77sxGpyQNp4nAB35m8gHQIu2lHDiUYOW84sXpcsgjlCWlm+x+
	mu3LIZFmjBj/XSq+ABbGBnk3mpKtJs5R7hrhfWccsS/2s=
X-Gm-Gg: ASbGncvflkb3Iz1osXV7/EcOVczBNLh8ZDQ6LqpkVjmi7gPU7s7XbBf4wja8oaU0vhZ
	AD5iC2UmbYlrfXh0nTZEptjGD+BwtCxpcqCB36OyGVNK7J6v3vAqNC9TmIYSBC0Cj6GDXK46k6K
	73YuMzeT88iJJBENHLNTJCvw==
X-Received: by 2002:a05:6a21:99aa:b0:243:f86b:3865 with SMTP id adf61e73a8af0-29270319fc8mr16685310637.36.1758502473151;
        Sun, 21 Sep 2025 17:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+e0tK5KOdYYGx1pnJKv9NZWwGOKiRwcrSGCcpLUk78S9iiIRwI8MOfu8Mn1YdymVNKfaWIikoSkmopURdtHo=
X-Received: by 2002:a05:6a21:99aa:b0:243:f86b:3865 with SMTP id
 adf61e73a8af0-29270319fc8mr16685289637.36.1758502472733; Sun, 21 Sep 2025
 17:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-7-jasowang@redhat.com>
 <20250921134601-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921134601-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:54:21 +0800
X-Gm-Features: AS18NWBf8ry-HTUen2C0-8fpN4bE4uOPg9V8nK67FrWVtWwU98ZvA5H7JSxfGUY
Message-ID: <CACGkMEvqOaEnkWd=C88kkBdCz8s3odWCw5D9io0YL-=8AN-tag@mail.gmail.com>
Subject: Re: [PATCH V6 06/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue_add variants
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s4Ixw95X9zmB_cqmoHErUjGmeoHKiFcSmePn_LcgfYE_1758502473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:47=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:41PM +0800, Jason Wang wrote:
> > Those variants are used internally so let's switch to use
> > vring_virtqueue as parameter to be consistent with other internal
> > virtqueue helpers.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 40 +++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index aadeab66e57c..93c36314b5e7 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -476,7 +476,7 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
> >       return extra->next;
> >  }
> >
> > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue =
*vq,
> >                                              unsigned int total_sg,
> >                                              gfp_t gfp)
> >  {
> > @@ -505,7 +505,7 @@ static struct vring_desc *alloc_indirect_split(stru=
ct virtqueue *_vq,
> >       return desc;
> >  }
> >
> > -static inline unsigned int virtqueue_add_desc_split(struct virtqueue *=
vq,
> > +static inline unsigned int virtqueue_add_desc_split(struct vring_virtq=
ueue *vq,
> >                                                   struct vring_desc *de=
sc,
> >                                                   struct vring_desc_ext=
ra *extra,
> >                                                   unsigned int i,
> > @@ -513,11 +513,12 @@ static inline unsigned int virtqueue_add_desc_spl=
it(struct virtqueue *vq,
> >                                                   unsigned int len,
> >                                                   u16 flags, bool prema=
pped)
> >  {
> > +     struct virtio_device *vdev =3D vq->vq.vdev;
> >       u16 next;
> >
> > -     desc[i].flags =3D cpu_to_virtio16(vq->vdev, flags);
> > -     desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
> > -     desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
> > +     desc[i].flags =3D cpu_to_virtio16(vdev, flags);
> > +     desc[i].addr =3D cpu_to_virtio64(vdev, addr);
> > +     desc[i].len =3D cpu_to_virtio32(vdev, len);
> >
> >       extra[i].addr =3D premapped ? DMA_MAPPING_ERROR : addr;
> >       extra[i].len =3D len;
> > @@ -525,12 +526,12 @@ static inline unsigned int virtqueue_add_desc_spl=
it(struct virtqueue *vq,
> >
> >       next =3D extra[i].next;
> >
> > -     desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
> > +     desc[i].next =3D cpu_to_virtio16(vdev, next);
> >
> >       return next;
> >  }
> >
> > -static inline int virtqueue_add_split(struct virtqueue *_vq,
> > +static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> >                                     struct scatterlist *sgs[],
> >                                     unsigned int total_sg,
> >                                     unsigned int out_sgs,
> > @@ -540,7 +541,6 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                                     bool premapped,
> >                                     gfp_t gfp)
> >  {
> > -     struct vring_virtqueue *vq =3D to_vvq(_vq);
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > @@ -565,7 +565,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >       head =3D vq->free_head;
> >
> >       if (virtqueue_use_indirect(vq, total_sg))
> > -             desc =3D alloc_indirect_split(_vq, total_sg, gfp);
> > +             desc =3D alloc_indirect_split(vq, total_sg, gfp);
> >       else {
> >               desc =3D NULL;
> >               WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indir=
ect);
> > @@ -612,7 +612,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> > -                     i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, len,
> > +                     i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> >                                                    VRING_DESC_F_NEXT,
> >                                                    premapped);
> >               }
> > @@ -629,14 +629,14 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> > -                     i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, len,
> > +                     i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> >                                                    VRING_DESC_F_NEXT |
> >                                                    VRING_DESC_F_WRITE,
> >                                                    premapped);
> >               }
> >       }
> >       /* Last one doesn't continue. */
> > -     desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NE=
XT);
> > +     desc[prev].flags &=3D cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_=
NEXT);
> >       if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> >               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
> >                       ~VRING_DESC_F_NEXT;
> > @@ -649,7 +649,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >               if (vring_mapping_error(vq, addr))
> >                       goto unmap_release;
> >
> > -             virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> > +             virtqueue_add_desc_split(vq, vq->split.vring.desc,
> >                                        vq->split.desc_extra,
> >                                        head, addr,
> >                                        total_sg * sizeof(struct vring_d=
esc),
> > @@ -675,13 +675,13 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >       /* Put entry in available array (but don't update avail->idx unti=
l they
> >        * do sync). */
> >       avail =3D vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > -     vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(_vq->vdev,=
 head);
> > +     vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(vq->vq.vde=
v, head);
> >
> >       /* Descriptors and available array need to be set before we expos=
e the
> >        * new available array entries. */
> >       virtio_wmb(vq->weak_barriers);
> >       vq->split.avail_idx_shadow++;
> > -     vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> > +     vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vdev,
> >                                               vq->split.avail_idx_shado=
w);
> >       vq->num_added++;
> >
> > @@ -691,7 +691,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >       /* This is very unlikely, but theoretically possible.  Kick
> >        * just in case. */
> >       if (unlikely(vq->num_added =3D=3D (1 << 16) - 1))
> > -             virtqueue_kick(_vq);
> > +             virtqueue_kick(&vq->vq);
> >
> >       return 0;
> >
> > @@ -706,7 +706,6 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >       for (n =3D 0; n < total_sg; n++) {
> >               if (i =3D=3D err_idx)
> >                       break;
> > -
> >               i =3D vring_unmap_one_split(vq, &extra[i]);
> >       }
> >
>
> can't say I like this, error handling is better separated visually from
> good path.

I don't see a connection to this commnet, this patch doesn't touch the
error handling. We can try to optimize the error handling on top.

But I will remove the unnecessary newline change here.

Thanks

