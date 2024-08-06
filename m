Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7C8F6D
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911432; cv=none; b=GYdz9A8I622Z1sD1PIQSRFgQyJ7G2+IjDCBYXGn1mnI0qP9aEgS4TPEOIn9aNL6j23HWhKRAasJqqwUGk9xuleyyarT4hQQ5T9F6/qD+2n0lApjbc6CkdBp0ODx5/oANp2PjNBdw341RFDSvpMEAa6p81KaD8mZOjcJ+nBDCN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911432; c=relaxed/simple;
	bh=/D1csEuO90M6q+rs2KLY7zIMAaLN52yEO7Z/nhHsT2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chn96VtkBS2Ng3IX3BZYNXJJBQ/OUpbHOZaprgnWQ+H1ee38D3h5rYW8XopFCmM6cfx6G7Ha9srtZtk0kghW10ZYVRVEBtaAd/k4RuNXA1waF14sQEnml/zl+bsGlzgv6GlheBXXBw7xMzfIpxdjX31bUNLpQqWn5C87YlztcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlNwkIoz; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlNwkIoz"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4929992a5e2so26248137.2
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722911430; x=1723516230; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRtCi5nTIIRJvWv07+NXoyLmPbrdSthBdBMp8eojHgc=;
        b=XlNwkIozfRwBChcIkKjjdu28TF6AWMXBGlzo1OH8gpDCMb5l9wExBKAjKrylfEZ3uV
         nIwuQ430rlDBUBF/tYPBuHyplnz//sTZ6PlSUpz/cNw9howwRS+fwYVFLC3cUthxj6mz
         zbIzJNQcdykgntX2HUVfKzvyc3YnB7bAFKwwBhCOcok5hYjSv2fihWd3FEGGDlga/j6p
         mQuG/XaupB5qvUQcoiTCY6RS3eGOictOC4i3oR2QhB8fuAcrNncbpNnliMHBFtpIUDNS
         A/U8aNw67J014NPQhg252rml/eBh3DIaaCPRBV+cssKTj6ALhxE4etKV2nBq93qDFjvH
         HTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722911430; x=1723516230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRtCi5nTIIRJvWv07+NXoyLmPbrdSthBdBMp8eojHgc=;
        b=DPcnCeEnXH/WcjepyRyc2Y59o0X0lkOCTb4P3REQkeMxFX3aoBYugrOzbu3AKbxnsB
         gBnFeADwkbvO0IurU+eFpzmagWzjwt8NSjuscznW4+CKIBthRbQUMxyphLKqh6NlXENG
         x53LLXrXfCRnweEzjhED5T/qb9BTy4rwHs6VbDa2/x22zIBCrHff6cCDaeNg1ZqdscnX
         hclnLHhf5vZmVJz9zv5xRO5hpAzyynqEH7kGImSmCMVXtbOp3PooEIKYhGw/9WcE35yv
         EajUcChOYmwrxlQ4bwtHdOd/t/aVowEwlngkGx7ZdKy++q1FTCxQpy/Y92Gyzcsel8Jj
         JM3A==
X-Forwarded-Encrypted: i=1; AJvYcCXJQ+O19agMH1YfEoi+7895Ohs7DvBHe0rpCwRTH4g1YKp4DFT9XAPAqnE8krnb/FhraFJWVV/DcgWFCzfLbW2T7ROFe6M7QwFeAb+GlrM=
X-Gm-Message-State: AOJu0YzN568VHON57z1JBRnlAKUjyjUa0x5Vr6sJFFDB5gH3ws3xhjgR
	WerAO2HpjFE7PoORI43ifa29rT6s6DNJGR346VpAikTqPzXrN1krv8CgYV5FhC7wJzExetqgooP
	PBpfhNNqAg2Ks3sPBJTNlQW5cfxs=
X-Google-Smtp-Source: AGHT+IFfnssI3iHUD6uHW2GeLD0+CUBMsYgyiffucQINpnMu5oxyIfCPsSxk0LIGmYOSNYqqT3EqqFbdZ7SLXUFwFuc=
X-Received: by 2002:a05:6102:c03:b0:48f:e8f9:5d9f with SMTP id
 ada2fe7eead31-4945bddc51fmr10783248137.7.1722911429807; Mon, 05 Aug 2024
 19:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com>
In-Reply-To: <20240805082106.65847-1-jasowang@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 6 Aug 2024 14:30:18 +1200
Message-ID: <CAGsJ_4yHU3hBZp2ub1qokf2rCvK7yM0fK9CXQUwxVLn5uaVpcQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Barry said [1]:
>
> """
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
> ""=E2=80=9C

the current code will result in returning a NULL pointer but
not a busy-loop.

static inline struct page *
__alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
                                                struct alloc_context *ac)
{
        ...
        /*
         * Make sure that __GFP_NOFAIL request doesn't leak out and make su=
re
         * we always retry
         */
        if (gfp_mask & __GFP_NOFAIL) {
                /*
                 * All existing users of the __GFP_NOFAIL are blockable, so=
 warn
                 * of any new users that actually require GFP_NOWAIT
                 */
                if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
                        goto fail;
                ...
        }
        ...
fail:
        warn_alloc(gfp_mask, ac->nodemask,
                        "page allocation failure: order:%u", order);
got_pg:
        return page;
}


We have two choices to address the issue:
1. busy-loop
2. BUG_ON

the below patch chose 2:
https://lore.kernel.org/linux-mm/20240731000155.109583-5-21cnbao@gmail.com/

>
> Unfortuantely, we do that under read lock. A possible way to fix that
> is to move the pages allocation out of the lock into the caller, but
> having to allocate a huge number of pages and auxiliary page array
> seems to be problematic as well per Tetsuon [2]:
>
> """
> You should implement proper error handling instead of using
> __GFP_NOFAIL if count can become large.
> """
>
> So I choose another way, which does not release kernel bounce pages
> when user tries to register usersapce bounce pages. Then we don't need
> to do allocation in the path which is not expected to be fail (e.g in
> the release). We pay this for more memory usage but further
> optimizations could be done on top.
>
> [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
>
> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buff=
er")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 18 ++++++++++--------
>  drivers/vdpa/vdpa_user/iova_domain.h |  1 +
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 791d38d6284c..933d2f7cd49a 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_dom=
ain *domain,
>                                 enum dma_data_direction dir)
>  {
>         struct vduse_bounce_map *map;
> +       struct page *page;
>         unsigned int offset;
>         void *addr;
>         size_t sz;
> @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_do=
main *domain,
>                             map->orig_phys =3D=3D INVALID_PHYS_ADDR))
>                         return;
>
> -               addr =3D kmap_local_page(map->bounce_page);
> +               page =3D domain->user_bounce_pages ?
> +                      map->user_bounce_page : map->bounce_page;
> +
> +               addr =3D kmap_local_page(page);
>                 do_bounce(map->orig_phys + offset, addr + offset, sz, dir=
);
>                 kunmap_local(addr);
>                 size -=3D sz;
> @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse_i=
ova_domain *domain,
>                                 memcpy_to_page(pages[i], 0,
>                                                page_address(map->bounce_p=
age),
>                                                PAGE_SIZE);
> -                       __free_page(map->bounce_page);
>                 }
> -               map->bounce_page =3D pages[i];
> +               map->user_bounce_page =3D pages[i];
>                 get_page(pages[i]);
>         }
>         domain->user_bounce_pages =3D true;
> @@ -297,17 +300,16 @@ void vduse_domain_remove_user_bounce_pages(struct v=
duse_iova_domain *domain)
>                 struct page *page =3D NULL;
>
>                 map =3D &domain->bounce_maps[i];
> -               if (WARN_ON(!map->bounce_page))
> +               if (WARN_ON(!map->user_bounce_page))
>                         continue;
>
>                 /* Copy user page to kernel page if it's in use */
>                 if (map->orig_phys !=3D INVALID_PHYS_ADDR) {
> -                       page =3D alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> +                       page =3D map->bounce_page;
>                         memcpy_from_page(page_address(page),
> -                                        map->bounce_page, 0, PAGE_SIZE);
> +                                        map->user_bounce_page, 0, PAGE_S=
IZE);
>                 }
> -               put_page(map->bounce_page);
> -               map->bounce_page =3D page;
> +               put_page(map->user_bounce_page);
>         }
>         domain->user_bounce_pages =3D false;
>  out:
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index f92f22a7267d..7f3f0928ec78 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -21,6 +21,7 @@
>
>  struct vduse_bounce_map {
>         struct page *bounce_page;
> +       struct page *user_bounce_page;
>         u64 orig_phys;
>  };
>
> --
> 2.31.1
>
