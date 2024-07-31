Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3617C79
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722398310; cv=none; b=MJ3TKhK68+OZxWz+yCnwVkRblONeCxFWrICWs1uAQRmDxA/CWqjKwcv8uWkY+xGyloJts7c1xL9OvAhJNxRelxkb2hPA/CVOZNDZ++vk2DvCfM8exI22lqANNQKyxhrEwBVm0duH7TISjouyHYJyqrb2bL+kvcKw3Onvd8med/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722398310; c=relaxed/simple;
	bh=7B7UTu3WeJgt4pD/2w9ZT3P3AVdE+l+g1il5cQnQ55o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlKSwAvFDINyZZj56M/a10GrxmfpKF6EleHjU1UieJJLzTrhrXue/leVs1wBVNYUqwa/gpA9fjEf8M4IFvEItWUIHQnpoKrDY1avbAlUF8Xo2ij4qYb7V/yWZL7PxJUYg6++zbfwRfvsTJwi1aEXmmeJSDP04hCmJhxi2WxtrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUqcFTJh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUqcFTJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722398306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vi79FakOmaGwzJiCvfN9dMzgsqZ/xgzfCFxHakMewQk=;
	b=gUqcFTJhOUK1MxWAMNvMdiDRWV4vkCJnRhYV5hOeMXGu7/IPjK4xQplL1eM5NpgIMBgZcH
	zLGtHE/f9shMy3QE26fsF/Ku8JK6AsRIaG/nH73suF8e6akB+VCYRp4nL0dhp0nvxOzcdp
	U8Jd3kzCggtyiG9YMuyGeg1+9N9Sk2U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-uTO0fot0OG2HogAg1j05Yg-1; Tue, 30 Jul 2024 23:58:22 -0400
X-MC-Unique: uTO0fot0OG2HogAg1j05Yg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb4bcd9671so7264947a91.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 20:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722398301; x=1723003101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi79FakOmaGwzJiCvfN9dMzgsqZ/xgzfCFxHakMewQk=;
        b=Zpu/luLxm5vQ9X6sqargirBJe8j/LptB5ht7OR5WAc5nr5jbCPgMABdcZL0wn0aeGl
         WbHsB8MIlkXE+b0aX2vlfeNV/sh7JXodoWS0XgLQuIv+JyzOvj41wTWvnna/vUElQo1o
         nA3eqUXu3rtJkKmARrf1Kan35cF4WxE2gyGHlSd3TqI5kTkYQNycCvDNymTrHkXsCi/V
         A7Sy55X3AVGLaPdZN7jCS9PqnroVnzEYNO2ajCdBbeRl3LJHOXZNABKsga0vP8niSyn8
         zIcSTdQuWrLyPbU2rGK09S8Let8u41sgWHkPozFbG3OigdJvKnVxXZTN+5/3cf2v2a/G
         Yl7w==
X-Forwarded-Encrypted: i=1; AJvYcCVatPHUVubVByGfmvpeAcWeNlZNjeObL9Nz2MOM5aJzv+bqKInBapfJ/SFzF602WrRSzjQLf0hH7pMUwQymXeJDVnbbgQOS8g9XkArrtb8=
X-Gm-Message-State: AOJu0YysqOkLf0vq7a41yUMuCNREdz7RgDTedTj4aIH74p6eDt85e2Bt
	gRlbUInsQ0FYvJjR6AYk5rWPBNYRGqkRXnG+Uf39/oQbGbJnI+fcKLN1YRLpUAgXYUjGgje18Rb
	oL3NCSG3eqfedQ2bTAutncfnZOAfE9F/vIenX14cnGtmBCzdu/fB5r2cMSe4jg6AmUP5+EHqMgC
	2mmnNJL9972k0XU5tBjKxZqG7Szji6qbQtpf1v/iQ=
X-Received: by 2002:a17:90a:a411:b0:2cb:3306:b2cc with SMTP id 98e67ed59e1d1-2cf7e19e197mr15653520a91.1.1722398301068;
        Tue, 30 Jul 2024 20:58:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVgnyGi+k0636c/0aO8rPRZzfZMMFmp0fVj/pXyBVQgNUFIT7NYlm5KokNpBngX2C8OF6GrULIQ+CoSKtgXwQ=
X-Received: by 2002:a17:90a:a411:b0:2cb:3306:b2cc with SMTP id
 98e67ed59e1d1-2cf7e19e197mr15653491a91.1.1722398300545; Tue, 30 Jul 2024
 20:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com> <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
In-Reply-To: <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:58:08 +0800
Message-ID: <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	lstoakes@gmail.com, mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:15=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Wed, Jul 31, 2024 at 11:10=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Wed, Jul 31, 2024 at 8:03=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > loop within non-sleepable contexts.
> > >
> > > static inline struct page *
> > > __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > >                                                 struct alloc_context =
*ac)
> > > {
> > >         ...
> > >         /*
> > >          * Make sure that __GFP_NOFAIL request doesn't leak out and m=
ake sure
> > >          * we always retry
> > >          */
> > >         if (gfp_mask & __GFP_NOFAIL) {
> > >                 /*
> > >                  * All existing users of the __GFP_NOFAIL are blockab=
le, so warn
> > >                  * of any new users that actually require GFP_NOWAIT
> > >                  */
> > >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > >                         goto fail;
> > >                 ...
> > >         }
> > >         ...
> > > fail:
> > >         warn_alloc(gfp_mask, ac->nodemask,
> > >                         "page allocation failure: order:%u", order);
> > > got_pg:
> > >         return page;
> > > }
> > >
> > > Let's move the memory allocation out of the atomic context and use
> > > the normal sleepable context to get pages.
> > >
> > > [RFT]: This has only been compile-tested; I'd prefer if the VDPA main=
tainers
> > > handles it.
> > >
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/iova_domain.c | 31 +++++++++++++++++++++++---=
--
> > >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
> > >  drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
> > >  3 files changed, 33 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa=
_user/iova_domain.c
> > > index 791d38d6284c..9318f059a8b5 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > @@ -283,7 +283,23 @@ int vduse_domain_add_user_bounce_pages(struct vd=
use_iova_domain *domain,
> > >         return ret;
> > >  }
> > >
> > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain =
*domain)
> > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vduse=
_iova_domain *domain)
> > > +{
> > > +       struct page **pages;
> > > +       unsigned long count, i;
> > > +
> > > +       if (!domain->user_bounce_pages)
> > > +               return NULL;
> > > +
> > > +       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > +       pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | _=
_GFP_NOFAIL);
> > > +       for (i =3D 0; i < count; i++)
> > > +               pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> > > +
> > > +       return pages;
> > > +}
> > > +
> > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain =
*domain, struct page **pages)
> > >  {
> > >         struct vduse_bounce_map *map;
> > >         unsigned long i, count;
> > > @@ -294,15 +310,16 @@ void vduse_domain_remove_user_bounce_pages(stru=
ct vduse_iova_domain *domain)
> > >
> > >         count =3D domain->bounce_size >> PAGE_SHIFT;
> > >         for (i =3D 0; i < count; i++) {
> > > -               struct page *page =3D NULL;
> > > +               struct page *page =3D pages[i];
> > >
> > >                 map =3D &domain->bounce_maps[i];
> > > -               if (WARN_ON(!map->bounce_page))
> > > +               if (WARN_ON(!map->bounce_page)) {
> > > +                       put_page(page);
> > >                         continue;
> > > +               }
> > >
> > >                 /* Copy user page to kernel page if it's in use */
> > >                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > > -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL=
);
> > >                         memcpy_from_page(page_address(page),
> > >                                          map->bounce_page, 0, PAGE_SI=
ZE);
> > >                 }
> > > @@ -310,6 +327,7 @@ void vduse_domain_remove_user_bounce_pages(struct=
 vduse_iova_domain *domain)
> > >                 map->bounce_page =3D page;
> > >         }
> > >         domain->user_bounce_pages =3D false;
> > > +       kfree(pages);
> > >  out:
> > >         write_unlock(&domain->bounce_lock);
> > >  }
> > > @@ -543,10 +561,13 @@ static int vduse_domain_mmap(struct file *file,=
 struct vm_area_struct *vma)
> > >  static int vduse_domain_release(struct inode *inode, struct file *fi=
le)
> > >  {
> > >         struct vduse_iova_domain *domain =3D file->private_data;
> > > +       struct page **pages;
> > > +
> > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(domain);
> > >
> > >         spin_lock(&domain->iotlb_lock);
> > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > >         vduse_domain_free_kernel_bounce_pages(domain);
> > >         spin_unlock(&domain->iotlb_lock);
> > >         put_iova_domain(&domain->stream_iovad);
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa=
_user/iova_domain.h
> > > index f92f22a7267d..17efa5555b3f 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > @@ -74,7 +74,10 @@ void vduse_domain_reset_bounce_map(struct vduse_io=
va_domain *domain);
> > >  int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *dom=
ain,
> > >                                        struct page **pages, int count=
);
> > >
> > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain =
*domain);
> > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain =
*domain,
> > > +                                          struct page **pages);
> > > +
> > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vduse=
_iova_domain *domain);
> > >
> > >  void vduse_domain_destroy(struct vduse_iova_domain *domain);
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 7ae99691efdf..5d8d5810df57 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1030,6 +1030,7 @@ static int vduse_dev_queue_irq_work(struct vdus=
e_dev *dev,
> > >  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > >                                 u64 iova, u64 size)
> > >  {
> > > +       struct page **pages;
> > >         int ret;
> > >
> > >         mutex_lock(&dev->mem_lock);
> > > @@ -1044,7 +1045,8 @@ static int vduse_dev_dereg_umem(struct vduse_de=
v *dev,
> > >         if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounc=
e_size)
> > >                 goto unlock;
> > >
> > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(dev->doma=
in);
> > > +       vduse_domain_remove_user_bounce_pages(dev->domain, pages);
> > >         unpin_user_pages_dirty_lock(dev->umem->pages,
> > >                                     dev->umem->npages, true);
> > >         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> >
> > We miss a kfree(pages); here?
> no.
> i've moved it into vduse_domain_remove_user_bounce_pages.

Ok, but it seems tricky e.g allocated by the caller but freed in
callee. And I think I missed some important issues in the previous
review: The check of user_bounce_pages must be done under the
bounce_lock, otherwise it might race with umem_reg.

So in the case of release(), we know the device is gone, so there's no
need to allocate pages that will be released soon. So we can pass NULL
as a hint and just assign bounce_page to NULL in
vduse_domain_remove_user_bounce_pages().

And in the case of vduse_dev_dereg_umem(), we need to allocate the
pages without checking user_bounce_pages. So in
vduse_domain_remove_user_bounce_pages() if we can free the allocated
pages as well as the pages in the following check

        if (!domain->user_bounce_pages)
                goto out;

What do you think?

Thanks

>
> >
> > Thanks
> >
> > > --
> > > 2.34.1
> > >
> >
>

