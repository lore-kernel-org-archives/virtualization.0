Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375213C68E
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308644; cv=none; b=mEML+yPJMOvx8f0xfVQIwGGXU9wI6I0IQLEFDmtefbMD2g0d1fV9X8+a6SQMRetfsFhl4Qbjj6ZIVGyBiZG64kN95wwufCvxltVoHU7fEGujNbfAA9qHmHTHMG1utCV5aLwMoBNk9w3/pWTU+EEMbys73mZ1e+mFed0iCrp2kHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308644; c=relaxed/simple;
	bh=M1Zp8PUTNvRyYIIyw5D/h1RqQe2eFDjC1H1W6MCFBr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIm2fLJ9UYT+nf3xpe5LVq9YUfkMNSfPOu1pSoZ5hnQbcf6/eeLNevfcsSrjNQyCbaWATpobeft0kF2dTDbB4Myim5Aaz+GtDnxhlZsw9VXt07YNZMGwzBCloQD0FDQRQlcd2RNiLODS3mHkbAYdVoXN2UIEua4/DcQiCyHNXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXW35l76; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXW35l76"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-498d318c0d1so187121137.2
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724308642; x=1724913442; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AuSCScEbylWk/6QSNhda4EgGXfhf6ylHfAJ9C6jPnc=;
        b=SXW35l7636IENOZ3HF7dn5u7qQO6rTSsKE6Pjq1g4Plvgzl5UuNDVtLHlP0eHg8iFM
         eixFJeavIdjo71bGjBTLCItJboQVWs+b7x4up8H/LnxBHPShakWU2nZ0xfKHMbMM/Mxj
         YMY/kaFX05ccpZ8lWcUxHkEV87Jfp5DjWQAbcP5glupDid+VNsYjdSkMUkJ2yvKf2WzM
         sZJOuJxz8tenX916O8QhibjPsjwJW2lWrWH4bmDlXYgPGufUkNaOOWpfmKDgxKRH5suU
         gczFK0vN6/4W+2R7hetoFP6QobUPy9Z/ogjscCxiWevV9ftHJhPTWuNhZJJG/Dvsa3fS
         By7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308642; x=1724913442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AuSCScEbylWk/6QSNhda4EgGXfhf6ylHfAJ9C6jPnc=;
        b=EBaigreUT8ArEoocGCwwjeOUdlmTol463ZBbjU8ZTR88jaNRh0RmnnwT36A5BON3wo
         cYFb4F8d/kijT/GY2kfUG4csxwPHygCXKkxzWAbYni7K0Bg8BneEHl1LWOQQEKMbhLXD
         wpV5A+Ir1TskRgxvPxO4ht3DhOm46S2yJsTQvk0Fe1JAPAyNXkwlzrSjIzdusEQlIgeu
         F823+ZebsSheTz+QmRFR5cd3SyjXFLuoskoMZ8LxXJORsEoirUQV+Fd5NGeWirx+K0iL
         wfBXl0h/DKK9XOKw+kGGfQdJI0rPSkUH3ezEYSBIQ5MDDwDKpGQQDNvefj8xDUvxxHEL
         xQJg==
X-Forwarded-Encrypted: i=1; AJvYcCVQPGo6iCUgfedPMYiX82vTlo1Ug5/RF+33bzsC6y1W8OaOxmBXPMwsz0b0tk/5iRLQTPQmbhRZ+m+W2pp6ug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1Q9hN8FrX2uuOJX9dcus/xsdtwsQBytHwH/kR+4lQgTjRBkVJ
	ICqAgI+hScru12JIJdi8SPEPHxoh/uYErdZuTQwFQcwqBJqnYRB+MHJ56sseb957ESnWGKrV1+b
	FrlhwNS6xPXzPZu41OgHx4zwarRk=
X-Google-Smtp-Source: AGHT+IFIQ1RumAQJ42/U2rDSoTKvx25U4gHqv/JJFxcqywi9lEKn/prxBiaXWNwAVRltwlGJVJWpFdew9Ort2xw3K8A=
X-Received: by 2002:a05:6102:6cb:b0:497:70db:ffcf with SMTP id
 ada2fe7eead31-498e724ad59mr776170137.19.1724308641592; Wed, 21 Aug 2024
 23:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com> <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
In-Reply-To: <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 18:37:10 +1200
Message-ID: <CAGsJ_4xbrrOy84CnZ-x1MG9FhBqp8E-bz6KfB9eku+kd_xsWFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 12:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Tue, Aug 20, 2024 at 12:05=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, 19 Aug 2024 at 06:02, David Hildenbrand <david@redhat.com> wrot=
e:
> > > >
> > > > If we must still fail a nofail allocation, we should trigger a BUG =
rather
> > > > than exposing NULL dereferences to callers who do not check the ret=
urn
> > > > value.
> > >
> > > I am not convinced that BUG_ON is the right tool here to save the wor=
ld,
> > > but I see how we arrived here.
> >
> > I think the thing to do is to just add a
> >
> >      WARN_ON_ONCE((flags & __GFP_NOFAIL) && bad_nofail_alloc(oder, flag=
s));
> >
> > or similar, where that bad_nofail_alloc() checks that the allocation
> > order is small and that the flags are sane for a NOFAIL allocation.
> >
> > Because no, BUG_ON() is *never* the answer. The answer is to make sure
> > nobody ever sets NOFAIL in situations where the allocation can fail
> > and there is no way forward.
> >
> > A BUG_ON() will quite likely just make things worse. You're better off
> > with a WARN_ON() and letting the caller just oops.
> >
> > Honestly, I'm perfectly fine with just removing that stupid useless
> > flag entirely. The flag goes back to 2003 and was introduced in
> > 2.5.69, and was meant to be for very particular uses that otherwise
> > just looped waiting for memory.
> >
> > Back in 2.5.69, there was exactly one user: the jbd journal code, that
> > did a buffer head allocation with GFP_NOFAIL.  By 2.6.0 that had
> > expanded by another user in XFS, and even that one had a comment
> > saying that it needed to be narrowed down. And in fact, by the 2.6.12
> > release, that XFS use had been removed, but the jbd journal had grown
> > another jbd_kmalloc case for transaction data. So at the beginning of
> > the git archives, we had exactly *one* user (with two places).
> >
> > *THAT* is the kind of use that the flag was meant for: small
> > allocations required to make forward progress in writeout during
> > memory pressure.
> >
> > It has then expanded and is now a problem. The cases using GFP_NOFAIL
> > for things like vmalloc() - which is by definition not a small
> > allocation - should be just removed as outright bugs.
>
> One potential approach could be to rename GFP_NOFAIL to
> GFP_NOFAIL_FOR_SMALL_ALLOC, specifically for smaller allocations, and
> to clear this flag for larger allocations. However, the challenge lies
> in determining what constitutes a 'small' allocation.

I'm not entirely sure if our concern is with higher order or larger size. H=
igher
order might pose a problem, but larger size(not too large) isn't
always an issue.
Allocating 100 * 4KiB pages is possibly easier than allocating a single
128KB folio.

Are we trying to limit the physical size or the physical order? If the conc=
ern
is order, vmalloc manages __GFP_NOFAIL by mapping order-0 pages. If the
concern is higher order, this sounds reasonable.  but it seems the buddy
system already has code to trigger a warning even for order > 1:

struct page *rmqueue(struct zone *preferred_zone,
                        struct zone *zone, unsigned int order,
                        gfp_t gfp_flags, unsigned int alloc_flags,
                        int migratetype)
{
        struct page *page;

        /*
         * We most definitely don't want callers attempting to
         * allocate greater than order-1 page units with __GFP_NOFAIL.
         */
        WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));

        if (likely(pcp_allowed_order(order))) {
                page =3D rmqueue_pcplist(preferred_zone, zone, order,
                                       migratetype, alloc_flags);
                if (likely(page))
                        goto out;
        }
        ....
}

>
> >
> > Note that we had this comment back in 2010:
> >
> >  * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the cal=
ler
> >  * cannot handle allocation failures.  This modifier is deprecated and =
no new
> >  * users should be added.
> >
> > and then it was softened in 2015 to the current
> >
> >  * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the cal=
ler
> >  * cannot handle allocation failures. New users should be evaluated car=
efully
> >   ...
> >
> > and clearly that "evaluated carefully" actually never happened, so the
> > new comment is just garbage.
> >
> > I wonder how many modern users of GFP_NOFAIL are simply due to
> > over-eager allocation failure injection testing, and then people added
> > GFP_NOFAIL just because it shut up the mindless random allocation
> > failures.
> >
> > I mean, we have a __GFP_NOFAIL in rhashtable_init() - which can
> > actually return an error just fine, but there was this crazy worry
> > about the IPC layer initialization failing:
> >
> >    https://lore.kernel.org/all/20180523172500.anfvmjtumww65ief@linux-n8=
05/
> >
> > Things like that, where people just added mindless "theoretical
> > concerns" issues, or possibly had some error injection module that
> > inserted impossible failures.
> >
> > I do NOT want those things to become BUG_ON()'s. It's better to just
> > return NULL with a "bogus GFP_NOFAIL" warning, and have the oops
> > happen in the actual bad place that did an invalid allocation.
> >
> > Because the blame should go *there*, and it should not even remotely
> > look like "oh, the MM code failed". No. The caller was garbage.
> >
> > So no. No MM BUG_ON code.
> >
> >                     Linus
> >
>
>
> --
> Regards
> Yafang

Thanks
Barry
