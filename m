Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA73CC33F
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315768; cv=none; b=oTYJkkEAFWFJDnMDSfnaT16J5Pk77oq8yx6Ql8sU0hPNMzZ/kx5bw9Bp3I1zVNmgsfHjTdEgRoopJAI1Mx6X88LWrLUu9V5FozCuIxOb8/LYRVPVK6TzrxoedeKhQOZJF7o1xLAiJO5+x8Vf85qVlJopUoYnsHNFxshLB02i6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315768; c=relaxed/simple;
	bh=c6xJpyp5zpjmRc9jnwYRt4nCMF1SinUlHasxCFwTPkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R9Tx2+VYCY3g6B7FsJTwpYK+8Cj1Z/qbJfSIIAC4oW48xtMZOwY+ZD9wFVL/cpMtdW4YMv75rIdSNrSUASfpLoPQlvK757sm4jVsCg9zrq79iYev8wKRqTMwJN9Kc+NIJam2GS6SGqVRpSb4yYha9tjotu7G2XSBUROIIFBFxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sow1jMbS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sow1jMbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qdOI4mS59hNGv2oV9kd67xyAhp7b5Wts0l8Olu5Azv0=;
	b=Sow1jMbSo7ZN7nO7vn+mmMQV/fXuVtVuJjONeLyxiXsqzoUIuMYQEI9fKVBGtyCPvwgITr
	jBkSo1rRrh33eHgg+kykRQJ9xDUR8VaMFA55e9q9eRCzyIwunRo6BuMjE0n3piAStIz2IO
	iwupDhM4qzdBoOpmAlHNVgapKpe3h3s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-UUaf2j6ENUyvfrPBd8QdLQ-1; Wed, 20 May 2026 18:22:44 -0400
X-MC-Unique: UUaf2j6ENUyvfrPBd8QdLQ-1
X-Mimecast-MFC-AGG-ID: UUaf2j6ENUyvfrPBd8QdLQ_1779315763
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso5149805f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315763; x=1779920563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdOI4mS59hNGv2oV9kd67xyAhp7b5Wts0l8Olu5Azv0=;
        b=T4PENNWegL6r7JfzWGp2dpk7tsQ3UOEs0ipyQVj/XISx9p7FAKSWC03qUpJFRjIsWk
         6q/dct5SIGbympFu6yipAKbh1LIn+PGMJ5KZjLnHxV8w7URXdtVBinv1ToTSwuMG8y6s
         Rb/q7pdjzLTjPmr+IWuR/pUNbdYFDWgId8TkDUUK7BrrAOEOkQ7Z1YF5lN29lP1V+cb9
         w+Ip56VDNZu02aqWikSFgCG6TaKsjgvPgTUVP3qRRu5bU0/71ex/ZRaQxG4t8viJ23aP
         JLDx9O0LJuTuPiAScHITKtfZnZJWE9uVbkQkkv/t5NOxEQlfRXLG9U6YnqzNGTNDOsfY
         H2Lw==
X-Forwarded-Encrypted: i=1; AFNElJ9797R9bN2s5FaFte+c35MOUV5T9k1J8csO4DcssiZ6ucmu9lce3ge5FFI66aZwr7i/NRAjmQr0+qg6+7lMkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjfQg+MaivSO5zBv6e/v4KlPrey5Rhut9DrhWlH7zYyG79zgCw
	aVWqbaYZBmaJTXwDBT7PGG46E810w7NPKNuFgKz8cHwd0GAe+hM2JXo0MvjTS5uatraSXBlkntu
	Xrqa4kTINm0gA1joAQ2m5rLYZUUpzDRomFcexM0BwhFPVTbXvCIbwTyVuYFLTHSbnvAX5
X-Gm-Gg: Acq92OEH1umo9FZjLNv4gz2FZ9EwcyBfdBQFRsvCERZcIlKe7MRj61rbe3ERRBA3iH7
	BHgSkwfkQqOiWtZtXaPkvgMimhi+uKlovRmGrPwnaOGti1WQSW17YDCoOtmljQ7kRkaKqjHOOh5
	sZ1bonigaW05O1ZeMnfPxP+BdHHMQkuplBDJspBMYptxGBQ67JyNxqTkpYFra01M9083zVzRq4w
	3Y5x3M/v4MgwjQSREBw0y+Rs9Z8u8bwd4qRBB9dEpyDqfCp9OKXl5wvL0y27Fh3NUhQMMCG7CvU
	ZbUeDJDkTnMLTEJOFSbgEwA3sRjPok6VD3Nv6UaiAatLOq60FDDsI+WApg5mj14eEZCtTWqdITJ
	xk6GaS6fml3UuzfhOLSDaAwBxcF+Nz4dInxgIWy6Bx6YEnEA3/3kyPQ==
X-Received: by 2002:a5d:5e92:0:b0:456:15fa:9eba with SMTP id ffacd0b85a97d-45ea3df6cebmr217157f8f.43.1779315762674;
        Wed, 20 May 2026 15:22:42 -0700 (PDT)
X-Received: by 2002:a5d:5e92:0:b0:456:15fa:9eba with SMTP id ffacd0b85a97d-45ea3df6cebmr217100f8f.43.1779315762157;
        Wed, 20 May 2026 15:22:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9adc2209sm54072453f8f.0.2026.05.20.15.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:41 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:36 -0400
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
Subject: [PATCH v8 25/37] mm: page_alloc: clear PG_zeroed on buddy merge if
 not both zero
Message-ID: <68d88e8d227865ec4f8513d47bdbe06d0482851a.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ZYer3ZEXk_xyB6xhr8lMxZSyfQ9-gzWLInelWwZxpQU_1779315763
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

