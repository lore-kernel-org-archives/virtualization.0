Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208D383327
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554253; cv=none; b=WY50KihO/TLR8pItJ6cJ8qcLxlSBHUsZxEPPVO+M11Q26VkzML8vBUp5IEoWWkS1t0o50U9WRCdSBrh3lFIq1ILbG4zgAcD1ABCiinHhsydW5h4vw/t3mWH9U45MZTouiwz5FAO0hj3VWELuOk98EiAkMW8yShtTmKzIbfW29qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554253; c=relaxed/simple;
	bh=ySpwvVwjaoz00brCrpac1ZXRE/yYfz3CspW4d8/R0Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5psiEQ9/BQStVoh137p366+1v+Lr67JMnRja2k+kUDgx7sTOcieh1pf8g9G6sQztA+X1Y+GiEn0ZPzkVnxXxxsBDVj9Ek8bjU87jY53N4kImowgb1rncpZUT0uMlnBuyTlBqab5g6ZoS+qiCrnFg+oRDzVSp31HbpGDnuxRlpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lMHvFrcs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lMHvFrcs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8f231f3b130so385793185a.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 19:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778554251; x=1779159051; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SkMrOM/wJbu6CYfcf0w3cGY5A4GXI3y3nMw7LLmua6c=;
        b=lMHvFrcs/zsptoMKa6b7xh8N+9Fyg3BWps/v7BGe0whdk8lECg6s88kXDtRbewmUCq
         AJSBPWJiaWgmzfXIBbSIhcTd/6+R75vLF8469bo12oRKD+C5cQKeM70l4D1PLfDoP0DW
         SXATKcaplDAiuUu2jwV/l6I2g6S6knhB23jH0fQ69mFRwfWokiCZ1UelpfgJQgOmMeYE
         ODSDg1YSq3IYTFk65uhU6fIp6gwwMCTGCtt1fh8vLU/3wTn981ZF8m+XFrXqyTXBdZND
         N9I7l4hB1xCrJvBRL/M2ACHM7UVz9qjmJHXWpH6GuLcDg9sLE+Rg6JVYpLVedWvLV7gV
         fhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554251; x=1779159051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkMrOM/wJbu6CYfcf0w3cGY5A4GXI3y3nMw7LLmua6c=;
        b=p0u+x/KQ85oWlJQtN1yTmn6f3OjEYIn66PVXM2EgS4nVrH9nAvJc6aOSZoYHzZKRkk
         IL21oI46VIjkhnCd8JbPA1gF9CaOrM+BuFF1C73nmGwhToK3z0Ybwf9z/97Y6T4VmCch
         38ugN48CH83sm07R3v85FhhtMptDXA2gTST793252A6B9MCtXObc6o2AdGebZj3WEeJT
         T+BfoFyGFirNJH5I514KRwqvxieNASeEJxhpR5b3T5YYGNfFfAiWpc121x89E3EGjdUp
         nv/74czxug/0PrUO6ev+3eZOVYdpzZfLjNKfRQOC7Y041ILt1LNUGHpdE/FUcznggS49
         iC+g==
X-Forwarded-Encrypted: i=1; AFNElJ8TL5LFd4kDdJL1xQP03hsHflrcv3Ia74wudA7nW8/yF1mN6fwHZbyt2NF00nqRHsyHST92mCGCzsvrdGe9JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ0Yk8taKvABw1adC/oz5Uu0IvNC4KbH4HqakoSzvloKOIGCQ7
	EBtOEWuP9ypguqvNYgeVNZzuDE/sltuOe/0qyt680jJXtpE/6jpIQL0pEguS47+E+Uw=
X-Gm-Gg: Acq92OEWERbL7ZTYSTPXIHw0QS7QgBb9uDcEO2xHhgIIBnGdeFU33IosO7k5c603Yny
	BXFHHdhzXM2VxfqmjAx1m/OJjtf/oXAYrE2/4OvUpa+4gkPTP4ORK7SikQZ6WV15WyEUUsslMjI
	sCskU4MBhYvWCAsL/srqGJQ3uk4nBtuYMHlnrdrt8BYnWccCHy7PTDdNtcIWNYPzQ5idH4hLhK8
	0dg4LZ586a5VodESUxBOVuyjSpLpWrXA5KznfDnqnNrZWgedvUUDI5DKDcGJg4SvnztIGH2Ium5
	1T2u3xt56MZQMWB2n6+O6AI95pYQ0GMBQ7veybwWB4RBJnU0xgpkwoYnPEv/D9k+Hm+T85TjDk5
	SxLxxX/D4um5fXXMGagk1R+IBYu+Q4ac+rMAqE2OsRcMJn+MMpWOah7KOslD/KYgpX6kOOrV0k1
	HlXgEsX9q8hyOZ3d0zLFpJBIBMFbeqKpMWCZDlymfMVa0d2+th4/6gwFMUQ4K/56TB4jurXfz4F
	M4TwUSt6lkb
X-Received: by 2002:a05:620a:44c7:b0:8cd:b61f:2f48 with SMTP id af79cd13be357-904d64ea04amr4159360985a.42.1778554251519;
        Mon, 11 May 2026 19:50:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9772b87sm1195078585a.5.2026.05.11.19.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:50:51 -0700 (PDT)
Date: Mon, 11 May 2026 22:50:48 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>
Subject: Re: [PATCH resend v6 03/30] mm: thread user_addr through page
 allocator for cache-friendly zeroing
Message-ID: <agKViOG_YQci0ffN@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <9b53972f4854c1064b92cefc464f51949afeb83f.1778489843.git.mst@redhat.com>
 <agH3wceKcPNmixCj@gourry-fedora-PF4VCD3F>
 <20260511114853-mutt-send-email-mst@kernel.org>
 <agIJOkLhTOsvJs1-@gourry-fedora-PF4VCD3F>
 <20260511175032-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511175032-mutt-send-email-mst@kernel.org>

On Mon, May 11, 2026 at 05:59:23PM -0400, Michael S. Tsirkin wrote:
> On Mon, May 11, 2026 at 12:52:10PM -0400, Gregory Price wrote:
> > On Mon, May 11, 2026 at 11:55:40AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, May 11, 2026 at 11:37:37AM -0400, Gregory Price wrote:
> > > > On Mon, May 11, 2026 at 05:01:55AM -0400, Michael S. Tsirkin wrote:
> > > > 
> > > > > +/*
> > > > > + * Sentinel for user_addr: indicates a non-user allocation.
> > > > > + * Cannot use 0 because address 0 is a valid userspace mapping.
> > > > > + */
> > > > > +#define USER_ADDR_NONE	((unsigned long)-1)
> > > > 
> > > > Ehm, hm.  Does -1 hold as a non-user address across all architectures?
> > > > 
> > > > What about in linear addressing / no VM mode?
> > > 
> > > this is used on a fault. I don't think there are any faults then?
> > > But maybe FAULT_ADDR_NONE would be clearer.
> > >
> > 
> > Meh, naming here is less relevant than the sentinel correctness.
> > 
> > My only concern is really whether -1 could end up being a valid address
> > in some horrid future timeline and this all going belly up.
> > 
> > Is why I asked about whether this is correct on all architectures.
> 
> I think the answer is yes: on all architectures Linux supports, the last
> page of the address space is never a valid user mapping. The kernel
> enforces this -- mmap will not create a mapping whose end wraps past -1.
> 
>   if (addr > TASK_SIZE - len)
>       return -ENOMEM;
> 
> 
> So the maximum vm_end = addr + len <= TASK_SIZE.
> On every architecture TASK_SIZE <= (unsigned long)-1, so vm_end can
> never wrap around to 0 and address -1 can never be within any
> VMA.
> 

That is worth documenting at least in the changelog if not the comment
with the define there's a clue if anything ever changes.

~Gregory
