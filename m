Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F61581EF
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815921; cv=none; b=mW1IHPc5xneQUMnGE/AHAqeav/PSxmmOlbghdhMjKb07W/NMlQfTwma57/g7RqrJsK5FfCpfZSKaWMuMzOQBi/k4s+3Ql7uFv7NZfnecxmbWhY9gZNJaV9lZikg12LM7hvn2n0GdI9rAQToSIXRT30R51Nwb2PaWpFRNto1d3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815921; c=relaxed/simple;
	bh=HsTsrVS+OMGvKi4VVljtakKAo6QmM4plAAKFnuNGQdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0VTzBAtPyCqo4NUPkZue4K4I4iGTcD3AOdr4XXQQjoRZul5sPoVmrpLPLjNh9YAfLohCyJqgEmDZObece/mHAAlaYw0WEgwQk6Eq1ziIskSsZHSzaynp7gm0txmt4YrDj/2JYQteGO5DNJzhQ9+bp13dbwj9CZIoCVox5HPNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnGXr6yG; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnGXr6yG"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4929d6429c2so973866137.3
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721815919; x=1722420719; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9GRB8RAjw9CtuU//c8IdZMqiwuacvDKkdwwbVUCl0I=;
        b=TnGXr6yGttKmIwpMRScSZs8H/nAYWiufNZYxuKGT86FfzegjnNLg02bhsrdH5RqkRl
         UpgbcPpYmi4aG8mkktvVmmlB+GbXOc/eR0+1mbG8/W6s7rseNqGj2+4+HIe6+rsoLbBS
         aei6gnuM2TmKQ+QYWoP1odF17rIjodjj004bNpf+A/edKtUVhP3Hl9VXEzMerNcj2SvO
         kIwt3w0Jn/XorkuoxlbM7zWY1B2szVwzE2ANPp13STDuHAibSXvLLFzxwEJ/Rgi1tci7
         mKRyiRNaO0nZmr9nDlroKlCYrJQ2cN9HrwMfuvNTeUEXreNVhWBtORhirHAjcj8wMUfj
         LLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721815919; x=1722420719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9GRB8RAjw9CtuU//c8IdZMqiwuacvDKkdwwbVUCl0I=;
        b=NOIZAIFiWg3DteyS2EpzbSzIuIUKGLc0wLYANScQiV4pGTy1aogAexBwjn66EyG44W
         B3clky/exuGP+Hppcu8lgAk02ZD0NPxINHAHbTSH6AIC3YE4+FSOFwcsYDFpbtDqsp5m
         olew763Ab2OXkvrtS+97yqy1J1dJYxX6SPg+C0AhcEETEdOYXrxtX707Z5bkuQU+n0vI
         X/jqB/bZL3N0lcjGc3wccpKtqjynQEQ+TkUzhK4YUxBWRk5vRMGECTtGg8w3N8kUCiEC
         HhARohWc/B6033hCSFFarrqim8BftPKZijJqK7rLRPgWwuYSN25km1ACMm8DjGxb/BwN
         LHxg==
X-Forwarded-Encrypted: i=1; AJvYcCVhCq5oZruU+7CKXyKDp90CdqQVwLuPVc9d/+g7YXHbe3RO5FZxVd9SFEV6RxhY3gHV6sk28Z5O8BPm28sqgUw9vhCxuhKPoIEbFDpnbBw=
X-Gm-Message-State: AOJu0Yztw0Cn09TF2saGsK2R+fGO+A6wrpL2/rjN8ZB9leJzn+B0BK/1
	Y1/htunIJ8rA4FIoamDBO+xGbdi8u+0newcsPWbbkx5IDMFRbDGnlGVWhKiY50v0bDg22GyLZVV
	aJb9Q93c6LPB6G33GmQOsshozEn4=
X-Google-Smtp-Source: AGHT+IFzE44rmuWnOKwwOuqrwpZBAHJmtmTqgX0cVzJxoiAsk2PFZBqXCXEHq1NI2cmdwGdjMCjST76ctlRVoCFj7Cc=
X-Received: by 2002:a05:6102:33cb:b0:48f:e09e:ef60 with SMTP id
 ada2fe7eead31-493c4bc3bc2mr965783137.29.1721815918800; Wed, 24 Jul 2024
 03:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724085544.299090-1-21cnbao@gmail.com> <20240724085544.299090-4-21cnbao@gmail.com>
 <419e9b88-de76-4f17-a785-2579f62ad880@suse.cz>
In-Reply-To: <419e9b88-de76-4f17-a785-2579f62ad880@suse.cz>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 24 Jul 2024 22:11:47 +1200
Message-ID: <CAGsJ_4w5ZmtohiJW5wDT-ZGHZnryBk7LsG9Hbm1KrKm_TghwkA@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: BUG_ON to avoid NULL deference while __GFP_NOFAIL fails
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, 
	torvalds@linux-foundation.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:03=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/24/24 10:55 AM, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > We have cases we still fail though callers might have __GFP_NOFAIL.
> > Since they don't check the return, we are exposed to the security
> > risks for NULL deference.
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
>
> Note that quote was meant specifically for the "too large" allocation, wh=
ich
> is truly impossible. That includes the kvmalloc_array() overflow, order >
> MAX_ORDER etc.

I equally quote this for two cases because non-sleepable is also returning =
NULL,
in this means, they are currently facing the same problems.

>
> The "can't sleep/reclaim" is a bit more nuanced as there's the alternativ=
e
> in just warning and looping and hoping kswapd or some other direct reclai=
mer
> saves the day. If yes, great, we have a system that still works and a
> warning to repor. If no, there's still a warning, but later soft/hardlock=
up
> hits. These might be eventually worse than an immediate BUG_ON so it's no=
t a
> clear cut. At least I think these cases should be handled in two differen=
t
> patches and not together.

But I fully agree these two can be separated and judged separately.

After more thinking, I am concerned that this issue might be difficult to b=
e
rescued, as the misuse of GFP_ATOMIC | __GFP_NOFAIL typically occurs
in atomic contexts with strict time requirements. Even if some other
components release memory to satisfy the one busy-looping to obtain
memory, it might already be too late?

>
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
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Kees Cook <kees@kernel.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/slab.h |  4 +++-
> >  mm/page_alloc.c      | 10 +++++-----
> >  mm/util.c            |  1 +
> >  3 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index c9cb42203183..4a4d1fdc2afe 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size, =
gfp_t flags, int node)
> >  {
> >       size_t bytes;
> >
> > -     if (unlikely(check_mul_overflow(n, size, &bytes)))
> > +     if (unlikely(check_mul_overflow(n, size, &bytes))) {
> > +             BUG_ON(flags & __GFP_NOFAIL);
> >               return NULL;
> > +     }
> >
> >       return kvmalloc_node_noprof(bytes, flags, node);
> >  }
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 45d2f41b4783..4d6af00fccd4 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4435,11 +4435,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned=
 int order,
> >        */
> >       if (gfp_mask & __GFP_NOFAIL) {
> >               /*
> > -              * All existing users of the __GFP_NOFAIL are blockable, =
so warn
> > -              * of any new users that actually require GFP_NOWAIT
> > +              * All existing users of the __GFP_NOFAIL are blockable
> > +              * otherwise we introduce a busy loop with inside the pag=
e
> > +              * allocator from non-sleepable contexts
> >                */
> > -             if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > -                     goto fail;
> > +             BUG_ON(!can_direct_reclaim);
> >
> >               /*
> >                * PF_MEMALLOC request from this context is rather bizarr=
e
> > @@ -4470,7 +4470,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned i=
nt order,
> >               cond_resched();
> >               goto retry;
> >       }
> > -fail:
> > +
> >       warn_alloc(gfp_mask, ac->nodemask,
> >                       "page allocation failure: order:%u", order);
> >  got_pg:
> > diff --git a/mm/util.c b/mm/util.c
> > index 0ff5898cc6de..a1be50c243f1 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -668,6 +668,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(siz=
e, b), gfp_t flags, int node)
> >       /* Don't even allow crazy sizes */
> >       if (unlikely(size > INT_MAX)) {
> >               WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> > +             BUG_ON(flags & __GFP_NOFAIL);
> >               return NULL;
> >       }
> >
>
