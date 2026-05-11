Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0C3C3BE8
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490266; cv=none; b=oa0eRar0DLySNFE//Khli85r+ZW96drFmwbknhUIHcdyfluHMUSyIkr9RxNmd6lhIE+YeHiYIdWbM2fUptem1IN0EgyJV8IMVn0nXSd0PwQ2oT1ZcWNwWEwt0SSffiGRv22OCRvQKD3H18oOmFWxzdT6Hh5K2dTSuW6l/quHpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490266; c=relaxed/simple;
	bh=+KuiJeJuJLSkbIBerUOZ9dDZIAZp2qPNKBgWnFOfNwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jZV9t6CgVhaJDdNR/k6QuCuJ1V0jyZauPv4Vu4aCXFWS1qOpNtffmZBmePPiy/RfX96QpT1zAO1bUcwFiWqkB2/jyjNFH1o4/DYU+fujwyske9L+EwhgGQmgq9P6dDaPwjFeeCNKJHCu35esicgUXoUtgcpssAHKNeiYBhWhagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fv3ErxYt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fv3ErxYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tewXfhJCZs85isDfaCarY9OYs1rdE/frw9lqrB10rtM=;
	b=Fv3ErxYtD0GDt7VnySnknWk6cLgoWBn1l9x7uugoSOUY6D3/DghnviFIQQkFa23kA9GE9C
	VZJEGPdfCUhTOohns7+XfP56MyRelqUeBd6UyA/V1yPIoczgH6HLlamY/T5zp0Enmj7bv4
	pmpGWyh6atfk7e0WEF2zKh1Yg1TFTVM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-EckH3VoaPVGRYUfNqFmQXw-1; Mon, 11 May 2026 05:04:21 -0400
X-MC-Unique: EckH3VoaPVGRYUfNqFmQXw-1
X-Mimecast-MFC-AGG-ID: EckH3VoaPVGRYUfNqFmQXw_1778490260
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43fe791a398so3727458f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490260; x=1779095060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tewXfhJCZs85isDfaCarY9OYs1rdE/frw9lqrB10rtM=;
        b=PNRZqPM+83L9XuNRjyXXW/nuxmAH+yi9UNDQaP/v9Es7HyPopZa7/PpmeG9MwycIu8
         hYR8n2r26PJhB6h2+toUi2aMeczgUKlaF9aS1hk58a7qYeoncFpde5TX3qZjkqYnMZ4X
         L8ZRAwY5qRf7wOFi6wshzEzGA1lXxxWtf3SIm/X2sSm5d7lJkBoaktQg2OUmfVSjJQBv
         tLG0oHMGmX2nrPEfPlIhmwMfdvoIV8VKYKwn4WFzuAA2XKoCnJ2GKSu57sty5NalDYl4
         dwVDM7KGSTSmMi/Rf5Xj93E1u+A8yhgyOFqOJYWlBChvfn8GiVcE/wGWx/qFY+UP612I
         +KPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ymB2Dpt0Ls2yMvE2TIkfINoWW7NcxadejpBeC7pae33kojpTmeh7djACPaMNGWPcCt7Lc6Py9iCxPwzsO0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCT9EPehhdiGNIcnc0x6h1zcrPNxP52Q+o0f6l4UJiQF0s5AAL
	Zch6zEQNTDgs3LCtkcG6vfpmyFsSagg2FGb4ikHXfyt4RQA3WKQf9nKgnEOjKRLWOOVK5umeWCJ
	Bz0Ms3FPkBl98MibM6k2RuCzD/uyg4AB9unzFX+q19DL2UkrZ8mjupko+Tv7DCwO/Ta69
X-Gm-Gg: Acq92OEJM84cJJMYmAW6eRfYfIyX81Fa6+WYAP0eKqmnrKAQ/AiG9A2EsG0ufXnS6rL
	b9Krk0tlaLKo9ywxOWquHPQ0TUHBomVudXWBhTqfnpalI6mXlfmh8Z13rV7uttvV3dGe7RJRR+P
	cfwrQcwNJBAWD3EtJFIQ+2Z+jwzMZX7AY1kB8vIjeCuE1eyQRdlifz/9OTXdjsAdH3dDI59OjwL
	OzXJzp+xT+CxCul+9WftMvnbMcYOwP5EKyCtrOnH/yw+JsfTtIFBCKI6mkHKMu24vygCF+A3SUR
	L5L7deLId+xEG9lRaGyTpzSOuStWURYEYtWaaQThAOkkdvPtQAPmikZnJIr/OZAeLTZuZ+c3dT7
	d7lfbLWNQDfi3sECsPIGICPQWoTPW0nu6pSP8fjLDTWQbry2BYoc=
X-Received: by 2002:a5d:64e8:0:b0:43b:5672:efe with SMTP id ffacd0b85a97d-4515b056cf3mr37638767f8f.9.1778490259745;
        Mon, 11 May 2026 02:04:19 -0700 (PDT)
X-Received: by 2002:a5d:64e8:0:b0:43b:5672:efe with SMTP id ffacd0b85a97d-4515b056cf3mr37638683f8f.9.1778490259026;
        Mon, 11 May 2026 02:04:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bb87bsm23423788f8f.2.2026.05.11.02.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:04:18 -0700 (PDT)
Date: Mon, 11 May 2026 05:04:13 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: [PATCH resend v6 27/30] mm: add free_frozen_pages_zeroed
Message-ID: <94ea0046b290ffd74a1db6c5e89962366dbc1a1a.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: uzJa3-itSNIsD8xDgzuR_3fqekj4J-qvSlU9PlWHd64_1778490260
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add free_frozen_pages_zeroed(page, order) to free a frozen page
while marking it as zeroed, so the next allocation can skip
redundant zeroing.

An FPI_ZEROED internal flag carries the hint through the free path.
PageZeroed is set after __free_pages_prepare() clears all flags,
so the hint survives on the free list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  1 +
 mm/internal.h       |  1 -
 mm/page_alloc.c     | 21 ++++++++++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ee35c5367abc..e0d5743de68d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -384,6 +384,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
+void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
diff --git a/mm/internal.h b/mm/internal.h
index fa7ffea4d492..0ef6f8221e5c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -934,7 +934,6 @@ struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
-void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce43f5a3dbaa..8eebe01cda80 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -90,6 +90,13 @@ typedef int __bitwise fpi_t;
 /* Free the page without taking locks. Rely on trylock only. */
 #define FPI_TRYLOCK		((__force fpi_t)BIT(2))
 
+/*
+ * The page contents are known to be zero (e.g., the host zeroed them
+ * during balloon deflate).  Set PageZeroed after free so the next
+ * allocation can skip redundant zeroing.
+ */
+#define FPI_ZEROED		((__force fpi_t)BIT(3))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -1596,8 +1603,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (__free_pages_prepare(page, order, fpi_flags))
+	if (__free_pages_prepare(page, order, fpi_flags)) {
+		if (fpi_flags & FPI_ZEROED)
+			__SetPageZeroed(page);
 		free_one_page(zone, page, pfn, order, fpi_flags);
+	}
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
@@ -3000,6 +3010,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
+	if (fpi_flags & FPI_ZEROED)
+		__SetPageZeroed(page);
+
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
@@ -3038,6 +3051,12 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	__free_frozen_pages(page, order, FPI_NONE);
 }
 
+void free_frozen_pages_zeroed(struct page *page, unsigned int order)
+{
+	__free_frozen_pages(page, order, FPI_ZEROED);
+}
+EXPORT_SYMBOL(free_frozen_pages_zeroed);
+
 void free_frozen_pages_nolock(struct page *page, unsigned int order)
 {
 	__free_frozen_pages(page, order, FPI_TRYLOCK);
-- 
MST

