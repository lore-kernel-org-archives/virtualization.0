Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49D3BED2D
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490234; cv=none; b=JkECnGvuHTuaGrrlQmxbvWJ9p6e7Zpzx0gKY6ueSqK8DBF0tPwdXfTR9BfY9H7u1y1V6D9ZkiGp6iZ6XOr2zodbDAq1MvIoVY+Oct+Ehnf3WfPHQbg3VOXBLLMs1Ce+eAkWCDS0OGcfWMrzjhCtdDcuf00ZjgkzrfURX3R9aUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490234; c=relaxed/simple;
	bh=NGAOCZ1WWFki8ZjzkCn4xgO9pK8NqvqtlCATI7T+TGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IqqbkO1LHZ3SlFXR5CXjj5hAGHN3Vno7wo3BMd9Eq7rQApYBhlM7R2dig2MeYQtw4MNydC3GVM5cuUswR5q0JivotehpkT5deDSsCbohDCrWKfw3EwtITR0z4dQTy3CeVd7gWyRvv3DqzWFjo1sprd2nQUol0XV5f79xbtNRbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WK+CRUrs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WK+CRUrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ahWBOyIHSf1xwmLBF3en/Ugor1Y2nztY4A6z0DPh0SQ=;
	b=WK+CRUrseA99QuFnBgWmKTwyobarp63BCqrKVfiOMA6XApdqzTDQLbGebV+2w7p8SjLqPv
	ideDgPh09G9D5CElzK/tZNQJBpps47bpRmGehgLZmTgL3lYfLMblM8bUbSFAIP6MlW6lai
	r5iMqg+nDwClIfXBVj8f2HMeR2cVecE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-qcSdd7iFPaOvNPuk2GRs0A-1; Mon, 11 May 2026 05:03:48 -0400
X-MC-Unique: qcSdd7iFPaOvNPuk2GRs0A-1
X-Mimecast-MFC-AGG-ID: qcSdd7iFPaOvNPuk2GRs0A_1778490228
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-449b2a183d3so3011945f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490227; x=1779095027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahWBOyIHSf1xwmLBF3en/Ugor1Y2nztY4A6z0DPh0SQ=;
        b=jWZ2PcBipfXZlawQ69+tyuTEDdRmhV1hhztSbQ28p+3ZG0POKu+IR0bDqzzI+hypzl
         lymW5wL+Y9XO7rXJ8lnjtAqysKiMZDXBugWrlVYP0MUvk/E4LOywqazecYX66ybzOrF/
         3YqWo1CyyQvhOZcOn/1PmnX0Xj2PWRK+sM+F44wM7F4B2V+r2gRa6ifrj8LvPO0bwzL8
         7TKckBI+hcLiDkDC73zeTvzsr9QWyteb1uWJWDWKDeBcn3FwaIt2Oyny5bbWP85F4DkM
         A/qs5nEIFoIJ1bbEgDRXbkhr2+VItMv70RvhvgGdkBDdGc0CvG8lXN5lbOffQejjHUWD
         7C1w==
X-Forwarded-Encrypted: i=1; AFNElJ+XlVNcSuS3hzof9kG38XUO2seG3o7/3I4r5+roS2K1gLXgxS9h17hxbW41h3l5zoKp3NZtoAUbrkBy4P+juQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAJGuj76oHmTFlq/g/7XmLRlb2KEWDhWgH0EdZYgGjHfcgEpvt
	axliwp4RYILE99m2L6aMCvmVkBZ3txpAGqEP089jhBOv92HdrRrE3nHmWBzP/3g6I5iB4l7KsDD
	EPPL1rtrCWTb68pXg0HeIn1bQVy5X4iFmj2koJ18tf29c1irmKxMjm2SbyCv3aXSUeLX8
X-Gm-Gg: Acq92OEaZHtOW9RV4XbG3eHuAPj4vUWNZ90ko30GTSQkN5U98BP1JSmEwF7YeD2M5iU
	n1d/1kdtnJ2/v/l7ySbwukmtJOQk6pcQr3qrl4PQjBBi20yh6/fdjcdXljXniGd4uir2X2bZd6K
	SHMot3dIahuo/1uAJFWDqg2cSVnAx1c5Fa1HPlLwYErd95C+9txCI6ZOqlsPfsO4tasKuTR4/D7
	tuqteGms2GBBEoDq01UyLQqQ0gtvH476hmv6TsgsOE9T5ZhJTwOQeddZe7ZB6Pw2x63S6oG7Y67
	u2psb5at0e2b9Ey0wdFVTlMdKsrQl3aWhAlLhQZGDBHvZQwm1x4hObMOwcI9wyQrsVf4rqyEVwm
	VcDU1ujRFVUdA/i4b315YhXGlU9oDfAIcY0XyZCgs
X-Received: by 2002:a05:6000:270f:b0:453:9897:76aa with SMTP id ffacd0b85a97d-45398977768mr16819440f8f.21.1778490227202;
        Mon, 11 May 2026 02:03:47 -0700 (PDT)
X-Received: by 2002:a05:6000:270f:b0:453:9897:76aa with SMTP id ffacd0b85a97d-45398977768mr16819377f8f.21.1778490226554;
        Mon, 11 May 2026 02:03:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a5b65sm25226099f8f.8.2026.05.11.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:03:46 -0700 (PDT)
Date: Mon, 11 May 2026 05:03:41 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH resend v6 21/30] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <57d30ce615c23d3f3737e38d300f4613b3ebadbc.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rL1t5xbCngiWrZno9XymgRfuX0Veqf7HGmXu71A_oso_1778490228
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Propagate PG_zeroed through buddy splits in page_del_and_expand()
and try_to_claim_block().  When a zeroed high-order page is split
to satisfy a smaller allocation, the sub-pages placed back on the
free lists keep PG_zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d70c9ba6b329..468e8bde7d34 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1712,7 +1712,8 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype, bool reported)
+				  int high, int migratetype, bool reported,
+				  bool zeroed)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1743,6 +1744,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		 */
 		if (reported)
 			__SetPageReported(&page[size]);
+		if (zeroed)
+			__SetPageZeroed(&page[size]);
 	}
 
 	return nr_added;
@@ -1754,10 +1757,12 @@ static __always_inline void page_del_and_expand(struct zone *zone,
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
 
@@ -2335,11 +2340,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
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

