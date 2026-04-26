Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE6303C83
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240107; cv=none; b=afhzfSHBp6Pxjy01+KgsTrYHu0YpS9i8YH5SLKqkmRfWEZRhh5TkAxkpOid97aDAr4dL3Y03n/Hzwur1IudduftIdxJgaeMNpNWN7nXjf3selFKWkxGhXLnGKJV4K9YSVSbCiGGYS8qKjpD3TmOSdlS7e9jVPoS6l+r9zd95GCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240107; c=relaxed/simple;
	bh=GQIxt3426GlDeqT1vnTp0KvfVXzR4vpnMpFfUxs113g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MHY5/mth1GDSkNm5wUcK8YCa1xIy6uGmhfV7peQoM9cV0U5l4IIVXLUszlqHcwUvUrAWc2Mrh7R3LE3H2iIDCTPqGyp0DZGgb+KFxHu+I9LSNLxiYpp+rqyWmHz4+t4bqQHsN+VJSIuaMVPjIg95MDyocBFVRiidwTFiaHSalPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WC3Cw5uB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC3Cw5uB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iX7QlDEIRvMq/lhdobB75J6k8cJUQBTaq/dVJzKRSYI=;
	b=WC3Cw5uBo3HFGVPImiwsIktgHhwArlKdGK5QT+D6y7ogEu7XY+OwZJK/lsesFnTVqSyOHL
	mqGFpwlfehXy8qEMwKvT+A7oZZmqL32hlKmB6TBTLvGPKExpfbrpAV+t2r8V9PhcxIFO7H
	HUiTr8oYx/65LSAzybHNbysxO7lCefc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-0QJ14E4jOmu1ylwq3Buehg-1; Sun, 26 Apr 2026 17:48:23 -0400
X-MC-Unique: 0QJ14E4jOmu1ylwq3Buehg-1
X-Mimecast-MFC-AGG-ID: 0QJ14E4jOmu1ylwq3Buehg_1777240102
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a2c034fso5432703f8f.3
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240102; x=1777844902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX7QlDEIRvMq/lhdobB75J6k8cJUQBTaq/dVJzKRSYI=;
        b=LNWPHnZG0FxlMx67yThWReJlscJVCPgTvl5WRTFHKHEjSlPIU6ka+NxHULFq96KE81
         feJaRpGB6kRydG42Q7W2j/ldvx9AtO0Oxb7qspUXatx/tb3O85hzN5pAc2dEYiNYNvOj
         C7ZafjvZ1Xsy/MtgBkDrpMMHP7cAdyMb1F+YTYCNxQ/XywBU9Pc9YCBXyyU91yBv1ggi
         RoZzgAM8Mye7CEKOSvvQTW41ZYPEr+AMmIzbMQBhXJVi00V/w32bGCO6R/5o5x6LzeHM
         Gt93aYUduorAHf66j1fPeHjsHztuqFkZ1eGL3aX4u8amb19VwfZwyWkbWxW0i+g0XWXc
         KULA==
X-Forwarded-Encrypted: i=1; AFNElJ9Uw92hAz/P/f8RwvordZ0VsbRTYXO9DSUFE5hU+i+Svxn7tV3HrKpqrFGOsYgoHU3WGg9MTC9DNatiI0qsZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw9rmEpalUFpDEmAcgwJDvq7RVN0fidtVR9LV1NGziWoG6MueS
	8OpNVW0UyVv1kqA7FMFEU1I4gacUJCDN8ouppsMRZgahH3eMpiSjQZKFUkcvM4lT2ZNO6qbLatX
	EnFlp36TXtwnVeuVmfzgc79N3cg6Ah+TziJUhp+tgJqXD1DLndiN4Uq4lA8CInKSOj5Il
X-Gm-Gg: AeBDieu9WqxXg/JazML1WCkq8pP5iVtgoZwIAv1t8Y9tKKP/ODi5Vrykb8efkDTZZB7
	9x/WfLTeVzPT0FLgHPlYFTC6pHmtzyibjE5s7uHsStezkUhJo1+o4j3Kxv6qeU9U1Rcou9Ycl2Q
	eigiq2SnNkVu1wU3TLcPGquSMDYbWjGz3xdjrpx5HuwooYcTUN6+qxagmZ1iqMkQPknkXlhEwyY
	G0I4NAI4HHSiy6z7I8JpJgffAgLnPZNyy1Ta7qLrv3TLHltEP0hoKvaWAdveVe+813eEshKByAu
	zvBJT11DF4m1KwP18Q5aoCaaXnOPhs2Fg8AraDLdSsSH+GeT4vUu2m3sjkT0kgieQIkDnkPiF1u
	2c58BM7XPLWV4DW8d+SIK7FidS1pOZ9NU+BlSeKOn9t4VbYeynBepyoSJ
X-Received: by 2002:a05:6000:420a:b0:43c:4810:dc4a with SMTP id ffacd0b85a97d-43fe3e14f81mr62740564f8f.38.1777240102262;
        Sun, 26 Apr 2026 14:48:22 -0700 (PDT)
X-Received: by 2002:a05:6000:420a:b0:43c:4810:dc4a with SMTP id ffacd0b85a97d-43fe3e14f81mr62740532f8f.38.1777240101794;
        Sun, 26 Apr 2026 14:48:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm76656472f8f.12.2026.04.26.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:21 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v4 15/22] mm: page_alloc: clear PG_zeroed on buddy merge
 if not both zero
Message-ID: <cf13854ffba899df37f25e9dca05c6ed9efc1a64.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WYEHJzppSr3xjAfjmNp75BscfpvmAYWzHwkvCd8ZkKw_1777240102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When two buddy pages merge in __free_one_page(), preserve
PG_zeroed on the merged page only if both buddies have the
flag set.  Otherwise clear it.

Without this, a zeroed page (freed via free_frozen_pages_zeroed
from balloon deflate) could merge with a non-zero buddy.  The merged
page would inherit PG_zeroed, and a later __GFP_ZERO allocation
would skip zeroing stale data in the non-zero half.

The page reporting path is not affected: it sets PG_zeroed during
allocation (page_del_and_expand), not on free list pages.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eff01a819744..1183ef3e91c9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -984,10 +984,14 @@ static inline void __free_one_page(struct page *page,
 	unsigned long buddy_pfn = 0;
 	unsigned long combined_pfn;
 	struct page *buddy;
+	bool buddy_zeroed;
+	bool page_zeroed;
 	bool to_tail;
 
 	VM_BUG_ON(!zone_is_initialized(zone));
-	VM_BUG_ON_PAGE(page->flags.f & PAGE_FLAGS_CHECK_AT_PREP, page);
+	/* PG_zeroed (aliased to PG_private) is valid on free-list pages */
+	VM_BUG_ON_PAGE(page->flags.f &
+		       (PAGE_FLAGS_CHECK_AT_PREP & ~__PG_ZEROED), page);
 
 	VM_BUG_ON(migratetype == -1);
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
@@ -1022,6 +1026,8 @@ static inline void __free_one_page(struct page *page,
 				goto done_merging;
 		}
 
+		buddy_zeroed = PageZeroed(buddy);
+
 		/*
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
@@ -1040,10 +1046,17 @@ static inline void __free_one_page(struct page *page,
 			change_pageblock_range(buddy, order, migratetype);
 		}
 
+		page_zeroed = PageZeroed(page);
+		__ClearPageZeroed(page);
+		__ClearPageZeroed(buddy);
+
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
 		order++;
+
+		if (page_zeroed && buddy_zeroed)
+			__SetPageZeroed(page);
 	}
 
 done_merging:
-- 
MST

