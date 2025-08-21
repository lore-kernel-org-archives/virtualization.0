Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC536CC8E
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806896; cv=none; b=FjbNQOxItGkQhbSofdFvHBWNFGLK/JdU1jbzxkl7dZNOZpoX1CaorIf9nPNWYcFgGOSSanDWccQ0PKtO5TEYKSgoKHs3is03V1FX/3ew3uD2tuNgRU+EL/AWAWRuX/zsDoNR1wkNYtTOnewEgT1j5P2uuSEHmCGo1x8k/lBvTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806896; c=relaxed/simple;
	bh=u7U0E5UNosH6c7PaP/scUrTgiGRReCYM/RkOjp4OjeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CseJi9YnUcxTb3O+nRt31HQ6awOGFpn0M50RIlp9sZvY0o4PKp4krBgFPGDEr+EG26XaNCAAlexK/jYYJp9KsrJJAe4CzT2zFxJjbTj40/nABzOonjbC99GoTk30+L1cmwLGd7YaFvvyLmMLdj2boFznepbQXN+FOxuDfWxAIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix0JCSnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix0JCSnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlD9YGSFbsAaeSHrs+lmfmp3eNVZAqkWDWaUN3GbxpI=;
	b=ix0JCSnBK7GKINQ17ZyVqqey9BAAeRbeJxXvdEmJgcXyqwnSO3PgtDzVUrD2uDOzjYIM/4
	SF5ZlRvdDyw9uAmyt/tWWkM05RTqmDhkoh7uexuJbZTdxbLaGZX39YaUx050GDo3GeRrFI
	litJD+P8jbVsTaQPMgIQgV656MxmK2E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-yPfT7BEBNk25kq6YmkhzQg-1; Thu, 21 Aug 2025 16:08:07 -0400
X-MC-Unique: yPfT7BEBNk25kq6YmkhzQg-1
X-Mimecast-MFC-AGG-ID: yPfT7BEBNk25kq6YmkhzQg_1755806886
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41bd50aso995802f8f.0
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806886; x=1756411686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlD9YGSFbsAaeSHrs+lmfmp3eNVZAqkWDWaUN3GbxpI=;
        b=k/KM/jY2bHRJFbjR0ifM/U4WMRV0vJcCn264DMqq1JwtXGRxdLkv4cPVXucuDQQybe
         G25twpLl46NaQzmN+voyQi4yCaEZNVdP/KOf1dCIikf3eMyR/h8ojo5JtLF0aPdJoAKH
         rh4UCh6YQXOy0iaU3L8btL0boygMVavupBvV+4toFTWampNHuOAgcJO1EeFNFkby/EUx
         HMUMAy7mxzYQ/YUdVSGCd2OSLHIjzb9AylwCSYvQX1wOP0ULFbZO4E010BWF0VWphhfX
         MfYVQZiSBEc/05iXXAfoQBb4hlJvie9s8RmjW9/YMglHMrpBviNs+iESj5t/h+x28CS0
         LNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWskE5yIinaznTgzV7lSouSHK/OWURKdk/FVyaRVFMNv3ffBvpl0TMBlyln07e+BUByX5LoBsX+QpIQooLzPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCEixfL4FI6cw3rzINZX4Z/9sjgkTFLCag8QGvIe3SahmQVGAJ
	TEOxY1w1edXXaKs0+/FiyAkBhoY+GLsUX7FGhWKPRBEMDDh7vGIqGbRwM0i2LvsGgtXTpFJq2tO
	1lMyZq8YdpmtWqQRrTLsJrhVpSMOnbAOkoDnXPKHyRcKQ8jmMIRn+GhSagS/mtSTHmEqC
X-Gm-Gg: ASbGncsmxBTQlC6YeZEmir/RqUXknjkmuGv8dScMGRRa4TlVsbXl/+dBpNUjiZg89SW
	ld1/6JJfhekd39qd6qGFDCnctLTst70anroJyB32aApPo6XNJ032S14vRKRoAdZvcs5mdTrPWuN
	ddWWwhIpI72E7qaci8m5K48UDfkAL1uju8knwg2vnEI+C2D70qxL2yC90FenuoStXwxRIskMvCV
	NJi3LPakP4zblKC2eQEYz7U6KvGqSxk73Mth4obAAu2FpiLjioeLPxafVCeG6DfRO8DCvDJDZkY
	Oba5nra9jLNOLahmgKRFTZ/B3YNZ8+Pf7kJJ+5OG/stgf/Wth2u85jzdQ8XLIgLegJC6euEbyhD
	p8NJ6FnHe4kPi73wlMB115Q==
X-Received: by 2002:a5d:5849:0:b0:3b7:94c6:7c9 with SMTP id ffacd0b85a97d-3c5db4ca226mr187845f8f.27.1755806886231;
        Thu, 21 Aug 2025 13:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN2zPHDTqkDZIT/HT3QVvSDWvKglll+HTpAUltvzBh+S3AYz2M0rKfptvzXjL7aLPeFpS91Q==
X-Received: by 2002:a5d:5849:0:b0:3b7:94c6:7c9 with SMTP id ffacd0b85a97d-3c5db4ca226mr187788f8f.27.1755806885705;
        Thu, 21 Aug 2025 13:08:05 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789d1dsm12697993f8f.49.2025.08.21.13.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:05 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 21/35] mm/cma: refuse handing out non-contiguous page ranges
Date: Thu, 21 Aug 2025 22:06:47 +0200
Message-ID: <20250821200701.1329277-22-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QHtp_gYOeFcq1po23BKOK0f4pmHDEDSqr05VxWktGik_1755806886
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's disallow handing out PFN ranges with non-contiguous pages, so we
can remove the nth-page usage in __cma_alloc(), and so any callers don't
have to worry about that either when wanting to blindly iterate pages.

This is really only a problem in configs with SPARSEMEM but without
SPARSEMEM_VMEMMAP, and only when we would cross memory sections in some
cases.

Will this cause harm? Probably not, because it's mostly 32bit that does
not support SPARSEMEM_VMEMMAP. If this ever becomes a problem we could
look into allocating the memmap for the memory sections spanned by a
single CMA region in one go from memblock.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  6 ++++++
 mm/cma.c           | 36 +++++++++++++++++++++++-------------
 mm/util.c          | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360b72cb05c..f59ad1f9fc792 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -209,9 +209,15 @@ extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+bool page_range_contiguous(const struct page *page, unsigned long nr_pages);
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 #else
 #define nth_page(page,n) ((page) + (n))
+static inline bool page_range_contiguous(const struct page *page,
+		unsigned long nr_pages)
+{
+	return true;
+}
 #endif
 
 /* to align the pointer to the (next) page boundary */
diff --git a/mm/cma.c b/mm/cma.c
index 2ffa4befb99ab..1119fa2830008 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -780,10 +780,8 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 				unsigned long count, unsigned int align,
 				struct page **pagep, gfp_t gfp)
 {
-	unsigned long mask, offset;
-	unsigned long pfn = -1;
-	unsigned long start = 0;
 	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
+	unsigned long start, pfn, mask, offset;
 	int ret = -EBUSY;
 	struct page *page = NULL;
 
@@ -795,7 +793,7 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 	if (bitmap_count > bitmap_maxno)
 		goto out;
 
-	for (;;) {
+	for (start = 0; ; start = bitmap_no + mask + 1) {
 		spin_lock_irq(&cma->lock);
 		/*
 		 * If the request is larger than the available number
@@ -812,6 +810,22 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 			spin_unlock_irq(&cma->lock);
 			break;
 		}
+
+		pfn = cmr->base_pfn + (bitmap_no << cma->order_per_bit);
+		page = pfn_to_page(pfn);
+
+		/*
+		 * Do not hand out page ranges that are not contiguous, so
+		 * callers can just iterate the pages without having to worry
+		 * about these corner cases.
+		 */
+		if (!page_range_contiguous(page, count)) {
+			spin_unlock_irq(&cma->lock);
+			pr_warn_ratelimited("%s: %s: skipping incompatible area [0x%lx-0x%lx]",
+					    __func__, cma->name, pfn, pfn + count - 1);
+			continue;
+		}
+
 		bitmap_set(cmr->bitmap, bitmap_no, bitmap_count);
 		cma->available_count -= count;
 		/*
@@ -821,29 +835,25 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 		 */
 		spin_unlock_irq(&cma->lock);
 
-		pfn = cmr->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma->alloc_mutex);
 		ret = alloc_contig_range(pfn, pfn + count, ACR_FLAGS_CMA, gfp);
 		mutex_unlock(&cma->alloc_mutex);
-		if (ret == 0) {
-			page = pfn_to_page(pfn);
+		if (!ret)
 			break;
-		}
 
 		cma_clear_bitmap(cma, cmr, pfn, count);
 		if (ret != -EBUSY)
 			break;
 
 		pr_debug("%s(): memory range at pfn 0x%lx %p is busy, retrying\n",
-			 __func__, pfn, pfn_to_page(pfn));
+			 __func__, pfn, page);
 
 		trace_cma_alloc_busy_retry(cma->name, pfn, pfn_to_page(pfn),
 					   count, align);
-		/* try again with a bit different memory target */
-		start = bitmap_no + mask + 1;
 	}
 out:
-	*pagep = page;
+	if (!ret)
+		*pagep = page;
 	return ret;
 }
 
@@ -882,7 +892,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 	 */
 	if (page) {
 		for (i = 0; i < count; i++)
-			page_kasan_tag_reset(nth_page(page, i));
+			page_kasan_tag_reset(page + i);
 	}
 
 	if (ret && !(gfp & __GFP_NOWARN)) {
diff --git a/mm/util.c b/mm/util.c
index d235b74f7aff7..0bf349b19b652 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1280,4 +1280,37 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 {
 	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr, 0);
 }
+
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+/**
+ * page_range_contiguous - test whether the page range is contiguous
+ * @page: the start of the page range.
+ * @nr_pages: the number of pages in the range.
+ *
+ * Test whether the page range is contiguous, such that they can be iterated
+ * naively, corresponding to iterating a contiguous PFN range.
+ *
+ * This function should primarily only be used for debug checks, or when
+ * working with page ranges that are not naturally contiguous (e.g., pages
+ * within a folio are).
+ *
+ * Returns true if contiguous, otherwise false.
+ */
+bool page_range_contiguous(const struct page *page, unsigned long nr_pages)
+{
+	const unsigned long start_pfn = page_to_pfn(page);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn;
+
+	/*
+	 * The memmap is allocated per memory section. We need to check
+	 * each involved memory section once.
+	 */
+	for (pfn = ALIGN(start_pfn, PAGES_PER_SECTION);
+	     pfn < end_pfn; pfn += PAGES_PER_SECTION)
+		if (unlikely(page + (pfn - start_pfn) != pfn_to_page(pfn)))
+			return false;
+	return true;
+}
+#endif
 #endif /* CONFIG_MMU */
-- 
2.50.1

