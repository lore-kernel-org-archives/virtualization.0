Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360C4A0A
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725323775; cv=none; b=PGTN7XMa9LBY+vgTcWfZMQXYqJ7P+c4Mx+kehLy38pjGV83OTc3Hbd8f3fLe+Wzso3pplj+dPqdKqS5S0e9i9fmd/2FMEPYRKe3LLFQCbPhtZFpM7VRVrHCs4kwEoCVdECpdCLJz1WX7E4m/ac9DWmaDdHzAAoB1YsVZQy5/Xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725323775; c=relaxed/simple;
	bh=kq54eIqNQqsvrnECZjz/XyIFyuULPkZleg9oXRryQl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQogf7Wdb5aeKgWFomkLV6W9XBsvzwheCU+HRbQjXp09ay60WTrkLytnVLabqXKCU4irDuYpYWVXUzLaJqo7L9u1izMFABAyfm228JgwCC5m7VEG44elHbKpjzq+Up5Ar9+UYrH07r6Dg2Q27KLIYK3ktBtz0Slx/NzVUb5bU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQo33qHZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQo33qHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725323773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNYgwgbX+AdqyBu8oPb0eLYitaIrgeI5+U9GRPp9PIA=;
	b=aQo33qHZzmpBDZ8dSWDR7NGBsVcpUKnRuI4WgVJbgimSapMDwDvdJc3p8fyIWPedjz9TZ3
	A4Hto9TULLergzpiGMTB73oq+S2u/dY57MJBnjQj5SFomjmJRb7sKTh2I0ZPu8yjLp1zFT
	INfxaZgWloGZ+Pf58QeV1pAIklkas9Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-M-G4d1E8PnimrhUChd7SUw-1; Mon, 02 Sep 2024 20:36:11 -0400
X-MC-Unique: M-G4d1E8PnimrhUChd7SUw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso3811867a12.0
        for <virtualization@lists.linux.dev>; Mon, 02 Sep 2024 17:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725323771; x=1725928571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNYgwgbX+AdqyBu8oPb0eLYitaIrgeI5+U9GRPp9PIA=;
        b=Jn2YnDBLJORncXf/xLoSeW28L58TaM++4mkpcI+ApkRhmAcnguQ1Fjyfc8MSPq91Vm
         FMftn9NvHKipMIDD64TbzlYPrTI9+ioA2crMzKRs2oEc0VLex8FQXrUbArBZ1xz62IEu
         QZ07pUdVIWYKuJqbDyHv2I/vVmmgjDjDEp7QBJmi+rF75ZGs8YfEAQ2He5f4aK5G608Y
         fbtXkhCZxv8epn2KC3psIWBSbGkXcAUY+A4i45FxXxYGaxkco4hDp1QqcgpG8QvFLBnD
         wcWzATWDqMnArGLku4pZsN5nNCt40va4SwnxGEqokNMFk/Gio5lo8tC/KD+K5gjkKVDs
         Fb8A==
X-Forwarded-Encrypted: i=1; AJvYcCVRp/Uf3/spTtnENjvK9k6BDxnJIZLuT/0l7idia0ScN3/sCwJmON+nmJQ3nIkdmkGX8YEziQEmK1Nl7P47RA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMBQCHRh3NcCO5mkD1YTPwTuwArZKn6vx/9jSsj4qjKl5vxFF+
	rnAxH23UiiMf8iM4O7RLvwWhYzZv7NMS015sTiyZiMN/eatN5D9KiwkWwE7HP9lpfHYhoL3mbNz
	1LxZOYKUqaPxqbi3CnjzVmVEGRLZK47cRnxK9Fr6m2NNIiiYQ3olzGwhl3iFK1+yRA0bGo9t7yz
	XHhw1Lf3MLf0tcB1VRfS8cbqYkHI9VncjNgW8IM3w=
X-Received: by 2002:a17:902:da84:b0:205:5bc9:37df with SMTP id d9443c01a7336-2055bc93a76mr91587935ad.30.1725323770842;
        Mon, 02 Sep 2024 17:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr172wcAJdS9YPgUVg44xHiQjMvqrmTor8v5kr0wfkmFU8k8NWQKur45nn4LsoWrLg3gJT1O7fkvFB8FRHtvQ=
X-Received: by 2002:a17:902:da84:b0:205:5bc9:37df with SMTP id
 d9443c01a7336-2055bc93a76mr91587415ad.30.1725323770020; Mon, 02 Sep 2024
 17:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240830202823.21478-1-21cnbao@gmail.com> <20240830202823.21478-2-21cnbao@gmail.com>
 <0804627b-49da-4ee0-a09a-19b87a7fdc3d@redhat.com> <CACGkMEtwmtSKFY2GzoNvEQzFq5wYUasf94GKqjGQKyShoqxo+A@mail.gmail.com>
 <b2174d62-b226-4ee3-9363-ab3c9a0b51ca@redhat.com>
In-Reply-To: <b2174d62-b226-4ee3-9363-ab3c9a0b51ca@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Sep 2024 08:35:58 +0800
Message-ID: <CACGkMEvzCJpTsjA4niTWCn5ygu2FeJPGEBnu6ae69G-_PiROpQ@mail.gmail.com>
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

On Mon, Sep 2, 2024 at 4:30=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 02.09.24 09:58, Jason Wang wrote:
> > On Mon, Sep 2, 2024 at 3:33=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 30.08.24 22:28, Barry Song wrote:
> >>> From: Jason Wang <jasowang@redhat.com>
> >>>
> >>> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> >>> persisting in providing __GFP_NOFAIL services for non-block users
> >>> who cannot perform direct memory reclaim may only result in an
> >>> endless busy loop.
> >>>
> >>> Therefore, in such cases, the current mm-core may directly return
> >>> a NULL pointer:
> >>>
> >>> static inline struct page *
> >>> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >>>                                                   struct alloc_contex=
t *ac)
> >>> {
> >>>           ...
> >>>           if (gfp_mask & __GFP_NOFAIL) {
> >>>                   /*
> >>>                    * All existing users of the __GFP_NOFAIL are block=
able, so warn
> >>>                    * of any new users that actually require GFP_NOWAI=
T
> >>>                    */
> >>>                   if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask)=
)
> >>>                           goto fail;
> >>>                   ...
> >>>           }
> >>>           ...
> >>> fail:
> >>>           warn_alloc(gfp_mask, ac->nodemask,
> >>>                           "page allocation failure: order:%u", order)=
;
> >>> got_pg:
> >>>           return page;
> >>> }
> >>>
> >>> Unfortuantely, vpda does that nofail allocation under non-sleepable
> >>> lock. A possible way to fix that is to move the pages allocation out
> >>> of the lock into the caller, but having to allocate a huge number of
> >>> pages and auxiliary page array seems to be problematic as well per
> >>> Tetsuon: " You should implement proper error handling instead of
> >>> using __GFP_NOFAIL if count can become large."
> >>>
> >>> So I choose another way, which does not release kernel bounce pages
> >>> when user tries to register userspace bounce pages. Then we can
> >>> avoid allocating in paths where failure is not expected.(e.g in
> >>> the release). We pay this for more memory usage as we don't release
> >>> kernel bounce pages but further optimizations could be done on top.
> >>>
> >>> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce =
buffer")
> >>> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> >>> Tested-by: Xie Yongji <xieyongji@bytedance.com>
> >>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>> [v-songbaohua@oppo.com: Refine the changelog]
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>>    drivers/vdpa/vdpa_user/iova_domain.c | 19 +++++++++++--------
> >>>    drivers/vdpa/vdpa_user/iova_domain.h |  1 +
> >>>    2 files changed, 12 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa=
_user/iova_domain.c
> >>> index 791d38d6284c..58116f89d8da 100644
> >>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> >>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> >>> @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova=
_domain *domain,
> >>>                                enum dma_data_direction dir)
> >>>    {
> >>>        struct vduse_bounce_map *map;
> >>> +     struct page *page;
> >>>        unsigned int offset;
> >>>        void *addr;
> >>>        size_t sz;
> >>> @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iov=
a_domain *domain,
> >>>                            map->orig_phys =3D=3D INVALID_PHYS_ADDR))
> >>>                        return;
> >>>
> >>> -             addr =3D kmap_local_page(map->bounce_page);
> >>> +             page =3D domain->user_bounce_pages ?
> >>> +                    map->user_bounce_page : map->bounce_page;
> >>> +
> >>> +             addr =3D kmap_local_page(page);
> >>>                do_bounce(map->orig_phys + offset, addr + offset, sz, =
dir);
> >>>                kunmap_local(addr);
> >>>                size -=3D sz;
> >>> @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vdu=
se_iova_domain *domain,
> >>>                                memcpy_to_page(pages[i], 0,
> >>>                                               page_address(map->bounc=
e_page),
> >>>                                               PAGE_SIZE);
> >>> -                     __free_page(map->bounce_page);
> >>>                }
> >>> -             map->bounce_page =3D pages[i];
> >>> +             map->user_bounce_page =3D pages[i];
> >>>                get_page(pages[i]);
> >>>        }
> >>>        domain->user_bounce_pages =3D true;
> >>> @@ -297,17 +300,17 @@ void vduse_domain_remove_user_bounce_pages(stru=
ct vduse_iova_domain *domain)
> >>>                struct page *page =3D NULL;
> >>>
> >>>                map =3D &domain->bounce_maps[i];
> >>> -             if (WARN_ON(!map->bounce_page))
> >>> +             if (WARN_ON(!map->user_bounce_page))
> >>>                        continue;
> >>>
> >>>                /* Copy user page to kernel page if it's in use */
> >>>                if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> >>> -                     page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> >>> +                     page =3D map->bounce_page;
> >>
> >> Why don't we need a kmap_local_page(map->bounce_page) here, but we mig=
ht
> >> perform one / have performed one in vduse_domain_bounce?
> >
> > I think it's another bug that needs to be fixed.
> >
> > Yongji, do you want to fix this?
>
> Or maybe it works because "map->bounce_page" is now always a kernel
> page,

Yes, the userspace bounce page is not user_bounce_page.

> and never one from user space that might reside in highmem.

Right. So we are actually fine :)

Thanks

>
> --
> Cheers,
>
> David / dhildenb
>

