Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB842D3EC3
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967948; cv=none; b=GBU1mzlQwZdGKrRcksUYfKPU7ABnMCkiG+dhrEPxso6a8fpmdvmu622A4TAyUjobvYspGv8E0TOaENFAD32ZNJj1VlypUxYpkFswLLR71YNLKx9Ry6d1+R3hiwrVO+zhkEmUwVG2xlcUsoA/NaIb/Odi0rsEm0dNDqulJ2pPxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967948; c=relaxed/simple;
	bh=BN3GaAJUYBQSzkDepfI1FFipXx/MYnKnF14RK67cEjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwMbX6S9G3qXmzqzEM/CEvmcssJG8HzyY+Vc9sjFSBwi5sgRQzkyp035o2s5wPpf305SgOfMMJVEhRoUH4H7VDsCw0+aPB8IupGXC4iG1mMzf6J3v2NfL3SsRChtqn5oDWv1aZRZbd0wS7YVUWWHGw6hEBxObYDfJR1Bnk5A3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZsT+R+83; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsT+R+83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754967944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAimd0bpGhCQyEwBX23lD7NFyUeSmJWBUxda3kyN+mU=;
	b=ZsT+R+832Y1ULcu+uBwk+Pnc8OYzdH2+8yx0wXdbWM76cS+ypzwP5RN/of7nEX1pXEd7rO
	BxVvnRXy/IRgNb5X4RkOCXDeE6qborOGtExxWFAKMWXchb5lcsSGwLWtsXFdXC1jtvnkAC
	1Q2bdQUH06DL5TCppSAi327APsCE+ds=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-SMHwX78RPpqxBAUzTDm0qQ-1; Mon, 11 Aug 2025 23:05:40 -0400
X-MC-Unique: SMHwX78RPpqxBAUzTDm0qQ-1
X-Mimecast-MFC-AGG-ID: SMHwX78RPpqxBAUzTDm0qQ_1754967939
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23ff6e5c131so40503895ad.2
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 20:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754967939; x=1755572739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAimd0bpGhCQyEwBX23lD7NFyUeSmJWBUxda3kyN+mU=;
        b=ttOeOvbckwN4EHSOrdG16P0C9kvLSqfpOeUv2399NmGnriKMKJ24i9kxG0n9axZ4O2
         nCwRS960pAWIAuJyVJv3U/KK//zX7AweYKzbMn3pAvSEALGqlI69XFEvrf8zj1rczYfX
         Z5lJAJL7rfzGiZ5qv/FZOHufj1oT3/jMWOy8YcxU9B7NxEcfEkayK1090Q2MjRqsdhu5
         VqFWZxnqg25GDDcyFYXQ08a6/TsB/uTVa1C6xJZqtrGYSweh3EtU/r5hoN/0vPoZxwh8
         gW9aCKiJFtdNktVTc4FN/6Il5FxtsdTOrLPsw8jyk/088RN++w+EDGXbXzB9RlxPVMG9
         HzGw==
X-Forwarded-Encrypted: i=1; AJvYcCX39Bucd3JqubI3wfJO3KccziS85NHaivu8eoRp1xt08aBc5+++TPv0H/++10FYOfzma1EdzwZ8pVOJY82Y2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBRaacNd4pl857llFmOJjohA+RcodDC7wwwv/oH8aJrYcU2QPR
	MqMsTATM7gAoOpkYmfSpMf72C4fJzWX248e8BmlsZFXghTvZ+zHaHysryB7jHOJm1xSJx/zVzjJ
	4XHlmgzHKMBJwZvHT/+WtIpp2/u6U6cbKQnizaoVQWWt3DqHiDwa6zH0TMFC18kSRWWvSpoIrZA
	wLZ/zv0O6cvcd06N/v0sZpkO+kUXTb2x2C+kv+CROt13o=
X-Gm-Gg: ASbGncuvYJ+WwvPifFyJIWFTrvnkspNiez9rq0A53g5uy8LfoKIS36WyUZN1fzRaYAL
	9QoGPuiJVAlgzAPF9PSWVj6W6wccHjgzLe9NIitDxr2WrZlkmkhcGsYuRfQ6exvsbIt0nvNGXIt
	gD3kBiqrid2cSyKsspj76XNc0=
X-Received: by 2002:a17:903:3d0e:b0:240:3915:99d8 with SMTP id d9443c01a7336-242fc35c5fbmr27407255ad.47.1754967938708;
        Mon, 11 Aug 2025 20:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIOUOkrtuQLQcbDGWbCgK0qbT8h1bsMYYS76oN51B6WTePT8WnvJEdm2qcMdaoDP3l6ZpRNzney3qT7m5P5B0=
X-Received: by 2002:a17:903:3d0e:b0:240:3915:99d8 with SMTP id
 d9443c01a7336-242fc35c5fbmr27406465ad.47.1754967937936; Mon, 11 Aug 2025
 20:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-6-eperezma@redhat.com>
 <CACGkMEu0vaWaMO7Mm0CC5R1KgNw9Y6jr156PwBD=e6-tGEUT3Q@mail.gmail.com> <CAJaqyWcLytoVCaS+HFVxDw2NRErfHz_nkviG-i+f=pJQST05jQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcLytoVCaS+HFVxDw2NRErfHz_nkviG-i+f=pJQST05jQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Aug 2025 11:05:26 +0800
X-Gm-Features: Ac12FXxp7iWpyTGAcHX6Emq82LnXUs_T92BbH8Q8gUakjMkhWh3HJkJ_QfF9I4g
Message-ID: <CACGkMEu2mh7oSVYJnD5R4EYXxtU0_rvXh08xSmGVRgTb7uKLAQ@mail.gmail.com>
Subject: Re: [RFC v2 5/7] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lH_WSj8Y9GgJ6fldDlWbP5KozUHa3vZ3IimPV3UYuHY_1754967939
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 7:20=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Aug 11, 2025 at 5:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v2: Make iotlb entry the last one of vduse_iotlb_entry_v2 so the firs=
t
> > > part of the struct is the same.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 259 ++++++++++++++++++++++-----=
--
> > >  include/uapi/linux/vduse.h         |  36 +++-
> > >  2 files changed, 230 insertions(+), 65 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index a7a2749f5818..145147c49930 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -51,6 +51,12 @@
> > >   */
> > >  #define VDUSE_MAX_VQ_GROUPS 3
> > >
> > > +/*
> > > + * We can do ASID thanks to (ab)using the vduse device and the vdpa =
one. So no
> > > + * more than 2.
> > > + */
> > > +#define VDUSE_MAX_ASID 2
> >
> > Similar to group limitation, I'd like to either make it larger to 64
> > or make it changable via sysfs.

We can start from something that is simple (64).

> >
> > > +
> > >  #define IRQ_UNBOUND -1
> > >
> > >  struct vduse_virtqueue {
> > > @@ -91,6 +97,7 @@ struct vduse_umem {
> > >  };
> > >
> > >  struct vduse_vq_group_int {
> > > +       struct vduse_iova_domain *domain;
> > >         struct vduse_dev *dev;
> > >  };
> > >
> > > @@ -98,7 +105,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_iova_domain *domain[VDUSE_MAX_ASID];
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -126,7 +133,8 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > -       struct vduse_umem *umem;
> > > +       u32 nas;
> > > +       struct vduse_umem *umem[VDUSE_MAX_ASID];
> > >         struct vduse_vq_group_int groups[VDUSE_MAX_VQ_GROUPS];
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > > @@ -440,14 +448,28 @@ static __poll_t vduse_dev_poll(struct file *fil=
e, poll_table *wait)
> > >         return mask;
> > >  }
> > >
> > > +/* Force set the asid to a vq group without a message to the VDUSE d=
evice */
> > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > +                                      unsigned int group, unsigned i=
nt asid)
> > > +{
> > > +       guard(mutex)(&dev->domain_lock);
> > > +       dev->groups[group].domain =3D dev->domain[asid];
> > > +}
> > > +
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > >
> > >         /* The coherent mappings are handled in vduse_dev_free_cohere=
nt() */
> > > -       if (domain && domain->bounce_map)
> > > -               vduse_domain_reset_bounce_map(domain);
> > > +       for (i =3D 0; i < dev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D dev->domain[i];
> > > +
> > > +               if (domain && domain->bounce_map)
> > > +                       vduse_domain_reset_bounce_map(domain);
> > > +       }
> > > +
> > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> >
> > I vaguely remember Siwei has invented a feature that forbids the reset
> > of the mapping during virtio reset. If it's true, let's check that
> > feature flag.
> >
>
> Ouch, very good catch!
>
> > Btw even if we device to reset the mapping, should it be implied via
> > reset message itself instead of having more operations here?
> >
>
> This was resetting all to valid values by the start of the device
> operation, so no need for a new message at least for now.
>
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > @@ -619,6 +641,29 @@ static u32 vduse_get_vq_desc_group(struct vdpa_d=
evice *vdpa, u16 idx)
> > >         return dev->vqs[idx]->vq_desc_group;
> > >  }
> > >
> > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned i=
nt group,
> > > +                               unsigned int asid)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int r;
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > +           group > dev->ngroups || asid > dev->nas)
> > > +               return -EINVAL;
> > > +
> > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > +       msg.req.vq_group_asid.group =3D group;
> > > +       msg.req.vq_group_asid.asid =3D asid;
> >
> > I wonder if this could be part of the shared memory?
> >
>
> I think it complicates the solution a lot, isn't it? How to notify the
> VDUSE device that these properties have changed, what vq group
> changed, etc? What do we want to achieve with the shm solution?

Rethink about this, I think you're right. But the point is to avoid
userspace transaction as much as possible.

>
> > > +
> > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > +       if (r < 0)
> > > +               return r;
> > > +
> > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > +       return 0;
> > > +}
> > > +
> > >  static void *vduse_get_vq_map_token(struct vdpa_device *vdpa, u16 id=
x)
> > >  {
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > @@ -833,13 +878,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
e *vdpa,
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         int ret;
> > >
> > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > +       ret =3D vduse_domain_set_map(dev->domain[asid], iotlb);
> > >         if (ret)
> > >                 return ret;
> > >
> > >         ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > >         if (ret) {
> > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > +               vduse_domain_clear_map(dev->domain[asid], iotlb);
> > >                 return ret;
> > >         }
> > >
> > > @@ -883,6 +928,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .get_vq_map_token       =3D vduse_get_vq_map_token,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > > @@ -893,8 +939,10 @@ static void vduse_dev_sync_single_for_device(voi=
d *token,
> > >  {
> > >         struct vduse_vq_group_int *group =3D token;
> > >         struct vduse_dev *vdev =3D group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D group->domain;
> > >         vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> > >  }
> > >
> > > @@ -904,8 +952,10 @@ static void vduse_dev_sync_single_for_cpu(void *=
token,
> > >  {
> > >         struct vduse_vq_group_int *group =3D token;
> > >         struct vduse_dev *vdev =3D group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D group->domain;
> > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > >  }
> > >
> > > @@ -916,8 +966,10 @@ static dma_addr_t vduse_dev_map_page(void *token=
, struct page *page,
> > >  {
> > >         struct vduse_vq_group_int *group =3D token;
> > >         struct vduse_dev *vdev =3D group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D group->domain;
> > >         return vduse_domain_map_page(domain, page, offset, size, dir,=
 attrs);
> > >  }
> > >
> > > @@ -927,8 +979,10 @@ static void vduse_dev_unmap_page(void *token, dm=
a_addr_t dma_addr,
> > >  {
> > >         struct vduse_vq_group_int *group =3D token;
> > >         struct vduse_dev *vdev =3D group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D group->domain;
> > >         return vduse_domain_unmap_page(domain, dma_addr, size, dir, a=
ttrs);
> > >  }
> > >
> > > @@ -937,11 +991,13 @@ static void *vduse_dev_alloc_coherent(void *tok=
en, size_t size,
> > >  {
> > >         struct vduse_vq_group_int *group =3D token;
> > >         struct vduse_dev *vdev =3D group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain;
> > >         unsigned long iova;
> > >         void *addr;
> > >
> > >         *dma_addr =3D DMA_MAPPING_ERROR;
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D group->domain;
> > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > >                                            (dma_addr_t *)&iova, flag)=
;
> > >         if (!addr)
> > > @@ -958,8 +1014,10 @@ static void vduse_dev_free_coherent(void *token=
, size_t size,
> > >  {
> > >         struct vduse_vq_group_int *group =3D token;
> > >         struct vduse_dev *vdev =3D group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D group->domain;
> > >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, att=
rs);
> > >  }
> > >
> > > @@ -967,8 +1025,10 @@ static size_t vduse_dev_max_mapping_size(void *=
token)
> > >  {
> > >         struct vduse_vq_group_int *group =3D token;
> > >         struct vduse_dev *vdev =3D group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D group->domain;
> > >         return domain->bounce_size;
> > >  }
> > >
> > > @@ -1107,31 +1167,32 @@ static int vduse_dev_queue_irq_work(struct vd=
use_dev *dev,
> > >         return ret;
> > >  }
> > >
> > > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> > >                                 u64 iova, u64 size)
> > >  {
> > >         int ret;
> > >
> > >         mutex_lock(&dev->mem_lock);
> > >         ret =3D -ENOENT;
> > > -       if (!dev->umem)
> > > +       if (!dev->umem[asid])
> > >                 goto unlock;
> > >
> > >         ret =3D -EINVAL;
> > > -       if (!dev->domain)
> > > +       if (!dev->domain[asid])
> > >                 goto unlock;
> > >
> > > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounc=
e_size)
> > > +       if (dev->umem[asid]->iova !=3D iova ||
> > > +           size !=3D dev->domain[asid]->bounce_size)
> > >                 goto unlock;
> > >
> > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > -       unpin_user_pages_dirty_lock(dev->umem->pages,
> > > -                                   dev->umem->npages, true);
> > > -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > > -       mmdrop(dev->umem->mm);
> > > -       vfree(dev->umem->pages);
> > > -       kfree(dev->umem);
> > > -       dev->umem =3D NULL;
> > > +       vduse_domain_remove_user_bounce_pages(dev->domain[asid]);
> > > +       unpin_user_pages_dirty_lock(dev->umem[asid]->pages,
> > > +                                   dev->umem[asid]->npages, true);
> > > +       atomic64_sub(dev->umem[asid]->npages, &dev->umem[asid]->mm->p=
inned_vm);
> > > +       mmdrop(dev->umem[asid]->mm);
> > > +       vfree(dev->umem[asid]->pages);
> > > +       kfree(dev->umem[asid]);
> > > +       dev->umem[asid] =3D NULL;
> > >         ret =3D 0;
> > >  unlock:
> > >         mutex_unlock(&dev->mem_lock);
> > > @@ -1139,7 +1200,7 @@ static int vduse_dev_dereg_umem(struct vduse_de=
v *dev,
> > >  }
> > >
> > >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > > -                             u64 iova, u64 uaddr, u64 size)
> > > +                             u32 asid, u64 iova, u64 uaddr, u64 size=
)
> > >  {
> > >         struct page **page_list =3D NULL;
> > >         struct vduse_umem *umem =3D NULL;
> > > @@ -1147,14 +1208,14 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > >         unsigned long npages, lock_limit;
> > >         int ret;
> > >
> > > -       if (!dev->domain || !dev->domain->bounce_map ||
> > > -           size !=3D dev->domain->bounce_size ||
> > > +       if (!dev->domain[asid] || !dev->domain[asid]->bounce_map ||
> > > +           size !=3D dev->domain[asid]->bounce_size ||
> > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > >                 return -EINVAL;
> > >
> > >         mutex_lock(&dev->mem_lock);
> > >         ret =3D -EEXIST;
> > > -       if (dev->umem)
> > > +       if (dev->umem[asid])
> > >                 goto unlock;
> > >
> > >         ret =3D -ENOMEM;
> > > @@ -1178,7 +1239,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >                 goto out;
> > >         }
> > >
> > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->domain[asid],
> > >                                                  page_list, pinned);
> > >         if (ret)
> > >                 goto out;
> > > @@ -1191,7 +1252,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >         umem->mm =3D current->mm;
> > >         mmgrab(current->mm);
> > >
> > > -       dev->umem =3D umem;
> > > +       dev->umem[asid] =3D umem;
> > >  out:
> > >         if (ret && pinned > 0)
> > >                 unpin_user_pages(page_list, pinned);
> > > @@ -1234,26 +1295,43 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >
> > >         switch (cmd) {
> > >         case VDUSE_IOTLB_GET_FD: {
> > > -               struct vduse_iotlb_entry entry;
> > > +               struct vduse_iotlb_entry_v2 entry;
> > > +               struct vduse_iotlb_entry entry_old;
> > >                 struct vhost_iotlb_map *map;
> > >                 struct vdpa_map_file *map_file;
> > >                 struct file *f =3D NULL;
> > >
> > >                 ret =3D -EFAULT;
> > > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > > -                       break;
> > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > > +                       if (copy_from_user(&entry, argp, sizeof(entry=
)))
> > > +                               break;
> > > +               } else {
> > > +                       if (copy_from_user(&entry_old, argp,
> > > +                                          sizeof(entry_old)))
> > > +                               break;
> > > +
> > > +                       entry.offset =3D entry_old.offset;
> > > +                       entry.start =3D entry_old.start;
> > > +                       entry.last =3D entry_old.last;
> > > +                       entry.asid =3D 0;
> > > +                       entry.perm =3D entry_old.perm;
> > > +               }
> > >
> > >                 ret =3D -EINVAL;
> > >                 if (entry.start > entry.last)
> > >                         break;
> > >
> > > +               if (entry.asid > dev->nas)
> > > +                       break;
> > > +
> > >                 mutex_lock(&dev->domain_lock);
> > > -               if (!dev->domain) {
> > > +               /* TODO accessing an array with idx from userspace, m=
itigations? */
> > > +               if (!dev->domain[entry.asid]) {
> > >                         mutex_unlock(&dev->domain_lock);
> > >                         break;
> > >                 }
> > > -               spin_lock(&dev->domain->iotlb_lock);
> > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > > +               spin_lock(&dev->domain[entry.asid]->iotlb_lock);
> > > +               map =3D vhost_iotlb_itree_first(dev->domain[entry.asi=
d]->iotlb,
> > >                                               entry.start, entry.last=
);
> > >                 if (map) {
> > >                         map_file =3D (struct vdpa_map_file *)map->opa=
que;
> > > @@ -1263,7 +1341,7 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> > >                         entry.last =3D map->last;
> > >                         entry.perm =3D map->perm;
> > >                 }
> > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > +               spin_unlock(&dev->domain[entry.asid]->iotlb_lock);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 ret =3D -EINVAL;
> > >                 if (!f)
> > > @@ -1413,12 +1491,16 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                         break;
> > >
> > >                 ret =3D -EINVAL;
> > > +               /* TODO: Using asid from userspace, need to mitigate?=
 */
> > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > -                                sizeof(umem.reserved)))
> > > +                                sizeof(umem.reserved)) ||
> > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > +                    umem.asid !=3D 0) ||
> > > +                    umem.asid > dev->nas)
> > >                         break;
> > >
> > >                 mutex_lock(&dev->domain_lock);
> > > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > > +               ret =3D vduse_dev_reg_umem(dev, umem.asid, umem.iova,
> > >                                          umem.uaddr, umem.size);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 break;
> > > @@ -1431,15 +1513,24 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                         break;
> > >
> > >                 ret =3D -EINVAL;
> > > +               /* TODO: Using asid from userspace, need to mitigate?=
 */
> > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > -                                sizeof(umem.reserved)))
> > > +                                sizeof(umem.reserved)) ||
> > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > +                    umem.asid !=3D 0) ||
> > > +                    umem.asid > dev->nas)
> > > +                       break;
> > > +
> > > +
> > > +               if (umem.asid > dev->nas)
> > >                         break;
> > >                 mutex_lock(&dev->domain_lock);
> > > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > > +               ret =3D vduse_dev_dereg_umem(dev, umem.asid, umem.iov=
a,
> > >                                            umem.size);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 break;
> > >         }
> > > +       /* TODO can we merge this with GET_FD? */
> >
> > Probably but might be too late.
> >
>
> Yep I should just remove this TODO actually.
>
> > >         case VDUSE_IOTLB_GET_INFO: {
> > >                 struct vduse_iova_info info;
> > >                 struct vhost_iotlb_map *map;
> > > @@ -1452,27 +1543,32 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                 if (info.start > info.last)
> > >                         break;
> > >
> > > +               if (info.asid > dev->nas)
> > > +                       break;
> > > +
> > >                 if (!is_mem_zero((const char *)info.reserved,
> > >                                  sizeof(info.reserved)))
> > >                         break;
> > >
> > >                 mutex_lock(&dev->domain_lock);
> > > -               if (!dev->domain) {
> > > +               /* TODO asid comes from userspace. mitigations? */
> >
> > We should do sanity check to avoid OOB at least?
> >
>
> There is an if (info.asid > dev->nas) break above, what is missing?

Ok I get, so what you want is array_index_nospec()?

>
> > > +               if (!dev->domain[info.asid]) {
> > >                         mutex_unlock(&dev->domain_lock);
> > >                         break;
> > >                 }
> > > -               spin_lock(&dev->domain->iotlb_lock);
> > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > > +               spin_lock(&dev->domain[info.asid]->iotlb_lock);
> > > +               map =3D vhost_iotlb_itree_first(dev->domain[info.asid=
]->iotlb,
> > >                                               info.start, info.last);
> > >                 if (map) {
> > >                         info.start =3D map->start;
> > >                         info.last =3D map->last;
> > >                         info.capability =3D 0;
> > > -                       if (dev->domain->bounce_map && map->start =3D=
=3D 0 &&
> > > -                           map->last =3D=3D dev->domain->bounce_size=
 - 1)
> > > +                       if (dev->domain[info.asid]->bounce_map &&
> > > +                           map->start =3D=3D 0 &&
> > > +                           map->last =3D=3D dev->domain[info.asid]->=
bounce_size - 1)
> > >                                 info.capability |=3D VDUSE_IOVA_CAP_U=
MEM;
> > >                 }
> > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > +               spin_unlock(&dev->domain[info.asid]->iotlb_lock);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 if (!map)
> > >                         break;
> > > @@ -1497,8 +1593,13 @@ static int vduse_dev_release(struct inode *ino=
de, struct file *file)
> > >         struct vduse_dev *dev =3D file->private_data;
> > >
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (dev->domain)
> > > -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size=
);
> > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > +               if (dev->domain[i]) {
> > > +                       vduse_dev_dereg_umem(dev, i, 0,
> > > +                                            dev->domain[i]->bounce_s=
ize);
> > > +                       dev->domain[i] =3D NULL;
> > > +               }
> > > +       }
> > >         mutex_unlock(&dev->domain_lock);
> > >         spin_lock(&dev->msg_lock);
> > >         /* Make sure the inflight messages can processed after reconn=
cection */
> > > @@ -1768,9 +1869,12 @@ static int vduse_destroy_dev(char *name)
> > >         idr_remove(&vduse_idr, dev->minor);
> > >         kvfree(dev->config);
> > >         vduse_dev_deinit_vqs(dev);
> > > -       if (dev->domain)
> > > -               vduse_domain_destroy(dev->domain);
> > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > +               if (dev->domain[i])
> > > +                       vduse_domain_destroy(dev->domain[i]);
> > > +       }
> > >         kfree(dev->name);
> > > +       kfree(dev->umem);
> > >         vduse_dev_destroy(dev);
> > >         module_put(THIS_MODULE);
> > >
> > > @@ -1877,7 +1981,8 @@ static ssize_t bounce_size_store(struct device =
*device,
> > >
> > >         ret =3D -EPERM;
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (dev->domain)
> > > +       /* Assuming that if the first domain is allocated, all are al=
located */
> > > +       if (dev->domain[0])
> > >                 goto unlock;
> > >
> > >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > > @@ -1933,11 +2038,20 @@ static int vduse_create_dev(struct vduse_dev_=
config *config,
> > >                 if (config->ngroups > VDUSE_MAX_VQ_GROUPS) {
> > >                         pr_err("Not creating a VDUSE device with %u v=
q groups. Max: %u",
> > >                                 config->ngroups, VDUSE_MAX_VQ_GROUPS)=
;
> > > +                       /* TODO: Need to destroy dev here too! */
> > >                         goto err;
> > >                 }
> > > +               if (config->nas > VDUSE_MAX_ASID) {
> > > +                       pr_err("Not creating a VDUSE device with %u a=
sid. Max: %u",
> > > +                               config->nas, VDUSE_MAX_ASID);
> > > +                       goto err_nas;
> > > +               }
> > > +
> > >                 dev->ngroups =3D config->ngroups ?: 1;
> > > +               dev->nas =3D config->nas ?: 1;
> > >         } else {
> > >                 dev->ngroups =3D 1;
> > > +               dev->nas =3D 1;
> > >         }
> > >         for (u32 i =3D 0; i < dev->ngroups; ++i)
> > >                 dev->groups[i].dev =3D dev;
> > > @@ -1977,6 +2091,7 @@ static int vduse_create_dev(struct vduse_dev_co=
nfig *config,
> > >  err_idr:
> > >         kfree(dev->name);
> > >  err_str:
> > > +err_nas:
> > >         vduse_dev_destroy(dev);
> > >  err:
> > >         return ret;
> > > @@ -2069,7 +2184,6 @@ static int vduse_open(struct inode *inode, stru=
ct file *file)
> > >         if (!control)
> > >                 return -ENOMEM;
> > >
> > > -       control->api_version =3D VDUSE_API_VERSION;
> > >         file->private_data =3D control;
> > >
> > >         return 0;
> > > @@ -2101,7 +2215,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev=
 *dev, const char *name)
> > >
> > >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> > >                                  &vduse_vdpa_config_ops, &vduse_map_o=
ps,
> > > -                                dev->ngroups, 1, name, true);
> > > +                                dev->ngroups, dev->nas, name, true);
> > >         if (IS_ERR(vdev))
> > >                 return PTR_ERR(vdev);
> > >
> > > @@ -2137,11 +2251,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
> > >                 return ret;
> > >
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (!dev->domain)
> > > -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE -=
 1,
> > > -                                                 dev->bounce_size);
> > > +       ret =3D 0;
> > > +
> > > +       /* TODO we could delay the creation of the domain */
> >
> > I don't get what this means?
> >
>
> If the device support all 64 asid but it never uses them we're
> consuming the memory for all the struct vduse_iova_domain, struct
> vduse_umem, etc. We could delay its creating until we start using it,
> but it complicates the code.

If it doesn't takes too much memory, we can start from a static
allocation (if that's what you meant here).

>
> > > +       for (int i =3D 0; i < dev->nas; ++i) {
> > > +               if (!dev->domain[i])
> > > +                       dev->domain[i] =3D vduse_domain_create(VDUSE_=
IOVA_SIZE - 1,
> > > +                                                            dev->bou=
nce_size);
> > > +               if (!dev->domain[i]) {
> > > +                       ret =3D -ENOMEM;
> > > +                       for (int j =3D 0; j < i; ++j)
> > > +                               vduse_domain_destroy(dev->domain[j]);
> >
> > Why not move the above error handling to the err label?
> >
>
> That implies I need to signal the index of successfully created
> domains. We only need to handle that in this part of the code. To move
> it is not impossible of course but it complicates the code IMO. I'd be
> happy to move it if requested though.
>
> > > +                       goto err_domain;
> > > +               }
> > > +       }
> > > +
> > >         mutex_unlock(&dev->domain_lock);
> > > -       if (!dev->domain) {
> > > +       if (ret =3D=3D -ENOMEM) {
> > >                 put_device(&dev->vdev->vdpa.dev);
> > >                 return -ENOMEM;
> > >         }
> > > @@ -2150,13 +2276,22 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
> > >         if (ret) {
> > >                 put_device(&dev->vdev->vdpa.dev);
> > >                 mutex_lock(&dev->domain_lock);
> > > -               vduse_domain_destroy(dev->domain);
> > > -               dev->domain =3D NULL;
> > > +               for (int i =3D 0; i < dev->nas; i++) {
> > > +                       if (dev->domain[i]) {
> > > +                               vduse_domain_destroy(dev->domain[i]);
> > > +                               dev->domain[i] =3D NULL;
> > > +                       }
> > > +               }
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 return ret;
> > >         }
> > >
> > >         return 0;
> > > +
> > > +err_domain:
> > > +       /* TODO do I need to call put_device? */
> >
> > If it comes after the success of vduse_dev_init_vdpa().
> >
>
> Ouch, that was a TODO for me but I forgot to remove it, sorry :).
>
> > > +       mutex_unlock(&dev->domain_lock);
> > > +       return ret;
> > >  }
> > >
> > >  static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_dev=
ice *dev)
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index b4b139dc76bb..d300fd5f867f 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -47,7 +47,8 @@ struct vduse_dev_config {
> > >         __u32 vq_num;
> > >         __u32 vq_align;
> > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > -       __u32 reserved[12];
> > > +       __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > +       __u32 reserved[11];
> > >         __u32 config_size;
> > >         __u8 config[];
> > >  };
> > > @@ -82,6 +83,17 @@ struct vduse_iotlb_entry {
> > >         __u8 perm;
> > >  };
> > >
> > > +struct vduse_iotlb_entry_v2 {
> > > +       __u64 offset;
> > > +       __u64 start;
> > > +       __u64 last;
> > > +#define VDUSE_ACCESS_RO 0x1
> > > +#define VDUSE_ACCESS_WO 0x2
> > > +#define VDUSE_ACCESS_RW 0x3
> > > +       __u8 perm;
> >
> > We can embed vduse_iotlb_entry here. This will ease the userspace devel=
opment.
> >
>
> I agree, I'll do it that way for the next version.
>
> > > +       __u32 asid;
> > > +};
> > > +
> > >  /*
> > >   * Find the first IOVA region that overlaps with the range [start, l=
ast]
> > >   * and return the corresponding file descriptor. Return -EINVAL mean=
s the
> > > @@ -172,6 +184,16 @@ struct vduse_vq_group {
> > >         __u32 num;
> > >  };
> > >
> > > +/**
> > > + * struct vduse_vq_group - virtqueue group
> > > + @ @group: Index of the virtqueue group
> > > + * @asid: Address space ID of the group
> > > + */
> > > +struct vduse_vq_group_asid {
> > > +       __u32 group;
> > > +       __u32 asid;
> > > +};
> > > +
> > >  /**
> > >   * struct vduse_vq_info - information of a virtqueue
> > >   * @index: virtqueue index
> > > @@ -232,6 +254,7 @@ struct vduse_vq_eventfd {
> > >   * @uaddr: start address of userspace memory, it must be aligned to =
page size
> > >   * @iova: start of the IOVA region
> > >   * @size: size of the IOVA region
> > > + * @asid: Address space ID of the IOVA region
> > >   * @reserved: for future use, needs to be initialized to zero
> > >   *
> > >   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> > > @@ -241,7 +264,8 @@ struct vduse_iova_umem {
> > >         __u64 uaddr;
> > >         __u64 iova;
> > >         __u64 size;
> > > -       __u64 reserved[3];
> > > +       __u32 asid;
> > > +       __u32 reserved[5];
> > >  };
> > >
> > >  /* Register userspace memory for IOVA regions */
> > > @@ -265,7 +289,8 @@ struct vduse_iova_info {
> > >         __u64 last;
> > >  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > >         __u64 capability;
> > > -       __u64 reserved[3];
> > > +       __u32 asid; /* Only if device API version >=3D 1 */
> > > +       __u32 reserved[5];
> > >  };
> > >
> > >  /*
> > > @@ -289,6 +314,7 @@ enum vduse_req_type {
> > >         VDUSE_UPDATE_IOTLB,
> > >         VDUSE_GET_VQ_GROUP,
> > >         VDUSE_GET_VRING_DESC_GROUP,
> > > +       VDUSE_SET_VQ_GROUP_ASID,
> > >  };
> > >
> > >  /**
> > > @@ -344,6 +370,8 @@ struct vduse_dev_request {
> > >                 struct vduse_dev_status s;
> > >                 struct vduse_iova_range iova;
> > >                 struct vduse_vq_group vq_group; /* Only if vduse api =
version >=3D 1 */
> > > +               /* Only if vduse api version >=3D 1 */
> >
> > We can use:
> >
> > /* Only if vduse api version >=3D 1 */
> > struct vduse_vq_group vq_group;
> > struct vduse_vq_group_asid vq_group_asid;
> >
>
> I'm happy to do it that way, but it is not clear to me that both
> members are only if version >=3D1. Maybe "The following members are
> valid only if..."?
>
> > > +               struct vduse_vq_group_asid vq_group_asid;
> > >                 __u32 padding[32];
> > >         };
> > >  };
> > > @@ -367,6 +395,8 @@ struct vduse_dev_response {
> > >         union {
> > >                 struct vduse_vq_state vq_state;
> > >                 struct vduse_vq_group vq_group; /* Only if vduse api =
version >=3D 1 */
> > > +               /* Only if vduse api version >=3D 1 */
> > > +               struct vduse_vq_group_asid vq_group_asid;
> > >                 __u32 padding[32];
> > >         };
> > >  };
> > > --
> > > 2.50.1
> > >
> >
> > Thanks
> >
>

Thanks

