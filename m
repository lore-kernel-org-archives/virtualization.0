Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8711B81C7
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966879; cv=none; b=kC6Fz3hW6CR0u/sHVC0u7QM7JFH8hQb2fzCDEJs899Bdxafn7zrdv68IZyhs6f0x3KemxOnJ4HH0PaExd8HtuphX86vp4tpkqev9HYE+FBG+Fq1CxoDd2L3pPYIrbmZAEzeU4H2kLhmI9WouwnGKTuq0fx7MeJQJ4K2b6QKL/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966879; c=relaxed/simple;
	bh=xI6jWtDgVhVAyox0ou6HEMJsKQJYYT51z7Bn75Qsv9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dy1RIj+1++PYR5H+LMPooA3xVqf7hzzAoBTbHQthTaDsGoZBe7q8e+b5KBdlMd+ylfmL2O3v6A1ceMUJjoPoZ5vUDxVzrkl9JT932wr72fOcY8ZQRTkVswOizjCgbZHgi2IBYI3JXsds+qHF2ZGu9H6ujHWUsEA7e868GWKuIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrQTN9QZ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrQTN9QZ"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-842fd4e4de7so360256241.1
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724966877; x=1725571677; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b74/nL6yM7DqQj6YIDRSkjEeKfBsodW/MeHd7rIt+PI=;
        b=GrQTN9QZ2ZuQFhXaYecQhREyvjYOq7+VBFHEmkoc0v3TlNtmHg0ytMpFXqQvzEexvs
         sWpac5VGMpurN7dOslEE/7mhDD9H4souFEXfv0KQKpiiWJGEQPIt/VOgKjxYRxFD2mlG
         oGgrHuv8oD5znKQlvxJ4PS24WP/00RoRSGxBg/r+NpUwbMk0F8Zw707gWUFrGbkXemdp
         GzZzw297BLy4Aen++s6s2VKHJMJ0j5E9VeW8LucHAwRjWaAycGT6rJEt32XP5EFsKcJ/
         HmlGRjbje1ehcJqG+D1TtUmbGMYBocEkpkN5LxipRP6W3+gES/aNK90Jw5RG3qZCWiV6
         qtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724966877; x=1725571677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b74/nL6yM7DqQj6YIDRSkjEeKfBsodW/MeHd7rIt+PI=;
        b=BOR5jEmJJdKOlT+dtbH7B1AdADHH8LX7DgcOyN4uMEVz9d87iU/tcKvDJfgaisiGld
         tpyDV8XUCeONXA9zdyBTK1YFaksiP0fgo6qhjhMrurvzSrxz9ZrnuYq21Tc396lxwdW5
         yxjH647iymhMtikgjJyI7iB3X7LK3/5B8Z0mPZJcjDyRqpwgntZ071nr5l2p8ZNxVGN4
         lfRc7IxNmXDbw/BzgagB3H77noAgTfjRfmJcepTm2jc1uAJWocXF11okyvQIhukWeBCt
         t51x+9uShKUb57ZpkyD1emf3e8L0E7c+ojffbICLYDBo8j4tJu5AUQx4wd4iJBZ+Cwo8
         eIuA==
X-Forwarded-Encrypted: i=1; AJvYcCUxxd7ajOfrtmHfDnvs0T7H++SE6L910zY88n0s0eKJQpZZzm45yxC8lXqW/uA022nPcTD0YJmYjcbSlCh1Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNfDLobS6qPdECUUU+u2BrRbV9IlEeWQOU9r0S7ZHuY79aoEC6
	T8/KczrCZOoEAuEhl2lzqiIhHZpaE3qJ0QAaeWFW39+2n5mFOueLCpvvaGPBUKmFHsRnXb+ffpF
	TYox9Q3OKudcqagyjoDUJQfZ28oo=
X-Google-Smtp-Source: AGHT+IHFl75GTpZGRhFgVBJELmEX9X/2XagOVMq2pkrForU7wgZKEZm8rM3Zk7y1bShZr5WrMKfOlQpwnaSO7fbHhbY=
X-Received: by 2002:a05:6102:c92:b0:48f:cb62:231a with SMTP id
 ada2fe7eead31-49a5b1a85ffmr4651130137.23.1724966876680; Thu, 29 Aug 2024
 14:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka> <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
 <be4c9110-72d0-4749-941e-797a861d8319@suse.cz> <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
 <c258403c-afc5-4969-b7c5-fa2a6c257371@suse.cz> <CAGsJ_4wu3theWe0iyXdBK-JvLfuBh7Qw-B+9Wztm2XyrU1Uzeg@mail.gmail.com>
 <2663352f-ecef-4e5b-bee5-e31d2b286c63@suse.cz> <CAGsJ_4zY5jwCsJh94OFMi1UqzFu5Ji3OeJZz91p2YKT5jxBc5A@mail.gmail.com>
 <ZtB1lLljEk9PVkU7@tiehlicka>
In-Reply-To: <ZtB1lLljEk9PVkU7@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 30 Aug 2024 09:27:45 +1200
Message-ID: <CAGsJ_4wZiE08XDjNAPENwH=KQEzdm2FB_bMDi0b7PJx+e7ydrA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, virtualization@lists.linux.dev, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:20=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 29-08-24 23:53:33, Barry Song wrote:
> > On Thu, Aug 29, 2024 at 10:24=E2=80=AFPM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> > >
> > > On 8/27/24 09:50, Barry Song wrote:
> > > > On Tue, Aug 27, 2024 at 7:38=E2=80=AFPM Vlastimil Babka <vbabka@sus=
e.cz> wrote:
> > > >>
> > > >>
> > > >> Ugh, wasn't aware, well spotted. So it means there at least should=
n't be
> > > >> existing users of __GFP_NOFAIL with order > 1 :)
> > > >>
> > > >> But also the check is in the hotpath, even before trying the pcpli=
sts, so we
> > > >> could move it to __alloc_pages_slowpath() while extending it?
> > > >
> > > > Agreed. I don't think it is reasonable to check the order and flags=
 in
> > > > two different places especially rmqueue() has already had
> > > > gfp_flags & __GFP_NOFAIL operation and order > 1
> > > > overhead.
> > > >
> > > > We can at least extend the current check to make some improvement
> > > > though I still believe Michal's suggestion of implementing OOPS_ON =
is a
> > > > better approach to pursue, as it doesn't crash the entire system
> > > > while ensuring the problematic process is terminated.
> > >
> > > Linus made clear it's not a mm concern. If e.g. hardening people want=
 to
> > > pursuit that instead, they can.
> > >
> > > BTW I think BUG_ON already works like this, if possible only the call=
ing
> > > process is terminated. panic happens in case of being in a irq contex=
t, or
> >
> > you are right. This is a detail I overlooked in the last discussion.
> > BUG_ON has already been exactly the case to only terminate the bad
> > process if it can
> > (panic_on_oops=3DN and not in irq context).
>
> Are you sure about that? Maybe x86 implementation treats BUG as oops but
> is this what that does on all arches? BUG() has historically meant stop
> everything and die and I am not really sure when that would have
> changed TBH.

My ARM64 machine also only terminates the bad process by BUG_ON()
if we are not in irq and we don't set panic_on_oops.

I guess it depends on HAVE_ARCH_BUG? if arch has no BUG(), BUG()
will be just a panic ?

#ifndef HAVE_ARCH_BUG
#define BUG() do { \
        printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func_=
_); \
        barrier_before_unreachable(); \
        panic("BUG!"); \
} while (0)
#endif

I assume it is equally difficult to implement OOPS_ON() if arch lacks
HAVE_ARCH_BUG ?

"grep" shows the most mainstream archs have their own HAVE_ARCH_BUG:

$ git grep HAVE_ARCH_BUG
arch/alpha/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/arc/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/arm/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/arm64/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/csky/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/loongarch/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/m68k/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/mips/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/mips/include/asm/bug.h:#define HAVE_ARCH_BUG_ON
arch/parisc/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/powerpc/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/powerpc/include/asm/bug.h:#define HAVE_ARCH_BUG_ON
arch/riscv/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/s390/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/sh/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/sparc/include/asm/bug.h:#define HAVE_ARCH_BUG
arch/x86/include/asm/bug.h:#define HAVE_ARCH_BUG

>
> > > due to panic_on_oops. Which the security people are setting to 1 anyw=
ay and
> > > OOPS_ON would have to observe it too. So AFAICS the only difference f=
rom
> > > BUG_ON would be not panic in the irq context, if panic_on_oops isn't =
set.
> >
> > right.
> >
> > > (as for "no mm locks held" I think it's already satisfied at the poin=
ts we
> > > check for __GFP_NOFAIL).
> >
> > Let me summarize the discussion:
> >
> > Patch 1/4, which fixes the misuse of combining gfp_nofail and atomic
> > in vdpa driver, is necessary.
> > Patch 2/4, which updates the documentation to clarify that
> > non-blockable gfp_nofail is not
> >                   supported, is needed.
>
> Let's please have those merged now.
>
> > Patch 3/4: We will replace BUG_ON with WARN_ON_ONCE to warn when the
> > size is too large,
> >                  where gfp_nofail will return NULL.
>
>
> I would pull this one out for a separate discussion. We should really
> define what the too large really means and INT_MAX etc. is not it at
> all.

make sense.

>
> > Patch 4/4: We will move the order > 1 check from the current fast path
> > to the slow path and extend
> >                  the check of gfp_direct_reclaim flag also in the slow =
path.
>
> OK, let's have that go in now as well.
>
> --
> Michal Hocko
> SUSE Labs

Thanks
Barry
