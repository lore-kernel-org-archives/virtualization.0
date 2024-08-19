Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474714BFA2
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095427; cv=none; b=trn1RKQHD5cybvN579spkTLWaXcX+uyoBSreqvzrAqKFfLm5FHCh94lytzadvcfAXWhg5Z+4GKhx/OBDLun7X12gdceSQ2uegHlg3u3rWifOAn25EH4M1QM2Q0eKKwE/BH3QDUfXgC0LH55kEW/yCa0yye8Eu6MsGdbCCkvxP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095427; c=relaxed/simple;
	bh=jJ4OvITJQsSw34kGgVMEgMaGZG2InkxvgCMPhHp5DNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9BS5J/Fiog2VhZQK4SXVvkjGqf2SHMFZ9tCuKmsqY/s9knPHWeDGG6vqaVWqOSj4n3KLkolTKeS7PgOoMg704FbEZpWkzm8PFlBMZKQCHAMBWlFewDn42/taE28ZSwCJP59fyKQezk4Y5ACWbD/h4BR4e5QLFrCZFZxDtdMI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmheTJ7s; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmheTJ7s"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso23686286d6.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724095425; x=1724700225; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzFJ7K9wdRT+QQN8nk00JRyGEe7qfSEYg3oRtqc9s/Y=;
        b=NmheTJ7sItrexgg1BKl6pljYE8wlagItsRIZsv3FuYK55LW7ZkRHME2C14P4RSjMO/
         Wu+6nHS2xXStG77wzoaJcV6cTpXAMPOO+U6DGmNP0RxNGBJ+x54UXYMwMDna49l7S8Gx
         ng7q9bPL1rmupdmIG8AlFD6DUuFpvQJmK+JpN+Kua95nfXY+ND93zAmGpO/qfDZzSVEX
         yAKbzoB+3yXTuhK9e2J42ybuE7p4XwQooCH5uGA/2aETW0ULi1NZA+X05olwfWdIZM44
         YQFEGpEbWTpRZz09uP0u/As2msEsyiHKB/RINZJDSJzPp1Mkn2nMwqgh78UmWHFHv2SQ
         OhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724095425; x=1724700225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzFJ7K9wdRT+QQN8nk00JRyGEe7qfSEYg3oRtqc9s/Y=;
        b=IvUsFKzSFXP9VmlPrtkiTzVy0ZpfXXf2r45KrRy9AefPDYOOsdxCu0phN42Buq9NvP
         3pInrwyk3lE2n0cKBldUiJOVW6LIRTL4PrfBbBcdu29k/xBAImGjOPKl0mZG+xCYBDyA
         /GKSuzKCZtpdjxg5gjR2HjuYlGD98knRgtCWC1x9VUw3i9yEEBKN2LBJG2ReiFn71yAH
         Eax2VARErbJChLPTJSCb8XJHDsZGPpwRnW2PM2gS0U6Jb9TOTQKZIcR0cW7d4ISlxzss
         z8z8/49U3D25lNTZANHIW8WKxv0W9BO306dc+q2VhElOAYDXSML8Spp6cG3UMcIveMn9
         prug==
X-Forwarded-Encrypted: i=1; AJvYcCU1Rn9ffUP+eXaEGR+kEvOl1f4eUC34k9IHApwoEEMtoFDsRXLrbupKiURlDB2hMgR6O4SeJdWBFszsg0RC3ZZhQHh8a6Gw/AK8v5ptKVY=
X-Gm-Message-State: AOJu0Yz4Wu4hy7+Y4n5GVQO90H8l5ckK5A8cIakiF+z/0+CB9nn4Mh4x
	hd//b4/X2xi+H3FVo92RJfaxxb9wITEnHAPkc9Js2Kv2SHnkt9U9UqylRY8h3yjDCXNxXPzZn0b
	33VtAXqk8wrGM71NGIbc4bItRqcM=
X-Google-Smtp-Source: AGHT+IETlY5cNq9g0dHqEUB4cSHIAgnEby1WMSf7rLlyw3/o+UIOTsTYGREIlaqYZFL3bZuBjpvCJZSGSZ64HzX4VC8=
X-Received: by 2002:a05:6214:5490:b0:6bf:8711:ab43 with SMTP id
 6a1803df08f44-6bf8711aee5mr82046406d6.31.1724095424517; Mon, 19 Aug 2024
 12:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 07:23:31 +1200
Message-ID: <CAGsJ_4xwj+trzpOS4b-RSHtqHkD4+0g1Sadr7YCiauOBgd35dQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 4:05=E2=80=AFAM Linus Torvalds
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

That could be an exploit taking advantage of those improper callers,
thus it wouldn=E2=80=99t necessarily result in an immediate oops in callers=
 but
result in an exploit such as

p =3D malloc(gfp_nofail);

using p->field
or
using p + offset

where p->filed or p + offset might be attacking code though p is NULL.

Could we consider infinitely blocking those bad callers:
while (illegal_gfp_nofail)  do_sth_relax_cpu();

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
