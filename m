Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066C279903
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240086; cv=none; b=FjKzDaw88hL9Z53gRR+csvhR5z5W2SRLMt1o5NokwFAi7HNEA3YQzCON9vb9c1YWkuYETG/XgguvUB2d7MmxnJEzNWQlTVKDEfJZuRm+hMdTIMO7mQZ000SFTqKbnbnh/mks6R8rvf4uAVv5sXVXD5LiyAOng4ub38djsCsndiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240086; c=relaxed/simple;
	bh=NvzxDfyhBY8HhpKlujoOhD2X7P7j0RP/UcBg8w+dASc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GnKw6zqEt0psfNaQNHtnFdze/9+0lmwXsrDd5nk8xTf47TxMaBqtc0rcX4CuP2k+PRIbHmoilvK/YwiEjNmWg6mFgewUFZxVqqM3tJBXvVJDQxpiFe4FhI7aVH6EQWLEZxWzD61yFc67SGXLk3qdGviRgXBtj9z59AfCiuSgr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCfr5suO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCfr5suO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lya+idGqxu4DlV/pLONwdjLPocorK4fxVlb4E+6fg/I=;
	b=YCfr5suOEKP7qfopaJIw10JGnMAPzUp40TQk3hKE8HSvSjSPR7uk0ulo19R3AxqDOMtMj4
	GE34EJ6MWLJt4RGhNu4TayF+h6aFEx4wDtrWN4nZaA2Idb/zSxdzPiuAa9DwpVA0Dlx9Ww
	t+B3nZXqMh4UllMhkl/QGKt5fStF50k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-4G5GwHIxPkagItDSwp2upg-1; Sun, 26 Apr 2026 17:48:01 -0400
X-MC-Unique: 4G5GwHIxPkagItDSwp2upg-1
X-Mimecast-MFC-AGG-ID: 4G5GwHIxPkagItDSwp2upg_1777240080
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-440d12a472eso6750439f8f.3
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240080; x=1777844880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lya+idGqxu4DlV/pLONwdjLPocorK4fxVlb4E+6fg/I=;
        b=acb50RySP89C1IpfL/OaaLTweMnRTrmXoEoQwUUD/ynBqbNlYLKhjSq47TU2r8g/9R
         UQQJDYz5Aw4DMgFOsGF6hHAzgmN5f3KXTEcm69MkHrn8VAScHgsN01+2LmcYANgfPbUO
         jjbKm8bhoE7iO16WKY0EWVdLe3PRCB5LkNEkbKQ4kOPxza4CwcUh4J8dl7WoGtIdle3a
         ZBcyAVG8YGjKLW4RgRPqhkVYVFIXyb+FHhYsLDWURMytt4b+68WQov9bTYKwep4Oulvp
         m/Wa8brUEyrc+LAwsN+hHz898o7butoVoa5Uf0T5fsjEpF0oBAI7967/LgwsX64abqCI
         VB+A==
X-Forwarded-Encrypted: i=1; AFNElJ8HQs234rOQWUF+VhrL0ana5o11K5DyB1JKmbyv2jWdH9R1roOgtAV79wBD9XSHKjXkFoYg5bnQcsoVgddYgA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+P2auBzpGh+lLve1SUZCs5P9Rk1fec1XGkS3IdM2lZxX96F+O
	n5x/dHBca3nPq34C9pOYKZ8SNIOF2wAkUKkxBqPIVvxCpuutbKczWj2Eo1anit3aaqWfcrGc9M8
	rnzodhndp/GuMOlWNo0XmnywOjg7D3px+d/bQrU2crAXF+JFeaB2Wi8hbnwS/3ri8Li972dA4eS
	H4
X-Gm-Gg: AeBDievBYlxG1pjR7z1DZ1l3WupV8T04zC3M7dhmqiRyGcVXkVxkWCNA2bdg0qiBFT/
	Mmcod/4tr9a+/bagrpd7BXDMaku7MLXXz38rvMGBjNKUYV4WmRbstnQI+4TzyInOEwHOKf1zaMf
	6uqvJnV/z3nY36TqxEPQ6mAKpvgezO4MJFKDJm7+nOGpMnMFQVxsBiqg+IEqH7//H+eiMn29/ep
	7ttFnqlpeb0OG+v78k/dmHStERoiINehzfAjNLaj2LEOLMbETsta8djxWeQbOijY7tS26E3xJZR
	TFUXykGAFV3vlNkWbdY3HcvXdNY7sgt9pe4iyS4wZTgVmxVQCbGKA0PgMyOXKwWK1tWfEilqKn2
	2L6Tv+JnVbaZ4dRk0ePT7TkFvWaPDDtbXjBLtOXNsmaTGsberZSA6k01B
X-Received: by 2002:a05:6000:420a:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-43fe3e0b61bmr62764554f8f.27.1777240079806;
        Sun, 26 Apr 2026 14:47:59 -0700 (PDT)
X-Received: by 2002:a05:6000:420a:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-43fe3e0b61bmr62764530f8f.27.1777240079334;
        Sun, 26 Apr 2026 14:47:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm81019233f8f.27.2026.04.26.14.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:47:58 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:56 -0400
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
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v4 08/22] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <28642fd392362fff6d84d7d16acf9653c43cbcb3.1777223007.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: TQcPaHJLCGnC9B7JjHNOo0FbAk6TZaczY2NFLoWPtTQ_1777240080
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert alloc_anon_folio() to pass __GFP_ZERO instead of zeroing at the callsite.
Use vma_alloc_folio_user_addr() to pass the folio-aligned address
for NUMA policy and the raw vmf->address for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 07778814b4a8..83ec73791fae 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4662,7 +4662,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio_user_addr(gfp, order, vma, addr,
+					  vmf->address);
 		if (folio) {
 			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 							    gfp, entry))
@@ -5176,10 +5177,11 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		goto fallback;
 
 	/* Try allocating the highest of the remaining orders. */
-	gfp = vma_thp_gfp_mask(vma);
+	gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio_user_addr(gfp, order, vma, addr,
+					  vmf->address);
 		if (folio) {
 			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
@@ -5187,15 +5189,6 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 				goto next;
 			}
 			folio_throttle_swaprate(folio, gfp);
-			/*
-			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used) or user folios require special
-			 * handling, folio_zero_user() is used to make sure
-			 * that the page corresponding to the faulting address
-			 * will be hot in the cache after zeroing.
-			 */
-			if (user_alloc_needs_zeroing())
-				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
 next:
-- 
MST

