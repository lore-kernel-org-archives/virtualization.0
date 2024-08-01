Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F9DDC3
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479499; cv=none; b=hIy5cGx3BBaaA+L8pEZpzq95CDMECoH846yg5JHX+4uPHjzGZNRts0XOOmZkhS7/XZ5d0bSdA8qiK6Ly6GJddbVm0YRJQ01ATu8uiCqsGPCpM7FV/aTHVtlujp0M6Of0sE2hl+SBH24VTqp2kOThKC0AYEaCwat90Gwgl40XE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479499; c=relaxed/simple;
	bh=vG/O9O42cWq7cuQ2VHu/aiaW8mIgxVvHfAniCrbIIb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2UEH/gpW6L1g+lAZh815f3UKWvU+HUriAvVxYYx3x17ARX2+HduuR8eENEKptmVtsKyZdw87NPv8a8yGqjYWym9k7M8bhJSnQZhWyTvFct+YNy+r0kNLrFv2FqTJqBQU58gVHhvwkUlVAJy6vAwrzMV8LBNzlQgFk+dS4kXslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaBV2f8S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaBV2f8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722479495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yIlY4Q31HIrYzzLusJHBJaaFMIXY24OfMSxZbfSa7kg=;
	b=UaBV2f8SODnZkNsxUIZ4Tu+Lt3WIvkAL+3HeCpZVSt5Nuj/pGp1gHk6KLVTYVwx/E3/8wZ
	CAhC2U2+v60EGBlqSew5aJDBBpI5AQ2QW/c7Ne33F4YK5plWcNOt611FDArawoFcGxFJ8G
	aDhQKE5mCE/V/+uMWs3caXGOh/8UayU=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-HzMmGtMCP-m0FGaUtM4jAQ-1; Wed, 31 Jul 2024 22:31:34 -0400
X-MC-Unique: HzMmGtMCP-m0FGaUtM4jAQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-493d0326fa7so3055599137.1
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 19:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722479494; x=1723084294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIlY4Q31HIrYzzLusJHBJaaFMIXY24OfMSxZbfSa7kg=;
        b=LteEA+s39VESN3dwh1EXly7dp6xNmR1jeNwTd6QZDcsjGUgZ7QmlJY3ux063L7hHf8
         1EjxW48l6NnhWeX2Hhwp5BCU+5/oL8AugK59LT157s32mClfB0BPhULQ5Pdz7iU7DBdK
         cNEzKJracqWJ3Y8LF9aG7kyqWy/5oFV7cGPvIa4kbae+23Ug351LTWMK8c/Jb94Uckx4
         2fGGa3iJ12z4OKHl6bfcD+wbG2QPEdMHt7Hj4te1iJAszd4/xDkzObsBeQO97GZBvxX0
         +lspL7KYjNMmOxgjc0aOFHKrT9sZgn0fdtMJZQQ3k2kDJjpJJdVUH5oricFQf2cVt3O7
         bE7g==
X-Forwarded-Encrypted: i=1; AJvYcCV31fZpgxfsIm/D5Wm2DLX4DjTj8QryqlKqvoI6YLYon1ztORm0Dqd8s/+9iZvgMIwaBb1BQZrxzHJ+FA5+dbfqzOfirUUTvTBR5UTfyT0=
X-Gm-Message-State: AOJu0Yzr6NYUg4KYJVMcGkiLFWMjQakVux5WJ200mS/GUTatFKXqdn+7
	SqNtdjP1UhvOVEVh0Py/gddif5NzJdF//uk0FCAZ8GQBRNw7zz9s62+KvILP2cd2d4EPYaNmn3L
	56EAwYOILDG6S1QFL7f+iRDHTcjoIpNGNMM4JUDw/hDsPh5P7ziP7y/z8kFSSwflc7r/UmI1wVa
	nK4nPQhzU7oPYQZuUPsQuGRqTLgv38ijVib4NXDVI=
X-Received: by 2002:a05:6102:511e:b0:493:b4e1:634a with SMTP id ada2fe7eead31-494506c7bf6mr1477913137.8.1722479493799;
        Wed, 31 Jul 2024 19:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtE19wU8GqsqvtYAm3MfCZxcMqdopsb201LOjDxhzVP3gqMYIf8v9PLan9M07aGx1K+sLXAv7K6uriZgRXHio=
X-Received: by 2002:a05:6102:511e:b0:493:b4e1:634a with SMTP id
 ada2fe7eead31-494506c7bf6mr1477899137.8.1722479493373; Wed, 31 Jul 2024
 19:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
 <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
 <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com>
 <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com>
 <CACGkMEvnfFVWWd9++BkZu=7iL8+yo71Fr=R00sTJ+pZUbKbiXw@mail.gmail.com> <CAGsJ_4w9UrgBR9gs-J74036JBXaod2OE0WOtPiMYyw+ov7VcHQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4w9UrgBR9gs-J74036JBXaod2OE0WOtPiMYyw+ov7VcHQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 10:30:52 +0800
Message-ID: <CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2saLnUdfOGOLg@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: penguin-kernel@i-love.sakura.ne.jp, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:05=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Jul 31, 2024 at 12:13=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Wed, Jul 31, 2024 at 12:12=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> > >
> > > On Wed, Jul 31, 2024 at 11:58=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Wed, Jul 31, 2024 at 11:15=E2=80=AFAM Barry Song <21cnbao@gmail.=
com> wrote:
> > > > >
> > > > > On Wed, Jul 31, 2024 at 11:10=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 31, 2024 at 8:03=E2=80=AFAM Barry Song <21cnbao@gma=
il.com> wrote:
> > > > > > >
> > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > > >
> > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Bec=
ause
> > > > > > > __GFP_NOFAIL without direct reclamation may just result in a =
busy
> > > > > > > loop within non-sleepable contexts.
> > > > > > >
> > > > > > > static inline struct page *
> > > > > > > __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > > > > > >                                                 struct alloc_=
context *ac)
> > > > > > > {
> > > > > > >         ...
> > > > > > >         /*
> > > > > > >          * Make sure that __GFP_NOFAIL request doesn't leak o=
ut and make sure
> > > > > > >          * we always retry
> > > > > > >          */
> > > > > > >         if (gfp_mask & __GFP_NOFAIL) {
> > > > > > >                 /*
> > > > > > >                  * All existing users of the __GFP_NOFAIL are=
 blockable, so warn
> > > > > > >                  * of any new users that actually require GFP=
_NOWAIT
> > > > > > >                  */
> > > > > > >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp=
_mask))
> > > > > > >                         goto fail;
> > > > > > >                 ...
> > > > > > >         }
> > > > > > >         ...
> > > > > > > fail:
> > > > > > >         warn_alloc(gfp_mask, ac->nodemask,
> > > > > > >                         "page allocation failure: order:%u", =
order);
> > > > > > > got_pg:
> > > > > > >         return page;
> > > > > > > }
> > > > > > >
> > > > > > > Let's move the memory allocation out of the atomic context an=
d use
> > > > > > > the normal sleepable context to get pages.
> > > > > > >
> > > > > > > [RFT]: This has only been compile-tested; I'd prefer if the V=
DPA maintainers
> > > > > > > handles it.
> > > > > > >
> > > > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > > > > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/iova_domain.c | 31 ++++++++++++++++++=
+++++-----
> > > > > > >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
> > > > > > >  3 files changed, 33 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/v=
dpa/vdpa_user/iova_domain.c
> > > > > > > index 791d38d6284c..9318f059a8b5 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > > @@ -283,7 +283,23 @@ int vduse_domain_add_user_bounce_pages(s=
truct vduse_iova_domain *domain,
> > > > > > >         return ret;
> > > > > > >  }
> > > > > > >
> > > > > > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova=
_domain *domain)
> > > > > > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(stru=
ct vduse_iova_domain *domain)
> > > > > > > +{
> > > > > > > +       struct page **pages;
> > > > > > > +       unsigned long count, i;
> > > > > > > +
> > > > > > > +       if (!domain->user_bounce_pages)
> > > > > > > +               return NULL;
> > > > > > > +
> > > > > > > +       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > > > +       pages =3D kmalloc_array(count, sizeof(*pages), GFP_KE=
RNEL | __GFP_NOFAIL);
> > > > > > > +       for (i =3D 0; i < count; i++)
> > > > > > > +               pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NO=
FAIL);
> > > > > > > +
> > > > > > > +       return pages;
> > > > > > > +}
> > > > > > > +
> > > > > > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova=
_domain *domain, struct page **pages)
> > > > > > >  {
> > > > > > >         struct vduse_bounce_map *map;
> > > > > > >         unsigned long i, count;
> > > > > > > @@ -294,15 +310,16 @@ void vduse_domain_remove_user_bounce_pa=
ges(struct vduse_iova_domain *domain)
> > > > > > >
> > > > > > >         count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > > >         for (i =3D 0; i < count; i++) {
> > > > > > > -               struct page *page =3D NULL;
> > > > > > > +               struct page *page =3D pages[i];
> > > > > > >
> > > > > > >                 map =3D &domain->bounce_maps[i];
> > > > > > > -               if (WARN_ON(!map->bounce_page))
> > > > > > > +               if (WARN_ON(!map->bounce_page)) {
> > > > > > > +                       put_page(page);
> > > > > > >                         continue;
> > > > > > > +               }
> > > > > > >
> > > > > > >                 /* Copy user page to kernel page if it's in u=
se */
> > > > > > >                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > > > > > > -                       page =3D alloc_page(GFP_ATOMIC | __GF=
P_NOFAIL);
> > > > > > >                         memcpy_from_page(page_address(page),
> > > > > > >                                          map->bounce_page, 0,=
 PAGE_SIZE);
> > > > > > >                 }
> > > > > > > @@ -310,6 +327,7 @@ void vduse_domain_remove_user_bounce_page=
s(struct vduse_iova_domain *domain)
> > > > > > >                 map->bounce_page =3D page;
> > > > > > >         }
> > > > > > >         domain->user_bounce_pages =3D false;
> > > > > > > +       kfree(pages);
> > > > > > >  out:
> > > > > > >         write_unlock(&domain->bounce_lock);
> > > > > > >  }
> > > > > > > @@ -543,10 +561,13 @@ static int vduse_domain_mmap(struct fil=
e *file, struct vm_area_struct *vma)
> > > > > > >  static int vduse_domain_release(struct inode *inode, struct =
file *file)
> > > > > > >  {
> > > > > > >         struct vduse_iova_domain *domain =3D file->private_da=
ta;
> > > > > > > +       struct page **pages;
> > > > > > > +
> > > > > > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(d=
omain);
> > > > > > >
> > > > > > >         spin_lock(&domain->iotlb_lock);
> > > > > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > > > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > > > > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > > > > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > > > > >         spin_unlock(&domain->iotlb_lock);
> > > > > > >         put_iova_domain(&domain->stream_iovad);
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/v=
dpa/vdpa_user/iova_domain.h
> > > > > > > index f92f22a7267d..17efa5555b3f 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > > > > > @@ -74,7 +74,10 @@ void vduse_domain_reset_bounce_map(struct =
vduse_iova_domain *domain);
> > > > > > >  int vduse_domain_add_user_bounce_pages(struct vduse_iova_dom=
ain *domain,
> > > > > > >                                        struct page **pages, i=
nt count);
> > > > > > >
> > > > > > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova=
_domain *domain);
> > > > > > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova=
_domain *domain,
> > > > > > > +                                          struct page **page=
s);
> > > > > > > +
> > > > > > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(stru=
ct vduse_iova_domain *domain);
> > > > > > >
> > > > > > >  void vduse_domain_destroy(struct vduse_iova_domain *domain);
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index 7ae99691efdf..5d8d5810df57 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -1030,6 +1030,7 @@ static int vduse_dev_queue_irq_work(str=
uct vduse_dev *dev,
> > > > > > >  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > > > > >                                 u64 iova, u64 size)
> > > > > > >  {
> > > > > > > +       struct page **pages;
> > > > > > >         int ret;
> > > > > > >
> > > > > > >         mutex_lock(&dev->mem_lock);
> > > > > > > @@ -1044,7 +1045,8 @@ static int vduse_dev_dereg_umem(struct =
vduse_dev *dev,
> > > > > > >         if (dev->umem->iova !=3D iova || size !=3D dev->domai=
n->bounce_size)
> > > > > > >                 goto unlock;
> > > > > > >
> > > > > > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > > > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(d=
ev->domain);
> > > > > > > +       vduse_domain_remove_user_bounce_pages(dev->domain, pa=
ges);
> > > > > > >         unpin_user_pages_dirty_lock(dev->umem->pages,
> > > > > > >                                     dev->umem->npages, true);
> > > > > > >         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinne=
d_vm);
> > > > > >
> > > > > > We miss a kfree(pages); here?
> > > > > no.
> > > > > i've moved it into vduse_domain_remove_user_bounce_pages.
> > > >
> > > > Ok, but it seems tricky e.g allocated by the caller but freed in
> > > > callee. And I think I missed some important issues in the previous
> > > > review: The check of user_bounce_pages must be done under the
> > > > bounce_lock, otherwise it might race with umem_reg.
> > > >
> > > > So in the case of release(), we know the device is gone, so there's=
 no
> > > > need to allocate pages that will be released soon. So we can pass N=
ULL
> > > > as a hint and just assign bounce_page to NULL in
> > > > vduse_domain_remove_user_bounce_pages().
> > > >
> > > > And in the case of vduse_dev_dereg_umem(), we need to allocate the
> > > > pages without checking user_bounce_pages. So in
> > > > vduse_domain_remove_user_bounce_pages() if we can free the allocate=
d
> > > > pages as well as the pages in the following check
> > > >
> > > >         if (!domain->user_bounce_pages)
> > > >                 goto out;
> > > >
> > > > What do you think?
> > >
> > > I am not a vdpa guy, but  changing the current logic is another patch=
.
> > > From mm perspective, I can only address the __GFP_NOFAIL issue.
> > >
> > > I actually prefer you guys handle it  directly:-) I'd rather report a=
 BUG
> > > instead. TBH, I know nothing about vpda.
> >
> > Fine, let me post a patch for this (no later than the end of this week)=
.
> >
> Jason,
> Thank you very much. Also, Tetsuo reminded me that kmalloc_array() might =
be
> problematic if the count is too large:
>  pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL=
);
>

I think it's a side effect of __GFP_NOFAIL?

> You might want to consider using vmalloc_array() or kvmalloc_array() inst=
ead
> when you send a new version.

Will consider that.

Thanks


>
> > Thanks
> >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > >
>
> Thanks
> Barry
>

