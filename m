Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C914387363
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947820; cv=none; b=AXgNmP/wJzb8Sa1AFYfJa7IEmrmgPnvLPytZ3RejIvJAJ1qk8yvzpfda0H2M1uBqAZ1cwYOrdZchCO/pxaSJhNfdELY8LNSji1PmHewuT553xCG8B2A14lZrB25MDwb/gnMoICaF/0F+yMZW9sQkBmLChF9xnmSJcdEBKFgtD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947820; c=relaxed/simple;
	bh=etrKXcFBMen5TXae63L9aHdVuHYxLJofSqP/JQTAbh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/oFqgfrFVcnNm+hSnlDhiF+lJIttzWZgju7axxaSnETrF8pwzD3mzkssW+zi/L9Ek61IzrQOyZNnC9b7rGifIrA2joSm1DEhC19Rdt2xbz/nHiv6vAOZZ0zfxnr3zQL6AVne5L1nQGwK65mrd4Tn0ZHvPzz5DzS7iD1er6WDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j9GSIrZg; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j9GSIrZg"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so59968926d6.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780947818; x=1781552618; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn5+ZpQefRkmWKbevzDNoMTNeOUuJtiAWUOcjYbKJkI=;
        b=j9GSIrZgfZhjuyoQyPjp6azWMKs6OVQQV8RM1/gziM1lfBSL5EVz30fGhyDkeRb/6Q
         kNY3D5mN6va6SGsiyW/3lSbRf8iCLFIi8yIj9LRVQVgMB6uW8pJ6hGA+ZOeKHurjhY1S
         X38I3Tybi4M92LkQYqtVNhM1k7g0HMri5vVEq6L7dvlJ9LxMW/rGFCtd4tJfoMcqxvtz
         TtZkZhE/rx1iDozkoDxBRh+S3+1bdohjH9DB8zYEDYlMjtLO2Hj0kmffiN1+E0HDOXPC
         U+YdEOJBPfrELx3XZdkfYXe9ojd+Lb7UQ7vtR4kem5VATjXxW3PeQOYU6fDszfB5tI13
         obKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947818; x=1781552618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn5+ZpQefRkmWKbevzDNoMTNeOUuJtiAWUOcjYbKJkI=;
        b=bvAdN+LZtorqqOOGj3LbxuKaCRB4XdwuYRYWrhFesHPJ6l9sOmJL/QAhKPa+ch6Ow/
         RBmWjC0UdLiEkAvit0T/9i98ohSc2lpjLEG12chD06O9+UleZweygIhPW0Qt+DZUqiPw
         bvlLPFLTkYd2u2VQVBJWdPEx1qIY+YW4toN8M6HVcB1HY2Fs5da3ZGKGZkYxaqU4enuo
         9NFoi7S3ZFdWAEyENe5FEdK8+M9YTLNA70Z0fCta+Nuqjwa6CKVc/5vJ6VED5MpHm357
         KL4ME3eor/oTfgQ4oiBhy9426tVuvL/i+XNZpSNumOiCMrFWuAsMMonAcCumh95PLRvK
         AGmw==
X-Forwarded-Encrypted: i=1; AFNElJ+XIc6w25YDWpe88V5XcOgLaNGB4XCRunQ88miL7P6/1YFVNrOGddHWZ860S14lpfsGYSKIsqTHHIU7CSACqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp1V63V01OaXq8RbXFfX9sQL+Yzx5Szqr+JTwk8YuAJTnr7egm
	WjsUK9l3CX++j6rLQV8zZmAsWQix/9EcVTRNZ5EMamdRW+VYFO+OpXikShQc9ln3UJo=
X-Gm-Gg: Acq92OGB7vdyQEDIAGkta2D4xVsHBReqgO8+L72J5eJz+BRsDBi5ah4W1sZoHqjCust
	x5R9sG6rq8wXEagdXcbtPxAhXHy/sgBbgT2J9cUNi9yJ6kVHSwy0OqAA/HAhddC3vYZB1jBxzAA
	BHPlNdfQADo0Gm7A6cF1D0u5eXwjiArz40HgtScsIN4NVKFwGxuEHod2uD7sWyDw8ErfiuoMnbz
	WkWckSnogczyvcEPpN5GcD6S7N+iJrOCZrSqZJQw6DBFa+b/aYsq771BM+77PSZjZvnAKYlzkzB
	HA83uyxLvKgnLSnM/2a19FKyaNORxaRTDP7dlxHEJlIulp9rlPaEfuuvTAKwvQNpyW9Dzkh4dLn
	WE1GS/zXl8zD+7uKh2g9DZMyi8/Lz2ESk1op7TjtpbkefI1FH1QXE5+04wjkwuCsSTFF/bwi4Wu
	3r3BMHZBunvmbU+KSFiHk7AcCiNI8DX+60FcqOnEmRLh1o3LVmQHzOBqm9EbipDmU+JtASh5sVV
	eBgtTbFWkIDi+LHhw==
X-Received: by 2002:a05:6214:2c13:b0:8ce:b018:89e1 with SMTP id 6a1803df08f44-8cee628fefcmr267968686d6.32.1780947818366;
        Mon, 08 Jun 2026 12:43:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd07629dsm176866096d6.39.2026.06.08.12.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:43:37 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:43:35 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <ljs@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aicbZ9lewv1wJqqS@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <64f2e580-aa82-4849-9236-b8ec4208ca24@kernel.org>
 <AEB19464-20A9-4C5B-97B8-681CCDD81031@nvidia.com>
 <2475e4c4-9ba3-4091-9bfd-1c1c15163da7@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2475e4c4-9ba3-4091-9bfd-1c1c15163da7@kernel.org>

On Mon, Jun 08, 2026 at 08:39:10PM +0200, David Hildenbrand (Arm) wrote:
> On 6/8/26 17:27, Zi Yan wrote:
> > On 8 Jun 2026, at 7:08, David Hildenbrand (Arm) wrote:
> > 
> > Or should we defer zeroing after a page is returned from allocator? So that
> > user_addr does not need to be passed through irrelevant allocation APIs.
> > Something like:
> > 
> > alloc_page_wrapper(gfp, order, user_addr)
> > {
> > 	page = alloc_pages();
> > 	if (gfp & __GFP_ZERO)
> > 		clear_page(page);
> > }
> > 
> 
> Not really sure what's best here. I think we'd want to limit the lifting to some
> internal API, so it cannot easily be messed up by random kernel code calling
> into the wrong API and not getting pages cleared.
> 

We're a bit in circles on this.  We discussed explicit interfaces a few
months back and the trade off was:

a) add user_addr to the existing API and cause churn

or

b) add special interface like above
   increase the buddy surface
   leaves open the ability for users to get it wrong easily

If we forget VMs for a moment and break this step out separately, the
core question is whether page_alloc.c is the right place to be calling
the folio_user_zero() or whatever it is.

We seem to have agreed "yes", which necessitates the plumbing of the
address into the allocator.  The question is whether it should churn the
existing interface for have its own explicit interface.

The implications of getting it wrong are:  a user page doesn't get
zeroed.  *oof*

I think that's why we thought the churn was better.  But considering
we're already in the same state now (callers are responsible for calling
folio_user_zero() or whatever), maybe that's not horrid? 

~Gregory
