Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86F1EA91
	for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773798; cv=none; b=HkWGzkylKLHOaOsZT6YAkC8nqLhaYES+TBvy7ZsaZPAZ8VjEmP6p5VJTs9Lj7sDtJDZuQ8P4TU4iam2zGZGq2DLikzpJgfXMsfnOjKyZ907H8RV7ZU20F6O5MQ5t7+Obvj+AIvqzjTaBp5LvBGUZAk9Qez/2OWS6yWGCez60iIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773798; c=relaxed/simple;
	bh=CMSJTnZLnpRIAQBRrxwvO2/NDeze+GJ7mmql4M1z1/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSPMSuT9/ZP+0riq3WVAcatWlT3xsIODzD3VZ3NLHhyB4mz3GXRGNXP3BQTdj4KqL07/mdATiZskCvi6w9I0oZH8dMFHM/8/dtDHWlnFwqL0sjmctJawqcP1C4gP7jllTvE2Mu5c7mpCzFIP5Kxfze1UX1+MD3+0gzmzrfYL1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9tCayQW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9tCayQW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723773795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ5B0ImEQzmf8xYCie68AXiPbOARRhsWcWzXhuhzV7c=;
	b=d9tCayQW97JY+Bygpflpmjkxl7puvPqNWAUuYSghPD9TVh+F6IGNqirOx1oXmm09wOFVdk
	SIY9kEgY4BR6pLfC7mfwyHX8SayAg9ZYFw+lNUJMHyQ+69+bA5WKNHE0dLFfgsZlo2sc4r
	f4LKeHD8WYwCZveb/+zrF1c3EHFKALo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-L3lLI-ILOci6dxf-O4ksXQ-1; Thu, 15 Aug 2024 22:03:13 -0400
X-MC-Unique: L3lLI-ILOci6dxf-O4ksXQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3c4d321f4so1468368a91.2
        for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 19:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723773792; x=1724378592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ5B0ImEQzmf8xYCie68AXiPbOARRhsWcWzXhuhzV7c=;
        b=eRpNaPV4ldGZw4Opyj9Rl5SG3EPoKiXyx5wSqCkTQNeulyFQx1wbSG27L9w5JNO3Mw
         phtzGkuCPpYAE6VLf0cN46n4tpwk2EzvTEqVkjOcN1XZ7uwyUcayIagUQ0sFy1tegc/7
         V4UIS13wOq+mQFWUvuNvkcNbX1cXBrzoMHlW/lgN1qHdNFLNOjHidTd8ZEBghkMWpA5c
         EtBvpVymIcoZLHr9PsOBtR5Y/b9Y22gouQHFLALYNhfM/pRY9HnArUAhAN3TC8NOkn/1
         WRCOAXB65QX6r69dAzlWEf4RRsOksJq12ohuMKjiFlwW7XsGiqFa5x8bAQGw3EbvjAoe
         2dSg==
X-Forwarded-Encrypted: i=1; AJvYcCVzMhROvUppLVwhMAZiL4qdtCwyJNNTOOr+KZQON6bsnAyY4cVqdCAw1h9TSBn2kIK32yzRK5guI57tVs9bc30VY5Rx5ER/NrcsL/2/NOc=
X-Gm-Message-State: AOJu0YyUNHD0VRWyETO72RNX6fXrRKV/VaoQ331hSjg7JyucqTAflYoe
	ge+qMX7PNSgenp5YAvEUJY+d6cwiaRMGVWdP8i0NxhwfM8aDQc+KkABTdCkZVlnPmEj4ZG40RkC
	44xwSz6VDXJgmgY7NFEuKzZRatjx3i6YqmPBjxbh1q96M2Wl8FYNZKNkfjkpS1ecqP+pOiEsRMp
	Kvz203r4IOapcQUUGxfazuebMzeVIXvd9MpvEShSU=
X-Received: by 2002:a17:90a:f68d:b0:2ca:4a6f:1dd with SMTP id 98e67ed59e1d1-2d3e0e41f2emr1509615a91.41.1723773792351;
        Thu, 15 Aug 2024 19:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6fzU4v04t1a18oambrme/e7f79ORNtNPInVFx6f4DxC8T49Q8r2pMI2Nr5gxU60Mh9VIBV0j3weVDk2HOwrc=
X-Received: by 2002:a17:90a:f68d:b0:2ca:4a6f:1dd with SMTP id
 98e67ed59e1d1-2d3e0e41f2emr1509580a91.41.1723773791587; Thu, 15 Aug 2024
 19:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240808054320.10017-1-jasowang@redhat.com> <CAGsJ_4ze4YAOSfM5+6Wj1-EcGNaaJQ-S2Ljzm4egjRsXdDp5MA@mail.gmail.com>
In-Reply-To: <CAGsJ_4ze4YAOSfM5+6Wj1-EcGNaaJQ-S2Ljzm4egjRsXdDp5MA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Aug 2024 10:03:00 +0800
Message-ID: <CACGkMEvz3-G5U3_abVSbMoM=p7iGn54GMXQk-rpvNo4WeLMdFA@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: avoid using __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 8:17=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Aug 8, 2024 at 5:43=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Barry said [1]:
> >
> > """
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> >
> > The current code will result in returning a NULL pointer but
> > not a busy-loop.
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
> > We have two choices to address the issue:
> > 1. busy-loop
> > 2. BUG_ON
> >
> > the below patch chose 2:
> > https://lore.kernel.org/linux-mm/20240731000155.109583-5-21cnbao@gmail.=
com/
> > ""=E2=80=9C
> >
> > Unfortuantely, we do that under read lock. A possible way to fix that
> > is to move the pages allocation out of the lock into the caller, but
> > having to allocate a huge number of pages and auxiliary page array
> > seems to be problematic as well per Tetsuon [2]:
> >
> > """
> > You should implement proper error handling instead of using
> > __GFP_NOFAIL if count can become large.
> > """
> >
> > So I choose another way, which does not release kernel bounce pages
> > when user tries to register usersapce bounce pages. Then we don't need
> > to do allocation in the path which is not expected to be fail (e.g in
> > the release). We pay this for more memory usage as we don't release
> > kernel bounce pages but further optimizations could be done on top.
> >
> > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
> >
> > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce bu=
ffer")
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > Tested-by: Xie Yongji <xieyongji@bytedance.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Hi Jason,
>
> Is this the final version to fix __GFP_NOFAIL issue, or will you have a n=
ew
> version?

I think so.

> Do you prefer it to go through the mm tree or the drivers subsystem tree?

Either is fine.

> If it's the former, I can send a new version that includes this one in my
> series[1].
>
> [1] https://lore.kernel.org/linux-mm/20240731000155.109583-1-21cnbao@gmai=
l.com/

That's fine.

Thanks

>
> > ---
> > Changes since V1:
> > - Tweak the commit log
> > - Assign map->user_bounce_page to NULL for safety
> > ---
> >  drivers/vdpa/vdpa_user/iova_domain.c | 19 +++++++++++--------
> >  drivers/vdpa/vdpa_user/iova_domain.h |  1 +
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 791d38d6284c..58116f89d8da 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_d=
omain *domain,
> >                                 enum dma_data_direction dir)
> >  {
> >         struct vduse_bounce_map *map;
> > +       struct page *page;
> >         unsigned int offset;
> >         void *addr;
> >         size_t sz;
> > @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_=
domain *domain,
> >                             map->orig_phys =3D=3D INVALID_PHYS_ADDR))
> >                         return;
> >
> > -               addr =3D kmap_local_page(map->bounce_page);
> > +               page =3D domain->user_bounce_pages ?
> > +                      map->user_bounce_page : map->bounce_page;
> > +
> > +               addr =3D kmap_local_page(page);
> >                 do_bounce(map->orig_phys + offset, addr + offset, sz, d=
ir);
> >                 kunmap_local(addr);
> >                 size -=3D sz;
> > @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse=
_iova_domain *domain,
> >                                 memcpy_to_page(pages[i], 0,
> >                                                page_address(map->bounce=
_page),
> >                                                PAGE_SIZE);
> > -                       __free_page(map->bounce_page);
> >                 }
> > -               map->bounce_page =3D pages[i];
> > +               map->user_bounce_page =3D pages[i];
> >                 get_page(pages[i]);
> >         }
> >         domain->user_bounce_pages =3D true;
> > @@ -297,17 +300,17 @@ void vduse_domain_remove_user_bounce_pages(struct=
 vduse_iova_domain *domain)
> >                 struct page *page =3D NULL;
> >
> >                 map =3D &domain->bounce_maps[i];
> > -               if (WARN_ON(!map->bounce_page))
> > +               if (WARN_ON(!map->user_bounce_page))
> >                         continue;
> >
> >                 /* Copy user page to kernel page if it's in use */
> >                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> > +                       page =3D map->bounce_page;
> >                         memcpy_from_page(page_address(page),
> > -                                        map->bounce_page, 0, PAGE_SIZE=
);
> > +                                        map->user_bounce_page, 0, PAGE=
_SIZE);
> >                 }
> > -               put_page(map->bounce_page);
> > -               map->bounce_page =3D page;
> > +               put_page(map->user_bounce_page);
> > +               map->user_bounce_page =3D NULL;
> >         }
> >         domain->user_bounce_pages =3D false;
> >  out:
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_u=
ser/iova_domain.h
> > index f92f22a7267d..7f3f0928ec78 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -21,6 +21,7 @@
> >
> >  struct vduse_bounce_map {
> >         struct page *bounce_page;
> > +       struct page *user_bounce_page;
> >         u64 orig_phys;
> >  };
> >
> > --
> > 2.31.1
> >
>
> Thanks
> Barry
>

