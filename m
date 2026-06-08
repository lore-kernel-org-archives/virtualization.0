Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6433B19D6
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907752; cv=none; b=CILTid6mirkY6ubwzu3oxuvFaVszBCLwXdJiIxXM1DyNmuyAr2T3XdNdkFlU0+fS0s8QL3XHlPwxk2fjd5UvrLqAMjoKbTZ0CUGNOtuqRh2lxZVi7ilnpE3SY9eJCIhRa4j+hOuVfk0j0wYDSvsubXClBWRTyaZ3OrwNWbw1nPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907752; c=relaxed/simple;
	bh=VvYEZY8DbRfnOqU9SNzEdKKP+Kx+uDwCJkKNzhWK0fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lbqRSRRyEwx6MhBjEh/dBnldsWCW6oAgWUIW8XJ9WXGf8D21ptyePXPlWSWDD2q+6OU7FDXm781vX4KyxWByHGugLzRk3GgyJ1oQ15z21ePVrlein2bKG/AvGDE/oDTYbZoLsKphdPhEoIFHkVH2EB5oUjGkGP9CuauWDD/lIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZSkKIEq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZSkKIEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OcVo+/Lds4YxddLi3UfNSteOvi0JEMISiAqD3/N1YSI=;
	b=EZSkKIEqw8XSOYkHIz4ij3Q6qsLScZrIxL/mWPpSBg9kYcO8GUXT/NIaWc4aVSgsHBsI/8
	YZsoQ14a1msxwyuJ4JnGO1HlgijLydUOBjmd9yXg4RRIMsoRAaY0lRDiMhEi1W595h8jL+
	N2H0tdBEhslMTlFzBBoX7TEasr/6Vjc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-FrNmhmZ4Pf2vmMLOKM6LYw-1; Mon, 08 Jun 2026 04:35:46 -0400
X-MC-Unique: FrNmhmZ4Pf2vmMLOKM6LYw-1
X-Mimecast-MFC-AGG-ID: FrNmhmZ4Pf2vmMLOKM6LYw_1780907745
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so32498775e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907745; x=1781512545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcVo+/Lds4YxddLi3UfNSteOvi0JEMISiAqD3/N1YSI=;
        b=jMu5pZ3UfUPMGnjwNbH+QpgNHjXqd4gY4mJy15807SD3ApATYImts+hOLf3DAUjKya
         9hM1Z9vLpfnbWZgGmFhyiaX+E7bFclUGEoQ5w+fW3DCvuwdiHMeedj1S0plP+BGlr99x
         b2LxN6u1WLz2ujrVr/XvtZ2Vpla96+Zsd6SBR7cbB09VTYl88m6CL4B95eCdTf/5RS86
         z6s1OmzE8MV32FPZRxEhdUjVWr8n1+SMBTbN5fIIFC14dKa58uR/4T2kCS8PRcKdGuwW
         4GeSgDtILJSFTAQsowr2oQfnUZCj3ZEZCrWl+MRqUHXuYOwnZksUHoNyiFv6AcvxnN0w
         jGXg==
X-Forwarded-Encrypted: i=1; AFNElJ9Qy5AOzN9uE0Z8r9M5EtPIC9UxJMa3xlfAAzkOzckyfTZqD8mxG99MhVWR6TDmZSntIrSAyuQ/Gd+bO1ELUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxExgSFc6EYY9xfobwPx6T4Yxf2Z6JPwPnViuTWLs33f8mb8Jp6
	kx9trLjY8mHPznZJ7YcZ0F4+vly5VDTYR0nOtWlxGvuCGKJAsnZZbbdhwnjNeA0D5zPpLDVU0w4
	+ljcN/m1Fg3Ww8BxMay6ioweCbuuJGmJ50EjCQMrEB60Nei0TT0hrc7hnF906V9aprQ8O
X-Gm-Gg: Acq92OEpGvhcvuYMxJ+ST75VExuJA6cXytW6wxgkTz66ZJ4UPW1EzyICBAzgsgOIvkA
	y4h8uak3ldYOixm8phsKWsTncpTndgdUfY3fkaoA6EHGDHq3UP+cL1nMwMVLgGSSdgNXl2ooxMV
	cPPip2FE5RXoqv8oJ46jNHJzWLIlK+HLCuQlFLg3aSiuPGrVj56q6SX3kooRJa3Wx+Uqnk7xw7t
	QJJh95Hph7ZRAz44/i2jry5sDqvFc06NqPvghuVMzRuLYEDtugQzCrkvMN7DFAyxneKRKwvyWAG
	A/F2KVEw9diIgud3NqTXMu5a6ZkE05kzMIgmePQh7XhWxDaDE9owd0okL03uUJJJEacQcYGrPln
	0U3Us6M6AheMSq5BLtGdoyRo=
X-Received: by 2002:a05:600c:e548:10b0:490:cf76:dea4 with SMTP id 5b1f17b1804b1-490cf76dec2mr27271145e9.2.1780907744709;
        Mon, 08 Jun 2026 01:35:44 -0700 (PDT)
X-Received: by 2002:a05:600c:e548:10b0:490:cf76:dea4 with SMTP id 5b1f17b1804b1-490cf76dec2mr27270255e9.2.1780907744100;
        Mon, 08 Jun 2026 01:35:44 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm50742305f8f.3.2026.06.08.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:35:43 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:35:29 -0400
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
Subject: [PATCH v10 08/37] mm: add alloc_contig_frozen_pages_user for
 cache-friendly zeroing
Message-ID: <f2036f596f17f66fb55b74a5fd85e8b7ab51876d.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: SNFcwAndf3d9HfkB-u5lQEeELWoZieecpqHVbp8WD9Y_1780907745
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a _user variant of alloc_contig_frozen_pages that accepts a user_addr
parameter for cache-friendly zeroing of contiguous allocations.

No functional change; all existing callers continue to pass
USER_ADDR_NONE.

Note for reviewers: non-compound contiguous allocations are
zeroed via kernel_init_pages, same as before this patch.
There is no fault address because these allocations are not
from the page fault path. For compound allocations, user_addr
reaches post_alloc_hook() which calls folio_zero_user() with
the dcache flush on cache-aliasing architectures.

Note about Sashiko (sashiko.dev) false positives: sashiko
flags two issues here: (1) user_addr silently ignored for
non-compound allocations, and (2) post_alloc_hook ignores
user_addr. Both are false positives: (1) non-compound
contiguous allocations have no fault address to pass, and
(2) post_alloc_hook does use user_addr when it is not
USER_ADDR_NONE.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  6 ++++++
 mm/page_alloc.c     | 42 ++++++++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ee35c5367abc..73109d4e31a4 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -453,6 +453,12 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 #define alloc_contig_frozen_pages(...) \
 	alloc_hooks(alloc_contig_frozen_pages_noprof(__VA_ARGS__))
 
+struct page *alloc_contig_frozen_pages_user_noprof(unsigned long nr_pages,
+		gfp_t gfp_mask, int nid, nodemask_t *nodemask,
+		unsigned long user_addr);
+#define alloc_contig_frozen_pages_user(...) \
+	alloc_hooks(alloc_contig_frozen_pages_user_noprof(__VA_ARGS__))
+
 struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask);
 #define alloc_contig_pages(...)	\
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 21b52c879751..6d3f284c607d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6975,13 +6975,15 @@ static void __free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages
 }
 
 /**
- * alloc_contig_frozen_range() -- tries to allocate given range of frozen pages
+ * __alloc_contig_frozen_range() -- tries to allocate given range of frozen pages
  * @start:	start PFN to allocate
  * @end:	one-past-the-last PFN to allocate
  * @alloc_flags:	allocation information
  * @gfp_mask:	GFP mask. Node/zone/placement hints are ignored; only some
  *		action and reclaim modifiers are supported. Reclaim modifiers
  *		control allocation behavior during compaction/migration/reclaim.
+ * @user_addr:	user virtual address for cache-friendly zeroing, or
+ *		USER_ADDR_NONE for kernel allocations.
  *
  * The PFN range does not have to be pageblock aligned. The PFN range must
  * belong to a single zone.
@@ -6997,8 +6999,9 @@ static void __free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages
  *
  * Return: zero on success or negative error code.
  */
-int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
-		acr_flags_t alloc_flags, gfp_t gfp_mask)
+static int __alloc_contig_frozen_range(unsigned long start, unsigned long end,
+		acr_flags_t alloc_flags, gfp_t gfp_mask,
+		unsigned long user_addr)
 {
 	const unsigned int order = ilog2(end - start);
 	unsigned long outer_start, outer_end;
@@ -7125,7 +7128,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 		struct page *head = pfn_to_page(start);
 
 		check_new_pages(head, order);
-		prep_new_page(head, order, gfp_mask, 0, USER_ADDR_NONE);
+		prep_new_page(head, order, gfp_mask, 0, user_addr);
 	} else {
 		ret = -EINVAL;
 		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
@@ -7135,6 +7138,13 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	undo_isolate_page_range(start, end);
 	return ret;
 }
+
+int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
+		acr_flags_t alloc_flags, gfp_t gfp_mask)
+{
+	return __alloc_contig_frozen_range(start, end, alloc_flags, gfp_mask,
+					   USER_ADDR_NONE);
+}
 EXPORT_SYMBOL(alloc_contig_frozen_range_noprof);
 
 /**
@@ -7227,14 +7237,16 @@ static bool zone_spans_last_pfn(const struct zone *zone,
 	return zone_spans_pfn(zone, last_pfn);
 }
 
-/**
- * alloc_contig_frozen_pages() -- tries to find and allocate contiguous range of frozen pages
+/*
+ * alloc_contig_frozen_pages_user_noprof() -- allocate contiguous frozen pages with user address
  * @nr_pages:	Number of contiguous pages to allocate
  * @gfp_mask:	GFP mask. Node/zone/placement hints limit the search; only some
  *		action and reclaim modifiers are supported. Reclaim modifiers
  *		control allocation behavior during compaction/migration/reclaim.
  * @nid:	Target node
  * @nodemask:	Mask for other possible nodes
+ * @user_addr:	user virtual address for cache-friendly zeroing, or
+ *		USER_ADDR_NONE for kernel allocations.
  *
  * This routine is a wrapper around alloc_contig_frozen_range(). It scans over
  * zones on an applicable zonelist to find a contiguous pfn range which can then
@@ -7253,8 +7265,9 @@ static bool zone_spans_last_pfn(const struct zone *zone,
  *
  * Return: pointer to contiguous frozen pages on success, or NULL if not successful.
  */
-struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
-		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
+struct page *alloc_contig_frozen_pages_user_noprof(unsigned long nr_pages,
+		gfp_t gfp_mask, int nid, nodemask_t *nodemask,
+		unsigned long user_addr)
 {
 	unsigned long ret, pfn, flags;
 	struct zonelist *zonelist;
@@ -7282,10 +7295,11 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 				 * win the race and cause allocation to fail.
 				 */
 				spin_unlock_irqrestore(&zone->lock, flags);
-				ret = alloc_contig_frozen_range_noprof(pfn,
+				ret = __alloc_contig_frozen_range(pfn,
 							pfn + nr_pages,
 							ACR_FLAGS_NONE,
-							gfp_mask);
+							gfp_mask,
+							user_addr);
 				if (!ret)
 					return pfn_to_page(pfn);
 				spin_lock_irqsave(&zone->lock, flags);
@@ -7307,6 +7321,14 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(alloc_contig_frozen_pages_user_noprof);
+
+struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
+		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
+{
+	return alloc_contig_frozen_pages_user_noprof(nr_pages, gfp_mask, nid,
+						     nodemask, USER_ADDR_NONE);
+}
 EXPORT_SYMBOL(alloc_contig_frozen_pages_noprof);
 
 /**
-- 
MST

