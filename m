Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA79171E73
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083529; cv=none; b=sk9Ug9Bh7Q1Zy1tyVVHhqUkG9noaBb2/v1tDMeABHZVuMDXr5XWax6/ECt0YqUJ7AWpeTcFB82M+FOsoWXqt16LW5mc6M0/n0TYt5bPUD0jwI9jhW5mAQLpqgyk1/ZYYYAtXiinIXQL1WQ5LeE6O9wSoxCmlW+hACsLb3hC15Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083529; c=relaxed/simple;
	bh=0Ge0pt+iwkHKoy3I/rc6ZiYGFulyQ3fH+p5SpDfj1QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6TFPyCA0Moi3/RT6BdDoasXXbb6rJyvdC1MPbwTG6O6Vmvedap8w6U+23n7FQ5pcNAkEkZh34Fp5UTbZG9+5i8Lo67cBIVF4Y5pOPfE6RWeaR/3tP6WYn3M3I6RpvDZ3brM7Woajz+gEOJbhapGZWXl3JEgv7Iocu6UMwy9hv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NhZ5twun; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NhZ5twun"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01afa11cso5721745e87.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724083525; x=1724688325; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0av1AdwzyMt+HVE6FQ9tUPI5Mm9RtXw6l9qSQ7ZGdPE=;
        b=NhZ5twunr1WB2ojEX5wFZhxdl47PVyTnkY2uJewJb3WeA2fjybz/GJ51ALVzYCmPyP
         ngLZ2AkIUSd+nkU7deosDgZEp3Ne1eELje1FJoD1gnqXXtXEI6SLxKiBqFlltjXdIm8Y
         CLzJvKgK0nCpwrPoX71bQj4OY6ZE/hUP+AUa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083525; x=1724688325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0av1AdwzyMt+HVE6FQ9tUPI5Mm9RtXw6l9qSQ7ZGdPE=;
        b=hVPv1ag+T7g2VnPdATNBHU2ZOQOzMlUmMWtRXsybt85jqOL4EYLPt5iOz3lNMPJ1bf
         mWpyrStV5crSsDzbFDVtNB3I4AD5viQd7FRnFxAwpd2wnmTeoJOotni53GSA6z78FmRW
         RZkMHgYSZX0CS6+Nl3M9hWb91QcMJwBb6QdO6P1Lb2CspaqCYe86oVRMHy4lDBSgLwzM
         2kOz0ddGuB5ABPgmnifBpe9QBnR5sEmyDJEdTtT66HOW2eR6Ls6g7FFSOdjxD4B8VjU1
         DK7YHxS0SQPPxcwXNcT59HKkywbsShP0k3Oe5DKloTiMMQfoPfJEqRbVBSbLrLaZm/8f
         1AhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1NmO8G9f+Nl+5QjVFzv7KzOLnEvTsR5m14vAQ14mGZYoDz+yR4cEOrVDWg3N84eUTQzOVy3ND0JysxSZLe2WEAMJW+wvyJFeFuJ4dr4=
X-Gm-Message-State: AOJu0YzB1iGTSeHY+NjOZQS/b1SSAOHX6YzqUevVcR/b117BGsoC42VT
	P2P8qu9Q+VVj+HFerTpejjCxEcYpWXXHl7LbMR7tdZa1PIwkpTA9FRQDAip/cXBqonCVvWaK3nN
	EU+NuKA==
X-Google-Smtp-Source: AGHT+IGVKqUvCqTLr9J0SahQ0keB4QAsm5+Zez0BRWsjtm/7/I6KX57adyshTy71hVpBo7kKi/MvXA==
X-Received: by 2002:a05:6512:694:b0:52d:6673:11da with SMTP id 2adb3069b0e04-5331c6e9463mr7385321e87.57.1724083524816;
        Mon, 19 Aug 2024 09:05:24 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6639sm648283766b.7.2024.08.19.09.05.23
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:05:23 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso2539552a12.2
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:05:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV882917AURjx2vForJY2mpkpDozTRH9RQjxrOMoXBGuoyFpt/p4lRjF2fhKxuH61mpS+pwXtOni4wSD9rSnEQaDTlZiJwNORhPQMu0T74=
X-Received: by 2002:a05:6402:84f:b0:5bb:9b22:68f4 with SMTP id
 4fb4d7f45d1cf-5beca59a339mr7451139a12.18.1724083523048; Mon, 19 Aug 2024
 09:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
In-Reply-To: <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 09:05:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
Message-ID: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 06:02, David Hildenbrand <david@redhat.com> wrote:
> >
> > If we must still fail a nofail allocation, we should trigger a BUG rather
> > than exposing NULL dereferences to callers who do not check the return
> > value.
>
> I am not convinced that BUG_ON is the right tool here to save the world,
> but I see how we arrived here.

I think the thing to do is to just add a

     WARN_ON_ONCE((flags & __GFP_NOFAIL) && bad_nofail_alloc(oder, flags));

or similar, where that bad_nofail_alloc() checks that the allocation
order is small and that the flags are sane for a NOFAIL allocation.

Because no, BUG_ON() is *never* the answer. The answer is to make sure
nobody ever sets NOFAIL in situations where the allocation can fail
and there is no way forward.

A BUG_ON() will quite likely just make things worse. You're better off
with a WARN_ON() and letting the caller just oops.

Honestly, I'm perfectly fine with just removing that stupid useless
flag entirely. The flag goes back to 2003 and was introduced in
2.5.69, and was meant to be for very particular uses that otherwise
just looped waiting for memory.

Back in 2.5.69, there was exactly one user: the jbd journal code, that
did a buffer head allocation with GFP_NOFAIL.  By 2.6.0 that had
expanded by another user in XFS, and even that one had a comment
saying that it needed to be narrowed down. And in fact, by the 2.6.12
release, that XFS use had been removed, but the jbd journal had grown
another jbd_kmalloc case for transaction data. So at the beginning of
the git archives, we had exactly *one* user (with two places).

*THAT* is the kind of use that the flag was meant for: small
allocations required to make forward progress in writeout during
memory pressure.

It has then expanded and is now a problem. The cases using GFP_NOFAIL
for things like vmalloc() - which is by definition not a small
allocation - should be just removed as outright bugs.

Note that we had this comment back in 2010:

 * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
 * cannot handle allocation failures.  This modifier is deprecated and no new
 * users should be added.

and then it was softened in 2015 to the current

 * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
 * cannot handle allocation failures. New users should be evaluated carefully
  ...

and clearly that "evaluated carefully" actually never happened, so the
new comment is just garbage.

I wonder how many modern users of GFP_NOFAIL are simply due to
over-eager allocation failure injection testing, and then people added
GFP_NOFAIL just because it shut up the mindless random allocation
failures.

I mean, we have a __GFP_NOFAIL in rhashtable_init() - which can
actually return an error just fine, but there was this crazy worry
about the IPC layer initialization failing:

   https://lore.kernel.org/all/20180523172500.anfvmjtumww65ief@linux-n805/

Things like that, where people just added mindless "theoretical
concerns" issues, or possibly had some error injection module that
inserted impossible failures.

I do NOT want those things to become BUG_ON()'s. It's better to just
return NULL with a "bogus GFP_NOFAIL" warning, and have the oops
happen in the actual bad place that did an invalid allocation.

Because the blame should go *there*, and it should not even remotely
look like "oh, the MM code failed". No. The caller was garbage.

So no. No MM BUG_ON code.

                    Linus
