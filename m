Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC8264F8A
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357509; cv=none; b=S9gsR9cDhTIR6Y2giXOBKQeL6HQNL80WZivt5eOZebJlL6AQRbOYjchGd8MoLHJ26ECjAAWBXo0RsPRS+bCAXb3MGr04qqwlOfOv2Qj1KP1n8aZkljVzfxY7eGSMSCLxcg4RmQnYaqMnymAmHt9EZSf7cKT6ZeJkMF1SYs3Ph34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357509; c=relaxed/simple;
	bh=Pwgdi2CvewwnEKgFZOz2o74hYongJz6uGVGt3vJGt30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/zngMfytylEG1h0JTXS9G5k+nVIHiKQBEiySywm72lidDilEDnSayTt1HOHxAqtjW5gaKV5sQ5homG/XSX8eHgZ1DLwB/y+7diUfgvPEW12o1X+CUfON1NgsRnbRAkQR2b7bEsQMRmjgdjXkeuZHtbhAp2orScS906kCNKJAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEnwQynG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEnwQynG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751357506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4tzUe65NdcyoaFKff3kl/phF45No3Ud2Gm+SIFnV3G8=;
	b=CEnwQynGAf/bkodRYfn72whG/PUXrYQy91I83UcpZcRGup862viIJY4/JSn0IrJP64D94b
	vKAKi0F8UUlgj9l5t3QFYMFeRi1x0Y9irv2tU187v08YQ0iut9pEQVFvAlI8lZumlP1MRt
	zOLtS2YkmGRsVtJrUzRmJsJ0LdfG6PM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-SZ1tWnrHNB2N7cpZxGMtoA-1; Tue, 01 Jul 2025 04:11:45 -0400
X-MC-Unique: SZ1tWnrHNB2N7cpZxGMtoA-1
X-Mimecast-MFC-AGG-ID: SZ1tWnrHNB2N7cpZxGMtoA_1751357504
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so4705379a91.1
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 01:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751357503; x=1751962303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tzUe65NdcyoaFKff3kl/phF45No3Ud2Gm+SIFnV3G8=;
        b=ctSo7d8MuYLYEyJrAp4Pq9eQvJ+Jb4bk6/Ob1yXd2UtWGownENRLZMQ9t+NLRFzuy2
         w3jz4KM8sE5R36gmFr7MQGcBAyXo+QhFC8PX7HKEzFYVxBkydPbR+UtWr0Qs2gVoXxpg
         iX94xYcaurh+5XMuySNUddxZ+CVlCdUZDUp1Sb8noMwh6RnoFXhsxjpkkrUCHBbiPUwg
         UjS59XWWBufPbEoPRgUdU0xV+dQDHfQIEpE6wg8KiTtjQf6vOOHIxw2tF78YXWLHxNPk
         CBYpFww966qmuk8Z1KxKM3wzxI81SIW8m0AGalu9Qitv444NYtgYVrdpYpOnU5W52YOl
         s7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVdGLL1Wh0/ErP9b0BmSqjHC3IIguxN+C/nErtl9JU9OoRyHMj0QnCoODcbm4WshHKZ+pMh3tY5GBzD45D1tQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5StqONMLNrnq7pr1x0Xrp99b58EuY1fktwvNdLOdErH5pWhb/
	YHeRY46yCmvNYTJddLLjEdB0yQc7aCk9U2CnyME6QF0OI56lausneyhSFOdmQaqXeCzpdiJsxbO
	1xNWScR3ZWgA1qX0iVgxlpk+RhCpBye5jhEDpAV9DCjnWd7SZz0E+MC17H2lM3EC0vM/fUF/0XY
	AlL//7HG3OFjCLC6w9eSPJSZ3ynC/k23/bmKp2U04oA+c=
X-Gm-Gg: ASbGncv28qs5x7VttZQtkAvBZN27dnMwKrdICkMXvAe0fJ/QDk57ste0//l8VwV1sza
	/v7qzHGbFbFjyXAUPLXmuRgWDteDXHh9gmH0jUc9vQnnael0A2wfk+jpJwm5T76QYuSZyxBBG49
	FD
X-Received: by 2002:a17:90b:3c06:b0:312:e9bd:5d37 with SMTP id 98e67ed59e1d1-318c9106946mr22510156a91.6.1751357502428;
        Tue, 01 Jul 2025 01:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpJTtJ3cO2SOiD5qr9TT09fbndyZp4u8KjU6x0emgonO+tUZ0YiHzbsC1YylxU+ge1nnS6RXzqUmlF4Nt+jeg=
X-Received: by 2002:a17:90b:3c06:b0:312:e9bd:5d37 with SMTP id
 98e67ed59e1d1-318c9106946mr22510106a91.6.1751357501802; Tue, 01 Jul 2025
 01:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701011401.74851-1-jasowang@redhat.com> <20250701011401.74851-10-jasowang@redhat.com>
 <20250701034754-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250701034754-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 16:11:29 +0800
X-Gm-Features: Ac12FXxba2GAg1rPYB--ydU2eP87EwqN6UIFRq9hSMO-3XBfVhHBu1N5p0_hvt4
Message-ID: <CACGkMEv2OUBgrawUv-mPMV6=soV4CE+QM7VqEsnUjxdnEiySCg@mail.gmail.com>
Subject: Re: [PATCH 9/9] vduse: switch to use virtio map API instead of DMA API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org, xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p-nuLRvhYnW7lmw6_qQqB31jjnJVGhGvGU1aH4nmido_1751357504
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 3:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jul 01, 2025 at 09:14:01AM +0800, Jason Wang wrote:
> > Lacking the support of device specific mapping supported in virtio,
> > VDUSE must trick the DMA API in order to make virtio-vdpa transport
> > work. This is done by advertising vDPA device as dma device with a
> > VDUSE specific dma_ops even if it doesn't do DMA at all.
> >
> > This will be fixed by this patch. Thanks to the new mapping operations
> > support by virtio and vDPA. VDUSE can simply switch to advertise its
> > specific mappings operations to virtio via virtio-vdpa then DMA API is
> > not needed for VDUSE any more.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> so what exactly is the issue fixed by all this pile of code?

Avoiding using DMA API for VDUSE.

> I just don't really see it. yes the existing thing is a hack
> but at least it is isolated within vduse which let's be
> frank is not it's only issue.

Christoph shows concerns when Eugenio is trying to extend VDUSE for
multiple AS support:

https://lists.openwall.net/linux-kernel/2025/06/23/133

I think we need to reach some agreement here. I'm fine to leave the
current code as is.

But we may have a problem:

Technically, we want the ability of allowing control virtqueue to be
backed by an isolated iova domain in order to make shadow virtqueue
work. Though this might be only useful for vhost-vdpa, technically we
should allow virtio-vdpa to work in this case as well. This means cvq
should have its own dma device which might be tricky to VDUSE to
implement (for example it needs a hack on top of the existing hack,
e.g creating a child device to that which looks more like an
overkill).

Thanks

>
>
> > ---
> >  drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
> >  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c   | 31 ++++++++++++++++------------
> >  3 files changed, 20 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 019f3305c0ac..8ea311692545 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -447,7 +447,7 @@ void vduse_domain_unmap_page(struct vduse_iova_doma=
in *domain,
> >
> >  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> >                                 size_t size, dma_addr_t *dma_addr,
> > -                               gfp_t flag, unsigned long attrs)
> > +                               gfp_t flag)
> >  {
> >       struct iova_domain *iovad =3D &domain->consistent_iovad;
> >       unsigned long limit =3D domain->iova_limit;
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_u=
ser/iova_domain.h
> > index 846572b95c23..a2316571671f 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -64,7 +64,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain=
 *domain,
> >
> >  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> >                                 size_t size, dma_addr_t *dma_addr,
> > -                               gfp_t flag, unsigned long attrs);
> > +                               gfp_t flag);
> >
> >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size=
_t size,
> >                               void *vaddr, dma_addr_t dma_addr,
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 64bc39722007..f86d7111e103 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -814,51 +814,55 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> >       .free                   =3D vduse_vdpa_free,
> >  };
> >
> > -static void vduse_dev_sync_single_for_device(struct device *dev,
> > +static void vduse_dev_sync_single_for_device(void *token,
> >                                            dma_addr_t dma_addr, size_t =
size,
> >                                            enum dma_data_direction dir)
> >  {
> > +     struct device *dev =3D token;
> >       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> >       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >       vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
> >  }
> >
> > -static void vduse_dev_sync_single_for_cpu(struct device *dev,
> > +static void vduse_dev_sync_single_for_cpu(void *token,
> >                                            dma_addr_t dma_addr, size_t =
size,
> >                                            enum dma_data_direction dir)
> >  {
> > +     struct device *dev =3D token;
> >       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> >       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >       vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> >
> > -static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *=
page,
> > +static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
> >                                    unsigned long offset, size_t size,
> >                                    enum dma_data_direction dir,
> >                                    unsigned long attrs)
> >  {
> > +     struct device *dev =3D token;
> >       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> >       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >       return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
> >  }
> >
> > -static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_ad=
dr,
> > +static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
> >                               size_t size, enum dma_data_direction dir,
> >                               unsigned long attrs)
> >  {
> > +     struct device *dev =3D token;
> >       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> >       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >       return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
> >  }
> >
> > -static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
> > -                                     dma_addr_t *dma_addr, gfp_t flag,
> > -                                     unsigned long attrs)
> > +static void *vduse_dev_alloc_coherent(void *token, size_t size,
> > +                                   dma_addr_t *dma_addr, gfp_t flag)
> >  {
> > +     struct device *dev =3D token;
> >       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> >       struct vduse_iova_domain *domain =3D vdev->domain;
> >       unsigned long iova;
> > @@ -866,7 +870,7 @@ static void *vduse_dev_alloc_coherent(struct device=
 *dev, size_t size,
> >
> >       *dma_addr =3D DMA_MAPPING_ERROR;
> >       addr =3D vduse_domain_alloc_coherent(domain, size,
> > -                             (dma_addr_t *)&iova, flag, attrs);
> > +                                        (dma_addr_t *)&iova, flag);
> >       if (!addr)
> >               return NULL;
> >
> > @@ -875,25 +879,27 @@ static void *vduse_dev_alloc_coherent(struct devi=
ce *dev, size_t size,
> >       return addr;
> >  }
> >
> > -static void vduse_dev_free_coherent(struct device *dev, size_t size,
> > +static void vduse_dev_free_coherent(void *token, size_t size,
> >                                       void *vaddr, dma_addr_t dma_addr,
> >                                       unsigned long attrs)
> >  {
> > +     struct device *dev =3D token;
> >       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> >       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >       vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
> >  }
> >
> > -static size_t vduse_dev_max_mapping_size(struct device *dev)
> > +static size_t vduse_dev_max_mapping_size(void *token)
> >  {
> > +     struct device *dev =3D token;
> >       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> >       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >       return domain->bounce_size;
> >  }
> >
> > -static const struct dma_map_ops vduse_dev_dma_ops =3D {
> > +static const struct virtio_map_ops vduse_map_ops =3D {
> >       .sync_single_for_device =3D vduse_dev_sync_single_for_device,
> >       .sync_single_for_cpu =3D vduse_dev_sync_single_for_cpu,
> >       .map_page =3D vduse_dev_map_page,
> > @@ -2009,7 +2015,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
dev, const char *name)
> >               return -EEXIST;
> >
> >       vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> > -                              &vduse_vdpa_config_ops, NULL,
> > +                              &vduse_vdpa_config_ops, &vduse_map_ops,
> >                                1, 1, name, true);
> >       if (IS_ERR(vdev))
> >               return PTR_ERR(vdev);
> > @@ -2022,7 +2028,6 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
dev, const char *name)
> >               put_device(&vdev->vdpa.dev);
> >               return ret;
> >       }
> > -     set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
> >       vdev->vdpa.map_token =3D &vdev->vdpa.dev;
> >       vdev->vdpa.mdev =3D &vduse_mgmt->mgmt_dev;
> >
> > --
> > 2.34.1
>

