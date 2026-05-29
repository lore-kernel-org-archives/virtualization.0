Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62F3DA7D7
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068247; cv=none; b=p8TeR5d9koYWE6V63bV1yhLfpU9RWJJEC5gRj/ZH71IEcRAbB+9nYzwRVCBmyFbKo24AMljeamod0CwT/MbrKO3mQvNXKxzXSQOQcZbCRkZ+Ero6U2IKXR96Tm+lZctrH1tI24y9HMTEsPc9VfgwdpUk2FBoriA8kID/nkc55UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068247; c=relaxed/simple;
	bh=xLQXzmmGjvEYiJuwU2B0ROV9KzzjJEnYf6CxLCTRo/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UGrPIQaRt+rIHGZUCeXSoPiBVJnhDeVGWvSXoSUqDpIj5/5C471UDU5yHZEzaX0mfPkTYN/AiDnvl0T5bO8VFra1SmorSkLbrxgX2ti1W5RD6xmNi2XuFN8MPYmZ/SWGixKciZlreMGRm+WeGI7DDgCGYeJNG9Ftw45TE0vFFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivKOvE5I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivKOvE5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8FgYlTim+1qafXpBvmXgDRFgmjZT3BzBxl1fqmzl20=;
	b=ivKOvE5IumAu6zBp2sy/LwrAw4gvCQ7dDc1mIPzV8A8GFzGlclvZYXm+OarE5s6plf+nLG
	a0ShWOYD0vdIdBis7kbLm51PUUXnfbYeZeXS6PCaOTpq7jejX7egLrEiuRuub4EYYK89Io
	dXmrjSjWCkIlaXYbbDHyPSCBymBMzzs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-7cz7YQgvOZyB-QT7MUhmtg-1; Fri, 29 May 2026 11:24:03 -0400
X-MC-Unique: 7cz7YQgvOZyB-QT7MUhmtg-1
X-Mimecast-MFC-AGG-ID: 7cz7YQgvOZyB-QT7MUhmtg_1780068242
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef5ba50aeso268198f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068242; x=1780673042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8FgYlTim+1qafXpBvmXgDRFgmjZT3BzBxl1fqmzl20=;
        b=iSYoKFAG/1AbZz7G+jYJnEFUjFTYpyBu/W+G5QppLK3i1yZECirOn8J/vBVY56nqUu
         VMSlMnoxsE5G1XsD7rRAEGvbnUh88mrTjzy0jq2Mmj55yr74pO42iBgr8+BU1eSkCemY
         t3BYDYsZygaumQ4inuqc8xWNpx8CYWnKtCSx48uueNzi6rLY7cpKZXZLRjIGtTWgACMu
         NuA23S1lbCFYA4xk9MWg2Iw9H+e4KkHneRjYSVot9oxMQo+V1JpQA8EG1if0mLMJlWMM
         HhM814hfuL6Hg6yw4CZL6LboRa67Ba5M2QqjMSLwfI2Bqn5KpL6Y3fdTFs2Izgjw+vt0
         1Gxg==
X-Forwarded-Encrypted: i=1; AFNElJ8wqTr4VOVvmiEcHwelBTAbetDtqRKMShzOtWBfuJZ9ZBK+W363BjO2j4uZz3oI+Y+az6S+1gICYs/EZPtYOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwuY0yBQ15jioBY+1q0dr+DgEjbxOaMYwSAYUcd85FXE8/fKbJ
	x6C5zExd4l1Rdm5lMFZwa6Wqd5WeLky7uE20RxLAhaGMddrybspPbeCgBG0vNLd34dV7oRLUWAM
	a6Q3kvMZZnwvL197gcxirIAg/klHP6/kEqd0VlrQ8QncM8VEFZeQv2MzvCc7j9l9UPw86
X-Gm-Gg: Acq92OGJaa+khyeWT4p07sqD/jWyYLbJ7MSzpT3eBWUZd/n0sgLao5ZoSDvy/YDGqt+
	1TbCNgUItu7OgekfStAhE+zK59T6CnuzrR+Qs+CYzWmgs9h828E+zpVlqDdiWfs+yBF6uv8z6tq
	uIem0yvx+HQt/OWMawoj4Fw1Dy1Twyhm00mrT9ahw4rC7wOR9eoY4TNwxwnYJgKY2d0LiKKBTel
	rpxTwJzt3v9XcuQxLGDnFZ0P4qDtDu0JJVjzPYjFRHm488THziTbqs7TX8K+MjMB4rRiMhqAlzx
	pX0nFPUv6UFsuYhsrBpzfJzXedE8zj8oFKOMU7udKSbsb4V0f9MsOuDBawZolqK2448oGb3JZqV
	wYhyviUl48bw0IBuC1RgETzY+IiEYsmOHHRzgKgbBZ0E2+UubCJ5jmQ==
X-Received: by 2002:a05:600d:6445:20b0:490:4f91:5519 with SMTP id 5b1f17b1804b1-490a2958db9mr849275e9.18.1780068241692;
        Fri, 29 May 2026 08:24:01 -0700 (PDT)
X-Received: by 2002:a05:600d:6445:20b0:490:4f91:5519 with SMTP id 5b1f17b1804b1-490a2958db9mr848535e9.18.1780068241185;
        Fri, 29 May 2026 08:24:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c104920sm16482535e9.21.2026.05.29.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:00 -0700 (PDT)
Date: Fri, 29 May 2026 11:23:56 -0400
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
Subject: [PATCH v9 19/37] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <6dcf0045e069812ef06a71ebcf67ef0c819eb51d.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: NQ7FmPVw0wjw3aVgu3Cog3cvuej_fcXdy7oWS9ywshc_1780068242
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
zeroing at the callsite. post_alloc_hook uses the fault address
passed through vma_alloc_folio for cache-friendly zeroing.

Note: with __GFP_ZERO, the folio is zeroed before
mem_cgroup_charge().  If the charge fails, the zeroing work is
wasted.  Previously zeroing was done after a successful charge.
This is inherent to moving zeroing into the allocator.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
---
 mm/huge_memory.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d689e6491ddb..4978d34532ea 100644
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

