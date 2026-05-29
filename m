Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4F3E51F5
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068319; cv=none; b=mqyMsBELx3aQKGoGyYqTM8ZMPjKAabiiWjMoPIHlzg67FmXM6AjyCQ6wrVhiIGbNfHQbQsxLMKdgs1Ny4isKLO3NxbSDm38DVAZMtUEXowiJVe6Qo7+z+A1fEtQVtNNV6A4d4GQ2XCepPM25X3BeN7Dzn+707R3oxRIe4B6B5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068319; c=relaxed/simple;
	bh=m+2CGKGy9tP1X5jr3y7WRquw/r2rQI3y1dy5VzBRNcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LzQO9B89WuTCFpqKe+kq41mhpSBxv4+PsegWNlxJ7hrInZDCq8WJxhrOr2MjzjvpyFeO8iEuWKagpz7nt1f348UW3lEBJRjHMatTgjf8n75BhW7HDMaZIc/27Yt2kKdznCKLW2leeY7yyCWqGq17fhMXAkft/eZaIYmSEAJv22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Np+NEEHr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Np+NEEHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVyoesbwmJaC/SCrniPu7amcCOYT9PX+z/FEgZLf3FM=;
	b=Np+NEEHrAzBFc7iDzGDPFBw0B8LhHSVekOBJmRj0RtdsgvsvNquS8ihhvdNuuxEoQsKxeV
	7bT1RRomAojWsx5tfCh+FfW21yZV0r7BZQvNmpcxyK/T7JrhKJvsbXHcnhM4sFaF2pb+q2
	XPpc4T9/doBq8CFX88ujpKpa/svGBq8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-Wb60dRLgO-qFCGNkzH6ufg-1; Fri, 29 May 2026 11:25:16 -0400
X-MC-Unique: Wb60dRLgO-qFCGNkzH6ufg-1
X-Mimecast-MFC-AGG-ID: Wb60dRLgO-qFCGNkzH6ufg_1780068315
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6417092so186503f8f.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068315; x=1780673115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVyoesbwmJaC/SCrniPu7amcCOYT9PX+z/FEgZLf3FM=;
        b=qPsFm+FeMNYjn7h+56BrPJ/YKMYZl1fy2t+gZ3YxONrSxE7EYsQti83ou1xnE1NpNd
         SsGGGOHXn0YhNwjmIxUFx3k8wjt+366bnrkVBXNM8nmVTBfMvOK6t46CxJpcYiZ7AALp
         Dl+qdEYjeoo3kSluLRDlPKySkIv2nPB9O2YRoGWbK93YBQdSNHEfzyiMe3M2JTyukKZB
         ssmPCk01spR3gnDElz9f1yE5Ig3nnrQ9nUy3yOCulUkj2DNmBui9bTaJpapSpplMuNxc
         5LWC6aTdY6x/NQGSE6w/Cy4pAO8/9YIAC5gxND0Sg5lVzUTodq2qC8wLQ/7Fr7j1QNQv
         LBVA==
X-Forwarded-Encrypted: i=1; AFNElJ+bc6YLPVrsspjeD31Sfh7UHArXQiArxkf3gaF//WxNy4W7rjc18R7rpz1/uasrVmWHcl3pskohvu5XF8IK0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyecVO5JvN47aCcqzpDdTfgliwS7q0Z2qzW0B9I4jVcOUhJ4OqY
	ye8Jd81b0Ra6xhW1uHPDpQuKu7CNtg9enJ9g0e7ZP2//C/LawzbKIPc75srzDkET234iIjkou8g
	arfbH4KPhywxd+en/j+JSJTEsY512KOICq08NYtmLpam0f0JFYlPDhLVqXUtkGcZDEiWg
X-Gm-Gg: Acq92OHBqYlryujzizpSt7AxzNXV1OMWTMDamaWn7KtA65Pp3ywc1/EfeG8uogsnU3M
	mlQyqCfGSny4jJYjNJKoqZikg7gaINd+GH29BD8OOgf6GgG75FLtcG9GTuROw8FXC3u8EwoEaiW
	qGeCj9/ZGa3JjQVgl/dV9CIcX/TsFeraeCmRaUBfjC0Os0+kCe/44bAU15AZCjycXrhJnnx7MPI
	9eEtIABODNYQ7PbBAeO0n+bRajv/nDuFS6aC0eZdnM7CDkCEkV+PS2CgVHoxTz5njihhnDhyhtL
	oXr04E/qtyHHsxt9sVdAkTNvcFsZWvSrNNJe32GS6+5rEJHC1Gs7jEPctcwx5Klu9bVTkdv/+a+
	lpn8GcKEU9sQGElRC7ZLVp9Tpr7pSeEiI3AvuQMPOzusZaejuU/gVEw==
X-Received: by 2002:a5d:49c2:0:b0:455:7d77:1d25 with SMTP id ffacd0b85a97d-45ef6b75cf8mr364477f8f.27.1780068314869;
        Fri, 29 May 2026 08:25:14 -0700 (PDT)
X-Received: by 2002:a5d:49c2:0:b0:455:7d77:1d25 with SMTP id ffacd0b85a97d-45ef6b75cf8mr364397f8f.27.1780068314292;
        Fri, 29 May 2026 08:25:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef357635fsm4180544f8f.33.2026.05.29.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:25:13 -0700 (PDT)
Date: Fri, 29 May 2026 11:25:09 -0400
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
Subject: [PATCH v9 33/37] mm: add free_frozen_pages_zeroed
Message-ID: <2869cf9cacba23da37dd8b5a8417f8ae30861724.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: vIiyWKEcQikB4LuJ9GguMT05TZrbzOjhtRPB1K4g2lQ_1780068315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add free_frozen_pages_zeroed(page, order) to free a frozen page
while marking it as zeroed, so the next allocation can skip
redundant zeroing.

An FPI_ZEROED internal flag carries the hint through the free path.
PageZeroed is set after __free_pages_prepare() clears all flags,
so the hint survives on the free list.

__SetPageZeroed is non-atomic but safe here: the page is frozen
(refcount 0) and not yet on any free list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  1 +
 mm/internal.h       |  1 -
 mm/page_alloc.c     | 29 ++++++++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 73109d4e31a4..d24b61e45861 100644
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
index fd910743ddc3..4af5e72742ba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -938,7 +938,6 @@ struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
-void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 702fa2ced1e1..399e2038dcd9 100644
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
@@ -1599,8 +1606,19 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (__free_pages_prepare(page, order, fpi_flags))
+	if (__free_pages_prepare(page, order, fpi_flags)) {
+		/*
+		 * Only mark as zeroed if the page is actually still zero.
+		 * kernel_poison_pages() overwrites with PAGE_POISON (0xAA)
+		 * when CONFIG_PAGE_POISONING is enabled.  With init_on_free,
+		 * kernel_init_pages() re-zeroes after poisoning, so the
+		 * page is still zero.
+		 */
+		if ((fpi_flags & FPI_ZEROED) &&
+		    (!page_poisoning_enabled_static() || want_init_on_free()))
+			__SetPageZeroed(page);
 		free_one_page(zone, page, pfn, order, fpi_flags);
+	}
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
@@ -3021,6 +3039,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
+	if (fpi_flags & FPI_ZEROED)
+		__SetPageZeroed(page);
+
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
@@ -3059,6 +3080,12 @@ void free_frozen_pages(struct page *page, unsigned int order)
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

