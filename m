Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5327FBD1
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722307742; cv=none; b=L1ZlDFrQ8vWhQA52rTEEsmAKgmAwZEaUrImjo+dCJ+WwVBoHj4PztFvINWEeBBHRn5pxLsiLfE5wUI5Im/btMPqxfjfeb0TYL8ORoh/EqbkVO2Yf98mK2tPosNqf4xv2m732wZ/gQwCpk8vAyFr75ApN1sGH7hr7T01fZgoIW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722307742; c=relaxed/simple;
	bh=CN4oBLV7oPPC0x0IBPU4jZj3bve7Ad4RaWjSPS36orI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKXhlNi3Rramf04XdbzYtkRafxypK8hpvSkUfRBiVshNN+39wC5FMTtweRDhX9CRTPMgp9RWVtcc5XIt2qYz8SIUqnCGw85SxxVmbHeXnGYcM7EIgURp66s9jIZwlIgQJqtJyzz8/aDKiajtDFC2guODfn6f9Zw1l8jcxyVSQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDaYzMVA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDaYzMVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722307739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iODY1leMHYWVIGb4Xzg4M+NjPzry465TvBbXtmSDHsA=;
	b=JDaYzMVAJRW7VFEAGUtUdaGsyivf0IE0K9h+7lw5KD0oQe8UAoLrJmwHTANUkrPRTLyg/J
	iY+nCETRhlSWTmjQPLZksx1OhX7N5/+JKkfwAMeuVJsTsJ1cpT7TUX7GX9zJK2nNu7+F8b
	KnWemWxBdRi3cAU0eOc0zHizEsBCMdQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-A5fjQoksMbWBbhOm9FD8xA-1; Mon, 29 Jul 2024 22:48:54 -0400
X-MC-Unique: A5fjQoksMbWBbhOm9FD8xA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7a28217cfecso4357552a12.2
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 19:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722307733; x=1722912533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iODY1leMHYWVIGb4Xzg4M+NjPzry465TvBbXtmSDHsA=;
        b=ZBiolFv90m5NPEIEwYv2B2bzeWf5lm4GNzayqVJWf4r5GyMMOaON00o0fFF/cDLDVG
         k8/woO6CQ+odM9pRxb30uYrPsJBa6wqM2OqG7AHvB15MjE7UZ7dRODkWHBrd7+8fCw1D
         Mso0fvyTc6txznfpKRCVTcbvInIlG6MVvXygEj0FBrsHnXyhKhJtHaeXMc2eRLnMTLfN
         /+pUHYC/bGOjTMsXpGyz5a2/yHS0gtsODzilNJFTY3fKLy4Nyxidh8RVUnWDCPUolJs9
         3iYCkgNogga6ysNB1e6bISmmwfkYGnpJJ4sfaSCkgQ7Oxdj/PfnIK8Addzfk2KURNCaq
         iuKg==
X-Forwarded-Encrypted: i=1; AJvYcCVE8MOb2C/VtayWvJvAODveoAdsuTHPvC7BGWlvwOJmCg+Y8RkBZN6HnbfXzjkkBF0MoejQA3LZykVAj0VQUXqVuhpuqE0eid7DcJ7QxME=
X-Gm-Message-State: AOJu0YzjWXyxpHAUl14agTaRb6Sv0MynX4c8q94xvqvZ6pnyFmXl5LbR
	3f+IpJmCvsUYXaC3sKKLenttcGIPTy8LWY60IzY1FEKjJSueTFQPAqGTv6ifC13Qi7a6hzHJOPG
	Ykx+hxO4++snoSuBfAWihRk7IYqT4+tsiJpTmvMX3i2kMfgrRLqfckXWnm6lnGw6NePY7zCGWPg
	XKhm2XHPDsPyCmTrjfXaP5GpvsHKRvmfGOrx84sJk=
X-Received: by 2002:a05:6a20:1125:b0:1bd:a048:7fcc with SMTP id adf61e73a8af0-1c4a14f9962mr8765568637.46.1722307733623;
        Mon, 29 Jul 2024 19:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGhehkFOKLNQ5aUQSJXM+7gJWaTZq73T0ej7zgx3l+6K5YfYEu7MXBzJ5Lmk1/6eevl5afbwOPhT0m2bXmcTM=
X-Received: by 2002:a05:6a20:1125:b0:1bd:a048:7fcc with SMTP id
 adf61e73a8af0-1c4a14f9962mr8765538637.46.1722307733089; Mon, 29 Jul 2024
 19:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACGkMEs49KckODWSpe7VPfTeshogni0_eOdkMO0b7zW2A5YX2w@mail.gmail.com>
 <20240729060529.93243-1-21cnbao@gmail.com>
In-Reply-To: <20240729060529.93243-1-21cnbao@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 10:48:40 +0800
Message-ID: <CACGkMEuv4M_NaUQPHH59MPevGoJJoYb70LykcCODD=nUvik3ZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com, 
	eperezma@redhat.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, linux-mm@kvack.org, lstoakes@gmail.com, 
	maxime.coquelin@redhat.com, mhocko@suse.com, mst@redhat.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, 
	torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:05=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Jul 29, 2024 at 3:42=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Jul 25, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Thu, Jul 25, 2024 at 6:08=E2=80=AFPM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Thu 25-07-24 10:50:45, Barry Song wrote:
> > > > > On Thu, Jul 25, 2024 at 12:27=E2=80=AFAM Michal Hocko <mhocko@sus=
e.com> wrote:
> > > > > >
> > > > > > On Wed 24-07-24 20:55:40, Barry Song wrote:
> > > > [...]
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/v=
dpa/vdpa_user/iova_domain.c
> > > > > > > index 791d38d6284c..eff700e5f7a2 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > > @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_pa=
ges(struct vduse_iova_domain *domain)
> > > > > > >  {
> > > > > > >       struct vduse_bounce_map *map;
> > > > > > >       unsigned long i, count;
> > > > > > > +     struct page **pages =3D NULL;
> > > > > > >
> > > > > > >       write_lock(&domain->bounce_lock);
> > > > > > >       if (!domain->user_bounce_pages)
> > > > > > >               goto out;
> > > > > > > -
> > > > > > >       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > > > +     write_unlock(&domain->bounce_lock);
> > > > > > > +
> > > > > > > +     pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERN=
EL | __GFP_NOFAIL);
> > > > > > > +     for (i =3D 0; i < count; i++)
> > > > > > > +             pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFA=
IL);
> > > > > >
> > > > > > AFAICS vduse_domain_release calls this function with
> > > > > > spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_lock=
 is not
> > > > > > sufficient.
> > > > >
> > > > > yes. this is true:
> > > > >
> > > > > static int vduse_domain_release(struct inode *inode, struct file =
*file)
> > > > > {
> > > > >         struct vduse_iova_domain *domain =3D file->private_data;
> > > > >
> > > > >         spin_lock(&domain->iotlb_lock);
> > > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > >         vduse_domain_remove_user_bounce_pages(domain);
> > > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > > >         spin_unlock(&domain->iotlb_lock);
> > > > >         put_iova_domain(&domain->stream_iovad);
> > > > >         put_iova_domain(&domain->consistent_iovad);
> > > > >         vhost_iotlb_free(domain->iotlb);
> > > > >         vfree(domain->bounce_maps);
> > > > >         kfree(domain);
> > > > >
> > > > >         return 0;
> > > > > }
> > > > >
> > > > > This is quite a pain. I admit I don't have knowledge of this driv=
er, and I don't
> > > > > think it's safe to release two locks and then reacquire them. The=
 situation is
> > > > > rather complex. Therefore, I would prefer if the VDPA maintainers=
 could
> > > > > take the lead in implementing a proper fix.
> > > >
> > > > Would it be possible to move all that work to a deferred context?
> > >
> > > My understanding is that we need to be aware of both the iotlb_lock a=
nd
> > > bounce_lock to implement the correct changes. As long as we still nee=
d
> > > to acquire these two locks in a deferred context, there doesn't seem =
to
> > > be any difference.
> > >
> > > I can do the memory pre-allocation before spin_lock(&domain->iotlb_lo=
ck),
> > > but I have no knowledge whether the "count" will change after I make
> > > the preallocation.
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
> > > b/drivers/vdpa/vdpa_user/iova_domain.c
> > > index 791d38d6284c..7ec87ef33d42 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > @@ -544,9 +544,12 @@ static int vduse_domain_release(struct inode
> > > *inode, struct file *file)
> > >  {
> > >         struct vduse_iova_domain *domain =3D file->private_data;
> > >
> > > +      struct page **pages;
> > > +      spin_lock(&domain->iotlb_lock); maybe also + bounce_lock?
> > > +      count =3D domain->bounce_size >> PAGE_SHIFT;
> > > +      spin_unlock(&domain->iotlb_lock);
> >
> > We probably don't need any lock here as bounce_size won't be changed .
> >
> > > +
> > > +       preallocate_count_pages(pages, count);
> > > +
> > > ....
> > >         spin_lock(&domain->iotlb_lock);
> > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > >         vduse_domain_free_kernel_bounce_pages(domain);
> > >         spin_unlock(&domain->iotlb_lock);
> > >         put_iova_domain(&domain->stream_iovad);
> >
> > This seems to work.
>
> Thanks, Jason. I personally have no knowledge of vDPA. Could you please h=
elp
> review and test the patch below?
>
> From 1f3cae091159bfcaffdb4a999a4a8e37db2eacf1 Mon Sep 17 00:00:00 2001
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Wed, 24 Jul 2024 20:55:40 +1200
> Subject: [PATCH RFC v2] vpda: try to fix the potential crash due to misus=
ing
>  __GFP_NOFAIL
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
>
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>                                                 struct alloc_context *ac)
> {
>         ...
>         /*
>          * Make sure that __GFP_NOFAIL request doesn't leak out and make =
sure
>          * we always retry
>          */
>         if (gfp_mask & __GFP_NOFAIL) {
>                 /*
>                  * All existing users of the __GFP_NOFAIL are blockable, =
so warn
>                  * of any new users that actually require GFP_NOWAIT
>                  */
>                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>                         goto fail;
>                 ...
>         }
>         ...
> fail:
>         warn_alloc(gfp_mask, ac->nodemask,
>                         "page allocation failure: order:%u", order);
> got_pg:
>         return page;
> }
>
> Let's move the memory allocation out of the atomic context and use
> the normal sleepable context to get pages.
>
> [RFC]: This has only been compile-tested; I'd prefer if the VDPA maintain=
ers
> handles it.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 21 ++++++++++++++++-----
>  drivers/vdpa/vdpa_user/iova_domain.h |  3 ++-
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 13 ++++++++++++-
>  3 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 791d38d6284c..014809ac2b7c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -283,7 +283,7 @@ int vduse_domain_add_user_bounce_pages(struct vduse_i=
ova_domain *domain,
>         return ret;
>  }
>
> -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *dom=
ain)
> +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *dom=
ain, struct page **pages)
>  {
>         struct vduse_bounce_map *map;
>         unsigned long i, count;
> @@ -294,15 +294,16 @@ void vduse_domain_remove_user_bounce_pages(struct v=
duse_iova_domain *domain)
>
>         count =3D domain->bounce_size >> PAGE_SHIFT;
>         for (i =3D 0; i < count; i++) {
> -               struct page *page =3D NULL;
> +               struct page *page =3D pages[i];
>
>                 map =3D &domain->bounce_maps[i];
> -               if (WARN_ON(!map->bounce_page))
> +               if (WARN_ON(!map->bounce_page)) {
> +                       put_page(page);
>                         continue;
> +               }
>
>                 /* Copy user page to kernel page if it's in use */
>                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
>                         memcpy_from_page(page_address(page),
>                                          map->bounce_page, 0, PAGE_SIZE);
>                 }
> @@ -543,10 +544,19 @@ static int vduse_domain_mmap(struct file *file, str=
uct vm_area_struct *vma)
>  static int vduse_domain_release(struct inode *inode, struct file *file)
>  {
>         struct vduse_iova_domain *domain =3D file->private_data;
> +       struct page **pages =3D NULL;
> +       unsigned long count, i;
> +
> +       if (domain->user_bounce_pages) {
> +               count =3D domain->bounce_size >> PAGE_SHIFT;
> +               pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL=
 | __GFP_NOFAIL);
> +               for (i =3D 0; i < count; i++)
> +                       pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL=
);
> +       }
>
>         spin_lock(&domain->iotlb_lock);
>         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> -       vduse_domain_remove_user_bounce_pages(domain);
> +       vduse_domain_remove_user_bounce_pages(domain, pages);
>         vduse_domain_free_kernel_bounce_pages(domain);
>         spin_unlock(&domain->iotlb_lock);
>         put_iova_domain(&domain->stream_iovad);
> @@ -554,6 +564,7 @@ static int vduse_domain_release(struct inode *inode, =
struct file *file)
>         vhost_iotlb_free(domain->iotlb);
>         vfree(domain->bounce_maps);
>         kfree(domain);
> +       kfree(pages);
>
>         return 0;
>  }
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index f92f22a7267d..db0b793d86db 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -74,7 +74,8 @@ void vduse_domain_reset_bounce_map(struct vduse_iova_do=
main *domain);
>  int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
>                                        struct page **pages, int count);
>
> -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *dom=
ain);
> +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *dom=
ain,
> +                                          struct page **pages);
>
>  void vduse_domain_destroy(struct vduse_iova_domain *domain);
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 7ae99691efdf..df7c1b6f1350 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1030,6 +1030,8 @@ static int vduse_dev_queue_irq_work(struct vduse_de=
v *dev,
>  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
>                                 u64 iova, u64 size)
>  {
> +       struct page **pages =3D NULL;
> +       unsigned long count, i;
>         int ret;
>
>         mutex_lock(&dev->mem_lock);
> @@ -1044,13 +1046,22 @@ static int vduse_dev_dereg_umem(struct vduse_dev =
*dev,
>         if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_si=
ze)
>                 goto unlock;
>
> -       vduse_domain_remove_user_bounce_pages(dev->domain);
> +       if (dev->domain->user_bounce_pages) {
> +               count =3D dev->domain->bounce_size >> PAGE_SHIFT;
> +               pages =3D kmalloc_array(count, sizeof(*pages),
> +                                     GFP_KERNEL | __GFP_NOFAIL);
> +               for (i =3D 0; i < count; i++)
> +                       pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL=
);
> +       }

Nit: there's some code duplication with vduse_domain_release().

Others look good to me.

Would you like to post a formal patch?

Thanks

> +
> +       vduse_domain_remove_user_bounce_pages(dev->domain, pages);
>         unpin_user_pages_dirty_lock(dev->umem->pages,
>                                     dev->umem->npages, true);
>         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
>         mmdrop(dev->umem->mm);
>         vfree(dev->umem->pages);
>         kfree(dev->umem);
> +       kfree(pages);
>         dev->umem =3D NULL;
>         ret =3D 0;
>  unlock:
> --
> 2.34.1
>
> >
> > Thanks
> >
> > >
> > >
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs
> > >
>
> Thanks
> Barry
>

