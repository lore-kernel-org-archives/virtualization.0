Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BD3A0B26
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689446; cv=none; b=R0feJ4Lc3LkvOKecstyzPd3bY3NBN9r5icapKOezoRZv2/XNpkxt+sK7M3m3eIuLh6/BNhRWju3eSSDHEYWVaf4MRajQT3YJ9C0XZItLWAi3aosO8HBLug8m1g6NJvdHCCJI+4hUYJvt5UgDQk2ijzo9Dk+0IEhnx9X4pTXLHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689446; c=relaxed/simple;
	bh=xGH+Tbv6Ot2NIFWvdduKCymUO4Ct3OBttETzUcGBWZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fNvzp1oQ4Et/+HqjJaeH/8mCUIDzpv3jMDr44ZZUUF283XO/1/GHY93UbOM2OreG9uoL62MFQ0abHjB29s1NLCF80gTnhA0FLkZc0JRcQo9V3FW1vPEhiitEbrKHbsa3QWFN4SRzvebNLxkZ9OoIQ5/OT3dbtKHJwxSlTpqucdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGbhMUp+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGbhMUp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJcG0BVg25HZ2E/z9uEY2PXmC8ZZQ0Dy/q/+TJStPMY=;
	b=iGbhMUp+mOsUpon+xH39dAXASkRveFClob3YiI8Xxg/7saEtw0L4c4/Q1/Q/c3LJdzCfHs
	+uhf0BCWlgP8vxAd7/702gyxGlRD6L+L1l1qf75sVWkJSiwPTgnO/68e36kQgeCuIvy3AU
	sbFFWIX0WS4P9kAvUt2sr4awKp8L8AM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-9hUV2VOpMYeWTtLbtLmACA-1; Mon, 20 Apr 2026 08:50:43 -0400
X-MC-Unique: 9hUV2VOpMYeWTtLbtLmACA-1
X-Mimecast-MFC-AGG-ID: 9hUV2VOpMYeWTtLbtLmACA_1776689442
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4891e102d47so5069865e9.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689442; x=1777294242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJcG0BVg25HZ2E/z9uEY2PXmC8ZZQ0Dy/q/+TJStPMY=;
        b=Wg2er6A1WG7Qn+Y4+QgNhu2ufiNWfT3r10rGb1QUZtbjIHZJsvSN81DvYMV2BB0UuA
         lLzYiYAgErENVlmD7RNVwUuAS4XDx2BAN6TzTTa0qYve3M5e2EPdvgpV7B0PqVzu6L/C
         l51biVTvpeUt3vwPUH4mB29g3xh4DAgNmZI7YFrEYqEB9gi+F4eDrI9mj3pUDIOVR/NB
         JIYuajmDCZ9b7Yl0vauefxYLbQEEv+vDUC8Y1jLWFr5VzJkYGSxIB7y6LSZOrIPFNtRh
         csWvklKyv1SZ/B5LHQwQ6mBYFJz3SrvV0OBT/Wtwpqz4JgPvHcMpwFSYb4F4LT1TDl/N
         hMUw==
X-Forwarded-Encrypted: i=1; AFNElJ+Hy20wd62BlH3YdW/eYELfIdHLNMxJu5ZZUdFRnbrX5ktbfzCOSFNGLTb0OuxwtNukI6zicwkWlMij/WkEvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCAK8utMjPvL088btIdEwhYW9slimL5ubJOtpVjeFjiRrv5SiD
	8B0smGN1WmgPGzE9ek6ofnvDW43vzvRqRbz0BXDSoeSdWUYjvabvsYvTOSMRycgfJbz0Fw3pw48
	zX1aEN9kCl0N9MGpPSIOGNJocfPbUwTqJTruOJCM09xtQCpyVYlTnY/Rpf0TmoBqe2vuS
X-Gm-Gg: AeBDieuBuktmudjwQ+iBTLwRZPXRv2td+A/siPKWXI0Po10CVVNm9Euw4zHQFqqm8dC
	hh8SPcSzYJDNHh4yk4+Iqxv+l44/oOQXVzAXDxyGuuDe4oqCYyYsNYqYApZDY5SC3VLgtGAqhez
	PpkRfWT+au3AzeNxbkEKfx5kB+NQLwWDjisNAC8yZvuBVkatemvyREjw4E7/NfcasVI3W6Xp8NQ
	y9ZDpoCE9hwjKPavAXV/0qaDh0feXWv2FDQ11SlXTW7WNZ+yrdHq61ahtjF8wS3Hp0fSsc+krP/
	GizJTYKBYFvFTwEyRArsQoU+ofR9CI56xSpY4UKiw4G9avftpjJlMvY/Lpsrw63t1akKE4vZsQk
	qiIYQEvVmxj0xnQKc1oGcd0b25FIKVagStTUS5pVBRkVPP8nofAfS+w==
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-4891c1f38c8mr61834735e9.6.1776689441672;
        Mon, 20 Apr 2026 05:50:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-4891c1f38c8mr61834045e9.6.1776689441052;
        Mon, 20 Apr 2026 05:50:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7bf696sm89203495e9.32.2026.04.20.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:40 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v2 07/18] mm: post_alloc_hook: use PG_zeroed to skip
 zeroing, return pghint_t
Message-ID: <fea448c692ed75232179a24ca853fdc8dede42f6.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xDzVNIiCT0qIv3n3tBLIK611lqdojlNOvD9opfW3Sq4_1776689442
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add pghint_t *hints parameter to post_alloc_hook() and
prep_new_page(). post_alloc_hook() reads PageZeroed, clears
it, and returns PGHINT_ZEROED via hints.

This provides a single point where PG_zeroed is consumed and
cleared, regardless of whether the page came through PCP or
buddy. The flag is set in page_del_and_expand() and survives
both paths until post_alloc_hook() consumes it.

Only get_page_from_freelist() passes hints through
prep_new_page(); all other callers (compaction, bulk alloc,
split, contig) pass NULL.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/compaction.c |  4 ++--
 mm/internal.h   |  3 ++-
 mm/page_alloc.c | 25 +++++++++++++++++--------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..6fcce7756613 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -82,7 +82,7 @@ static inline bool is_via_compact_memory(int order) { return false; }
 
 static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
 {
-	post_alloc_hook(page, order, __GFP_MOVABLE);
+	post_alloc_hook(page, order, __GFP_MOVABLE, NULL);
 	set_page_refcounted(page);
 	return page;
 }
@@ -1833,7 +1833,7 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
 	}
 	dst = (struct folio *)freepage;
 
-	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, NULL);
 	set_page_refcounted(&dst->page);
 	if (order)
 		prep_compound_page(&dst->page, order);
diff --git a/mm/internal.h b/mm/internal.h
index 686667b956c0..2964cdfcd31f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -887,7 +887,8 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
+void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
+		     pghint_t *hints);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ece61d02ea96..a4cfd645599a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1863,13 +1863,21 @@ static inline bool should_skip_init(gfp_t flags)
 }
 
 inline void post_alloc_hook(struct page *page, unsigned int order,
-				gfp_t gfp_flags)
+				gfp_t gfp_flags, pghint_t *hints)
 {
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
 	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+	bool zeroed = PageZeroed(page);
 	int i;
 
+	__ClearPageZeroed(page);
+	if (hints)
+		*hints = zeroed ? PGHINT_ZEROED : 0;
+
+	if (zeroed && !zero_tags)
+		init = false;
+
 	set_page_private(page, 0);
 
 	arch_alloc_page(page, order);
@@ -1918,9 +1926,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
-							unsigned int alloc_flags)
+					unsigned int alloc_flags, pghint_t *hints)
 {
-	post_alloc_hook(page, order, gfp_flags);
+	post_alloc_hook(page, order, gfp_flags, hints);
 
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
@@ -3991,7 +3999,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
-			prep_new_page(page, order, gfp_mask, alloc_flags);
+			prep_new_page(page, order, gfp_mask, alloc_flags,
+				      hints);
 
 			/*
 			 * If this is a high-order atomic allocation then check
@@ -4227,7 +4236,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 	/* Prep a captured page if available */
 	if (page)
-		prep_new_page(page, order, gfp_mask, alloc_flags);
+		prep_new_page(page, order, gfp_mask, alloc_flags, NULL);
 
 	/* Try get a page from the freelist if available */
 	if (!page)
@@ -5223,7 +5232,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		}
 		nr_account++;
 
-		prep_new_page(page, 0, gfp, 0);
+		prep_new_page(page, 0, gfp, 0, NULL);
 		set_page_refcounted(page);
 		page_array[nr_populated++] = page;
 	}
@@ -6958,7 +6967,7 @@ static void split_free_frozen_pages(struct list_head *list, gfp_t gfp_mask)
 		list_for_each_entry_safe(page, next, &list[order], lru) {
 			int i;
 
-			post_alloc_hook(page, order, gfp_mask);
+			post_alloc_hook(page, order, gfp_mask, NULL);
 			if (!order)
 				continue;
 
@@ -7164,7 +7173,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 		struct page *head = pfn_to_page(start);
 
 		check_new_pages(head, order);
-		prep_new_page(head, order, gfp_mask, 0);
+		prep_new_page(head, order, gfp_mask, 0, NULL);
 	} else {
 		ret = -EINVAL;
 		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
-- 
MST

