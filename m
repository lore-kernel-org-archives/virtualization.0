Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E0433C1
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308935; cv=none; b=WsQbEGpsZnTU+cqAZVaierRI+1Pop37eL7i3+H2ymQPRRjcfDsDI7VmrBGDp8cxo/NqN9sDGV/vFMLsBg6gQ6QxYqsM0ElkFFiLtCioJFcfPxIRAcfAtkwavIWhvtzHpVlHnVMW0+vSO9GYNyeqetfMyJg0qK2muZzdbWbQS9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308935; c=relaxed/simple;
	bh=9/NM6JIMT4mcCZIPnnnx/bC2JrZm+kMRCRtriAqlKQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cv+9lVrbGjGMOwc98J1/Ws1tJFWGiktkgEUEQ/UibcjZR+ZJ8FRgBXYAAbeJUBuwnY0rZhf9SjTksL1vl43sewGizUli7juh2io3taY0Ax1e5o+i4iENj5kqZvKhspy7TmPmcR5MvaS+fZwxHL+AT4gh4po+dViusnkVhueHtuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUovSAKn; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUovSAKn"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-831a5b7d250so1103919241.3
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 20:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722308932; x=1722913732; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGwHErpXzosqNy0EwP2+ZXrgOtRglWVeO8E0C/27bD8=;
        b=dUovSAKnnh6iTD/sszMfFIgKdHITf+GFV8AzkdI07YRSsDtFSM7exnO4TdKjz1VWeh
         z2Oyc9VBzX3UTU0DBDLRxrZ3oB1CJHaFOIKF4ou/gAd6GaR3V09JhSKVemwvy8fCEWd3
         qo9AMgvZY3HcUohnRRWQCYS9Ka5sDT15ZtnP42twDgz2lSszby8BVNrSxLNZepBNeDQo
         FDXLkbuMWncU3CdP1kJMkaqAeMx9sxpJY1KFS+k5UXAsIyscWPE8Lky8OO/J92XgSvE/
         RFce7kL/ln2hwdBOkSjN1UnGLc5AJ/SuTdHRLn+OV/o+UR+O6DSnVyx6BDBGyPsy8tIw
         /hSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722308932; x=1722913732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGwHErpXzosqNy0EwP2+ZXrgOtRglWVeO8E0C/27bD8=;
        b=mM6mk0B31pyMb9+WEqFEa/3PSM5RnyBmISscWDI0TcL5HcpHPoTBaOKWGx8Hx/KOFs
         UjBuPpWE2vF77SklX59C7fOYtPp4EJNgIiMqxG7geeu0f92fCZDy5MRNuSHLbCfxos6G
         at52Ol8qTKumw9ucdRgLAgNuC2QY5+inf7SqARJhe8YiNKlnisiCawiZHBRZxOR/U615
         FrY6fHARX0Hb0RFpUN2GyvOUasX8+TNrkfjFvurW1FHqV2JiZF71zCo+8dU2gwtaW3ZS
         GXx2pMxQrIg+ZxlhbwYS2EuLPVO1FHxFkLyyVaAg0BJNLlNvQ47OoHzNmAguAJ/tNBM1
         m12Q==
X-Forwarded-Encrypted: i=1; AJvYcCWt3h/9LAHXLGSRc8B1x4bFLOv/rwl3yFUiEQzsD7ZBQ8jUBO2zWshNvRb2ThPnn8AfpU6j9X+L2TXUWdslfwzqKXp8zLx9NEffqJRBhzg=
X-Gm-Message-State: AOJu0YxfEPhYKlO09zZsBfxH6Bx6MKLrKd9dB+JwPGVhpkmznaYOjggQ
	BtkYUHeQUveKZxq12M3mPI3cDNqRx7zh10Bh5FiqLNyyOO1qIsh5TCwqvnlo6J6rJo5RtJUvd6n
	rX373lZ687/JI5ZKffQnw2xUKtk0=
X-Google-Smtp-Source: AGHT+IEhuAQNKawilTtLqMQ1DZGdifl+qDGJs63nG9lYXmHxbBimB9J6YK/+7Ez1HthG1YMQqgWwy9agjivJOrf2fjk=
X-Received: by 2002:a05:6102:38ce:b0:492:9394:d2e with SMTP id
 ada2fe7eead31-493fa1c7700mr11219166137.16.1722308932107; Mon, 29 Jul 2024
 20:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACGkMEs49KckODWSpe7VPfTeshogni0_eOdkMO0b7zW2A5YX2w@mail.gmail.com>
 <20240729060529.93243-1-21cnbao@gmail.com> <CACGkMEuv4M_NaUQPHH59MPevGoJJoYb70LykcCODD=nUvik3ZQ@mail.gmail.com>
In-Reply-To: <CACGkMEuv4M_NaUQPHH59MPevGoJJoYb70LykcCODD=nUvik3ZQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 30 Jul 2024 11:08:40 +0800
Message-ID: <CAGsJ_4wpH0jU9C+dLu=P0haRLupYONN4KxJSeETQMFP69kMvdA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com, 
	eperezma@redhat.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, linux-mm@kvack.org, lstoakes@gmail.com, 
	maxime.coquelin@redhat.com, mhocko@suse.com, mst@redhat.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, 
	torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 10:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jul 29, 2024 at 2:05=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Mon, Jul 29, 2024 at 3:42=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Jul 25, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > On Thu, Jul 25, 2024 at 6:08=E2=80=AFPM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > > >
> > > > > On Thu 25-07-24 10:50:45, Barry Song wrote:
> > > > > > On Thu, Jul 25, 2024 at 12:27=E2=80=AFAM Michal Hocko <mhocko@s=
use.com> wrote:
> > > > > > >
> > > > > > > On Wed 24-07-24 20:55:40, Barry Song wrote:
> > > > > [...]
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers=
/vdpa/vdpa_user/iova_domain.c
> > > > > > > > index 791d38d6284c..eff700e5f7a2 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > > > @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_=
pages(struct vduse_iova_domain *domain)
> > > > > > > >  {
> > > > > > > >       struct vduse_bounce_map *map;
> > > > > > > >       unsigned long i, count;
> > > > > > > > +     struct page **pages =3D NULL;
> > > > > > > >
> > > > > > > >       write_lock(&domain->bounce_lock);
> > > > > > > >       if (!domain->user_bounce_pages)
> > > > > > > >               goto out;
> > > > > > > > -
> > > > > > > >       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > > > > +     write_unlock(&domain->bounce_lock);
> > > > > > > > +
> > > > > > > > +     pages =3D kmalloc_array(count, sizeof(*pages), GFP_KE=
RNEL | __GFP_NOFAIL);
> > > > > > > > +     for (i =3D 0; i < count; i++)
> > > > > > > > +             pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NO=
FAIL);
> > > > > > >
> > > > > > > AFAICS vduse_domain_release calls this function with
> > > > > > > spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_lo=
ck is not
> > > > > > > sufficient.
> > > > > >
> > > > > > yes. this is true:
> > > > > >
> > > > > > static int vduse_domain_release(struct inode *inode, struct fil=
e *file)
> > > > > > {
> > > > > >         struct vduse_iova_domain *domain =3D file->private_data=
;
> > > > > >
> > > > > >         spin_lock(&domain->iotlb_lock);
> > > > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > > >         vduse_domain_remove_user_bounce_pages(domain);
> > > > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > > > >         spin_unlock(&domain->iotlb_lock);
> > > > > >         put_iova_domain(&domain->stream_iovad);
> > > > > >         put_iova_domain(&domain->consistent_iovad);
> > > > > >         vhost_iotlb_free(domain->iotlb);
> > > > > >         vfree(domain->bounce_maps);
> > > > > >         kfree(domain);
> > > > > >
> > > > > >         return 0;
> > > > > > }
> > > > > >
> > > > > > This is quite a pain. I admit I don't have knowledge of this dr=
iver, and I don't
> > > > > > think it's safe to release two locks and then reacquire them. T=
he situation is
> > > > > > rather complex. Therefore, I would prefer if the VDPA maintaine=
rs could
> > > > > > take the lead in implementing a proper fix.
> > > > >
> > > > > Would it be possible to move all that work to a deferred context?
> > > >
> > > > My understanding is that we need to be aware of both the iotlb_lock=
 and
> > > > bounce_lock to implement the correct changes. As long as we still n=
eed
> > > > to acquire these two locks in a deferred context, there doesn't see=
m to
> > > > be any difference.
> > > >
> > > > I can do the memory pre-allocation before spin_lock(&domain->iotlb_=
lock),
> > > > but I have no knowledge whether the "count" will change after I mak=
e
> > > > the preallocation.
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > index 791d38d6284c..7ec87ef33d42 100644
> > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > @@ -544,9 +544,12 @@ static int vduse_domain_release(struct inode
> > > > *inode, struct file *file)
> > > >  {
> > > >         struct vduse_iova_domain *domain =3D file->private_data;
> > > >
> > > > +      struct page **pages;
> > > > +      spin_lock(&domain->iotlb_lock); maybe also + bounce_lock?
> > > > +      count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > +      spin_unlock(&domain->iotlb_lock);
> > >
> > > We probably don't need any lock here as bounce_size won't be changed =
.
> > >
> > > > +
> > > > +       preallocate_count_pages(pages, count);
> > > > +
> > > > ....
> > > >         spin_lock(&domain->iotlb_lock);
> > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > >         spin_unlock(&domain->iotlb_lock);
> > > >         put_iova_domain(&domain->stream_iovad);
> > >
> > > This seems to work.
> >
> > Thanks, Jason. I personally have no knowledge of vDPA. Could you please=
 help
> > review and test the patch below?
> >
> > From 1f3cae091159bfcaffdb4a999a4a8e37db2eacf1 Mon Sep 17 00:00:00 2001
> > From: Barry Song <v-songbaohua@oppo.com>
> > Date: Wed, 24 Jul 2024 20:55:40 +1200
> > Subject: [PATCH RFC v2] vpda: try to fix the potential crash due to mis=
using
> >  __GFP_NOFAIL
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
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
> > [RFC]: This has only been compile-tested; I'd prefer if the VDPA mainta=
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
> >  drivers/vdpa/vdpa_user/iova_domain.c | 21 ++++++++++++++++-----
> >  drivers/vdpa/vdpa_user/iova_domain.h |  3 ++-
> >  drivers/vdpa/vdpa_user/vduse_dev.c   | 13 ++++++++++++-
> >  3 files changed, 30 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 791d38d6284c..014809ac2b7c 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -283,7 +283,7 @@ int vduse_domain_add_user_bounce_pages(struct vduse=
_iova_domain *domain,
> >         return ret;
> >  }
> >
> > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *d=
omain)
> > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *d=
omain, struct page **pages)
> >  {
> >         struct vduse_bounce_map *map;
> >         unsigned long i, count;
> > @@ -294,15 +294,16 @@ void vduse_domain_remove_user_bounce_pages(struct=
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
> > @@ -543,10 +544,19 @@ static int vduse_domain_mmap(struct file *file, s=
truct vm_area_struct *vma)
> >  static int vduse_domain_release(struct inode *inode, struct file *file=
)
> >  {
> >         struct vduse_iova_domain *domain =3D file->private_data;
> > +       struct page **pages =3D NULL;
> > +       unsigned long count, i;
> > +
> > +       if (domain->user_bounce_pages) {
> > +               count =3D domain->bounce_size >> PAGE_SHIFT;
> > +               pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERN=
EL | __GFP_NOFAIL);
> > +               for (i =3D 0; i < count; i++)
> > +                       pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFA=
IL);
> > +       }
> >
> >         spin_lock(&domain->iotlb_lock);
> >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > -       vduse_domain_remove_user_bounce_pages(domain);
> > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> >         vduse_domain_free_kernel_bounce_pages(domain);
> >         spin_unlock(&domain->iotlb_lock);
> >         put_iova_domain(&domain->stream_iovad);
> > @@ -554,6 +564,7 @@ static int vduse_domain_release(struct inode *inode=
, struct file *file)
> >         vhost_iotlb_free(domain->iotlb);
> >         vfree(domain->bounce_maps);
> >         kfree(domain);
> > +       kfree(pages);
> >
> >         return 0;
> >  }
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_u=
ser/iova_domain.h
> > index f92f22a7267d..db0b793d86db 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -74,7 +74,8 @@ void vduse_domain_reset_bounce_map(struct vduse_iova_=
domain *domain);
> >  int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domai=
n,
> >                                        struct page **pages, int count);
> >
> > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *d=
omain);
> > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *d=
omain,
> > +                                          struct page **pages);
> >
> >  void vduse_domain_destroy(struct vduse_iova_domain *domain);
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 7ae99691efdf..df7c1b6f1350 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1030,6 +1030,8 @@ static int vduse_dev_queue_irq_work(struct vduse_=
dev *dev,
> >  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> >                                 u64 iova, u64 size)
> >  {
> > +       struct page **pages =3D NULL;
> > +       unsigned long count, i;
> >         int ret;
> >
> >         mutex_lock(&dev->mem_lock);
> > @@ -1044,13 +1046,22 @@ static int vduse_dev_dereg_umem(struct vduse_de=
v *dev,
> >         if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_=
size)
> >                 goto unlock;
> >
> > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > +       if (dev->domain->user_bounce_pages) {
> > +               count =3D dev->domain->bounce_size >> PAGE_SHIFT;
> > +               pages =3D kmalloc_array(count, sizeof(*pages),
> > +                                     GFP_KERNEL | __GFP_NOFAIL);
> > +               for (i =3D 0; i < count; i++)
> > +                       pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFA=
IL);
> > +       }
>
> Nit: there's some code duplication with vduse_domain_release().
>
> Others look good to me.
>
> Would you like to post a formal patch?

 Jason, thanks!

I haven't tested this patch and I don't have the setup to test. I
wonder if you can
post a tested-by tag before I send a formal patch.

BTW, if we want to have a common function to remove the duplicated code,
what is the name you suggest to have for this function?

>
> Thanks
>
> > +
> > +       vduse_domain_remove_user_bounce_pages(dev->domain, pages);
> >         unpin_user_pages_dirty_lock(dev->umem->pages,
> >                                     dev->umem->npages, true);
> >         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> >         mmdrop(dev->umem->mm);
> >         vfree(dev->umem->pages);
> >         kfree(dev->umem);
> > +       kfree(pages);
> >         dev->umem =3D NULL;
> >         ret =3D 0;
> >  unlock:
> > --
> > 2.34.1
> >
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > > --
> > > > > Michal Hocko
> > > > > SUSE Labs
> > > >
> >
> > Thanks
> > Barry
> >
>

Thanks
Barry
