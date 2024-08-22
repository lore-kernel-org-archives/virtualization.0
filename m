Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22514B940
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312861; cv=none; b=a9nJM+RVcrubwc0nqKSPCKg5qSwD78L56rQOoYpUOG6wtkpgZfZ8EIyZjSTfGVYxULZElwDZI7yZ4wWd8stqWbKiWO8aPSZAbzzNVIHIwldUOnk0S2iE2IbUSnh1ILKIk6Rcn7bS8huKJweHWd2xsjogBObwtfCQp0V6gW37usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312861; c=relaxed/simple;
	bh=wJV+w1yGSYPhK+XvaKv+gIDdTgNHTpE9w+z5VwERyb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkhJiOWiO2erV/PmVr1zhI76KpTGGI0Ceum1vSTcD7w0L97hTusJsMszvylUtA0rZEPWIJqmrP3h9TWyBshmNKR6GEcwCDCokH1Iz5Eg4ziAEz3DvbiQEsb+g7yFxGY3TytIkR0q9BreNn5AROaxAFXpSlBRe8tXtKCTaAE7hec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cim65CPh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cim65CPh"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so88218166b.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724312858; x=1724917658; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOUg6sAJPIKaVbX18cSw88ZQjYwiNscZCwt0YM3lYBw=;
        b=cim65CPhycUPt0EjrH03nP0S+xme+2BW6WEivZmrCTgjVm4M6LCB72BduUt7dnIKhS
         VQ8m+6W/yZCr6WpcoNPnYO60w+ZodOWLab6oWHkxqT2HKyQHtbzeCY9kiMTvkyElYnMh
         0mVij1dbEluruZaK9W4OId9EQ6qfcGiyol/9ZPoCWmkrLJ195POtsbXx2VWxzFuDonsF
         +23SB6zG4Z+OYlvWqgOGeTFew94mI+TZlcyK6fxS6BAypL1Wj6Fq7P7S0NPvhIsvASMC
         it5/+eDUntym9tJ9ztpfOsdysobGfskPIJ+J5bD2YElvvhCEwyG2qrzeFqnVrEJWtMMN
         1e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724312858; x=1724917658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOUg6sAJPIKaVbX18cSw88ZQjYwiNscZCwt0YM3lYBw=;
        b=i6fdVRZVTzkbZHux1auJUN30DB7cEe5+fTxMSkf+w87LIjiuHDpEuCjrDDyFOttWOF
         hysexf+Tq7eoI1y6T5+6fG9+p3gEJjegAECTkAamEEGKVG2LVmbz+ALDogt1XvA9GeOM
         bXdoObnxLUzbvFJFmnyDjMoqYQugAvLRSTdRQ6xUc10iSjFMh0jVNBI62Hylv/HSJY9k
         ys1N35FoAPz6WNmhDoESKiBqXgEBDv6UjX//Miw9bpfv1BXBp+eVFzJ5ScUVyE8+6HMO
         f8RoA1I9ID1NKDGdW87q9gl0is7z/Ymya/Rg5O8yR+FAuLvoCP/r1ikUAX92yyITCLAS
         KPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0q9p78iaJBA/VbxdVCYfy6bwOqrgrj9cnGnrfAOd/eXgsr0cI6GFT0gyz1Ha8BmScxZxAJhiQCiWi4vDEwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJBjUPsXadT4tp2Z0VGtSlCsmmgXzJTY4ykqX4SRFBmAA9ehPH
	0RTSS56aTaT+t3SrpHsY8h9mNsC2k4Mo8tInoCouNgup0Tf7sNcQXj20DL/KtN8=
X-Google-Smtp-Source: AGHT+IFAKLPReEiPw9xv+p/rwUpV91S1DMn9/jtovjL8YV2jNNPlezFNNuxQKTXLxTAr1nuRuwrqPw==
X-Received: by 2002:a17:906:c143:b0:a86:91a5:4d09 with SMTP id a640c23a62f3a-a8691a67c8fmr83329066b.26.1724312857735;
        Thu, 22 Aug 2024 00:47:37 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4862b6sm78077966b.170.2024.08.22.00.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:47:37 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:47:36 +0200
From: Michal Hocko <mhocko@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZsbtGClLMtaeakdo@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>

On Thu 22-08-24 14:56:08, Linus Torvalds wrote:
> On Thu, 22 Aug 2024 at 14:40, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I did find three cases of kvcalloc(NOFAIL) in the nouveau driver and
> > one in erofs. It's not clear that any of them make much sense (or that
> > the erofs one is actually a large allocation).
> 
> Oh, and I missed one in btrfs because it needed five lines of context
> due to being the allocation from hell.
> 
> That said, yes, the vmalloc case at least has no fragmentation issues,
> but I do think even that needs to be size limited for sanity.
> 
> The size limit might be larger than a couple of pages, but not
> _hugely_ larger. You can't just say "I want a megabyte, and you can't
> fail me". That kind of code is garbage, and needs to be called out for
> being garbage.

yes, no objection here. Our current limits are too large for any
practical purpose. We still need a strategy how to communicate that
the size is not supported though. Just returning NULL is IMHO bad thing
because it adds potentially silent failure. In other subthread I was
contemplating about OOPS_ON which would simply terminate the user
context and kill it right away. What do you think about something like
that?
-- 
Michal Hocko
SUSE Labs
