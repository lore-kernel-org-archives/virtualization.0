Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951451519A6
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759629; cv=none; b=spFzqf3ILGwooYnUKST+V+a8/55DXwp9MDdlLDqHXxPmK6afwpSt5vBFiBPyLJQB2dGmd8Vso3qDrf0V+aKvWD032iS26E16wvJlVMHZtvZ75cNWfAVOpX2s9K5WPVTIoHWWe95WdyFm08zAnLYzMLbBZYcNcklEF3zIg2aVY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759629; c=relaxed/simple;
	bh=z6RG1NzBqpZcXxw7lAJMb1E2Y3MSfyoy5GWNYgAnZDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU0b3jv807pan3sF4IC39xKxSZG2ecA4sdDaE0AjRwUxDeJiffRydwFKNB/+Xl3jRLj5UwaovecNWXVjaP2QmnAPLsY2cr65qETyo3HpwlSo7o51OOuw7b4zDIZwsl8dC/5IRZ5QUGV2P2mBb18eQdTjBvH/626lb2h1yImIask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUmfIl3M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUmfIl3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758759626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBdXmbBK+zYgY+FkDU0KfDCA9hAmOijbFD22Agl/pNA=;
	b=bUmfIl3MSF6RAyHzJ1uu4CrNV82ds9fCbvXeXDM8I0LoUHxTNpw23oR5wHEAK22QDBHkNW
	Zdk7lyehtw1nWKKSg2pBuMVWfxkE1PiSrDuZhpckjIV/TQJEFitmegpHIxTY1lvifM1H17
	8h73eSVa5Li/wY8g/AmRrSuoeAE3iNE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-RUh7NAMBNJmQb7hgAHSXvQ-1; Wed, 24 Sep 2025 20:20:24 -0400
X-MC-Unique: RUh7NAMBNJmQb7hgAHSXvQ-1
X-Mimecast-MFC-AGG-ID: RUh7NAMBNJmQb7hgAHSXvQ_1758759624
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780f914b5a4so390611b3a.1
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 17:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759624; x=1759364424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBdXmbBK+zYgY+FkDU0KfDCA9hAmOijbFD22Agl/pNA=;
        b=aZijja8SW2sDZ2Zo8aEcwhFkq5pCqn/0gCxlnpxuP1vAmsvJFU6moD04Rgy6kdM239
         5uq80ukbmgm7zWprR6BwwKnKbr2D1QGybJFcvTiK6TGe21FfkyTH6tROlo8H3rvawgOg
         8T2g0uAmt0cdJOwjGvN0boL1BPYaYYxr45y4OrA9ZvVkdDUT9fbVOfu4ZwyzyeuP3/dn
         CISjml9c/jejBilCJcxCfzLwHNIrvLJJ2YDZj8R4jzrRkyosEStEqRDkG/u7fitL3ICP
         WiemlKc/gWWTm4n3VErtH13rD2Q0bJ6Y9ZIMEWdGlJs7PTbfS1JWyedZLCapfSxhFvb+
         Rm7w==
X-Forwarded-Encrypted: i=1; AJvYcCXySI9DQG1Adqb1kesa8hacEgcNp0m3BKs8bjz5sWd91idSGxHf0aOA+jTxjp/4tA9SW2Iha1ZSC+uBiMB9/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLr7it8fkFPFrvhyXxC8J0kgrZh0vlhe72tRJYCm78xP1iRRBu
	qChF5Opr1IXg4aIAb5ryVTr9DdeNQwoVncX9oz4sRVK5uJvSUTLgd9iocZpTpWpD8JZuTXYEfa7
	Pepxsvyf8DjDe6haPYiMmY1qHZlP4b7J/lXd45JBme9hVZNYw+lje1pDsZ1AJalrjoW9g5MEe5E
	16IYZz4SevgGYAwUDWtsUvMMWKV8BHAcAyR7qInYyAaIs=
X-Gm-Gg: ASbGnctVItS27R0jRx02mwTBtYgX7KX4HlC01l9qA6A2n/3DH+6dteOPUKgYz+1cqYx
	6vdrdyiT/7RS0J6ggK9M+j/NooWa3gnv0uzdNqUMMPpeb8BnWcctS1qE8/TKZMmgZgdr1vqCGp8
	jma7JE22wTh8C+WxzdwQ==
X-Received: by 2002:a05:6a20:a126:b0:24c:dd96:54f2 with SMTP id adf61e73a8af0-2e7bf47c13emr1926792637.1.1758759623743;
        Wed, 24 Sep 2025 17:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvLMAV/8B1P5qPCLtvGQU0+RKs7N8f4KhEHl70VSOnWY8mLTxXSnMrb+lx7ACU9ZyiJFWSTtOBh9B3XvN3V9E=
X-Received: by 2002:a05:6a20:a126:b0:24c:dd96:54f2 with SMTP id
 adf61e73a8af0-2e7bf47c13emr1926740637.1.1758759623163; Wed, 24 Sep 2025
 17:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com>
 <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com> <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
 <aed938d0-e70a-4af6-9950-d4d0b7d6a93f@bytedance.com> <CACGkMEv4TZOAyxaTkCvZ4rgyVsPet+r3pNSauHaGOYHim3Loag@mail.gmail.com>
 <b5bc34c2-b82a-475d-ba15-a7f67495b56a@bytedance.com>
In-Reply-To: <b5bc34c2-b82a-475d-ba15-a7f67495b56a@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Sep 2025 08:20:11 +0800
X-Gm-Features: AS18NWDdt4kY5KPqivF5QVdC5EV0coiQzHRAXlVturRFKt4v3-LoM7ZWGsG5sK0
Message-ID: <CACGkMEsLg-oi3BU1EgRVb2hB9P1bfxEyZoH03+vtEGe=YmNQHg@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
To: Sheng Zhao <sheng.zhao@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5T6UT36zuPo7pKyfZUyplYOtnj5bgxDRmaMA0lrE2cM_1758759624
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:38=E2=80=AFPM Sheng Zhao <sheng.zhao@bytedance.co=
m> wrote:
>
>
>
> On 2025/9/24 12:15, Jason Wang wrote:
> > On Wed, Sep 24, 2025 at 12:05=E2=80=AFPM Sheng Zhao <sheng.zhao@bytedan=
ce.com> wrote:
> >>
> >>
> >>
> >> On 2025/9/24 08:57, Jason Wang wrote:
> >>> On Tue, Sep 23, 2025 at 8:37=E2=80=AFPM Sheng Zhao <sheng.zhao@byteda=
nce.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2025/9/17 16:16, Jason Wang wrote:
> >>>>> On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> =
wrote:
> >>>>>>
> >>>>>> From: Sheng Zhao <sheng.zhao@bytedance.com>
> >>>>>>
> >>>>>> The allocation granularity of bounce pages is PAGE_SIZE. This may =
cause
> >>>>>> even small IO requests to occupy an entire bounce page exclusively=
. The
> >>>>>> kind of memory waste will be more significant on arm64 with 64KB p=
ages.
> >>>>>
> >>>>> Let's tweak the title as there are archs that are using non 4KB pag=
es
> >>>>> other than arm.
> >>>>>
> >>>>
> >>>> Got it. I will modify this in v2.
> >>>>
> >>>>>>
> >>>>>> So, optimize it by using fixed 4KB bounce pages.
> >>>>>>
> >>>>>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> >>>>>> ---
> >>>>>>     drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++--=
--------
> >>>>>>     drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
> >>>>>>     2 files changed, 83 insertions(+), 42 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/v=
dpa_user/iova_domain.c
> >>>>>> index 58116f89d8da..768313c80b62 100644
> >>>>>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> >>>>>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> >>>>>> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iov=
a_domain *domain,
> >>>>>>     static int vduse_domain_map_bounce_page(struct vduse_iova_doma=
in *domain,
> >>>>>>                                             u64 iova, u64 size, u6=
4 paddr)
> >>>>>>     {
> >>>>>> -       struct vduse_bounce_map *map;
> >>>>>> +       struct vduse_bounce_map *map, *head_map;
> >>>>>> +       struct page *tmp_page;
> >>>>>>            u64 last =3D iova + size - 1;
> >>>>>>
> >>>>>>            while (iova <=3D last) {
> >>>>>> -               map =3D &domain->bounce_maps[iova >> PAGE_SHIFT];
> >>>>>> +               map =3D &domain->bounce_maps[iova >> BOUNCE_PAGE_S=
HIFT];
> >>>>>
> >>>>> BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any p=
age
> >>>>> at all when PAGE_SIZE is not 4K.
> >>>>>
> >>>>
> >>>> How about BOUNCE_MAP_SIZE?
> >>>
> >>> Fine with me.
> >>>
> >>>>
> >>>>>>                    if (!map->bounce_page) {
> >>>>>> -                       map->bounce_page =3D alloc_page(GFP_ATOMIC=
);
> >>>>>> -                       if (!map->bounce_page)
> >>>>>> -                               return -ENOMEM;
> >>>>>> +                       head_map =3D &domain->bounce_maps[(iova & =
PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
> >>>>>> +                       if (!head_map->bounce_page) {
> >>>>>> +                               tmp_page =3D alloc_page(GFP_ATOMIC=
);
> >>>>>> +                               if (!tmp_page)
> >>>>>> +                                       return -ENOMEM;
> >>>>>> +                               if (cmpxchg(&head_map->bounce_page=
, NULL, tmp_page))
> >>>>>> +                                       __free_page(tmp_page);
> >>>>>
> >>>>> I don't understand why we need cmpxchg() logic.
> >>>>>
> >>>>> Btw, it looks like you want to make multiple bounce_map to point to
> >>>>> the same 64KB page? I wonder what's the advantages of doing this. C=
an
> >>>>> we simply keep the 64KB page in bounce_map?
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>> That's correct. We use fixed 4KB-sized bounce pages, and there will =
be a
> >>>> many-to-one relationship between these 4KB bounce pages and the 64KB
> >>>> memory pages.
> >>>>
> >>>> Bounce pages are allocated on demand. As a result, it may occur that
> >>>> multiple bounce pages corresponding to the same 64KB memory page att=
empt
> >>>> to allocate memory simultaneously, so we use cmpxchg to handle this
> >>>> concurrency.
> >>>>
> >>>> In the current implementation, the bounce_map structure requires no
> >>>> modification. However, if we keep the 64KB page into a single bounce=
_map
> >>>> while still wanting to implement a similar logic, we may need an
> >>>> additional array to store multiple orig_phys values in order to
> >>>> accommodate the many-to-one relationship.
> >>>
> >>> Or simply having a bitmap is sufficient per bounce_map?
> >>>
> >>
> >> Yes, using a bitmap can mark the usage status of each 4KB, but it may
> >> not simplify things overall.
> >>
> >> - we will inevitably need to add an additional array per bounce_map to
> >> store the orig_phys corresponding to each 4KB for subsequent copying
> >> (vduse_domain_bounce).
> >
> > I may miss something, the PAGE_SIZE is 64KB in this case, why do we
> > need to store per 4KB orig_phys?
> >
>
> Since one orig_phys originates from one IO request. If we want the
> minimum size of bounce pages occupied by an IO request to be 4KB instead
> of 64KB. we need to store their respective orig_phys values for each 4KB
> corresponding to the IO request.
>
> In other words, we may not be able to guarantee that the orig_phys
> values of all IO requests within the same 64KB memory page are
> contiguous, so we need to store them separately.

Ok, let's leave a comment to explain this design.

Thanks

>
> Thanks
> >>
> >> - compared to the current commit, this modification may only be a
> >> structural change and fail to reduce the amount of changes to the code
> >> logic. For instance, cmpxchg is still required.
> >
> > Thanks
> >
> >>
> >>
> >> Thanks
> >>
> >>> Thanks
> >>>
> >>>>
> >>>> Thanks
> >>>>
> >>>
> >>
> >
>

