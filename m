Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8062DAFBB
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967701; cv=none; b=qcomcP/BltpJ72/wfvmLhuK8se29oCQwucth0yrP3/5ozcu3cATn3jwnnm6UdYIQ35ojZsWnCYxeHA14c/NWDRRA4F06qyZgsG/WZ/FW3/M5+4Wtctj/BCuSpXPmH5cCxywOML0ntQURKeTa3IhsAuJxZTCCO9+pMEA7bimTfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967701; c=relaxed/simple;
	bh=FRNkmyIGRZfkC5SrUwIs8BFVvGk7FLcVut2X8jIKp/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTjokRACxSWSQ0pQ9BHN3FG8KUDcXC/AdR8OEz8NcnQ6Sl6n19T4Ifh77L+DcgpZx4YBfowcbOC4t4/HHofhunOkrd/8PzmaR91hsZ0FFX8KRrdIEVMdtrTJKRCPOJEBo8d/+EqIZmzsmRubHPSImnLvV6+5sBwe65PGCGeDvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBwoXOea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBwoXOea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754967697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXcDrKzmleXkZZvSJcFC+popEo/MH2O5hILC0DB+8iE=;
	b=TBwoXOeaS78RlHVXPpcbHZ2HMFxQA5lVDJFQp9EfDBR5p1hDK7UC2PwbB+gdBLoATZ1uJa
	p6MGT2nWUdav069wjo3qUcnM8G9E/if9rZ8QHac2C1cLEVDfYvzMSJheRPfDXDZjHAhq43
	KpN4D0887cD/j8Jde6BGOFSHtWPPufQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-um5vIzYmOaqBA-n0rDYlvQ-1; Mon, 11 Aug 2025 23:01:36 -0400
X-MC-Unique: um5vIzYmOaqBA-n0rDYlvQ-1
X-Mimecast-MFC-AGG-ID: um5vIzYmOaqBA-n0rDYlvQ_1754967695
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32147620790so5342154a91.1
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 20:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754967695; x=1755572495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXcDrKzmleXkZZvSJcFC+popEo/MH2O5hILC0DB+8iE=;
        b=SfNgOOokHQ17XSARo3/8HARYFvhXOll2PddvFCz/Af8qbnQy+CwjNxaHHTxDtwaCav
         pJcig1XRjd9qnBu5jYay3BEaYkDM0veO2cONdFnF3l1eGqSxtR78et5xJqk+DLIiy+Uj
         N29U1BU6xPXv5XUSB03rk821/ufg8aSpTDobjTPC7l1+H4P8eF/6J1v78f23BWkT4yUR
         ocriAmgbOjUPfUIN0RWrdja62EDYE4TYAfFsdJSod34AN/kniD1RwvQ+PeN6a5X7W/FD
         /iQT8mMtmzIesrQL8on3ys7uJF5QorTjPNECTCYnPbpuhkOPXkSIMT5QAm9mdU/C6Ep2
         SEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGwWumSEsF9PokVm1NMFYMiNgVQnxbGQ60yihcXy7XlHvRd6xL7D2I9kxWf3bdma3HmcneJ6ePf1gSUeG9Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxvs/J1zEhpXDjQI1cnWfI9yMgLNxbwP43N2REExSft8vbiPapl
	pwRnU1VotvViv41TNqxrmR3eKzG4bex+hbtmcJXn/NFsZoMZBxq1PZhndrrsb148l07hhLFB02y
	miCXq6qXm4GD6ZjntZw6bs6oHiAjvKcl1dBgkoxciqFfg7qiMs4KKFBC0+xOFeCaIE1/jjv2nOf
	OdSDiGQLYR9zOxGtw7D1MCMW1zrB6sAYwMCWEQ79V3SZI=
X-Gm-Gg: ASbGncsQ8CvhKxIXqkltKeCGfVxfKhxb4l7kS2Ey2ZsnUsx+lRia8F8OEMZ44bATnqv
	Iq6Eys8iwq3vYYTE98MqQf5dr6+GRPgQmOWYycBrn3LG6LznbuFwnIByqBkj3Yi4IxWfQdlTzW7
	8lAXXWAHjgoji7RjKlCd2GJdM=
X-Received: by 2002:a17:902:fc47:b0:242:d8df:f825 with SMTP id d9443c01a7336-242fc367f3amr20963225ad.27.1754967694956;
        Mon, 11 Aug 2025 20:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoPjpmdiT5XkbDR7sZg80IBGgYIt3Zm3upy7dVJWT730qe7UD8OfkIsBZsMHYybaQR6Pc3E5yWW93/A2lkZa0=
X-Received: by 2002:a17:902:fc47:b0:242:d8df:f825 with SMTP id
 d9443c01a7336-242fc367f3amr20962725ad.27.1754967694446; Mon, 11 Aug 2025
 20:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
 <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com> <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com>
In-Reply-To: <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Aug 2025 11:01:23 +0800
X-Gm-Features: Ac12FXy6buDk7v1XeKBtiDS7OwYpGm54-0cAvQTN7fCpc1VH-iW_THBu3PGqyzM
Message-ID: <CACGkMEuZq2NaS9icynhrgZtXQ26fDFFpFrP3bUwDXLCR6uN4qw@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GsXwS_N7uAHlwat1usdHoEHGqZZG_MawEGCR1RwsF0A_1754967695
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:52=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Aug 11, 2025 at 5:10=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > This allows sepparate the different virtqueues in groups that shares =
the
> > > same address space.  Asking the VDUSE device for the groups of the vq=
 at
> > > the beginning as they're needed for the DMA API.
> > >
> > > Allocating 3 vq groups as net is the device that need the most groups=
:
> > > * Dataplane (guest passthrough)
> > > * CVQ
> > > * Shadowed vrings.
> > >
> > > Future versions of the series can include dynamic allocation of the
> > > groups array so VDUSE can declare more groups.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v2:
> > > * Cache group information in kernel, as we need to provide the vq map
> > >   tokens properly.
> > > * Add descs vq group to optimize SVQ forwarding and support indirect
> > >   descriptors out of the box.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 71 ++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/vduse.h         | 19 +++++++-
> > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index d858c4389cc1..d1f6d00a9c71 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -46,6 +46,11 @@
> > >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
> > >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> > >
> > > +/*
> > > + * Let's make it 3 for simplicity.
> > > + */
> > > +#define VDUSE_MAX_VQ_GROUPS 3
> >
> > I think we can release this to something like 64. Otherwise we might
> > bump the version again just to increase the limitation? Or having a
> > sysfs entry like bounce_size?
> >
>
> I think it should not be linked to the version, but it is true there
> is no way for VDUSE devices to check the maximum VQ groups / ASID that
> the kernel supports.
>
> To handle as bounce_size seems the best option, good point. I'll send
> a new version with that!
>
> > > +
> > >  #define IRQ_UNBOUND -1
> > >
> > >  struct vduse_virtqueue {
> > > @@ -58,6 +63,8 @@ struct vduse_virtqueue {
> > >         struct vdpa_vq_state state;
> > >         bool ready;
> > >         bool kicked;
> > > +       u32 vq_group;
> > > +       u32 vq_desc_group;
> > >         spinlock_t kick_lock;
> > >         spinlock_t irq_lock;
> > >         struct eventfd_ctx *kickfd;
> > > @@ -114,6 +121,7 @@ struct vduse_dev {
> > >         u8 status;
> > >         u32 vq_num;
> > >         u32 vq_align;
> > > +       u32 ngroups;
> > >         struct vduse_umem *umem;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > > @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa_d=
evice *vdpa, u16 idx,
> > >         return 0;
> > >  }
> > >
> > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +
> > > +       return dev->vqs[idx]->vq_group;
> > > +}
> > > +
> > > +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx=
)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +
> > > +       return dev->vqs[idx]->vq_desc_group;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_dev=
ice *vdpa)
> > >         return dev->status;
> > >  }
> > >
> > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > +{
> > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > +               return 0;
> > > +
> > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > +               struct vduse_dev_msg msg =3D { 0 };
> > > +               int ret;
> > > +
> > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > +               msg.req.vq_group.index =3D i;
> > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> >
> > I fail to understand why the default group mapping is not done during
> > device creation.
> >
>
> Because it changes depending on the features.
>
> If a new device has 5 virtqueues and the device wants to isolate the
> CVQ, the CVQ position depends on the features that the guest's acks:
> * If MQ is acked the isolated vq is #5
> * If MQ is not acked the isolated vq is #3.

I see we are still damaged by the design of the cvq index. But this is
just a static branch not a dynamic one. If we can find ways to make it
static it would be better.

>
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> > > +
> > > +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.num;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 statu=
s)
> > >  {
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       u8 previous_status =3D dev->status;
> > >
> > >         if (vduse_dev_set_status(dev, status))
> > >                 return;
> > >
> > > +       if ((dev->status ^ previous_status) &
> > > +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> > > +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> > > +               if (vduse_fill_vq_groups(dev))
> >
> > Can we merge the two messages into a single one? Or can we use a
> > shared memory for storing such mapping?
> >
> > For example, if we have 256 queues it would be very slow.
> >
>
> To merge it in the same message is good to me, sure.

We can start from this if we can't find a way to provision vq to group
mapping during device creation.

> To make it a
> table in shm seems more complicated, unless we accept a void * in the
> reply and VDUSE uses copy_from_user. If that is ok here, then sure.
>

This looks tricky indeed.

Thanks

