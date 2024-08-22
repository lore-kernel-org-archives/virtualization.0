Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244716DEB4
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313285; cv=none; b=SCJ9Sm1C4LMXjg0H+maRrxKBNxTuGrHJNDYNaXHrWxDukQmonAtjFDXeYys5+9DdXjvmn0bxqJ2wl2TrfMrPeuz/t3Wc/akzsn3K8XBOGYQs0LbvikGCZr7uFv2NcfGPxne2vIrXkrdaa6bU7+w7FppiBCkwZPEJoNEttitUv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313285; c=relaxed/simple;
	bh=Xd3iPO6p7lAd6e9pJyZN6uOw3X/efINGTQQZq9Rfsx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1PYqdYz1flHpyEPr5w05BSC8AjrOoCg1xGDu8nnHnthKPZpelSBHvV3P+XoSpdv5pdwRNdNXPCYJ5wtuxPo/KIhuq+xlzy7ql8jYdimqitVeaD7LpHkxRhT+jXKJys8ypEeUITfXLatwKGNrrQd+hJAYjZZETNzXSyJuNW1/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fv/7xrFM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fv/7xrFM"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso674859a12.3
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724313281; x=1724918081; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/dMpJsKzCty7PyozAjDXVmfBlGRovYP8Y1Bj5uwLJ0=;
        b=fv/7xrFM/BFJgaWBbhGs/QAj4j5qwXa22FqIwxl3/T2NK5Xspke52HQFFpqqBxqk6c
         UQYkpf7wTdI+rGOp495umGBuFjDdr0hn1BVLFEVc4tchW5b0cdUIDCYiogqAiZyXdN23
         e7xssNTljfLqKVG9E1BqxVjYajD44T7AA4YaRAlO0ZQBmnR9uduZ74HbPRc31XAVYKJt
         MU07kzEcGV2LJkVlizsJ38cfnna3cNFVFFPFd+bS5HRFuais0D2Vf2ytJn30I0ryTnUd
         DXpbBmED2Tur8PAK1pZV4K9Ljmv8iD3KXe27okdOLk78ZRlQcFcaFN3ciQVjTA0LQ1ai
         S+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724313281; x=1724918081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/dMpJsKzCty7PyozAjDXVmfBlGRovYP8Y1Bj5uwLJ0=;
        b=sXJVEG+TFF0ksGbyxO4tLORYOWpb5LJB3VsMW4SFpp7wbRJ4FYz1fGofr/wWKeuoxb
         0VxtEKsbYIAtJIvRnlmY4BK6TUgG7cVZvZ6sbUfJkJRF3lnQPZ0el6Qmpo18unWBz+k+
         Ecapx/aWiTUsNjquZqb8FM75/RuRg7KAJlZHfmLbW6GBsZ+e/SGjy+DPxT9yXa/N0Uts
         NX7nraGHuquxEJihy7ohPBkkaDObzGopSf932z41Xu4hxi7S3B5llOWkT35K8yleVbfT
         Dydx+SUnE9Cu55hPppJmCJb82y5LAKqYfsvQ+/i8emh+uEnwWYM77Z9oeAyg0MkjgXYH
         ck1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR1oTAjS/1zlBC+GWLJsciKI6sMkXs2IYteOeyj5DKIT02LThgiLMrdkd2BSs+WMRMC2eAVTAg1gAD9CqyWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxZopylhFjoGLTDsPKbIeLx6Rfhck99UseB1LhQYCww+NV9jPA
	5m9YPmfRKlF9ydiQTD8Xllgfl8KFhXLJYgWJ7dfzCr8Cw9HfeVbyCWIaGY0OzSo=
X-Google-Smtp-Source: AGHT+IGq4R4GrxX7o9hFe7kKdnmxkeZ7NThxzG6CVbaJLbEsy1IDahxB33tMpj6vYTZfwwfSA1NLAQ==
X-Received: by 2002:a05:6402:458e:b0:5be:db8a:7f5e with SMTP id 4fb4d7f45d1cf-5bf1f282963mr2279193a12.37.1724313281414;
        Thu, 22 Aug 2024 00:54:41 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a9469sm555414a12.92.2024.08.22.00.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:54:41 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:54:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZsbuwJPtRwr5Hi6E@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <9fa8eca0-ad4e-445c-a21e-aaabb6aa4160@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa8eca0-ad4e-445c-a21e-aaabb6aa4160@linux.alibaba.com>

On Thu 22-08-24 15:01:43, Gao Xiang wrote:
> In my opinion, I'm not sure how PAGE_ALLOC_COSTLY_ORDER restriction
> means for a single shot.  Because assume even if you don't consider
> a virtual consecutive buffer, people could also do
> < PAGE_ALLOC_COSTLY_ORDER allocations multiple times to get almost
> the same heavy workload to the whole system.  And we also allow
> direct/kswap reclaim here.

Quite honestly I do not think that PAGE_ALLOC_COSTLY_ORDER constrain
make sense outside of the page allocator proper. There is no reason why
vmalloc NOFAIL should be constrained by that. Sure it should be
contrained to some value but considering it is just a bunch of PAGE_SIZE
allocation then the limit could be higher. I am not sure where the
practical limit should be but anything that requires more than couple of
MBs seems really excessive.

And for PAGE_ALLOC_COSTLY_ORDER and NOFAIL at the page allocator level I
would argue that we do not want to provide such a strong guarantee to
anything order > 0. Just use kvmalloc for that purpose. Sure we
practically never fail up to costly order but guaranteeing that is a
different story.

-- 
Michal Hocko
SUSE Labs
