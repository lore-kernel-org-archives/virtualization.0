Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9E3A16BE
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689452; cv=none; b=t+GbcfCks9uFwEmTuQXqevj4MwiBBarBFVua5bksehQl/67vjPGpKb+TXXTWI5xXnvY7ZL0p+Cz6srXrJK+g83EUquL3a5aVS81rFOYvXvYibEMOq3OAkJbrr7Taz9+Z0SKQM8rDOGoYieFRaO0mY4F3bgXFYB6NJJOpFrJiYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689452; c=relaxed/simple;
	bh=Iqo+uRjUW8vQWkIcCauoHPwk80gsXmFn7kTaAYxVOHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lctaepoi4U/9WKTn/uK3RfQ3UO0a573FOgdWDOCGIofcddn9J8pZ7gFvBzM4Dr/auQH+I5eN1Z38nvLw7xiVmraCv5AsqR/ePLqiYnl7xdyP3n8n2tfBezcrLiEEtjTLoU07Mj4aIDfoW7TxU2Yna/urEzkj0ZJNt81hJ0QqG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dX8tmDHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dX8tmDHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RqSLZ/IXDnoMvKzd+RuDqnZVTelRyZJIHxTKtL1QEDg=;
	b=dX8tmDHnrOp6lSC4rYJdvzI6fp6NBbYQXIpqSI6KydVGMNZlQWp3FWMac6tquG1XP0oSPd
	A8wye8hr1mXSAUb5Tg6TOC/cSl4LmcvO2rv6ghiX+QFDomeuN9fJ/JlCImMCii7WmyVKTN
	Gtkg31ufzuOWHzJfzBk2clT8pJqs9ZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Ci9SLWpGPcqetP5QaZobXQ-1; Mon, 20 Apr 2026 08:50:48 -0400
X-MC-Unique: Ci9SLWpGPcqetP5QaZobXQ-1
X-Mimecast-MFC-AGG-ID: Ci9SLWpGPcqetP5QaZobXQ_1776689447
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ea7a5da42so1994075f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689447; x=1777294247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqSLZ/IXDnoMvKzd+RuDqnZVTelRyZJIHxTKtL1QEDg=;
        b=qNutdxdTHyGup3GoKDlb0F9yySi39umnIbTMaSR12Msbvpr4Jih1CWEcf26fubtusC
         ZLBOWNJN8teC2yIt3+SzVepMHSxarRKA5Zk2TvCrif+Wv/e2K91+CkTgRgCTeZmgl1R/
         oJJNE2UosdgZCchXdv9juWOaeh1bKW+TGgAvgO+vMKbUFDyLSg3DW3iOxFPmsjejF7vZ
         4i7ZZm00E9ptkThC4J63dyXaUkgcToiW2W/tlvTjgspM3ELjTF9dgrju4hXN95j1o+XB
         au8WVHhAgyckwe9j1/mNoZbjS8xTg/36tYXpP/NdlN1MdsGsGMlcsFL2IdROLv3i7bSN
         X1lw==
X-Forwarded-Encrypted: i=1; AFNElJ8IYbizdRrjTFQn1180jBWng5wzWvU63XXlJQiHw8AJCC673P3UJuUz1kk10g9a886XjG6SiwmA/cQ/lvvriA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSRd4YbjJ/NsCeawW8iOsE179vdmM6B0puHCQ07d69G+PjcMcj
	Q4IbleRAMY4LIPKLLtvb0cAh8KeiliizZLYn/mOTqk3fbqEE06jsWKZu3tDIAyoDkn3khWlIXGH
	bIUXE8CIk9g48FKJPdFe28o98mRAXxZvUiyuJGxmV7LBYJWPtAJymzWZOo8N2ZhAT2/DI
X-Gm-Gg: AeBDiesnYyKrM9Jue62oLdAaVIHILGEgIMvR4ZkzM5nTIBMFCJgR0WhOfbOMIV1mgUt
	ziy7GEUN/ZVT+3mwUGkDyGVBzAUiUjx2BeFpcymNPQuIBRkSTheHfr/wLo8Wm1dS6KZGzAQPKD1
	rmv1x3NXcD+odSbl9NsqCttW6/66cixiTwvshXASRzHQgN53rW4x+yXU1bB5rCtmcZnvlCN5VeO
	LZDPjb8utiyCQY72EDI1fl8MEjwJW85YfIiBsDdpU2BPCE9er1OmEnjXq+MLVJGLzboTzzZV87D
	wHPpymPGxCtf2fvNlMP/sjhZbGFWzQ6aweJHKsA6kpB/M/CTV/mV65AjZuGmYG7r438oo7Fu7de
	gzDc6hywr7X3QRXB8813ZuLhLayRs7WAv0x6aQAVFexlwg2Yu37790w==
X-Received: by 2002:a05:600c:888b:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488fb73d234mr157904055e9.2.1776689447021;
        Mon, 20 Apr 2026 05:50:47 -0700 (PDT)
X-Received: by 2002:a05:600c:888b:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488fb73d234mr157903665e9.2.1776689446452;
        Mon, 20 Apr 2026 05:50:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm43629625e9.3.2026.04.20.05.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:46 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:43 -0400
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
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH RFC v2 09/18] mm: hugetlb: use PG_zeroed for pool pages, skip
 redundant zeroing
Message-ID: <cb29348b99c742e10ac9147ce781fa56dabf9600.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XyqHzkAgH6PPm8VFTBBP1NA7_aqAG4cEcZEZQeHmeYs_1776689447
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Set PG_zeroed on surplus hugetlb pages when buddy-allocated with
PGHINT_ZEROED (indicating the page was pre-zeroed by the host).
Clear PG_zeroed in free_huge_folio() when a user-mapped page
returns to the pool.

Check PG_zeroed at fault and fallocate callers to skip redundant
folio_zero_user().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 fs/hugetlbfs/inode.c |  5 ++++-
 mm/hugetlb.c         | 31 +++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3f70c47981de..3f9bdb5a7c85 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -828,7 +828,10 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 			error = PTR_ERR(folio);
 			goto out;
 		}
-		folio_zero_user(folio, addr);
+		if (PageZeroed(&folio->page))
+			__ClearPageZeroed(&folio->page);
+		else
+			folio_zero_user(folio, addr);
 		__folio_mark_uptodate(folio);
 		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index faa94a114fd4..704ec0817c5e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1746,6 +1746,8 @@ void free_huge_folio(struct folio *folio)
 	bool restore_reserve;
 	unsigned long flags;
 
+	__ClearPageZeroed(&folio->page);
+
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 	VM_BUG_ON_FOLIO(folio_mapcount(folio), folio);
 
@@ -1919,12 +1921,13 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
  * pages is zero, and the accounting must be done in the caller.
  */
 static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask)
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		pghint_t *hints)
 {
 	struct folio *folio;
 
 	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
-					      NULL, NULL);
+					      NULL, hints);
 	if (folio)
 		hugetlb_vmemmap_optimize_folio(h, folio);
 	return folio;
@@ -2137,6 +2140,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 				gfp_t gfp_mask,	int nid, nodemask_t *nmask)
 {
 	struct folio *folio = NULL;
+	pghint_t hints;
 
 	if (hstate_is_gigantic_no_runtime(h))
 		return NULL;
@@ -2146,10 +2150,13 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, &hints);
 	if (!folio)
 		return NULL;
 
+	if (hints & PGHINT_ZEROED)
+		__SetPageZeroed(&folio->page);
+
 	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * nr_huge_pages needs to be adjusted within the same lock cycle
@@ -2189,7 +2196,7 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
 	if (!folio)
 		return NULL;
 
@@ -2242,9 +2249,6 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 {
 	struct folio *folio;
 
-	if (hints)
-		*hints = (pghint_t)0;
-
 	spin_lock_irq(&hugetlb_lock);
 	if (!h->resv_huge_pages) {
 		spin_unlock_irq(&hugetlb_lock);
@@ -2253,8 +2257,12 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 
 	folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask, preferred_nid,
 					       nmask);
-	if (folio)
+	if (folio) {
 		h->resv_huge_pages--;
+		if (hints)
+			*hints = PageZeroed(&folio->page) ? PGHINT_ZEROED : 0;
+		__ClearPageZeroed(&folio->page);
+	}
 
 	spin_unlock_irq(&hugetlb_lock);
 	return folio;
@@ -2748,7 +2756,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct folio *old_folio,
 			spin_unlock_irq(&hugetlb_lock);
 			gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 			new_folio = alloc_fresh_hugetlb_folio(h, gfp_mask,
-							      nid, NULL);
+							      nid, NULL, NULL);
 			if (!new_folio)
 				return -ENOMEM;
 			goto retry;
@@ -5820,7 +5828,10 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				ret = 0;
 			goto out;
 		}
-		folio_zero_user(folio, vmf->real_address);
+		if (PageZeroed(&folio->page))
+			__ClearPageZeroed(&folio->page);
+		else
+			folio_zero_user(folio, vmf->real_address);
 		__folio_mark_uptodate(folio);
 		new_folio = true;
 
-- 
MST

