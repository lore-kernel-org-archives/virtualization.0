Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E135898
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240094; cv=none; b=AtIkhVL8CvToV6o6ewo9SHLHXKqYrpgPkUhsU6t9Z6mcVCzni4XwxpAwPT3JgNeLZzudvv8fPXMThr14Z6y+1Vwgyz53HXcQ9zgXqdToe75pu+hhSlBnUwTAA3IV9SVhQj149CXBq4TxPCnRXsCOE6tBsHHyymEL3/ve9/s2sMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240094; c=relaxed/simple;
	bh=1ejL+Z1wL5a9wUXBRiBrtQNmVFq1XngLbhmkTIDh9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nGx50oQphFdfvOShNHDiIOOx31Q2/bOygHRgDLEdBFNc1q2A+Sqqo+dRQPm4NwzrbD+bPKeZaR/Ct0Du+ZgxWnSvxNW2N078IYiKXSh6pKcGzqF/7HgNIBoOxBf/OMvRoAMLjUuACOYLo0Hz5IOFpFyMt2/040WVHTHNmcxdh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHuSpHsP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHuSpHsP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ6M8fMmd15EsU5jHzG0CofBcVEbXAB28EkZbWFSSyk=;
	b=KHuSpHsPoYA6DfHg3tVHcdvuH7TlR17TuA2VosOtbJ6uyCtNhDbKtEmrke4DDL7nXCMdzn
	9zS6HWp8Y5Rp/3rfGGz66AocEH28eyOVVZh5RpwJxiW7NYnQMKdGTttFbPEAJ9JFiMQEGA
	OHQox3asDBxGkaD4PSlMQdZN0PZJBtc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-9EW_HUEzNWeIfnnawellEQ-1; Sun, 26 Apr 2026 17:48:10 -0400
X-MC-Unique: 9EW_HUEzNWeIfnnawellEQ-1
X-Mimecast-MFC-AGG-ID: 9EW_HUEzNWeIfnnawellEQ_1777240090
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d780757eeso6032786f8f.1
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240089; x=1777844889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ6M8fMmd15EsU5jHzG0CofBcVEbXAB28EkZbWFSSyk=;
        b=TbD57MeGRoKBfdNQtxyx/xd2VR2YQgwh7mDGvx6ej3qCJCFDIx015YnMe9AvxX78k8
         vpbfz7xMvE+MiaqK4/oKjaj+xGcG+NxQ9IxKnqr8PaV+fyKQmXjHm3XBWtlNT93cc5eS
         B+7GEauLL0wQCy1sWsPMpx6NUopLmpa+SQo/iGqVg0qIpgIqLtTCkyy5Opmda5+YIaEZ
         Y2hODA8EbzEQVpm/Pqd5yVde43OCkBzuT8xdQq1268/SMluGeLSBevTIP1mLOWqh48q5
         Z1EzFzQfX87/mFnhHUDQneD1pt8X66mP4k3T2MTPCSZ2GpnkPSS+n9KYLAmQa38KW50V
         Fzzg==
X-Forwarded-Encrypted: i=1; AFNElJ/R8o42t/3+RfZVyVLJqDmSTXSGr5qR/aRLEjUXjMRE+gc/XppnrD4kRGCHC+eHmbtK8QUpz7uperpSk081fA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQWaozCNXCNB31gyDje1YOg+a9c6/vsv3uR0i8DIrAJCbApS1U
	KKlagbjMNk7phtDJ+/XBYw4Vqsv6YxKKql++JkgIgGk1PJE02arI4JxR+63r89rGxQrxv48cuCc
	Zq0SE/iGrCo4DHKUrkaQnApUT7cSpr+Gu91LhTaId+Y9lKmpGjRBJop3zEj1QKrz9SBJd
X-Gm-Gg: AeBDieu3Xqir/kAGypHcnCPWLoZQ8Wezkch03JzwOO86xB1M9W0D75pia4uhB42v2eR
	1MdO+eH9ZJ2sZ7EsZ4XmVEPS4jBvltja5ThXE/xiPcplWCuXaxD7nMNOdLBzxVId+fZABa+V5a7
	vzlpZE99FR69XH1T7G52up4AihaUNdNX5u//wweIA/JNi8vOY4+GPb0WChInysIB2FFhdJW6zra
	WnMhuVQGM6fOJMxAOvhhTzeiBPgahOSDtJe55ZLmd+1CPPlUXZxep1QuK6ai/che7rnwsIld4/Y
	CdICZnrbT8Uok4XJrY0uycw/JNBE9+yCoxMnvV9b4WT7/d07ar7cX8gyCfRQ9jkNp6UB7/9KQXS
	1twTmGdhBoo9yA52Hws8XZXBx+zNyuVoV7kcdI9HJjEEmj7d8uSP6j5wr
X-Received: by 2002:a5d:5848:0:b0:439:bee4:8a93 with SMTP id ffacd0b85a97d-43fe4073758mr63737397f8f.12.1777240089533;
        Sun, 26 Apr 2026 14:48:09 -0700 (PDT)
X-Received: by 2002:a5d:5848:0:b0:439:bee4:8a93 with SMTP id ffacd0b85a97d-43fe4073758mr63737360f8f.12.1777240089089;
        Sun, 26 Apr 2026 14:48:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm76655583f8f.12.2026.04.26.14.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:08 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:06 -0400
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
Subject: [PATCH RFC v4 11/22] mm: memfd: skip zeroing for zeroed hugetlb pool
 pages
Message-ID: <abaa072a630ce322bd4c3c0ab2147051136c617a.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hm6TAlQjdWBR46zE9N00s2xAjtOUmIhg78sUYsgCR4s_1777240090
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

