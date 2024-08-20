Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD131494C3
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135071; cv=none; b=dGwrxkjzsV5I7RYL7U4uA+gwoSm6T3Rq8E4Ct6+ytmDWEKHvbNe1f0CCzA/XAiSgNjVrnqHCpl5awvtLnAsVgFmHr1kOsg9b+XkOOdXGw1r0aPuyQenjhr5X3kBkoLq6kxZYXNdUqdGaMfBq5jbLpfHTAqIUayJhQjqdbs9qBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135071; c=relaxed/simple;
	bh=bl3N9ZvuIhGvb6G1fIAPnxLQXGgR+QvFiKCOBxeSZok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDA2XA6Ls+nENFUO+4Z/k4MScOmdf5OX/79NW79SjRpiKlQrsCvoxd7mN8Cbhix0MDBfZkHy6cOTb3BRBfpzs6Yjp46Wjwvt+OUi4p6zWNchZL8CoukbCYCuynLLdd4e1e55aSuTJ5JbXxJ34y058dvBujoCKn9r2ZWt3vArqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bX57iYqE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bX57iYqE"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3ce5bc7d2so28638601fa.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724135067; x=1724739867; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YvsResvw8jITINilmCv0YRZaCLzBf4CZQYeQV5CJiNs=;
        b=bX57iYqE3T8gE1s5QobOVtqce0gVMIuf0xDMFnMfooOmwDb/ij2tjRPmdKBzoHDY/O
         Wbhm9ZeRSy2RIIyZiRI+VUesdd4BSxFgEY3xbdq9SSOZYW/PZVtsbtYN5+LgGrsYHdl8
         l1nOY1jPraBsIaUQxSRqYkInwSAnByGTKKS0hmPeQ4Iv7JCWC0FgpbDlC2QzFLhGPIUI
         xBcMtvYQqjWCgNQIORr5zNKK+3kM38UZB9du/Gh03MSqYmicxj4DICooXmv9R+x4qARs
         oyG2H18qTOaCZynljb0XgRiogkk50HUQ4DAJWRKHUKstc7BexaxYr9pIe3E+I4Tpnst7
         Crvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724135067; x=1724739867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvsResvw8jITINilmCv0YRZaCLzBf4CZQYeQV5CJiNs=;
        b=YOlfgyNwpuYA1M5Htwsr9C1R91QK9TmWHFqEsy6H4XjA4MfaxBuEucR51Yu5FhHKxW
         AVmEJUDlGK/KJ8PL5zV5BWrKXTZLGcXjOZlIJs1B600C5Fzna8U6u+FCgAr6cj3UactF
         RAYHbjUy9leqejUFol6mHn0OLWT9+uQcL9SBvzv73mCtrUJ8+Cj8BgdQPByS/Ve2PXmx
         vZJbYnMJ1UWpPKFwso7v19BeuUCA04mGgvH+ZYyI8vQYEXeJqTX4QPIdZXROlKOkQiNY
         6eIfrpUFWP2KRVSg3mHwLq7wEy12DJgcmClUAMqwZjCKieIcrPAcKB4SPUONn0UuIgUN
         UnRw==
X-Forwarded-Encrypted: i=1; AJvYcCUL4mdxDvmLOP33T3+25hSMNBc5mET6Hi9sYj0nnXZwA2SHsOC0F1XGXvl6Vg+MUAgeXx+/0pOBQ/nLG7ONvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJKm2zgnp4xiQxgX71OMD6MkP2VIfks4FUvdEsGVgiFlc++OCW
	YlKbthvxC9jfPxN2AIlHWmxgsVJ1YVXWzHfw5hwWfULidcRgi5f+UQsoIj9maBs=
X-Google-Smtp-Source: AGHT+IE5WRYvgKxvdloRqiDIvhJwnUc0A+h4bUZ7BZNwewSpx2IFyR3kTXPB84oSYYF4pOAMVG18rw==
X-Received: by 2002:a05:6512:31d3:b0:52c:e09c:b747 with SMTP id 2adb3069b0e04-5331c6ae184mr8144605e87.27.1724135067438;
        Mon, 19 Aug 2024 23:24:27 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d375sm719241366b.221.2024.08.19.23.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:24:27 -0700 (PDT)
Date: Tue, 20 Aug 2024 08:24:26 +0200
From: Michal Hocko <mhocko@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZsQ2mtmgCQprmBXW@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CAGsJ_4xwj+trzpOS4b-RSHtqHkD4+0g1Sadr7YCiauOBgd35dQ@mail.gmail.com>
 <CAHk-=who4GDu0gXZ2xWdpmTOQ_OZaWfgVmcADUGo05Eoa-jKxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=who4GDu0gXZ2xWdpmTOQ_OZaWfgVmcADUGo05Eoa-jKxA@mail.gmail.com>

On Mon 19-08-24 12:33:17, Linus Torvalds wrote:
> On Mon, 19 Aug 2024 at 12:23, Barry Song <21cnbao@gmail.com> wrote:
> >
> >
> > That could be an exploit taking advantage of those improper callers,
> 
> So?
> 
> FIX THE BUGGY CODE.
> 
> Don't make insane and incorrect changes to the MM code and spread
> Fear, Uncertainty and Doubt.
> 
> > thus it wouldn’t necessarily result in an immediate oops in callers but
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

I really do not think that accusing Barry from spreading FUD is fair!
I believe there is a good intention behind this initiative and he has
used tools that he has available.

So rather than throwing FUD arguments I would really like to stick to a
technical discussion, please.
-- 
Michal Hocko
SUSE Labs
