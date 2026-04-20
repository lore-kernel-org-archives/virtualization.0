Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E463A0E84
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689443; cv=none; b=V9a8h2tAakWu7EsMnrbBKE8Y0JXufPdiUtVnQkfPgHtzr7pm94iyzWRhIMKWpYB+UntBsaBBNQ2DKwRFB6X045dhjEWB8E7SgYSd6vxgQAEeVMuSLmCXxm15K8jdqLOHSkv24CuwiKY3GkD9TauPlOsKnHbM7D7b8szXwr2gYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689443; c=relaxed/simple;
	bh=neg6eIdJRVkDfxbADXvR7pQbjSovMoDrB+ifUOQr2bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jI/fbieUvgKkYG2LcIv0FxzGZHNbg501IP1wUneQFBqA2FB7fe0wvYGBopoeDE2XNj8RTAqNDFwNjR1lw1Q5CR351e6px1yq/uIJiUR2NksGNgn6yCHLLZ7aBaCLlXM+mUAXVq/CTKwXpxkZQGYVzEGXF5DXZ+alZ8uYMJWz9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c03A3tyo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c03A3tyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOqefyw2xfKGzGmt4FILCNloyRh5kydROPG1tzzp9Iw=;
	b=c03A3tyoc//Q9LfOERjuGnxPCIKtbLqMwxEk/V4mftT0g1u8269sIraSnekF5t1lpB0jTB
	6M4hoHuluSPtqjJ21OzmLVy2HrrswQke1Z3/6Y0JsFW4XNvGYwoeLsI8bDUyYNyROUmazY
	BJ3jf1bpAFM9JTYISy5Xu+89nIysCig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-_OEYuMxRPmuz9OS1C038WA-1; Mon, 20 Apr 2026 08:50:40 -0400
X-MC-Unique: _OEYuMxRPmuz9OS1C038WA-1
X-Mimecast-MFC-AGG-ID: _OEYuMxRPmuz9OS1C038WA_1776689439
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4411a1f9601so832097f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689439; x=1777294239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOqefyw2xfKGzGmt4FILCNloyRh5kydROPG1tzzp9Iw=;
        b=YGY5UdADwxfi93LCzItccNiaSwBVdxkClPh107o2wj77Ras7/tG6DypGYyHx5oEgqU
         L6bPvNsQD1bayHFd84mMbt/VLvHUTy02dpVaunU2eZJhd7sk+H9Yvt0G5AjuV9Kt1JuJ
         a0HDBJJHDDcAJCaEjY4CMl/ch/ZDjDJmWlT4UyLMci1Z1YdI+TlNYG/EiAF4qvsqBiUn
         gpMdl3bBUiHBabZYyAm/1s6LunSdXQeoEPO7sMUuK1dItvUBe1CxXv4v4pJUnLl9gYcs
         VHVmhN4CyVVDA1oI2z5EHINK37MMb1jDnNZwTdahg3ixQ/FdAa0rteKcWPXS/9sR9yme
         AEjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KUprN1sMoxnLqnKhikGKMW21BdULPQjetgreqmaVlQTy8AwkOD5NI4Ngm2tWheKRQc90yGpsisGSsKplXhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzN3OJ90kYlZaoprJUKkqAmQFOJsTWhmJsRBU7ck5HlFro8kEa4
	JBbS4Sdbl8n+ELNAbTmUSwo/l92ywGdtFqnENbLG6r8M6KcL8DDFAgl7xRRFf0r7OVlPc5bNYNc
	iNnuYFteej+aTabriJEtPWejmQQ4Baif+dMQnt5a1JAlgaLrzXn9mscOc2ceJp0SHP37B
X-Gm-Gg: AeBDiesQ6MLm4M049zkihaRb0SfxsoCeYikvMCKDqydMq/QjaeUJR38HvEVzvS9bar3
	sOP7Q2AX6Wzu9R/boi7/FBWh6Y/IwiAe/UO2x4S+ioe2UEP3X7HRvD/dTl/N3nN+vhzHZBUZMrU
	rbM9NY9gEatDcA1Bkem/K0l0ZyRBhdMr5ZBIqHmSyE0D8vsjs0lx9juIs9Xxt8cTeyfLP/Vqm04
	WUv6aE4dZckN0R7wTpv2U7X4yKpVhJWlIA11MhRM/JibVjhINHOSb9m62OVmtMZ+vWzlkbx2wM2
	n2JxdfuQWlMDwAUPjYY23xWBQx/tOU22cRl7ZJq7YuUsUxxX9ey10O8rjjWGNFR4PpoNYdyuy86
	xaWlA1X8phjrmqR9ma1UxwaTCOrAhmqCrjT6qcDDgmiw55slE4rDN9Q==
X-Received: by 2002:a05:6000:40dc:b0:43d:7b7b:ab77 with SMTP id ffacd0b85a97d-43fe3dcbbeamr19710766f8f.11.1776689438761;
        Mon, 20 Apr 2026 05:50:38 -0700 (PDT)
X-Received: by 2002:a05:6000:40dc:b0:43d:7b7b:ab77 with SMTP id ffacd0b85a97d-43fe3dcbbeamr19710690f8f.11.1776689437905;
        Mon, 20 Apr 2026 05:50:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1249sm25931964f8f.5.2026.04.20.05.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:37 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:35 -0400
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
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v2 06/18] mm: page_alloc: thread pghint_t through
 get_page_from_freelist
Message-ID: <e4aaa5244f129a0a057b190ff65b87526a1f7c8c.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: iEFLAR61oJ643vyWGvxN6EBE-NdIzCgjQdlf-pnOVZ8_1776689439
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add pghint_t *hints to get_page_from_freelist() and pass it to
prep_new_page().  All internal callers except the main fast path
in __alloc_frozen_pages_hints_noprof() pass NULL.

The next patch uses this to return hints from
post_alloc_hook() to callers via __alloc_frozen_pages_hints().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b0971a1eaa73..ece61d02ea96 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2483,7 +2483,8 @@ __rmqueue_steal(struct zone *zone, int order, int start_migratetype)
 			continue;
 
 		page = get_page_from_free_area(area, fallback_mt);
-		page_del_and_expand(zone, page, order, current_order, fallback_mt);
+		page_del_and_expand(zone, page, order, current_order,
+				    fallback_mt);
 		trace_mm_page_alloc_extfrag(page, order, current_order,
 					    start_migratetype, fallback_mt);
 		return page;
@@ -3294,7 +3295,8 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 * high-order atomic allocation in the future.
 			 */
 			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
-				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
+				page = __rmqueue_smallest(zone, order,
+							  MIGRATE_HIGHATOMIC);
 
 			if (!page) {
 				spin_unlock_irqrestore(&zone->lock, flags);
@@ -3414,7 +3416,8 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 */
 	pcp->free_count >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp,
+				list);
 	pcp_spin_unlock(pcp, UP_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -3451,7 +3454,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	}
 
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
-							migratetype);
+			     migratetype);
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -3835,7 +3838,7 @@ static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
  */
 static struct page *
 get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
-						const struct alloc_context *ac)
+		       const struct alloc_context *ac, pghint_t *hints)
 {
 	struct zoneref *z;
 	struct zone *zone;
@@ -4084,14 +4087,14 @@ __alloc_pages_cpuset_fallback(gfp_t gfp_mask, unsigned int order,
 	struct page *page;
 
 	page = get_page_from_freelist(gfp_mask, order,
-			alloc_flags|ALLOC_CPUSET, ac);
+			alloc_flags|ALLOC_CPUSET, ac, NULL);
 	/*
 	 * fallback to ignore cpuset restriction if our nodes
 	 * are depleted
 	 */
 	if (!page)
 		page = get_page_from_freelist(gfp_mask, order,
-				alloc_flags, ac);
+				alloc_flags, ac, NULL);
 	return page;
 }
 
@@ -4129,7 +4132,8 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	 */
 	page = get_page_from_freelist((gfp_mask | __GFP_HARDWALL) &
 				      ~__GFP_DIRECT_RECLAIM, order,
-				      ALLOC_WMARK_HIGH|ALLOC_CPUSET, ac);
+				      ALLOC_WMARK_HIGH|ALLOC_CPUSET, ac,
+				      NULL);
 	if (page)
 		goto out;
 
@@ -4227,7 +4231,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 	/* Try get a page from the freelist if available */
 	if (!page)
-		page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
+		page = get_page_from_freelist(gfp_mask, order, alloc_flags,
+					     ac, NULL);
 
 	if (page) {
 		struct zone *zone = page_zone(page);
@@ -4477,7 +4482,8 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 		goto out;
 
 retry:
-	page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
+	page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac,
+				     NULL);
 
 	/*
 	 * If an allocation failed after direct reclaim, it could be because
@@ -4831,7 +4837,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * The adjusted alloc_flags might result in immediate success, so try
 	 * that first
 	 */
-	page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
+	page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac,
+				     NULL);
 	if (page)
 		goto got_pg;
 
@@ -5249,7 +5256,7 @@ struct page *__alloc_frozen_pages_hints_noprof(gfp_t gfp, unsigned int order,
 	struct alloc_context ac = { };
 
 	if (hints)
-		*hints = (pghint_t)0;
+		*hints = 0;
 
 	/*
 	 * There are several places where we assume that the order value is sane
@@ -5279,7 +5286,8 @@ struct page *__alloc_frozen_pages_hints_noprof(gfp_t gfp, unsigned int order,
 	alloc_flags |= alloc_flags_nofragment(zonelist_zone(ac.preferred_zoneref), gfp);
 
 	/* First allocation attempt */
-	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac,
+				     hints);
 	if (likely(page))
 		goto out;
 
@@ -7855,7 +7863,8 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	 * Best effort allocation from percpu free list.
 	 * If it's empty attempt to spin_trylock zone->lock.
 	 */
-	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac,
+				     NULL);
 
 	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
 
-- 
MST

