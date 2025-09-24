Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D61DB95E
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676240; cv=none; b=YrxgKWo5zc02DieganohkPHtYtOXHsMnUz1nPXtoTNLw7coCH+ADeCdCqEUP9UN/GfSgRrohFfKEDXNA6fhctheGCFgWkVDXwzzqEdO0OIyonX/cieU80MJXlaSjthIyNeza8qp4x3cxMUXeRv0gHFzsTWBtl1vhIrZwp6N5uGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676240; c=relaxed/simple;
	bh=Hv80EmEtHL45wT/0yLj7i2DMP4+gdbEFWI/H3wjFAX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqyMwThibXElIDDpBYIna0f5cCKpGr8RFWWUfbPOCVUJ8WzDpBlaRoqnPy+b8/gDRAizF9zbvqGmdczDmVSdVTsHQHEbSqIKNL8BS2ji2Pr7+cBNHbX3D4Ss8jFL0jmIiPSA0gGp9sMw5ejUXKsgfWqa7mXeLEbkWGnmSmykQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlSbebys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlSbebys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758676237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6DqK3IvLE/66wRqA1Cb+jCFpmee4WVfBTdu5wyBgHY=;
	b=TlSbebys752oiBl1uyARJy25hbdycjgp8TVC6Rr17tCoydvhIIgwV8PEEU0T9FMwbT7k81
	zTq6VABk9EH+w218gg1knp+z//Rv3RMxp6szm/LOeVcDnJZ48q/vDYg0U5q9ilC7JZa9IB
	MdJKHaBm6BzisYWkxzOWXsRwyAO2/6M=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-cW2KAU3IPyaQ2OLo-xhNCg-1; Tue, 23 Sep 2025 21:10:35 -0400
X-MC-Unique: cW2KAU3IPyaQ2OLo-xhNCg-1
X-Mimecast-MFC-AGG-ID: cW2KAU3IPyaQ2OLo-xhNCg_1758676234
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b551ca103d8so3295530a12.1
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 18:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676234; x=1759281034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6DqK3IvLE/66wRqA1Cb+jCFpmee4WVfBTdu5wyBgHY=;
        b=az3z1IWmkB8f8LvzIYv9OWeWHKvA4wKsLqPc9Tzn0pTy6yFdN7dgkKObv2ajwOWfvj
         rNwaPF1hxNf0E8OrI1DevfKN5W9bO23s2M/byqNqNaoKYtmCuv1ZM5qKxho4oP+wUYOQ
         ZQTwJHaGQ5W4p0J0h7ZArlrqDm5x/xppa/fTe+ooiAL4cRmH4OQLd5qLmF9+BofSAVCh
         /HK/Uomkmow6rUp4nPmUyQm5PGl4i/RSIHWMta9cQSmz4/6mGB2w+iFlMfhEdRHZyUZp
         kSilKiJJ7hKqA02f9mw513nGak+/qT1zR/lho0PkyxMFYdaVfPXTlrkm1PLh3pzujZks
         mvsg==
X-Forwarded-Encrypted: i=1; AJvYcCXs+ItT4VqVhmLE/vTXGFoZkg7qvnwJFKy5LCW0aE8a/milz4W45R6xoDFFQw/Qnw3VvUS6aNqxgx36MYulRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmj9q85i6GmEzoDcX8ktAEg2RyXhTQtVAE8PTnxONwfg//x9dD
	C8HEg/36hzwg9zK/RKb/dUjzP+5CibHOjk4ol+u5BhJ2n9NkH7qCETu17mhjBdn8z8EqAdhZDp6
	WPOB3wf38ntGvW3H8dW2d+yK9j8HTqzQDXpg5RFYlSDm8HiVPwTOosUHivphCfLsfT/FBegwuYW
	RTQacXwfhkYHFrgyF4Sgu8wP57GXje4UT0WTIFRA6q8gQ=
X-Gm-Gg: ASbGnctMtq/+8hEKvMhV7QbFvP+viVCVmIWHYJwi8Y/dhxbhdruT3DIMe0z3ATAJc3Z
	9ANGODwtSEDJhj48NRIxqYmHc5D6xu3NbLqskSbOYVWW9djEJTX8Ovf3HV/yL+ojUrCKYt80HYp
	5yhqWrLUgrruL/0O1hIA==
X-Received: by 2002:a17:902:d2d2:b0:25b:f1f3:815f with SMTP id d9443c01a7336-27cca52116amr62795235ad.58.1758676233986;
        Tue, 23 Sep 2025 18:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQHTdiP5kiHpTymYH7RgHp+aaHepfHG+E+92UasaN6fEztK+gUpYU88eF9UWWSZkpwD2qM9KaR0WyKSmdStww=
X-Received: by 2002:a17:902:d2d2:b0:25b:f1f3:815f with SMTP id
 d9443c01a7336-27cca52116amr62794875ad.58.1758676233325; Tue, 23 Sep 2025
 18:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919093359.961296-1-eperezma@redhat.com> <20250919093359.961296-4-eperezma@redhat.com>
 <CACGkMEv2Bmq+KqPE2qKwub=SE64wphfK9Jbo46kRzBjuurbeZQ@mail.gmail.com> <CAJaqyWc9FCrL7zF_XQEB=g7Te69VTiWD0W4_3vos76dCUeFTMw@mail.gmail.com>
In-Reply-To: <CAJaqyWc9FCrL7zF_XQEB=g7Te69VTiWD0W4_3vos76dCUeFTMw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 09:10:21 +0800
X-Gm-Features: AS18NWBNmu8ZXdSTowBEzZ4lTE89gu10Mf9AH8HMhHY3aJLwJo_yu5_CKFw9SXQ
Message-ID: <CACGkMEuHJUh+TuDyEPpFgOimV7VpwiAC+FTJBc3JHB5c8_QtJg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ggn8QL94JTW8wRSbgA_juiGw9-R7eTmdtDFrOIoIBao_1758676234
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:51=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Sep 22, 2025 at 3:16=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Sep 19, 2025 at 5:34=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
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
> > > v3:
> > > * Make the default group an invalid group as long as VDUSE device doe=
s
> > >   not set it to some valid u32 value.  Modify the vdpa core to take t=
hat
> > >   into account (Jason).
> > > * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
> > >
> > > v2:
> > > * Now the vq group is in vduse_vq_config struct instead of issuing on=
e
> > >   VDUSE message per vq.
> > >
> > > v1:
> > > * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> > >
> > > RFC v3:
> > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lo=
wer
> > >   value to reduce memory consumption, but vqs are already limited to
> > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > * Remove the descs vq group capability as it will not be used and we =
can
> > >   add it on top.
> > > * Do not ask for vq groups in number of vq groups < 2.
> > > * Move the valid vq groups range check to vduse_validate_config.
> > >
> > > RFC v2:
> > > * Cache group information in kernel, as we need to provide the vq map
> > >   tokens properly.
> > > * Add descs vq group to optimize SVQ forwarding and support indirect
> > >   descriptors out of the box.
> > > ---
> > >  drivers/vdpa/ifcvf/ifcvf_main.c    |  2 +-
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  2 +-
> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c   |  2 +-
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 +++++++++++++++++++++++++++-=
--
> > >  drivers/vhost/vdpa.c               | 11 +++++--
> > >  include/linux/vdpa.h               |  5 +--
> > >  include/uapi/linux/vduse.h         | 12 +++++--
> > >  7 files changed, 69 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifc=
vf_main.c
> > > index 6658dc74d915..ea6643760fb7 100644
> > > --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > > +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > @@ -559,7 +559,7 @@ static size_t ifcvf_vdpa_get_config_size(struct v=
dpa_device *vdpa_dev)
> > >         return  vf->config_size;
> > >  }
> > >
> > > -static u32 ifcvf_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx=
)
> > > +static s64 ifcvf_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx=
)
> > >  {
> > >         return 0;
> > >  }
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index 82034efb74fc..daab0ccb78b2 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -2640,7 +2640,7 @@ static u32 mlx5_vdpa_get_vq_align(struct vdpa_d=
evice *vdev)
> > >         return PAGE_SIZE;
> > >  }
> > >
> > > -static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
> > > +static s64 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
> > >  {
> > >         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > >
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim.c
> > > index c1c6431950e1..fe4d65aaf6aa 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > @@ -412,7 +412,7 @@ static u32 vdpasim_get_vq_align(struct vdpa_devic=
e *vdpa)
> > >         return VDPASIM_QUEUE_ALIGN;
> > >  }
> > >
> > > -static u32 vdpasim_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > +static s64 vdpasim_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > >  {
> > >         /* RX and TX belongs to group 0, CVQ belongs to group 1 */
> > >         if (idx =3D=3D 2)
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 2b6a8958ffe0..7ddd81456f7b 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -40,6 +40,7 @@
> > >  #define DRV_LICENSE  "GPL v2"
> > >
> > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > +#define VDUSE_DEV_MAX_GROUPS 0xffff
> > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > @@ -49,6 +50,8 @@
> > >
> > >  #define IRQ_UNBOUND -1
> > >
> > > +#define VQ_GROUP_INVALID -1
> > > +
> > >  struct vduse_virtqueue {
> > >         u16 index;
> > >         u16 num_max;
> > > @@ -59,6 +62,7 @@ struct vduse_virtqueue {
> > >         struct vdpa_vq_state state;
> > >         bool ready;
> > >         bool kicked;
> > > +       u32 vq_group;
> > >         spinlock_t kick_lock;
> > >         spinlock_t irq_lock;
> > >         struct eventfd_ctx *kickfd;
> > > @@ -115,6 +119,7 @@ struct vduse_dev {
> > >         u8 status;
> > >         u32 vq_num;
> > >         u32 vq_align;
> > > +       u32 ngroups;
> > >         struct vduse_umem *umem;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > > @@ -456,6 +461,7 @@ static void vduse_dev_reset(struct vduse_dev *dev=
)
> > >                 vq->driver_addr =3D 0;
> > >                 vq->device_addr =3D 0;
> > >                 vq->num =3D 0;
> > > +               vq->vq_group =3D VQ_GROUP_INVALID;
> > >                 memset(&vq->state, 0, sizeof(vq->state));
> > >
> > >                 spin_lock(&vq->kick_lock);
> > > @@ -593,6 +599,19 @@ static int vduse_vdpa_set_vq_state(struct vdpa_d=
evice *vdpa, u16 idx,
> > >         return 0;
> > >  }
> > >
> > > +static s64 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > +               return 0;
> > > +
> > > +       if (dev->vqs[idx]->vq_group =3D=3D VQ_GROUP_INVALID)
> > > +               return -EINVAL;
> > > +
> > > +       return dev->vqs[idx]->vq_group;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -790,6 +809,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> > >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> > >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > > +       .get_vq_group           =3D vduse_get_vq_group,
> > >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> > >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> > >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > > @@ -1253,12 +1273,24 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                 if (config.index >=3D dev->vq_num)
> > >                         break;
> > >
> > > -               if (!is_mem_zero((const char *)config.reserved,
> > > -                                sizeof(config.reserved)))
> > > +               if (dev->api_version < VDUSE_API_VERSION_1 && config.=
group)
> > > +                       break;
> > > +
> > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > > +                       if (config.group > dev->ngroups)
> > > +                               break;
> > > +                       if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > +                               break;
> >
> > This seems to be a new requirement for V1. Please explain why.
> >
>
> Would a code comment like "The device is not allowed to change the VQ
> group after the driver sets DRIVER_OK" work? I'm tempted to add "VQ
> group or size", but it was not an error previously so I'm ok with
> leaving it only for vq groups.

That's fine but I wonder why we check DRIVER_OK instead of FEATURES_OK.

>
> > > +               }
> > > +
> > > +               if (config.reserved1 ||
> > > +                   !is_mem_zero((const char *)config.reserved2,
> > > +                                sizeof(config.reserved2)))
> > >                         break;
> > >
> > >                 index =3D array_index_nospec(config.index, dev->vq_nu=
m);
> > >                 dev->vqs[index]->num_max =3D config.max_size;
> > > +               dev->vqs[index]->vq_group =3D config.group;
> > >                 ret =3D 0;
> > >                 break;
> > >         }
> > > @@ -1738,12 +1770,20 @@ static bool features_is_valid(struct vduse_de=
v_config *config)
> > >         return true;
> > >  }
> > >
> > > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > > +                                 u64 api_version)
> > >  {
> > >         if (!is_mem_zero((const char *)config->reserved,
> > >                          sizeof(config->reserved)))
> > >                 return false;
> > >
> > > +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > > +               return false;
> > > +
> > > +       if (api_version >=3D VDUSE_API_VERSION_1 &&
> > > +           config->ngroups > VDUSE_DEV_MAX_GROUPS)
> > > +               return false;
> > > +
> > >         if (config->vq_align > PAGE_SIZE)
> > >                 return false;
> > >
> > > @@ -1859,6 +1899,7 @@ static int vduse_create_dev(struct vduse_dev_co=
nfig *config,
> > >         dev->device_features =3D config->features;
> > >         dev->device_id =3D config->device_id;
> > >         dev->vendor_id =3D config->vendor_id;
> > > +       dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroup=
s ?: 1);
> >
> > Should we fail if config->ngroups is zero when version is 1?
> >
>
> The devices that don't need to mess with vq groups are better with not
> needing to know anything about it in their codebases, in my opinion.
> Having to learn about what is a vq group for a newcomer to vDPA/VDUSE
> is setting the barrier higher for little benefit.
>
> We can obtain the same advantage of reserving the value 0 with a new
> API version or VDUSE feature flags.
>
> Having said that, I'm ok if you prefer this device creation to fail in
> that case.

I prefer to fail in this case.

>
> > >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> > >         if (!dev->name)
> > >                 goto err_str;
> > > @@ -1937,7 +1978,7 @@ static long vduse_ioctl(struct file *file, unsi=
gned int cmd,
> > >                         break;
> > >
> > >                 ret =3D -EINVAL;
> > > -               if (vduse_validate_config(&config) =3D=3D false)
> > > +               if (!vduse_validate_config(&config, control->api_vers=
ion))
> > >                         break;
> > >
> > >                 buf =3D vmemdup_user(argp + size, config.config_size)=
;
> > > @@ -2018,7 +2059,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev=
 *dev, const char *name)
> > >
> > >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> > >                                  &vduse_vdpa_config_ops, &vduse_map_o=
ps,
> > > -                                1, 1, name, true);
> > > +                                dev->ngroups, 1, name, true);
> > >         if (IS_ERR(vdev))
> > >                 return PTR_ERR(vdev);
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 05a481e4c385..6305382eacbb 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/vdpa.h>
> > >  #include <linux/nospec.h>
> > >  #include <linux/vhost.h>
> > > +#include <linux/types.h>
> > >
> > >  #include "vhost.h"
> > >
> > > @@ -657,16 +658,20 @@ static long vhost_vdpa_vring_ioctl(struct vhost=
_vdpa *v, unsigned int cmd,
> > >                         return -EFAULT;
> > >                 ops->set_vq_ready(vdpa, idx, s.num);
> > >                 return 0;
> > > -       case VHOST_VDPA_GET_VRING_GROUP:
> > > +       case VHOST_VDPA_GET_VRING_GROUP: {
> > > +               u64 group;
> > > +
> > >                 if (!ops->get_vq_group)
> > >                         return -EOPNOTSUPP;
> > >                 s.index =3D idx;
> > > -               s.num =3D ops->get_vq_group(vdpa, idx);
> > > -               if (s.num >=3D vdpa->ngroups)
> > > +               group =3D ops->get_vq_group(vdpa, idx);
> > > +               if (group >=3D vdpa->ngroups || group > U32_MAX || gr=
oup < 0)
> > >                         return -EIO;
> > >                 else if (copy_to_user(argp, &s, sizeof(s)))
> > >                         return -EFAULT;
> > > +               s.num =3D group;
> > >                 return 0;
> > > +       }
> > >         case VHOST_VDPA_GET_VRING_DESC_GROUP:
> > >                 if (!vhost_vdpa_has_desc_group(v))
> > >                         return -EOPNOTSUPP;
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index 4cf21d6e9cfd..76a673ef7deb 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -211,7 +211,8 @@ struct vdpa_map_file {
> > >   *                             virtqueue (optional)
> > >   *                             @vdev: vdpa device
> > >   *                             @idx: virtqueue index
> > > - *                             Returns u32: group id for this virtqu=
eue
> > > + *                             Returns i64: (32 bits wide) group id =
for this
> >
> > Let's separate the u32->s64 changes. And maybe it's fine to say
> > returns s64 and explain U32_MAX is the maximum value allowed.
> >
>
> Sure, sending a new version with that.
>
> > > + *                             virtqueue if >0. If <0, errno.
> > >   * @get_vq_desc_group:         Get the group id for the descriptor t=
able of
> > >   *                             a specific virtqueue (optional)
> > >   *                             @vdev: vdpa device
> > > @@ -398,7 +399,7 @@ struct vdpa_config_ops {
> > >
> > >         /* Device ops */
> > >         u32 (*get_vq_align)(struct vdpa_device *vdev);
> > > -       u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
> > > +       s64 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
> > >         u32 (*get_vq_desc_group)(struct vdpa_device *vdev, u16 idx);
> > >         u64 (*get_device_features)(struct vdpa_device *vdev);
> > >         u64 (*get_backend_features)(const struct vdpa_device *vdev);
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index ccb92a1efce0..a3d51cf6df3a 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -31,6 +31,7 @@
> > >   * @features: virtio features
> > >   * @vq_num: the number of virtqueues
> > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > > + * @ngroups: number of vq groups that VDUSE device declares
> > >   * @reserved: for future use, needs to be initialized to zero
> > >   * @config_size: the size of the configuration space
> > >   * @config: the buffer of the configuration space
> > > @@ -45,7 +46,8 @@ struct vduse_dev_config {
> > >         __u64 features;
> > >         __u32 vq_num;
> > >         __u32 vq_align;
> > > -       __u32 reserved[13];
> > > +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > +       __u32 reserved[12];
> > >         __u32 config_size;
> > >         __u8 config[];
> > >  };
> > > @@ -122,14 +124,18 @@ struct vduse_config_data {
> > >   * struct vduse_vq_config - basic configuration of a virtqueue
> > >   * @index: virtqueue index
> > >   * @max_size: the max size of virtqueue
> > > - * @reserved: for future use, needs to be initialized to zero
> > > + * @reserved1: for future use, needs to be initialized to zero
> > > + * @group: virtqueue group
> > > + * @reserved2: for future use, needs to be initialized to zero
> > >   *
> > >   * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
> > >   */
> > >  struct vduse_vq_config {
> > >         __u32 index;
> > >         __u16 max_size;
> > > -       __u16 reserved[13];
> > > +       __u16 reserved1;
> > > +       __u32 group;
> > > +       __u16 reserved2[10];
> > >  };
> > >
> > >  /*
> > > --
> > > 2.51.0
> > >
> >
> > Thanks
> >
>

Thanks

