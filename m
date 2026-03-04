Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726833067C
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605302; cv=none; b=IWMe35+0z1Vpxe4cVibre08CiUxhkuiIGDuV0WpAoytTfjrtyXuFxi3Z5eR/6ZBUJ6y9x8tpxZd1v35FM/Jnh611Mf1zehkDmOwy+HbRGZAjRrNTJdSSp9FlmWglbwuPSAi5EYCktFbJG/btM+iUceT54QhfBzsqagPDZtnC+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605302; c=relaxed/simple;
	bh=SbgfWJieII3AmdL/YXzuHJJ6cnfe7ZmZ8OhkyvT2tyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntCsDUilxiwVRnv4rUHsUHA8MLzW9TLRmslcTsq79FKdpVxLfZM0r9YDQpYf36yXs+RXcgHCOIYwCQlfKbN5BXaqdNsz7+fas24xtkBuftIv7qv+dgvgek5uemvKOzONx6FNmdntpwFsZTz1+R2W2kyZbg78wT+RehCBatHYKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEkcDF3j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEkcDF3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772605300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbTFBztdeX/4HkwDOKVIaF65ojZmuw5OduR3Zh3G4Yc=;
	b=eEkcDF3j+4Vyc8bNLDx6HUKZwcaWV82G8ZPtdUFqawRgZRyE/pDJcCoqBEVUhH6zQmhM1q
	soSYHHqkah4OowGA4pRQQowOo6mQ/a7iCigHgADI1MEHn0PF7Mcqc+wWWZsQdSpHXz7/iK
	5jxrNAkxrCp22xelyrHotNBKTXy1n6Q=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-iAfVLwThMnu4EUFo-vlShg-1; Wed, 04 Mar 2026 01:21:38 -0500
X-MC-Unique: iAfVLwThMnu4EUFo-vlShg-1
X-Mimecast-MFC-AGG-ID: iAfVLwThMnu4EUFo-vlShg_1772605298
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64ad0e5cddbso7423505d50.3
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 22:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772605298; x=1773210098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbTFBztdeX/4HkwDOKVIaF65ojZmuw5OduR3Zh3G4Yc=;
        b=IoIdXK+DM0KfKuyiD7zRLQXeml32v9DgSUwfD8M7QSGnwtDdIHoD1lUgFjSkkdeP/m
         +FrD6w9AEbqiweW2ul1oHoh7yj2mJ1G9Qxwq6addvfuqfHhzGyu8z9i803GpftVQibFu
         CdsqfohRmmYqOEPd3v0KNtzfBJbP2DJz7iloMjNbqC0KsUhy8/Bpl9QuGtenKlsyWyyH
         4ZgyaR53EiPRkA/RhN00p9zqzPZ8GR9a09ie5JGDiJSfw8OcNwt487qtzMN3QoknPR9v
         H9jLCvi0xIe6zVDTbBxYkiiUwDW3rOnQi5bc9l9t+y5l1aqpWDUU3EQGzoSSUAypr5la
         g0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWALVmY2OpTX7Js7+yINbUhelvHYbR1vj0fs9ZIo/phm8+BRHCsxvMgcNTZXXahLBDzEctp72KayCNGp+xeAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpmjY4MpCxEl8WcWqko0vgbP4YRPg8YBRqk4tb5KNyKZU0858P
	tgbBkCQzvNjQYeEbpbW+Pg6ftc5d0YKd95k9tV+BPoJsvMW+wllZTVeWb3NObj6Pxg0MTxfzntS
	S9kL/ng4bs0YUGlE2vsOUUvRrcIv/HQRNki9wNMOIEWTVt8fAr4rzyyqq0jpdTavbwjzsefYexd
	NVkZTmPmDiRGHsuym6D/A9THXt+mKa3/AswWAJxwKknvA=
X-Gm-Gg: ATEYQzwgjnSUxuQNWID0kM8MJnxgh08lMS3aPQ5wwnoCX3x8/3HJG05octeV01Cb+qQ
	YqvwZGR886tru+MRccgmV9pFJGhLtUUy3RhAW+23f03lfn1gbrTdtgCTTMJPb5kMNjJCbOcdUfC
	1Y2j+r/n8+VMqrXsgm35s6u+GZpiYQFKfyOgS8pgCZLMWYbQ+0wR6a2tctXwyyGwZaijr0RbKm2
	zSJFw==
X-Received: by 2002:a53:e194:0:b0:64a:ec39:dd54 with SMTP id 956f58d0204a3-64cf9b6a4bamr655241d50.39.1772605298198;
        Tue, 03 Mar 2026 22:21:38 -0800 (PST)
X-Received: by 2002:a53:e194:0:b0:64a:ec39:dd54 with SMTP id
 956f58d0204a3-64cf9b6a4bamr655224d50.39.1772605297767; Tue, 03 Mar 2026
 22:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260211120158.2501592-1-eperezma@redhat.com> <CACGkMEtizCT+4WUXaROEvnWgKoFVqv9iRfLk-3HduRnsKfthqQ@mail.gmail.com>
 <CAJaqyWczXRDAWAtgR5Z2=A-ZRr=vWJw3Vm40VV0zTNjFCzECNg@mail.gmail.com> <CACGkMEvsTfamC+_-KXQ=eJWhvO0TztOo5jgX7eugCLGosVwCUQ@mail.gmail.com>
In-Reply-To: <CACGkMEvsTfamC+_-KXQ=eJWhvO0TztOo5jgX7eugCLGosVwCUQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 4 Mar 2026 07:21:01 +0100
X-Gm-Features: AaiRm50u1RM5FRiFQQKg_8Hhj_CEd3KSup62n5sBeeWiCLAoQwWIiu0V04ZBJu0
Message-ID: <CAJaqyWerKfULoXn-xz2MYPk5XGyB-99XOuLk0LgL0F9MvdSuMA@mail.gmail.com>
Subject: Re: [PATCH] vduse: Add suspend
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rawJM3FLQRytBuE1KDIM9Zih0RtljIf4LAFu5B9SYgw_1772605298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:52=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Mar 3, 2026 at 6:51=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Tue, Mar 3, 2026 at 8:26=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Wed, Feb 11, 2026 at 8:02=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Implement suspend operation for vduse devices, so vhost-vdpa will o=
ffer
> > > > that backend feature and userspace can effectively suspend the devi=
ce.
> > > >
> > > > This is a must before get virtqueue indexes (base) for live migrati=
on,
> > > > since the device could modify them after userland gets them.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > This series depends on
> > > > https://lore.kernel.org/lkml/20260210082554.1582553-1-eperezma@redh=
at.com
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 86 ++++++++++++++++++++++++++=
+++-
> > > >  include/uapi/linux/vduse.h         |  4 ++
> > > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 59d9c4718d86..bdcc114e2710 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -54,7 +54,8 @@
> > > >  #define IRQ_UNBOUND -1
> > > >
> > > >  /* Supported VDUSE features */
> > > > -static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_REA=
DY);
> > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_REA=
DY) |
> > > > +                                      BIT_U64(VDUSE_F_SUSPEND);
> > > >
> > > >  /*
> > > >   * VDUSE instance have not asked the vduse API version, so assume =
0.
> > > > @@ -85,6 +86,7 @@ struct vduse_virtqueue {
> > > >         int irq_effective_cpu;
> > > >         struct cpumask irq_affinity;
> > > >         struct kobject kobj;
> > > > +       struct vduse_dev *dev;
> > > >  };
> > > >
> > > >  struct vduse_dev;
> > > > @@ -134,6 +136,7 @@ struct vduse_dev {
> > > >         int minor;
> > > >         bool broken;
> > > >         bool connected;
> > > > +       bool suspended;
> > > >         u64 api_version;
> > > >         u64 device_features;
> > > >         u64 driver_features;
> > > > @@ -480,6 +483,7 @@ static void vduse_dev_reset(struct vduse_dev *d=
ev)
> > > >
> > > >         down_write(&dev->rwsem);
> > > >
> > > > +       dev->suspended =3D false;
> > > >         dev->status =3D 0;
> > > >         dev->driver_features =3D 0;
> > > >         dev->generation++;
> > > > @@ -559,6 +563,10 @@ static void vduse_vdpa_kick_vq(struct vdpa_dev=
ice *vdpa, u16 idx)
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > >
> > > > +       guard(rwsem_read)(&vq->dev->rwsem);
> > > > +       if (vq->dev->suspended)
> > > > +               return;
> > > > +
> > > >         if (!eventfd_signal_allowed()) {
> > > >                 schedule_work(&vq->kick);
> > > >                 return;
> > > > @@ -896,6 +904,27 @@ static int vduse_vdpa_set_map(struct vdpa_devi=
ce *vdpa,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > +       int ret;
> > > > +
> > > > +       msg.req.type =3D VDUSE_SUSPEND;
> > > > +
> > > > +       ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > +       if (ret =3D=3D 0) {
> > > > +               scoped_guard(rwsem_write, &dev->rwsem)
> > > > +                       dev->suspended =3D true;
> > > > +
> > > > +               cancel_work_sync(&dev->inject);
> > > > +               for (u32 i =3D 0; i < dev->vq_num; i++)
> > > > +                       cancel_work_sync(&dev->vqs[i]->inject);
> > >
> > > Should we cancel those before msy sync?
> > >
> >
> > The only condition is that the driver must not see interrupts from the
> > moment the ioctl returns.
>
> I think you meant "vduse_vdpa_suspend returns" here.
>
> >
> > Also, disabling it before the msg returns would add complexity because
> > it needs to be reenabled & call the driver if it falis. Or am I
> > missing something it adds?
>
> I think not but I have another question:
>
> 1) I don't see resume, any reason for that

It's not strictly neccesary, and QEMU doesn't even support resume at
the moment. Every time we've implemented suspend / resume in the VDPA
core or parent drivers, it has been done in two different series.

> 2) assuming we need to support resume, do we need to record pending
> interrupt otherwise we may lose interrupt after resuming
>

Sure, I'll handle that when / if I add the resume operation.

> >
> > TBH this is more of a hardening than something the VDUSE driver should
> > do. We could even move to the vdpa core.
> >
> > > > +       }
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > >  static void vduse_vdpa_free(struct vdpa_device *vdpa)
> > > >  {
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > @@ -937,6 +966,41 @@ static const struct vdpa_config_ops vduse_vdpa=
_config_ops =3D {
> > > >         .free                   =3D vduse_vdpa_free,
> > > >  };
> > > >
> > > > +static const struct vdpa_config_ops vduse_vdpa_config_ops_with_sus=
pend =3D {
> > > > +       .set_vq_address         =3D vduse_vdpa_set_vq_address,
> > > > +       .kick_vq                =3D vduse_vdpa_kick_vq,
> > > > +       .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> > > > +       .set_vq_num             =3D vduse_vdpa_set_vq_num,
> > > > +       .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > > > +       .get_vq_group           =3D vduse_get_vq_group,
> > > > +       .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> > > > +       .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> > > > +       .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > > > +       .get_vq_state           =3D vduse_vdpa_get_vq_state,
> > > > +       .get_vq_align           =3D vduse_vdpa_get_vq_align,
> > > > +       .get_device_features    =3D vduse_vdpa_get_device_features,
> > > > +       .set_driver_features    =3D vduse_vdpa_set_driver_features,
> > > > +       .get_driver_features    =3D vduse_vdpa_get_driver_features,
> > > > +       .set_config_cb          =3D vduse_vdpa_set_config_cb,
> > > > +       .get_vq_num_max         =3D vduse_vdpa_get_vq_num_max,
> > > > +       .get_device_id          =3D vduse_vdpa_get_device_id,
> > > > +       .get_vendor_id          =3D vduse_vdpa_get_vendor_id,
> > > > +       .get_status             =3D vduse_vdpa_get_status,
> > > > +       .set_status             =3D vduse_vdpa_set_status,
> > > > +       .get_config_size        =3D vduse_vdpa_get_config_size,
> > > > +       .get_config             =3D vduse_vdpa_get_config,
> > > > +       .set_config             =3D vduse_vdpa_set_config,
> > > > +       .get_generation         =3D vduse_vdpa_get_generation,
> > > > +       .set_vq_affinity        =3D vduse_vdpa_set_vq_affinity,
> > > > +       .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > > +       .reset                  =3D vduse_vdpa_reset,
> > > > +       .set_map                =3D vduse_vdpa_set_map,
> > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > +       .get_vq_map             =3D vduse_get_vq_map,
> > > > +       .suspend                =3D vduse_vdpa_suspend,
> > >
> > > We can have a
> > >
> > > if (suspend_is_supported)
> > >         ...
> > >
> > > to avoid having a new set of config ops?
> > >
> >
> > It complicates the code of vhost_vdpa in my opinion.
> >
> > Currently, it is:
> > if (ops->suspend)
>
> Okay, I see the problem which is:
>
> static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
> {
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>
>         return ops->suspend;
> }
>
> >
> > And that would move to something like:
> > if (ops->suspend) {
> >   if (ops->suspend_is_supported && !ops->suspend_is_supported(dev)) {
> >     return; // CANNOT SUSPEND
> >   }
> >
> >   ops->suspend(dev)
> > }
> >
> > Another option I considered is to follow mlx5's approach and have one
> > set of ops per device. But I think duplicating the vdpa_ops in the
> > data section is the cleanest approach. Let me know if you think we
> > should go with suspend_is_supported callback instead.
>
> I think there's no need then.
>
> >
> > > > +       .free                   =3D vduse_vdpa_free,
> > > > +};
> > > > +
> > > >  static void vduse_dev_sync_single_for_device(union virtio_map toke=
n,
> > > >                                              dma_addr_t dma_addr, s=
ize_t size,
> > > >                                              enum dma_data_directio=
n dir)
> > > > @@ -1148,6 +1212,10 @@ static void vduse_dev_irq_inject(struct work=
_struct *work)
> > > >  {
> > > >         struct vduse_dev *dev =3D container_of(work, struct vduse_d=
ev, inject);
> > > >
> > > > +       guard(rwsem_read)(&dev->rwsem);
> > > > +       if (dev->suspended)
> > > > +               return;
> > >
> > > Device can still modify memory, so I wonder how much this can help.
> > >
> >
> > Do you prefer me to remove this guard?
>
> Nope, I misread the code, it should be fine.
>
> Thanks
>
> >
> > > > +
> > > >         spin_lock_bh(&dev->irq_lock);
> > > >         if (dev->config_cb.callback)
> > > >                 dev->config_cb.callback(dev->config_cb.private);
> > > > @@ -1159,6 +1227,10 @@ static void vduse_vq_irq_inject(struct work_=
struct *work)
> > > >         struct vduse_virtqueue *vq =3D container_of(work,
> > > >                                         struct vduse_virtqueue, inj=
ect);
> > > >
> > > > +       guard(rwsem_read)(&vq->dev->rwsem);
> > > > +       if (vq->dev->suspended)
> > > > +               return;
> > > > +
> > > >         spin_lock_bh(&vq->irq_lock);
> > > >         if (vq->ready && vq->cb.callback)
> > > >                 vq->cb.callback(vq->cb.private);
> > > > @@ -1189,6 +1261,9 @@ static int vduse_dev_queue_irq_work(struct vd=
use_dev *dev,
> > > >         int ret =3D -EINVAL;
> > > >
> > > >         down_read(&dev->rwsem);
> > > > +       if (dev->suspended)
> > > > +               return ret;
> > > > +
> > > >         if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > >                 goto unlock;
> > > >
> > > > @@ -1839,6 +1914,7 @@ static int vduse_dev_init_vqs(struct vduse_de=
v *dev, u32 vq_align, u32 vq_num)
> > > >                 }
> > > >
> > > >                 dev->vqs[i]->index =3D i;
> > > > +               dev->vqs[i]->dev =3D dev;
> > > >                 dev->vqs[i]->irq_effective_cpu =3D IRQ_UNBOUND;
> > > >                 INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject=
);
> > > >                 INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
> > > > @@ -2311,12 +2387,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
> > > >  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *=
name)
> > > >  {
> > > >         struct vduse_vdpa *vdev;
> > > > +       const struct vdpa_config_ops *ops;
> > > >
> > > >         if (dev->vdev)
> > > >                 return -EEXIST;
> > > >
> > > > +       if (dev->vduse_features & BIT_U64(VDUSE_F_SUSPEND))
> > > > +               ops =3D &vduse_vdpa_config_ops_with_suspend;
> > > > +       else
> > > > +               ops =3D &vduse_vdpa_config_ops;
> > > > +
> > > >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->de=
v,
> > > > -                                &vduse_vdpa_config_ops, &vduse_map=
_ops,
> > > > +                                ops, &vduse_map_ops,
> > > >                                  dev->ngroups, dev->nas, name, true=
);
> > > >         if (IS_ERR(vdev))
> > > >                 return PTR_ERR(vdev);
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.=
h
> > > > index d39734cef6d3..95b93bc6bac5 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -21,6 +21,9 @@
> > > >  /* The VDUSE instance expects a request for vq ready */
> > > >  #define VDUSE_F_QUEUE_READY    0
> > > >
> > > > +/* The VDUSE instance expects a request for suspend */
> > > > +#define VDUSE_F_SUSPEND                1
> > > > +
> > > >  /*
> > > >   * Get the version of VDUSE API that kernel supported (VDUSE_API_V=
ERSION).
> > > >   * This is used for future extension.
> > > > @@ -338,6 +341,7 @@ enum vduse_req_type {
> > > >         VDUSE_UPDATE_IOTLB,
> > > >         VDUSE_SET_VQ_GROUP_ASID,
> > > >         VDUSE_SET_VQ_READY,
> > > > +       VDUSE_SUSPEND,
> > > >  };
> > > >
> > > >  /**
> > > > --
> > > > 2.53.0
> > > >
> > >
> > > Thanks
> > >
> >
>

