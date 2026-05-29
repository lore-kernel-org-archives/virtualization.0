Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7A3F4DE7
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068293; cv=none; b=pb2mW1Nc0FHvwlZZMji1QIzPLe/6ID7oU/Cpgh0viWg2XqNLxXK959KpbCKHz986nuFAs7xSw3T3YyhGttwMS2esNb6+DMk9ACs9pMf0AJp5WCHpGg0+m5y+/8NHYopEM01JtTWZMXxmhtXw1lMJa5VZVVFMSQKgdaTDQNwjwaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068293; c=relaxed/simple;
	bh=c6xJpyp5zpjmRc9jnwYRt4nCMF1SinUlHasxCFwTPkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WzHQQwSxC7reVbvi89xsbkxbcNgvhg7ttfz0BhhmJ/T8F3Wjf2EKVClN3aoVqUN0W+jm7fXAQHBUjPZqMq3Q6rGcNBhsNZsDf+WdOxyo+hgP+86316lcWEnBQwbrnfoLxJNtgIIuy6lWKM6wVV3tVA24XFpXOTEgmUFsVyfXInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXTDOiT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXTDOiT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdOI4mS59hNGv2oV9kd67xyAhp7b5Wts0l8Olu5Azv0=;
	b=CXTDOiT7Ts8xzXJuLXtogoL2hgrxFw1uEWTYRn8uARYiq2sdJq8wpSdf4cmnaKLzSPDlx6
	oMlO1NL3qnOZgYHFlt8wyUVHAfxolWxhY8dSpgcYewJAqZ2jRqT7S6nCKKujTohiBaHfEV
	6UvWE+PJNlklPCEV5AD+NcgQKJWC9V4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-E_FfpTSwMduWySiq4qW0xQ-1; Fri, 29 May 2026 11:24:35 -0400
X-MC-Unique: E_FfpTSwMduWySiq4qW0xQ-1
X-Mimecast-MFC-AGG-ID: E_FfpTSwMduWySiq4qW0xQ_1780068274
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef6b407b4so34056f8f.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068274; x=1780673074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdOI4mS59hNGv2oV9kd67xyAhp7b5Wts0l8Olu5Azv0=;
        b=hobHMnWd8ycc6DjDRf3t0BN7SzdJrwHsQFX8pU+y2c5UVmRVnHs3xwilPZ9EHgAM0j
         y9AzokM0ENXIDTjlqkcgku7U6NBT4GSl5fJYgmNOZd7UYceUqRy3UGYCtUYTEUlukkzC
         mbIFWWE+U2LxYJEbRT+5Y//4LQG/uh2kMJEFH8avCoTsEnV/h2M9sJNtVLZdZ8g/M7VN
         lFCgmyYQyeXpd4aZcBCqZC9mSYRc371KtAKs6h00x746ZXgPIn1fClwQOdpIp42aT/IV
         oVfNMwK4ycMzprj4hhmh2ErHDTTpQJcm5dSNRyX3tUa/86LXaa1aiUu8lXmAgC1XmiaT
         BXyA==
X-Forwarded-Encrypted: i=1; AFNElJ+GF0FJK081fH17GaluAzzI+CECNvTUqLzscy/TrE+H8OUXYYtAqQ2vME2THcECuhAEJMQ8zolwmt6vn7gd0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqsf92fyRaxYYlsjByhUdRHVktHMYwz2hNWibvhb5Cazzrl00m
	+6WwA/q4koRgBwgQlPTMPys9NNLVyftASJ5vQreEZa/OhKXqE1AvXPQCUTL+dU0aeaClOCu8KnM
	k08aih5iy/n9zGqSuA5iPOpxQ947Ud9lENtIvNwae6t1GqTSHV63KMKJ+xXg/0mvlORQ6
X-Gm-Gg: Acq92OFHbfJnMMyWis6X/24mfgGIRXyBWgjwXmwfS+t5YnM+L1WBXfN+1h3FHiFFSO1
	pipr/5u5WXGm7TsGxghsjpokXlfF2YGWWHaThVzmWZIBJNAWlIA6rZBXjZ/MVHUqEX0xlpzJddG
	OvJmAz2IJ/EZdxFCqHY7Hn6CR8ERJutScTAZizYn+WV4Y42PWnjSdhrVNdj6QruhKvDE56dYCe8
	dTKHI44bWroaAySA8Ni2vHfxCChKcDQQ9PR4D80/VsKe3IVKesXencAW+2uynxn4S5wIyMPXTNn
	EteZIVFDdbPNdJRvy2m860TjmczU9SZwbv8nhWr3Ay3/Idi0rmOElc6UJLm7/H+3zO85nH8Cpny
	o8sYryjWvUDFTfNGu04+6kPxeQX7YzovWF/fX0q43L4jlHFr1zjFCwA==
X-Received: by 2002:a05:600c:1988:b0:490:845e:3a6 with SMTP id 5b1f17b1804b1-490a295013bmr1065415e9.25.1780068273970;
        Fri, 29 May 2026 08:24:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1988:b0:490:845e:3a6 with SMTP id 5b1f17b1804b1-490a295013bmr1064315e9.25.1780068273271;
        Fri, 29 May 2026 08:24:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0674sm3959493f8f.8.2026.05.29.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:32 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:28 -0400
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
Subject: [PATCH v9 25/37] mm: page_alloc: clear PG_zeroed on buddy merge if
 not both zero
Message-ID: <c022faf4f5516d8d630bb2801ecf482c09ae5199.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: tfqRhPTGT4FqMeGxy9Da46v41MP2cVTXRaLyHH4nDDY_1780068274
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When two buddy pages merge in __free_one_page(), preserve
PG_zeroed on the merged page only if both buddies have the
flag set.  Otherwise clear it.

The merged page would inherit PG_zeroed, and a later __GFP_ZERO
allocation would skip zeroing stale data in the non-zero half.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/page-flags.h |  1 +
 mm/page_alloc.c            | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4ee64134acc3..ff0b192b38e5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -680,6 +680,7 @@ FOLIO_FLAG_FALSE(idle)
  * uses this to skip redundant zeroing in post_alloc_hook().
  */
 __PAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
+CLEARPAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
 #define __PG_ZEROED (1UL << PG_zeroed)
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4cb7e779a6c5..ff614e422eec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -940,10 +940,14 @@ static inline void __free_one_page(struct page *page,
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
@@ -978,6 +982,8 @@ static inline void __free_one_page(struct page *page,
 				goto done_merging;
 		}
 
+		buddy_zeroed = PageZeroed(buddy);
+
 		/*
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
@@ -996,10 +1002,17 @@ static inline void __free_one_page(struct page *page,
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

