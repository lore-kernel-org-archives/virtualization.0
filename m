Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779A3CAE9E
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620035; cv=none; b=kLbyw26UnhyeLRtyA+eLVlkfF8eZAarlEsLSt/8xVfX/iM4nged+hsDvDU8/S9RqSx2kWSr9MbwSe2GV7EX6oIcZnuBCIl1JEQEcGQ8CKOQ1EINHzUF29md2xkHwU3JHfPjqxRLmmYvfz0VIAWC1ruYpYSwo6t8WoSvMQlzWNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620035; c=relaxed/simple;
	bh=Noe25cYGU37yEnBN/uCs4h0K5JHYLW0DyCxvIEDnqFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uZDg/lVW2rx5Ett7R4v/Aaikk+92F3Kf2TN3/0zjhGUw9GkSYdwr0Bbqd8v/mMG2W0PzgCwUrjXQAhOwsWcyBrazn0PjG84JBo7HZfkPLGdSyVrc4eUHeH7yS78zUdE53+t1EqFAS+Yw/4KNei9FQoggvEELmoiE6TgTqyRauWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+EGiJ7W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+EGiJ7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KozvVjbx/oxts5t0d1Kf0c1bCJ+8LaI82XbCSjPbc9g=;
	b=X+EGiJ7WTExI5/+oORAb3hnWDgNevVCzUpVAhXtSPr5ibhjIobNxEa0Mdx+16SWSuEoI4s
	pbbyMuy8uyXmgOLvsOc5uipGyks1h7LFNAy/E/LTjflHe4UtmyZlTXDDYXpQyfQDEokwb5
	fWAK1jCdAs0g3/D61Xtpgn+dMk/8nK4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-icTP6heNPE-som1ChmbtVQ-1; Tue, 12 May 2026 17:07:11 -0400
X-MC-Unique: icTP6heNPE-som1ChmbtVQ-1
X-Mimecast-MFC-AGG-ID: icTP6heNPE-som1ChmbtVQ_1778620031
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44b2b38648eso4718533f8f.3
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620030; x=1779224830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KozvVjbx/oxts5t0d1Kf0c1bCJ+8LaI82XbCSjPbc9g=;
        b=CbgDUb0+6jHV4nodG7520EMCKkKmsjgyxIv0KKgcvZWYOE0TblHor4VR8ov1W4+cgj
         7/8y+jof5+ld4Wgob7NhAS8DJRCMwdHYsvuI1VZscxoapisGRdlBeTsxHs4QVw3rR5Aq
         ZzsqEQ+Q6j65YPeXPDORDkAWhhDV+ZrpvY/9DKx87A+ju/bl0Er3BLWyWczGQmEwGjoI
         1nYDLduHM88wqg7JHlMSN4/xrcdiaXT8gehlz02CrEjsfEjub5WEu+KTql8mnG2IkuRy
         iCBwfmW3icyparHgD+cnuw7xcAReG3slNE+qOQpn7u77xKgJhbxvdukxm03Kc7X63xyu
         dAoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FqfvYxdlYvHg6d6es/+4OfSMxMVI3CXDMCnLpnCY+0mYLX+yys8DR7DJmpYH6D7CT086ADkR7+f5K0zmX4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHdZUcE33mGkYkjvMu83Zq3KUrEi0GGCRG6WvUGKMny7JKgemI
	DGbgjVpg6axupMLZTPSN1Hxh82wM7d00YNMzru8y3inPQVvrAPDC6VwR4LfrBCSZJ9who+8wUD/
	xYG2KuiCzDkJiaJvV7c8HOowCk5MqtyKatByl8djpRu81aVymHEdWDDg8YUVeCUhmHmQ5
X-Gm-Gg: Acq92OHzZCMSmhFHr4y2gOzcIVPPcGk0Ddj4rb9lH6YIdhwyEa3eeiY3USf0YUtDFBu
	aIeycdrg5dfz3YIG2pc8abu67LoB3oguN6f36gMYq+/PB/uTfagJ24bm4GxCnkUClm2Tb/ulDnl
	eXPkw14t+kFPFc6jZjq+GRvXpRPaA0429V6Y92LBfkmISqQXcDRYKJQfMhBLDyCiYW8TNKL0fe+
	saMz/GH+wdBd+1ZNxSVEslPYA2SGBrkNjNNA8TiVbjxHLvgWfovWhATdCSE7APyymVgzLHcsf4A
	Dj895ADLShJv+d6Wb4LtpM2ACZ59U/3YOIqkYAf9ZmyfGXW8Lyc3UggWE89BIMujiE0SJbWDoOb
	EwnrR9v1uz2/pUAuM1iuTiLTiktJAkafwSHrpTTDs
X-Received: by 2002:a05:6000:4021:b0:43d:77e1:6a69 with SMTP id ffacd0b85a97d-45c5a6894fbmr498483f8f.38.1778620030391;
        Tue, 12 May 2026 14:07:10 -0700 (PDT)
X-Received: by 2002:a05:6000:4021:b0:43d:77e1:6a69 with SMTP id ffacd0b85a97d-45c5a6894fbmr498437f8f.38.1778620029903;
        Tue, 12 May 2026 14:07:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm34970009f8f.34.2026.05.12.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:09 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:05 -0400
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
Subject: [PATCH v7 22/31] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hmLhfGHBmVHwM_bK3f2_UA6ItJ8YhqzhxbpUyAK0iwU_1778620031
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

