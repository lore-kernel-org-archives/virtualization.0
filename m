Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5B3C1973
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315773; cv=none; b=AeY9LJAtHC+tXkS4OWqmma9d3Gi60T2v1LRuQF3uxDtFZ19l4PyV0H4j2k5HlPJJcFHzn0ptj2NWxTBuc5fCDDhqAUT49ekZVxU8+4NEsD9lv16B/kma+bINQvmDk90hJ/5GXMvBeXbKWV1g9JwfA0IW+MoSZHhsF+QAwL8i8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315773; c=relaxed/simple;
	bh=5mf25/lf1DdZ8laPTDH+Cdq3xa7RrEIj1yvI/mG2wH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EP8CUShtGitOuBpfypshZDEgBsUTgo186hmLuRA5qLJLdLlaY06+wdfZ+Bai6qjLRsWi/+RpPyAnCVM8A8FtYNzOV2caqqgEdafGx1+usmUKSult4miDupHTfkjpVmARgugjU/0uhgyvB0SDapxnooocaJcxtDT8nlQ9iupMiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0s/s0mN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0s/s0mN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19buVa4Rma7mh18uS22QrkEHb5BZSKvMOxe4gXL+M+k=;
	b=A0s/s0mNsU5e3257f9jBWEdIehKR1/Yd9UY5zabkUgAPLHiIr83hzPQiat67k2vLjlKsoX
	+LsHx2hXmnPaEbLVxB84qYRFGApXiwq8T2kqHhTe5mEettWYfIUQch6zg1+mTq2T1HuUD4
	ZkXXlKEU2qJyR7DEbcxoX26isQV70YU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-lG4DH7MpPS2mJTEu2FEWqA-1; Wed, 20 May 2026 18:22:49 -0400
X-MC-Unique: lG4DH7MpPS2mJTEu2FEWqA-1
X-Mimecast-MFC-AGG-ID: lG4DH7MpPS2mJTEu2FEWqA_1779315768
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso37130555e9.3
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315768; x=1779920568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19buVa4Rma7mh18uS22QrkEHb5BZSKvMOxe4gXL+M+k=;
        b=ooBQRGyorp9SK7GosVSD/CdjwX3MWp3NEdWu9iXlFpDAa56CahqnfsMXhKB0H9rgHy
         I4oCtmUHNpgxIvxo3oAkP7stak/2zs4cMHMb8MMkpdJgiGY5aFiXnGnRJt3KEePIYGM6
         k2D+Id7J4B23k+y7I4O6cOhJQht/9wNTe3uXSG10ihAOR4A3aT0nBoPZyCsIxAve4P+0
         hnNBSfja1plG9z8yMTYpMQ1mBcpb8kcX8CNdOe2JEhDaFIv9F5XdbKEmVv1Sewj7leAj
         XQKXr+tVJF32qMKaoCysGolhF1S8Yka+IcWJFHvN/JSET7qkuoEyGLMr9ulGrDV3oxiT
         9dng==
X-Forwarded-Encrypted: i=1; AFNElJ/hACOkNqU0fTMn5V/e7LktyOANvLnqxnIPjEDCu8RQBRFZ7YK2y47RVqdwMOBKzKQiomAO089KljvaQvzdaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsBm1bSK6e7lvxcUWYftoWFm8npkvEajKxFUoQcQXRpdAFjPXT
	RHrOafemTAU71WCs2S0FUxG9pOwOnQY77dL05xFKur5KX6hh3DqyRjQFREQhwnGVy3mWnMjB991
	4bHHoaGqq2CKoDXvD7iNbR6zDWmzDnpaIu/xBVRLuNxb80fmdJSZk5woTtlz7dfTGqy51
X-Gm-Gg: Acq92OHuoUyPH+WtROcqk24p+Yh/8KLqKTHjzHZOLFV86hLKK4khnrXJpibEEsuQWEK
	Pm+NIWcQ8mfFD+KFqxu2Zb7Uh9hNiB2O3PSUrmCT4+dJR4Sz2TP3biGrCHJmyRXcWb8MIk8XR+X
	0Btjjwac4KoYuhBddRHVHNjsa6KbKFp3BDX+bHwPXtBe4IDIJB2vkrhzuseLtAOZHYLoE+wVwPi
	nDPXcL1XF/eJBD8QxZlPP3CmL78UL2eoGnwCnQFKS01XY1dk4xWM+dWRtIzIojj9qP4YOakyFwH
	gCVYAKj4VFXY54pyqv59ae8ZqM9hjDvAVWZJINw5XEfVh3TyBFEA1jFTk7EbBZqwfcqgIfUaLSx
	sjEPVQv/lS0lMzqmwetGQKRONYs9NuUeqs1VtlZSUGfw=
X-Received: by 2002:a05:600c:c086:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-4903606bb2cmr2183305e9.13.1779315767667;
        Wed, 20 May 2026 15:22:47 -0700 (PDT)
X-Received: by 2002:a05:600c:c086:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-4903606bb2cmr2182985e9.13.1779315767276;
        Wed, 20 May 2026 15:22:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035f52a0dsm1490795e9.24.2026.05.20.15.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:46 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:42 -0400
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
Subject: [PATCH v8 26/37] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <c260659c001161c5630d36a466dcdb293790917e.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 1jyVfNM2Foxo_6qnJLmDZ31QjBOBOGXvDVZcSpDgSL4_1779315768
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Propagate PG_zeroed through buddy splits in page_del_and_expand()
and try_to_claim_block().  When a zeroed high-order page is split
to satisfy a smaller allocation, the sub-pages placed back on the
free lists keep PG_zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ff614e422eec..72e52f049cf0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1715,7 +1715,8 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype, bool reported)
+				  int high, int migratetype, bool reported,
+				  bool zeroed)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1746,6 +1747,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		 */
 		if (reported)
 			__SetPageReported(&page[size]);
+		if (zeroed)
+			__SetPageZeroed(&page[size]);
 	}
 
 	return nr_added;
@@ -1757,10 +1760,12 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 {
 	int nr_pages = 1 << high;
 	bool was_reported = page_reported(page);
+	bool was_zeroed = PageZeroed(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
 
-	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported,
+			   was_zeroed);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2356,11 +2361,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	if (current_order >= pageblock_order) {
 		unsigned int nr_added;
 		bool was_reported = page_reported(page);
+		bool was_zeroed = PageZeroed(page);
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type,
-				  was_reported);
+				  was_reported, was_zeroed);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

