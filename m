Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D64502F
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722402330; cv=none; b=qiIZlGWyahBiv1cr1lcj/TmkjYmCr4aRTDSz9wkC1P5nacGsF+NLri/TH65GPOlMP2VeDptT5yVQMxA3mg5/sBTldVs+SH0hBzpmhmYBF2il1yy6rPhVtpJ1CrW7EdO8PLDxV+lDkUJeJjeCPHP2je/0WR9g0ndgRqR02Xj5YZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722402330; c=relaxed/simple;
	bh=9ZNigfHZS/RceezZMOMjMyBMFBBGHh391ze9FhgrtMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+mejDeV7dRbN8fNiHNbKiGtwo7zEhcsrcmeRyv9cut8Fxq4MPwnQ7M8R2ac+7gTPt/zYvuyijI/Xxep3c07srAxlS83H6hnGmdZ2JQdDTNwtfyvvgxFQyoCUzhxLCyyg9eHtjzoliwBDAtAGmQVpwi7WMq2A7jX6i13v4MtKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTmbkt+h; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTmbkt+h"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-83446a5601bso1510005241.0
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722402327; x=1723007127; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xn+7YwKXTJEDk+Hqw80LqfVKiLUraDj++Wq5QfpnOJE=;
        b=BTmbkt+hnnfktXBBta1KTC4DqZlb9S1kAdgXTgFgTRe6+Cq3d/EkOEJpd7Jm7oc5LL
         9Z1fIOdteh+ALrgUmFRY/msoW+543ccIj/wG5eO7Ydm/YW00GoD4zdmj5Ob0Akj2ie9J
         E1Yc5f0UP2dOUNcIjT3267V+G9//0X7J7UaSl4nzaJTSIEX+Xy0XeM8vwhVOFmSE9Tg4
         jy8HoEDD3eXDk8BvHKpnZwKTevO3R/Js+1+qiug7voQaV5XzC7xtgO7M8T9q3ssBGMBH
         EzRuvxErQBQMtwrpji95UIAU6cJYp47CzXNiulQf8gxybb7FfJTihkPG+lex9SAMsoC1
         Ietw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722402327; x=1723007127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn+7YwKXTJEDk+Hqw80LqfVKiLUraDj++Wq5QfpnOJE=;
        b=ccp3ylpAtXZwpc9Dxrds3txYYbae0ch6INJe/tUQ24j3xbcP9GIngvu+/nS/T4ul8g
         DV+YKb7qcSrPYzHG0NOtVwx00PFe/kwZdQP8QILeh2eVRcC55NtBUqK/L65ea9M5Tmu9
         9lqLqj3KJlkyBVSOjdharNCd/Kh7jYQ9qbGHC2r8Aa2GEYEh2NFvpUHHW278SdLmxBCF
         ng5xVazVbRwQieOKGlF3R53Wmw86UEMhjppNdD9YWelI4H958p6r0qfc8tyCciKs2fY6
         RQgE3bGNyB6Oqj9zL7l/8+1heTEFKTidFa6RAs1oMup14wZpsNjmPwr4t4dW6czeYQdg
         Tcyw==
X-Forwarded-Encrypted: i=1; AJvYcCWcO6PJmiB2rzSbduK2IvXonzLbwA/fPlQsUzyewpVTzC7iqlEgw31i2VC19PaIJaCrwPA8APnAAjiFhRwoZTyVhqhG7RFMDjesk4fRtrI=
X-Gm-Message-State: AOJu0YyD67x8ElwoZ6IocJu5fYT6dGCbsDpQKSDhrAVzcc9yMuh289Ko
	hJmosPyGZrOZfA6juGOvkaAZkrhdKL0yWPUU6DBC5MvylS+xeK3ZNE2CTYdbpzP9cjW5arc2Bue
	Ebqmjb2T8E4QqLqU+zcWWFFyfn4s=
X-Google-Smtp-Source: AGHT+IG+taccu8vxFmzYT8IWmHvg8VnBpcE12YA8ZxKB8a6+TKfwHMeZQTcTfllGTQHXaviRyTU3+dnUyBZflxRjeFQ=
X-Received: by 2002:a05:6102:358d:b0:48f:c062:75ae with SMTP id
 ada2fe7eead31-493fa819b11mr15925091137.8.1722402327038; Tue, 30 Jul 2024
 22:05:27 -0700 (PDT)
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
 <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com> <CACGkMEvnfFVWWd9++BkZu=7iL8+yo71Fr=R00sTJ+pZUbKbiXw@mail.gmail.com>
In-Reply-To: <CACGkMEvnfFVWWd9++BkZu=7iL8+yo71Fr=R00sTJ+pZUbKbiXw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 13:05:15 +0800
Message-ID: <CAGsJ_4w9UrgBR9gs-J74036JBXaod2OE0WOtPiMYyw+ov7VcHQ@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>, penguin-kernel@i-love.sakura.ne.jp
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

On Wed, Jul 31, 2024 at 12:13=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Jul 31, 2024 at 12:12=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > On Wed, Jul 31, 2024 at 11:58=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 11:15=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> > > >
> > > > On Wed, Jul 31, 2024 at 11:10=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Wed, Jul 31, 2024 at 8:03=E2=80=AFAM Barry Song <21cnbao@gmail=
.com> wrote:
> > > > > >
> > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > >
> > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Becau=
se
> > > > > > __GFP_NOFAIL without direct reclamation may just result in a bu=
sy
> > > > > > loop within non-sleepable contexts.
> > > > > >
> > > > > > static inline struct page *
> > > > > > __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > > > > >                                                 struct alloc_co=
ntext *ac)
> > > > > > {
> > > > > >         ...
> > > > > >         /*
> > > > > >          * Make sure that __GFP_NOFAIL request doesn't leak out=
 and make sure
> > > > > >          * we always retry
> > > > > >          */
> > > > > >         if (gfp_mask & __GFP_NOFAIL) {
> > > > > >                 /*
> > > > > >                  * All existing users of the __GFP_NOFAIL are b=
lockable, so warn
> > > > > >                  * of any new users that actually require GFP_N=
OWAIT
> > > > > >                  */
> > > > > >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_m=
ask))
> > > > > >                         goto fail;
> > > > > >                 ...
> > > > > >         }
> > > > > >         ...
> > > > > > fail:
> > > > > >         warn_alloc(gfp_mask, ac->nodemask,
> > > > > >                         "page allocation failure: order:%u", or=
der);
> > > > > > got_pg:
> > > > > >         return page;
> > > > > > }
> > > > > >
> > > > > > Let's move the memory allocation out of the atomic context and =
use
> > > > > > the normal sleepable context to get pages.
> > > > > >
> > > > > > [RFT]: This has only been compile-tested; I'd prefer if the VDP=
A maintainers
> > > > > > handles it.
> > > > > >
> > > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > > > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/iova_domain.c | 31 ++++++++++++++++++++=
+++-----
> > > > > >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
> > > > > >  3 files changed, 33 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdp=
a/vdpa_user/iova_domain.c
> > > > > > index 791d38d6284c..9318f059a8b5 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > @@ -283,7 +283,23 @@ int vduse_domain_add_user_bounce_pages(str=
uct vduse_iova_domain *domain,
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_d=
omain *domain)
> > > > > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct=
 vduse_iova_domain *domain)
> > > > > > +{
> > > > > > +       struct page **pages;
> > > > > > +       unsigned long count, i;
> > > > > > +
> > > > > > +       if (!domain->user_bounce_pages)
> > > > > > +               return NULL;
> > > > > > +
> > > > > > +       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > > +       pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERN=
EL | __GFP_NOFAIL);
> > > > > > +       for (i =3D 0; i < count; i++)
> > > > > > +               pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFA=
IL);
> > > > > > +
> > > > > > +       return pages;
> > > > > > +}
> > > > > > +
> > > > > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_d=
omain *domain, struct page **pages)
> > > > > >  {
> > > > > >         struct vduse_bounce_map *map;
> > > > > >         unsigned long i, count;
> > > > > > @@ -294,15 +310,16 @@ void vduse_domain_remove_user_bounce_page=
s(struct vduse_iova_domain *domain)
> > > > > >
> > > > > >         count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > >         for (i =3D 0; i < count; i++) {
> > > > > > -               struct page *page =3D NULL;
> > > > > > +               struct page *page =3D pages[i];
> > > > > >
> > > > > >                 map =3D &domain->bounce_maps[i];
> > > > > > -               if (WARN_ON(!map->bounce_page))
> > > > > > +               if (WARN_ON(!map->bounce_page)) {
> > > > > > +                       put_page(page);
> > > > > >                         continue;
> > > > > > +               }
> > > > > >
> > > > > >                 /* Copy user page to kernel page if it's in use=
 */
> > > > > >                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > > > > > -                       page =3D alloc_page(GFP_ATOMIC | __GFP_=
NOFAIL);
> > > > > >                         memcpy_from_page(page_address(page),
> > > > > >                                          map->bounce_page, 0, P=
AGE_SIZE);
> > > > > >                 }
> > > > > > @@ -310,6 +327,7 @@ void vduse_domain_remove_user_bounce_pages(=
struct vduse_iova_domain *domain)
> > > > > >                 map->bounce_page =3D page;
> > > > > >         }
> > > > > >         domain->user_bounce_pages =3D false;
> > > > > > +       kfree(pages);
> > > > > >  out:
> > > > > >         write_unlock(&domain->bounce_lock);
> > > > > >  }
> > > > > > @@ -543,10 +561,13 @@ static int vduse_domain_mmap(struct file =
*file, struct vm_area_struct *vma)
> > > > > >  static int vduse_domain_release(struct inode *inode, struct fi=
le *file)
> > > > > >  {
> > > > > >         struct vduse_iova_domain *domain =3D file->private_data=
;
> > > > > > +       struct page **pages;
> > > > > > +
> > > > > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(dom=
ain);
> > > > > >
> > > > > >         spin_lock(&domain->iotlb_lock);
> > > > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > > > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > > > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > > > >         spin_unlock(&domain->iotlb_lock);
> > > > > >         put_iova_domain(&domain->stream_iovad);
> > > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdp=
a/vdpa_user/iova_domain.h
> > > > > > index f92f22a7267d..17efa5555b3f 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > > > > @@ -74,7 +74,10 @@ void vduse_domain_reset_bounce_map(struct vd=
use_iova_domain *domain);
> > > > > >  int vduse_domain_add_user_bounce_pages(struct vduse_iova_domai=
n *domain,
> > > > > >                                        struct page **pages, int=
 count);
> > > > > >
> > > > > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_d=
omain *domain);
> > > > > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_d=
omain *domain,
> > > > > > +                                          struct page **pages)=
;
> > > > > > +
> > > > > > +struct page **vduse_domain_alloc_pages_to_remove_bounce(struct=
 vduse_iova_domain *domain);
> > > > > >
> > > > > >  void vduse_domain_destroy(struct vduse_iova_domain *domain);
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index 7ae99691efdf..5d8d5810df57 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -1030,6 +1030,7 @@ static int vduse_dev_queue_irq_work(struc=
t vduse_dev *dev,
> > > > > >  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > > > >                                 u64 iova, u64 size)
> > > > > >  {
> > > > > > +       struct page **pages;
> > > > > >         int ret;
> > > > > >
> > > > > >         mutex_lock(&dev->mem_lock);
> > > > > > @@ -1044,7 +1045,8 @@ static int vduse_dev_dereg_umem(struct vd=
use_dev *dev,
> > > > > >         if (dev->umem->iova !=3D iova || size !=3D dev->domain-=
>bounce_size)
> > > > > >                 goto unlock;
> > > > > >
> > > > > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > > > +       pages =3D vduse_domain_alloc_pages_to_remove_bounce(dev=
->domain);
> > > > > > +       vduse_domain_remove_user_bounce_pages(dev->domain, page=
s);
> > > > > >         unpin_user_pages_dirty_lock(dev->umem->pages,
> > > > > >                                     dev->umem->npages, true);
> > > > > >         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_=
vm);
> > > > >
> > > > > We miss a kfree(pages); here?
> > > > no.
> > > > i've moved it into vduse_domain_remove_user_bounce_pages.
> > >
> > > Ok, but it seems tricky e.g allocated by the caller but freed in
> > > callee. And I think I missed some important issues in the previous
> > > review: The check of user_bounce_pages must be done under the
> > > bounce_lock, otherwise it might race with umem_reg.
> > >
> > > So in the case of release(), we know the device is gone, so there's n=
o
> > > need to allocate pages that will be released soon. So we can pass NUL=
L
> > > as a hint and just assign bounce_page to NULL in
> > > vduse_domain_remove_user_bounce_pages().
> > >
> > > And in the case of vduse_dev_dereg_umem(), we need to allocate the
> > > pages without checking user_bounce_pages. So in
> > > vduse_domain_remove_user_bounce_pages() if we can free the allocated
> > > pages as well as the pages in the following check
> > >
> > >         if (!domain->user_bounce_pages)
> > >                 goto out;
> > >
> > > What do you think?
> >
> > I am not a vdpa guy, but  changing the current logic is another patch.
> > From mm perspective, I can only address the __GFP_NOFAIL issue.
> >
> > I actually prefer you guys handle it  directly:-) I'd rather report a B=
UG
> > instead. TBH, I know nothing about vpda.
>
> Fine, let me post a patch for this (no later than the end of this week).
>
Jason,
Thank you very much. Also, Tetsuo reminded me that kmalloc_array() might be
problematic if the count is too large:
 pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);

You might want to consider using vmalloc_array() or kvmalloc_array() instea=
d
when you send a new version.

> Thanks
>
> >
> > >
> > > Thanks
> > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > >

Thanks
Barry
