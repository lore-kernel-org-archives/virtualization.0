Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EE35950
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875803; cv=none; b=aZpWrCtkxPmsP4JElJ+zg/pttezK8eM49W2M/RzPPfaIyuqEKqhGaXUKa9Xriybs3gVwxrEHqBJmbcaBRaXRADxzAhjI5+MLIHop6nJkCqVtVFOjG58z4F867cVWx6xa9ZBOzeRUPinVBgQQT1H+x6xlHi/n+HuY+XIYCrr/FpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875803; c=relaxed/simple;
	bh=o6/fX1aCgHfN6QHPeBEThy7Iyc8B2MpwqcX0asOLmv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDYyeMKQhFXY1R8LcuUH4rpBXi2O0l2vS0Xi7VlUJHdkOWnRMhKWKCNAwLz+ZorZhwWWMLHroMIoBvWiuKpCT03pdv8CL9CaBtu+MKhxxaqiDS7soZOM5wN2VQFeunbX6A61iV1FkVwlVHhQ+kU6CdxJ6r3Mpks1yLA9QCzZUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSr1VkaA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSr1VkaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758875799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMU8paa2tckjJZknzdXGbYSTPT0vJHI/CuQYFznTw60=;
	b=VSr1VkaAfXfLY6Nx854aJ3PAs5nisjAGRINzwBV0Bx/9hZEZzlcEIk1dkOVtPITtpRfVj6
	OKGoUtXlKCFpU3EsgmAho6ItP3zMA4XNDxC0aU8J9rCCAojtuu9lfic5X7dgYc8dg+ojM1
	Cw5vEIYy9hYKrbxNlkhvzjtCu89MTMw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-rlM_EPEsPJmHXxAwCgg50g-1; Fri, 26 Sep 2025 04:36:38 -0400
X-MC-Unique: rlM_EPEsPJmHXxAwCgg50g-1
X-Mimecast-MFC-AGG-ID: rlM_EPEsPJmHXxAwCgg50g_1758875798
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so1265356a12.1
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 01:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875796; x=1759480596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMU8paa2tckjJZknzdXGbYSTPT0vJHI/CuQYFznTw60=;
        b=ptvRHozs/GRT5kOOKkdYew9V/D6uv8+h1yviuodKE4pDap1FsPFtwyIGyeTkt6G9ms
         XWQg6zp8z71lGMIH7qCIF/2Dc/HS7nv1EwruULXnvkV9d82f8UTVtCGbaohYXdGbgP1h
         ImvxnTkUEDkilt2OmUgEOpsQB4HxVTNhTvHx8Fc1Ay3RHz87SftrhJF6A710n4McPnYT
         l3tGTuTZq27tHnJqne9xyTXhC/nBg7PVVAD1O4buVTQu9W5/ThjBUnOq3UnHamPzTA8u
         RUn4ucSp7yjCOyG4NeALqpwrpQIJSU3MzHj+aMMfawUTNSImWRLPg4JWT+ceYAlwk2xJ
         pYfg==
X-Forwarded-Encrypted: i=1; AJvYcCUd9Lr5echx1E0UGYHQdex01oEwm1tGiy6RUqimvDbMRpo50gZywSAXyvT8IL2rP/97htdCVnHa94FbT2DeMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHSNDVuQV/oAiVW6ChuqWkfAADyLf6XH9uoqJkI8vrB6hIuLRR
	loFHb0ft4rnME8I7t+j/CHsP2HMR9gAqjn8LDfqAj1LU/9tjH0fb340wO55O5Sejdik3ihbvEWw
	HB5Hfb+HSIFdaBS/ZHPmkBAZEw2WIkchMtebpTHt+k/tGGK2BUGyCIVeLZUkFIWyM/V7INzGRGU
	zpBAq3ABKhQazGm9d3E/9XWN18ra9gm2Z35QCY+ZFn3W8=
X-Gm-Gg: ASbGncuQsA0iG+cYWKjCDdt2sXExakIibFccYRPpaNHXObeOmhCIw+mxqS2B6AvLl4Q
	z0KkfbVYyOF36eRWCSyAYCiB59GJqnMOnFK+LRiFagj6PI/XAAVBJpnJmdxqdV8TIEEBZ6+xo41
	nikLgFLUWpvub9hQWSzQ==
X-Received: by 2002:a17:90b:1808:b0:32d:4187:7bc8 with SMTP id 98e67ed59e1d1-3342a2b11acmr7450673a91.27.1758875796381;
        Fri, 26 Sep 2025 01:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR7cPo07zLl/VGVa/sojNT48BQez7xISfZI4qXx40XzdZ8VxZkM4ruqVaGl+BwbqySQPDWfi5qV1U2JhxeqIs=
X-Received: by 2002:a17:90b:1808:b0:32d:4187:7bc8 with SMTP id
 98e67ed59e1d1-3342a2b11acmr7450638a91.27.1758875795838; Fri, 26 Sep 2025
 01:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925091335.1964283-1-eperezma@redhat.com> <20250925091335.1964283-4-eperezma@redhat.com>
 <CACGkMEtXOOLuf01qx_MbptjvyZe0jLTgnPU5JDQ0SOUXx54KYg@mail.gmail.com> <CAJaqyWfx8L6rt+sEeVjdPQ3y0=c_8gSi5_d1TLUopq5PmqAY9w@mail.gmail.com>
In-Reply-To: <CAJaqyWfx8L6rt+sEeVjdPQ3y0=c_8gSi5_d1TLUopq5PmqAY9w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 16:36:22 +0800
X-Gm-Features: AS18NWBB0cT3CMjDFAovt2WMQf6OiyhjRNKPh_6phG3EDIY_ZJpLuW-fJOzsa0c
Message-ID: <CACGkMEvfc88V=dDt3D1nTnBUQLd0js3J-xdWBPT1OaPNy0oDSQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XEa5RosIBOkwk3ZeJT8ZAf5P8CnbN-xyuZUVu0Kr6T0_1758875798
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:16=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Sep 26, 2025 at 9:42=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Sep 25, 2025 at 5:14=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
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
> > > v4:
> > > * Revert the "invalid vq group" concept and assume 0 if not set (Jaso=
n).
> > > * Make config->ngroups =3D=3D 0 invalid (Jason).
> > >
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
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 46 ++++++++++++++++++++++++++--=
--
> > >  drivers/vhost/vdpa.c               | 11 +++++--
> > >  include/uapi/linux/vduse.h         | 12 ++++++--
> > >  3 files changed, 58 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 2b6a8958ffe0..3415217cb3a9 100644
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
> > > @@ -59,6 +60,7 @@ struct vduse_virtqueue {
> > >         struct vdpa_vq_state state;
> > >         bool ready;
> > >         bool kicked;
> > > +       u32 vq_group;
> > >         spinlock_t kick_lock;
> > >         spinlock_t irq_lock;
> > >         struct eventfd_ctx *kickfd;
> > > @@ -115,6 +117,7 @@ struct vduse_dev {
> > >         u8 status;
> > >         u32 vq_num;
> > >         u32 vq_align;
> > > +       u32 ngroups;
> > >         struct vduse_umem *umem;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > > @@ -456,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev=
)
> > >                 vq->driver_addr =3D 0;
> > >                 vq->device_addr =3D 0;
> > >                 vq->num =3D 0;
> > > +               vq->vq_group =3D 0;
> > >                 memset(&vq->state, 0, sizeof(vq->state));
> > >
> > >                 spin_lock(&vq->kick_lock);
> > > @@ -593,6 +597,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_d=
evice *vdpa, u16 idx,
> > >         return 0;
> > >  }
> > >
> > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > +               return 0;
> > > +
> > > +       return dev->vqs[idx]->vq_group;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -790,6 +804,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> > >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> > >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > > +       .get_vq_group           =3D vduse_get_vq_group,
> > >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> > >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> > >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > > @@ -1253,12 +1268,24 @@ static long vduse_dev_ioctl(struct file *file=
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
> >
> > This should be ">=3D".
> >
>
> Right, good catch!
>
> > > +                       if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > +                               break;
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
> > > @@ -1738,12 +1765,20 @@ static bool features_is_valid(struct vduse_de=
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
> > > +           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROU=
PS))
> > > +               return false;
> > > +
> > >         if (config->vq_align > PAGE_SIZE)
> > >                 return false;
> > >
> > > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_co=
nfig *config,
> > >         dev->device_features =3D config->features;
> > >         dev->device_id =3D config->device_id;
> > >         dev->vendor_id =3D config->vendor_id;
> > > +       dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups=
;
> > >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> > >         if (!dev->name)
> > >                 goto err_str;
> > > @@ -1937,7 +1973,7 @@ static long vduse_ioctl(struct file *file, unsi=
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
> > > @@ -2018,7 +2054,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev=
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
> >
> > I guess this won't work.
> >
>
> Right, and it has a lot of dead code from the s64 conversion. Fixing it.
>
> Should I send the whole series again or a patch on top?

I think a new version might be better.

Thanks

