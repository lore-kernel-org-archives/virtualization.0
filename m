Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532A156962
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263920; cv=none; b=Rk2Bpn2BgS4G0Zhsc+GoBzXWu5VeBqgDeMyuhBPuWzJMAf3vaOQjfGou2oVZobuDHEKw0CU5TL5NyipHDEw2Zhj+zR0iu3EAq6jDP4hyoE46c4qohQ0MHmqmDVzoj9mRJSXvvKTsZd01QN7nZ0Ubx4J6vzEg12S3kaMnv6wzoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263920; c=relaxed/simple;
	bh=IxM25vSyJxW75XZXKrdgavh9IB9lsNbAK0oapSqw2g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b13OLBfrwiqFPXxPu+naJWcUMYkil+Lhtw9CkyvI10xHwCluB2Yhgmjgbp7LOZxDrj57V/3Fyclw2dki/F1rpGF7Wq3Z6nVeDAcbWvup3t7xhQyo/PMCu0Vv3fMtNphEFjE6dMOX39q3sfo9Lcqz0wrWN51I6Z20qGURJbH/KUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li76+CLx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li76+CLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725263916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NECJn/hf3RY85bFxDr+7/yBNmaMtfM+SK6hVtERdSsI=;
	b=Li76+CLx15865SQYIQrTftztbREfCj5PXbSzW77zrANuWojlOficxLAO+idWbvdXB1Yc6V
	bdRXbxgoJyhEWnN1P59g/EDSv3fan0dp4VPbJCVbnvZ7SoK1UoxYraN7y9LUtHwdCFLQAF
	xAcc7PtNfAH07U4Pgwmac2SNUgYpbC0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-redEH4VxPUSwZR-8NeEfrQ-1; Mon, 02 Sep 2024 03:58:35 -0400
X-MC-Unique: redEH4VxPUSwZR-8NeEfrQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d877d7f9b4so2531099a91.3
        for <virtualization@lists.linux.dev>; Mon, 02 Sep 2024 00:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725263914; x=1725868714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NECJn/hf3RY85bFxDr+7/yBNmaMtfM+SK6hVtERdSsI=;
        b=Y0/3Sj9ccFsNV1sDW/lq9s8TICpvuY5qVdUjMdiGIMOxtrXURY7pCJ+Z/UYVB/WMJb
         Fu+iTLYjn9IbgWGJ6uK6Fk59psq7KaYPACXVmBHa8V92nSYfxXIAbMFLFl+wkUlDlqlc
         wAmllzF2++U7IYPoqu2TFkxwzcdlUYqIwIHn1pMhasW10g4u9PH9Ty6NMoM3DhVdYkIp
         Srni37zGNquvcuwQY8zkkVwnkFZ9J7RuTLp3kXhyG6UuHmVJAhphKlsSiikfLeasJLPx
         FFKJhSWfyjmSH1QRxQFqvt5aUUCI+sK5217qvxXDArGG0CM+p7T7fz3MzeCa08C5b7KC
         rhzA==
X-Forwarded-Encrypted: i=1; AJvYcCWmrQPTOo1vdauYWENJTnST4MGw8tcFvzkeVjhxqsyiO4BIWIJ+W5YeXFrgTmZbbiQmIapzmBCgO08vpZsK1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFqKGrtqoe2tV0u7ER4EWnG2f///rnRKgvPQ3iW0Nt9U6Sn1xg
	xqozbk5afnPtvEv73ZGYQ+X6bZYODv5lMPjSOg5CaTUUUb4vYdbnJ6wY64JGL7dkBcEVkFCj9XS
	eQ7MXxct4x8/up6gwJPtw2+Swop+ZxU/LQpXQ58M9qJ+BEWqFKr4xuOmgKjPqNBEPNCA3FvBXai
	I3o8QIWkEaXf9OOWRqRkQmmN74lA724+0hz2XyUSM=
X-Received: by 2002:a17:90b:1897:b0:2d8:9226:aa94 with SMTP id 98e67ed59e1d1-2d89226bbabmr5419791a91.1.1725263914611;
        Mon, 02 Sep 2024 00:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyHZ6f1mIMCnXW8b12KM4KaR2GDnh0unB84S72waJyrJzC11O44dTASCgepEPNt1ZH+w8lYR5yZ1H/ZVzQ1sk=
X-Received: by 2002:a17:90b:1897:b0:2d8:9226:aa94 with SMTP id
 98e67ed59e1d1-2d89226bbabmr5419775a91.1.1725263914061; Mon, 02 Sep 2024
 00:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240830202823.21478-1-21cnbao@gmail.com> <20240830202823.21478-2-21cnbao@gmail.com>
 <0804627b-49da-4ee0-a09a-19b87a7fdc3d@redhat.com>
In-Reply-To: <0804627b-49da-4ee0-a09a-19b87a7fdc3d@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 2 Sep 2024 15:58:22 +0800
Message-ID: <CACGkMEtwmtSKFY2GzoNvEQzFq5wYUasf94GKqjGQKyShoqxo+A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vduse: avoid using __GFP_NOFAIL
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, 42.hyeyoo@gmail.com, cl@linux.com, 
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, laoar.shao@gmail.com, 
	Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:33=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 30.08.24 22:28, Barry Song wrote:
> > From: Jason Wang <jasowang@redhat.com>
> >
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > persisting in providing __GFP_NOFAIL services for non-block users
> > who cannot perform direct memory reclaim may only result in an
> > endless busy loop.
> >
> > Therefore, in such cases, the current mm-core may directly return
> > a NULL pointer:
> >
> > static inline struct page *
> > __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >                                                  struct alloc_context *=
ac)
> > {
> >          ...
> >          if (gfp_mask & __GFP_NOFAIL) {
> >                  /*
> >                   * All existing users of the __GFP_NOFAIL are blockabl=
e, so warn
> >                   * of any new users that actually require GFP_NOWAIT
> >                   */
> >                  if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> >                          goto fail;
> >                  ...
> >          }
> >          ...
> > fail:
> >          warn_alloc(gfp_mask, ac->nodemask,
> >                          "page allocation failure: order:%u", order);
> > got_pg:
> >          return page;
> > }
> >
> > Unfortuantely, vpda does that nofail allocation under non-sleepable
> > lock. A possible way to fix that is to move the pages allocation out
> > of the lock into the caller, but having to allocate a huge number of
> > pages and auxiliary page array seems to be problematic as well per
> > Tetsuon: " You should implement proper error handling instead of
> > using __GFP_NOFAIL if count can become large."
> >
> > So I choose another way, which does not release kernel bounce pages
> > when user tries to register userspace bounce pages. Then we can
> > avoid allocating in paths where failure is not expected.(e.g in
> > the release). We pay this for more memory usage as we don't release
> > kernel bounce pages but further optimizations could be done on top.
> >
> > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce bu=
ffer")
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > Tested-by: Xie Yongji <xieyongji@bytedance.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > [v-songbaohua@oppo.com: Refine the changelog]
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   drivers/vdpa/vdpa_user/iova_domain.c | 19 +++++++++++--------
> >   drivers/vdpa/vdpa_user/iova_domain.h |  1 +
> >   2 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 791d38d6284c..58116f89d8da 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_d=
omain *domain,
> >                               enum dma_data_direction dir)
> >   {
> >       struct vduse_bounce_map *map;
> > +     struct page *page;
> >       unsigned int offset;
> >       void *addr;
> >       size_t sz;
> > @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_=
domain *domain,
> >                           map->orig_phys =3D=3D INVALID_PHYS_ADDR))
> >                       return;
> >
> > -             addr =3D kmap_local_page(map->bounce_page);
> > +             page =3D domain->user_bounce_pages ?
> > +                    map->user_bounce_page : map->bounce_page;
> > +
> > +             addr =3D kmap_local_page(page);
> >               do_bounce(map->orig_phys + offset, addr + offset, sz, dir=
);
> >               kunmap_local(addr);
> >               size -=3D sz;
> > @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse=
_iova_domain *domain,
> >                               memcpy_to_page(pages[i], 0,
> >                                              page_address(map->bounce_p=
age),
> >                                              PAGE_SIZE);
> > -                     __free_page(map->bounce_page);
> >               }
> > -             map->bounce_page =3D pages[i];
> > +             map->user_bounce_page =3D pages[i];
> >               get_page(pages[i]);
> >       }
> >       domain->user_bounce_pages =3D true;
> > @@ -297,17 +300,17 @@ void vduse_domain_remove_user_bounce_pages(struct=
 vduse_iova_domain *domain)
> >               struct page *page =3D NULL;
> >
> >               map =3D &domain->bounce_maps[i];
> > -             if (WARN_ON(!map->bounce_page))
> > +             if (WARN_ON(!map->user_bounce_page))
> >                       continue;
> >
> >               /* Copy user page to kernel page if it's in use */
> >               if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> > -                     page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> > +                     page =3D map->bounce_page;
>
> Why don't we need a kmap_local_page(map->bounce_page) here, but we might
> perform one / have performed one in vduse_domain_bounce?

I think it's another bug that needs to be fixed.

Yongji, do you want to fix this?

Thanks

>
> Maybe we should simply use
>
> memcpy_page(map->bounce_page, 0, map->user_bounce_page, 0, PAGE_SIZE)
>
> ?
>
>
> --
> Cheers,
>
> David / dhildenb
>

