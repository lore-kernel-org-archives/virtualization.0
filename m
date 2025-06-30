Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E628B4FD
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288478; cv=none; b=WoqNTpO9qaQI0qMrZphKuOXNZFBgcWC5WBH+6WQPshHutSI7KkHKSVAmodMX0vzvTJ9Px+4dZpoTkXNJd++IW+zqDkiVT2eSu9D7n5E724Bwy7oGD+Vov2HXeIP7p0mTuDR7RUON39oRQAGaa7QrYwMcQrm++eo6gn7BQOC4f0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288478; c=relaxed/simple;
	bh=7xJKM0wHRvJlTPEV4a7GEQ9RPiMSBfT28nYx22hkvv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eTi4jzsvQmHyG1x5huefHeZy2TZYIzLyDj6PLjgttnaisAvbbTzBuarS62mSpb0sEQIOz2TodGQ1bgM7bf+XOApfVLAgfk+RdZbboodhWqa7FTbt84/Pc+eqgJ0ppecidWuAaPCmFqTniXTp1En3fnZD6fF5KGnJfWQGFXeGpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHiANXhm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHiANXhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFoZ+ZWQ3WhLHAA9oaT1biVSgyM158tXM490LDGSwpg=;
	b=jHiANXhmbhMgOZtRdOp0DkhXr+LDavOpn7YLKJwS5qY3fS326sJKVNQj555xczbrhf68yA
	ty9IuA+BZxYiYkhtaw8uMVVQEGPe+GpbCJoyatwiUcj2gKUuJNsSyXVFr6qHeVumaFzbLg
	SyF5D7neF/c6ozHXjZKDSf50aC/PKG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-S0G9WAj7NSmx6aM1gtq5eA-1; Mon, 30 Jun 2025 09:01:10 -0400
X-MC-Unique: S0G9WAj7NSmx6aM1gtq5eA-1
X-Mimecast-MFC-AGG-ID: S0G9WAj7NSmx6aM1gtq5eA_1751288469
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so1588409f8f.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288469; x=1751893269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFoZ+ZWQ3WhLHAA9oaT1biVSgyM158tXM490LDGSwpg=;
        b=Sa9XSZxnlHxAJJmkgwS4T7/tB8l344ryFmlldnVdtLpzmerpsfctTQQ/+0VvajGtjk
         z3oNhZaDLjPpDDP++wc3K9jCCIgvQ+RKb9x4OcPdqaVw1fo7Y4IuXveXnV4lw/n+IVA+
         CyelNcxUKDDHBeDS8U5YrOHj5CUsPQVMiWUsZaMuco0jvveslSRMZiOW1bT0Xr9KP4mK
         tWcPPjHxSDkvjWZa8RERkV8A0xfmoxPU2EG9yb8Pfs7dHokkOtLP9k2HMfIBQ4/bFr9G
         Lzrli/WAcxJw5vXYa2RITTSEd/+KnauzvDpOQelpMrtDWTQRzdgm4pyrm2ugBrnmYdAL
         FRbw==
X-Forwarded-Encrypted: i=1; AJvYcCU0cEVNZsbgC0y/1bsnfaINmXrYEdyrG0EuBtKG+D3Q5gDppGYMbVEi9KCUSCr4wKwlx2ycdZyh6GmnBAstvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8HyHk+4zp+M+pnw/s24LyBocuZ3mG7KpzQ7aJ0pmwevTLJXbp
	D0waV/SiaRTm+uxCYr1ge1YtrK5KDq3EdhF4/r70uNh3kc3qbeCjeaUdUgF9r8/V7bPdpiC0x80
	fpcgi1Lp5y8h+kpESAmiqJdCyz0GXktEnMEEXutRdRnOCW9K5q8KPo4oZ80gXq+P+12cQ
X-Gm-Gg: ASbGnct1OH897uJgfvVSiIhxLm8Fiddmq/SkP29Kwrt1+ULjGS/ilPO8a3bjSKR0v1a
	F5EHUoPu9rQ4PVCH1CGsbgUzCr4Ew/ZyIzUljT1MjFpdV3aztmF2a84xcEPJW/WVNa3sSt9Gx+3
	KPaDkM0psiztx2CD/oJYdwwnC41Ur+kSz1/AEIvZfc6BEHtQzeZS/U6Oghn9AAmo4GJBKaCL1gd
	eDpmQMMdz/ak8bHNQVDGGqZemkxLG7tSRRLs/HSudAsWvVygFYuAf4FRbDiU1OX0h/5mDlQvCdw
	TAeeIkel6Dt71VJFOss6SwB1aIKMVoDX4LXxC1RsaPLAbZAd269EBXt/xQAnfG78iD4Mvpj27/W
	pCKVrIFQ=
X-Received: by 2002:adf:b301:0:b0:3a6:e1e7:2a88 with SMTP id ffacd0b85a97d-3a8ff05093dmr8389711f8f.57.1751288469165;
        Mon, 30 Jun 2025 06:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5PkTKThngrkuXzEjagSlsXbjs5Ldlq7ssFfZO6/XI6tZJegQpsM73QRMndkrSs09mr6FuKQ==
X-Received: by 2002:adf:b301:0:b0:3a6:e1e7:2a88 with SMTP id ffacd0b85a97d-3a8ff05093dmr8389609f8f.57.1751288468412;
        Mon, 30 Jun 2025 06:01:08 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e52c23sm10479813f8f.52.2025.06.30.06.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:07 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v1 19/29] mm: stop storing migration_ops in page->mapping
Date: Mon, 30 Jun 2025 15:00:00 +0200
Message-ID: <20250630130011.330477-20-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bnRgFFhVK-kjUAplolHw5DXBnMPE31wrBGz1NyEgYvc_1751288469
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... instead, look them up statically based on the page type. Maybe in the
future we want a registration interface? At least for now, it can be
easily handled using the two page types that actually support page
migration.

The remaining usage of page->mapping is to flag such pages as actually
being movable (having movable_ops), which we will change next.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  2 +-
 include/linux/migrate.h            | 14 ++------------
 include/linux/zsmalloc.h           |  2 ++
 mm/balloon_compaction.c            |  1 -
 mm/compaction.c                    |  5 ++---
 mm/migrate.c                       | 23 +++++++++++++++++++++++
 mm/zpdesc.h                        |  5 ++---
 mm/zsmalloc.c                      |  8 +++-----
 8 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 9bce8e9f5018c..a8a1706cc56f3 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -92,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	__SetPageMovable(page, &balloon_mops);
+	__SetPageMovable(page);
 	set_page_private(page, (unsigned long)balloon);
 	list_add(&page->lru, &balloon->pages);
 }
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index e04035f70e36f..6aece3f3c8be8 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -104,23 +104,13 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page, const struct movable_operations *ops);
+void __SetPageMovable(struct page *page);
 #else
-static inline void __SetPageMovable(struct page *page,
-		const struct movable_operations *ops)
+static inline void __SetPageMovable(struct page *page)
 {
 }
 #endif
 
-static inline
-const struct movable_operations *page_movable_ops(struct page *page)
-{
-	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
-
-	return (const struct movable_operations *)
-		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
-}
-
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 13e9cc5490f71..f3ccff2d966cd 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -46,4 +46,6 @@ void zs_obj_read_end(struct zs_pool *pool, unsigned long handle,
 void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 		  void *handle_mem, size_t mem_len);
 
+extern const struct movable_operations zsmalloc_mops;
+
 #endif
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index e4f1a122d786b..2a4a649805c11 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -253,6 +253,5 @@ const struct movable_operations balloon_mops = {
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
 };
-EXPORT_SYMBOL_GPL(balloon_mops);
 
 #endif /* CONFIG_BALLOON_COMPACTION */
diff --git a/mm/compaction.c b/mm/compaction.c
index 41fd6a1fe9a33..348eb754cb227 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -114,11 +114,10 @@ static unsigned long release_free_list(struct list_head *freepages)
 }
 
 #ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page, const struct movable_operations *mops)
+void __SetPageMovable(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE((unsigned long)mops & PAGE_MAPPING_MOVABLE, page);
-	page->mapping = (void *)((unsigned long)mops | PAGE_MAPPING_MOVABLE);
+	page->mapping = (void *)(PAGE_MAPPING_MOVABLE);
 }
 EXPORT_SYMBOL(__SetPageMovable);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 15d3c1031530c..c6c9998014ec8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -43,6 +43,8 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
+#include <linux/balloon_compaction.h>
+#include <linux/zsmalloc.h>
 
 #include <asm/tlbflush.h>
 
@@ -51,6 +53,27 @@
 #include "internal.h"
 #include "swap.h"
 
+static const struct movable_operations *page_movable_ops(struct page *page)
+{
+	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
+
+	/*
+	 * If we enable page migration for a page of a certain type by marking
+	 * it as movable, the page type must be sticky until the page gets freed
+	 * back to the buddy.
+	 */
+#ifdef CONFIG_BALLOON_COMPACTION
+	if (PageOffline(page))
+		/* Only balloon compaction sets PageOffline pages movable. */
+		return &balloon_mops;
+#endif /* CONFIG_BALLOON_COMPACTION */
+#if defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION)
+	if (PageZsmalloc(page))
+		return &zsmalloc_mops;
+#endif /* defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION) */
+	return NULL;
+}
+
 /**
  * isolate_movable_ops_page - isolate a movable_ops page for migration
  * @page: The page.
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 5763f36039736..6855d9e2732d8 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -152,10 +152,9 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
 	return page_zpdesc(pfn_to_page(pfn));
 }
 
-static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
-					const struct movable_operations *mops)
+static inline void __zpdesc_set_movable(struct zpdesc *zpdesc)
 {
-	__SetPageMovable(zpdesc_page(zpdesc), mops);
+	__SetPageMovable(zpdesc_page(zpdesc));
 }
 
 static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 72c2b7562c511..7192196b9421d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1684,8 +1684,6 @@ static void lock_zspage(struct zspage *zspage)
 
 #ifdef CONFIG_COMPACTION
 
-static const struct movable_operations zsmalloc_mops;
-
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct zpdesc *newzpdesc, struct zpdesc *oldzpdesc)
 {
@@ -1708,7 +1706,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
 		newzpdesc->handle = oldzpdesc->handle;
-	__zpdesc_set_movable(newzpdesc, &zsmalloc_mops);
+	__zpdesc_set_movable(newzpdesc);
 }
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
@@ -1815,7 +1813,7 @@ static void zs_page_putback(struct page *page)
 {
 }
 
-static const struct movable_operations zsmalloc_mops = {
+const struct movable_operations zsmalloc_mops = {
 	.isolate_page = zs_page_isolate,
 	.migrate_page = zs_page_migrate,
 	.putback_page = zs_page_putback,
@@ -1878,7 +1876,7 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
 
 	do {
 		WARN_ON(!zpdesc_trylock(zpdesc));
-		__zpdesc_set_movable(zpdesc, &zsmalloc_mops);
+		__zpdesc_set_movable(zpdesc);
 		zpdesc_unlock(zpdesc);
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 }
-- 
2.49.0

