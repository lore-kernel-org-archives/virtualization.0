Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C013A244
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327934; cv=none; b=Sj5HQ1QkrXSr3A5YLMwLZAq/ItZzrSvo+GVt1gPmceQj+i0wvgrShzOtkOm4xSVDP1fQ9lm+7J6xWPmoq8NFZBcqCmjcOcBYAHmSWGvO/c87eIHXdO8n520M69UHhp+Ynwgo5RWyYkd1xwz7YUMYBTixBnL0CkC8neVqo2UF5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327934; c=relaxed/simple;
	bh=cG/YuHSRdBFf1BEbu4QC6gJh2N0P9enVeUrG+iF4DO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEtyT+aZzwOzAXzu6HSysOVem08V4lm3RNRTUxxTQWUw7mFk1QS/6xGLiu1s/wo6LT1qYjcjWMZR2ndd6aDNLWl9N5SppWxQ2RLMGZwdhoqE3X/4mhG7QlQ3RLEmt4pyevlpWNhWHWYT0og9TfpsknIdNck5/5TSHC6wMpFiKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=WxiPP4sI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="WxiPP4sI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so1092700a12.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1724327929; x=1724932729; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k6+44GVv5VoR6gJL6+MDhdHhaquWcMnYUrv1YK4tTF8=;
        b=WxiPP4sIY6vfmI22w9AEaLHMralyWI2u1yEoW7J3yy9wEuztmJgreovxXDXG5afW4n
         N1Qs/ofzyva3EWX71si0djqu3LC+dz6oVU5jlqg7lD+JG7MEjiL1lsMZgIj5pXqDDi3N
         YBj5IoJfT/w6AtH2Hrkr3qzBowXG3vhuQTfQLkhxVSll4q1UudMR9dXsZfVVTMhXfFFh
         6Tu1i3Q90wwrEdhiM6Wu92Nb1WBIlljq7XjrEb69ijKJB995OsA7FSni4VQomwCKoVZl
         QRUC0eBWcjhcZCSrAP8zIVlgWqUldvcvPn7/0hGRfdh23650rN7o1SOxE2iwxVJI84jb
         vSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724327929; x=1724932729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6+44GVv5VoR6gJL6+MDhdHhaquWcMnYUrv1YK4tTF8=;
        b=oX+ht0xD0oh34W2rdU3InBiUclZVE326MarCY5A8f7lNfcCJ0uQO3E4dC1r9xwhrzr
         1s+h1Lbprr61YfZJ2vh+oUv4wX+rcQLdOgDt15rufBJmihKFlCTE1l43yf5fa95ZNNPo
         KbTMBtDwUVtFrYmk0lAgiA0QFzqW/yXiUvfM/QStMZ80uZHRzg4xWrzfloB3z95O/V9c
         vKUPXzx6paihBhYNLodLpUbD5c6lF/rHWQyDwbpsVf6qfqzUtvIkGyK4Clizt3AxmEkm
         scg0H2kMFAJ/SDDuKejQ9rhObcHlA9fFS9yVnYrEywZMTUjPl8ll+SVfiwQNe2lCBFsH
         7qig==
X-Forwarded-Encrypted: i=1; AJvYcCWbcV1Nn6yIrKGkC/N34HfMZXU+xqwFqj/xuddGTHNxZG7BRlWH91iA4NWKu2GYcWKB28Il4AHyIVREj8w57Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq3sn3pSQKM5Sf7jRRlz+ioGRut1RNBvKPqN3p0zeVkZJGiAGR
	I1NwJ+gGiM4Yg5kC7Y2W/N6SXfPUNSNqH9V/01ft+6/gvpJAIh2dItk1+2wIHTGdImgKWwhJKe/
	upQ8IZw==
X-Google-Smtp-Source: AGHT+IG13r4mxQnlEshp3lwVpXH9TCnF216rQVlMjsJtxd5sDVF4AHb7gNJExDhrJunr62kk0Mk8dQ==
X-Received: by 2002:a05:6402:d08:b0:5be:d9ac:c776 with SMTP id 4fb4d7f45d1cf-5c0792b163cmr758523a12.38.1724327928682;
        Thu, 22 Aug 2024 04:58:48 -0700 (PDT)
Received: from localhost ([2a02:8071:8280:d6e0:e324:b080:c95e:f348])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c59afsm836434a12.78.2024.08.22.04.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:58:48 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:58:42 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>,
	Barry Song <21cnbao@gmail.com>, Yafang Shao <laoar.shao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <20240822115842.GA352372@cmpxchg.org>
References: <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
 <4df58ef1-b379-484a-aa5d-ef77a1200c63@redhat.com>
 <CAHk-=whx7a6HTjLLDWz4Vi=ARqg+cReWoKAbrdH22a4=u4FKZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whx7a6HTjLLDWz4Vi=ARqg+cReWoKAbrdH22a4=u4FKZQ@mail.gmail.com>

On Thu, Aug 22, 2024 at 05:53:22PM +0800, Linus Torvalds wrote:
> On Thu, 22 Aug 2024 at 17:43, David Hildenbrand <david@redhat.com> wrote:
> >
> > So on the buddy level, that might mean that we limit it to a single
> > page,
> 
> Actually, for many SLUB allocations, you probably do have to accept
> the small orders - the slab caches are often two or four pages.
> 
> For example, a kmalloc(256) is an order-1 allocation on a buddy level
> from a quick look at /proc/slabinfo.

It will try higher orders to reduce fragmentation (and mask out NOFAIL
on those attempts), but it can fall back to the minimum size required
for the object, i.e. get_order(size).

> So it's not necessarily only single pages. We do handle small orders.
> But it gets exponentially harder, so it really is just the small
> orders that work.

Agreed.

> Looks like slub will use up to order-3. That smells like an off-by-one
> to me (I thought we made 0-2 be the "cheap" orders, but maybe I'm just
> wrong), but it probably is still acceptable.

It's 0-3. We #define PAGE_ALLOC_COSTLY_ORDER 3, but it's exclusive -
all the order checks are > costly and <= costly.
