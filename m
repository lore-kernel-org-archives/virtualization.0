Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5733C33
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142439; cv=none; b=tM5FWH9DBO2gStbdLsXIWzwmVyFyQ8yBgDPq9978MzSX0gaRUlfFLQUsUEJFHuWymEjCVK3fRd3pTmsAUUbj+ee9RFY/qRyEq2n5EMF8BXXPVDTRLMQ3U4RKv8sVDvPBRhnVE6+IaDR2tGKPmCIIRO9axQM30zLZYgK6+9WB9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142439; c=relaxed/simple;
	bh=qCYPSQyXfbScn/dju49Sm6k7Gx67vpP4HB1TPAv6kAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWYYBy2cv1qwVOGLKiC9cfYq0O56Lz6VTx572g4+4W0M11ANqJkvg/d9sg8TEhzW3eWTGbyBaBj4OkS4S7hqKpsUSRoZ4/WoNIqgwvDZ6z1g4/hm28vaQ9fKPd6C0b60escsdAA3MbuSPVZMAImEpRBid2/ChEHTjBal8rAkRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9NoDRo/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9NoDRo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755142436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eujK3cEs50pIJAHzYFF3mi6x7v5bUXVfJI3LrBNzuLQ=;
	b=C9NoDRo/X77oFdPd+oNTgYLJxYRj7JZKJcJO+JdcMSwXXUaal9Rl03lufp41/Wr4Xhi4HG
	pqF1xGYFyFY0/Llsz4aUdmmGubVcdE8Qqg0F7RmgxVTUhEFeWMHFAczE/+WlI1tG267dL8
	d80d5l8ufuZE+DUbQDACBS5hq7q2hQo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-U0L2H1eLOWuQXbnsT8B42A-1; Wed, 13 Aug 2025 23:33:54 -0400
X-MC-Unique: U0L2H1eLOWuQXbnsT8B42A-1
X-Mimecast-MFC-AGG-ID: U0L2H1eLOWuQXbnsT8B42A_1755142434
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737c5efso293603a12.1
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 20:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142433; x=1755747233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eujK3cEs50pIJAHzYFF3mi6x7v5bUXVfJI3LrBNzuLQ=;
        b=lVL/4aYh90mkMxQeiztDiLTMlyxjifmqOkO1Da3HLqjoD54aUCkn2W0EmmxefX9ntF
         Md/A+N28sGr88phKwhOz61im9Mg+OAUYUxAEAo2Ep14/l2FJN+S+cB2wG7iKoak9lxaZ
         OVAQi0wiW5B1Il42uS93OEKz378ZxGyKQuEMj2P8qy9PmXKsq41vw6+Nsp7x+TT0Gnz9
         ZzMwB0J8A/dtzsNRGHxILAxvFhZUkV6FjdVd1Wf9QCbvFIlR2M5BOhO8upaBVspubBU7
         bIMyRlxC/l/Vjc1K5zmaZ0ThDkfGSzazgkgDO2bYnjw1xdAjA5B2ODDiVdY8HLLEdFAb
         nZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzkBd89MeNG7iI0fu+mUobtO1c87o/XhLCZHX6mLGfhgcFTttr4lkTSA5M6jOxsJsJRXwV1dhqhGSqtczMlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3wPYe0dN/frwAcpZF1ioD0+/sZAwqixBLOAsqbYWwU6O07Q3O
	lPaLzjWYLDIqGXL4T6Z7iAgG+IkWalsr66/DjGQkmWt/H7WGUW9knu7g10d1Ic/lPKMt5XZlRQA
	8tqXwLXeQb85p4vLUoGQ75V+IsuANvDW1HC5hKf8kmUtqwjzM2w0tO1lLeOkORCJH3r1+dVWN6c
	6bI/yEinKYs1uK4bqe01btX+Y0py8S0gCoBp7PvXAFTkc=
X-Gm-Gg: ASbGncs+JlmALXPeELgNjVJksbAUOtVAk0s3yiqq8rew/beGJeBZO+wyFk9n/gkrBK5
	bASCiMDfozZ7FU0BFY2UK1jj17oeZ3ygodcQ7lL6iXsozN+8ZJUD5sGpUqJefST2F+QZZU2m73h
	Y0s5TLR/3IzYK/yC6x3UIRXQ==
X-Received: by 2002:a05:6a20:72a1:b0:240:1ca4:297d with SMTP id adf61e73a8af0-240bd1b1466mr2133433637.13.1755142433436;
        Wed, 13 Aug 2025 20:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYhrBIKDCg8wLR+E2L4kHSK3U4ob+Ku/FTjWCsSq5KEr8be2JZ+cm7BU8SKuumSalPK5fRr0cs1aTm73S6eg4=
X-Received: by 2002:a05:6a20:72a1:b0:240:1ca4:297d with SMTP id
 adf61e73a8af0-240bd1b1466mr2133378637.13.1755142432887; Wed, 13 Aug 2025
 20:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-10-jasowang@redhat.com>
 <CAJaqyWdZv30TMedrdb-iF6qwwis7d_GJpVyk2dCur2J27+ywog@mail.gmail.com>
In-Reply-To: <CAJaqyWdZv30TMedrdb-iF6qwwis7d_GJpVyk2dCur2J27+ywog@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 11:33:41 +0800
X-Gm-Features: Ac12FXzq8BSEPBlf1MWRz3DYcSqEp8m_lWYmVRk2raUvNN5Yp_wdHSHlFYsejm4
Message-ID: <CACGkMEtYq9XnhNzdmD+=d1k8RStMcMP-Ljo_j1qfz6Us2wOXdQ@mail.gmail.com>
Subject: Re: [PATCH V5 9/9] vduse: switch to use virtio map API instead of DMA API
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m9r0HqpgSeoFJue7iGra7TIxyjyzXSi9jYPoL23YI_0_1755142434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:03=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > Lacking the support of device specific mapping supported in virtio,
> > VDUSE must trick the DMA API in order to make virtio-vdpa transport
> > work. This is done by advertising vDPA device as dma device with a
> > VDUSE specific dma_ops even if it doesn't do DMA at all.
> >
> > This will be fixed by this patch. Thanks to the new mapping operations
> > support by virtio and vDPA. VDUSE can simply switch to advertise its
> > specific mappings operations to virtio via virtio-vdpa then DMA API is
> > not needed for VDUSE any more and iova domain could be used as the
> > mapping token instead.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/Kconfig                 |  8 +--
> >  drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
> >  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c   | 75 ++++++++++++++--------------
> >  4 files changed, 41 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > index 559fb9d3271f..857cf288c876 100644
> > --- a/drivers/vdpa/Kconfig
> > +++ b/drivers/vdpa/Kconfig
> > @@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
> >
> >  config VDPA_USER
> >         tristate "VDUSE (vDPA Device in Userspace) support"
> > -       depends on EVENTFD && MMU && HAS_DMA
> > -       #
> > -       # This driver incorrectly tries to override the dma_ops.  It sh=
ould
> > -       # never have done that, but for now keep it working on architec=
tures
> > -       # that use dma ops
> > -       #
> > -       depends on ARCH_HAS_DMA_OPS
> > +       depends on EVENTFD && MMU
> >         select VHOST_IOTLB
> >         select IOMMU_IOVA
> >         help
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 58116f89d8da..ccaed24b7ef8 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -447,7 +447,7 @@ void vduse_domain_unmap_page(struct vduse_iova_doma=
in *domain,
> >
> >  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> >                                   size_t size, dma_addr_t *dma_addr,
> > -                                 gfp_t flag, unsigned long attrs)
> > +                                 gfp_t flag)
> >  {
> >         struct iova_domain *iovad =3D &domain->consistent_iovad;
> >         unsigned long limit =3D domain->iova_limit;
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_u=
ser/iova_domain.h
> > index 7f3f0928ec78..1f3c30be272a 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -64,7 +64,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain=
 *domain,
> >
> >  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> >                                   size_t size, dma_addr_t *dma_addr,
> > -                                 gfp_t flag, unsigned long attrs);
> > +                                 gfp_t flag);
> >
> >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size=
_t size,
> >                                 void *vaddr, dma_addr_t dma_addr,
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index f161059d543e..3260edefdf0d 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -88,6 +88,7 @@ struct vduse_dev {
> >         struct device *dev;
> >         struct vduse_virtqueue **vqs;
> >         struct vduse_iova_domain *domain;
> > +       struct vduse_iova_domain *dom;
>
> *dom is not used
>

Let me fix that.

> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > @@ -814,59 +815,53 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> >         .free                   =3D vduse_vdpa_free,
> >  };
> >
> > -static void vduse_dev_sync_single_for_device(struct device *dev,
> > +static void vduse_dev_sync_single_for_device(void *token,
> >                                              dma_addr_t dma_addr, size_=
t size,
> >                                              enum dma_data_direction di=
r)
> >  {
> > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D token;
>
> If I add ASID support to VDUSE I'll need to replace the token by a vq
> group representor. Is that ok?

It should be ok.

>
> I think it is as I like how using *domain here makes this patch
> clearer, and adding something else will make this patch harder to
> review.

Yes.

>
> >
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> >  }
> >
> > -static void vduse_dev_sync_single_for_cpu(struct device *dev,
> > +static void vduse_dev_sync_single_for_cpu(void *token,
> >                                              dma_addr_t dma_addr, size_=
t size,
> >                                              enum dma_data_direction di=
r)
> >  {
> > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D token;
> >
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> >
> > -static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *=
page,
> > +static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
> >                                      unsigned long offset, size_t size,
> >                                      enum dma_data_direction dir,
> >                                      unsigned long attrs)
> >  {
> > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D token;
> >
> >         return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> >  }
> >
> > -static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_ad=
dr,
> > +static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
> >                                 size_t size, enum dma_data_direction di=
r,
> >                                 unsigned long attrs)
> >  {
> > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D token;
> >
> >         return vduse_domain_unmap_page(domain, dma_addr, size, dir, att=
rs);
> >  }
> >
> > -static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
> > -                                       dma_addr_t *dma_addr, gfp_t fla=
g,
> > -                                       unsigned long attrs)
> > +static void *vduse_dev_alloc_coherent(void *token, size_t size,
> > +                                     dma_addr_t *dma_addr, gfp_t flag)
> >  {
> > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D token;
> >         unsigned long iova;
> >         void *addr;
> >
> >         *dma_addr =3D DMA_MAPPING_ERROR;
> >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > -                               (dma_addr_t *)&iova, flag, attrs);
> > +                                          (dma_addr_t *)&iova, flag);
> >         if (!addr)
> >                 return NULL;
> >
> > @@ -875,31 +870,45 @@ static void *vduse_dev_alloc_coherent(struct devi=
ce *dev, size_t size,
> >         return addr;
> >  }
> >
> > -static void vduse_dev_free_coherent(struct device *dev, size_t size,
> > -                                       void *vaddr, dma_addr_t dma_add=
r,
> > -                                       unsigned long attrs)
> > +static void vduse_dev_free_coherent(void *token, size_t size,
> > +                                   void *vaddr, dma_addr_t dma_addr,
> > +                                   unsigned long attrs)
> >  {
> > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D token;
> >
> >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs=
);
> >  }
> >
> > -static size_t vduse_dev_max_mapping_size(struct device *dev)
> > +static bool vduse_dev_need_sync(void *token, dma_addr_t dma_addr)
> >  {
> > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D token;
> > +
> > +       return dma_addr < domain->bounce_size;
> > +}
> > +
> > +static int vduse_dev_mapping_error(void *token, dma_addr_t dma_addr)
> > +{
> > +       if (unlikely(dma_addr =3D=3D DMA_MAPPING_ERROR))
> > +               return -ENOMEM;
> > +       return 0;
> > +}
> > +
> > +static size_t vduse_dev_max_mapping_size(void *token)
> > +{
> > +       struct vduse_iova_domain *domain =3D token;
> >
> >         return domain->bounce_size;
> >  }
> >
> > -static const struct dma_map_ops vduse_dev_dma_ops =3D {
> > +static const struct virtio_map_ops vduse_map_ops =3D {
> >         .sync_single_for_device =3D vduse_dev_sync_single_for_device,
> >         .sync_single_for_cpu =3D vduse_dev_sync_single_for_cpu,
> >         .map_page =3D vduse_dev_map_page,
> >         .unmap_page =3D vduse_dev_unmap_page,
> >         .alloc =3D vduse_dev_alloc_coherent,
> >         .free =3D vduse_dev_free_coherent,
> > +       .need_sync =3D vduse_dev_need_sync,
> > +       .mapping_error =3D vduse_dev_mapping_error,
>
> I think that adding these functions here is problematic,
>
> In the case of mapping error vring_mapping_error only checks for
> vdev->map, not for vdev->map->mapping_error:
>
> static int vring_mapping_error(const struct vring_virtqueue *vq,
>                               dma_addr_t addr)
> {
>        struct virtio_device *vdev =3D vq->vq.vdev;
>
>        if (!vq->use_map_api)
>                return 0;
>
>        if (vdev->map)
>                return vdev->map->mapping_error(vring_mapping_token(vq), a=
ddr);
>        else
>                return dma_mapping_error(vring_dma_dev(vq), addr);
> }
>
> So we either add the check for the member or we define them from the begi=
nning.

I'm not sure I will get here. I can add a comment to explain that all
map ops are mandated not optional.

Thanks

>
> >         .max_mapping_size =3D vduse_dev_max_mapping_size,
> >  };
> >
> > @@ -2003,27 +2012,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
> >  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name=
)
> >  {
> >         struct vduse_vdpa *vdev;
> > -       int ret;
> >
> >         if (dev->vdev)
> >                 return -EEXIST;
> >
> >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> > -                                &vduse_vdpa_config_ops, NULL,
> > +                                &vduse_vdpa_config_ops, &vduse_map_ops=
,
> >                                  1, 1, name, true);
> >         if (IS_ERR(vdev))
> >                 return PTR_ERR(vdev);
> >
> >         dev->vdev =3D vdev;
> >         vdev->dev =3D dev;
> > -       vdev->vdpa.dev.dma_mask =3D &vdev->vdpa.dev.coherent_dma_mask;
> > -       ret =3D dma_set_mask_and_coherent(&vdev->vdpa.dev, DMA_BIT_MASK=
(64));
> > -       if (ret) {
> > -               put_device(&vdev->vdpa.dev);
> > -               return ret;
> > -       }
> > -       set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
> > -       vdev->vdpa.mapping_token.dma_dev =3D &vdev->vdpa.dev;
> >         vdev->vdpa.mdev =3D &vduse_mgmt->mgmt_dev;
> >
> >         return 0;
> > @@ -2056,6 +2056,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
> >                 return -ENOMEM;
> >         }
> >
> > +       dev->vdev->vdpa.mapping_token.token =3D dev->domain;
> >         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> >         if (ret) {
> >                 put_device(&dev->vdev->vdpa.dev);
> > --
> > 2.31.1
> >
>

