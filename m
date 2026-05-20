Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1B3C3459
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315741; cv=none; b=XOm56RZGscf1/RaGEUhPmWubFOProV3CpTptwwjaLonAn1EpaAGBH7XY7GVuMqMpp5rdfUt18KsUePGVq4f4d2d6+zf4WhiDXtBC58X4vJcGaluH6quh9G/n9xx5UKVkb+tlWzP4VLt7fnnfThjKQA4IcQV9WB63BtcBEfKQn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315741; c=relaxed/simple;
	bh=MOLGrRKYtAzXHsjQPObl4upRAuBjzhEEowJkGu/kpHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HhTO30Ly1kkw2TZdV0cp1AeykvnHzJ/XtgYUntBQLbf7WlXXbANI4u2A3pnv0HhIDTgKXjcOJc6Di34dok1in9pVl0BG8PcSwWeutbMmGxshIVMSALwjt5b1sOitOBzRuNKDYUqCUxkfyV6YKIezSD+x8SxrmPmbnQsaJOWjfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqCgxNZ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqCgxNZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFnBVDBDzVeV9p9dYXmJ4JPUR3YMu/6T3H2GlWvoQjs=;
	b=gqCgxNZ4pPWItivvm6csFx3m0NiRc5w6Djv2sk6b3VrB0bdOSEKJs3aPnN79Hy1m+Y3dge
	IAYsxcRBQUPa8An7Ndbg+ZCaiHTl31H6o2cNiLAtOsosv05wnG5DsOf3w0e7xV3WZHxnWO
	oSYzx0+u5zcEEyLffByaVphyaQ6eyFY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-29lSy6u3OnGFjvz5GvobEw-1; Wed, 20 May 2026 18:22:18 -0400
X-MC-Unique: 29lSy6u3OnGFjvz5GvobEw-1
X-Mimecast-MFC-AGG-ID: 29lSy6u3OnGFjvz5GvobEw_1779315737
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48eb0da933fso39142415e9.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315737; x=1779920537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFnBVDBDzVeV9p9dYXmJ4JPUR3YMu/6T3H2GlWvoQjs=;
        b=qAEvCttHychUtwMZSBIZc2qAgJjfUese+5rpbI6Ar6qaJdoLK/FMC6MkR2t23RaT9c
         Syiz6rZ5CaLMO1EcOpVgXbuIHk1yfQlmPmxVsa1fj7ROYDXwkkeImVF3ztPlqJcjFDu4
         a80NZUfcPZdz1YF2zotpdY/U/GED069PCMSfbPAbLi2fDYLMjc/nbwal8xx1vLhVP0Gi
         +M2ebIU+3kL7rAgyFmnyfBnzSN4Ysz6qxA17jquH/zy++MWNQOCZDve3j3MU2y72siT4
         kEO+C3mhqcFual7BJ2AL4XCetF56Wh2MzLj6fNwT+FTP0P9OEhJnfpaLb9ZDdBP0wbYY
         Lq+w==
X-Forwarded-Encrypted: i=1; AFNElJ8B/m4ReezS3LF8ZE8qrnKxtdsymzGERlfYYSSkXpVlBwGQUIoN895jnbkuioOE+HSXiobnli8eYH9lxioLzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRUDhLdky3zIv6U0nt3a4C42HtGLcqltRPSUK7Cwoh2Kv/jfSd
	eFCfXMxH9JMOxIEOtvgnM6NeIvwJel3ghfP4FMH/elo5IEOKE6ybuLZ6o99ySK2/jky9bbpy33q
	gHsjWn00v/MqX6Ne8KSTIKeWMdblxLbdggga6ziU9bnq+2Bu4BRytLI683B3TSX3ZrdWT
X-Gm-Gg: Acq92OF0C8uZEJPbm2HCFnDt+O5SHjw7Dblee0x2xrVmk0v3/26J5Rr432bwE5HlNYE
	tSoMqnzIyzbCbXiSu2TI1CS3xtyCaDbqLF+aEWdK073gpYjBASf0T+TGhgQ6G9bqFKLPnzOBlrz
	U/fHrUzHgk2bI8To7KLCdA+hasFUWwFAZ8pLRacSYpdTbZowVMbfkcGAd+QOtdc3iOKTvQKh/ah
	+eqLOKGHN639jDRn9uveZjhMeh5WcxPLl7gSHM1Jz+6hhW786VmmxCzSEhTnTY7JA8WnrEfvV4E
	Gn6DkPQhqQY4VvrKNbc3ah1ipBUza+Z5wDuBcDEzdz7ZZPKTiNFevCyBKLXdswsamQuCXFIpamJ
	jwDdB6RIe5OltcME/h13cTft2yfu34l+O0r1z4jMiS2hj+bmd/vZ8Qw==
X-Received: by 2002:a05:600c:32af:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-4903605e3damr1811745e9.10.1779315736854;
        Wed, 20 May 2026 15:22:16 -0700 (PDT)
X-Received: by 2002:a05:600c:32af:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-4903605e3damr1811475e9.10.1779315736278;
        Wed, 20 May 2026 15:22:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d2fd6bsm20770385e9.1.2026.05.20.15.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:15 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:11 -0400
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
Subject: [PATCH v8 20/37] mm: hugetlb: add gfp parameter and skip zeroing for
 zeroed pages
Message-ID: <4eb3feb0a01adc0f2f68e0d0ebf48a43e28c00f1.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xXAJhlhGacg4hhWoHa96wkFqyvLzj1rPg2L-hZihYxY_1779315737
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a gfp_t parameter to alloc_hugetlb_folio(). When __GFP_ZERO
is set, the function guarantees the returned folio is zeroed:
- Fresh allocations (buddy or gigantic): zeroed by
  post_alloc_hook via __GFP_ZERO, HPG_zeroed set by
  alloc_surplus_hugetlb_folio.
- Pool pages with HPG_zeroed set: already zeroed, skip.
- Pool pages without HPG_zeroed: zeroed via folio_zero_user().

The address parameter is renamed to user_addr; the function
aligns it internally for reservation and NUMA policy lookups.
For pages that need zeroing, user_addr is passed to
folio_zero_user() for cache-friendly zeroing near the faulting
subpage.  All callers pass a page-aligned address; the
hugetlb_no_page caller passes vmf->real_address & PAGE_MASK
for consistency.

HPG_zeroed (stored in hugetlb folio->private bits) tracks
known-zero pool pages. It is set when alloc_surplus_hugetlb_folio
allocates with __GFP_ZERO, and cleared in free_huge_folio when
the page returns to the pool after userspace use.

Suggested-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 fs/hugetlbfs/inode.c    |  3 +--
 include/linux/hugetlb.h |  5 ++++-
 mm/hugetlb.c            | 42 +++++++++++++++++++++++++++++------------
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 8b05bec08e04..5856a3530c7b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -810,13 +810,12 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * folios in these areas, we need to consume the reserves
 		 * to keep reservation accounting consistent.
 		 */
-		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false);
+		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false, __GFP_ZERO);
 		if (IS_ERR(folio)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			error = PTR_ERR(folio);
 			goto out;
 		}
-		folio_zero_user(folio, addr);
 		__folio_mark_uptodate(folio);
 		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f016bc2e8936..49e5557d6cc0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -599,6 +599,7 @@ enum hugetlb_page_flags {
 	HPG_vmemmap_optimized,
 	HPG_raw_hwp_unreliable,
 	HPG_cma,
+	HPG_zeroed,
 	__NR_HPAGEFLAGS,
 };
 
@@ -659,6 +660,7 @@ HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
 HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
 HPAGEFLAG(Cma, cma)
+HPAGEFLAG(Zeroed, zeroed)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
@@ -706,7 +708,8 @@ int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 void wait_for_freed_hugetlb_folios(void);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				unsigned long addr, bool cow_from_owner);
+				unsigned long user_addr, bool cow_from_owner,
+				gfp_t gfp);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask,
 				bool allow_alloc_fallback);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3a6afbe99116..4ccf4eb91d92 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1712,6 +1712,9 @@ void free_huge_folio(struct folio *folio)
 	bool restore_reserve;
 	unsigned long flags;
 
+	/* Page was mapped to userspace; no longer known-zero */
+	folio_clear_hugetlb_zeroed(folio);
+
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 	VM_BUG_ON_FOLIO(folio_mapcount(folio), folio);
 
@@ -2113,6 +2116,10 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 	if (!folio)
 		return NULL;
 
+	/* Mark as known-zero only if __GFP_ZERO was requested */
+	if (gfp_mask & __GFP_ZERO)
+		folio_set_hugetlb_zeroed(folio);
+
 	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * nr_huge_pages needs to be adjusted within the same lock cycle
@@ -2176,11 +2183,11 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
  */
 static
 struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
-		struct vm_area_struct *vma, unsigned long addr)
+		struct vm_area_struct *vma, unsigned long addr, gfp_t gfp)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
-	gfp_t gfp_mask = htlb_alloc_mask(h);
+	gfp_t gfp_mask = htlb_alloc_mask(h) | gfp;
 	int nid;
 	nodemask_t *nodemask;
 
@@ -2877,16 +2884,19 @@ typedef enum {
  * When it's set, the allocation will bypass all vma level reservations.
  */
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				    unsigned long addr, bool cow_from_owner)
+				    unsigned long user_addr, bool cow_from_owner,
+				    gfp_t gfp)
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
+	unsigned long addr = user_addr & huge_page_mask(h);
 	struct folio *folio;
 	long retval, gbl_chg, gbl_reserve;
 	map_chg_state map_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
-	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
+
+	gfp |= htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
 
 	idx = hstate_index(h);
 
@@ -2954,13 +2964,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
-		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
+		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, user_addr, gfp);
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
 		list_add(&folio->lru, &h->hugepage_activelist);
 		folio_ref_unfreeze(folio, 1);
-		/* Fall through */
 	}
 
 	/*
@@ -2983,6 +2992,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	spin_unlock_irq(&hugetlb_lock);
 
+	if ((gfp & __GFP_ZERO) && !folio_test_hugetlb_zeroed(folio))
+		folio_zero_user(folio, user_addr);
+	folio_clear_hugetlb_zeroed(folio);
+
 	hugetlb_set_folio_subpool(folio, spool);
 
 	if (map_chg != MAP_CHG_ENFORCED) {
@@ -4991,7 +5004,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new_folio = alloc_hugetlb_folio(dst_vma, addr, false);
+				new_folio = alloc_hugetlb_folio(dst_vma, addr, false, 0);
 				if (IS_ERR(new_folio)) {
 					folio_put(pte_folio);
 					ret = PTR_ERR(new_folio);
@@ -5520,7 +5533,7 @@ static vm_fault_t hugetlb_wp(struct vm_fault *vmf)
 	 * be acquired again before returning to the caller, as expected.
 	 */
 	spin_unlock(vmf->ptl);
-	new_folio = alloc_hugetlb_folio(vma, vmf->address, cow_from_owner);
+	new_folio = alloc_hugetlb_folio(vma, vmf->address, cow_from_owner, 0);
 
 	if (IS_ERR(new_folio)) {
 		/*
@@ -5780,7 +5793,13 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				goto out;
 		}
 
-		folio = alloc_hugetlb_folio(vma, vmf->address, false);
+		/*
+		 * Passing vmf->real_address would work just as well,
+		 * but PAGE_MASK helps make sure we never pass
+		 * USER_ADDR_NONE by mistake.
+		 */
+		folio = alloc_hugetlb_folio(vma, vmf->real_address & PAGE_MASK,
+					   false, __GFP_ZERO);
 		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
@@ -5800,7 +5819,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				ret = 0;
 			goto out;
 		}
-		folio_zero_user(folio, vmf->real_address);
 		__folio_mark_uptodate(folio);
 		new_folio = true;
 
@@ -6239,7 +6257,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false, 0);
 		if (IS_ERR(folio)) {
 			pte_t *actual_pte = hugetlb_walk(dst_vma, dst_addr, PMD_SIZE);
 			if (actual_pte) {
@@ -6286,7 +6304,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false, 0);
 		if (IS_ERR(folio)) {
 			folio_put(*foliop);
 			ret = -ENOMEM;
-- 
MST

