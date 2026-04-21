Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC8C346AE1
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808907; cv=none; b=FuLXlmrR7G/hynMn9f/sZtia8RE8c3FmlwjuryYuHAPvx/EK15ghreeH7p4uDbE7SS61IqAUq6f9lu9HlA5vo8Y348Y7YDMOhVJA5NMsjkYWod/NKtGE+IzmqK5QQ8Ifkck6vO5azcyPoQdYMmElwHhzYNRNnWG0UCnfnNw9qcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808907; c=relaxed/simple;
	bh=1ejL+Z1wL5a9wUXBRiBrtQNmVFq1XngLbhmkTIDh9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nbs6pKXdMk+urWhN4yWt6S/PFVatIQMlYCli/uJflFUhKP1YWuDKxGRz/rMQN3ra4sXTYp0JUsRaWlcCAnJC+3l4056DIMpBoLsqG+81hGyB6Aj8qt2SYysLEvDB/1kMkKhFaS7a8+OtF5z9SyCL4Jdbbz/hdnj+hJXwaT3AN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVI/5Wsf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVI/5Wsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ6M8fMmd15EsU5jHzG0CofBcVEbXAB28EkZbWFSSyk=;
	b=KVI/5WsfoMDWw4SBFyeqnHy3fPl9eDrGTbOxf5ebUi8X4R+G9pP5Oxr1AspDEz9+fZDdgQ
	iGDRXFONggdyk2uEztZGe5P+vRnWO7D4bwjIXPxIkH9lJVOwZLS9Ogb2X/6S5WJWzesfxr
	etXoEef5u5YQs3R/Be3huCM9nzSup08=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-cHNe5Vs6Nb22x9_4jke7NA-1; Tue, 21 Apr 2026 18:01:44 -0400
X-MC-Unique: cHNe5Vs6Nb22x9_4jke7NA-1
X-Mimecast-MFC-AGG-ID: cHNe5Vs6Nb22x9_4jke7NA_1776808903
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4891f2eecb7so16045365e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808903; x=1777413703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ6M8fMmd15EsU5jHzG0CofBcVEbXAB28EkZbWFSSyk=;
        b=GPDMVYmMNHzlgj6cKawLwqSZVFcfGm2TysuC3dblmE9THrs7vB4h8SMcrWaSP+iAyJ
         e5OURMmwkaGqsNyfZBJ9FGSpmVrdJbtLCQDBtiArL+g/7V64JSc/5UicRUC4fmGl8Qvl
         6Rq0Km82R8fthulZYgjoydVHefJZ2U8DAffneuqQ1E80pwQ3LdBy9aQKiDFbcTilzpYE
         hXR4qLG2xGqolCY6jZE8qJBvAiB5a8s/YQybV1n6UMC5wWDVv6Nj4sjtckLn1rm+xj3i
         QCREpOiFpSx2Rw0hXG5vsyeTjIiu/h9O/nca8qiKAUXafKprdugEwmbGfJDhmD5vnS17
         VbBA==
X-Forwarded-Encrypted: i=1; AFNElJ/L0HDI3CHxQoHOq35gadoqGTDLfgBO8pwGtU6idmuGq8HMO9lk2iSXcOJfuLJQ867znc9zEiqvSYzUOoYjPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/sbLMHloI/OuSMZX4/7pPcdEpPHnNpHUEMZ+pt9Y4O9Xlm06c
	dQzu7ETFhYO/aY7YEY96tJ2pp3IUTnPWGZvx3ST4FGNFTVPEAoV7NBXl/4eJFD4mf/Vj1LNzuWL
	EzYIJSg+1Bt4UmAwA5TZT3V4udb6pIIi9tw581Dexy0UagFCGtd2Oi9M1IJ7il166o03k
X-Gm-Gg: AeBDietKJq0X8U2heljvTVL4VR5t6JypYaQrqCDk5znF0lzWo40REEsdQYdw9R+lX8B
	44AKAdlVPH0TRSXg9DvUghkcwyoMoRZ0Til1jJELqStszMYk+LCNCrGoYE5kSdiNS7Ap1FFFd29
	RT+5GH8XLGZKpjrIXU37R0IpkH5RhYZdzIakyvnxPUNG9xsFHSX6Tc84CLD3hX+qy1Zi6miQc0h
	4D86JQN+3YzqpC+heGMuJUcISq9ICYCDYjy9OWhDDJkyzblwhNMSRTFM+rZ3zeZ4sThvDR8AIyG
	bbZP0pGp9Eia274aKZ4eLAvNJcDNA6AVrT0v8g/VgE7JTiSUXDaEthfS0OVw3lKcgOY6yIK7Rnw
	nieq0ChsxjdDlMWsyhk8gZCnYzr6QaAo0ZC5hEUtjbfR5QVDuX1aFVQ==
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr57313235e9.7.1776808902987;
        Tue, 21 Apr 2026 15:01:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr57312985e9.7.1776808902531;
        Tue, 21 Apr 2026 15:01:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm42637228f8f.7.2026.04.21.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:42 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH RFC v3 09/19] mm: memfd: skip zeroing for zeroed hugetlb pool
 pages
Message-ID: <d5bc27ec04ea4d7a9322315fc44c15651e31c53e.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kivkWvgkfG45SOOfEqF96kacrZwveZyhCA8SyFiS88g_1776808903
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gather_surplus_pages() pre-allocates hugetlb pages into the pool
during mmap.  Pass __GFP_ZERO so these pages are zeroed by the
buddy allocator, and HPG_zeroed is set by alloc_surplus_hugetlb_folio.

Add bool *zeroed output to alloc_hugetlb_folio_reserve() so
callers can check whether the pool page is known-zero.  memfd's
memfd_alloc_folio() uses this to skip the explicit folio_zero_user()
when the page is already zero.

This avoids redundant zeroing for memfd hugetlb pages that were
pre-allocated into the pool and never mapped to userspace.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 11 +++++++++--
 mm/memfd.c              | 17 +++++++++++------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 094714c607f9..93bb06a33f57 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -713,7 +713,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask,
 				bool allow_alloc_fallback);
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-					  nodemask_t *nmask, gfp_t gfp_mask);
+					  nodemask_t *nmask, gfp_t gfp_mask,
+					  bool *zeroed);
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
@@ -1128,7 +1129,8 @@ static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 static inline struct folio *
 alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-			    nodemask_t *nmask, gfp_t gfp_mask)
+			    nodemask_t *nmask, gfp_t gfp_mask,
+			    bool *zeroed)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4f0ed01f5b13..f02583b9faab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2241,7 +2241,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 }
 
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool *zeroed)
 {
 	struct folio *folio;
 
@@ -2257,6 +2257,12 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 		h->resv_huge_pages--;
 
 	spin_unlock_irq(&hugetlb_lock);
+
+	if (zeroed && folio) {
+		*zeroed = folio_test_hugetlb_zeroed(folio);
+		folio_clear_hugetlb_zeroed(folio);
+	}
+
 	return folio;
 }
 
@@ -2341,7 +2347,8 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		 * It is okay to use NUMA_NO_NODE because we use numa_mem_id()
 		 * down the road to pick the current node if that is the case.
 		 */
-		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
+		folio = alloc_surplus_hugetlb_folio(h,
+						    htlb_alloc_mask(h) | __GFP_ZERO,
 						    NUMA_NO_NODE, &alloc_nodemask,
 						    USER_ADDR_NONE);
 		if (!folio) {
diff --git a/mm/memfd.c b/mm/memfd.c
index 919c2a53eb96..b9b44ed54db5 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -90,20 +90,24 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		if (nr_resv < 0)
 			return ERR_PTR(nr_resv);
 
+		{
+		bool zeroed;
+
 		folio = alloc_hugetlb_folio_reserve(h,
 						    numa_node_id(),
 						    NULL,
-						    gfp_mask);
+						    gfp_mask,
+						    &zeroed);
 		if (folio) {
 			u32 hash;
 
 			/*
-			 * Zero the folio to prevent information leaks to userspace.
-			 * Use folio_zero_user() which is optimized for huge/gigantic
-			 * pages. Pass 0 as addr_hint since this is not a faulting path
-			 *  and we don't have a user virtual address yet.
+			 * Zero the folio to prevent information leaks to
+			 * userspace.  Skip if the pool page is known-zero
+			 * (HPG_zeroed set during pool pre-allocation).
 			 */
-			folio_zero_user(folio, 0);
+			if (!zeroed)
+				folio_zero_user(folio, 0);
 
 			/*
 			 * Mark the folio uptodate before adding to page cache,
@@ -139,6 +143,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 			hugetlb_unreserve_pages(inode, idx, idx + 1, 0);
 		return ERR_PTR(err);
 	}
+	}
 #endif
 	return shmem_read_folio(memfd->f_mapping, idx);
 }
-- 
MST

