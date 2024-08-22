Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02AE15383E
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309790; cv=none; b=Yfosh0CPu2KXVk0prVB4OxbZGWOVpMK5BaH6oCNack3axM/O3lZI4Nujn40a2QOYeVSOVhzQ89U7RNwL8UE0fgTwHPzK5SEh3goJormB0jGZO5Oxq56A5sUnz56nkn5lX8TzEBvfDmbvcT5u4hw0Y0/QyrSFyleBExwmOEoE7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309790; c=relaxed/simple;
	bh=B7+RgdlScFrXDxAvsyecbiZn9fqCnhpA5bzvsmQNPyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCe+hXMaGdZieUH1HoheXX1KCg4uiBJCeUs+6mBNbJBH36XDILr7JSVy39opndMrD6SiPo591m4/O8t/iDtMtEKmQbP20KBaK7Bw7vlAFT35vyZsoFsVCf5+ZN4vbM5CM7BRWaVOKK+uaUXlttRJ9T2kGzrQvDJrqT65Nbgw3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SdVmnYvw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SdVmnYvw"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533488ffaddso616483e87.1
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724309786; x=1724914586; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uwdvM7Xu6vrLGjstL8D4CXE+bz614O3QOBk1OGcaUvw=;
        b=SdVmnYvwAG11q/G/hwT0eGxgudNc+X4KYi0wYEwLtw0+ToKwDho5HqNKbhv4k1+iVI
         kAdN7xekKiplpe411ttKve+c81vuN1nZqTo92y6hYipvDyBVmvKXANvWhjFd7zROLkm+
         IvrQQQWE3qie2J4NEMbKjS1/I9/rZdFmEkjOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309786; x=1724914586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwdvM7Xu6vrLGjstL8D4CXE+bz614O3QOBk1OGcaUvw=;
        b=Fj/nrY7naY4iETQ639HtOpx8udRgteNclyEaHiiz3PYEDuLYcBzFAl9byuREI/YVFq
         0ku0CCrLffFhyl/lKjd9LB60L4h2N4NG+F5+3RA32K5cbz8W9VomCRw4S+v7I8QErKJc
         EYwcPx4iGEU81T8MeyqLklQvrqPB2O8p72kC+AmSJSuyQNT1QxLMl7Ole1ldIiTKV+QT
         boKU8y5AwkjhND0EvzEqEy0MkzjuWPQgyj3r5VdQ9vSKO3ZuksBmBkp/bDqNPLlpCmWH
         uu3JQc/ZAVPHo5JFeRBLbbEX7k3WU4stPspyeY+7wGryW5ubtVlc0zxCS7Ke5POb4on1
         hzew==
X-Forwarded-Encrypted: i=1; AJvYcCXQPhwmGTzqNLR3CGIdL8UesBzUoEgLWLqYEMUsumwmMQvPUMbAFbeJRzYhy1S+vUicflICnCgtgimtzVdbgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzEMmnsABPmtLoT7gdm1xqWceftm0KgNckf6iVxVbPoYlRfROE
	BgKDAR4euPU8oJFA7nf+LFt/e0OS+iIvC2e+h91t1RP8Es8j899ZcUeFOVrb+MyLM9jMdZFb8Je
	+IaEEaQ==
X-Google-Smtp-Source: AGHT+IHHI6qsYKqzxUUYxIl8XkrBSu4f5Bx5+XAqeyB9ykot18TRKm0BCrQJ0lp9YUanQUqO5+5r8w==
X-Received: by 2002:ac2:4c45:0:b0:52e:768e:4d1f with SMTP id 2adb3069b0e04-53348565395mr2786719e87.36.1724309785580;
        Wed, 21 Aug 2024 23:56:25 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d344sm132496e87.194.2024.08.21.23.56.25
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 23:56:25 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3e2f07f41so4086651fa.3
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 23:56:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaLIhPBHDr4O9K0EIWAMjIMvHLLVqb9sWZcdk9WIspg3gEMutO2qOf+DL0xh9Sp5PArLXOm+4ZmdCUenMWzA==@lists.linux.dev
X-Received: by 2002:a05:651c:1502:b0:2ef:22ef:a24e with SMTP id
 38308e7fff4ca-2f3f881e268mr32445201fa.10.1724309784839; Wed, 21 Aug 2024
 23:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
In-Reply-To: <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 14:56:08 +0800
X-Gmail-Original-Message-ID: <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
Message-ID: <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 14:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I did find three cases of kvcalloc(NOFAIL) in the nouveau driver and
> one in erofs. It's not clear that any of them make much sense (or that
> the erofs one is actually a large allocation).

Oh, and I missed one in btrfs because it needed five lines of context
due to being the allocation from hell.

That said, yes, the vmalloc case at least has no fragmentation issues,
but I do think even that needs to be size limited for sanity.

The size limit might be larger than a couple of pages, but not
_hugely_ larger. You can't just say "I want a megabyte, and you can't
fail me". That kind of code is garbage, and needs to be called out for
being garbage.

                 Linus
