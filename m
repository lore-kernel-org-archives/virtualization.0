Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63E03B4E9D
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907906; cv=none; b=s0cH2CmIMykOffk0vZo58ySomqIKLjToRyMW0qK1rEFW+5JkQY7Fg6QSAn1D85TMd0gn6LGo4nJRm5mX/mIPn2ullAN7CdMekpNo+3ZD2SWxkzDdMc/xC23H605WprCNLp5brxGk4U0JPQ/HNHdYmYZrGvyaedq8h+jUVpVgF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907906; c=relaxed/simple;
	bh=BXaZfFdflynFOGogrQYYCO11NJz9qF4gKEWS8jDZf8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hi9me1VlDGGgYp9p66OwmSVQPBtc0VujTgE5azCX3qNhOgdVXe37LxHuV7DPfJcanF2R1fkLEjGoyKlruMHRPOdwfLCmZMwhkWq26ydhJkhUHBqNqO06Q41NNaz5RNg4HidZK9piu25YhsDtipDLOTaE89bxW5jmQU4c9hY0B/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNLDxEM9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNLDxEM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwQyRM0soCCwqjRtQ3TNBnEtxbXipQm56goEaNWxWT0=;
	b=jNLDxEM9+fGjAE1KygVL0khmDQO9BJwOhZG5mLZgO843lISsZYppMX1l4riL+BG8BForRf
	hu1vpIJyiviPqoTj1F6bYOqxpGBk+t/wVZ6lpzqaY22MQaOAC4niBDXjDI6HJO7ZbIWLS/
	7TASlFtnp52S/lW2Zsb2lZpbQpvRRFo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-rxyLbVpwPROW7ot1YKLhhA-1; Mon, 08 Jun 2026 04:38:17 -0400
X-MC-Unique: rxyLbVpwPROW7ot1YKLhhA-1
X-Mimecast-MFC-AGG-ID: rxyLbVpwPROW7ot1YKLhhA_1780907896
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46010392f89so3681634f8f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907896; x=1781512696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwQyRM0soCCwqjRtQ3TNBnEtxbXipQm56goEaNWxWT0=;
        b=Crc2px6Ms/z8mbRQq7hI++j6uzQd6bdQ/EDMebAfszShgjia0Fk6dkVx0e0E4RFXTN
         h0RnOIcMz0kxkSzIhLhLYRmxzFXNlpq9k/DQJRSC2E6QoxXG58LScHuws20QzUig3XDf
         4g4HhNyF2qWsSNeelU3zbRNEiM1QOuIi1fvIUgI7i/oZFuo3+KHQ7VVLvQc+CtJvGsvD
         INnaLc1XDEDSZXPdey8F0A+j0vtkkLYQ2gloo6Fw1HCNZQ3X4LmxG+2XZrgjvtlE55v0
         4o3RnH5cxuDiNimGZouF5r+dMFPbS38G1S7wYOO1NDI6SuzrGQPlf+quMYxByDNuSbB1
         s0tg==
X-Forwarded-Encrypted: i=1; AFNElJ8G3eQyeZ7YWmmgo2pYan64y+P9Eax0DEpUcAzIU0OZ5ohfa1YHvVy/yq1Lp6Xyf7DZfp4t9arhiQUt2OzaGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkoRXzrozmatlDO/HjvUxOSQXh8+OT0e5v0SKMRHjAbA0HOKOA
	cHUH2FhExJPZ0IDv8oAiSYWQ/7n24PSsMA84l2DVzLbTfuW6GMXCahM349HTOWsrh9s09VNGkN0
	VZWQoCO1D8mnBLU284R6THePku4iArJ5req0N2o0sI6uAMUpfT94vRohrfB9U4HUZA5Pv
X-Gm-Gg: Acq92OHJac4Yjy5TRgUQE4ArYyjYlxibxwMctASHVcdMvr4A6GQQDRDQLBYqnxMx3F2
	HYoPq3otsq/TS6xHZSnwKUcaaJNuQeHQFEdGiDC2kbbFx27UeJHTL1gmr8ILyWtqYJR1c9gYSP+
	h9J+ilpPzgeQ8CSMK2XHMSuZzgMCImpHS12V9hPtp5ASUU8Q9FYQxDR8de2rlkzPUwN/YMD8SN3
	iafXrhuirVvKKoL2rXp4YzU9ROEqGOBVPAj2W8dx5lkGhujbfz0G2qpvq7PAuXWhTb7sWBgUHNN
	gH3EBi89vXe+iGp44uTElyt/rOsLecIz/tc+3i7K4ebFCHvaG57maipMo5FJst0cV5vVVCjeZhC
	iHgGW1h1H9C1DdXsYFffHpNw=
X-Received: by 2002:a5d:624a:0:b0:452:3677:3fb3 with SMTP id ffacd0b85a97d-460304ebbe1mr15950832f8f.1.1780907896405;
        Mon, 08 Jun 2026 01:38:16 -0700 (PDT)
X-Received: by 2002:a5d:624a:0:b0:452:3677:3fb3 with SMTP id ffacd0b85a97d-460304ebbe1mr15950779f8f.1.1780907895867;
        Mon, 08 Jun 2026 01:38:15 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm47271286f8f.22.2026.06.08.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:38:15 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:38:08 -0400
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
Subject: [PATCH v10 19/37] mm: page_alloc: clear PG_zeroed on buddy merge if
 not both zero
Message-ID: <918897302a4cab9f476625adc238ec65a688d1d7.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: _rtop8ti6NvVnIiVPHruqgUTzO3BMohU4WIWwuMVnuc_1780907896
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
index 91f8ddb1d512..9365d59ac1d6 100644
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
index edfc83571985..a90bca5317c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -941,10 +941,14 @@ static inline void __free_one_page(struct page *page,
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
@@ -979,6 +983,8 @@ static inline void __free_one_page(struct page *page,
 				goto done_merging;
 		}
 
+		buddy_zeroed = PageZeroed(buddy);
+
 		/*
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
@@ -997,10 +1003,17 @@ static inline void __free_one_page(struct page *page,
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

