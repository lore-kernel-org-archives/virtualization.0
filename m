Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF2134AC
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244096; cv=none; b=PQtrX5JPDkS85ihpNK/O3DIwgTxcqP0M6RA3vM/B26qsrzz7pQ8v8EJb8cvdG/3s9GFPPm5DR8ITU+lU2dKQRUHdehHX6RmCVT/Fh+xqQwzlxlPRqSzT/n28BCRMFHR4lgPPbNixuG3Q+6H6r4YNPtKJBof0e8Nx9Keugn+4Ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244096; c=relaxed/simple;
	bh=6AK0WLHOdWmMgQC1alPbDQFX64bcPbT335gHtJBxKBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2JjWaGfVcF04AHqGIsuVI4Kjd04/ueuao0Y/J4F3gjVCFBvKc8juMAvjR+OkkihIQ61Vwf3fLLNSqqwWHthLY7nvpXexqXiOguw9LMbsoFUPzM193j3XnCbl1iWhzBAfrHGcwHDH4kOum0uqP33kB3vOuhQqTZemfDHE7OWbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/XMK9vs; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/XMK9vs"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-844bf4b5051so395403241.3
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244094; x=1724848894; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLZMJpmpzGt5GhCbFn0EpW7Uj9M6X8hFyELkG7gj5uU=;
        b=G/XMK9vsYKWBd3YHN/BJmGzPeeblrZbIjd9vBYXscs7Cko8dQLeiI35sYY0NngRFRS
         DTLLTVcr8CNWFRJT256ifC9vT/CESa/j/uqOafLa270tV4rJRa7F3iZc9Pt5Gbj2KHRi
         bddD36u0s7xx4f8TgRtTiMxj6wf0zuCu1eqNbRvCHBnBQUTyCVETOuuEqEtKyeO3GZns
         Pnbn/iAmQlZa9riohh0vLNlTNJUW/LDkx1DvdtktQYnOyG3WMtouYpsdP5TwH2TiTqsa
         U5orYb8+QqbhcwAHibEfi/Huh9hGw1f4Ba/smHHmq83L3rdVaxfAgOpsncWm5Tu6JLJj
         GE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244094; x=1724848894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLZMJpmpzGt5GhCbFn0EpW7Uj9M6X8hFyELkG7gj5uU=;
        b=K/ajXfGY/4U1GO8zmOz7USXxPiE1f36/Yk9GC2C7i4bzGA7L6j4jT73t+dyQNjM71v
         vkZMoWnQEMp+KizlBlNEgtLRAuKjGLwrEudV3hmJGa2tKLWJD0MBC7PMeOqSlEpJUagr
         FfEsdFM40MXg16Azq/tCylfRLLzBrjKnV5duKXkfln/zDMUJKstYRSG0z0WNQUsi/Rjr
         oCS9C3AHaUQB/O+R5BcXeT180Tclut/Tc8hFxhgWQmGA3vOHpklv1dAxGn8+D0bDWVqF
         Kcn21YNRbvEH/p1s8+VgK1bhjWfGQA6cNXVBapiUPsO9wrtCmX/WB+u6L3O2d83m0tIu
         lHQw==
X-Forwarded-Encrypted: i=1; AJvYcCVOPtdEixoc6EwxR3gkRV0YhsUhfrQTIYfpkgMTVwcJA4wPa7diKOey3hwOgMygGQD92zt1OqfK40leo870JA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxV0TjgdKfsW/zs97ohXTTZ1AJ8IW2KC9ti1Vyk3dw4pjIa6CIs
	KYNhH3xJyDJ9imF946IlikE0ZQMAQTi73wygjrA6xn1lOEIBRulnmL9GjebbnEjp7AEk3c9beXn
	uFX5OZfaEmR2MnJrHPwfqltRA6XA=
X-Google-Smtp-Source: AGHT+IGnM2JOP3BDTAlgVEWy9Jwa8Xn67U8sTX4goz/aFENoIfFfkW/zg10z5jA+HbAXH3KlXwA39DrlPe0lgrnjkTA=
X-Received: by 2002:a05:6102:26c8:b0:497:6bb5:398a with SMTP id
 ada2fe7eead31-498d2eb7a78mr2537587137.7.1724244094122; Wed, 21 Aug 2024
 05:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 Aug 2024 20:40:56 +0800
Message-ID: <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, mhocko@suse.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, 
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 12:05=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 19 Aug 2024 at 06:02, David Hildenbrand <david@redhat.com> wrote:
> > >
> > > If we must still fail a nofail allocation, we should trigger a BUG ra=
ther
> > > than exposing NULL dereferences to callers who do not check the retur=
n
> > > value.
> >
> > I am not convinced that BUG_ON is the right tool here to save the world=
,
> > but I see how we arrived here.
>
> I think the thing to do is to just add a
>
>      WARN_ON_ONCE((flags & __GFP_NOFAIL) && bad_nofail_alloc(oder, flags)=
);
>
> or similar, where that bad_nofail_alloc() checks that the allocation
> order is small and that the flags are sane for a NOFAIL allocation.
>
> Because no, BUG_ON() is *never* the answer. The answer is to make sure
> nobody ever sets NOFAIL in situations where the allocation can fail
> and there is no way forward.
>
> A BUG_ON() will quite likely just make things worse. You're better off
> with a WARN_ON() and letting the caller just oops.
>
> Honestly, I'm perfectly fine with just removing that stupid useless
> flag entirely. The flag goes back to 2003 and was introduced in
> 2.5.69, and was meant to be for very particular uses that otherwise
> just looped waiting for memory.
>
> Back in 2.5.69, there was exactly one user: the jbd journal code, that
> did a buffer head allocation with GFP_NOFAIL.  By 2.6.0 that had
> expanded by another user in XFS, and even that one had a comment
> saying that it needed to be narrowed down. And in fact, by the 2.6.12
> release, that XFS use had been removed, but the jbd journal had grown
> another jbd_kmalloc case for transaction data. So at the beginning of
> the git archives, we had exactly *one* user (with two places).
>
> *THAT* is the kind of use that the flag was meant for: small
> allocations required to make forward progress in writeout during
> memory pressure.
>
> It has then expanded and is now a problem. The cases using GFP_NOFAIL
> for things like vmalloc() - which is by definition not a small
> allocation - should be just removed as outright bugs.

One potential approach could be to rename GFP_NOFAIL to
GFP_NOFAIL_FOR_SMALL_ALLOC, specifically for smaller allocations, and
to clear this flag for larger allocations. However, the challenge lies
in determining what constitutes a 'small' allocation.

>
> Note that we had this comment back in 2010:
>
>  * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the calle=
r
>  * cannot handle allocation failures.  This modifier is deprecated and no=
 new
>  * users should be added.
>
> and then it was softened in 2015 to the current
>
>  * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the calle=
r
>  * cannot handle allocation failures. New users should be evaluated caref=
ully
>   ...
>
> and clearly that "evaluated carefully" actually never happened, so the
> new comment is just garbage.
>
> I wonder how many modern users of GFP_NOFAIL are simply due to
> over-eager allocation failure injection testing, and then people added
> GFP_NOFAIL just because it shut up the mindless random allocation
> failures.
>
> I mean, we have a __GFP_NOFAIL in rhashtable_init() - which can
> actually return an error just fine, but there was this crazy worry
> about the IPC layer initialization failing:
>
>    https://lore.kernel.org/all/20180523172500.anfvmjtumww65ief@linux-n805=
/
>
> Things like that, where people just added mindless "theoretical
> concerns" issues, or possibly had some error injection module that
> inserted impossible failures.
>
> I do NOT want those things to become BUG_ON()'s. It's better to just
> return NULL with a "bogus GFP_NOFAIL" warning, and have the oops
> happen in the actual bad place that did an invalid allocation.
>
> Because the blame should go *there*, and it should not even remotely
> look like "oh, the MM code failed". No. The caller was garbage.
>
> So no. No MM BUG_ON code.
>
>                     Linus
>


--
Regards
Yafang
