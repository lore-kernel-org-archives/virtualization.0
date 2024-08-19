Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929D33C0
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061766; cv=none; b=oaFElTa60bVAKa4xXX+x2DtnXPbiYxdofoFfnwuHcX5V2KR9AQTft18yMjQhthxkz6NldEkzM8JszxPUzRCQY+Va/4fIxXBhgOvCkN3LzsZJdyKUz9BZ3yTcG0fjzczVmL9Rp+uVnWFAV6Vpg0ZsR3Fqn600gS6n579HFBU0Ofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061766; c=relaxed/simple;
	bh=1WVnK0pqZm1SwF2lw5AFSydzwNTOOJlCLNhkOpaIc4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaQ8EF7xsDpFQQNmPZy84pP42XGIHasZSbfoOeY+AuH8wB5qHDZo4JBcuql+KjG19hoXY5vImR00I+MrgnBbOMSJs+eCCNME9sD9/LrLUMTaibmIq7rvKrn7gooyhZRXDtfdULuUfj/LNoFdocbHMe/A+I1atGO1k9yw3IqQU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtUQdw56; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtUQdw56"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f52bd5b555so2454308e0c.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724061764; x=1724666564; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d62lfnArQ+W+wXiW8uVMEV5IRAsxo/eNQMcf2FOMm2M=;
        b=QtUQdw56kNHIZ6XTw0AaWxHbPrdfSSYyN4VHPLKH5NJoHXsF3WJXsKAdzko90/u4bV
         I6LI+PLB7C9MUGQayH2HGN1qbVNmHpqWzyFwM3+PjXEHWMuYYxHe4guE2vXy6+jvALkT
         NR+6MDAnUz6Ez1sw/WmDrk767Ek5DVz5O/6K7xgtkp/fZDyoCxqqZ2W9h0Or6LQ7qcCa
         jPDxAFAGYRlGBX4nC/I74IeJ3OGpGSfKR03gZeKQHZJurRCoGupSfqOirbwftgMUnU0p
         s6ECA3BGdWr8LlWrpoNVFDu8kuDj2eOdA+xyc0g1Bb3X8ucTltyQgD4qBMOrk29JcVAB
         UimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724061764; x=1724666564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d62lfnArQ+W+wXiW8uVMEV5IRAsxo/eNQMcf2FOMm2M=;
        b=b6J327rQK4sFuqwZo83gbfiDP1k3j1ONNQq3g+rjyoI92li+1CxBenif0wQnlj/SuR
         dwbfxoj9UlJIhps71WVRpxeD/dGPzZjrTaYTam3RaVNirkPiMw8D8jFIaA9A4/1VpBqk
         on1hhH3eML7dKLezgXIpxpJeGDmch6UsYikaVhXpuE9dhoJkRcAtZKp2qzY8S6q8uVT7
         fEyGoXLN2vibPS+Xnjxa4WUgOdwh9Rug2ytV5qQM3uiHVt+dC4kmdN8CJ7aS8/rAVxJF
         JsesTgSL2RfOzrpA+34qQNP0H1W9qtiqPRZhhgfI6ZJTfM2CH/2kwLGMGCx7EprHnQ3s
         hdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEClBZ1BGA3UEKYlrwBOMxSowEM2L3nrbl1KGsUyHrByl1CMt5bDsI8J5lu8KDx10JKU5J8/gEQetorycwJ6+9HUbrCimpP9QozwJOieM=
X-Gm-Message-State: AOJu0YxZ/NUhaQiSIrR9l3k1Qj1gI0m2P+k4C+zS68YHgerPpT4mY45a
	ajQT7BxHgwmYjjbHPhfzykRfVYhiGwVg9GlVwLwy4Vmy8XiF4RlmjhgJQ+v2Pv1C0X0cNAkNAb4
	C96/4VqjS+nBs5DfusRJ3Pj6gP/0=
X-Google-Smtp-Source: AGHT+IE6NFzpaEfiuWE5jrWWKZxObh1oplK9M250rQQ6GDhiDdlVvYZCeY8C06spkAjH/fxZutvKMRNbtztrJdi43OI=
X-Received: by 2002:a05:6122:29c8:b0:4f5:2adf:3445 with SMTP id
 71dfb90a1353d-4fc591623e7mr7224555e0c.7.1724061763685; Mon, 19 Aug 2024
 03:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com> <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com>
In-Reply-To: <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 19 Aug 2024 22:02:32 +1200
Message-ID: <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:55=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.08.24 11:47, Barry Song wrote:
> > On Mon, Aug 19, 2024 at 9:43=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 17.08.24 08:24, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> We have cases we still fail though callers might have __GFP_NOFAIL.  =
Since
> >>> they don't check the return, we are exposed to the security risks for=
 NULL
> >>> deference.
> >>>
> >>> Though BUG_ON() is not encouraged by Linus, this is an unrecoverable
> >>> situation.
> >>>
> >>> Christoph Hellwig:
> >>> The whole freaking point of __GFP_NOFAIL is that callers don't handle
> >>> allocation failures.  So in fact a straight BUG is the right thing
> >>> here.
> >>>
> >>> Vlastimil Babka:
> >>> It's just not a recoverable situation (WARN_ON is for recoverable
> >>> situations). The caller cannot handle allocation failure and at the s=
ame
> >>> time asked for an impossible allocation. BUG_ON() is a guaranteed oop=
s
> >>> with stracktrace etc. We don't need to hope for the later NULL pointe=
r
> >>> dereference (which might if really unlucky happen from a different
> >>> context where it's no longer obvious what lead to the allocation fail=
ing).
> >>>
> >>> Michal Hocko:
> >>> Linus tends to be against adding new BUG() calls unless the failure i=
s
> >>> absolutely unrecoverable (e.g. corrupted data structures etc.). I am
> >>> not sure how he would look at simply incorrect memory allocator usage=
 to
> >>> blow up the kernel. Now the argument could be made that those failure=
s
> >>> could cause subtle memory corruptions or even be exploitable which mi=
ght
> >>> be a sufficient reason to stop them early.
> >>>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>> Acked-by: Michal Hocko <mhocko@suse.com>
> >>> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >>> Cc: Christoph Lameter <cl@linux.com>
> >>> Cc: Pekka Enberg <penberg@kernel.org>
> >>> Cc: David Rientjes <rientjes@google.com>
> >>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >>> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> >>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >>> Cc: Kees Cook <kees@kernel.org>
> >>> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> >>> Cc: Hailong.Liu <hailong.liu@oppo.com>
> >>> Cc: Jason Wang <jasowang@redhat.com>
> >>> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> >>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>> ---
> >>>    include/linux/slab.h | 4 +++-
> >>>    mm/page_alloc.c      | 4 +++-
> >>>    mm/util.c            | 1 +
> >>>    3 files changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/linux/slab.h b/include/linux/slab.h
> >>> index c9cb42203183..4a4d1fdc2afe 100644
> >>> --- a/include/linux/slab.h
> >>> +++ b/include/linux/slab.h
> >>> @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size=
, gfp_t flags, int node)
> >>>    {
> >>>        size_t bytes;
> >>>
> >>> -     if (unlikely(check_mul_overflow(n, size, &bytes)))
> >>> +     if (unlikely(check_mul_overflow(n, size, &bytes))) {
> >>> +             BUG_ON(flags & __GFP_NOFAIL);
> >>>                return NULL;
> >>> +     }
> >>>
> >>>        return kvmalloc_node_noprof(bytes, flags, node);
> >>>    }
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 60742d057b05..d2c37f8f8d09 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -4668,8 +4668,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, u=
nsigned int order,
> >>>         * There are several places where we assume that the order val=
ue is sane
> >>>         * so bail out early if the request is out of bound.
> >>>         */
> >>> -     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> >>> +     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {
> >>> +             BUG_ON(gfp & __GFP_NOFAIL);
> >>>                return NULL;
> >>> +     }
> >>>
> >>>        gfp &=3D gfp_allowed_mask;
> >>>        /*
> >>> diff --git a/mm/util.c b/mm/util.c
> >>> index ac01925a4179..678c647b778f 100644
> >>> --- a/mm/util.c
> >>> +++ b/mm/util.c
> >>> @@ -667,6 +667,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(s=
ize, b), gfp_t flags, int node)
> >>>
> >>>        /* Don't even allow crazy sizes */
> >>>        if (unlikely(size > INT_MAX)) {
> >>> +             BUG_ON(flags & __GFP_NOFAIL);
> >>
> >> No new BUG_ON please. WARN_ON_ONCE() + recovery code might be suitable=
 here.
> >
> > Hi David,
> > WARN_ON_ONCE()  might be fine but I don't see how it is possible to rec=
over.
>
> Just return NULL? "shit in shit out" :) ?

Returning NULL is perfectly right if gfp doesn't include __GFP_NOFAIL,
as it's the caller's responsibility to check the return value. However, wit=
h
__GFP_NOFAIL, users will directly dereference *(p + offset) even when
p =3D=3D NULL. It is how __GFP_NOFAIL is supposed to work.

>
> --
> Cheers,
>
> David / dhildenb
>
