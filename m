Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F615B55D
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060858; cv=none; b=o9igCRnuKB1b+UWW3ETszTMr+KZQ/jwHf+pOoEiTZ6A9CIJV17DqQe7cJfOKRsDVRgeUJWyiqdWg+877EqAunlISwLAlYkkBbB+EKyDP/gaUHvkmUhf6PBuoR8scD2eoFm3W1Fsg0i6aRXLxi7fm2WXkYjAKsCv+Rgpefz1HK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060858; c=relaxed/simple;
	bh=VuKKs84tYBKrFAuvN3pGnN/SM9WHaB7sI31kL/WYPOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ef/2a6e1jLi2c0iww141Ht9pxa28sS6BXYDTk4CpAhbETEaI+PDvUFfYrWbg1qEqKO8xjUaFIiKtjqOGTd6kR4k3kcqp5kOhU2T0f9BSoiIUygipujk7Suz4DMn7SEuAenNeGKbchTwKVGVVsvCJRgYN9eJQcE4aFaa4duE2SwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQNvP3Z0; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQNvP3Z0"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-493d7455231so1432183137.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724060856; x=1724665656; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xbejarYMKiQbEM/kf06MHZ/zKxP3Rp8SKcsyHToWCM=;
        b=fQNvP3Z0h8s0gzEwJtjXEcQeAfKnH/BXEE05nqgpt3jrDZziw+FCBeIZcHSvtRG7OB
         YdMsJBAkxriLfuM7TaLc138Q8ii0NBOoCXQG+282kOR5gZj6HkIvwAjIdkgpVfHvEbse
         Xf65Mt5U8wp/oiS/+NXTFJKEKMUfCXUAqpPJlnVqxVjXkVn+zze1pr3wfIq4aCT1F2hv
         KpPR6UAOxEQqNZTkHsyj5Y2RyLgNaDRm2vKbPYc0zcATepyP1BlTZDOxYd7UtDFLsRv3
         ptZhJ6gTHtOfvaK/wJtqyqhTeTZyBNOXQfG8oQnNZdkHvTscIKlwux0s+93Kc/BX+jb/
         xULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060856; x=1724665656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xbejarYMKiQbEM/kf06MHZ/zKxP3Rp8SKcsyHToWCM=;
        b=ccxt8s41PkLUDFLZF+2EvoqINIEAYM7IzZ05uh5By1A9DqfNzfjrY+NnxoUXaZQFI2
         a8J5T6LOBOnlkV7BYW9paJswxwzi7KhT/sVCROo3H+x8n3lVkNsc9Y5xWoDt3PGMhVrU
         HWm67ARoLxCrjkru7oh5MVCwGxFqr0be8GRBYf/PuX2xwNlmwDmT8vm5ftmnrTn3jn1j
         elXc5gMAL/+rdKmcQ7Jlw9zCXjf6JGCF4TjxbaT6796dimsNcMgbUNBr8W+4uQN1KOU/
         fgf+nSPJY+MjQiXrENao5o0xgDK0DFmOrRmCVSsZycTKXuG1vWF0rVpoWQKzUtbIKRbi
         /1jw==
X-Forwarded-Encrypted: i=1; AJvYcCW125ag45JyJ4foy0ZUES4ab2ros1AUr2mHrZ+ZOk5vOtWbvGssbk7gSPe5LFibHszm+uEHQknD1B2ahmUjzSb1L9M5Qz7FRP0fVRvSQQA=
X-Gm-Message-State: AOJu0Yxw6wcOnHz8eNLAhfVtC/4XiCTWp9v74n5CgigVlbdrWmEx04NY
	wVRKebWq/LU+NLEotUncuT/EapGEQjg/+Yrb6NAhmjmxWCOvChfvFlJUH5baXKWxd4oOoy/ZKkY
	qZPULv+2WvHevv9qs6X+20MqS2Fc=
X-Google-Smtp-Source: AGHT+IEk7c1sRiQ8T7Kj2zOqlRKg8J4U5Q2AmFztIv5napM84afxAVkC8YWWSFfC0mCSRYx76qLETWBETO5UiTFZFI0=
X-Received: by 2002:a05:6102:32d2:b0:493:c89b:1c8f with SMTP id
 ada2fe7eead31-49779883c70mr13098485137.3.1724060855801; Mon, 19 Aug 2024
 02:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com>
In-Reply-To: <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 19 Aug 2024 21:47:25 +1200
Message-ID: <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
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

On Mon, Aug 19, 2024 at 9:43=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.08.24 08:24, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > We have cases we still fail though callers might have __GFP_NOFAIL.  Si=
nce
> > they don't check the return, we are exposed to the security risks for N=
ULL
> > deference.
> >
> > Though BUG_ON() is not encouraged by Linus, this is an unrecoverable
> > situation.
> >
> > Christoph Hellwig:
> > The whole freaking point of __GFP_NOFAIL is that callers don't handle
> > allocation failures.  So in fact a straight BUG is the right thing
> > here.
> >
> > Vlastimil Babka:
> > It's just not a recoverable situation (WARN_ON is for recoverable
> > situations). The caller cannot handle allocation failure and at the sam=
e
> > time asked for an impossible allocation. BUG_ON() is a guaranteed oops
> > with stracktrace etc. We don't need to hope for the later NULL pointer
> > dereference (which might if really unlucky happen from a different
> > context where it's no longer obvious what lead to the allocation failin=
g).
> >
> > Michal Hocko:
> > Linus tends to be against adding new BUG() calls unless the failure is
> > absolutely unrecoverable (e.g. corrupted data structures etc.). I am
> > not sure how he would look at simply incorrect memory allocator usage t=
o
> > blow up the kernel. Now the argument could be made that those failures
> > could cause subtle memory corruptions or even be exploitable which migh=
t
> > be a sufficient reason to stop them early.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > Cc: Hailong.Liu <hailong.liu@oppo.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   include/linux/slab.h | 4 +++-
> >   mm/page_alloc.c      | 4 +++-
> >   mm/util.c            | 1 +
> >   3 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index c9cb42203183..4a4d1fdc2afe 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size, =
gfp_t flags, int node)
> >   {
> >       size_t bytes;
> >
> > -     if (unlikely(check_mul_overflow(n, size, &bytes)))
> > +     if (unlikely(check_mul_overflow(n, size, &bytes))) {
> > +             BUG_ON(flags & __GFP_NOFAIL);
> >               return NULL;
> > +     }
> >
> >       return kvmalloc_node_noprof(bytes, flags, node);
> >   }
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 60742d057b05..d2c37f8f8d09 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4668,8 +4668,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, uns=
igned int order,
> >        * There are several places where we assume that the order value =
is sane
> >        * so bail out early if the request is out of bound.
> >        */
> > -     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> > +     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {
> > +             BUG_ON(gfp & __GFP_NOFAIL);
> >               return NULL;
> > +     }
> >
> >       gfp &=3D gfp_allowed_mask;
> >       /*
> > diff --git a/mm/util.c b/mm/util.c
> > index ac01925a4179..678c647b778f 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -667,6 +667,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(siz=
e, b), gfp_t flags, int node)
> >
> >       /* Don't even allow crazy sizes */
> >       if (unlikely(size > INT_MAX)) {
> > +             BUG_ON(flags & __GFP_NOFAIL);
>
> No new BUG_ON please. WARN_ON_ONCE() + recovery code might be suitable he=
re.

Hi David,
WARN_ON_ONCE()  might be fine but I don't see how it is possible to recover=
.

>
> --
> Cheers,
>
> David / dhildenb
>
