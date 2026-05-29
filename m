Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9242885D
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068286; cv=none; b=ksRDnv/beTIxs9EntPONEcIKvpoYZ6u0qVr8I88vHM7diAWVu7gPOHjyOKwwbvPYULbATDIe8rEQvC/F6glhJ/mAdUm5GjcTX+EH/o4NBEieUHynFW2X5a4ZpbSiwWaJgj1XuvOCTNUa2G5rtc2PJtuCbcGkZ1fLgwY0QxzEVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068286; c=relaxed/simple;
	bh=5mf25/lf1DdZ8laPTDH+Cdq3xa7RrEIj1yvI/mG2wH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ok2RbMohxUDO6U04kPpz47+8+GjY58b41Mxz66fFiLDj+9GPtzU/ayI07bbCu9T5o4jbXLZJQDKU2xZKOBwn4faIpbGjP5t//kwezC0gEhP2Yd9K3cv/d/I0rPcpGTWxUqNo6WbV/k47pukdMMxKZhRMG76W+ZW5oQlyB7QvSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeMZ31xJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeMZ31xJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19buVa4Rma7mh18uS22QrkEHb5BZSKvMOxe4gXL+M+k=;
	b=TeMZ31xJSGAZJhU0gNOamxyjhpvQ9/h3BpRo9QpEQI2TvWT6Wq3MyGH28MlU54IfD040dy
	xx9t1kFz/vtEgtRpULiFez5rq5lrw6u0vJNkGi7cByKWHX5WWGAJzfTlWLscrlF05fmAZn
	2VAQwfNjDFfHx9Hlfa8B0i5TaUlsH/U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-o50VJz5jMEm64IiXq3q5_g-1; Fri, 29 May 2026 11:24:40 -0400
X-MC-Unique: o50VJz5jMEm64IiXq3q5_g-1
X-Mimecast-MFC-AGG-ID: o50VJz5jMEm64IiXq3q5_g_1780068279
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so193414f8f.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068279; x=1780673079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19buVa4Rma7mh18uS22QrkEHb5BZSKvMOxe4gXL+M+k=;
        b=aOkFgx8Iu0tZrcdzRz0G5koc0Of9MqhNqqlTV0edsTxDPLkYv0W3AuXjvjuyfyQ+oN
         ePw80ePDBua0FzA7EkngkdL/6+InZi7CrJUQujrJipXhKW9fjYUKVpai6xAi0N+/MgKc
         Hig8cThdLY8oS/hzUSm50TsFkoe9Eb7M/LZNhQfeGAmx3Uiohp79hG/3wpPP0q9pFjp1
         SfXzxYmKWKyAvmW2pNcBU/a1Xc8nBTqABtCJ29Hmg46Lk/i1sK/MP1YKKZw5jIOoVADm
         FdHQP+P3q93YN3eeiH+wiDjM3I3eqa521HptYzY5lpAqTXSavlAUJUI0CvnTBPwv+Fa9
         A0cA==
X-Forwarded-Encrypted: i=1; AFNElJ+YHJMDQGNYg4aGPmn0EtOjqfwD9CGgbuyId95ex6/txFFAu9qunMggbsvkAmrcgxzakEkKiz0CRLE0hQDZRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKDyn/BHxSTLctbQhW8xZdbw0F70Gv87zNw8Ny6BV7FhrHQcil
	Gp7qRg07/8PSVc8CfBdFqriDCgfJhyeQ8vZEMPzWw4gcvwHWLQsXukS1Escw+YnDOzwjwZ/h+3o
	yhWGeMDlFj4qI9kfLr+rl6+h2rR/osizRaS3UNCGW+HbEQOprxCL3c3PHvV7abkmGedRd
X-Gm-Gg: Acq92OE5N30HkFtB3LKATGX0L3wxZR8g6kAAmawbQLMX7xpswugY6KjiLrWF+m/UMG7
	PG8JvlXwar1Cy27U06eg15k5QgssJB+ZrkIieSZn2savxRSR77N8vIbbtml0EnhxzgmvR9qyrzH
	AgM4kfYRydanrtU4Yzl9pYxBolnDVDjeL7UuJUBxtsk/TSuyisYCJiMG4EidoY9W03oSs/WsZC+
	aKRbTQ4gYWM6vehisxvaMjx9ONleSn3ZD4/SBRbbshf1/55R74IQ3vgh4O0Kgjjmt3gLGxgCPP5
	gVXg1sL25SrpoIeTE1vgHChVIr1faW3KiqwK4RYgKfOd2VIZH6SzgsblZT/bLZMoaFM7Hywxh6v
	ehg3scxOy2MBDthi0VeTrQ/Ym3j57/do4lhTNFGxawcDiAPvFUGYIXw==
X-Received: by 2002:a05:600c:4e92:b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-490a2900dacmr2026885e9.3.1780068279097;
        Fri, 29 May 2026 08:24:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4e92:b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-490a2900dacmr2026175e9.3.1780068278476;
        Fri, 29 May 2026 08:24:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6975e2sm75803555e9.6.2026.05.29.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:38 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:33 -0400
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
Subject: [PATCH v9 26/37] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <d0cf46d1d56304a1aa3ae46d4698d312978638fe.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: FuKXHiVh_XxKZApj_Yr_EjO08eXFoTZvuwVTMPunrQU_1780068279
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

