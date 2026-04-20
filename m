Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5F3A16A2
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689449; cv=none; b=ic6KOIWpla6AKyQgxb1cZfOnorYBqtJUEsle0sQiQuCYXI7rd4799je6gUt3hpTQLfOe2Dr9MxvHfV8vHis8Kl44jMlid5HyOXZ6N8xk097A45eNUnlAvsZyzfLj0aVzSK/Ft7mVZOPKgg8MxB3U95mqw4n3OiyJOC9qPgpseYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689449; c=relaxed/simple;
	bh=sSfa5mO+Tuc8WlFhLhsagE6tOSwlDbqV/IGvIAB9fvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gSgT+Zrd9XSG8YeKPpqg3ub95qr+M0QgCBHUoHdJgns8bN/6PNvWGiwNXHfIh5lakvX3grfmCI0p6YCQxJs7eHL55hcFK3k4BztArHaL/bPBXE9RSFf8q2UXBBHFkJ5AnFxnkMMFW2xC31/2QTztMGZZ8WsPvRgBp10icSrcXeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlY69wbl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlY69wbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1uMYUyGM2Qrt5nxh6GVo3Jl5MBn378JvNFc5Ca6urQ=;
	b=JlY69wbl0eI7nIOmwbKpLfxTdCo7xSHqdQJb8iqAMpEfy6zX6WwCfNJPFg9IyDZFLvwigK
	jRb212z0lxeaoxVxESEqX4t/uyCjZJgncx30eIhAwjUvsmLiEed8E2z+1z9VnIZplahQi6
	t+zkC/3RjitwXVJtFLTCRh5DUzlooDk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-15QUixeWNomufWq1I0cjeg-1; Mon, 20 Apr 2026 08:50:45 -0400
X-MC-Unique: 15QUixeWNomufWq1I0cjeg-1
X-Mimecast-MFC-AGG-ID: 15QUixeWNomufWq1I0cjeg_1776689444
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-440d0d7872aso654022f8f.2
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689444; x=1777294244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1uMYUyGM2Qrt5nxh6GVo3Jl5MBn378JvNFc5Ca6urQ=;
        b=Uws9AiJuaAx9i3b1rRI1jxYdVn5dlcnAlsZRGMuHq5V72RLukTOouLNtSrJLTCliHq
         Us7p8b2QcKqjLBOeozDc4Ffve3mAL4QK6O/sC7TgXGIb0WFD71666KCXHJlG5yfLwIHC
         6lcrckCgWpYBMvV+pOsh5QfGjGgw1tD/hXKz3ieRHzrfw/3OgEdeHDrwJTUHap2+gchn
         fUaVLTTAQ3CfoKPvSJhd2z6LEBc15TuukHph5tK130DcX1RWxMtuAoHUKNl9g1iqJDEq
         g9janpAc1SrXlU1D8akpc5EVxE/OMGpZ/SfDRbRVAHZ294W0M2LkTpZNAjX5GtCw/hMx
         ro+A==
X-Forwarded-Encrypted: i=1; AFNElJ/GxcuQxFmKk2+4seheT5b73dO3TbiMMw5Vt4ajYLi2m6ix4tV7Jtn86qsmC2KVooK8Tk5JOHwy89Z2CaDpZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYbyVZY38kBdBISSoECceg+5+E9V6+b1eUAWsqCEgwQyoi2Znp
	vlWJOjS1cwPHPZJWSjcdaIXrO1yoPyeX8sCRoHanGyD/kKuXZC3hv5mVnq1EnTsLr4u0fJKC89x
	853cVUFAfu6BJld7X+0gczCn+ri78Agdcwyg38PnxYKRUG4kbdjy4++0pIoYwceGtHaFH
X-Gm-Gg: AeBDieu94DYCSje+nC2kZcQ0AvXZ6rl08pOO90nTRCl7p/XCBLYoJrSWgiSbWUd6XdR
	Cb4QYxX3mD1yMCyNMn17DqWug/Mau6MQPGHgCs1XZmGKLOM4h+vDDtEPV/CRexKMt3GC7H7P/nc
	ewx/HSG8QlOam6QtZem0ZeRvaVCgZgoJrCKZlgYHFKmdJoQj1ajOK8KKnb5eZ9U6gWP/+H5YQKX
	WjzHHdX3QnF2no2VFRLfk09IwY129mxHO6xP85tzVCQZyw47MV0wImmFn5CJnqXr8Ot5MZYE16u
	bf/DjsYAwsz262au9z7AbxZ2fExXhR89WXgqnIBB+3fXQlWGSnwHVKqOif7vh46/8joEd5XRUDY
	0wRY7zZoct0UgNkwkT0ZIi4wsbMKaaUoJAUVQNDPmOCmxsUI636TMig==
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-488fb78ea6fmr191197935e9.29.1776689444278;
        Mon, 20 Apr 2026 05:50:44 -0700 (PDT)
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-488fb78ea6fmr191197445e9.29.1776689443758;
        Mon, 20 Apr 2026 05:50:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm466309085e9.3.2026.04.20.05.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:43 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:41 -0400
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
	virtualization@lists.linux.dev, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH RFC v2 08/18] mm: hugetlb: thread pghint_t through buddy
 allocation chain
Message-ID: <ad75b8d2d13bc92e1ee369a4a3fff646d90018d9.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Klo0wUrk_3A_M-28_nZs86joiS_iNhqin-j_euXbtCQ_1776689444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thread pghint_t *hints through the hugetlb buddy allocation path:
  alloc_buddy_frozen_folio -> only_alloc_fresh_hugetlb_folio

alloc_buddy_frozen_folio now calls __alloc_frozen_pages_hints()
so the reported-page zeroed hint can propagate up.

Add pghint_t *hints to alloc_hugetlb_folio_reserve() for the
memfd path.  Callers that do not need hints pass NULL.

No functional change yet: hints are threaded but not acted upon.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 29 ++++++++++++++++++++---------
 mm/memfd.c              |  2 +-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65910437be1c..7311ad87add4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -710,7 +710,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask,
 				bool allow_alloc_fallback);
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-					  nodemask_t *nmask, gfp_t gfp_mask);
+				nodemask_t *nmask, gfp_t gfp_mask,
+				pghint_t *hints);
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
@@ -1124,7 +1125,8 @@ static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 static inline struct folio *
 alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-			    nodemask_t *nmask, gfp_t gfp_mask)
+			    nodemask_t *nmask, gfp_t gfp_mask,
+			    pghint_t *hints)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 327eaa4074d3..faa94a114fd4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1842,7 +1842,8 @@ struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio)
 }
 
 static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask, nodemask_t *node_alloc_noretry)
+		int nid, nodemask_t *nmask, nodemask_t *node_alloc_noretry,
+		pghint_t *hints)
 {
 	struct folio *folio;
 	bool alloc_try_hard = true;
@@ -1859,7 +1860,8 @@ static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
 	if (alloc_try_hard)
 		gfp_mask |= __GFP_RETRY_MAYFAIL;
 
-	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask);
+	folio = (struct folio *)__alloc_frozen_pages_hints(gfp_mask, order,
+							  nid, nmask, hints);
 
 	/*
 	 * If we did not specify __GFP_RETRY_MAYFAIL, but still got a
@@ -1888,11 +1890,14 @@ static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
 
 static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+		nodemask_t *node_alloc_noretry, pghint_t *hints)
 {
 	struct folio *folio;
 	int order = huge_page_order(h);
 
+	if (hints)
+		*hints = 0;
+
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
@@ -1900,7 +1905,7 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
 		folio = alloc_gigantic_frozen_folio(order, gfp_mask, nid, nmask);
 	else
 		folio = alloc_buddy_frozen_folio(order, gfp_mask, nid, nmask,
-						 node_alloc_noretry);
+						 node_alloc_noretry, hints);
 	if (folio)
 		init_new_hugetlb_folio(folio);
 	return folio;
@@ -1918,7 +1923,8 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 {
 	struct folio *folio;
 
-	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+					      NULL, NULL);
 	if (folio)
 		hugetlb_vmemmap_optimize_folio(h, folio);
 	return folio;
@@ -1958,7 +1964,8 @@ static struct folio *alloc_pool_huge_folio(struct hstate *h,
 		struct folio *folio;
 
 		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
-					nodes_allowed, node_alloc_noretry);
+					nodes_allowed, node_alloc_noretry,
+					NULL);
 		if (folio)
 			return folio;
 	}
@@ -2231,10 +2238,13 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 }
 
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, pghint_t *hints)
 {
 	struct folio *folio;
 
+	if (hints)
+		*hints = (pghint_t)0;
+
 	spin_lock_irq(&hugetlb_lock);
 	if (!h->resv_huge_pages) {
 		spin_unlock_irq(&hugetlb_lock);
@@ -3434,13 +3444,14 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
 			folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-					&node_states[N_MEMORY], NULL);
+					&node_states[N_MEMORY], NULL, NULL);
 			if (!folio && !list_empty(&folio_list) &&
 			    hugetlb_vmemmap_optimizable_size(h)) {
 				prep_and_add_allocated_folios(h, &folio_list);
 				INIT_LIST_HEAD(&folio_list);
 				folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-						&node_states[N_MEMORY], NULL);
+						&node_states[N_MEMORY], NULL,
+						NULL);
 			}
 			if (!folio)
 				break;
diff --git a/mm/memfd.c b/mm/memfd.c
index 919c2a53eb96..f1c00600e19a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -93,7 +93,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		folio = alloc_hugetlb_folio_reserve(h,
 						    numa_node_id(),
 						    NULL,
-						    gfp_mask);
+						    gfp_mask, NULL);
 		if (folio) {
 			u32 hash;
 
-- 
MST

