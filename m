Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4939E182
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689433; cv=none; b=eBGp6qkmtemtXl9bRgLYadNK1A2M0cN4SAetiAUyqcyQ5yrEX9XH1oSm6E8ZMr4VK8v/UMlt/IwBsWQSEUazt3iTc1mcZ/R81lDmbRHzPMMI+QTQCVZKSrmI+Rb2p/pDE4uwwBnqb1b35hBfZ5wTbiej3WUqO4N5OM+UxZdzxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689433; c=relaxed/simple;
	bh=Pgd5pgQvAE8Ie6vlQf5xyYaFKximuIPOGMU/e9exHFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NAV7ebApMqbv0opn8tafyre5D2a7iIyqgijHhZjREL11IuuJpM0UqQhB995IX/Hf1dBicQM98pPx7nnd2+ax9mv2GV989LmooZY72kXeTVyjlIm2j3gCa8/5Ra76cjuYRraF5XdFWM/PdU7J52L28uPbb7op9WCuGZpMIa7vVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSdboorF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSdboorF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5FdBsp1kGQjyJJvapBdTNqnIIO/0keRRtcyQFKcGwU=;
	b=NSdboorFpgJaHp2iBGpSU+YfIXC9tcBLxnFkpfgrJtHGa4FxpsZuaPz6emfLRHw8zT3Xe5
	X7Oox3SohiI7kBST7pDETksZSOSgj3d1ClDoZkJXeKLmjQpZRfFNVXWr3YEw53Ax2p3CtK
	KJPuldAKfOQNF6zrEpo2QbhuHr1Bvzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-RVUOPY2LMgW6ukQiDDsinw-1; Mon, 20 Apr 2026 08:50:29 -0400
X-MC-Unique: RVUOPY2LMgW6ukQiDDsinw-1
X-Mimecast-MFC-AGG-ID: RVUOPY2LMgW6ukQiDDsinw_1776689428
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso25760125e9.3
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689428; x=1777294228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5FdBsp1kGQjyJJvapBdTNqnIIO/0keRRtcyQFKcGwU=;
        b=tSvdoqUCtDC9vkSPUv/E09sY1eDmllqjYp2lQMId9KVyd9Bu7SLd/7cCDdCPIwRU37
         gTl1ww77sHPxWN98Ou3l8yist3nx4WdoL6uAWp0erwm5eVy0BptmVHQafi0sK+9uMJ2H
         jh9mlRoY2Q8ABDn2nE/EjA0I/8M2XdnadNtqzyIDnJLp5Y7VLnEghe8Cs0zszR2nAPfo
         NsYO3Lii4+71vKpfkrzUqgzS8kSfTnxuV35/xopfpHWTrSSlqsjVx6Ez0GQYc5m3nErX
         PskhPRut76N2IY/fjYpd6ghx8azckGHaLmBSkfgvXLUZb/dakzMlExIGOi7595lUOj4V
         F3eA==
X-Forwarded-Encrypted: i=1; AFNElJ/w6CYul1aPlOlKj92ToKjuWYIE6Jp6iEIoIl4sojLcLvo9hYGrVpbeo3Php7THuBzJd0gqlLYWg4HYhMrFHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBWDj5TTcG4ei1GjhymMlTCnT2ZVXIxH7exkQe8e3y77Af2eKl
	1KzeBlQtSj9MWwCdV4hmpkOavwh4HpzMTTl0tm1EFlXk5jzmjUcFGLqUtsWTGCK90bS0i9jcJTa
	bbbMczy57awWATR/M+8kIZ0G3uZdJtaBk2+g1zoQUn8cGj68VwO1+qYD9+7fzqgOigxlK
X-Gm-Gg: AeBDietdWHvlCF8XePb94pg0Rt+45/cSVyhZyubjfV0ENs07Zsio+uHmskO0s/jDWxf
	eGu6juDWBivWJUrUb3ojxpRrl5n8WO6+YL91NOErhqM1vxqL1Cx3sk/54m5z048FkLnKmpDzjzP
	qZ0GhWy6rw1GNwLnR8Icjm0qSs7ngVxz7rIrg2JG5SvcGJwR/IclgbsXEf9X0husNz1JLoZ0iUJ
	HKwBeABkdGSIpYjNPTGsm7LJTwBk+31Kiep2AvIDyt+TiCTCjHn6wnxS5O8GIdzoKrlTjtatBWE
	VRozWNzw8xQ1gZ6D5/EnEFlLuGfuyBumy92JdUQBtMxmgFtjqWAXH+XvdxUGo/oQciNjX3hW7GT
	+hSeNEjPJMO/xBK8FKCa/JAwM76mB8g4PKg/w/el/H54oOGDs2lWS9g==
X-Received: by 2002:a05:600c:c0db:b0:485:2a4b:7bc3 with SMTP id 5b1f17b1804b1-488fb745289mr134427075e9.4.1776689427812;
        Mon, 20 Apr 2026 05:50:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c0db:b0:485:2a4b:7bc3 with SMTP id 5b1f17b1804b1-488fb745289mr134426535e9.4.1776689427197;
        Mon, 20 Apr 2026 05:50:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f4016bbsm17219265e9.4.2026.04.20.05.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:26 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:23 -0400
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
	Mike Rapoport <rppt@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC v2 02/18] mm: add pghint_t type and vma_alloc_folio_hints
 API
Message-ID: <290d615a001cf121dc0c604eb79451bcc7917baa.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: i6g08mpYUViYSX-KRzbXe3uOCk5-PPXjlOnlZryhKuQ_1776689428
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add pghint_t, a bitwise type for communicating page allocation hints
between the allocator and callers.  Define PGHINT_ZEROED to indicate
that the allocated page contents are known to be zero.

Add _hints variants of the allocation functions that accept a
pghint_t *hints output parameter:

  vma_alloc_folio_hints()  -> folio_alloc_mpol_hints (internal)
                           -> __alloc_frozen_pages_hints()

The existing APIs are unchanged and continue to work without hints.
For now, hints is always initialized to 0.  A subsequent patch will
set PGHINT_ZEROED when the page was pre-zeroed by the host.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/gfp.h | 15 ++++++++
 mm/internal.h       |  4 +++
 mm/mempolicy.c      | 85 +++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c     | 15 ++++++--
 4 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 51ef13ed756e..14433a20e60c 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -226,6 +226,9 @@ static inline void arch_free_page(struct page *page, int order) { }
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
 
+typedef unsigned int __bitwise pghint_t;
+#define PGHINT_ZEROED	((__force pghint_t)BIT(0))
+
 struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
 #define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
@@ -325,6 +328,9 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
 		struct mempolicy *mpol, pgoff_t ilx, int nid);
 struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned long addr);
+struct folio *vma_alloc_folio_hints_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr,
+		pghint_t *hints);
 #else
 static inline struct page *alloc_pages_noprof(gfp_t gfp_mask, unsigned int order)
 {
@@ -344,12 +350,21 @@ static inline struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
 {
 	return folio_alloc_noprof(gfp, order);
 }
+static inline struct folio *vma_alloc_folio_hints_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr,
+		pghint_t *hints)
+{
+	if (hints)
+		*hints = 0;
+	return folio_alloc_noprof(gfp, order);
+}
 #endif
 
 #define alloc_pages(...)			alloc_hooks(alloc_pages_noprof(__VA_ARGS__))
 #define folio_alloc(...)			alloc_hooks(folio_alloc_noprof(__VA_ARGS__))
 #define folio_alloc_mpol(...)			alloc_hooks(folio_alloc_mpol_noprof(__VA_ARGS__))
 #define vma_alloc_folio(...)			alloc_hooks(vma_alloc_folio_noprof(__VA_ARGS__))
+#define vma_alloc_folio_hints(...)		alloc_hooks(vma_alloc_folio_hints_noprof(__VA_ARGS__))
 
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 
diff --git a/mm/internal.h b/mm/internal.h
index cb0af847d7d9..686667b956c0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -894,8 +894,12 @@ extern int user_min_free_kbytes;
 
 struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
 		nodemask_t *);
+struct page *__alloc_frozen_pages_hints_noprof(gfp_t, unsigned int order,
+		int nid, nodemask_t *, pghint_t *hints);
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
+#define __alloc_frozen_pages_hints(...) \
+	alloc_hooks(__alloc_frozen_pages_hints_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cf92bd6a8226..b918639eef71 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2547,6 +2547,91 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct
 }
 EXPORT_SYMBOL(vma_alloc_folio_noprof);
 
+static struct page *alloc_pages_preferred_many_hints(gfp_t gfp,
+		unsigned int order, int nid, nodemask_t *nodemask,
+		pghint_t *hints)
+{
+	struct page *page;
+	gfp_t preferred_gfp;
+
+	preferred_gfp = gfp | __GFP_NOWARN;
+	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
+	page = __alloc_frozen_pages_hints_noprof(preferred_gfp, order, nid,
+						 nodemask, hints);
+	if (!page)
+		page = __alloc_frozen_pages_hints_noprof(gfp, order, nid, NULL,
+							 hints);
+
+	return page;
+}
+
+static struct page *alloc_pages_mpol_hints(gfp_t gfp, unsigned int order,
+		struct mempolicy *pol, pgoff_t ilx, int nid,
+		pghint_t *hints)
+{
+	nodemask_t *nodemask;
+	struct page *page;
+
+	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
+
+	if (pol->mode == MPOL_PREFERRED_MANY)
+		return alloc_pages_preferred_many_hints(gfp, order, nid,
+						       nodemask, hints);
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+	    order == HPAGE_PMD_ORDER && ilx != NO_INTERLEAVE_INDEX) {
+		if (pol->mode != MPOL_INTERLEAVE &&
+		    pol->mode != MPOL_WEIGHTED_INTERLEAVE &&
+		    (!nodemask || node_isset(nid, *nodemask))) {
+			page = __alloc_frozen_pages_hints_noprof(
+				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
+				nid, NULL, hints);
+			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
+				return page;
+		}
+	}
+
+	page = __alloc_frozen_pages_hints_noprof(gfp, order, nid, nodemask,
+						 hints);
+
+	if (unlikely(pol->mode == MPOL_INTERLEAVE ||
+		     pol->mode == MPOL_WEIGHTED_INTERLEAVE) && page) {
+		if (static_branch_likely(&vm_numa_stat_key) &&
+		    page_to_nid(page) == nid) {
+			preempt_disable();
+			__count_numa_event(page_zone(page), NUMA_INTERLEAVE_HIT);
+			preempt_enable();
+		}
+	}
+
+	return page;
+}
+
+struct folio *vma_alloc_folio_hints_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr,
+		pghint_t *hints)
+{
+	struct mempolicy *pol;
+	pgoff_t ilx;
+	struct folio *folio;
+	struct page *page;
+
+	if (vma->vm_flags & VM_DROPPABLE)
+		gfp |= __GFP_NOWARN;
+
+	pol = get_vma_policy(vma, addr, order, &ilx);
+	page = alloc_pages_mpol_hints(gfp | __GFP_COMP, order, pol, ilx,
+				      numa_node_id(), hints);
+	mpol_cond_put(pol);
+	if (!page)
+		return NULL;
+
+	set_page_refcounted(page);
+	folio = page_rmappable_folio(page);
+	return folio;
+}
+EXPORT_SYMBOL(vma_alloc_folio_hints_noprof);
+
 struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned order)
 {
 	struct mempolicy *pol = &default_policy;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index edbb1edf463d..f7abbc46e725 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5222,14 +5222,17 @@ EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
-struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
-		int preferred_nid, nodemask_t *nodemask)
+struct page *__alloc_frozen_pages_hints_noprof(gfp_t gfp, unsigned int order,
+		int preferred_nid, nodemask_t *nodemask, pghint_t *hints)
 {
 	struct page *page;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
+	if (hints)
+		*hints = (pghint_t)0;
+
 	/*
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.
@@ -5285,6 +5288,14 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 
 	return page;
 }
+EXPORT_SYMBOL(__alloc_frozen_pages_hints_noprof);
+
+struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
+		int preferred_nid, nodemask_t *nodemask)
+{
+	return __alloc_frozen_pages_hints_noprof(gfp, order, preferred_nid,
+						nodemask, NULL);
+}
 EXPORT_SYMBOL(__alloc_frozen_pages_noprof);
 
 struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
-- 
MST

