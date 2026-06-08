Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562E3BC667
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907973; cv=none; b=bDa4FfiAM4gOvmUMq6Rll9NzPLzvS+iCEnfP22rNyTrV1pzfc8h5TQ6qpefuK1s1HEiBjHLepaAr3UCs+i4jX7L7CCoTHf3kXCHML65E7dZFrTHwGfJmDqfW9NCeJWVABhDKBnIBvUldlfaidotjeZC+cThqsqCaVjW65i7iZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907973; c=relaxed/simple;
	bh=GbupeTEyC1nYpB3GHTrtS/PPh02DP7xvsmjmQMrjGAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ts6/CkEvy9EX/glT/w2BbmVNDu835a/6uov9iwkQb5jQprDPpfH6A141op0NFH0cQGXm3QmyN5KZP4NhbDV56IppX6wGTwvEeaBhkyz/Fwh5yatzGncPgnxxq8ilPZJdHDKlVscpnK6qM0dX9+3ASlKhXjXrf3xepEwrF22hBFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHJitiSA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHJitiSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jfQ8iRnJTK4n0bEkv49q5EiiPzQx8wAqaRkFNFNqcuU=;
	b=QHJitiSAGIkYxYAfamx5tcTCRJ7UAOQscQit0c27jeE4rUHHdZJUbBnZGqTJ3lCRYnzxat
	1IpaKlhtTHMBBSa80/v/tL3+eIzxck7wititercGjW/T6qI0I06Yx4JeA+Phc0Qd12Hasq
	XsEeXSXSBtHPHWVSFi0LZceu4QtO/Jw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-ehOYfecsNr2ax9oZ7ggjnw-1; Mon, 08 Jun 2026 04:39:27 -0400
X-MC-Unique: ehOYfecsNr2ax9oZ7ggjnw-1
X-Mimecast-MFC-AGG-ID: ehOYfecsNr2ax9oZ7ggjnw_1780907966
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4908af8d7f9so23275215e9.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907966; x=1781512766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfQ8iRnJTK4n0bEkv49q5EiiPzQx8wAqaRkFNFNqcuU=;
        b=k2lJX68FiFWKUlzAd9u5qpU2BnGaPwepklZoonwtXK/iF3pirMzuLHSUCb/3dxKuO+
         9fVbqYggM6JvQ2b83Zz0o+eZsJoQAJdjcGxaEOK7eMH56BKDFzK66a7nVd+JzUUcabMK
         8dpCO2HSo7nsrMZqVGXmMHFHCCoR0INsQw/lvOD27MXYMqZJ9ph1/cGESvWxFJRkjSFB
         s5xzgcDVAK9YErr5sfWspetJhp0xGGcGrKuy8M4mZxpTlDjy0s9DEpDjpF+29l38K/Gd
         IiwZ6ZHewsyVcszrKB4K9zGga1E5kYfw03IPNrKH0LC4F5xs9vxK9j0k1uBOtVhRwaf9
         wPrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gC+tgwXzUxlUIDFkSHcwfJMzXgBEitpevCtv7KTW1daWj+NXGXVcf2w4wXDdis4TXhNRsFx1MttD/eclcRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS8TTq1/cqIcV5jWYQcMdaiZCBdwENUg3sIBWqOhJHdrH47Y/P
	jVAkoyIqsGyKzya8qmSGW1VTr8QLnNABV8REHnmUmr6abGwdQ2ZQfBCUpAeP0+UbvA9nXZSMEKd
	pZZ2U4huJFmutmOPeKGPUohgF0GVEE9LFW9n99GlT3IpNBr3uGGUjSmY8zvoTODqbwBI1
X-Gm-Gg: Acq92OEGrvv7tWmF+PzY0WPEtXhsm2ggZsLziIFGjfxWmPiDCMzFlvOPJ+6MKWEVTlU
	adHLv/th7GnwFCfbkIMyQ7XluS9AErG0RJOKHKCBuJAYT+Mb1msxD6wiP+JZet0mtVb/eMokJ5D
	Y3qiTsvCI/966jaJQLXZ3qNcJ+LZex2Mi1YGifoTxked60DIwG7I0PoBvUP1imoqbdvXWVLpOKL
	Fo+VTVrd2ifOkFqzYTij+Xy3DW3A5+ePK+7cVlGWUqoqXrK2BCxwGaik084rE86fq+Ij+jePlzr
	Nzy2tZ5+ooWy7M5sYCWGcoR/XT04F7fcCGraLlA8kZ2LvlPXuEWzjZXxCByqi9h/9oexjumC9Hz
	XmkMg/8GP4/E0s2jYOy9A8Zw=
X-Received: by 2002:a05:600c:8b70:b0:490:ae94:a7e6 with SMTP id 5b1f17b1804b1-490c25c20e0mr225776965e9.24.1780907966188;
        Mon, 08 Jun 2026 01:39:26 -0700 (PDT)
X-Received: by 2002:a05:600c:8b70:b0:490:ae94:a7e6 with SMTP id 5b1f17b1804b1-490c25c20e0mr225776435e9.24.1780907965793;
        Mon, 08 Jun 2026 01:39:25 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d30eeasm239643575e9.1.2026.06.08.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:39:25 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:39:18 -0400
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
Subject: [PATCH v10 27/37] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <2ee827fed4765a155d2b56bb0e13d7ee5fc6dce8.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 525AdcsANMEywON_lodVRnZ_nXrk7xsEkMqdr4ZLDw0_1780907966
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
zeroing at the callsite. post_alloc_hook uses the fault address
passed through vma_alloc_folio for cache-friendly zeroing.

Note: before this series, replacing folio_zero_user() with
__GFP_ZERO was unsafe on cache-aliasing architectures because
__GFP_ZERO uses clear_page() without a dcache flush. With this
series, it is safe if the caller passes a valid user address
(not USER_ADDR_NONE) to vma_alloc_folio() etc., which delivers
it to post_alloc_hook() for the dcache flush via
folio_zero_user(). It is only unsafe if USER_ADDR_NONE is passed.

Note: with __GFP_ZERO, the folio is zeroed before
mem_cgroup_charge().  If the charge fails, the zeroing work is
wasted.  Previously zeroing was done after a successful charge.
This is inherent to moving zeroing into the allocator.
Charge failures are rare (only at cgroup limits).

Use folio_put_zeroed() on charge failure so the zeroed hint
propagates to the buddy allocator, avoiding redundant re-zeroing
on the next allocation attempt.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
---
 mm/huge_memory.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d689e6491ddb..0dec3c717ff2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1333,7 +1333,7 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 		unsigned long addr)
 {
-	gfp_t gfp = vma_thp_gfp_mask(vma);
+	gfp_t gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
@@ -1347,7 +1347,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
-		folio_put(folio);
+		folio_put_zeroed(folio);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
 		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
@@ -1356,17 +1356,9 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-       /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
-	* or user folios require special handling, folio_zero_user() is used to
-	* make sure that the page corresponding to the faulting address will be
-	* hot in the cache after zeroing.
-	*/
-	if (user_alloc_needs_zeroing())
-		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
-	 * folio_zero_user writes become visible before the set_pmd_at()
+	 * page zeroing becomes visible before the set_pmd_at()
 	 * write.
 	 */
 	__folio_mark_uptodate(folio);
-- 
MST

