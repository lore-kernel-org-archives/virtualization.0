Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1947A3A542A
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759469; cv=none; b=fBJ8wn7xF3Bke4WBVCxd2C9nXfhY6lemWzW1MQg+ynZnLwBNWmVrTuQSNmEiDaLko7bo7WV2Yikl9WkRLfioHJBhsXCwddHJRAdVpMkxw+PUDxjtNlsplBW8ZrMgOCrOZT70wrGyFufX+Ex6I5Fw/16+O68Qf0R98ujLr9w8McE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759469; c=relaxed/simple;
	bh=TDT8hciE5by+7p1FA4NNR45GEo+DRpRqNs9hjNu/cxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMQOB1P+mzez4YyvuJ1+h4PMVUsbb7j5QqQnWIvRyw7PTaWf3BbQapG4jsVN//S2HHyK9VKk73KkjTqMIBZrAAw0LL2wX7H1W/UkVkA0AL9EPEJR9e1K4K9DbwojquHL+WU9wJuu0xJJOSjfWarziPb+D2GVXlGFlJVlc56QfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m6/d9uQg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m6/d9uQg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90ca6f20872so349433785a.0
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778759467; x=1779364267; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3otPrX8ylWiqgm/t2ct4ZpbOY2TynCo6XoPa75Eeyno=;
        b=m6/d9uQgR3qZNbX0QKa5kryZEMJay8TPP+RWLIH2fifIBJDVb1iLmLySKRL/rL/21v
         l8va0HOSYqAX2H/UNFihxwCVb0cW3V6Q/5LYtjk4EGZPm3vevUHOm2pYU2Y7fkjclEPK
         3zsyshW3wd47fR4xy7h5kOSe3m8KHKub7ODZ8Xo1dHM/dHNydPyaBn3+hYAjebiH+yrg
         36kl/s2XM/OqAXYcWJVYVx9hewDGEQ4tIb5dbUbHMDiJ1tK72mALefR1ZYGj8g1rQbZR
         sLaKAbdW1IPhqp0j3ntgo3EguF625UftspMQl1MOtGVs+ehondIWQ932u8X+5e2AJHxu
         du2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759467; x=1779364267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3otPrX8ylWiqgm/t2ct4ZpbOY2TynCo6XoPa75Eeyno=;
        b=eLcrmuhperc+TEBdPPP3SbE7hWQ0v5Psrn1GcrbyKHlzHrFuaaH4FhK6PVeLACps2y
         BlOW/mjf468/kX9xnDwkC505oJJ4EZbC9+8RRYloWHrBqWhdaMDiixK2HbBu6vzJ/HAH
         W0Evz6TwVNRtfWrlRq/T3pH6Yt3WNR1JOXahQtdd+UyBXq4F06ZpTE6XVII5CEibeylP
         jj5ByNrEhHJKXWp2Z0uY+a5/PSDrQJHmE0EsrOaozksBD8b1i7i6lpNbsivA182SErh/
         ehk+2YhYM3fQYZ+UrljlbNBaaQHmK41rB356/VHgvu/Akmhp4frkbQgSZieovUDFdFYQ
         Pw/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/7hhTXJn5z3A5gWOT40WH4IZVp6iC7Hpr6vxTBqFYjqYeXKuFvwt6XIT0HTvydKPnJLz7UX0wgx/dsTXgYzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs/cNsft3VuT5WBWOO2ijPd8RpxNHGovhHRPek6yOH/zCevsR2
	9ngDWIegwhONY/Hi4j03I74qaNMD+FMvKqSr+UfOqJ70KuDu1LKkRPNSvbq0ul6IbTE=
X-Gm-Gg: Acq92OEMBk9+7Uj15FgISP3ZB8oWP6ZyUJ93EJBFOuhNpbnZtSmVPdcO89LoiDq9q6S
	Kqh59OA41fUAwoxXPUkB7U+S3jKgK3ntbnVfNpiosk9CkwOE+/pH3m/wtfo3Hhw9tHV58FQgR11
	IisVemoPcRHFn8K8KIAHBmnRDGkkPv/tq8hhotTaVoOzrX5RegwlqLCQbFzhGG8X3oSdL9lW5o3
	YEKCdKz5lVVc4Ma5VVxWkvPh1hs5/CInNEFxY6iuykKkhbAtYkAaCEBomeQ1YDqHOZfY06vM4bX
	ZuUg0UAj5XE/eX8X9HZRMwrHEJt+3yhhf8p0jRD2IQ/7UEq0VW1eV7Yoa5EQJUpM/jJUR7RxoVk
	M2kESQE6f756daWJ3QvxwROBL9NHZ8n949DFOhBZCvv2LkAYJ13LVy1FdfYZJi/ec+cVDZswS58
	judCZzFyT08coMapnSBm70I5m9vSUotjDN+CqoMmeDqwFTYsp8Xse7GfHMJ3sXPNKnSOzO5B6zQ
	wCGVHc7G1YfqrAtfetrL3Q=
X-Received: by 2002:a05:620a:448a:b0:8d6:d217:96a0 with SMTP id af79cd13be357-910abf49b96mr451245385a.0.1778759466839;
        Thu, 14 May 2026 04:51:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd620fbcsm229997985a.42.2026.05.14.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:51:06 -0700 (PDT)
Date: Thu, 14 May 2026 07:51:03 -0400
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
	"Liam R. Howlett" <liam@infradead.org>,
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v7 02/31] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:05:16PM -0400, Michael S. Tsirkin wrote:
> When a reported free page is split via expand() to satisfy a
> smaller allocation, the sub-pages placed back on the free lists
> lose the PageReported flag.  This means they will be unnecessarily
> re-reported to the hypervisor in the next reporting cycle, wasting
> work.
> 
> While I was unable to quantify the performance difference, it is
> an obvious waste, even if small.
> 
> Propagate the PageReported flag to sub-pages during expand(),
> both in page_del_and_expand() and try_to_claim_block(), so
> that they are recognized as already-reported.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
... snip ...
> @@ -1731,9 +1740,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>  						int high, int migratetype)
>  {
>  	int nr_pages = 1 << high;
> +	bool was_reported = page_reported(page);
>  
>  	__del_page_from_free_list(page, zone, high, migratetype);
> -	nr_pages -= expand(zone, page, low, high, migratetype);
> +	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
>  	account_freepages(zone, -nr_pages, migratetype);
>  }
>  

Maybe mildly out of scope but worth asking:  Are there other flags that
should be retained/propogated on a split?  If so, rather than pass
was_reported, should we just take a temporary copy of the page flags and
pass them all in?

~Gregory
