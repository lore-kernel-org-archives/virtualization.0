Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB123E7140
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772867; cv=none; b=VQ9hE8LswNYySnPofAi/VAxWWEW5EdlrfR1ndbEmZGNoHryBhAWQcYLbLrzCqrq+Vq/UT9rzkEXeX6haZtpupItp20/jol/ra8IwJ6u0L3sEv3U2upN9nqwiPzNzqt2gsTbVIgr15mx0om8eJZej/m3XEX+j1sANiz6UClvh7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772867; c=relaxed/simple;
	bh=CHD1VwchtvP9g5VyScF+zybP9GHn0GYWzM4e1ldl/7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ch59B1EZp1exTpJ8ph6cUKzxfU1s6MGtLOOVFeX8DCb4KEtQ1IyljzrfDh3Y9opinKxFWxRSF4ldTN+bUg6P6txmXU2Q2XNTk6unBMnyxrKIf7m/U/2cA6RLZ1X7ROJRFdN4R910O+Q5ZA/Dn0vEwEB3k+pGiN4byfYjrBP5hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZberkJql; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZberkJql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+CWg5lxx32FMjsqcYIsFdKwXQ5ffiqlurIUVj9N3ys=;
	b=ZberkJqlH3gdIdfD0S9VGnTFTct+76E00n0bxWjtXHpJ3QLHaMrZFt9hBcKPv+5pK32I4B
	CAk6WJhiTBj/Yk5AWxgbZdEjTaz7ZhX43WZS2iNtO5/EPi3jr7v6/zbA7fEET6prMlXVlH
	bk5L6Q7YDR65zK2zHyoslx8uEvRhfTk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-ET0RWycxN02qdb-YRyw5cg-1; Thu, 14 May 2026 11:34:23 -0400
X-MC-Unique: ET0RWycxN02qdb-YRyw5cg-1
X-Mimecast-MFC-AGG-ID: ET0RWycxN02qdb-YRyw5cg_1778772861
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fe3e73da6so1774445e9.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 08:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778772861; x=1779377661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+CWg5lxx32FMjsqcYIsFdKwXQ5ffiqlurIUVj9N3ys=;
        b=VoCpCQOssZxHLNPSUkOvgrxd1DMxct1wVp+xgphNK3LcRqLZXFfR+u24bYUdnplhLA
         AI0Pee74mXWQ+1Esc31bYb4eYCGPdrV/iFMQ9tydoiWA2LZ9ShUe+0NTCiuelA0iCGPr
         O47MAy+acNgtIQfVBYrgcqYXVgjLkqOEhIQqPyLgnej+A9XFbf+hox/Hu42S93TKPnuY
         Woq9KtvW42C0/HNi3lQ127qHfl1ZMC6CMk09Q4JbrMaiGFC2ll1mRz1VSEUMKkcERI0x
         4MEsvlS941mTh8m+KPc2yeyvNSHZPYi56GmY++iP1Duxln/jElw0EtIDPSlMoL6ZYIIj
         AMkg==
X-Forwarded-Encrypted: i=1; AFNElJ8qKh0e5Pp/yH0spJTqdJG2vlUSsTLbvPTusE1EAnI8ZCPRIlbay7HnxZW3xb23SWpuOA8HgtV03Rx++5kJvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKsRjmUfoL7YffawwYDVKXydy42o2im+kWxZV+2rOPRUnWwFKR
	5jL29wAQQCHgbfpa7OUN6KmzxEJFvJvu0hTspqSFwib7UxGXi8JNaL2pksIhdQKG+GTUxwl6ukR
	ef23hLpsCfKG5F3KFL26tX2w8nxO3UZqA2zvm3wO9D8T5VovNsayGB/6ofsB5H9Acok3I
X-Gm-Gg: Acq92OGRY722xLzE0DNVbXxESzm+QHSChiInnuxBlNI4Chni30q0TjR5hjvAH+//SNO
	aP/YcD2GBXlecMSJneh7a7TVdFNWn5DTnvzpr1DZ8/enlTXiQ7FhwsSzk/qjY+qSeG7J0Jrx+Xw
	BxRTyenvhXpwUJBteyBlqP1OnjLu4Hobcp3xpY0AfCRB2KMZvoLlb3yIwqfl5emlYHBvM50k+be
	9HeFmGztKstNOX3wUU0SeeBDtb4fqhzPnpnsBQ83yUt41lKtRqrgXgAn9C+KVsPI2h0FwkREsAZ
	tNxBvsYTTbjo0WrEpI/5B5APZqJsk+9REojL5siF+SaJcGyMsrdMOVjM52gMejJKc8F7aZVzNZ5
	2/XfYX7TFvZsIqb5i4qQuQxlxHIc9RAxRSrnX8WNv
X-Received: by 2002:a05:600c:348e:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48fc9a5b56amr127677345e9.28.1778772860698;
        Thu, 14 May 2026 08:34:20 -0700 (PDT)
X-Received: by 2002:a05:600c:348e:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48fc9a5b56amr127676625e9.28.1778772860100;
        Thu, 14 May 2026 08:34:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdafb6145sm33187345e9.1.2026.05.14.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:34:19 -0700 (PDT)
Date: Thu, 14 May 2026 11:34:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
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
Message-ID: <20260514113337-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
 <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
 <20260514104735-mutt-send-email-mst@kernel.org>
 <agXrCinY2HmJmhT6@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agXrCinY2HmJmhT6@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RuxVv-sDHx9b4aIegGzlLxeB1USoF1AhvDZGYzDlCRw_1778772861
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 11:32:26AM -0400, Gregory Price wrote:
> On Thu, May 14, 2026 at 10:48:28AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2026 at 07:51:03AM -0400, Gregory Price wrote:
> > > On Tue, May 12, 2026 at 05:05:16PM -0400, Michael S. Tsirkin wrote:
> > > > When a reported free page is split via expand() to satisfy a
> > > > smaller allocation, the sub-pages placed back on the free lists
> > > > lose the PageReported flag.  This means they will be unnecessarily
> > > > re-reported to the hypervisor in the next reporting cycle, wasting
> > > > work.
> > > > 
> > > > While I was unable to quantify the performance difference, it is
> > > > an obvious waste, even if small.
> > > > 
> > > > Propagate the PageReported flag to sub-pages during expand(),
> > > > both in page_del_and_expand() and try_to_claim_block(), so
> > > > that they are recognized as already-reported.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Assisted-by: Claude:claude-opus-4-6
> > > ... snip ...
> > > > @@ -1731,9 +1740,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
> > > >  						int high, int migratetype)
> > > >  {
> > > >  	int nr_pages = 1 << high;
> > > > +	bool was_reported = page_reported(page);
> > > >  
> > > >  	__del_page_from_free_list(page, zone, high, migratetype);
> > > > -	nr_pages -= expand(zone, page, low, high, migratetype);
> > > > +	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
> > > >  	account_freepages(zone, -nr_pages, migratetype);
> > > >  }
> > > >  
> > > 
> > > Maybe mildly out of scope but worth asking:  Are there other flags that
> > > should be retained/propogated on a split?  If so, rather than pass
> > > was_reported, should we just take a temporary copy of the page flags and
> > > pass them all in?
> > > 
> > > ~Gregory
> > 
> > 
> > Not that I can see, no.
> > 
> 
> You do this exact thing again later :]
> 
> https://lore.kernel.org/linux-mm/9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com/
> 
> ~Gregory

I mean yes, reported and zeroed) Just zeroed does not exist at this
stage in the series.

