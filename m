Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD21D53F
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395723; cv=none; b=bHj3nILWzaH2z/d1Azqo4dT08nn8XvvemBXebx9G+/pKyW+L2/Zq/8EG4z60ghZPh/EpiaWHonW2NNLNrv5UniVg+7VrWFobvMOIMpop8wNfp4ft0FA+C7hJAGNyjRRRpNVPREXPCupdGgeTJD6sRwjQarJmfJaBhg6wsccLZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395723; c=relaxed/simple;
	bh=CyxLHWy5Cs16QVe4onKIh1Q+S3/HxFBZ8SGj989k/6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDqh5r6IJheHXXGoLSi96uAUmMxcyvMuWIBmorBKmJ3erLQjNN9JJ6uNX5Gfus+0wfe9fqZ1HqngIQG7h1KhTFXGwzRkSPN4Vzu86UXKa5RtV5HeOdCXfD/qUIg3AytcTbx6NCKGpZzKCEtkOc65j6Bg0vLvo+mDOv3IHtWstGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo5/6Upq; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo5/6Upq"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-821eab936d6so1274772241.3
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 20:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722395720; x=1723000520; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggbJOz4fatqxCDnDaH2v6qBI6yak8UftyOVEx66FRBM=;
        b=Mo5/6UpqK+3fz384eWPgY5wLBzP9+UC+GpZdbLBx9Sq+IE5IrkZTscAZh4Lw1el+7m
         BcP85K++JH2Ggx8ioYC3dNqjEQQGGQJ9KqxsGT8fxZYe8fagC/GxPQ1pJiFeex2fCihz
         77HuxulR/hfq4Q3pi+NQFi9mCG4QC/Hyu3w2RfB33Q2iTdWrwk5WOKGBspsp7jVsqhD6
         qvKAJUN1rVTiClTMMWy/lL3L1XK82RCwlycC9DW2hqtTm2FAP1Lnch/B5Dyq0aP4qTev
         axEBE71iehd7NknKyM6xI7LbyQM/UaKQuhaSA7sOdeUWNJxXm/8GQ9HT3Z3BmQ+1LZ4w
         8NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395720; x=1723000520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggbJOz4fatqxCDnDaH2v6qBI6yak8UftyOVEx66FRBM=;
        b=Ew776IuGDZv1pBoD9o86oM/y+PCJ4KgKCo6QYeqrOO2A+n3KYOUlo5PsLcY/nx83KB
         tJBusX9EvQDsihWWXT46CmCjyiTjrbGZHSkqjQrAq7/npHfAYAAYYO2R00oilqi3nHH5
         9WtiVcLbDXSeGdu59S2uUEgi2wQehMmmDExODWgtKLtXKeM7EPoW1Foq/6ZTLlpaVA7c
         zVfLG5WzJezFG8GHDlmZ31qnFojw5nY8QyagV8E6tlYSNr2DOiW2mDSYb2OtXdSKKguc
         jEcRjrGJ7VlvOX+afH6RbpTHfdWx3LHOpH6k5NydE3Yr+cbvq2ZzDM2QhvgGc7Fbv5RQ
         j/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVkWo04b6s0QPLMhdqBL+IpjMTw1neV0RpkoGOyqkxC77SOttMQyMQh0j4G84NI7I+f+5FByBLvHtt7jjHwY5tvRinwadh2f8E32TPwb7A=
X-Gm-Message-State: AOJu0YwKmTNVsrVVuA1QgF2AuIQ0NGuFXQZH8WMEBKIn7hpcuxz1a3C9
	ylOVaJbFH8iYnWmJpsYgy6vwuOKkIIVQu/3j7r07nwyONlTxEfiIUAq353DcWJDLtmdQH23bzzF
	h4+2q/kgpEMSaXY8VRx9uA7m0RtqNVNNR2Xw=
X-Google-Smtp-Source: AGHT+IFR0pUOPqmpICJoMa62JMkVa0b9TxNVpTC5kz22S3LAfVarPFVe6nXW3RQIFbx2oUayXsgys0jA2FwfTzmg6ug=
X-Received: by 2002:a05:6102:3f0e:b0:493:e585:6ce3 with SMTP id
 ada2fe7eead31-493fadd965emr14448595137.31.1722395720249; Tue, 30 Jul 2024
 20:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
In-Reply-To: <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 11:15:07 +0800
Message-ID: <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	lstoakes@gmail.com, mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:10=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Jul 31, 2024 at 8:03=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> >
> > static inline struct page *
> > __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >                                                 struct alloc_context *a=
c)
> > {
> >         ...
> >         /*
> >          * Make sure that __GFP_NOFAIL request doesn't leak out and mak=
e sure
> >          * we always retry
> >          */
> >         if (gfp_mask & __GFP_NOFAIL) {
> >                 /*
> >                  * All existing users of the __GFP_NOFAIL are blockable=
, so warn
> >                  * of any new users that actually require GFP_NOWAIT
> >                  */
> >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> >                         goto fail;
> >                 ...
> >         }
> >         ...
> > fail:
> >         warn_alloc(gfp_mask, ac->nodemask,
> >                         "page allocation failure: order:%u", order);
> > got_pg:
> >         return page;
> > }
> >
> > Let's move the memory allocation out of the atomic context and use
> > the normal sleepable context to get pages.
> >
> > [RFT]: This has only been compile-tested; I'd prefer if the VDPA mainta=
iners
> > handles it.
> >
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  drivers/vdpa/vdpa_user/iova_domain.c | 31 +++++++++++++++++++++++-----
> >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
> >  drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
> >  3 files changed, 33 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 791d38d6284c..9318f059a8b5 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -283,7 +283,23 @@ int vduse_domain_add_user_bounce_pages(struct vdus=
e_iova_domain *domain,
> >         return ret;
> >  }
> >
> > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *d=
omain)
> > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vduse_i=
ova_domain *domain)
> > +{
> > +       struct page **pages;
> > +       unsigned long count, i;
> > +
> > +       if (!domain->user_bounce_pages)
> > +               return NULL;
> > +
> > +       count =3D domain->bounce_size >> PAGE_SHIFT;
> > +       pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __G=
FP_NOFAIL);
> > +       for (i =3D 0; i < count; i++)
> > +               pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> > +
> > +       return pages;
> > +}
> > +
> > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *d=
omain, struct page **pages)
> >  {
> >         struct vduse_bounce_map *map;
> >         unsigned long i, count;
> > @@ -294,15 +310,16 @@ void vduse_domain_remove_user_bounce_pages(struct=
 vduse_iova_domain *domain)
> >
> >         count =3D domain->bounce_size >> PAGE_SHIFT;
> >         for (i =3D 0; i < count; i++) {
> > -               struct page *page =3D NULL;
> > +               struct page *page =3D pages[i];
> >
> >                 map =3D &domain->bounce_maps[i];
> > -               if (WARN_ON(!map->bounce_page))
> > +               if (WARN_ON(!map->bounce_page)) {
> > +                       put_page(page);
> >                         continue;
> > +               }
> >
> >                 /* Copy user page to kernel page if it's in use */
> >                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> >                         memcpy_from_page(page_address(page),
> >                                          map->bounce_page, 0, PAGE_SIZE=
);
> >                 }
> > @@ -310,6 +327,7 @@ void vduse_domain_remove_user_bounce_pages(struct v=
duse_iova_domain *domain)
> >                 map->bounce_page =3D page;
> >         }
> >         domain->user_bounce_pages =3D false;
> > +       kfree(pages);
> >  out:
> >         write_unlock(&domain->bounce_lock);
> >  }
> > @@ -543,10 +561,13 @@ static int vduse_domain_mmap(struct file *file, s=
truct vm_area_struct *vma)
> >  static int vduse_domain_release(struct inode *inode, struct file *file=
)
> >  {
> >         struct vduse_iova_domain *domain =3D file->private_data;
> > +       struct page **pages;
> > +
> > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(domain);
> >
> >         spin_lock(&domain->iotlb_lock);
> >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > -       vduse_domain_remove_user_bounce_pages(domain);
> > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> >         vduse_domain_free_kernel_bounce_pages(domain);
> >         spin_unlock(&domain->iotlb_lock);
> >         put_iova_domain(&domain->stream_iovad);
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_u=
ser/iova_domain.h
> > index f92f22a7267d..17efa5555b3f 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -74,7 +74,10 @@ void vduse_domain_reset_bounce_map(struct vduse_iova=
_domain *domain);
> >  int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domai=
n,
> >                                        struct page **pages, int count);
> >
> > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *d=
omain);
> > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *d=
omain,
> > +                                          struct page **pages);
> > +
> > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vduse_i=
ova_domain *domain);
> >
> >  void vduse_domain_destroy(struct vduse_iova_domain *domain);
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 7ae99691efdf..5d8d5810df57 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1030,6 +1030,7 @@ static int vduse_dev_queue_irq_work(struct vduse_=
dev *dev,
> >  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> >                                 u64 iova, u64 size)
> >  {
> > +       struct page **pages;
> >         int ret;
> >
> >         mutex_lock(&dev->mem_lock);
> > @@ -1044,7 +1045,8 @@ static int vduse_dev_dereg_umem(struct vduse_dev =
*dev,
> >         if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_=
size)
> >                 goto unlock;
> >
> > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(dev->domain=
);
> > +       vduse_domain_remove_user_bounce_pages(dev->domain, pages);
> >         unpin_user_pages_dirty_lock(dev->umem->pages,
> >                                     dev->umem->npages, true);
> >         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
>
> We miss a kfree(pages); here?
no.
i've moved it into vduse_domain_remove_user_bounce_pages.

>
> Thanks
>
> > --
> > 2.34.1
> >
>
