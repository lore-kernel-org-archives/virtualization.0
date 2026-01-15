Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926035F8B1
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482858; cv=none; b=nNjX7loNeEs+dnnUFY2/iOE5zPqjBNk42UBhAs30xegMPsxnMtaP33L3+HrZhvJmQNPkxNKbrJjx8tX/Li9vMdpfNfN5Sp8HizLXVqK0Sc1aN6nn1kcUm0l/9ZTOHzzOR12dAECeBK6CBP3olzAMf8JKap2eWWxTkPH1rZCzrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482858; c=relaxed/simple;
	bh=sUmbxOxCbOL4/RyF8PNyO0BNzsSCJO63JEr8qh9SYVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOvU6uWspXSfaB+9SjuvkUmygkZyQChi/VKG/LsaiPC5rL4UbTaHuN+fRbJDf80QSYGGDZNHsCk2DasvgepxNYyUKvEUHYSZySIKHVZHKrBeNLrO1nijXjSIcy+GxW3PPY5yPdmHsYsdGCEVbMIIQOhuMyenC935dZD8Pj9BwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvUc0EcO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvUc0EcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768482856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGZGpJ14uBCHWL61vtoZBdWl/RcYmehzPPEjCGrmHyc=;
	b=ZvUc0EcOxiiMvfibOFR+1PsvSQYrMiPs4B5lART5+2AnA6lKGrIB94wV2z63tScGyDyFrg
	hA0cRuC9TpPzhX7VLn1pe75QsiZFCJtTfo60phKWD3g3rumklKDc4viduAZTVG4ma2gXYm
	fGd9RJtp87DGu/jrclkM6LnNQweLW7w=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-FHEs7Cu1MDK1B-VCeZg22Q-1; Thu, 15 Jan 2026 08:14:14 -0500
X-MC-Unique: FHEs7Cu1MDK1B-VCeZg22Q-1
X-Mimecast-MFC-AGG-ID: FHEs7Cu1MDK1B-VCeZg22Q_1768482854
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-645592c1b59so1189887d50.0
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 05:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768482854; x=1769087654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGZGpJ14uBCHWL61vtoZBdWl/RcYmehzPPEjCGrmHyc=;
        b=qficB3NY5HVG/8nL4yW/Xe+KTV8Ku5I9Y9fqur8zoscAKyE9poQjVQobtJ774pJXGl
         rRrVUncpETFlIqRwKRtXg41Sc7UBubEocGY3t9hcQUMAhbkGs4flZQBLcOOZ+nd8sIJw
         4Qn9OUsEoky1vD9KZ5XGMGYf8mOPY6ixu/SWAFGhb3g1Hc6kYxR+OUKB6oRzFHpV70Pt
         I1cWVPm6+r9EFAolHFgUKbuZiYsC3BMvt1zoozg4mg+uPQiL+B3nCaaWloLbTvifURQn
         7Mj4aCL+So2reupMzjmGc4q2vxqTcBsvr+dQs8Diqs6DKnkM5gp6EKvRxSInm3DzSOHo
         c72A==
X-Forwarded-Encrypted: i=1; AJvYcCXCws+7ObcllUoAiLlSgMIQsSJyzM7KFbzuhvO+zvTL0VRZsBzXoSlTAai6WG/eh3i3iu5B15BA1Fd+R2J/qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGwwTJICCqruzFexJsUORma4E27KxawMtYP+MHT0OI/qGm6fq9
	VcaLKWbpbBeDZn3PvqwNwhxoNvfFoQI4QXPNelXgI//IngEYvLODucdYLWOeEZyM3yK3GLCDope
	6XfIRBT+2BmECcCc1xY2tCatRHPZgnvdC8IAS8JkDpqEKoOvHuEI2q//5Jmb2ygvRIPOzxaLL2H
	Ep5ZGaj5dK3RuSgLoSHSvT82r3nUqRy+/piFqffTp8bfM=
X-Gm-Gg: AY/fxX529Zhey/a6pxsc+MUMTp4QoXQ0W6CmnUcrT251+EUcmNmvPxKDXR+V2wxnAtr
	f2dqd1JJk2toT/RgWENqewpemsvlDaCdVPEwX41T4U5tHBDTF9aX4JUTpu0UM2+PPi56hVh2vFo
	1qSGanX4P93ra6Rtr8PF60moBD2tM1QlyLdu4OsBgy9CHep3hmnQa3MiPTTmBlGYms8Q==
X-Received: by 2002:a05:690e:138f:b0:644:60d9:7508 with SMTP id 956f58d0204a3-64901b2d185mr4503244d50.88.1768482854155;
        Thu, 15 Jan 2026 05:14:14 -0800 (PST)
X-Received: by 2002:a05:690e:138f:b0:644:60d9:7508 with SMTP id
 956f58d0204a3-64901b2d185mr4503222d50.88.1768482853702; Thu, 15 Jan 2026
 05:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-10-eperezma@redhat.com>
 <CACGkMEuMsz8ao0btTixZ=Lh7GadyxdOtu4HQeF=c7=TTirmV+A@mail.gmail.com>
 <20260115034348-mutt-send-email-mst@kernel.org> <CACGkMEsXYWzbDCRFyzk_RE8DW8w-OdquGRvygpujwFhNR8assw@mail.gmail.com>
In-Reply-To: <CACGkMEsXYWzbDCRFyzk_RE8DW8w-OdquGRvygpujwFhNR8assw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Jan 2026 14:13:35 +0100
X-Gm-Features: AZwV_QhTboCM5_xyMvgt7qrbrYMHgAgXKqtLaPjSrsBRA2JXw0lwOq405kt0gg8
Message-ID: <CAJaqyWeeoahJZ86uFXwMhuy-tuQuvhUxekLpRDUNEs_OdNx+ow@mail.gmail.com>
Subject: Re: [PATCH v12 09/13] vduse: take out allocations from vduse_dev_alloc_coherent
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tl7KWaM0Ao4wY0y4XmkbDpaLF9gmCMDXPP3i7gSz-80_1768482854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 12:59=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Thu, Jan 15, 2026 at 4:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, Jan 15, 2026 at 04:22:49PM +0800, Jason Wang wrote:
> > > On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > The function vduse_dev_alloc_coherent will be called under rwlock i=
n
> > > > next patches.  Make it out of the lock to avoid increasing its fail
> > > > rate.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > v12:
> > > > * Avoid free_pages_exact(NULL, size) in case vduse_domain_alloc_coh=
erent
> > > >   fails (MST).
> > > >
> > > > v11: Remove duplicated call to free_pages_exact (Jason).
> > > > ---
> > > >  drivers/vdpa/vdpa_user/iova_domain.c | 24 +++++++-----------------
> > > >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c   | 17 +++++++++++------
> > > >  3 files changed, 20 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vd=
pa_user/iova_domain.c
> > > > index 309cd5a039d1..0a9f668467a8 100644
> > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > @@ -493,17 +493,15 @@ void vduse_domain_unmap_page(struct vduse_iov=
a_domain *domain,
> > > >         vduse_domain_free_iova(iovad, dma_addr, size);
> > > >  }
> > > >
> > > > -void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain=
,
> > > > -                                 size_t size, dma_addr_t *dma_addr=
,
> > > > -                                 gfp_t flag)
> > > > +dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *d=
omain,
> > > > +                                      size_t size, void *orig)
> > > >  {
> > > >         struct iova_domain *iovad =3D &domain->consistent_iovad;
> > > >         unsigned long limit =3D domain->iova_limit;
> > > >         dma_addr_t iova =3D vduse_domain_alloc_iova(iovad, size, li=
mit);
> > > > -       void *orig =3D alloc_pages_exact(size, flag);
> > > >
> > > > -       if (!iova || !orig)
> > > > -               goto err;
> > > > +       if (!iova)
> > > > +               return DMA_MAPPING_ERROR;
> > > >
> > > >         spin_lock(&domain->iotlb_lock);
> > > >         if (vduse_iotlb_add_range(domain, (u64)iova, (u64)iova + si=
ze - 1,
> > > > @@ -514,17 +512,12 @@ void *vduse_domain_alloc_coherent(struct vdus=
e_iova_domain *domain,
> > > >         }
> > > >         spin_unlock(&domain->iotlb_lock);
> > > >
> > > > -       *dma_addr =3D iova;
> > > > +       return iova;
> > > >
> > > > -       return orig;
> > > >  err:
> > > > -       *dma_addr =3D DMA_MAPPING_ERROR;
> > > > -       if (orig)
> > > > -               free_pages_exact(orig, size);
> > > > -       if (iova)
> > > > -               vduse_domain_free_iova(iovad, iova, size);
> > > > +       vduse_domain_free_iova(iovad, iova, size);
> > > >
> > > > -       return NULL;
> > > > +       return DMA_MAPPING_ERROR;
> > > >  }
> > > >
> > > >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, =
size_t size,
> > > > @@ -533,7 +526,6 @@ void vduse_domain_free_coherent(struct vduse_io=
va_domain *domain, size_t size,
> > > >         struct iova_domain *iovad =3D &domain->consistent_iovad;
> > > >         struct vhost_iotlb_map *map;
> > > >         struct vdpa_map_file *map_file;
> > > > -       phys_addr_t pa;
> > > >
> > > >         spin_lock(&domain->iotlb_lock);
> > > >         map =3D vhost_iotlb_itree_first(domain->iotlb, (u64)dma_add=
r,
> > > > @@ -545,12 +537,10 @@ void vduse_domain_free_coherent(struct vduse_=
iova_domain *domain, size_t size,
> > > >         map_file =3D (struct vdpa_map_file *)map->opaque;
> > > >         fput(map_file->file);
> > > >         kfree(map_file);
> > > > -       pa =3D map->addr;
> > > >         vhost_iotlb_map_free(domain->iotlb, map);
> > > >         spin_unlock(&domain->iotlb_lock);
> > > >
> > > >         vduse_domain_free_iova(iovad, dma_addr, size);
> > > > -       free_pages_exact(phys_to_virt(pa), size);
> > > >  }
> > > >
> > > >  static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
> > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vd=
pa_user/iova_domain.h
> > > > index 081f06c52cdc..e50e55d1396f 100644
> > > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > > @@ -65,9 +65,8 @@ void vduse_domain_unmap_page(struct vduse_iova_do=
main *domain,
> > > >                              dma_addr_t dma_addr, size_t size,
> > > >                              enum dma_data_direction dir, unsigned =
long attrs);
> > > >
> > > > -void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain=
,
> > > > -                                 size_t size, dma_addr_t *dma_addr=
,
> > > > -                                 gfp_t flag);
> > > > +dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *d=
omain,
> > > > +                                      size_t size, void *orig);
> > > >
> > > >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, =
size_t size,
> > > >                                 dma_addr_t dma_addr, unsigned long =
attrs);
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 0e3cf5128ad0..6dba1f3224d9 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -916,23 +916,27 @@ static void *vduse_dev_alloc_coherent(union v=
irtio_map token, size_t size,
> > > >  {
> > > >         struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > > -       unsigned long iova;
> > > >         void *addr;
> > > >
> > > >         *dma_addr =3D DMA_MAPPING_ERROR;
> > > >         if (!token.group)
> > > >                 return NULL;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > -       addr =3D vduse_domain_alloc_coherent(domain, size,
> > > > -                                          (dma_addr_t *)&iova, fla=
g);
> > > > +       addr =3D alloc_pages_exact(size, flag);
> > > >         if (!addr)
> > > >                 return NULL;
> > > >
> > > > -       *dma_addr =3D (dma_addr_t)iova;
> > > > +       vdev =3D token.group->dev;
> > > > +       domain =3D vdev->domain;
> > > > +       *dma_addr =3D vduse_domain_alloc_coherent(domain, size, add=
r);
> > > > +       if (*dma_addr =3D=3D DMA_MAPPING_ERROR)
> > > > +               goto err;
> > > >
> > > >         return addr;
> > > > +
> > > > +err:
> > > > +       free_pages_exact(addr, size);
> > > > +       return NULL;
> > > >  }
> > >
> > > I think the code tries to hide the iova domain specific things (e.g
> > > mappings and DMA_MAPPING_ERROR) from vduse core. Could we find a way
> > > to stick to that?
> > >
> > > Thanks
> >
> >
> > what do you suggest more spefically though?
>
> I think it would be better to move the dma/map stuffs to the iova_domain.=
c
>

I'm not sure, DMA_MAPPING_ERROR was returned by parameter already
before this series and virtio_ring.c uses it in other functions too. I
guess we could divert more from the HW DMA and trust in return value
in virtion_ring.c conditionals checking if vring_use_dma_api, but I
think to include it here is trying to add too much to this series to
be honest.

Would that work to do it on top in the future?

> Thanks
>
> >
> > > >
> > > >  static void vduse_dev_free_coherent(union virtio_map token, size_t=
 size,
> > > > @@ -949,6 +953,7 @@ static void vduse_dev_free_coherent(union virti=
o_map token, size_t size,
> > > >         domain =3D vdev->domain;
> > > >
> > > >         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> > > > +       free_pages_exact(vaddr, size);
> > > >  }
> > > >
> > > >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t=
 dma_addr)
> > > > --
> > > > 2.52.0
> > > >
> >
>

