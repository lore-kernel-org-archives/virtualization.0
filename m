Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1641BC20
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 04:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399237; cv=none; b=MsJajBXVTNPKam/xvtqeYytQKQ4u3RrdlGLHH0uyAaVdI/unMd5+PfGz5p18N1FjGZEHCbxccvwlNxhvGRvfSYQh1TnXyEwc/28+MR0/ib/uS1ro0xafu5qzCx3KypYdFsl5X3A3wkfGmVfNZw0U2+6MqYekYWfS2sMHHnoblDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399237; c=relaxed/simple;
	bh=+iuygkEZrYwjOReMQhHWl6+SBaTbutPQXeFf58F28l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQ5RoGdQbvsKx6agKz6xLKf/A1curgIGDtEzzD9uZBvvCz9XaEkVPawuNCWrws0DNulmByJ/nFJbliwXlVCCr26o4yuoBPAKAC6Cl5mu9wa2/cMdixv49IBHXmqqChzZtvaEqzeFQV4jPL7IZr9UAKMRg+8yk8Bh98phKcfnuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7iaYrep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7iaYrep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722399234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7fduLws3eq5qh3TUq/RoZAYJZPIhkYXrAv/fjZLiu4=;
	b=Z7iaYrepcCCanCWl91Ya8vXsH2IF1KK3bA+iJVADr+A2vJdLH+dydR6hgMNZMf26+fosRI
	Gc9lOl6n3L5fISIOTD+nlRRnLdhCnwMSckbXhhEI4kORm+ApHokf+eD8JOEbmzikOX2UTi
	QkI2hceMNUApZ5Xsa6/MtWlEoL+IZrc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-pKIiSu60OT-jhkF0-qSaVg-1; Wed, 31 Jul 2024 00:13:51 -0400
X-MC-Unique: pKIiSu60OT-jhkF0-qSaVg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb4d02f34cso5267649a91.3
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 21:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399231; x=1723004031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7fduLws3eq5qh3TUq/RoZAYJZPIhkYXrAv/fjZLiu4=;
        b=di7O7cENNZ0PLzY4RjwizcdgP3mnl4ZxuzF4nOlsJwSwlZGh5n6jFaM2/S5G3SjrCT
         14KtbetUBxP3stxJ512y/vaW0Bh+Htg+PSBziImGdPO8cr4dKr4KimCtldObvw1iuPkw
         Qf95WP7wg1uNyUcihPIpOcGQp7G270x0XdWV+qCR2duguIK34nYxibZDVNtG6m93MXc2
         UDTcHd9ZvIptT9UwaH4gB9C6Mbj6UlBXDn3lyPfzN+9EyhHq2PiDZ88/OF1g6kX6GFD3
         x6wwdxGUBzISMSxp5WXpMZKO+ASwYP4gD5XAe814WBEHLsYtousAGW4hxT3e7JZ4HvH6
         tYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXENrjWfpTrmqgJKSQgvgtJ3DoLT9VVmCn9+6I8doDklF2gvvzYcdd9JSZxB7FI4CdABHU9c7p0MjvxD2h0H5N91nfDG1FQiiWj3R3u8U8=
X-Gm-Message-State: AOJu0YyS0ve6tDtv9uBcsZRR2gkWyrhJrIXXwirMWTfQYTtWYospexX9
	eZAEBUbdzlaX0joch0gFeCPCnZtQCtVyjDMQw2JMKhanmcIz60iqM9J9MTw+/jERzMtK9osI/26
	5ZEjSw/ksRXdNB0BOh7JFlI9e1QC5YK7y5HhMYDUwB2GXOcl3RuAX1yGspA5UsCk+wI/XPOzya/
	4bAiJTq3gkVIH1hJtmzB7m4BgKVZ6J/dJ1/bNEaBI=
X-Received: by 2002:a17:90b:793:b0:2c9:7616:dec7 with SMTP id 98e67ed59e1d1-2cf7e1b9439mr11648380a91.6.1722399230675;
        Tue, 30 Jul 2024 21:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+7eCv/z138G2h+rrUTN4HYLOmXdtxjb+D37a7vm7eDMexVsIFaScsFTYQKKPDOXufrasT6Bh/IVsUTE9N4UQ=
X-Received: by 2002:a17:90b:793:b0:2c9:7616:dec7 with SMTP id
 98e67ed59e1d1-2cf7e1b9439mr11648360a91.6.1722399230105; Tue, 30 Jul 2024
 21:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
 <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
 <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com> <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com>
In-Reply-To: <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 12:13:39 +0800
Message-ID: <CACGkMEvnfFVWWd9++BkZu=7iL8+yo71Fr=R00sTJ+pZUbKbiXw@mail.gmail.com>
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

On Wed, Jul 31, 2024 at 12:12=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Wed, Jul 31, 2024 at 11:58=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Wed, Jul 31, 2024 at 11:15=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
> > >
> > > On Wed, Jul 31, 2024 at 11:10=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Wed, Jul 31, 2024 at 8:03=E2=80=AFAM Barry Song <21cnbao@gmail.c=
om> wrote:
> > > > >
> > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > >
> > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > > > loop within non-sleepable contexts.
> > > > >
> > > > > static inline struct page *
> > > > > __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > > > >                                                 struct alloc_cont=
ext *ac)
> > > > > {
> > > > >         ...
> > > > >         /*
> > > > >          * Make sure that __GFP_NOFAIL request doesn't leak out a=
nd make sure
> > > > >          * we always retry
> > > > >          */
> > > > >         if (gfp_mask & __GFP_NOFAIL) {
> > > > >                 /*
> > > > >                  * All existing users of the __GFP_NOFAIL are blo=
ckable, so warn
> > > > >                  * of any new users that actually require GFP_NOW=
AIT
> > > > >                  */
> > > > >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mas=
k))
> > > > >                         goto fail;
> > > > >                 ...
> > > > >         }
> > > > >         ...
> > > > > fail:
> > > > >         warn_alloc(gfp_mask, ac->nodemask,
> > > > >                         "page allocation failure: order:%u", orde=
r);
> > > > > got_pg:
> > > > >         return page;
> > > > > }
> > > > >
> > > > > Let's move the memory allocation out of the atomic context and us=
e
> > > > > the normal sleepable context to get pages.
> > > > >
> > > > > [RFT]: This has only been compile-tested; I'd prefer if the VDPA =
maintainers
> > > > > handles it.
> > > > >
> > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/iova_domain.c | 31 ++++++++++++++++++++++=
+-----
> > > > >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
> > > > >  3 files changed, 33 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/=
vdpa_user/iova_domain.c
> > > > > index 791d38d6284c..9318f059a8b5 100644
> > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > @@ -283,7 +283,23 @@ int vduse_domain_add_user_bounce_pages(struc=
t vduse_iova_domain *domain,
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_dom=
ain *domain)
> > > > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct v=
duse_iova_domain *domain)
> > > > > +{
> > > > > +       struct page **pages;
> > > > > +       unsigned long count, i;
> > > > > +
> > > > > +       if (!domain->user_bounce_pages)
> > > > > +               return NULL;
> > > > > +
> > > > > +       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > +       pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL=
 | __GFP_NOFAIL);
> > > > > +       for (i =3D 0; i < count; i++)
> > > > > +               pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL=
);
> > > > > +
> > > > > +       return pages;
> > > > > +}
> > > > > +
> > > > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_dom=
ain *domain, struct page **pages)
> > > > >  {
> > > > >         struct vduse_bounce_map *map;
> > > > >         unsigned long i, count;
> > > > > @@ -294,15 +310,16 @@ void vduse_domain_remove_user_bounce_pages(=
struct vduse_iova_domain *domain)
> > > > >
> > > > >         count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > >         for (i =3D 0; i < count; i++) {
> > > > > -               struct page *page =3D NULL;
> > > > > +               struct page *page =3D pages[i];
> > > > >
> > > > >                 map =3D &domain->bounce_maps[i];
> > > > > -               if (WARN_ON(!map->bounce_page))
> > > > > +               if (WARN_ON(!map->bounce_page)) {
> > > > > +                       put_page(page);
> > > > >                         continue;
> > > > > +               }
> > > > >
> > > > >                 /* Copy user page to kernel page if it's in use *=
/
> > > > >                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > > > > -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NO=
FAIL);
> > > > >                         memcpy_from_page(page_address(page),
> > > > >                                          map->bounce_page, 0, PAG=
E_SIZE);
> > > > >                 }
> > > > > @@ -310,6 +327,7 @@ void vduse_domain_remove_user_bounce_pages(st=
ruct vduse_iova_domain *domain)
> > > > >                 map->bounce_page =3D page;
> > > > >         }
> > > > >         domain->user_bounce_pages =3D false;
> > > > > +       kfree(pages);
> > > > >  out:
> > > > >         write_unlock(&domain->bounce_lock);
> > > > >  }
> > > > > @@ -543,10 +561,13 @@ static int vduse_domain_mmap(struct file *f=
ile, struct vm_area_struct *vma)
> > > > >  static int vduse_domain_release(struct inode *inode, struct file=
 *file)
> > > > >  {
> > > > >         struct vduse_iova_domain *domain =3D file->private_data;
> > > > > +       struct page **pages;
> > > > > +
> > > > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(domai=
n);
> > > > >
> > > > >         spin_lock(&domain->iotlb_lock);
> > > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > > >         spin_unlock(&domain->iotlb_lock);
> > > > >         put_iova_domain(&domain->stream_iovad);
> > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/=
vdpa_user/iova_domain.h
> > > > > index f92f22a7267d..17efa5555b3f 100644
> > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > > > @@ -74,7 +74,10 @@ void vduse_domain_reset_bounce_map(struct vdus=
e_iova_domain *domain);
> > > > >  int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain =
*domain,
> > > > >                                        struct page **pages, int c=
ount);
> > > > >
> > > > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_dom=
ain *domain);
> > > > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_dom=
ain *domain,
> > > > > +                                          struct page **pages);
> > > > > +
> > > > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct v=
duse_iova_domain *domain);
> > > > >
> > > > >  void vduse_domain_destroy(struct vduse_iova_domain *domain);
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index 7ae99691efdf..5d8d5810df57 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -1030,6 +1030,7 @@ static int vduse_dev_queue_irq_work(struct =
vduse_dev *dev,
> > > > >  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > > >                                 u64 iova, u64 size)
> > > > >  {
> > > > > +       struct page **pages;
> > > > >         int ret;
> > > > >
> > > > >         mutex_lock(&dev->mem_lock);
> > > > > @@ -1044,7 +1045,8 @@ static int vduse_dev_dereg_umem(struct vdus=
e_dev *dev,
> > > > >         if (dev->umem->iova !=3D iova || size !=3D dev->domain->b=
ounce_size)
> > > > >                 goto unlock;
> > > > >
> > > > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(dev->=
domain);
> > > > > +       vduse_domain_remove_user_bounce_pages(dev->domain, pages)=
;
> > > > >         unpin_user_pages_dirty_lock(dev->umem->pages,
> > > > >                                     dev->umem->npages, true);
> > > > >         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm=
);
> > > >
> > > > We miss a kfree(pages); here?
> > > no.
> > > i've moved it into vduse_domain_remove_user_bounce_pages.
> >
> > Ok, but it seems tricky e.g allocated by the caller but freed in
> > callee. And I think I missed some important issues in the previous
> > review: The check of user_bounce_pages must be done under the
> > bounce_lock, otherwise it might race with umem_reg.
> >
> > So in the case of release(), we know the device is gone, so there's no
> > need to allocate pages that will be released soon. So we can pass NULL
> > as a hint and just assign bounce_page to NULL in
> > vduse_domain_remove_user_bounce_pages().
> >
> > And in the case of vduse_dev_dereg_umem(), we need to allocate the
> > pages without checking user_bounce_pages. So in
> > vduse_domain_remove_user_bounce_pages() if we can free the allocated
> > pages as well as the pages in the following check
> >
> >         if (!domain->user_bounce_pages)
> >                 goto out;
> >
> > What do you think?
>
> I am not a vdpa guy, but  changing the current logic is another patch.
> From mm perspective, I can only address the __GFP_NOFAIL issue.
>
> I actually prefer you guys handle it  directly:-) I'd rather report a BUG
> instead. TBH, I know nothing about vpda.

Fine, let me post a patch for this (no later than the end of this week).

Thanks

>
> >
> > Thanks
> >
> > >
> > > >
> > > > Thanks
> > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> Thanks
> Barry
>

