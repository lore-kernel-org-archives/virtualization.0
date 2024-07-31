Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54E2E62B
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399118; cv=none; b=doctt4xzHTBcij8O0EQffocqiYhSPDkEwRSYsaHAv2u9uWS+HvTSZ+rVCEhiplsnMifD6QfFeTHmdm67dCJ8mHuTglWgS1DP608cFZ9u51NfASArJb+na8SigkJDWdtXfKhXup8TvQelfXqL9AepS8j8GDjXV9g5xfeG6bqU4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399118; c=relaxed/simple;
	bh=RNzUW3oF4FzmMc8eH+AgamwZDLg0dYvoQSjiQ6OzHWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djqUdDzj7ASD/zauBziiHVImyaQ0bbWw1gwTjaFS38ZMfuyllaFZmt1f3rjHHyJqzNJnHQ4rtOmiUkorLPMB+RoAO5ejyvwR8niLDiCJgDWZmdtUR7Nyle89v2xjO/PXbUSgbBp1orCOmcs1QzQquoIVlz68W5mmcTDbV3U2zto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPs79xkl; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPs79xkl"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f52c326501so2199154e0c.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399115; x=1723003915; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg+ne5RbXGzTMhIX6WeWXeIYwsCxgZAOGqT3yzWRW58=;
        b=TPs79xklFu+E28bO6Ih3FbEHrCb8am/DYraWrTJtuEH5fvv3A/rhk+SkLWQ9vH23Iw
         lMZZ8/F4TpbYR15pxn/eMdeDXyg71lSueEymn3bUt4BgPvqa5nrfvG9oIUPGe6Z3i44a
         Nc1YRgDcG5DSHaBqbuozkMWRhGDAA1nqRhmnlBVdBBkCKRieCiH6lwYM0mdts7iLyJ4q
         D7Wuz+mi1jtVJ1hfqCG63X5jZKImle9wJEpCnE/+FI/g9k3v6PMorkqXYQsk2D1Jp0o6
         2Ovk7OSLRfHCgW/aJN1hDuNFf1kqfkjRzz6P7JnFQhocJGieTBA4St0WVzYnv4txbUCn
         Qt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399115; x=1723003915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg+ne5RbXGzTMhIX6WeWXeIYwsCxgZAOGqT3yzWRW58=;
        b=TtjarSUiBbU4+NWbJ7KLdSKcHJqmwqB2MA5ajDcOGEyCc6VrdNbLh1M6/9hNAeBgTN
         7vIrtPzh+FJ8Rf9vkT1ALC8UEnnV39GPTvgPMR5yyuxPh6aqNfAObiGCm+YYTsio7und
         yNY706wQHKDE54ra66YdgWe2urpBojJ1pg989o+vb4ptjYgYbdYTXM5VyR6W2U+2W9Qh
         Fbqu1KcRCOkgxFTFWDW69a4zD0/ZNikdHFnGDMF82UmEq4j/MuNbnsDHvBSzk3bZKITj
         JpSQZO0ORA0a40klBThrxUmdpkaCtfsPBZTRfZ8Cbg13enMedzajF9y0lZRHFmBKGzIt
         RWPA==
X-Forwarded-Encrypted: i=1; AJvYcCWIAp6Y6z+8Oz5DbUnY/oSWZPbddsOXuU6Xh3jvD3hI1j4EuquIVTOSga6+UI5Wqvq4U2xnKkcqhkSjEF1aBzOK3LFWSn/WdZNEMiYLFqc=
X-Gm-Message-State: AOJu0Ywk1w8b0vAgRbfjjfPBkhWsvPFJcMBfZaRicBuvKDHM7uVVfW/n
	TSdfwLo2AivSTomgPKGX333iZsYJ5qEfD4LyGfd4DjsJZpiMrYvCmQMY/zP/dplmweYUpa/5/Sp
	jAZV/yVo0z6g5lNXLOBKrHe0LpM8=
X-Google-Smtp-Source: AGHT+IGx8hISC2H0WLvgvyVRjW0c+XgOzVPalC4KfRlnbsMIKUuZoEMS9f9fO16Dt4jspjHCeyZqMPYZxyE0t3aqnAk=
X-Received: by 2002:a05:6122:469a:b0:4eb:499a:2453 with SMTP id
 71dfb90a1353d-4f6e6904434mr9321710e0c.8.1722399115429; Tue, 30 Jul 2024
 21:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
 <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com> <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com>
In-Reply-To: <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 12:11:41 +0800
Message-ID: <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com>
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

On Wed, Jul 31, 2024 at 11:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Jul 31, 2024 at 11:15=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > On Wed, Jul 31, 2024 at 11:10=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 8:03=E2=80=AFAM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > > loop within non-sleepable contexts.
> > > >
> > > > static inline struct page *
> > > > __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > > >                                                 struct alloc_contex=
t *ac)
> > > > {
> > > >         ...
> > > >         /*
> > > >          * Make sure that __GFP_NOFAIL request doesn't leak out and=
 make sure
> > > >          * we always retry
> > > >          */
> > > >         if (gfp_mask & __GFP_NOFAIL) {
> > > >                 /*
> > > >                  * All existing users of the __GFP_NOFAIL are block=
able, so warn
> > > >                  * of any new users that actually require GFP_NOWAI=
T
> > > >                  */
> > > >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask)=
)
> > > >                         goto fail;
> > > >                 ...
> > > >         }
> > > >         ...
> > > > fail:
> > > >         warn_alloc(gfp_mask, ac->nodemask,
> > > >                         "page allocation failure: order:%u", order)=
;
> > > > got_pg:
> > > >         return page;
> > > > }
> > > >
> > > > Let's move the memory allocation out of the atomic context and use
> > > > the normal sleepable context to get pages.
> > > >
> > > > [RFT]: This has only been compile-tested; I'd prefer if the VDPA ma=
intainers
> > > > handles it.
> > > >
> > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/iova_domain.c | 31 +++++++++++++++++++++++-=
----
> > > >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
> > > >  3 files changed, 33 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vd=
pa_user/iova_domain.c
> > > > index 791d38d6284c..9318f059a8b5 100644
> > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > @@ -283,7 +283,23 @@ int vduse_domain_add_user_bounce_pages(struct =
vduse_iova_domain *domain,
> > > >         return ret;
> > > >  }
> > > >
> > > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domai=
n *domain)
> > > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vdu=
se_iova_domain *domain)
> > > > +{
> > > > +       struct page **pages;
> > > > +       unsigned long count, i;
> > > > +
> > > > +       if (!domain->user_bounce_pages)
> > > > +               return NULL;
> > > > +
> > > > +       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > +       pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL |=
 __GFP_NOFAIL);
> > > > +       for (i =3D 0; i < count; i++)
> > > > +               pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> > > > +
> > > > +       return pages;
> > > > +}
> > > > +
> > > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domai=
n *domain, struct page **pages)
> > > >  {
> > > >         struct vduse_bounce_map *map;
> > > >         unsigned long i, count;
> > > > @@ -294,15 +310,16 @@ void vduse_domain_remove_user_bounce_pages(st=
ruct vduse_iova_domain *domain)
> > > >
> > > >         count =3D domain->bounce_size >> PAGE_SHIFT;
> > > >         for (i =3D 0; i < count; i++) {
> > > > -               struct page *page =3D NULL;
> > > > +               struct page *page =3D pages[i];
> > > >
> > > >                 map =3D &domain->bounce_maps[i];
> > > > -               if (WARN_ON(!map->bounce_page))
> > > > +               if (WARN_ON(!map->bounce_page)) {
> > > > +                       put_page(page);
> > > >                         continue;
> > > > +               }
> > > >
> > > >                 /* Copy user page to kernel page if it's in use */
> > > >                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > > > -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFA=
IL);
> > > >                         memcpy_from_page(page_address(page),
> > > >                                          map->bounce_page, 0, PAGE_=
SIZE);
> > > >                 }
> > > > @@ -310,6 +327,7 @@ void vduse_domain_remove_user_bounce_pages(stru=
ct vduse_iova_domain *domain)
> > > >                 map->bounce_page =3D page;
> > > >         }
> > > >         domain->user_bounce_pages =3D false;
> > > > +       kfree(pages);
> > > >  out:
> > > >         write_unlock(&domain->bounce_lock);
> > > >  }
> > > > @@ -543,10 +561,13 @@ static int vduse_domain_mmap(struct file *fil=
e, struct vm_area_struct *vma)
> > > >  static int vduse_domain_release(struct inode *inode, struct file *=
file)
> > > >  {
> > > >         struct vduse_iova_domain *domain =3D file->private_data;
> > > > +       struct page **pages;
> > > > +
> > > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(domain)=
;
> > > >
> > > >         spin_lock(&domain->iotlb_lock);
> > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > >         spin_unlock(&domain->iotlb_lock);
> > > >         put_iova_domain(&domain->stream_iovad);
> > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vd=
pa_user/iova_domain.h
> > > > index f92f22a7267d..17efa5555b3f 100644
> > > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > > @@ -74,7 +74,10 @@ void vduse_domain_reset_bounce_map(struct vduse_=
iova_domain *domain);
> > > >  int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *d=
omain,
> > > >                                        struct page **pages, int cou=
nt);
> > > >
> > > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domai=
n *domain);
> > > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domai=
n *domain,
> > > > +                                          struct page **pages);
> > > > +
> > > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vdu=
se_iova_domain *domain);
> > > >
> > > >  void vduse_domain_destroy(struct vduse_iova_domain *domain);
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 7ae99691efdf..5d8d5810df57 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -1030,6 +1030,7 @@ static int vduse_dev_queue_irq_work(struct vd=
use_dev *dev,
> > > >  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > >                                 u64 iova, u64 size)
> > > >  {
> > > > +       struct page **pages;
> > > >         int ret;
> > > >
> > > >         mutex_lock(&dev->mem_lock);
> > > > @@ -1044,7 +1045,8 @@ static int vduse_dev_dereg_umem(struct vduse_=
dev *dev,
> > > >         if (dev->umem->iova !=3D iova || size !=3D dev->domain->bou=
nce_size)
> > > >                 goto unlock;
> > > >
> > > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(dev->do=
main);
> > > > +       vduse_domain_remove_user_bounce_pages(dev->domain, pages);
> > > >         unpin_user_pages_dirty_lock(dev->umem->pages,
> > > >                                     dev->umem->npages, true);
> > > >         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > >
> > > We miss a kfree(pages); here?
> > no.
> > i've moved it into vduse_domain_remove_user_bounce_pages.
>
> Ok, but it seems tricky e.g allocated by the caller but freed in
> callee. And I think I missed some important issues in the previous
> review: The check of user_bounce_pages must be done under the
> bounce_lock, otherwise it might race with umem_reg.
>
> So in the case of release(), we know the device is gone, so there's no
> need to allocate pages that will be released soon. So we can pass NULL
> as a hint and just assign bounce_page to NULL in
> vduse_domain_remove_user_bounce_pages().
>
> And in the case of vduse_dev_dereg_umem(), we need to allocate the
> pages without checking user_bounce_pages. So in
> vduse_domain_remove_user_bounce_pages() if we can free the allocated
> pages as well as the pages in the following check
>
>         if (!domain->user_bounce_pages)
>                 goto out;
>
> What do you think?

I am not a vdpa guy, but  changing the current logic is another patch.
From mm perspective, I can only address the __GFP_NOFAIL issue.

I actually prefer you guys handle it  directly:-) I'd rather report a BUG
instead. TBH, I know nothing about vpda.

>
> Thanks
>
> >
> > >
> > > Thanks
> > >
> > > > --
> > > > 2.34.1
> > > >
> > >
Thanks
Barry
