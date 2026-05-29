Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57B367B70
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068146; cv=none; b=HyiMLM5n/ZjJYE/zD9FoFCJizL7v6+ZnJpBuZv2pzCFW2Gu6dqUZtAQhtEt0DRcBNLOsNl22lP2AIr9s6/S1MbsIJjIQb4YOJUz2ti3lexnPdFTxflhq88VHoquMk0J4pjufS505QBZoLts2Io1EQIPSq4iMNFFTsLN74MOKj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068146; c=relaxed/simple;
	bh=2SCjG0p+gTn8qm5MHLYDPQz8gTh6+lwWx6Kgl/LoFJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FOQo8chqNAdpivYrGMuyAHrSqyYZNu46iG6TF7mg6+PnvDfeDF0OYzuAhWqruia0zasxM7dFCS2txjFcDbkIV7dCBn5k6qoTR6erk0uvs5NXWimoRu1PeN/KbEo0izcLFj+SSqbbSqAIE83qrfWYiTxS59Ojfj/v1Na/WtnnMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvdAz3Yy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvdAz3Yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a9U/grsiUVqQvDGNE/rE2t/3gE4VHHRcC3EwM49fXU=;
	b=bvdAz3Yy2b+2L7ZCUqVryV/aByeZ7IZimErgqW0dBKXHkJcdPTG+ol/RWC6HFRb/v/XeZX
	0ZzAYlYPhL0qgbMCDNtbDT2wPYb4nh3FaRtOb/vT7maP60ztWN7oHIP0xs9QiB8ZshEnbX
	Wj84L/lLz6co04H9wCro/wtpFCkfHKo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-TGcy2VjPMDCtUG6zA6b4RQ-1; Fri, 29 May 2026 11:22:23 -0400
X-MC-Unique: TGcy2VjPMDCtUG6zA6b4RQ-1
X-Mimecast-MFC-AGG-ID: TGcy2VjPMDCtUG6zA6b4RQ_1780068142
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6b407b4so32898f8f.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068142; x=1780672942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a9U/grsiUVqQvDGNE/rE2t/3gE4VHHRcC3EwM49fXU=;
        b=NXnQetuORs/rNqZYCQD3/U4Fg9Ge5DB2YYP4hEpNYaHTAwErtVctNw04uYyMEJa2eo
         cx9GgCt0EDpnOEC3xgqeggCfwoeBGm0Y7k4SMhdMOM9a55yEwAWtm0b+8K0z/HEEkoZh
         CEJY4XLOAbJjylRxxa6sI2o2fKTvRlbZjUzC2OkVszzbDY4qpg2/H5+bh3uURiaIPWnD
         IpogNBgBpDJ6/2IETsw/Al0eo1VHn7x1jDdiK67za4jy4GNDAIKthg5oxmp0j0BCzTqj
         HMqbhuEPCNQRDuvaHDKvySVSiYB6fugi2SazsfbD3ZGCTvossOKsBcZm7zvK6+Mhlsdb
         J9AA==
X-Forwarded-Encrypted: i=1; AFNElJ9E7M2S64smyHi+a5o6EfGASvINGzIvVznXNVteceosFTkBfVdT7fUSqYShVJhz4mY6Vu0jRisTTvVIm5/01w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk7ap/qmOh/Lr1AFxl2mVmX9d9eP8I6HRiDiaB9dknt39Rllvl
	mYT3rzOmOzKxum6erEtBLmRz4haFu2IBBKtSPr39/I8L+J6z0H5/X2fQ5oG7OF0BwTI4xRHsOeh
	xP010WAvQHpbo5900QKdOELsX2HNOUm9oZhLJ8bwxQ8F0po8Yu0pPFkT9F1inlmyzA2uI
X-Gm-Gg: Acq92OEtJSCaIAvxjS/vw9G5PXC0SF3MhBbXfghzuaD2klKic6ssQTS8VD8CBTlgHqb
	qi6hfP5F7H8YLfi5CYSO8pd22wCoyQfRCWWL1IEsBTnikt9sL5+L8DJEgHF04gTkwlWWVuuqtpp
	LecAjVroQaqm8LQSSbEeKITqmOzH8Bqo/TCJ3QkzA25Zzt/u4QB1x4JIHeqHnlzPoNHQzMBbAXs
	815rX7XBljRS5670MlQB8HwSxjkhSH36Bf9a1CzXb6khdW8hRZ4auBhx5cq4yPlp2QgMx4mLO2s
	ktiRvLc0+ktA9VAaIA7bkviefSVwtS4dBKR9it+xYXAUJCscPARe66MEI4zs74kNa7/+gj2V7ef
	mEhzQgMMsGVFY+kRfDpyvRo4Lz3FXr5kpMGAXrw7Ty/dk/hZhVQpfJQ==
X-Received: by 2002:adf:f2cf:0:b0:45e:f672:40fb with SMTP id ffacd0b85a97d-45ef6b4f72bmr394853f8f.22.1780068141733;
        Fri, 29 May 2026 08:22:21 -0700 (PDT)
X-Received: by 2002:adf:f2cf:0:b0:45e:f672:40fb with SMTP id ffacd0b85a97d-45ef6b4f72bmr394796f8f.22.1780068141211;
        Fri, 29 May 2026 08:22:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd87sm3989750f8f.24.2026.05.29.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:20 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:16 -0400
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
Subject: [PATCH v9 03/37] mm: page_alloc: propagate PageReported flag across
 buddy splits
Message-ID: <35539ca539f76bec575e8a6abc0cf42add858c0f.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yPnzdx91SX2PJP9uIuXU4r1vmhiaW04MSdWdTkJlbsc_1780068142
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

