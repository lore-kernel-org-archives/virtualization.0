Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CD261B70
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240121; cv=none; b=VyVqFtNPJVVraO9P4mkIdMP7TeS0sjme3J3oVxIyZdVtyTeXU4x/TU7WgYnuuLc7C/tfjnu7h7vOnUMC/JIkbOJrYu3nh2VqLmubYgxKrS+NJSix3jMvdSALFFF5xoZfjXGlFQ844ojbLfGtz1YCvMmnXVQOFMyTQn1IN4TUce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240121; c=relaxed/simple;
	bh=QLA2RGwCxgyfX1bS6CbrL8hgVv2A/s1slaGKecTu3qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ucTDT7S1N7OSX3prnS34Cb2KuNZ8K3kKyeCCBjTsUlajivlrZQIO/MwQjlbANzdxj9u7PUjb8I1migIiouFlEoixZSUpysdfF0PMJyFqHaSeGI6fP/lIjvFaKyNFnjqIuSeSlRyg28CHFzLPACjMsKROBrMa3Wb1IWHuxPMzJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLKhO/74; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLKhO/74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ym5bn+CWMcoek2qBVqBOry4vxURkIsMQd8yhmA+BaCk=;
	b=LLKhO/74o7jPDiLRI4pUlkAp8ImF9MEeho5nrcDaSsegDnkHWrxbci++NN/0AEJ3KNJzuY
	7OWnGgvePQgJlw8BC/LOhJztUUt16ZQkD1TRAVru9Lw8Bn/FHb45vqxnFQqcFPsAqemnEG
	arrV3B6ZKX7wHIB+JTDrSsQFlSbO+pI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-x2otrOLYPuWCChdLCPwhuQ-1; Sun, 26 Apr 2026 17:48:37 -0400
X-MC-Unique: x2otrOLYPuWCChdLCPwhuQ-1
X-Mimecast-MFC-AGG-ID: x2otrOLYPuWCChdLCPwhuQ_1777240117
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c0120047so56216125e9.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240116; x=1777844916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym5bn+CWMcoek2qBVqBOry4vxURkIsMQd8yhmA+BaCk=;
        b=Ntp787Ml/Egf8AL22BOob1ozA3sucAFM5Z9XjK8FnIIPx/n8+NkOrkDtDaQK0zHqRj
         kuPtkT9ddJS09t5IDbSLzrYloSS+z2tndxKOpFoIFKWkqgksZrroMICogdFcUycwtWg9
         H27Cl8MGwf2FQDBORkOKBO5OZGgMFzsMpl71Kq8Huge2DYhvP8rrV0dLrYKMp/UTIUbG
         8aPtH3x8gmaMRkmJEhfmF8pqMqq5OCZDktCe6AkTIENAjjkUvIJ8/+bzHPrR3/ZfO+mi
         jpjnFwzG/g/cQlYjHZVq3hFLgt+OmqG0eP7avXmr6zpKNCHcWUgXJAZmcl0EyFBLCiQA
         bFfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2I/BhKBcUI4QEyB075h1DHNFcxhbBbPAFaWZnJ0j11T9uWeoGctJC8Kc/U2tRiBq6oEauoK30ru27OlQQpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTHpjlk4LvFRJFp2vNSHqg4aFIG6U9QngGmVh0ltMpWD+6gMIB
	C8+SV9tixdok/vzO7+7v8ZFZLtoo7aobaezfFDzACqmDBaINt9OtLtLtx9tjfkYuiyskIf6OpF4
	Vqa1A7zwjutVm+B759u7cJV7bAAHKyEXInRKzJFLLhvylkWwqdM5IRgQTZ5ktw0CDJb6a
X-Gm-Gg: AeBDievKEjORYmZNesoj+le+Tvz2AZfDOrzt2cxiRYCMOMl+LewxiRIGeUCvZSk3wJG
	I71qjKncGMwOxAKTtHGEkRTHJF0e8FJPCfDlQpLtxz4web5clG5qsob/zkD1o5AxueKnbLZak5x
	P8GRydnjUdy+vFfP16uiCBZq2jPC9ubiPIUpaD+4qNm3q0CRpsrs8/jvpTRInP025OqTWzVautq
	hLCaKR+XKby2tWZT9RtPZSD67ve90A7ZsP4S9ZFIcma+u5bhEX9c0wnFOXtQbfs0Vs9Jfn6SvGx
	HFUWuiSoy2kjcxdJP8ycBD4xXDMYCAiGxZC2VHoDFN2n/9oHWA5hREhKl99o/N+gRBQp9nSrM4M
	CTR7LLipdrsMfQamwoMto8O/VSEJ2TysY/epKhtpjdrdy3bk0Q3vz/PDY
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id 5b1f17b1804b1-488fb784843mr454260205e9.24.1777240116472;
        Sun, 26 Apr 2026 14:48:36 -0700 (PDT)
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id 5b1f17b1804b1-488fb784843mr454259925e9.24.1777240116042;
        Sun, 26 Apr 2026 14:48:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489201cde98sm505689585e9.7.2026.04.26.14.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:35 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:33 -0400
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
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v4 20/22] mm: add free_frozen_pages_zeroed
Message-ID: <c7ea29cb7a8d88175f2c4f62130e7509ceb785e8.1777223007.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: NmU74vD_-OmhqYII6dzmkVj0nHLQYpXThFS8l99eYrs_1777240117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add free_frozen_pages_zeroed(page, order) to free a frozen page
while marking it as zeroed, so the next allocation can skip
redundant zeroing.

An FPI_ZEROED internal flag carries the hint through the free path.
PageZeroed is set after __free_pages_prepare() clears all flags,
so the hint survives on the free list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  1 +
 mm/internal.h       |  1 -
 mm/page_alloc.c     | 21 ++++++++++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e275cc80e19e..766b1c7f0731 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -394,6 +394,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
+void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
diff --git a/mm/internal.h b/mm/internal.h
index 0600d824ba03..60b983872d51 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -899,7 +899,6 @@ struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
-void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1169714406e7..981ddf3566b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -90,6 +90,13 @@ typedef int __bitwise fpi_t;
 /* Free the page without taking locks. Rely on trylock only. */
 #define FPI_TRYLOCK		((__force fpi_t)BIT(2))
 
+/*
+ * The page contents are known to be zero (e.g., the host zeroed them
+ * during balloon deflate).  Set PageZeroed after free so the next
+ * allocation can skip redundant zeroing.
+ */
+#define FPI_ZEROED		((__force fpi_t)BIT(3))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -1624,8 +1631,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (__free_pages_prepare(page, order, fpi_flags))
+	if (__free_pages_prepare(page, order, fpi_flags)) {
+		if (fpi_flags & FPI_ZEROED)
+			__SetPageZeroed(page);
 		free_one_page(zone, page, pfn, order, fpi_flags);
+	}
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
@@ -3032,6 +3042,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
+	if (fpi_flags & FPI_ZEROED)
+		__SetPageZeroed(page);
+
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
@@ -3070,6 +3083,12 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	__free_frozen_pages(page, order, FPI_NONE);
 }
 
+void free_frozen_pages_zeroed(struct page *page, unsigned int order)
+{
+	__free_frozen_pages(page, order, FPI_ZEROED);
+}
+EXPORT_SYMBOL(free_frozen_pages_zeroed);
+
 void free_frozen_pages_nolock(struct page *page, unsigned int order)
 {
 	__free_frozen_pages(page, order, FPI_TRYLOCK);
-- 
MST

