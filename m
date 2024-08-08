Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BBFD2FB
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085905; cv=none; b=Db7t7FRg6lpKnGj3e6H1g4iQZrk63kOZhMgSbS3aAZWjBZ1VFlBxG5nZ/bioeIIpEbk15/rvI6181z+I+eAkzQbUJjYvMZJtwe4KFpEkCjLVkZY+hWyznsZP0/rz4vQIUAhDJEAFGdoRw+CbGUfiy5vxLg8FLyEuT2bRkPclMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085905; c=relaxed/simple;
	bh=VNMGCN3K7dYB2D1yFW8pEkV/m/ZDheqzNYCNmyk0nZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrw2CDz1PysTq3v1+beUftYZkGzCfmez0Svm4zpkdMPhWlnx/2bndnsEwRhtsQ6ttA5O9dI/ARpuS/a/c1OotMcuoZgwtkxwnSmkw6fYjx+6WN9hF0Ccg7nBJ4AcSebNR5vkbrM5Yk/vr0gRIj9QnBxKnsaMfNYWoemWlq/Wx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFazmJH4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFazmJH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723085902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ms7GM5nBFpICUPNkIa1lvEOGwID30MEVHv5V6CEvL58=;
	b=QFazmJH4KJ2v5xyjUVbVFWu01EHbzbNfooPXw8Swu0O0jkdIo17JPjYOCn8OLoDp8/UwNV
	oLjrg9wWMLyNgntlsQH78pkwd2rqQb6OtoSXf7euPND0myAs/RAgRr/OA1Hq0h1dkeNxE3
	7lNnEY1uPI1j+kzt3YweZFEEymZzk3E=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-a7AocKVgNx6B_hk_vDCN5g-1; Wed, 07 Aug 2024 22:58:20 -0400
X-MC-Unique: a7AocKVgNx6B_hk_vDCN5g-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7b04199911bso1356733a12.1
        for <virtualization@lists.linux.dev>; Wed, 07 Aug 2024 19:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723085899; x=1723690699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms7GM5nBFpICUPNkIa1lvEOGwID30MEVHv5V6CEvL58=;
        b=SHWW7YziiQwfJf6VWF6w6CsVCGZEV9QTGLCfEdXZ/wSCERL2rBtMQJBDXocg7qdaLq
         xsBLzbdpRF6IaD9+XfC83lXIqYPmnDLFiGxa/lyzzzOKk33SSPsLBkLeF6GIPF+aTAMs
         66joplBOaSnfGwl+gpj53gZa6XfyrPgCnJ0BtsZOXpUqbAYxFCEJwlnHEZC8+Kb/JPiI
         FwzCcmKlMkPjzi7oCCz+spvohtGtEhhldllB5umNDnMeCR5Vhsy6tqrOdiH8Dt7MZQ7o
         ZzHTaVyxWnwYv3MeFzSAR3byIFsDR3NBs97zRJF9VJKxT5EEvfXT0UxmM3gkIPB7obSA
         ZBmg==
X-Forwarded-Encrypted: i=1; AJvYcCUL3EdNTKk4waFKJwmev2nPpB2TopHqM5/0XN9wjYk114ltAESNtohdX2tjQA4sJIEgfU+1BRYRmrwtIMRw3Bbp//ZyFI3fXjQ2s1W5ybU=
X-Gm-Message-State: AOJu0Yyqvx216ai/4KjgUdaGS07Fw1thetSWdsl0lvGLu51yWwJf3K18
	FqKoxoajklxt5WbfCZ2RhhqyExk6/kYo4JkzVPmHxFFtU+ue2aP/nc2Od+2ooP4q6P7rjKkvJA/
	eI2ftdY4nOAJMdONVEuT6BRxJJBvfoJ9+gUu77A4dnbet5BAJkoisd5sxhoLALrRkZsWwjTHmhK
	bpWFJL3rkW4AOZcFvyl/GsLIRXfdElLPHRMWm8/bI4nTkgUe2A+g==
X-Received: by 2002:a17:90a:17ec:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2d1c4f7ffcemr449633a91.3.1723085899405;
        Wed, 07 Aug 2024 19:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHPsusqODlyN/Y2NKkNEN5MV4OvfYjQpK1hVjQHlsFtCjwUc/HVVj2xAjML9dJtaAFFSkIKjg4vo+eHiHKsy4=
X-Received: by 2002:a17:90a:17ec:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2d1c4f7ffcemr449586a91.3.1723085898669; Wed, 07 Aug 2024
 19:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
In-Reply-To: <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Aug 2024 10:58:07 +0800
Message-ID: <CACGkMEtYE1OY+okxHAj=cVfW-Qz45an28oO=Wv15yOtpD6UqdQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Barry said [1]:
> >
> > """
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
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
> > the release). We pay this for more memory usage but further
> > optimizations could be done on top.
> >
> > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
> >
> > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce bu=
ffer")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Tested-by: Xie Yongji <xieyongji@bytedance.com>

Thanks.

>
> Have tested it with qemu-storage-daemon [1]:
>
> $ qemu-storage-daemon \
>     --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=3Don,wa=
it=3Doff \
>     --monitor chardev=3Dcharmonitor \
>     --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,filena=
me=3D/dev/nullb0,node-name=3Ddisk0
> \
>     --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,node-name=
=3Ddisk0,writable=3Don
>
> [1] https://github.com/bytedance/qemu/tree/vduse-umem

Great, would you want to post them to the Qemu?

>
> >  drivers/vdpa/vdpa_user/iova_domain.c | 18 ++++++++++--------
> >  drivers/vdpa/vdpa_user/iova_domain.h |  1 +
> >  2 files changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 791d38d6284c..933d2f7cd49a 100644
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
> > @@ -297,17 +300,16 @@ void vduse_domain_remove_user_bounce_pages(struct=
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
>
> map->user_bounce_page =3D NULL?

For safety, it might be better. Let me add this and post a V2/

Thanks

>
> Thanks,
> Yongji
>

