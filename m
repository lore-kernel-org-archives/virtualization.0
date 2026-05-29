Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9063FB06E
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068189; cv=none; b=Sp5dkGCqrWBeVtKQkWU2sVDZXWwou2P2m3cZNgt9pyln2TIeC6oSiGN7S+8olpcbKw/DAqU0DpYkmPp2RVAV8VaNjm3ADUdAYy3nWF8RNUQuKl/0L+NlitFEhQSd1+rnK9Q/ry7waAZlKnUwI6crlGN+9nY1pZYTP8brU9sUDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068189; c=relaxed/simple;
	bh=W8/RgV8YlHoI/N38IUKKZXJPftBVftzLE1J25cjwbi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UUTj+1rBTYcSITTH1GGufcUn0Pl0xBTPO+IPNlYY1fsO/FUoDU1ue43YDEyGuDh5+vsjAqvUw4uwtWhQ9zWrwSRz+0soaW+Mps5wChePcNak5IJYZOFFz5rorHCPLjFlEhU2Q4gN4mbgYnw1yP9CtxKqm6f/8GD1Tuoeaz2buz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QltAKcxg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QltAKcxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjfty6vgLrS4T7uumYbV6HhVn6mEWZk8nuiVgC9VboM=;
	b=QltAKcxgNt533q1q+Z51wHw2Ewwn/ACeC98pd2X3JaM5jIGf6GruON3A3QEiBq95maRkb5
	DAG9hzluSO3vN4i+zo9i57WdOqIWS6vH1z/ce3DBEGnLpPbJWlm1XY2v7uQbbXRzR6fU3J
	Nn4eMq5j10XqaeB1MP2Mjf6WGXCs4jQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-EgT3fZB5OaCshHugqfa95g-1; Fri, 29 May 2026 11:23:05 -0400
X-MC-Unique: EgT3fZB5OaCshHugqfa95g-1
X-Mimecast-MFC-AGG-ID: EgT3fZB5OaCshHugqfa95g_1780068184
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef2bd566bso468340f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068184; x=1780672984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjfty6vgLrS4T7uumYbV6HhVn6mEWZk8nuiVgC9VboM=;
        b=ckYcxPnDa+pgyovNW9WHlWi00DCF3Pju6DcVeZphKXPqvKhlzC+exzwk3CzFGL8qU9
         A5bwhiPyzipXrXAdAv70TPwGSCffbBrgB61N/G1lBoAmgjt0zV36rHbiJC3bIxd+dYY/
         9lLuK1bcID9CAwnoRpRynATifKUEVIMECaPoNLBVEQP/uvp22KjXXeLwHWJCjyjI/rwi
         xFgluzjRbAm8k4TqRafZOlokNhK40T0uYhHyMpb8yUy1S8bhrOA4Hw0U4rP85u9YRQqq
         OxKHrZKfC4Ok9mLw0sH3Vl8FTsp2q1aaFTI7H3RZlk3UeIvhKmictGoVLqcbSUJoR/xZ
         HUXw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ov1nZlc7+aIT1wZacz6tA0zzXIASRBup7tt2E2IPNDKIxqCNm9NtqI+fPmDktsPBZ2Mupsttet8+fG+Xn8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH24XJ8CP236FjdNbYSigG7ZOliOiy/mr9rr3Kjt9Zix5nFHJn
	2cM5vUBB3Thsg8G7xBwQXbaIaXcKL+NNWv4c0ZOu2cgfo/x8cmm4YQ+k0onIXjICkbYPI7nw9Qk
	Csxkiu4kv3DVxXfC2D/jq0mEsG9zKWv5F8rdRBAfFLd0J3jkzR4mdg0qhNjoPztDt1fmA
X-Gm-Gg: Acq92OFlBEj8gYXTNrvjWsyzToZvmVQ3SQTPsRTNSZtGSE7hIMismTDqk+Jsm1dT6nw
	NSHuPgxE1okORcg8S7XJ/ZuZWQ3o3HM1NjKXoTq7nX75WSI6D7JEE9OXaO2bGr6WPu9H7OZmQj/
	LsLUGsE7uNSttXQ9nNQUuPSpucjwDRFx6dcEnJChLMQ6G+HarxY5SbpdbuKiQl6wkfSxCVlXjxI
	A7ihXrLWHv13N1c2jOcrRSvg95g3wxN7KZd9ZTz8wgQ7UTDI39sz0yYIUtx41jQaITnhytTN0Q2
	r13Z5naPjkqpwSHOYhEBMhYYOm3VGMPnIvRA9QuefF7mJ3flHD7hdWDFRIWD9pe0981E804Nmk0
	C1EbW+f3T+1cF2h6GAkT/pfv0g8SX1O85i6Ccadw5Hn0bTLhFBo3jdg==
X-Received: by 2002:a05:6000:1603:b0:45e:82b7:c260 with SMTP id ffacd0b85a97d-45ef6af7a60mr366061f8f.2.1780068184088;
        Fri, 29 May 2026 08:23:04 -0700 (PDT)
X-Received: by 2002:a05:6000:1603:b0:45e:82b7:c260 with SMTP id ffacd0b85a97d-45ef6af7a60mr365980f8f.2.1780068183483;
        Fri, 29 May 2026 08:23:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354c682sm3952557f8f.23.2026.05.29.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:23:02 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:58 -0400
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
Subject: [PATCH v9 11/37] mm: page_alloc: move prep_compound_page before
 post_alloc_hook
Message-ID: <bc9c4eff561153656b7ad247f584dda05ad7c098.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VuHQO3g8Mm8PSDBJY3fQrMMWqsGBi98Vm2cGYQ5JxpE_1780068184
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
index b725a3b59835..3108ac9061ce 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1877,11 +1877,11 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
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

