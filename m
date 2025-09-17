Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BCD34BA35
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125835; cv=none; b=otI4+6d4RPLDzEQ/S1lgBJjLubVGlDCSPM4hl85XLU4Dfl0YU5DJZAkX2K9LroeiXFKdGlYg7me7hF22Xk3hY4z7kumgbgcJwfyLvrX927jdO6VVzfce7oUuHPjpnSyxBxNsWLa8oMSPDJsghJ9kR4MU3yp0S72mBzgRsxiewMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125835; c=relaxed/simple;
	bh=f5o/FUxe5iNbC4RBGy2qWQid6QD7+9xO0zGKc4rFrQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvFTVZqm3iGNwbZympviJe2sl747RrlzXXK+RE3I9ALHO25dDXsczGMSTXOKlQ37AD7dOWr3VG7fcbW0WPK7bslgerA0B4cHLv5kT20axgqxVKv5YqO/7kpT/TlJ55z1ELy5qi2e6n++G5qFUpZSmEHILcT3hlmY1J1ON5w4dlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwqNvklX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwqNvklX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758125832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfWZBt2zSfStApfaCH7mmPn5eoFglffKKLGnGyZRxNM=;
	b=RwqNvklXbGfzKHZwB7ePBOAblbRIE3gLXFC38ea2enaaLSeSGNsFCL8LIza8j/eZrgJTS0
	IFUnvq1Qp8Fax2x2KpocrZz7nU0vJIotE8IufT8gDi8OAWnkmFyjPej9B/z6/Feduz/+YB
	KDpSv83c+X1f2fv1jj5E/PR4brtMuw0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-GtC5EB7PNKKP1L_ccnOPRg-1; Wed, 17 Sep 2025 12:17:10 -0400
X-MC-Unique: GtC5EB7PNKKP1L_ccnOPRg-1
X-Mimecast-MFC-AGG-ID: GtC5EB7PNKKP1L_ccnOPRg_1758125830
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-733ff1a73dcso668917b3.1
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125830; x=1758730630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfWZBt2zSfStApfaCH7mmPn5eoFglffKKLGnGyZRxNM=;
        b=n3kBwXA9YG9e/+xx7XNA4nWf4wY655/fGA8sm1OmA0kaRgF7JI89i788lLy42QyiJ5
         jo0FhiTJ/LnIpZKFFiQGj1z+6TbuZCBDxVyQ+y31krChjc/e1hdh4hfEaSXQ2xXQbsTm
         Ncfv/SetGj1Y+tD6q+yYzSHFOjy6K5MBDeR22RF94W9Y5UBjohGQiub6YfPC4bgLSpxw
         Fifj65Olke96CDn/HcwRRLpknvCegKrbbr0V2hdIyWHy3G8yYxzZtujM+rXwhibQ22YU
         8aXCtzqxFKjZrP5ki/rwm6+ADkzfTdXN3bhSdB+etoYJXCTNRf2aLaIUrBV1a8RdEXvz
         IsUw==
X-Forwarded-Encrypted: i=1; AJvYcCUGcAMwMZi4iiPrAwvkV47mFn/+4mNDpcenN7LwzsnDVOQ73O5R5btIZDWNJRBXQfOSwiO1TsNAZvvXOMGWeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw61FC/rSCtudaHFNvxjJltdkdrr9oVF1Y5nK4lvcCUr+9JxSHx
	Vax9tqv4Z8XpegarsxfhD2T3PPbMNM0BjUMGn0YODJyDWBY+pKiIikIGBiqJYSIP5kNnECi4WPp
	OeQOdFa7OnhsLFHsAeSegCoUkkG9pKK7YU4wQ9x6g8/XoGJWAwpprIb1hugWXK1ZrpopCp4cOXh
	VIOvKgrMzU1mGxzaAw5q/q8sRsfkGN5WQnOZ4o5BJp6aI=
X-Gm-Gg: ASbGncs44lsONVcO3jkz5xXi6DXjy2dtsaer0LsEoKhdURo4Grb82Y6uCHFUq4RVKrh
	R8IyfntGCNwkVOjxcpN7nq8YlX72H9TYcBQy6F3AvpbX21aU2RSnE+4qFUb9Ktzb0sAAcU5v2ZI
	9BCwe9/yJzOeuX0lbPBtsmfBOdkL2CMY7UmlJLK19UUhWbv4aLmit0zTWgkndAOnpzgamJqq0Qz
	dXEgOYl
X-Received: by 2002:a05:690c:64ca:b0:726:4b7a:1ec1 with SMTP id 00721157ae682-73893249140mr23662897b3.47.1758125830009;
        Wed, 17 Sep 2025 09:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGObF9RKTyIpHyxzWy+Hnw2h3N0ZVh0xAj9VZdVv1dpBLIeYQreBnm0kTVybwmeR5N+VPNZL+4W2cjYeU7Ptbg=
X-Received: by 2002:a05:690c:64ca:b0:726:4b7a:1ec1 with SMTP id
 00721157ae682-73893249140mr23662517b3.47.1758125829439; Wed, 17 Sep 2025
 09:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-5-eperezma@redhat.com>
 <CACGkMEuY359QtVeTY40Z_L1zhG87rB2te=qc7YM6gZxcKM=m7w@mail.gmail.com>
In-Reply-To: <CACGkMEuY359QtVeTY40Z_L1zhG87rB2te=qc7YM6gZxcKM=m7w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 18:16:33 +0200
X-Gm-Features: AS18NWDkg-GLhDiz_uY5XwV9ED8cCpt8XErhSKA-aurbAKWbY2w-ZsgS0WsMdl0
Message-ID: <CAJaqyWfkpxmFXafRnxvP1Wjd3=uBaSr_m05BCpDYB4e7XR9diQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] vduse: return internal vq group struct as map token
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u2Jv7XoamwE76zXuP_UsOFz14hEbAmHRpJJ86ce3SXo_1758125830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Return the internal struct that represents the vq group as virtqueue ma=
p
> > token, instead of the device.  This allows the map functions to access
> > the information per group.
> >
> > At this moment all the virtqueues share the same vq group, that only
> > can point to ASID 0.  This change prepares the infrastructure for actua=
l
> > per-group address space handling
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > RFC v3:
> > * Make the vq groups a dynamic array to support an arbitrary number of
> >   them.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++------
> >  include/linux/virtio.h             |  6 ++--
> >  2 files changed, 46 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 42f8807911d4..9c12ae72abc2 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/vdpa.h>
> >  #include <linux/nospec.h>
> > +#include <linux/virtio.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sched/mm.h>
> >  #include <uapi/linux/vduse.h>
> > @@ -85,6 +86,10 @@ struct vduse_umem {
> >         struct mm_struct *mm;
> >  };
> >
> > +struct vduse_vq_group_int {
> > +       struct vduse_dev *dev;
> > +};
>
> I remember we had some discussion over this, and the conclusion is to
> have a better name.
>
> Maybe just vduse_vq_group?
>

Good catch, I also hate the _int suffix :). vduse_vq_group was used in
the vduse uapi in previous series, but now there is no reason for it.
Replacing it, thanks!

> And to be conceptually correct, we need to use iova_domain here
> instead of the vduse_dev. More below.
>
> > +
> >  struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> > @@ -118,6 +123,7 @@ struct vduse_dev {
> >         u32 vq_align;
> >         u32 ngroups;
> >         struct vduse_umem *umem;
> > +       struct vduse_vq_group_int *groups;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> >         rwlock_t domain_lock;
> > @@ -602,6 +608,15 @@ static u32 vduse_get_vq_group(struct vdpa_device *=
vdpa, u16 idx)
> >         return dev->vqs[idx]->vq_group;
> >  }
> >
> > +static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16=
 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +       u32 vq_group =3D dev->vqs[idx]->vq_group;
> > +       union virtio_map ret =3D { .group =3D &dev->groups[vq_group] };
> > +
> > +       return ret;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -822,6 +837,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> >
> > @@ -829,7 +845,8 @@ static void vduse_dev_sync_single_for_device(union =
virtio_map token,
> >                                              dma_addr_t dma_addr, size_=
t size,
> >                                              enum dma_data_direction di=
r)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
>
> If we really want to do this, we need to move the iova_domian into the gr=
oup.
>

It's done in patches on top to make each patch smaller. This patch is
focused on just changing the type of the union. Would you prefer me to
reorder the patches so that part is done earlier?

> >
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> >  }
> > @@ -838,7 +855,8 @@ static void vduse_dev_sync_single_for_cpu(union vir=
tio_map token,
> >                                              dma_addr_t dma_addr, size_=
t size,
> >                                              enum dma_data_direction di=
r)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> > @@ -848,7 +866,8 @@ static dma_addr_t vduse_dev_map_page(union virtio_m=
ap token, struct page *page,
> >                                      enum dma_data_direction dir,
> >                                      unsigned long attrs)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> >  }
> > @@ -857,7 +876,8 @@ static void vduse_dev_unmap_page(union virtio_map t=
oken, dma_addr_t dma_addr,
> >                                  size_t size, enum dma_data_direction d=
ir,
> >                                  unsigned long attrs)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         return vduse_domain_unmap_page(domain, dma_addr, size, dir, att=
rs);
> >  }
> > @@ -865,7 +885,8 @@ static void vduse_dev_unmap_page(union virtio_map t=
oken, dma_addr_t dma_addr,
> >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t s=
ize,
> >                                       dma_addr_t *dma_addr, gfp_t flag)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >         unsigned long iova;
> >         void *addr;
> >
> > @@ -884,14 +905,16 @@ static void vduse_dev_free_coherent(union virtio_=
map token, size_t size,
> >                                     void *vaddr, dma_addr_t dma_addr,
> >                                     unsigned long attrs)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs=
);
> >  }
> >
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma=
_addr)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         return dma_addr < domain->bounce_size;
> >  }
> > @@ -905,7 +928,8 @@ static int vduse_dev_mapping_error(union virtio_map=
 token, dma_addr_t dma_addr)
> >
> >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         return domain->bounce_size;
> >  }
> > @@ -1720,6 +1744,7 @@ static int vduse_destroy_dev(char *name)
> >         if (dev->domain)
> >                 vduse_domain_destroy(dev->domain);
> >         kfree(dev->name);
> > +       kfree(dev->groups);
> >         vduse_dev_destroy(dev);
> >         module_put(THIS_MODULE);
> >
> > @@ -1885,7 +1910,15 @@ static int vduse_create_dev(struct vduse_dev_con=
fig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +
> >         dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups =
?: 1);
> > +       dev->groups =3D kcalloc(dev->ngroups, sizeof(dev->groups[0]),
> > +                             GFP_KERNEL);
> > +       if (!dev->groups)
> > +               goto err_vq_groups;
> > +       for (u32 i =3D 0; i < dev->ngroups; ++i)
> > +               dev->groups[i].dev =3D dev;
> > +
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> >                 goto err_str;
> > @@ -1922,6 +1955,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >  err_idr:
> >         kfree(dev->name);
> >  err_str:
> > +       kfree(dev->groups);
> > +err_vq_groups:
> >         vduse_dev_destroy(dev);
> >  err:
> >         return ret;
> > @@ -2083,7 +2118,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
> >                 return -ENOMEM;
> >         }
> >
> > -       dev->vdev->vdpa.vmap.iova_domain =3D dev->domain;
> >         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> >         if (ret) {
> >                 put_device(&dev->vdev->vdpa.dev);
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 96c66126c074..5f8db75f7833 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -41,13 +41,13 @@ struct virtqueue {
> >         void *priv;
> >  };
> >
> > -struct vduse_iova_domain;
> > +struct vduse_vq_group_int;
> >
> >  union virtio_map {
> >         /* Device that performs DMA */
> >         struct device *dma_dev;
> > -       /* VDUSE specific mapping data */
> > -       struct vduse_iova_domain *iova_domain;
> > +       /* VDUSE specific virtqueue group for doing map */
> > +       struct vduse_vq_group_int *group;
> >  };
> >
> >  int virtqueue_add_outbuf(struct virtqueue *vq,
> > --
> > 2.51.0
> >
>
> Thanks
>

