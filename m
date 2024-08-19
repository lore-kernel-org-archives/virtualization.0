Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC150176231
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104134; cv=none; b=iKGkZVEKfQvFsOVVx2eoo4XK97FlvOIKDQ/BUOgXypVNmVd/6+m/zunq2LRqSa+g7Lk0zGVVhqKXLqcUgBpfNY7mwP+noE7UukQTU/o7hW0hekZnWei7v9/ngYV1RBWkGZS5O2ow8fiwHpcW/lwXnF5GLZSLT5pg//Dmt2R2kJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104134; c=relaxed/simple;
	bh=g/+8ChFNFynnYS6sw1akki6SZBU+rx1gKKNAILzaDl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar3Keg9u3WCvBKq+IWHDJAB+yUeGQqr20aUEXwW003/tDVTaT5LjfqIeaqPTl3LkAfXxsbhGodH4bVyXbh+YxMRGGsEuD8CHOPmPRyX854dYvYDNPDoY3IxlgFSLsciagAtnHjQASdowX1y4dg089mUPEqpQm8KbJcRhVF63+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMSJaTQ7; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMSJaTQ7"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4929754aee9so1202484137.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724104132; x=1724708932; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/XWOzBh0omPAtqplmJtCs5xfxeJs6oMvcpGm2ydwOo=;
        b=PMSJaTQ7yYit7IuC13v9UdNqbVDbfhqdEox3s1m2J4GUlC/g2HeCF/ERq4AGoKwuLC
         5wY7tiih+pFMES1vwAm6t93rTi9maa/eJdPToMCO0khSNjyVeQEUg/t7A29IXDA9FEXi
         JEre41EGiwyOXVrgjEz5PldJDYPa9UUjf41ObDfwnDJtwnJ1s4fvtqzzcCLSoXhmr3Bq
         Cpu6OxAwqz8vFsKQwvQjAeh+7LaYqHuA81rQQ799jyQlBu31Mt8LWSf0vxfW6/UInOOB
         CT4CGcnEFQoxIlONO8IYX1ayPcYUy399Qo0r+jjp4ySIBudji2AZyNOL+PH3SbYsla96
         jqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104132; x=1724708932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/XWOzBh0omPAtqplmJtCs5xfxeJs6oMvcpGm2ydwOo=;
        b=IAnU9Mj973cXashHTw4xlXj9KHJ7wu+xENGpw/ilEhYxOLSKRfoghgWjyRHFaOlk/A
         WVg5jwKiherpeQaKjpHXb2D4WsFrbaGecsbft/TWFnH/K8i+XqlJWsWtmht1vVnQgWQd
         wssHcofs1UWan9WX0vqNjcgEGIDnpyhc5WeuhZKQ29cCEM6gn75OkWPK7S/Vsu91Pg5U
         KO+/+VhRtfFRI1rNFsOcwDcgqwGzrvJ0T/BEQgyW6LKYl0uP59qBaoRLsDggtrD/Q5UK
         AqnwJSKcKhbBbxq7yzrLcXkdQExbG+bTLCsbQxbCHj2uSTXK1Jp8fHEjYEHe8dxqKySt
         znow==
X-Forwarded-Encrypted: i=1; AJvYcCVLk69gyidGgZusi7+4fPDa/Ma4mdwhL0nHsHajBek184TSFJeLfLsX4EHJMaVGA/RFkT9fSZKAfWBfoVvTvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpr0HL1AsitsVYAcE5BlaSQQFnYk3HsoHPrz9+5vMZvT/dN6Ws
	c7FLxu/XCSGKMGT4vV6f3/+Yk8wbvW2Ufoq7pYGQ6vOWVkTQkn9c1mZnD1DEjWozjSUbkJmneQp
	qivsE46SMVVvTB4Sap0N19oqaD8o=
X-Google-Smtp-Source: AGHT+IENb5DYPovjDFMjwqzq3uvD4Nv2Ze4DbhBh4gLv4aruNViDXNpg95ZVdQIT4X89mk0e7YdoQ5zVz6TsbTbh4PE=
X-Received: by 2002:a05:6102:e13:b0:48f:df71:17e3 with SMTP id
 ada2fe7eead31-497799fe285mr11313058137.28.1724104131684; Mon, 19 Aug 2024
 14:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CAGsJ_4xwj+trzpOS4b-RSHtqHkD4+0g1Sadr7YCiauOBgd35dQ@mail.gmail.com> <CAHk-=who4GDu0gXZ2xWdpmTOQ_OZaWfgVmcADUGo05Eoa-jKxA@mail.gmail.com>
In-Reply-To: <CAHk-=who4GDu0gXZ2xWdpmTOQ_OZaWfgVmcADUGo05Eoa-jKxA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 09:48:36 +1200
Message-ID: <CAGsJ_4wDEY0mEGAL6Q7xV7uCv2tsyeK6fGsXUkSrF29tLbOTwA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 7:33=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 19 Aug 2024 at 12:23, Barry Song <21cnbao@gmail.com> wrote:
> >
> >
> > That could be an exploit taking advantage of those improper callers,
>
> So?
>
> FIX THE BUGGY CODE.

That's definitely in progress, with patch 1/4 addressing vdpa. There's also
an RFC to enforce DIRECT_RECLAMATION for __GFP_NOFAIL, which
will prevent passing unsupported flags to the memory management
system:

https://lore.kernel.org/all/20240724085544.299090-6-21cnbao@gmail.com/

>
> Don't make insane and incorrect changes to the MM code and spread
> Fear, Uncertainty and Doubt.
>
> > thus it wouldn=E2=80=99t necessarily result in an immediate oops in cal=
lers but
> > result in an exploit
>
> No. Any bug can be an exploit. Don't try to make this something
> special by calling it an exploit.
>
> NULL pointer dereferences are some of the *least* worrisome bugs,
> because we don't allow people to mmap the NULL area anyway.
>
> So just stop spreading FUD. We don't improve the kernel by making
> excuses for bugs, we improve it by fixing things.
>
> And any caller that asks for NOFAIL with bad parameters is buggy. The
> MM code should NOT try to fix it up, and dammit, BUG_ON() is not
> acceptable as a debugging help. Never was, never will be.

Okay, I see your point. However, the discussion originally began with just
a simple WARN_ON() to flag improper usage:
https://lore.kernel.org/linux-mm/20240717230025.77361-1-21cnbao@gmail.com/

Now, it seems we've come full circle and are opting to use
WARN_ON_ONCE() instead?

>
> Worry-warts already do "reboot-on-warn".
>
>             Linus

Thanks
Barry
