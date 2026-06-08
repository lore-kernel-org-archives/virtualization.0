Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C53B14C1
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907811; cv=none; b=lYE3FFWsQQiZeqySarRrVF309U6LZOk9OEAFPNUsgUWdpQmjUd5eLs5kVh1a48gT6uCXhSMkfXiYDVQPFcMCp38xj+4RbiqifdcTW4KRRXRYqLThyS/2vZrOMIeSls9bbAgqrVlYYhkiQu04MBf8Ki6NdcOCN3yHaIiSkjSEjvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907811; c=relaxed/simple;
	bh=pjwppoBrYRW1HQas7rkHTtLdWmdFN3pMjiX+S9iYC1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gXo45WipRxWfTL45GI+vQMuUucr+eySNz71iv81ansXynw/tk8+1s9UGXkWuULsviDtWIoomSHmpUFigIOl6PBuT8LNzm3xkAzyJHkT+lR4Ieao+ybVbKunROsjaoX6+uZ8gvVGbBLe2hNW5fjDTaabMt3OqYoQUIgqGAQufaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVHXuZ1T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVHXuZ1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KJh4wvwDWohkhm2jB8sA/e6an56FCy42Cqcxiv2qXU=;
	b=CVHXuZ1TDnz+lRknG6fLDPpW3ZTrEb6pzF10AnyKhzjT3aqGPAi3D1Xh3Fpmb25jhQKlv9
	7hgbKmDF2l4N5tvbXj4cgDgVEIXlPLXVgNzVYCFCXkRDq3qmCxBnxE8QBFNahrRUtSX8BU
	4SVLju3xjYjMoATC2GEBa508XuMvclw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-DTZwCZukOh6gOj9mEcFb6w-1; Mon, 08 Jun 2026 04:36:39 -0400
X-MC-Unique: DTZwCZukOh6gOj9mEcFb6w-1
X-Mimecast-MFC-AGG-ID: DTZwCZukOh6gOj9mEcFb6w_1780907798
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46010392f89so3680372f8f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907798; x=1781512598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KJh4wvwDWohkhm2jB8sA/e6an56FCy42Cqcxiv2qXU=;
        b=GSIlUAPjhHASObGCddLOjSsPfQAE7s/i7pVDPsyqH+VOYAAxM1iOjjmf1QeeBCpp5L
         OIH8RObOdXfgrsWkBnl5V3kpx5UYdIrH84TZot880+t+Dmy3cSkujlRIyrH/TfDFwCX1
         aiY5RRMDp7G/NkdvdUisTgveE5aCXF3Qu95ZiQ49q5x+80qunnad5RmOZqlyFBIgKQLS
         UiL2rXLEuW1mYH/jKub/L+zGzjjtvw53qC3etnFeBnqI2tlL4TJCubxINc2QWqGNOJAe
         Kl88ng08aIgK+VTxPotGaH6b6rHvNIlHpJ2pl/NXMh9TnHLBruY4wTxR8DVV90cjNr7+
         F0jA==
X-Forwarded-Encrypted: i=1; AFNElJ8aRh2/qY7B37DJ4vZooeWWq4MVRWKp8cO61Fz9JQtVji1TL4XulvlPCLv3CQQAaQV9inP+1V+e3MJkE1qNeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiTVytBuwGr2RdolJz8end4JH++IG80pzBbvhIwpTsLuci9m9K
	HExQ38idVELecWQiI9dRo0vCY52VQjHx2fRbCotjphDzrNpZW2a1ES7+56tefkq8myxvlF23TYO
	LYK8g6oMgnRiQH498bsJkHRUinRXsVZSW+jIq1sQ3xxUcvvR6o3M8BhIM50T0vRuLW1ff
X-Gm-Gg: Acq92OGSSASv0llZ+1gi9Hd24jjFoP2yUraTkwkvz8jBahtB/U/QFaz6R+yiLFMm38K
	bymBp4+2/UCZjpL9gV8ML68Nb2fbYu/r02WN/TjaH/V8maAasyAhR09RkUDUtOI+NBmRNvNLxD2
	ShU+g/ytLTPThnySTSBZgmGfJDinCgJEtHdznvbwTnKJXODgqG4iXJd7Nhcmm8NrdCMfvE3xwt3
	/YF7J7UG1qgDVeCq2OTY9m+a8kq8PD8PS54iFXeJoPpB/aHMGZYSik+f91zHeC7gFML/ovkyl4m
	fbqhPc9+CWlIFb/cEXjNVtqjcddGEgoaRWnLpE51ttFFocoHNg3kYFWr8s0IYKWyBfvceat4b+o
	qsfTb9FE8bFRjJg6vHr9FGPM=
X-Received: by 2002:a5d:658c:0:b0:45d:7bf0:c7d3 with SMTP id ffacd0b85a97d-46030643aa6mr15913828f8f.19.1780907798401;
        Mon, 08 Jun 2026 01:36:38 -0700 (PDT)
X-Received: by 2002:a5d:658c:0:b0:45d:7bf0:c7d3 with SMTP id ffacd0b85a97d-46030643aa6mr15913766f8f.19.1780907797944;
        Mon, 08 Jun 2026 01:36:37 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm50455796f8f.0.2026.06.08.01.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:36:37 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:36:20 -0400
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
Subject: [PATCH v10 11/37] mm: page_alloc: move prep_compound_page before
 post_alloc_hook
Message-ID: <de0433334a7763b81ce8ca8f8a332c800cfe64ed.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FACXh2icc3dVReK9HV0-Hul9g02fsciR3FRcy63EQ-c_1780907798
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move prep_compound_page() before post_alloc_hook() in prep_new_page().

The next patch adds a folio_zero_user() call to post_alloc_hook(),
which uses folio_nr_pages() to determine how many pages to zero.
Without compound metadata set up first, folio_nr_pages() returns 1
for higher-order allocations, so only the first page would be zeroed.

All other operations in post_alloc_hook() (arch_alloc_page, KASAN,
debug, page owner, etc.) use raw page pointers with explicit order
counts and are unaffected by this reordering.

Also reorder compaction_alloc_noprof() for consistency. Compaction
currently passes USER_ADDR_NONE so folio_zero_user() is not called
there, but keeping the same ordering avoids a future tripping hazard.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/compaction.c | 4 ++--
 mm/page_alloc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 72684fe81e83..4336e433c99b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1849,10 +1849,10 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
 		set_page_private(&freepage[size], start_order);
 	}
 	dst = (struct folio *)freepage;
-	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
-	set_page_refcounted(&dst->page);
 	if (order)
 		prep_compound_page(&dst->page, order);
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
+	set_page_refcounted(&dst->page);
 	cc->nr_freepages -= 1 << order;
 	cc->nr_migratepages -= 1 << order;
 	return page_rmappable_folio(&dst->page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0943ab724032..4676fd49819e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1874,11 +1874,11 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 							unsigned int alloc_flags,
 							unsigned long user_addr)
 {
-	post_alloc_hook(page, order, gfp_flags, user_addr);
-
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
 
+	post_alloc_hook(page, order, gfp_flags, user_addr);
+
 	/*
 	 * page is set pfmemalloc when ALLOC_NO_WATERMARKS was necessary to
 	 * allocate the page. The expectation is that the caller is taking
-- 
MST

