Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F32D611
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307692; cv=none; b=MEt/M2IVTBRRCBhTm0ACQqgGgUwzwQc3qUmY9nbjTpqxOJXMW2vTmAyQDBjEWNvKio/sFoY1cSrowgKc0jRaupJVnNf3Q4/sDRHkUdxA45Weg4wJUls/cN5qq5LK2SgBIujUJJC+5Dy3yw2iUhouRW7eTwtqIQiThmXiDzN6DNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307692; c=relaxed/simple;
	bh=V7SDWGS/ajcZ3cC+jR1aTa3d99AiLqFbsSaO0gb1lVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAybEgjcZr3/9M3RBSpu+dyAsWbXchycC/GIZeQ8zlVE9HBJE9oyTCF0TiGfr2hnnGUnI7pPoTb/y4liHubySDcUu3RuMt7zvXvKJjNqhN+mBIThKkrxOH5MiU0KMiFM7+xzPrMc7n8rh5FhUpR756HEqEJ1TBK58nJzWjsx7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DUKiKO5h; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DUKiKO5h"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so66253066b.1
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724307688; x=1724912488; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxk3nxKzZ05WqB9+cb54Umn8G5aB2VlCqrAvw7IQH5I=;
        b=DUKiKO5hoyYoVvhPk+7DV3LWXKCvJijVB1oPX5V2HcWZBqJmoem9FMm7XnBM5Ah4I2
         hAVgqKoKtpKxe6Ta4Ag605HXSoRmvbHaJeJxmipEkm2UN5WMghtdNHDyojspxap3/XyB
         ODK6svPvbQwTDW1rBuTsMGH17IffJmrBZLVv4cKxua3TL3ni+ZNyG/OmPOCfv4z/WqYa
         aqgx3NZp9bds2sEcgWbzAsQSIyActynemT6Jhg2/LgCopq0LVVD9q5zX64v9CeYRKNYf
         TA18hzTnGx9znwhAaEY+2ofNl+FU+oTdH4/o+2smkOFWHhzVoXT06JdjIqSSaOYsRy7X
         0Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307688; x=1724912488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxk3nxKzZ05WqB9+cb54Umn8G5aB2VlCqrAvw7IQH5I=;
        b=lYSH8lbMhQqZaTn6X1hzULhIWZAlhGb4BGyD/KE2tPhncHhFvfL/NGCn9c3PpzIcFg
         yOwDROvtK4FF47WMTmvQSYRlbc65zBOQfwVJmEYXOH7VWaDYAnXYdUWGflUzPAhEaQmU
         +Wcf5dg2draEHVGyAq/s+0F3HC5Tscy4rsbWGFMxE61r0XrADoObha9qUchedoKIRYSH
         l2CHhfNebmpXc49k9D6bFyQyKWCHyJs8PubvvSZmQrAp3OYHS6SEskM6YKauNqE9iQi6
         0A1CzcwjGJcSqS9mhqcqh5fEOy9SXU6rbYHBiwvnFFcoin7pvS+DHAiZk0qeCo28/JMm
         7MuA==
X-Forwarded-Encrypted: i=1; AJvYcCVtclaRngS5Ls2GnxlqUbJY/Piz3tU7/QQliJfIMqIqif9YYUBDWr8wwOwiutQK0AfEVQ0NBd2vCnu/qezr+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsq2fUzIunEibEY/1Z0uKzmNDi5gCjdcUegRNJ397W2KUOCbTT
	PE+Vo+ZHB+UIhrmNoiT0J4Pjr9X/ijlASP9R2xuc46BtoetHUxMJJUSbueAOWEg=
X-Google-Smtp-Source: AGHT+IHNGpIg3niNfMHtqWwcmdCGMpL6kLeS68NmizIAcNcxmExZy7at4c/BA7/v1Yq3Rb0C1ozgOw==
X-Received: by 2002:a17:907:3da6:b0:a86:789b:71fe with SMTP id a640c23a62f3a-a86789b793emr395960566b.48.1724307688230;
        Wed, 21 Aug 2024 23:21:28 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4378f3sm67199966b.132.2024.08.21.23.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:21:27 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:21:26 +0200
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
Message-ID: <ZsbY5pNhDqGoxJG_@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>

On Thu 22-08-24 06:59:08, Linus Torvalds wrote:
> On Wed, 21 Aug 2024 at 20:41, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > One potential approach could be to rename GFP_NOFAIL to
> > GFP_NOFAIL_FOR_SMALL_ALLOC, specifically for smaller allocations, and
> > to clear this flag for larger allocations.
> 
> Yes, that sounds like a good way to make sure people don't blame the
> MM layer when they themselves were the cause of problems.

The reality disagrees because there is a real demand for real GFP_NOFAIL
semantic. By that I do not mean arbitrary requests and sure GFP_NOFAIL
for higher orders is really hard to achieve but kvmalloc GFP_NOFAIL for
anything larger than PAGE_SIZE is doable without a considerable burden
on the MM end.
-- 
Michal Hocko
SUSE Labs
