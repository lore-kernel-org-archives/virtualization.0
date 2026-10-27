Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069815;
	b=rBmamA3FtrhkESzTTy18yngAF8u9rRqH0IrI+zKQQbp+/vhW/cBNr3c7KwBhNi6dBWP6
	 A6KzI2vMmf7iaYyXyI6D2i4FaKjvI60NexGs4rbmAM//uZrSEjHIYKr61NKTMIGFFAFOh
	 FjdLzIghq7uFTxlvABW+uykjD1UGenlW9tWRledHoy37aLO149a2dTcuihWrXafNkKsI3
	 lz2moatZ+tkXlXAuzZH6wnHdkynO+i5Cx1UgxrMiI2YswVBDPxOn8tbD5ohBpXoj3Z1Zu
	 sehtwsShedlzbiyj1z0aJhhsQ3wisBlZs0/2B2ecxTlq2XCU+G/GkdsUEr9GnnoUDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LCdG6rFn11zBCazpVzMCvIt14BjXcoxSwJ2DZpHTKik=;
	b=29GkTH8pTryZiAlocto0hqjxzOkQWC62p3w4YTVRU9C8C9+6Jzm1aOU2WvoR4NgHfC1w
	 mhwErEePwW8uPPCio88PDYOAuVD4fySklxOl/TrpbqQLmqrKjTbqXet08Ye95yMsF/48Q
	 awtVZgpH5gV5qID0PbDQW8VYS6XzGbEQv2W849GUWiqzG3QBBvPupCNkL5J2aXRqo7xeE
	 fSb60ItSFk+EA7TKYYf/gU18YFsZcEvxqlThVoI54uRloY/0LYXMlZCnVBiXRb8Z56FhH
	 8TcceU0cRmxav+FciBoT59dn6dOefbclRhGB4UqJj4kFw2lgzUu7Tdemox9zEs1P/1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vtKsx6RM;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50EF60A2607
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E50EF60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vtKsx6RM
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4dab94dc3e7so5879543b6e.0
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069814; x=1793674614; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCdG6rFn11zBCazpVzMCvIt14BjXcoxSwJ2DZpHTKik=;
        b=vtKsx6RMnhJEYXAcL+jq1dKsksMTSnSRYIQwBw0GGZpfozsX/rPR8goIZD4ZKOfVIB
         j/+FbtVe/nfY4VWbIEOxd5b/wS+Uec2MgqOkNr4y+nfZn2GttFA+oWoke8SF6/JuxnpD
         16M2glMHmT3Hz9JzLzLUqzEXNwJ8TgHh0FyXlNv7Av+QysEc/N+EVTZQwLKHPMMq9V+7
         pdZp2P1qqKzus3b28BgqnBKbEJTAf5Cu23HsWwVBhrPXS2DcPrxwFxGr7mVu6JQ3MCee
         /Jdiz90ZAOWFmnypFQlyOfwrYh/XhwnUdhtPBPlM47Ozf0TWJDvF1sw5giwygrx+DQgA
         pVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069814; x=1793674614;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LCdG6rFn11zBCazpVzMCvIt14BjXcoxSwJ2DZpHTKik=;
        b=kqRX1osHykxasWVNvJ+vlG+JNs57UDG8nkBGC45r7XUaBJQpeqTeSoSVb40JIlV7pE
         XlXqGbx4040S/kskQkjFDb9OPocHxc+CsYPMBytq6V3qsTxbu+PskeYE3+zJOgOs2ogh
         v2q2KdqwiC598C1HAsbIt26SQujt0RkO1uxdVY2BelyIlIwiIK9k+4PcYhDGE9VYdF0f
         plbck6ZESzvSiAk6dgW0+qLwCrLfTZnkAYVipe+qRThxEzHB6CWMOru8cp39xOi6SvrE
         M6QIJM9d9p/S+BoAAnKisvb1Ea6E9uH6acPqIRW5b82r7qNRTJL41R8ybgin1/wTA6Tr
         d6Qg==
X-Gm-Message-State: AFq9FYI0tesaTKG/WsjKWKeBAFk2ekan0QguaXKOC93CDpFuP1JU7drU
	NtSNl3pNTRLwwV7l3eVdRdL9c6AISIYqZcZVhkqUHHNrHoOi/+UwtTagr1A3hgyrOcyaffwFk1T
	DnGtNYFxuWAlSYdWxQNiGX81IDDYZ5InfGQ==
X-Received: from iohd14-n1.prod.google.com ([2002:a05:6602:86ce:10b0:9c4:b80b:7605])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1b2b:b0:4f4:73a9:f853 with SMTP id 5614622812f47-55bfff91bbdmr5294339b6e.1.1793069813464;
 Mon, 26 Oct 2026 19:56:53 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:11 +0000
In-Reply-To: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027025616.1632690-9-kevinloughlin@google.com>
Subject: [PATCH 08/13] mm/page_alloc: route unaccepted isolated pages
From: Kevin Loughlin <kevinloughlin@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>
Cc: virtualization@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sidharth Telang <sidtelang@google.com>, Punit Salian <psalian@google.com>, 
	Peter Gonda <pgonda@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Jacky Li <jackyli@google.com>, Steve Rutherford <srutherford@google.com>, 
	David Skidmore <davidskidmore@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

When free page reporting unaccepts isolated pages on confidential
computing guests, __putback_isolated_page() must not return those
unaccepted pages directly to zone->free_area; doing so would violate the
allocator invariant that all pages on zone->free_area are accepted.

Update __putback_isolated_page(), __free_pages_ok(),
__free_frozen_pages(), and free_unref_folios() to route dynamically
unaccepted pages to zone->unaccepted_pages via __free_unaccepted_locked()
(falling back to immediate acceptance for isolated or CMA pageblocks).

In addition:
- Extract free_pages_prepare_init() so post-acceptance poisoning,
  zeroing, KASAN tagging, arch_free_page(), and debug_pagealloc
  unmapping run after accept_memory() without touching unaccepted pages
  in __free_pages_prepare() or re-running metadata teardown in
  __accept_page().
- Pass FPI_SKIP_REPORT_NOTIFY when __accept_page() frees a freshly
  accepted block into the buddy allocator so it is not immediately
  re-queued for free page reporting before allocation.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 mm/page_alloc.c | 120 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 35 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 46ae8c6f3814..c10b77304633 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1298,12 +1298,53 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
+static inline bool should_free_unaccepted(struct page *page,
+					  unsigned int order,
+					  fpi_t fpi_flags)
+{
+	return !(fpi_flags & FPI_NOLOCK) &&
+	       page_contains_unaccepted(page, order);
+}
+
+static void free_pages_prepare_init(struct page *page, unsigned int order)
+{
+	bool skip_kasan_poison = should_skip_kasan_poison(page);
+	bool init = want_init_on_free();
+
+	kernel_poison_pages(page, 1 << order);
+
+	/*
+	 * As memory initialization might be integrated into KASAN,
+	 * KASAN poisoning and memory initialization code must be
+	 * kept together to avoid discrepancies in behavior.
+	 *
+	 * With hardware tag-based KASAN, memory tags must be set before the
+	 * page becomes unavailable via debug_pagealloc or arch_free_page.
+	 */
+	if (!skip_kasan_poison) {
+		kasan_poison_pages(page, order, init);
+
+		/* Memory is already initialized if KASAN did it internally. */
+		if (kasan_has_integrated_init())
+			init = false;
+	}
+	if (init)
+		clear_highpages_kasan_tagged(page, 1 << order);
+
+	/*
+	 * arch_free_page() can make the page's contents inaccessible.  s390
+	 * does this.  So nothing which can access the page's contents should
+	 * happen after this.
+	 */
+	arch_free_page(page, order);
+
+	debug_pagealloc_unmap_pages(page, 1 << order);
+}
+
 static __always_inline bool __free_pages_prepare(struct page *page,
 		unsigned int order, fpi_t fpi_flags)
 {
 	int bad = 0;
-	bool skip_kasan_poison = should_skip_kasan_poison(page);
-	bool init = want_init_on_free();
 	bool compound = PageCompound(page);
 	struct folio *folio = page_folio(page);
 
@@ -1411,34 +1452,10 @@ static __always_inline bool __free_pages_prepare(struct page *page,
 					   PAGE_SIZE << order);
 	}
 
-	kernel_poison_pages(page, 1 << order);
-
-	/*
-	 * As memory initialization might be integrated into KASAN,
-	 * KASAN poisoning and memory initialization code must be
-	 * kept together to avoid discrepancies in behavior.
-	 *
-	 * With hardware tag-based KASAN, memory tags must be set before the
-	 * page becomes unavailable via debug_pagealloc or arch_free_page.
-	 */
-	if (!skip_kasan_poison) {
-		kasan_poison_pages(page, order, init);
-
-		/* Memory is already initialized if KASAN did it internally. */
-		if (kasan_has_integrated_init())
-			init = false;
-	}
-	if (init)
-		clear_highpages_kasan_tagged(page, 1 << order);
-
-	/*
-	 * arch_free_page() can make the page's contents inaccessible.  s390
-	 * does this.  So nothing which can access the page's contents should
-	 * happen after this.
-	 */
-	arch_free_page(page, order);
+	if (should_free_unaccepted(page, order, fpi_flags))
+		return true;
 
-	debug_pagealloc_unmap_pages(page, 1 << order);
+	free_pages_prepare_init(page, order);
 
 	return true;
 }
@@ -1572,14 +1589,31 @@ static void free_one_page(struct zone *zone, struct page *page,
 	__count_vm_events(PGFREE, 1 << order);
 }
 
+static bool handle_unaccepted_free(struct page *page, unsigned int order,
+				   fpi_t fpi_flags)
+{
+	if (!should_free_unaccepted(page, order, fpi_flags))
+		return false;
+
+	if (__free_unaccepted(page, order))
+		return true;
+
+	accept_memory(page_to_phys(page), PAGE_SIZE << order);
+	free_pages_prepare_init(page, order);
+	return false;
+}
+
 static void __free_pages_ok(struct page *page, unsigned int order,
 			    fpi_t fpi_flags)
 {
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (__free_pages_prepare(page, order, fpi_flags))
+	if (__free_pages_prepare(page, order, fpi_flags)) {
+		if (handle_unaccepted_free(page, order, fpi_flags))
+			return;
 		free_one_page(zone, page, pfn, order, fpi_flags);
+	}
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
@@ -2955,7 +2989,8 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
 
-	if (!pcp_allowed_order(order)) {
+	if (!pcp_allowed_order(order) ||
+	    should_free_unaccepted(page, order, fpi_flags)) {
 		__free_pages_ok(page, order, fpi_flags);
 		return;
 	}
@@ -3024,9 +3059,13 @@ void free_unref_folios(struct folio_batch *folios)
 			continue;
 		/*
 		 * Free orders not handled on the PCP directly to the
-		 * allocator.
+		 * allocator, as well as any pages containing unaccepted memory.
 		 */
-		if (!pcp_allowed_order(order)) {
+		if (!pcp_allowed_order(order) ||
+		    should_free_unaccepted(&folio->page, order, FPI_NONE)) {
+			if (handle_unaccepted_free(&folio->page, order,
+						   FPI_NONE))
+				continue;
 			free_one_page(folio_zone(folio), &folio->page,
 				      pfn, order, FPI_NONE);
 			continue;
@@ -3187,6 +3226,16 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 	/* zone lock should be held when this function is called */
 	lockdep_assert_held(&zone->lock);
 
+	if (page_contains_unaccepted(page, order)) {
+		if (__free_unaccepted_locked(page, zone, order))
+			return;
+		accept_memory(page_to_phys(page), PAGE_SIZE << order);
+		free_pages_prepare_init(page, order);
+		split_large_buddy(zone, page, page_to_pfn(page), order,
+				  FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL);
+		return;
+	}
+
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
 			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL);
@@ -7933,8 +7982,9 @@ static void __accept_page(struct zone *zone, unsigned long *flags,
 	spin_unlock_irqrestore(&zone->lock, *flags);
 
 	accept_memory(page_to_phys(page), PAGE_SIZE << order);
-
-	__free_pages_ok(page, order, FPI_TO_TAIL);
+	free_pages_prepare_init(page, order);
+	free_one_page(zone, page, page_to_pfn(page), order,
+		      FPI_TO_TAIL | FPI_SKIP_REPORT_NOTIFY);
 }
 
 void accept_page(struct page *page)
-- 
2.56.0.307.g5fe7bd680c-goog

