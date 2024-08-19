Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC416C42C
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071712; cv=none; b=uzkdrjZJBOEHvipBjuPZSM+cNghiUqlghp8i5y+2YviO87BzfhQ8N3yJP9ksuKnBC/gsKjeqqaDqlSx+jKJ5APb2xnPZxNGO/dtw+5D8OP3SJwbKv0UTzFo/aj2qM6zy5rBfKM135+XLsDSCYLluaEdYvq0sdJblZqck00SYGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071712; c=relaxed/simple;
	bh=ie8HzDOIc5tNvQGzEGVfqC9JZPjMyOyUP0wlxUbOw48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ms5fznc+47IJWw8bsoPdSuqVWmlQUE8v29eJK4mlLPk2Q4fXlXzTUct7hPwpaM1VJVcpLi1jl1duRj+UeCo17ltt9zk3cGzVvfXcAauJsStslRGfy86Q4mNlq+toOypxGCUfmqf5CjQFmPdnbzBvQpQ37qnEgqNqIdwqFl99Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2Zxnmxc; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2Zxnmxc"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f50dd3eab9so1328111e0c.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724071710; x=1724676510; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQXZdzAnQoHXoN4yZdckIUNNjAtYBDG0MxDRUv+ICko=;
        b=P2Zxnmxcg62d8Vr0qkOuK0xwSmBKEygKReKV2QhOUjaUYYvg/MR+qt1YVMC34uFzsH
         jiJf+22J5ebzrBzhrbfDBPEUsUo4oLzVhFTBPDNHEKxfBIsdadQUr8wGTneBAGJ4r3Xb
         SOW3/rPqe2czpGG2HgmsqA4l1bIksHL9CQL6tcUOhx8pdbtosnD+8gRlQUwd7gMP6zFu
         9sLphTAi9AizHCPscceiTRPGWQoUawhrNG9RhJdQ9UgJmqMZVHDgJgq3V7PF0m3tt0lr
         VaZBulOECe20itICip7USnuayAe6/6K8NvEeOmmKQNvpUsntY9H9u+yw8hPurDBsZKiq
         4r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071710; x=1724676510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQXZdzAnQoHXoN4yZdckIUNNjAtYBDG0MxDRUv+ICko=;
        b=Ocsfm8hOX1/o7gC5yx+hBtFX1rg2T7DK0biXL+c3rfGaEycuDp05na7fsApFO6Pdfc
         D3aUDMkrh1BVpf/3YO4QZv1+ewLVmBDsNXW5TRwWyvIKSpfQBTTyO7CiImqiQ9pGMMxM
         JiKSgtk6o9xrXiw6spytffeBBYRPj4iDui0I3fay/CdveqDTkLLVjn7lBUqE/ndKb1fy
         bd6niP8bCdRqQqOzhEGcoNRnHLB9xumanJatlX/a3iW+dMfu+8OrHF4yFmfrQemOFHsD
         R1j8CTSe/aMk4p7qYvzptqs2j7ajLfzVza034hKAlC8yR9h90Z/pUplfcCc24x1d+L9X
         07Og==
X-Forwarded-Encrypted: i=1; AJvYcCW3UPjySgotfCySdagg3ZZv3oK21UVl6FSep1Lif3Q8j1PMFn9hNAC9ffiFZA3Nwc6Ub3E9p6DtOWR/gTKWRD+4VXSFAlyf44hcI43Mqew=
X-Gm-Message-State: AOJu0Yys9tlXfwdYmff9iLHdVK4AJUQjTjmu+l4M4EJKT6a6C0cIeSYf
	F8RqxttCuIgOOC2pkwP5/wsvxczddQYRebqbyNgBzipVapHtyG0YmG1DC95mzF4KqG9HnCH1P30
	6BRKXwGhqTpSGvthozyaISDvndKg=
X-Google-Smtp-Source: AGHT+IF7//DmJ6IWybIFsN9Jr7uQaycyCdYWtKQaiK4iQFmy/g3uf+B2D0Ph/CT22DTUWSfYRky4+/igQ0JSVZj67kU=
X-Received: by 2002:a05:6122:1685:b0:4f5:abe4:50e2 with SMTP id
 71dfb90a1353d-4fc6c601202mr13525978e0c.6.1724071709603; Mon, 19 Aug 2024
 05:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com> <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com> <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
 <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com>
In-Reply-To: <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 00:48:18 +1200
Message-ID: <CAGsJ_4zWNgA1OZJ-iAa4KhDY9TuGb2vji4=FJ=Vn7ve5uF6XzQ@mail.gmail.com>
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

On Tue, Aug 20, 2024 at 12:33=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 19.08.24 12:02, Barry Song wrote:
> > On Mon, Aug 19, 2024 at 9:55=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 19.08.24 11:47, Barry Song wrote:
> >>> On Mon, Aug 19, 2024 at 9:43=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 17.08.24 08:24, Barry Song wrote:
> >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> We have cases we still fail though callers might have __GFP_NOFAIL.=
  Since
> >>>>> they don't check the return, we are exposed to the security risks f=
or NULL
> >>>>> deference.
> >>>>>
> >>>>> Though BUG_ON() is not encouraged by Linus, this is an unrecoverabl=
e
> >>>>> situation.
> >>>>>
> >>>>> Christoph Hellwig:
> >>>>> The whole freaking point of __GFP_NOFAIL is that callers don't hand=
le
> >>>>> allocation failures.  So in fact a straight BUG is the right thing
> >>>>> here.
> >>>>>
> >>>>> Vlastimil Babka:
> >>>>> It's just not a recoverable situation (WARN_ON is for recoverable
> >>>>> situations). The caller cannot handle allocation failure and at the=
 same
> >>>>> time asked for an impossible allocation. BUG_ON() is a guaranteed o=
ops
> >>>>> with stracktrace etc. We don't need to hope for the later NULL poin=
ter
> >>>>> dereference (which might if really unlucky happen from a different
> >>>>> context where it's no longer obvious what lead to the allocation fa=
iling).
> >>>>>
> >>>>> Michal Hocko:
> >>>>> Linus tends to be against adding new BUG() calls unless the failure=
 is
> >>>>> absolutely unrecoverable (e.g. corrupted data structures etc.). I a=
m
> >>>>> not sure how he would look at simply incorrect memory allocator usa=
ge to
> >>>>> blow up the kernel. Now the argument could be made that those failu=
res
> >>>>> could cause subtle memory corruptions or even be exploitable which =
might
> >>>>> be a sufficient reason to stop them early.
> >>>>>
> >>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>>>> Acked-by: Michal Hocko <mhocko@suse.com>
> >>>>> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >>>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >>>>> Cc: Christoph Lameter <cl@linux.com>
> >>>>> Cc: Pekka Enberg <penberg@kernel.org>
> >>>>> Cc: David Rientjes <rientjes@google.com>
> >>>>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >>>>> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> >>>>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >>>>> Cc: Kees Cook <kees@kernel.org>
> >>>>> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> >>>>> Cc: Hailong.Liu <hailong.liu@oppo.com>
> >>>>> Cc: Jason Wang <jasowang@redhat.com>
> >>>>> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> >>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>>>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>>> ---
> >>>>>     include/linux/slab.h | 4 +++-
> >>>>>     mm/page_alloc.c      | 4 +++-
> >>>>>     mm/util.c            | 1 +
> >>>>>     3 files changed, 7 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/include/linux/slab.h b/include/linux/slab.h
> >>>>> index c9cb42203183..4a4d1fdc2afe 100644
> >>>>> --- a/include/linux/slab.h
> >>>>> +++ b/include/linux/slab.h
> >>>>> @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t si=
ze, gfp_t flags, int node)
> >>>>>     {
> >>>>>         size_t bytes;
> >>>>>
> >>>>> -     if (unlikely(check_mul_overflow(n, size, &bytes)))
> >>>>> +     if (unlikely(check_mul_overflow(n, size, &bytes))) {
> >>>>> +             BUG_ON(flags & __GFP_NOFAIL);
> >>>>>                 return NULL;
> >>>>> +     }
> >>>>>
> >>>>>         return kvmalloc_node_noprof(bytes, flags, node);
> >>>>>     }
> >>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>>>> index 60742d057b05..d2c37f8f8d09 100644
> >>>>> --- a/mm/page_alloc.c
> >>>>> +++ b/mm/page_alloc.c
> >>>>> @@ -4668,8 +4668,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp,=
 unsigned int order,
> >>>>>          * There are several places where we assume that the order =
value is sane
> >>>>>          * so bail out early if the request is out of bound.
> >>>>>          */
> >>>>> -     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> >>>>> +     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {
> >>>>> +             BUG_ON(gfp & __GFP_NOFAIL);
> >>>>>                 return NULL;
> >>>>> +     }
> >>>>>
> >>>>>         gfp &=3D gfp_allowed_mask;
> >>>>>         /*
> >>>>> diff --git a/mm/util.c b/mm/util.c
> >>>>> index ac01925a4179..678c647b778f 100644
> >>>>> --- a/mm/util.c
> >>>>> +++ b/mm/util.c
> >>>>> @@ -667,6 +667,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS=
(size, b), gfp_t flags, int node)
> >>>>>
> >>>>>         /* Don't even allow crazy sizes */
> >>>>>         if (unlikely(size > INT_MAX)) {
> >>>>> +             BUG_ON(flags & __GFP_NOFAIL);
> >>>>
> >>>> No new BUG_ON please. WARN_ON_ONCE() + recovery code might be suitab=
le here.
> >>>
> >>> Hi David,
> >>> WARN_ON_ONCE()  might be fine but I don't see how it is possible to r=
ecover.
> >>
> >> Just return NULL? "shit in shit out" :) ?
> >
> > Returning NULL is perfectly right if gfp doesn't include __GFP_NOFAIL,
> > as it's the caller's responsibility to check the return value. However,=
 with
> > __GFP_NOFAIL, users will directly dereference *(p + offset) even when
> > p =3D=3D NULL. It is how __GFP_NOFAIL is supposed to work.
>
> If the caller is not supposed to pass that flag combination (shit in),
> we are not obligated to give a reasonable result (shit out).
>
> My point is that we should let the caller (possibly?) crash -- the one
> that did something that is wrong -- instead of forcing a crash using
> BUG_ON in this code here.
>
> It should all be caught during testing either way. And if some OOT
> module does something nasty, that's not our responsibility.
>
> BUG_ON is not a way to write assertions into the code.

It seems there was a misunderstanding regarding the purpose of
this change. we actually have many details in changelog.

Its aim is not to write an assertion, but rather to prevent exposing
a security vulnerability.

Returning NULL doesn't necessarily crash the caller's process, p->field,
*(p + offset) deference could be used by hackers to exploit the system.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry
