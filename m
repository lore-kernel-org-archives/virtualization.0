Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEFFD268
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309226; cv=none; b=nibGS7eiI3Z9RRECqYB7eb5W9/rFOfu07zuq/q3PcCBUMzpiUH721GimZh6imW8Fits9ljs52EQm86NZqYh4FKtvX09r/YYn3Q+y5/jmGcJM4Il6M5LBPhFCtF7rv8TjVtVJHk10uGPXIUcvmCPornM5inuDAJJZbqj65xQEJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309226; c=relaxed/simple;
	bh=dmuu3ona78tEdHHEhl5XMOJOaDbHdkjq7jU6CtHPFas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5pfDa5EJnsd/Z/2x/839UifvkbTUq54gKFD6Kf5/zz9K4m2C3hMhtUlTsaFG3rZxMLxLA9ku5M7/QBD3zOCEsHIw8R49ZyY6u2HpsJ0MpuzyUV6+C/Iuq/2t7GCEkwLYXW2ZCBJKFdHflbTCEL7WLIzLz9BJFJd7hF3CGdESYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsUnEvfe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsUnEvfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722309220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElpoaJq7cgXiR46sT7tCwcW4SAqdUAqt5Vht5z1YmWE=;
	b=BsUnEvfe44MPE9pVgYomvvOMRXdjXNl1Slr3NfNy5cLvKfQu7gE8LygzdqDLek8vaehsJ0
	rdIuq+bLGGJ3DLlH5U1mKOwab9c4iTpT1pUxjEcBkMXO3HIYYJxb2SL5Gh4lL+vpjQPOsA
	MzZR4y+9miVKXFiphcVio209YzL9I4I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-x_GLVC7WMbCQ02CTpWBdAw-1; Mon, 29 Jul 2024 23:13:35 -0400
X-MC-Unique: x_GLVC7WMbCQ02CTpWBdAw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb5594a9f3so3747409a91.1
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 20:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722309213; x=1722914013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElpoaJq7cgXiR46sT7tCwcW4SAqdUAqt5Vht5z1YmWE=;
        b=eGZI3Ij+WnuJ03pUez+a3Ecqf/YB9Cf+JrvqqFP3+pTwdGaF8X4nBAT0nJJoY2VgPl
         wThUSy7C65S7DPU1QKsBApfbLyxAKv7TicbRyZmeR2u5XQhNb2quu8px8A8v5y+gtUsP
         skTy4vTFxXSYWnjhlQBtllp3YwfGx1GyoP8KOVsuBeMGUqCjJ9ZoN0B/6vusDLwii+Ct
         Y/e99mbVLvDzhN+dNnMQ9z85HyHC/rWVHz9bOlYq6/taNBAg2i72O+13hSY3ImHbiyuE
         GNlBJKDz2/kSmTUjzCjGgsw9JQdHRph2LiKiQELFLqEoQ1MirNbEkDXUA53sUv68ChJc
         sOnw==
X-Forwarded-Encrypted: i=1; AJvYcCXAkiYHguE9/2nPEzhkIn8xw11RdS0zZ9DQSPRSKUkKrfX7+62l0/U6Rntk4ef2Qj+UYfQrrq1Rb4xzUl7YY3Y0QKptT4aPlb9YT58ua6k=
X-Gm-Message-State: AOJu0YzrZ6/XoWgfADtBWuLLy90TL6909/+mP8cYdtBbrzrQoC20Z6eW
	OFXOhQF5XIAXq2NJgHeTjgdChROEHdyBq4CpFgH6W2X/OvIHNpfRwHtfdVk+IA4jRMO3UEjU9UR
	AJigZWe2quiCnW9pQpAqj2yQVRET74DSmHOJOgv/an+QeoTrHGvkcqyTYGXYOlJn6HRH9faRofZ
	e9NEqtSdBw+VEHChsgcjpo+hYWhIk7MBm3BtFHe+0=
X-Received: by 2002:a17:90a:8a81:b0:2c9:69cc:3a6a with SMTP id 98e67ed59e1d1-2cf7e09cf34mr7952417a91.3.1722309212995;
        Mon, 29 Jul 2024 20:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXhhfEfmFLaxu2ZeMsX0uX64bgKONohiyZeWUYv5h1gxrBLBdHym7dsmBJoejcxur4umRiVrHz2l5yia4Ao0M=
X-Received: by 2002:a17:90a:8a81:b0:2c9:69cc:3a6a with SMTP id
 98e67ed59e1d1-2cf7e09cf34mr7952379a91.3.1722309212419; Mon, 29 Jul 2024
 20:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACGkMEs49KckODWSpe7VPfTeshogni0_eOdkMO0b7zW2A5YX2w@mail.gmail.com>
 <20240729060529.93243-1-21cnbao@gmail.com> <CACGkMEuv4M_NaUQPHH59MPevGoJJoYb70LykcCODD=nUvik3ZQ@mail.gmail.com>
 <CAGsJ_4wpH0jU9C+dLu=P0haRLupYONN4KxJSeETQMFP69kMvdA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wpH0jU9C+dLu=P0haRLupYONN4KxJSeETQMFP69kMvdA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 11:13:21 +0800
Message-ID: <CACGkMEt7XCP_JG9gEexveUxTZLhSN7Q3LMYrdQzgStACtdk6Aw@mail.gmail.com>
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

On Tue, Jul 30, 2024 at 11:09=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Tue, Jul 30, 2024 at 10:49=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Jul 29, 2024 at 2:05=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Mon, Jul 29, 2024 at 3:42=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Jul 25, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.c=
om> wrote:
> > > > >
> > > > > On Thu, Jul 25, 2024 at 6:08=E2=80=AFPM Michal Hocko <mhocko@suse=
.com> wrote:
> > > > > >
> > > > > > On Thu 25-07-24 10:50:45, Barry Song wrote:
> > > > > > > On Thu, Jul 25, 2024 at 12:27=E2=80=AFAM Michal Hocko <mhocko=
@suse.com> wrote:
> > > > > > > >
> > > > > > > > On Wed 24-07-24 20:55:40, Barry Song wrote:
> > > > > > [...]
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drive=
rs/vdpa/vdpa_user/iova_domain.c
> > > > > > > > > index 791d38d6284c..eff700e5f7a2 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > > > > @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounc=
e_pages(struct vduse_iova_domain *domain)
> > > > > > > > >  {
> > > > > > > > >       struct vduse_bounce_map *map;
> > > > > > > > >       unsigned long i, count;
> > > > > > > > > +     struct page **pages =3D NULL;
> > > > > > > > >
> > > > > > > > >       write_lock(&domain->bounce_lock);
> > > > > > > > >       if (!domain->user_bounce_pages)
> > > > > > > > >               goto out;
> > > > > > > > > -
> > > > > > > > >       count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > > > > > +     write_unlock(&domain->bounce_lock);
> > > > > > > > > +
> > > > > > > > > +     pages =3D kmalloc_array(count, sizeof(*pages), GFP_=
KERNEL | __GFP_NOFAIL);
> > > > > > > > > +     for (i =3D 0; i < count; i++)
> > > > > > > > > +             pages[i] =3D alloc_page(GFP_KERNEL | __GFP_=
NOFAIL);
> > > > > > > >
> > > > > > > > AFAICS vduse_domain_release calls this function with
> > > > > > > > spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_=
lock is not
> > > > > > > > sufficient.
> > > > > > >
> > > > > > > yes. this is true:
> > > > > > >
> > > > > > > static int vduse_domain_release(struct inode *inode, struct f=
ile *file)
> > > > > > > {
> > > > > > >         struct vduse_iova_domain *domain =3D file->private_da=
ta;
> > > > > > >
> > > > > > >         spin_lock(&domain->iotlb_lock);
> > > > > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > > > >         vduse_domain_remove_user_bounce_pages(domain);
> > > > > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > > > > >         spin_unlock(&domain->iotlb_lock);
> > > > > > >         put_iova_domain(&domain->stream_iovad);
> > > > > > >         put_iova_domain(&domain->consistent_iovad);
> > > > > > >         vhost_iotlb_free(domain->iotlb);
> > > > > > >         vfree(domain->bounce_maps);
> > > > > > >         kfree(domain);
> > > > > > >
> > > > > > >         return 0;
> > > > > > > }
> > > > > > >
> > > > > > > This is quite a pain. I admit I don't have knowledge of this =
driver, and I don't
> > > > > > > think it's safe to release two locks and then reacquire them.=
 The situation is
> > > > > > > rather complex. Therefore, I would prefer if the VDPA maintai=
ners could
> > > > > > > take the lead in implementing a proper fix.
> > > > > >
> > > > > > Would it be possible to move all that work to a deferred contex=
t?
> > > > >
> > > > > My understanding is that we need to be aware of both the iotlb_lo=
ck and
> > > > > bounce_lock to implement the correct changes. As long as we still=
 need
> > > > > to acquire these two locks in a deferred context, there doesn't s=
eem to
> > > > > be any difference.
> > > > >
> > > > > I can do the memory pre-allocation before spin_lock(&domain->iotl=
b_lock),
> > > > > but I have no knowledge whether the "count" will change after I m=
ake
> > > > > the preallocation.
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > index 791d38d6284c..7ec87ef33d42 100644
> > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > @@ -544,9 +544,12 @@ static int vduse_domain_release(struct inode
> > > > > *inode, struct file *file)
> > > > >  {
> > > > >         struct vduse_iova_domain *domain =3D file->private_data;
> > > > >
> > > > > +      struct page **pages;
> > > > > +      spin_lock(&domain->iotlb_lock); maybe also + bounce_lock?
> > > > > +      count =3D domain->bounce_size >> PAGE_SHIFT;
> > > > > +      spin_unlock(&domain->iotlb_lock);
> > > >
> > > > We probably don't need any lock here as bounce_size won't be change=
d .
> > > >
> > > > > +
> > > > > +       preallocate_count_pages(pages, count);
> > > > > +
> > > > > ....
> > > > >         spin_lock(&domain->iotlb_lock);
> > > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > > >         spin_unlock(&domain->iotlb_lock);
> > > > >         put_iova_domain(&domain->stream_iovad);
> > > >
> > > > This seems to work.
> > >
> > > Thanks, Jason. I personally have no knowledge of vDPA. Could you plea=
se help
> > > review and test the patch below?
> > >
> > > From 1f3cae091159bfcaffdb4a999a4a8e37db2eacf1 Mon Sep 17 00:00:00 200=
1
> > > From: Barry Song <v-songbaohua@oppo.com>
> > > Date: Wed, 24 Jul 2024 20:55:40 +1200
> > > Subject: [PATCH RFC v2] vpda: try to fix the potential crash due to m=
isusing
> > >  __GFP_NOFAIL
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=3DUTF-8
> > > Content-Transfer-Encoding: 8bit
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
> > > [RFC]: This has only been compile-tested; I'd prefer if the VDPA main=
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
> > >  drivers/vdpa/vdpa_user/iova_domain.c | 21 ++++++++++++++++-----
> > >  drivers/vdpa/vdpa_user/iova_domain.h |  3 ++-
> > >  drivers/vdpa/vdpa_user/vduse_dev.c   | 13 ++++++++++++-
> > >  3 files changed, 30 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa=
_user/iova_domain.c
> > > index 791d38d6284c..014809ac2b7c 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > @@ -283,7 +283,7 @@ int vduse_domain_add_user_bounce_pages(struct vdu=
se_iova_domain *domain,
> > >         return ret;
> > >  }
> > >
> > > -void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain =
*domain)
> > > +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain =
*domain, struct page **pages)
> > >  {
> > >         struct vduse_bounce_map *map;
> > >         unsigned long i, count;
> > > @@ -294,15 +294,16 @@ void vduse_domain_remove_user_bounce_pages(stru=
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
> > > @@ -543,10 +544,19 @@ static int vduse_domain_mmap(struct file *file,=
 struct vm_area_struct *vma)
> > >  static int vduse_domain_release(struct inode *inode, struct file *fi=
le)
> > >  {
> > >         struct vduse_iova_domain *domain =3D file->private_data;
> > > +       struct page **pages =3D NULL;
> > > +       unsigned long count, i;
> > > +
> > > +       if (domain->user_bounce_pages) {
> > > +               count =3D domain->bounce_size >> PAGE_SHIFT;
> > > +               pages =3D kmalloc_array(count, sizeof(*pages), GFP_KE=
RNEL | __GFP_NOFAIL);
> > > +               for (i =3D 0; i < count; i++)
> > > +                       pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NO=
FAIL);
> > > +       }
> > >
> > >         spin_lock(&domain->iotlb_lock);
> > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > -       vduse_domain_remove_user_bounce_pages(domain);
> > > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> > >         vduse_domain_free_kernel_bounce_pages(domain);
> > >         spin_unlock(&domain->iotlb_lock);
> > >         put_iova_domain(&domain->stream_iovad);
> > > @@ -554,6 +564,7 @@ static int vduse_domain_release(struct inode *ino=
de, struct file *file)
> > >         vhost_iotlb_free(domain->iotlb);
> > >         vfree(domain->bounce_maps);
> > >         kfree(domain);
> > > +       kfree(pages);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa=
_user/iova_domain.h
> > > index f92f22a7267d..db0b793d86db 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > @@ -74,7 +74,8 @@ void vduse_domain_reset_bounce_map(struct vduse_iov=
a_domain *domain);
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
> > >
> > >  void vduse_domain_destroy(struct vduse_iova_domain *domain);
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 7ae99691efdf..df7c1b6f1350 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1030,6 +1030,8 @@ static int vduse_dev_queue_irq_work(struct vdus=
e_dev *dev,
> > >  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > >                                 u64 iova, u64 size)
> > >  {
> > > +       struct page **pages =3D NULL;
> > > +       unsigned long count, i;
> > >         int ret;
> > >
> > >         mutex_lock(&dev->mem_lock);
> > > @@ -1044,13 +1046,22 @@ static int vduse_dev_dereg_umem(struct vduse_=
dev *dev,
> > >         if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounc=
e_size)
> > >                 goto unlock;
> > >
> > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > +       if (dev->domain->user_bounce_pages) {
> > > +               count =3D dev->domain->bounce_size >> PAGE_SHIFT;
> > > +               pages =3D kmalloc_array(count, sizeof(*pages),
> > > +                                     GFP_KERNEL | __GFP_NOFAIL);
> > > +               for (i =3D 0; i < count; i++)
> > > +                       pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NO=
FAIL);
> > > +       }
> >
> > Nit: there's some code duplication with vduse_domain_release().
> >
> > Others look good to me.
> >
> > Would you like to post a formal patch?
>
>  Jason, thanks!
>
> I haven't tested this patch and I don't have the setup to test. I
> wonder if you can
> post a tested-by tag before I send a formal patch.

Maybe a RFT tag then I can do a test?

>
> BTW, if we want to have a common function to remove the duplicated code,
> what is the name you suggest to have for this function?

Something like vduse_alloc_pages()? (not a native speaker)

Thanks

>
> >
> > Thanks
> >
> > > +
> > > +       vduse_domain_remove_user_bounce_pages(dev->domain, pages);
> > >         unpin_user_pages_dirty_lock(dev->umem->pages,
> > >                                     dev->umem->npages, true);
> > >         atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > >         mmdrop(dev->umem->mm);
> > >         vfree(dev->umem->pages);
> > >         kfree(dev->umem);
> > > +       kfree(pages);
> > >         dev->umem =3D NULL;
> > >         ret =3D 0;
> > >  unlock:
> > > --
> > > 2.34.1
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > > > --
> > > > > > Michal Hocko
> > > > > > SUSE Labs
> > > > >
> > >
> > > Thanks
> > > Barry
> > >
> >
>
> Thanks
> Barry
>

