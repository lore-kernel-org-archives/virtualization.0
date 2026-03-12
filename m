Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28241F03D7
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296888; cv=none; b=pezQZR42PDr/NW+OW2pUBEUmBeXDnkIGBaX8N2G+EP0tLRlArXKp5UxS0826PYVbPsWtpDE38jhaYnMxdoUbAGEVAGg1gWfSlPmScc5FYgSJ5i/gwmPOkE5Ne/F5Xa3fgEYuj8IW4HB8i3s+eoWnq+4klOYQxnLF4yUQPwuQtsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296888; c=relaxed/simple;
	bh=dN1RPNmWlB1fIKHpUZUkYc6dEJRC+Dqdx+ncUdXcx4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9Xd60C+94ngEWu0y3JcU4zwYOpB1Mvi036YKSrdjUSWHGmZ9LGcWmTpr9LR1KVqRjIQ64sj4GOVn8rOXdGKzcAtTEbxkfPGlnjvwE5dl8kCq0D/96HRKiTC3gMwRTArQV4dQ46PxWySPG7ENfjZmQKbzldmg89aU/2e5/+ondY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCy8lzTN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCy8lzTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773296885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ejmc+kwIVpy7qDMYMF+VlYwwBwTwY/3GRVajXxykXlA=;
	b=TCy8lzTNgsAjftIvto54qRmcZbIU2nKkwMWJ0FbGqdp0Z8ZDonWMrjicNM8RVeQiI4tFXh
	aZw8xXG+EoZMlKGJ+8jA0xZWQfnqI92tbXwhKKwPtu5ILw/MVkCjOpFcvuFxhJraqLVRRd
	rARYzgYiw2LEh4WXuIB7CijOoXCLcro=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Bx2yKaguMhajys17n_GuRA-1; Thu, 12 Mar 2026 02:28:04 -0400
X-MC-Unique: Bx2yKaguMhajys17n_GuRA-1
X-Mimecast-MFC-AGG-ID: Bx2yKaguMhajys17n_GuRA_1773296884
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79878791ec6so14791347b3.3
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 23:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296884; x=1773901684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ejmc+kwIVpy7qDMYMF+VlYwwBwTwY/3GRVajXxykXlA=;
        b=UAnX1sIObfCaINIfB6y0KTHZkiaVDahS3GCzl2PfKDdSfKDe3K576tRiCGQiO4TsqA
         bCrJLinwnBV5dUhgTvrYW/6J0oiAw8bQxICJydaUV3zzHI1WwhWSEvMlhm9nQB1lQaar
         0eOBDtXavZ4eeHnQDuxW2hRLcNhdzPApZqrn1HcqV2qFBLDbaw30YyBoSOVW647wwbG7
         Ob8glgDnBsELgaQfJD6fny0GkW15B668Ulu844444xl2V/ITxPF6NFzbB2kwUfsywRo8
         60uf+sjXlW5GkPqQ4+N/5GXUcAhct3OxLRxfkvwH3gBUQ156dWPkKB/Zol+vsQo874fc
         3aHA==
X-Forwarded-Encrypted: i=1; AJvYcCX8NydP7OFMy/Ysx767ke0OMHfwQLmIzCMgj3FL3xlZTKrVPoqN7NuojujxNgPrKNMg24oHhl17nVOY7zUASg==@lists.linux.dev
X-Gm-Message-State: AOJu0YybYhvdL2i8CnW9Vzxqeugzp7sXjL80mw4HknmMFl/pX4pzVDGy
	46B9wFtNWSyjjXsgFFrN4fkSiZYHEIS5oRWyDyTgyjsmW1h73dC1NJAS8OcA+1BKqTDM06apSEC
	P0KzpGfeJg1doRvcHnmRrdWdErEAcePKOkMN8uA3aYZ4YhhcVLoEx6VkwJKUU2sN4PV3cbjamXu
	MVXnNAvwCOphc50zfFzafMTOKNLGCN2IYx2VevHiDro1s=
X-Gm-Gg: ATEYQzwS5iEqwPXRf0dHgNlEtPvuDncEuafRw3Jmg/ANdPCWwuwZfhmcc1N1zUYmacm
	mqY9lfbbVsDyUbW94QzeusZ4SmIjdv3UaF6SDe6eIcnUP8F6us9P9wzGAMXf0foigMB5HndibEJ
	Yois5AA3Pl1BYp0EC05HFi4k6D9UCU1Tq7LGODReIQXUqgPCMM9C6oNaoOcE7Yad01Fik5sNtiW
	KatVw==
X-Received: by 2002:a05:690c:2704:b0:794:d7ed:53a0 with SMTP id 00721157ae682-79917fb08f7mr47766937b3.53.1773296883889;
        Wed, 11 Mar 2026 23:28:03 -0700 (PDT)
X-Received: by 2002:a05:690c:2704:b0:794:d7ed:53a0 with SMTP id
 00721157ae682-79917fb08f7mr47766727b3.53.1773296883493; Wed, 11 Mar 2026
 23:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310191019.1099757-1-eperezma@redhat.com> <CACGkMEtAQ1HM_4P0aM2AARy7LVtjFmtzbPGOkYn4jD5KMJ+cBQ@mail.gmail.com>
In-Reply-To: <CACGkMEtAQ1HM_4P0aM2AARy7LVtjFmtzbPGOkYn4jD5KMJ+cBQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Mar 2026 07:27:27 +0100
X-Gm-Features: AaiRm52iGNrW0zfL3gFwfs2lUhFwPieXv3WBj-joFOqyeOxnh007WraYWm6fLbs
Message-ID: <CAJaqyWcdBxgnCppxpF=YNptFAOXtee3tUqn7kXRiM+XO1fy+UA@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Add suspend
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -1IIjohHBSXZvH5RtANW-LHvFjNpe-v1AjOHh4Oqltk_1773296884
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 5:03=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 3:10=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Implement suspend operation for vduse devices, so vhost-vdpa will offer
> > that backend feature and userspace can effectively suspend the device.
> >
> > This is a must before get virtqueue indexes (base) for live migration,
> > since the device could modify them after userland gets them.
>
> As discussed in the pervious version, let's explain why and the plan
> to support resume.
>

Is it ok to explain it just in the patch message or do you prefer
something like a /* TODO: resume op */ before the suspend callback?

> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > This patch depends on
> > https://lore.kernel.org/lkml/20260310190759.1097506-1-eperezma@redhat.c=
om
> >
> > v2:
> > * Take the rwsem only before the actual kick, not in vduse_vdpa_kick_vq=
.
> >   This assures that we're not in a critical section.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 86 +++++++++++++++++++++++++++++-
> >  include/uapi/linux/vduse.h         |  4 ++
> >  2 files changed, 88 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 4f642b95a7cb..f56b1e3eb82d 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -54,7 +54,8 @@
> >  #define IRQ_UNBOUND -1
> >
> >  /* Supported VDUSE features */
> > -static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY);
> > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY) =
|
> > +                                      BIT_U64(VDUSE_F_SUSPEND);
> >
> >  /*
> >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > @@ -85,6 +86,7 @@ struct vduse_virtqueue {
> >         int irq_effective_cpu;
> >         struct cpumask irq_affinity;
> >         struct kobject kobj;
> > +       struct vduse_dev *dev;
> >  };
> >
> >  struct vduse_dev;
> > @@ -134,6 +136,7 @@ struct vduse_dev {
> >         int minor;
> >         bool broken;
> >         bool connected;
> > +       bool suspended;
> >         u64 api_version;
> >         u64 device_features;
> >         u64 driver_features;
> > @@ -480,6 +483,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
> >
> >         down_write(&dev->rwsem);
> >
> > +       dev->suspended =3D false;
> >         dev->status =3D 0;
> >         dev->driver_features =3D 0;
> >         dev->generation++;
> > @@ -538,6 +542,10 @@ static void vduse_vq_kick(struct vduse_virtqueue *=
vq)
> >         if (!vq->ready)
> >                 goto unlock;
> >
> > +       guard(rwsem_read)(&vq->dev->rwsem);
> > +       if (vq->dev->suspended)
> > +               return;
>
> Any reason for this? E.g We don't do this for other transports.
>

It's just a hardening but I'm happy to remove it.

> Everything else looks good.
>
> Thanks
>

