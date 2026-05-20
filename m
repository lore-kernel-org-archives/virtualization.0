Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36AF33A9FE
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315638; cv=none; b=czUJAOFvaBzY/LyE16q4G7PbWOev3HQBuRLQfEHOTtKwpj8cge07KFyVE2P+r3y0wz6rETAS8C2DS8vvmwH5BDSdpkynNAgOUezolhyvVVy6K2U5It0PJvxYChqNw9PvBceQ/lsREELwo+QW1zEwvLHDpSbmS7/yEE9D5YgoYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315638; c=relaxed/simple;
	bh=2SCjG0p+gTn8qm5MHLYDPQz8gTh6+lwWx6Kgl/LoFJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZmUKcHcyeqxjyeK6CPboqEDGVM7Jebu6zzb/kSpHYXesLZ2M+cPQIbMANQZZ2hUxoNFWWWXB0Q+BxGFyLQKEaMXr32+t81cx0EsVb3+jq7JK+L8ENhN4GJwaPu2syv7wQiLMGH5DpmB2PKr7sYEpNjFVhVUheCGTvgTPezs4CU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFvuh9ov; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFvuh9ov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a9U/grsiUVqQvDGNE/rE2t/3gE4VHHRcC3EwM49fXU=;
	b=EFvuh9ovNYc87MDaDWef/t+q85/ecZvOxsW5pFNRQJvLc53T6g/S7hAshBNKOR+XJ//Z/0
	kMI0K3F7xXe3NZ/lCRQ1U/G3BZSjQfTq+O99DqsG4Xbfp2mw22H+oLARf2oD44wArX5BuP
	KrFkATsuduf+vnKAQnDhqAD1XvFhKgI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-WMdBU_sqMzGE0e4VHHKiFQ-1; Wed, 20 May 2026 18:20:33 -0400
X-MC-Unique: WMdBU_sqMzGE0e4VHHKiFQ-1
X-Mimecast-MFC-AGG-ID: WMdBU_sqMzGE0e4VHHKiFQ_1779315632
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-393e7ecef62so23594231fa.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315632; x=1779920432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a9U/grsiUVqQvDGNE/rE2t/3gE4VHHRcC3EwM49fXU=;
        b=GzG95d6OMl98njXav/aRFxxcigzrnq+LNidjJMB8lsgptuPTnLrEIU7o4/QcARcf5e
         tw50WW4NVN5Ngpo40fnTIgO77+KCvHDyxQv7xw2I5u51Vc0zmGakeFmfwwmcEOM1FVYH
         G/sJ9GWHVs51sAx2QWoFjFOv7J6wkqXh0KuiUO/H6QjpMMhucls1a4p+ZGrilltNEZA+
         L5YCUqsI5lahxYdpS1wKg3AKxEogmRp0EP0beXQkhsfJs8igHpHVzxOu8ytkPYxPWoxG
         qQyLl7jBbE10sWBhB5eyrtw+FiL4EsgXq79TAPI8Unr0PUhbAnI01o6pKRaMZJt/MCAs
         DRFw==
X-Forwarded-Encrypted: i=1; AFNElJ9hxDe3bQ4H3J0m75VzHGz0zTVDPbe8upX7iur8BGccZr+7ajI4xapkyagRdJ4t41cckejpK0FGF/dZL0ZN9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/2vlzS4BSlNRIOdp0ejdSQEa0FPmvllzmvk3s3o2+B6Xi4AfF
	3lisUTmRlM0plkPhmXPfzZMDNzqqqEvqJNufHx0d1vWE5rLO+LgSj47k/Hap8zvbv34to1Gyjqk
	cXg/+BYEeHinxP/C8wS0ugYvWyb+Qw873iZbusXhvg4ZR5JYeIGB9eLNZuNKRHNdROE1F
X-Gm-Gg: Acq92OFajlGP6NyXFjcQqHahmlv3Tn6FAqThYT5aKhZOWhVeLA4SjSdghqC0vzy37w5
	AEXS8wOnqTb2io95nCQuusXChPgZUu6HwMA5Zj3XeARANipyVRoQ4w0udgte7TnN4HPt9EVAwrI
	1nSKHAoODqYnVLxJD47BSLxMcVhBzstfvM2g8LcNnYNfwq50JiqbJ90ZPe3MVUpkZ34mtG+Ll9f
	WM5q5gcNDsWWbtxduRF44jMguJxKM5VNj4HH4M4YB4Mz2L4O8JWhF/vyEKWZsttB/80N+Crl8/O
	odOcjUz2nuvPCcBf4/TQaWB8F7E/0fiB+4POzVET6E7cX5SXkFe7pRgSSkFpwXcyR85ZVScCztc
	jMfBLJmzyaacTzv6DvIG55yJjsomu1NLFsD9PV6mTt3U=
X-Received: by 2002:a2e:bc90:0:b0:393:fa0f:d64a with SMTP id 38308e7fff4ca-395ca6449bbmr948151fa.28.1779315631972;
        Wed, 20 May 2026 15:20:31 -0700 (PDT)
X-Received: by 2002:a2e:bc90:0:b0:393:fa0f:d64a with SMTP id 38308e7fff4ca-395ca6449bbmr948031fa.28.1779315631503;
        Wed, 20 May 2026 15:20:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958828150csm32418221fa.7.2026.05.20.15.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:20:30 -0700 (PDT)
Date: Wed, 20 May 2026 18:20:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
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
	Gregory Price <gourry@gourry.net>,
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
Subject: [PATCH v8 03/37] mm: page_alloc: propagate PageReported flag across
 buddy splits
Message-ID: <20af8010c2e8ebeb736ae6754e640267b96b8c2d.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6AuMe73TFa1Xjy2qiXbyokwwNq7rCk5QL9t7fSPtB5Q_1779315632
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a reported free page is split via expand() to satisfy a
smaller allocation, the sub-pages placed back on the free lists
lose the PageReported flag.  This means they will be unnecessarily
re-reported to the hypervisor in the next reporting cycle, wasting
work.

While I was unable to quantify the performance difference, it is
an obvious waste, even if small.

Propagate the PageReported flag to sub-pages during expand(),
both in page_del_and_expand() and try_to_claim_block(), so
that they are recognized as already-reported.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 227d58dc3de6..1192c4e47da4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1510,6 +1510,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 			      unsigned long pfn, int order, fpi_t fpi)
 {
 	unsigned long end = pfn + (1 << order);
+	bool reported = PageReported(page);
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
@@ -1521,6 +1522,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	do {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
+		if (reported)
+			__SetPageReported(page);
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		pfn += 1 << order;
 		if (pfn == end)
@@ -1699,7 +1702,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype)
+				  int high, int migratetype, bool reported)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1721,6 +1724,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
 		nr_added += size;
+
+		/*
+		 * The parent page has been reported to the host.  The
+		 * sub-pages are part of the same reported block, so mark
+		 * them reported too.  This avoids re-reporting pages that
+		 * the host already knows about.
+		 */
+		if (reported)
+			__SetPageReported(&page[size]);
 	}
 
 	return nr_added;
@@ -1731,9 +1743,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 						int high, int migratetype)
 {
 	int nr_pages = 1 << high;
+	bool was_reported = page_reported(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
-	nr_pages -= expand(zone, page, low, high, migratetype);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2288,10 +2301,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		unsigned int nr_added;
+		bool was_reported = page_reported(page);
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
-		nr_added = expand(zone, page, order, current_order, start_type);
+		nr_added = expand(zone, page, order, current_order, start_type,
+				  was_reported);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

