Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F62F12C6
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236888; cv=none; b=KLYLNMtZltYnCVVp6z0pQlyJbKAidBTQAoKOR213znGJKLfgYLgisAYfgsAkTcB0ZX10LRp5Tcg0SxbpEDbVRcG7E/hsXbiQtlQe0XFbYaHVJ0HgpzJy+r+Wee/udHAHyIdaFwk0APXnoZyPnd2sQ8N+d7T38DwwrAFtv/9wVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236888; c=relaxed/simple;
	bh=jNoc5WheHY4CCYh5RHGgtSgYu68JyP4sZul+uV4WPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r2myl5FfhEpCWKIIbfgafkHe4mI//KtP8xR2Q7NTTdXQ89ETgfGv7cOLvreeJt8XURoMOJmUODMzeW1ZIAlOeIelIrJOI0r+T6CwCkyTm8hH/P0mzMlb74ho4jj2wyZD26E2BB40h7zn74B9bNMmZgP+F7ohCg7IZbVcYbyDVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsIJj3Bl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsIJj3Bl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777236885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7ngkkoYTFNaoszFfXjnqMQHnCI7xfB39TzmshJL6/Q=;
	b=AsIJj3Bl4555v1QiDKCLiynDZxxG/s/bmorNrGecz2yWnz7lwFcJ4SrgikwC1IwqiVH75M
	/CYGnfaHsTZTjSlV55RRPY7ZiIE1VdhD9LrEendEdL69cORZtC0LSfkobWmBYs7hQlcWxf
	cTzI0y+gr1RqC+laD4NW4FBZ4C7SRUA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-FImM9ogaPn6E-qvE5RQS_w-1; Sun, 26 Apr 2026 16:54:44 -0400
X-MC-Unique: FImM9ogaPn6E-qvE5RQS_w-1
X-Mimecast-MFC-AGG-ID: FImM9ogaPn6E-qvE5RQS_w_1777236883
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso104601885e9.1
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 13:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777236883; x=1777841683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7ngkkoYTFNaoszFfXjnqMQHnCI7xfB39TzmshJL6/Q=;
        b=Rc9w/E9yAf2lnZRtd3ZgSc45E53nx0mqcM6dqHid3m1NmPsAGxyr7hcqTj2NmbEvkG
         dOA+9mXAECSlL131gTKIK0iB8uWQERSh4j6E01d+ARLZfqPwL4bkEBDSrtCsRZjR9poS
         21eYjNdydA8L0emmTsx+SLv6Xa3kQU561mfi5J9CkGM3BgN9aYNiLHXkmVGBr+TpWXXb
         /LHE+1EliQRJidl3/DTs/QOmTLk1IpT22SyNrfe7v4Kw3c9W/e3ExK9ZZxg5I1wFnH61
         WQSX35os+EM3npCr+Pq1eXa4POX3G0cuM7QjfjiaFopNuix2iqHElw0xxnyypFycMATU
         FB2A==
X-Forwarded-Encrypted: i=1; AFNElJ/qUajxo0mFxB0EzE5/sMv2Q3ee3k6XeoiD6OTa7n7mtVb47MPNPrP+8ljrb5GUl7cOEM+Pqe6pHM8Ma3qkQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKVwHVc7nvjLsSD3V2IYfmYKVWOvsXQ4rXf0RV3NHB6onivI35
	0m7NlwoB3C6a7GvQ2JO0vfvXbyiATndM7ZZ1iHm3COj0PlZgZKpgDQCxAVuF8MBoCnGRNAF9t3d
	e1zvhYcfymKG+QOzUXVDan5vcMTv0Xb05DbaO2vVZvNu0cYr7WV0IxiRfEDccZiHpckvZ
X-Gm-Gg: AeBDiesghQeVaQvqi57tI3t1PRGFqf4VY7ptm7LmvU+GOk/O+sVCrZ1ngD98vPeMsrN
	Zkg4yFmv2JSAcrWhnXw90t5ib7Lf52/eOJcINhieujqRPuMxnkQuiId1C2sm6iqBgQHYY57llUh
	VeeD+dmZdn2zwVW04fhCHLzctBig9NkOkv6/d/VY0T3lyAXGVhusr3MwgnxhEmi5iM8aXY1rplz
	QLFlu511szO1Oyiuybs57BdyQoM8A/l3/jYSZnYXDS9kFYOTkON9f6WrWW8Q8Hn2dbx0buBqpsQ
	y3FKZ8zlWaodcgruGfmUqVXit7J+CKqc2+HSaG6A9It2yukbsXgaMw31FzrJ8vWxk6/fmFWTQai
	W2FVG0tM5nlNQNqjSV5KAPf1NdsA9Vk58IsMH4RHMtbuyxbtXGBMBG3T3
X-Received: by 2002:a05:600c:3e0d:b0:489:6c28:dbc6 with SMTP id 5b1f17b1804b1-4896c28dd4emr413474145e9.31.1777236882612;
        Sun, 26 Apr 2026 13:54:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0d:b0:489:6c28:dbc6 with SMTP id 5b1f17b1804b1-4896c28dd4emr413473955e9.31.1777236882086;
        Sun, 26 Apr 2026 13:54:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5c24d82asm164063795e9.7.2026.04.26.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 13:54:41 -0700 (PDT)
Date: Sun, 26 Apr 2026 16:54:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <20260426165330-mutt-send-email-mst@kernel.org>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aeu5P1bZW3yEH54t@casper.infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aeu5P1bZW3yEH54t@casper.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I8pZ3JBLGBti8NHLDPFEhR6ZKkBA3h_598Z5RQQJ_tk_1777236883
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2026 at 07:41:03PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 21, 2026 at 06:01:10PM -0400, Michael S. Tsirkin wrote:
> > Thread a user virtual address from vma_alloc_folio() down through
> > the page allocator to post_alloc_hook().  This is plumbing preparation
> > for a subsequent patch that will use user_addr to call folio_zero_user()
> > for cache-friendly zeroing of user pages.
> > 
> > The user_addr is stored in struct alloc_context and flows through:
> >   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
> >   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
> >   post_alloc_hook
> 
> I don't like this.  I think we should instead lift the zeroing from
> post_alloc_hook() to the callers of __alloc_frozen_pages().

can you and david agree somehow? I don't like being caught betweem
maintainers like this.

> I don't understand why you want to remove the double-zeroing of memory
> when the user has asked for zero_on_alloc.  They asked for stupid things,
> let them bear the cost.

it's just a side effect. I did not even test what effect it has.
what I care about is the overhead with
reporting.

