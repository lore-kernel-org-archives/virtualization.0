Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51392168497
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281170; cv=none; b=gq0vxEmW2JnZJeew7y+cmVlAoaFkCQZZ2tYtAmlpYkGuaGm71BCK6/IM7AsR5vOJ6bKMiWuAZSEl5iiuzATQHUmbfOvoo1A20D27498BGuju0LWZRcSCEEgMZZ+KxFN9Br4Tg8UQN963SQsmNc8xas/Jc9lftvqVMAUba7CVIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281170; c=relaxed/simple;
	bh=Fgk/KlMey93JjCBgGwArcLkgLwuv5KV18PBvlmuzQVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsfZ+RWTkfSQpspqY8zTrX981M0aWBn09efe6vazZGng3Kk5hh44Xp8aePlY8sbUwGi/rs/kpZpvhB8ySXJAVpzdkfI+n7DdAnqHZHMaZANYtnQQMPPcfu7PwLmEbZ89e0HcU6rqA1VsxyPxBFheuBNwoMJkkZ4AbJD6TduX2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e2s1qWct; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e2s1qWct"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a843bef98so24730966b.2
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724281166; x=1724885966; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3PYIeZz9FRIu2hm9JITrCL11YFLg6HZ0+1XGSiPFXqQ=;
        b=e2s1qWctg5NFs4L+aoLWmkRrIHQSrLY26VHYNIc4D/8qCDvI7GAC9OW3B4hlaVMcWd
         ONyEn5IJ27OYkbD5ZL7OoLY7uHHWYzpLNn9II2yWSW3fR2b2ccZ2jIHLIsj0E/Ak7Fze
         TwyWJ69OB7jZSf61BeaRTf+iSv32vBIxhDTag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281166; x=1724885966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PYIeZz9FRIu2hm9JITrCL11YFLg6HZ0+1XGSiPFXqQ=;
        b=IyPzppRUNSVYpdodarHZ5kPoRH1zy/JuewQv41gDN4lVl7LYy7UdJSR27t8NSR6DNk
         9Y/VJZ/dKdqcxglVb8lBiozmdSLVqWgmuWueQDYGZUMmg3SQWHtDws7+Ae0dgd/2BsRH
         /jgMl97sTNBmf8m32usmJ/i83xANN7d2kuemOK2jgSYGuQj92W+0XGoXlB85TZnGAuaq
         dij4ASAZhqDi7Qy83zia1x2RcDFz4rC+LugL9owsjtLsVVHZOL8Rr/EgbffRuXqyxLDf
         TTujfez8P77HKJ1UeKGLp89VcFi59SmWbk+1SauQGffh286oVX32mSt2HL/af60Ixc91
         /Q8g==
X-Forwarded-Encrypted: i=1; AJvYcCV3qUkxgtEnWpJfkSiQMG/WDdDQJSKLW+L9HNeWrQJClu/HzewD09LiFM4VduMB8BVDTME6ExS4pdmnZY0EIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuXrD5DzUbulQC5DXSLouFHRgR4oVv/DN2HIc6i1wtHOinZB54
	HYGxbSyRwbyLkIHY+kLV1N4eiYSWtAaS+BKoRPrDzQwfXLE+OWld7IdPDHLcT/HT0L769wRsrs1
	5aEEc5Q==
X-Google-Smtp-Source: AGHT+IEGWqjGFHZYQMHGRfndcdRSPK3eMV33nbEE4AOhOjGbkLkI+amIc3ErUbAauyiaN4OGTEgCzA==
X-Received: by 2002:a17:906:f598:b0:a86:842a:104a with SMTP id a640c23a62f3a-a8691cb8f87mr4226666b.57.1724281166169;
        Wed, 21 Aug 2024 15:59:26 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436bb8sm22952066b.131.2024.08.21.15.59.24
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 15:59:24 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so319305a12.2
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 15:59:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfwvnVPtt1sMY2K16o1fnukPfkyHmi4VgUJrkbdtigeNIE7CV+hXtep0vsY4R4N7trox+/OoWhGW3WMzbwHQ==@lists.linux.dev
X-Received: by 2002:a05:6402:1ec9:b0:5bf:2569:f8eb with SMTP id
 4fb4d7f45d1cf-5bf2569fb8fmr1340682a12.36.1724281164316; Wed, 21 Aug 2024
 15:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com> <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
In-Reply-To: <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 06:59:08 +0800
X-Gmail-Original-Message-ID: <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
Message-ID: <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, mhocko@suse.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, 
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 20:41, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> One potential approach could be to rename GFP_NOFAIL to
> GFP_NOFAIL_FOR_SMALL_ALLOC, specifically for smaller allocations, and
> to clear this flag for larger allocations.

Yes, that sounds like a good way to make sure people don't blame the
MM layer when they themselves were the cause of problems.

> However, the challenge lies
> in determining what constitutes a 'small' allocation.

I think we could easily just stick to the historical "order <
PAGE_ALLOC_COSTLY_ORDER":

 * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
 * costly to service.

(And the value for that is 3 - orders 0-2 are considered "cheap")

             Linus
