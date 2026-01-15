Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EA3803DA
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478355; cv=none; b=HLulhFdCVgrgmpFNMrGmZuLC/8VwWX/RlLrWKeLeL5WCMlK/EROpoIlcC+CHPiMSocMiZlJJwJMUQn729zWvu+EzqgEjE1i0xe8M2Tv0xs3A6hTRKzG9rxzcJlKGHxb/+KQeqgLH+LzDWT6uLPP6yPj1EzGXM15PmBDzgK/pfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478355; c=relaxed/simple;
	bh=F2WmHd8QrT1gknqNw82luqFbhY8K+cHfX+f9XHoX2k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQUJaJk7HRUYhmnCN2Niubgs0nXp7YqmWgr7kQ8a+2h0/OvCUs6TKxNC6DyNSwJp/usmSrXXCpfa7LncbQAxuYc8pXXfPspdgj8/xKCjBCxxJyVPY7n/UzeIECl3rJ5LctGyAmuHzdMIy3CvHABnhJL7o1Ne8iBlcWqqgJI6R5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4abnQDf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4abnQDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768478353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPd5IjJNB7E4U3GGdHOkSqhEIkc//rZU4fXUUPcRRmI=;
	b=h4abnQDf5h2mTYi5INXOFOI+pYpIdke0QUIktaDlDWdxab4WoSYtvMDGE4c+sD4UdBrCyg
	padTCKRKqabstWJ+J2drGXbGsqxVJB+qk/d6eD5ZVeq1IANQjhE/zB6l2pxzuPHB1O+Jbk
	xkvtaFWVahF2U3rWo3xAWLmkJR9z+FQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-x1v4okRaOH2f6ihX2PW5mQ-1; Thu, 15 Jan 2026 06:59:10 -0500
X-MC-Unique: x1v4okRaOH2f6ihX2PW5mQ-1
X-Mimecast-MFC-AGG-ID: x1v4okRaOH2f6ihX2PW5mQ_1768478349
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c21341f56so1625113a91.2
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 03:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768478349; x=1769083149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPd5IjJNB7E4U3GGdHOkSqhEIkc//rZU4fXUUPcRRmI=;
        b=a3XufwOT5wl1UvNU8Y/MuP85ZWld8E70htRMWcsqxAbY/IwnQ593rDGP9AhSjk1chY
         FoXcxnL7uP3tC6qlTbqkA7FXeHseAe3v0BgI+ahLVWOmvFlm6sus1smKsevQrwhhoRuM
         Zr3bj6EkFa+yNLe+glWQwKAIVEaDAlRFPRVSc0t6IAM7UjjJY6qAoTCToqrVqnLueGDf
         3/om9VDCUHp6Cogq3qW78JikTcVr1+gfSkXL2+RbCOdjksKzWR1Rnr/rCV6YJBls1Sks
         RLOsokXxtQSQyHSDvxmamkb/Nac8qSvXeKFcSXVmnR+eFnhD6aUlmrTEeFf4iR4I52bp
         6YBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZb5LJQ/lBAGYEBrvWI4+bOZUenPKWbWuh8DiTENx0SniQWDJ0ZZ7/vOBUfjp32uneKSxSvNOs28A+karaow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPQ+PjtsX4UEo47HmKOt0X8rZSti3T4sUvFxmU0/r6FZK5Gble
	kvsTAT5IPHAIAGQhtmvDTEWwSN+hwc4RuIiaKWqjvDNj48C5BR5baXTo0Mk9sKs4R9Pch6SMbtr
	PzQ9BE12LgN3ikcc1BUccA3Ku169o63INpVMqf1AzknIyLbglsFfNn9Qs/zokjlCGWWFFIk2fcz
	pV9sKLyODMIXNx0guGUgjw7pBynBrJfMJG30yLO3ASdkw=
X-Gm-Gg: AY/fxX5UN5fVsEKgxBbMlLR5Ipa5sqfJzSu+ii6zT/VIydOmYQAnBApSc2pv1WzKfer
	m/UZJ52V7wV+2QUvDRN3mmWhg3E1F8n/3Cnac+R1zY3Fqdwlzvz0Iwq8qRQv7kyunOcFMcshTrq
	nrNnulNzTuQOtStFmQd2zmVcTmmzhaBYiqOv8IuEov1UCkw0YwJOT5V0ZbcYwb6ZRNkQA=
X-Received: by 2002:a17:90b:1d0e:b0:34a:48ff:694 with SMTP id 98e67ed59e1d1-35109137fd5mr6275959a91.31.1768478348957;
        Thu, 15 Jan 2026 03:59:08 -0800 (PST)
X-Received: by 2002:a17:90b:1d0e:b0:34a:48ff:694 with SMTP id
 98e67ed59e1d1-35109137fd5mr6275942a91.31.1768478348560; Thu, 15 Jan 2026
 03:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-10-eperezma@redhat.com>
 <CACGkMEuMsz8ao0btTixZ=Lh7GadyxdOtu4HQeF=c7=TTirmV+A@mail.gmail.com> <20260115034348-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260115034348-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Jan 2026 19:58:57 +0800
X-Gm-Features: AZwV_Qiwm1xL9PoCWy5VzcpVaPgalay5JakbGHlw1pbMqU0s_B3x4rEe24rtHxo
Message-ID: <CACGkMEsXYWzbDCRFyzk_RE8DW8w-OdquGRvygpujwFhNR8assw@mail.gmail.com>
Subject: Re: [PATCH v12 09/13] vduse: take out allocations from vduse_dev_alloc_coherent
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nphOXl-e7jE2S8sbXVblYvZ_mBtNDUZWowXR0p6SbkE_1768478349
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 4:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jan 15, 2026 at 04:22:49PM +0800, Jason Wang wrote:
> > On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > The function vduse_dev_alloc_coherent will be called under rwlock in
> > > next patches.  Make it out of the lock to avoid increasing its fail
> > > rate.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v12:
> > > * Avoid free_pages_exact(NULL, size) in case vduse_domain_alloc_coher=
ent
> > >   fails (MST).
> > >
> > > v11: Remove duplicated call to free_pages_exact (Jason).
> > > ---
> > >  drivers/vdpa/vdpa_user/iova_domain.c | 24 +++++++-----------------
> > >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c   | 17 +++++++++++------
> > >  3 files changed, 20 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa=
_user/iova_domain.c
> > > index 309cd5a039d1..0a9f668467a8 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > @@ -493,17 +493,15 @@ void vduse_domain_unmap_page(struct vduse_iova_=
domain *domain,
> > >         vduse_domain_free_iova(iovad, dma_addr, size);
> > >  }
> > >
> > > -void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > > -                                 size_t size, dma_addr_t *dma_addr,
> > > -                                 gfp_t flag)
> > > +dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *dom=
ain,
> > > +                                      size_t size, void *orig)
> > >  {
> > >         struct iova_domain *iovad =3D &domain->consistent_iovad;
> > >         unsigned long limit =3D domain->iova_limit;
> > >         dma_addr_t iova =3D vduse_domain_alloc_iova(iovad, size, limi=
t);
> > > -       void *orig =3D alloc_pages_exact(size, flag);
> > >
> > > -       if (!iova || !orig)
> > > -               goto err;
> > > +       if (!iova)
> > > +               return DMA_MAPPING_ERROR;
> > >
> > >         spin_lock(&domain->iotlb_lock);
> > >         if (vduse_iotlb_add_range(domain, (u64)iova, (u64)iova + size=
 - 1,
> > > @@ -514,17 +512,12 @@ void *vduse_domain_alloc_coherent(struct vduse_=
iova_domain *domain,
> > >         }
> > >         spin_unlock(&domain->iotlb_lock);
> > >
> > > -       *dma_addr =3D iova;
> > > +       return iova;
> > >
> > > -       return orig;
> > >  err:
> > > -       *dma_addr =3D DMA_MAPPING_ERROR;
> > > -       if (orig)
> > > -               free_pages_exact(orig, size);
> > > -       if (iova)
> > > -               vduse_domain_free_iova(iovad, iova, size);
> > > +       vduse_domain_free_iova(iovad, iova, size);
> > >
> > > -       return NULL;
> > > +       return DMA_MAPPING_ERROR;
> > >  }
> > >
> > >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, si=
ze_t size,
> > > @@ -533,7 +526,6 @@ void vduse_domain_free_coherent(struct vduse_iova=
_domain *domain, size_t size,
> > >         struct iova_domain *iovad =3D &domain->consistent_iovad;
> > >         struct vhost_iotlb_map *map;
> > >         struct vdpa_map_file *map_file;
> > > -       phys_addr_t pa;
> > >
> > >         spin_lock(&domain->iotlb_lock);
> > >         map =3D vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
> > > @@ -545,12 +537,10 @@ void vduse_domain_free_coherent(struct vduse_io=
va_domain *domain, size_t size,
> > >         map_file =3D (struct vdpa_map_file *)map->opaque;
> > >         fput(map_file->file);
> > >         kfree(map_file);
> > > -       pa =3D map->addr;
> > >         vhost_iotlb_map_free(domain->iotlb, map);
> > >         spin_unlock(&domain->iotlb_lock);
> > >
> > >         vduse_domain_free_iova(iovad, dma_addr, size);
> > > -       free_pages_exact(phys_to_virt(pa), size);
> > >  }
> > >
> > >  static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa=
_user/iova_domain.h
> > > index 081f06c52cdc..e50e55d1396f 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > @@ -65,9 +65,8 @@ void vduse_domain_unmap_page(struct vduse_iova_doma=
in *domain,
> > >                              dma_addr_t dma_addr, size_t size,
> > >                              enum dma_data_direction dir, unsigned lo=
ng attrs);
> > >
> > > -void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > > -                                 size_t size, dma_addr_t *dma_addr,
> > > -                                 gfp_t flag);
> > > +dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *dom=
ain,
> > > +                                      size_t size, void *orig);
> > >
> > >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, si=
ze_t size,
> > >                                 dma_addr_t dma_addr, unsigned long at=
trs);
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 0e3cf5128ad0..6dba1f3224d9 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -916,23 +916,27 @@ static void *vduse_dev_alloc_coherent(union vir=
tio_map token, size_t size,
> > >  {
> > >         struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > > -       unsigned long iova;
> > >         void *addr;
> > >
> > >         *dma_addr =3D DMA_MAPPING_ERROR;
> > >         if (!token.group)
> > >                 return NULL;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -       addr =3D vduse_domain_alloc_coherent(domain, size,
> > > -                                          (dma_addr_t *)&iova, flag)=
;
> > > +       addr =3D alloc_pages_exact(size, flag);
> > >         if (!addr)
> > >                 return NULL;
> > >
> > > -       *dma_addr =3D (dma_addr_t)iova;
> > > +       vdev =3D token.group->dev;
> > > +       domain =3D vdev->domain;
> > > +       *dma_addr =3D vduse_domain_alloc_coherent(domain, size, addr)=
;
> > > +       if (*dma_addr =3D=3D DMA_MAPPING_ERROR)
> > > +               goto err;
> > >
> > >         return addr;
> > > +
> > > +err:
> > > +       free_pages_exact(addr, size);
> > > +       return NULL;
> > >  }
> >
> > I think the code tries to hide the iova domain specific things (e.g
> > mappings and DMA_MAPPING_ERROR) from vduse core. Could we find a way
> > to stick to that?
> >
> > Thanks
>
>
> what do you suggest more spefically though?

I think it would be better to move the dma/map stuffs to the iova_domain.c

Thanks

>
> > >
> > >  static void vduse_dev_free_coherent(union virtio_map token, size_t s=
ize,
> > > @@ -949,6 +953,7 @@ static void vduse_dev_free_coherent(union virtio_=
map token, size_t size,
> > >         domain =3D vdev->domain;
> > >
> > >         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> > > +       free_pages_exact(vaddr, size);
> > >  }
> > >
> > >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t d=
ma_addr)
> > > --
> > > 2.52.0
> > >
>

