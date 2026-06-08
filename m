Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860EE288B1
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950826; cv=none; b=V9X9oUWNj3cZkTccrZjDodJQIoKn08mHoHjNAgcMU1EABS7W3VtMmbpBQXVcaOW72jHVLowVu/arK+mojsWdw9vwqNbQzUBO0hy91cb2GALfcUVla2anWQfRuHwrBt3AahygW8WpBV9QQ50FNznnAftiZtyq4WxZQcFXr/FCDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950826; c=relaxed/simple;
	bh=W0dioJoghX7Q7sIdgbBbf5HsaBaheWAF7HSIZofrT2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lerL7S2nC0aw+X7e8m1UJZPXW/JlyBmUtVTZQjFQySfLwbmatnu3bS1Mgmcec9OxJhB28VCYU2YFmWR8FMsaqswz+wOkOrfxih08Hdx78Ll/ICGg3IDt2LvcU5dvgBDwNAK9dYSMZvKzd9fjC5HWT6LI3CC1TW8kGMslctbcGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4dI4SXr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4dI4SXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780950824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1CZWnaLjy4XWhYnDZ8ZzqFQF7H0uYCpTeSCvjLh0TY=;
	b=A4dI4SXrgUIq7yE/IGJAwyJBxES2fB6Wg+ygOfvq3cqtduT/KAH6bs5f+m6PThiAtjh/8R
	r4EtQ/G9W5vipN13wZsvaZu0ueOfodDxnLWnDWlA9CyTHU3j4zw9FT5Z6szItYjTYMeZMX
	iMQOw0luxGBXizQrHBKcpQ728sAuwEc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-Tn52GuCWMwur36YY7kbgVA-1; Mon, 08 Jun 2026 16:33:43 -0400
X-MC-Unique: Tn52GuCWMwur36YY7kbgVA-1
X-Mimecast-MFC-AGG-ID: Tn52GuCWMwur36YY7kbgVA_1780950822
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bfd70b0fso49312915e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950822; x=1781555622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1CZWnaLjy4XWhYnDZ8ZzqFQF7H0uYCpTeSCvjLh0TY=;
        b=GVv8D33fCiZQHIv2tHtTHpGtiwGfF3bCQHMAEo6lCjexIp7/4m8yvhQHG7rF9SJZcu
         ojjGllrgqAtOiQdWhKP1/4drUWv91iywLrPcfd0r+nzzYmqfmPWoFx+Y6xvwCcElv406
         xjjGLt4F0CFg1Ewux341bsWLqE/mvZcgJTPMewYapu0Nvk5kTHvFnsoHrf5KUGIado0q
         2BGr2VwvwEUhWaSmBzERaq/pfXXisfjtwTUTmJkTX1Gp//ZQ0XpHJ7o6A3tj/JPiw90k
         i1EwSlFeTTQHAMZpUdLuH/xtT1ntZCt2DKucJeApZhMMfe986/HG7VYLiN/Dv85Sm7Mp
         mFJw==
X-Forwarded-Encrypted: i=1; AFNElJ8h1RotAvyMlkwI6dVykgQQjUQtHzmlpWP7pCE49ftdwTnheCuflODCtzdvB8TT6Jd+HyGx1xX/iemBMkJETw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr7idxs7X5Sa0ixKoR2tgw44m//ovlQ9fiDvbBkzuD7cL+BK73
	a0Gs/Sf1QlxMpxEawHBqHSG/vW+bYNTTp4KHrCdhlS2z2OmItX+wOnUlQb+BER7GibhvfqzhMN2
	yXyNunuGNyy28Zu0glcLj33KB1MVNitcDt5eetZyW47Xoi0qljM2xGE9gEoPs97ol7irC
X-Gm-Gg: Acq92OEEbvEJ/ZMvllRSvQ5CQnI+4xcZYQUNzsf2aK38kWKJ0iQoKh3OS7uIzMxAIXU
	htBXqixFqp4OYO2pWn3dlZPiBQ5O6u1kav9PUJh0cVJGvgpXg2jgfZ4XZaJY1+zIfOIMi0nqQwU
	BO5BDQ0LjNQGF3ci3HkT1t8IOfkBwLIve8PzL2lXnxWchCSuLUcr93w3jCBHLjHxN6jQ1L+Yrow
	QEkz6sXfz6XZGm9bCg7472W9Mnd9/Xo6/2KmkwgoYuvqrJSXzdqUF/JemxFBLPJOtWxesDb7Egr
	VXCfjcU+5ze4skOnT1FySNhB4iHB+pHscAPSKWdGxcKNkgvk77kB1xeVeV98b5mprHreRUifJtg
	91TA0IcADY/Q3i2wC5kVCGMKopk0KfiG2m3sdIE2o95b3S3MQrHAotw==
X-Received: by 2002:a05:600c:3107:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-490c264cc2emr292104255e9.33.1780950821732;
        Mon, 08 Jun 2026 13:33:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3107:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-490c264cc2emr292103725e9.33.1780950821331;
        Mon, 08 Jun 2026 13:33:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d52e5esm196804455e9.2.2026.06.08.13.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:33:40 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:33:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
Message-ID: <20260608163257-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
 <aia93IzhTgi1vGi6@casper.infradead.org>
 <aicfERTP3H6AndOs@gourry-fedora-PF4VCD3F>
 <D1CF67EF-2CF1-45F8-9265-70A528C1CB01@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <D1CF67EF-2CF1-45F8-9265-70A528C1CB01@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2ymImVTaepdxGTcjCwJbMrPMKsL47gcA6Dkym474BI0_1780950822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 04:21:08PM -0400, Zi Yan wrote:
> On 8 Jun 2026, at 15:59, Gregory Price wrote:
> 
> > On Mon, Jun 08, 2026 at 02:04:28PM +0100, Matthew Wilcox wrote:
> >> On Mon, Jun 08, 2026 at 12:06:35PM +0100, Lorenzo Stoakes wrote:
> >>> But instead of overloading user_addr to indicate all kinds of things, instead
> >>> make life easier by actually breaking things out.
> >>>
> >>> Like:
> >>>
> >>> enum alloc_context_type {
> >>> 	KERNEL_ALLOCATION,
> >>> 	USER_MAPPED_ALLOCATION,
> >>> 	USER_UNMAPPED_ALLOCATION, // Maybe? Do we ever?
> >>> 	/* Perhaps some other states we want to encode? */
> >>> };
> >>>
> >>> struct alloc_context {
> >>> 	...
> >>>
> >>> 	enum alloc_context_type type;
> >>> 	unsigned long user_addr; // Only set if type == USER_ALLOCATION
> >>>
> >>> 	// Maybe something suggesting context or whether we init before in some
> >>> 	// cases?
> >>> };
> >>
> >> Ugh, please, no.  As I suggested last time I commented on this
> >> trainwreck of a series, lift the zeroing functionality from
> >> alloc_frozen_pages() into its callers.
> >
> > This sort of just implies writing the "alloc_frozen_zeroed_pages()"
> > wrapper that does the zeroing at the end before return, and then killing
> > the post hook nonsense associated with it in the first place.
> 
> This means it is going to be a multi-step optimization. This is probably
> step 1.
> 
> >
> > None of this resolves the user address annoyance which is needed on some
> > archs for cache flushing.  Whether anyone agrees that the page allocator
> > should be responsible for this particular operation - open debate.
> 
> This is probably step 2. But does the virtio use case apply to these
> archs? Does the performance matter for them? If not, maybe this part can
> be left as a TODO.
> 
> 
> Best Regards,
> Yan, Zi

I doubt it. But I don't get what's proposed, the code that we
have to modify is arch independent?

