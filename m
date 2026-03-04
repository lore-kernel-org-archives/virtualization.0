Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B5327C13
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772603538; cv=none; b=YgCNJnNQQ/8LQLRvfnFTGaaCCFY80+Ein2o0puyWjDY9NI0WhQZ6mUH/PwbzxcAI9N7zzRtDbsD/O/3k3SmQARnC0a7vUEpuF3wVaBe16QzyQ53LMPPJ+T6OxaJ8+onAE/Ev7UkYAxurLONu3VoqZjpkglCuGEcdWuoL6JVOJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772603538; c=relaxed/simple;
	bh=FAZ5w62IEfZLoy2/FFNOfug77S1eAM7B8tmSGFLONmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWTOgWrM/j70EocoKFu1j3KT/WJH+hbmPGzSfekLmt5kdXX1yGTOJH1P2VDrTJzWuozj65UTg+Bv4uSE8uewslFlS2+uhOX91mZby/7ykGX28Ib6FjjronqdYS6ZSNym0Kp0YHo5gRRkPfrmN2/xRpiEhI5Pg3wACHQgYS90CjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itaNyn4R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itaNyn4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772603535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnBWREkxyMd12W2Xs3U3MOTgXJ4tDspEjdFaS5YpAec=;
	b=itaNyn4Rfeej6FKnljDiHOYgVePjCEKhMFaB6bYyvhzq9TPqLLgzaOa6LmjsLP0z9avkaz
	TNr/KPU1UoqYVhVSKJMl9sagbGrQFtawAv4V0sXuzhkRYH1YQCvBk6ML8pjqVVXWIe2SeC
	faSf9U17/Ua0CwOJtYtIimEuaVPkGWc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-mb1FjDKaN2mlhs64UL56yA-1; Wed, 04 Mar 2026 00:52:14 -0500
X-MC-Unique: mb1FjDKaN2mlhs64UL56yA-1
X-Mimecast-MFC-AGG-ID: mb1FjDKaN2mlhs64UL56yA_1772603533
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso5340872a91.2
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 21:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772603533; x=1773208333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnBWREkxyMd12W2Xs3U3MOTgXJ4tDspEjdFaS5YpAec=;
        b=lz6E0mV4QvjCcfF0DtE7WG6ABPxQLEec51sRieGPdbMzBQfVkYGM7KfBlhu4UT9ghd
         OZoBGsDjVFWZp6YchZEfcKtLNz0uAIyjeEga9tCdM0fgnWqLxz+kCI1EbK2BC2anhaBM
         jMQPVwd8VgWgDFTqvgdCjM6agIqTLcQ63QxAphhati+BJ3PptpqAAwqn7lYlCDP/p0ax
         WVokRrEfZR29Ug+9W5en5enhRbmZeyssLu3RfVgPtlH9M+OEnvYFi4/KEuBn48SXGEzW
         2JP5cw15PiiyDk6qi0Kqu+e6wIHMBjCGLAe1lgFJcU6VKXS44rsvjILsWP94CSrrUjZB
         Vatw==
X-Forwarded-Encrypted: i=1; AJvYcCWgMyuKl9MvQAZTyBoeDNzB1NClgKqFNZJklVJJiEtsYsp+2nR/iX7SeIKPVRSRhtxJJ5rIC32y7f7GQKTSlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1AdqDju+BfcBgAVOt2ygU05U65/wI1QRdgPFbAnvkUh8x6HvV
	0J0gd9dUfIH4EqnXTaPfz1jW+2PZ5xPdH3dPyX2AgZrhqImq5ezJcyWKlvIEMx2hDPYa0hLI1y9
	FgY+sbtRPspRrNf/9uS/m/VLmFY7yHGUiEChH86HJxdaBSdlvWPwAzAI+FkhGxT9UtF2HsRCERj
	XKj3xYWp38kZbn0AYfIspGscd/s3ip9S4VxgEMGrCiFAk=
X-Gm-Gg: ATEYQzzUgEGyj1vf3wTC/V3D8DupCJHwU3RzmX6YyJgRWfvRI3Fc3TrHucH/IQ4dFfn
	c6OW9az4inKvdaamrb1JKWXeVULJpC311lfZ/bM/5qqx6C/c+0BCI0TznFIR3BT+dtNQnLHXqMC
	rENSoeOtXhN+gVxbJGGQD1uCiNSrcvPI9FKQdWXpNI7uZqrO/nDkRppivxL49pHFW4SWVK0h04J
	VeSVxY=
X-Received: by 2002:a17:90a:c2cc:b0:358:d80e:3831 with SMTP id 98e67ed59e1d1-359a69a28bdmr1129149a91.3.1772603532800;
        Tue, 03 Mar 2026 21:52:12 -0800 (PST)
X-Received: by 2002:a17:90a:c2cc:b0:358:d80e:3831 with SMTP id
 98e67ed59e1d1-359a69a28bdmr1129119a91.3.1772603532302; Tue, 03 Mar 2026
 21:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260211120158.2501592-1-eperezma@redhat.com> <CACGkMEtizCT+4WUXaROEvnWgKoFVqv9iRfLk-3HduRnsKfthqQ@mail.gmail.com>
 <CAJaqyWczXRDAWAtgR5Z2=A-ZRr=vWJw3Vm40VV0zTNjFCzECNg@mail.gmail.com>
In-Reply-To: <CAJaqyWczXRDAWAtgR5Z2=A-ZRr=vWJw3Vm40VV0zTNjFCzECNg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 13:52:00 +0800
X-Gm-Features: AaiRm502LCX1HPBdV_wG_-NySxzMBCbjR4_mqDfjJJ3U4CKP1GWQkS0nP6-zyQc
Message-ID: <CACGkMEvsTfamC+_-KXQ=eJWhvO0TztOo5jgX7eugCLGosVwCUQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: Add suspend
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PHzkHS1tniT5DVyYIxSQg6PFCxfMcDOwqaodkwUwBrg_1772603533
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 6:51=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Tue, Mar 3, 2026 at 8:26=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Feb 11, 2026 at 8:02=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Implement suspend operation for vduse devices, so vhost-vdpa will off=
er
> > > that backend feature and userspace can effectively suspend the device=
.
> > >
> > > This is a must before get virtqueue indexes (base) for live migration=
,
> > > since the device could modify them after userland gets them.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > This series depends on
> > > https://lore.kernel.org/lkml/20260210082554.1582553-1-eperezma@redhat=
.com
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 86 ++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/vduse.h         |  4 ++
> > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 59d9c4718d86..bdcc114e2710 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -54,7 +54,8 @@
> > >  #define IRQ_UNBOUND -1
> > >
> > >  /* Supported VDUSE features */
> > > -static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY=
);
> > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY=
) |
> > > +                                      BIT_U64(VDUSE_F_SUSPEND);
> > >
> > >  /*
> > >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > > @@ -85,6 +86,7 @@ struct vduse_virtqueue {
> > >         int irq_effective_cpu;
> > >         struct cpumask irq_affinity;
> > >         struct kobject kobj;
> > > +       struct vduse_dev *dev;
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -134,6 +136,7 @@ struct vduse_dev {
> > >         int minor;
> > >         bool broken;
> > >         bool connected;
> > > +       bool suspended;
> > >         u64 api_version;
> > >         u64 device_features;
> > >         u64 driver_features;
> > > @@ -480,6 +483,7 @@ static void vduse_dev_reset(struct vduse_dev *dev=
)
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > +       dev->suspended =3D false;
> > >         dev->status =3D 0;
> > >         dev->driver_features =3D 0;
> > >         dev->generation++;
> > > @@ -559,6 +563,10 @@ static void vduse_vdpa_kick_vq(struct vdpa_devic=
e *vdpa, u16 idx)
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > >
> > > +       guard(rwsem_read)(&vq->dev->rwsem);
> > > +       if (vq->dev->suspended)
> > > +               return;
> > > +
> > >         if (!eventfd_signal_allowed()) {
> > >                 schedule_work(&vq->kick);
> > >                 return;
> > > @@ -896,6 +904,27 @@ static int vduse_vdpa_set_map(struct vdpa_device=
 *vdpa,
> > >         return 0;
> > >  }
> > >
> > > +static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int ret;
> > > +
> > > +       msg.req.type =3D VDUSE_SUSPEND;
> > > +
> > > +       ret =3D vduse_dev_msg_sync(dev, &msg);
> > > +       if (ret =3D=3D 0) {
> > > +               scoped_guard(rwsem_write, &dev->rwsem)
> > > +                       dev->suspended =3D true;
> > > +
> > > +               cancel_work_sync(&dev->inject);
> > > +               for (u32 i =3D 0; i < dev->vq_num; i++)
> > > +                       cancel_work_sync(&dev->vqs[i]->inject);
> >
> > Should we cancel those before msy sync?
> >
>
> The only condition is that the driver must not see interrupts from the
> moment the ioctl returns.

I think you meant "vduse_vdpa_suspend returns" here.

>
> Also, disabling it before the msg returns would add complexity because
> it needs to be reenabled & call the driver if it falis. Or am I
> missing something it adds?

I think not but I have another question:

1) I don't see resume, any reason for that
2) assuming we need to support resume, do we need to record pending
interrupt otherwise we may lose interrupt after resuming

>
> TBH this is more of a hardening than something the VDUSE driver should
> do. We could even move to the vdpa core.
>
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  static void vduse_vdpa_free(struct vdpa_device *vdpa)
> > >  {
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > @@ -937,6 +966,41 @@ static const struct vdpa_config_ops vduse_vdpa_c=
onfig_ops =3D {
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > >
> > > +static const struct vdpa_config_ops vduse_vdpa_config_ops_with_suspe=
nd =3D {
> > > +       .set_vq_address         =3D vduse_vdpa_set_vq_address,
> > > +       .kick_vq                =3D vduse_vdpa_kick_vq,
> > > +       .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> > > +       .set_vq_num             =3D vduse_vdpa_set_vq_num,
> > > +       .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > > +       .get_vq_group           =3D vduse_get_vq_group,
> > > +       .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> > > +       .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> > > +       .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > > +       .get_vq_state           =3D vduse_vdpa_get_vq_state,
> > > +       .get_vq_align           =3D vduse_vdpa_get_vq_align,
> > > +       .get_device_features    =3D vduse_vdpa_get_device_features,
> > > +       .set_driver_features    =3D vduse_vdpa_set_driver_features,
> > > +       .get_driver_features    =3D vduse_vdpa_get_driver_features,
> > > +       .set_config_cb          =3D vduse_vdpa_set_config_cb,
> > > +       .get_vq_num_max         =3D vduse_vdpa_get_vq_num_max,
> > > +       .get_device_id          =3D vduse_vdpa_get_device_id,
> > > +       .get_vendor_id          =3D vduse_vdpa_get_vendor_id,
> > > +       .get_status             =3D vduse_vdpa_get_status,
> > > +       .set_status             =3D vduse_vdpa_set_status,
> > > +       .get_config_size        =3D vduse_vdpa_get_config_size,
> > > +       .get_config             =3D vduse_vdpa_get_config,
> > > +       .set_config             =3D vduse_vdpa_set_config,
> > > +       .get_generation         =3D vduse_vdpa_get_generation,
> > > +       .set_vq_affinity        =3D vduse_vdpa_set_vq_affinity,
> > > +       .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > +       .reset                  =3D vduse_vdpa_reset,
> > > +       .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > +       .get_vq_map             =3D vduse_get_vq_map,
> > > +       .suspend                =3D vduse_vdpa_suspend,
> >
> > We can have a
> >
> > if (suspend_is_supported)
> >         ...
> >
> > to avoid having a new set of config ops?
> >
>
> It complicates the code of vhost_vdpa in my opinion.
>
> Currently, it is:
> if (ops->suspend)

Okay, I see the problem which is:

static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
{
        struct vdpa_device *vdpa =3D v->vdpa;
        const struct vdpa_config_ops *ops =3D vdpa->config;

        return ops->suspend;
}

>
> And that would move to something like:
> if (ops->suspend) {
>   if (ops->suspend_is_supported && !ops->suspend_is_supported(dev)) {
>     return; // CANNOT SUSPEND
>   }
>
>   ops->suspend(dev)
> }
>
> Another option I considered is to follow mlx5's approach and have one
> set of ops per device. But I think duplicating the vdpa_ops in the
> data section is the cleanest approach. Let me know if you think we
> should go with suspend_is_supported callback instead.

I think there's no need then.

>
> > > +       .free                   =3D vduse_vdpa_free,
> > > +};
> > > +
> > >  static void vduse_dev_sync_single_for_device(union virtio_map token,
> > >                                              dma_addr_t dma_addr, siz=
e_t size,
> > >                                              enum dma_data_direction =
dir)
> > > @@ -1148,6 +1212,10 @@ static void vduse_dev_irq_inject(struct work_s=
truct *work)
> > >  {
> > >         struct vduse_dev *dev =3D container_of(work, struct vduse_dev=
, inject);
> > >
> > > +       guard(rwsem_read)(&dev->rwsem);
> > > +       if (dev->suspended)
> > > +               return;
> >
> > Device can still modify memory, so I wonder how much this can help.
> >
>
> Do you prefer me to remove this guard?

Nope, I misread the code, it should be fine.

Thanks

>
> > > +
> > >         spin_lock_bh(&dev->irq_lock);
> > >         if (dev->config_cb.callback)
> > >                 dev->config_cb.callback(dev->config_cb.private);
> > > @@ -1159,6 +1227,10 @@ static void vduse_vq_irq_inject(struct work_st=
ruct *work)
> > >         struct vduse_virtqueue *vq =3D container_of(work,
> > >                                         struct vduse_virtqueue, injec=
t);
> > >
> > > +       guard(rwsem_read)(&vq->dev->rwsem);
> > > +       if (vq->dev->suspended)
> > > +               return;
> > > +
> > >         spin_lock_bh(&vq->irq_lock);
> > >         if (vq->ready && vq->cb.callback)
> > >                 vq->cb.callback(vq->cb.private);
> > > @@ -1189,6 +1261,9 @@ static int vduse_dev_queue_irq_work(struct vdus=
e_dev *dev,
> > >         int ret =3D -EINVAL;
> > >
> > >         down_read(&dev->rwsem);
> > > +       if (dev->suspended)
> > > +               return ret;
> > > +
> > >         if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > >                 goto unlock;
> > >
> > > @@ -1839,6 +1914,7 @@ static int vduse_dev_init_vqs(struct vduse_dev =
*dev, u32 vq_align, u32 vq_num)
> > >                 }
> > >
> > >                 dev->vqs[i]->index =3D i;
> > > +               dev->vqs[i]->dev =3D dev;
> > >                 dev->vqs[i]->irq_effective_cpu =3D IRQ_UNBOUND;
> > >                 INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
> > >                 INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
> > > @@ -2311,12 +2387,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
> > >  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *na=
me)
> > >  {
> > >         struct vduse_vdpa *vdev;
> > > +       const struct vdpa_config_ops *ops;
> > >
> > >         if (dev->vdev)
> > >                 return -EEXIST;
> > >
> > > +       if (dev->vduse_features & BIT_U64(VDUSE_F_SUSPEND))
> > > +               ops =3D &vduse_vdpa_config_ops_with_suspend;
> > > +       else
> > > +               ops =3D &vduse_vdpa_config_ops;
> > > +
> > >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> > > -                                &vduse_vdpa_config_ops, &vduse_map_o=
ps,
> > > +                                ops, &vduse_map_ops,
> > >                                  dev->ngroups, dev->nas, name, true);
> > >         if (IS_ERR(vdev))
> > >                 return PTR_ERR(vdev);
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index d39734cef6d3..95b93bc6bac5 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -21,6 +21,9 @@
> > >  /* The VDUSE instance expects a request for vq ready */
> > >  #define VDUSE_F_QUEUE_READY    0
> > >
> > > +/* The VDUSE instance expects a request for suspend */
> > > +#define VDUSE_F_SUSPEND                1
> > > +
> > >  /*
> > >   * Get the version of VDUSE API that kernel supported (VDUSE_API_VER=
SION).
> > >   * This is used for future extension.
> > > @@ -338,6 +341,7 @@ enum vduse_req_type {
> > >         VDUSE_UPDATE_IOTLB,
> > >         VDUSE_SET_VQ_GROUP_ASID,
> > >         VDUSE_SET_VQ_READY,
> > > +       VDUSE_SUSPEND,
> > >  };
> > >
> > >  /**
> > > --
> > > 2.53.0
> > >
> >
> > Thanks
> >
>

