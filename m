Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB70F9C0
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687374; cv=none; b=HyIVAqPpuwzVobptJ3EZhAGZaOizeCpdeJFKYp1DabT3kRRTb/junpEU01g7VL5pz4l5nbYiGhwm/qpjyuPxWNI6ySjgqJ/DEgzIwA2HNWx58XEK5QOu3Tb3Sp40/uVyRmGgeyvOB+kDylt1NjCzWIQlXN86BeXChQrj2Chq/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687374; c=relaxed/simple;
	bh=e2SKGKOU3PUuIR6ckqLZ3rtP2opdftf/iOmVG3z9N68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrtyFQ+mGQweoCLKLZl3Ar/jLbEbAdN4YwtL8Dsbg8t8ekws11OQpdqdjS9hJu+wgELLMrR1qbWjALqcpOWU7p1nzW6nxcJNuTw+K5plfZm+XaS+2CWbVYHklwV7Svll7gD8SQwD4zLDH4dhT+u2FxOnbsPggs8/j3lJqn2c89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXVex8cT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXVex8cT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758687372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeYJpSmZcQynfx4YtXm/Ek5ULrPGYbbMEhsYF6GZhtQ=;
	b=SXVex8cTk/SCT88LnVcloPQkmtT90zjfqdocdT1z+q8Hy6bcwmpcNi0r3fMTUeKtZuEjiL
	l5cNml5RqqKVSzGU9EjZ/DP5CkPl6sI7EYNksEnunnmWWTMHMhgK6IvChZWdhYmF0D1oGg
	kfxQ1/woagKYVyVDk7rMEo8Fv6YR3s0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-eFA1AFiaMHimLeLaWvSx5w-1; Wed, 24 Sep 2025 00:16:10 -0400
X-MC-Unique: eFA1AFiaMHimLeLaWvSx5w-1
X-Mimecast-MFC-AGG-ID: eFA1AFiaMHimLeLaWvSx5w_1758687369
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so6086367a91.3
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 21:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758687369; x=1759292169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeYJpSmZcQynfx4YtXm/Ek5ULrPGYbbMEhsYF6GZhtQ=;
        b=JVART2O6Ot3shTd/s/Bnwl3kBpzc9YMmSn/AM/OOJxsuBCUuu9gA+OkcucmSPq31cy
         EIYgXdAoq6UMbCMMQbdxqX6nIRuCSnMP5Km9CMV9EQDomZE5HvdZ7EspDWxlEm/DMZlF
         13+hOGFh8O+6aAM40gWqUv0b5gesLf6LWHkTauPa0MHz9zti64YWS1qaHwKSPMqtPsUd
         vRzY7rkgUudjQf7LSQyXV9I8+H3gjT2nOggzFNpsBeFkprEPSBI5jVVBqYmhp3wY4WNe
         5+FJtECX7reukCv+9+fo9pSTIS9yKU5XZwyXnTiFeQulXKaP9EO49oz/voQD7a9iMhjA
         pIQg==
X-Forwarded-Encrypted: i=1; AJvYcCWSejd+TJAX/HP0ypQZwnVa6yHSH4j/E+Kh9X9OvWGs+EM/1MDkl7I2aYJsVVwKfdk5YqRHy/peSkCPX7u3FA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqiycv21A0dW5VWDeXF9k6xI+E5SPIxUzFh9GW0bLIcBKpal0L
	iW4tByVXMMq4PJ3Q/hdj2wIkLxzdNijUh/D3febvZWMZEqi2qFdD6ZRlra1+GIceY0+oVm5FqOv
	BoHCDNWdOB75vhD0oZvbamOIjsZK9ZBzDyylhYEaLL620IFPFLlDXBQo8s4oZCyqDsu3ip7xHfz
	QLP5/MDhHRZI+oVIZrcLP5ztQ3x0agJL8QQz06BGEMyMM=
X-Gm-Gg: ASbGncs67mViRAtM2yzZQiS9YaKA0cgZ/TiDd7gE4bfYfJCjC0InpQYOGwrlWlIJ8uz
	q9nlZ5UpHAFkdW3XwiTLr1Y8U2nDgIJunTh5aFjOwqDHC+YCcatKjK15WdJmR6Zg+oJcIumZ4n7
	tbYqif7bNxxgPNTjkVOWAQVw==
X-Received: by 2002:a17:90b:1e12:b0:32d:dffc:7ad6 with SMTP id 98e67ed59e1d1-332a9b0f286mr5447433a91.33.1758687369409;
        Tue, 23 Sep 2025 21:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF24cevzHrL6WvQey+iSyxQ4+6NnOrkY/zGrJgtXtDZ38+e0trn0RG1R/tR8T1tPl7yLBmPl7BbhhjDGMlwytI=
X-Received: by 2002:a17:90b:1e12:b0:32d:dffc:7ad6 with SMTP id
 98e67ed59e1d1-332a9b0f286mr5447403a91.33.1758687368910; Tue, 23 Sep 2025
 21:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com>
 <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com> <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
 <aed938d0-e70a-4af6-9950-d4d0b7d6a93f@bytedance.com>
In-Reply-To: <aed938d0-e70a-4af6-9950-d4d0b7d6a93f@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 12:15:57 +0800
X-Gm-Features: AS18NWD-E8tQ_Pws7t4DJCgVoufFrNH_4VLc6gHN89YX9o8eB-AsMD2Mx9znFfw
Message-ID: <CACGkMEv4TZOAyxaTkCvZ4rgyVsPet+r3pNSauHaGOYHim3Loag@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
To: Sheng Zhao <sheng.zhao@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2Je9CaFg9v9nvcza3o4soUZs1fawF4CuR_xaFPmr6gI_1758687369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 12:05=E2=80=AFPM Sheng Zhao <sheng.zhao@bytedance.c=
om> wrote:
>
>
>
> On 2025/9/24 08:57, Jason Wang wrote:
> > On Tue, Sep 23, 2025 at 8:37=E2=80=AFPM Sheng Zhao <sheng.zhao@bytedanc=
e.com> wrote:
> >>
> >>
> >>
> >> On 2025/9/17 16:16, Jason Wang wrote:
> >>> On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> wr=
ote:
> >>>>
> >>>> From: Sheng Zhao <sheng.zhao@bytedance.com>
> >>>>
> >>>> The allocation granularity of bounce pages is PAGE_SIZE. This may ca=
use
> >>>> even small IO requests to occupy an entire bounce page exclusively. =
The
> >>>> kind of memory waste will be more significant on arm64 with 64KB pag=
es.
> >>>
> >>> Let's tweak the title as there are archs that are using non 4KB pages
> >>> other than arm.
> >>>
> >>
> >> Got it. I will modify this in v2.
> >>
> >>>>
> >>>> So, optimize it by using fixed 4KB bounce pages.
> >>>>
> >>>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> >>>> ---
> >>>>    drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++-----=
-----
> >>>>    drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
> >>>>    2 files changed, 83 insertions(+), 42 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdp=
a_user/iova_domain.c
> >>>> index 58116f89d8da..768313c80b62 100644
> >>>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> >>>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> >>>> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_=
domain *domain,
> >>>>    static int vduse_domain_map_bounce_page(struct vduse_iova_domain =
*domain,
> >>>>                                            u64 iova, u64 size, u64 p=
addr)
> >>>>    {
> >>>> -       struct vduse_bounce_map *map;
> >>>> +       struct vduse_bounce_map *map, *head_map;
> >>>> +       struct page *tmp_page;
> >>>>           u64 last =3D iova + size - 1;
> >>>>
> >>>>           while (iova <=3D last) {
> >>>> -               map =3D &domain->bounce_maps[iova >> PAGE_SHIFT];
> >>>> +               map =3D &domain->bounce_maps[iova >> BOUNCE_PAGE_SHI=
FT];
> >>>
> >>> BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any pag=
e
> >>> at all when PAGE_SIZE is not 4K.
> >>>
> >>
> >> How about BOUNCE_MAP_SIZE?
> >
> > Fine with me.
> >
> >>
> >>>>                   if (!map->bounce_page) {
> >>>> -                       map->bounce_page =3D alloc_page(GFP_ATOMIC);
> >>>> -                       if (!map->bounce_page)
> >>>> -                               return -ENOMEM;
> >>>> +                       head_map =3D &domain->bounce_maps[(iova & PA=
GE_MASK) >> BOUNCE_PAGE_SHIFT];
> >>>> +                       if (!head_map->bounce_page) {
> >>>> +                               tmp_page =3D alloc_page(GFP_ATOMIC);
> >>>> +                               if (!tmp_page)
> >>>> +                                       return -ENOMEM;
> >>>> +                               if (cmpxchg(&head_map->bounce_page, =
NULL, tmp_page))
> >>>> +                                       __free_page(tmp_page);
> >>>
> >>> I don't understand why we need cmpxchg() logic.
> >>>
> >>> Btw, it looks like you want to make multiple bounce_map to point to
> >>> the same 64KB page? I wonder what's the advantages of doing this. Can
> >>> we simply keep the 64KB page in bounce_map?
> >>>
> >>> Thanks
> >>>
> >>
> >> That's correct. We use fixed 4KB-sized bounce pages, and there will be=
 a
> >> many-to-one relationship between these 4KB bounce pages and the 64KB
> >> memory pages.
> >>
> >> Bounce pages are allocated on demand. As a result, it may occur that
> >> multiple bounce pages corresponding to the same 64KB memory page attem=
pt
> >> to allocate memory simultaneously, so we use cmpxchg to handle this
> >> concurrency.
> >>
> >> In the current implementation, the bounce_map structure requires no
> >> modification. However, if we keep the 64KB page into a single bounce_m=
ap
> >> while still wanting to implement a similar logic, we may need an
> >> additional array to store multiple orig_phys values in order to
> >> accommodate the many-to-one relationship.
> >
> > Or simply having a bitmap is sufficient per bounce_map?
> >
>
> Yes, using a bitmap can mark the usage status of each 4KB, but it may
> not simplify things overall.
>
> - we will inevitably need to add an additional array per bounce_map to
> store the orig_phys corresponding to each 4KB for subsequent copying
> (vduse_domain_bounce).

I may miss something, the PAGE_SIZE is 64KB in this case, why do we
need to store per 4KB orig_phys?

>
> - compared to the current commit, this modification may only be a
> structural change and fail to reduce the amount of changes to the code
> logic. For instance, cmpxchg is still required.

Thanks

>
>
> Thanks
>
> > Thanks
> >
> >>
> >> Thanks
> >>
> >
>

