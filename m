Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA82FC01D
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624793; cv=none; b=ZtZBcuMZOGH+xbZk93zb96d+amxlVTE+BMvjiTQJ5FzoVcy+rTPjegIbe/xRxgpswXSnpnrSq3ySQhc8WoJF683403WCqLiFh6tRZ+P/EX9RojKaLXPojnjJQ21nr17Cr1MNaN+H/PVOAhINIQjCY0yEZhq/ctfuQj8TVypa18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624793; c=relaxed/simple;
	bh=g8pdy1DKrW7JXLanGhBhAjfwcy+F0V2q4a+pmUjqPhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mL+3vIRlbIf7kICZ6BO4xCc8hpjD4q/Ice37xzXd16OzCeTRylvUeV2v2Ikc+r0dcWSC0/s2kQzeEpNxtPOFfRgh1V5qI2hpEBqTKSzUCInk+V4fUqHC1Euw5Ih+JaVaJ1XoyzYc08Qu3D6Tq83u1JMrY0/OiPEjZu7DDzN6ZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3g8omLM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3g8omLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yV5TxHJVxkcIeudKWCbk5OXSzT/72+A13Qm9FGClEWo=;
	b=K3g8omLMvv14QzHWZcfckGFrO8xyA5JsaCHalhtFLkMgoFpaHAowaF9jVuaKKcwI3LfAAD
	xlTP6WWKlcaaIhd5zH32ozOQcNUBkW/h2lOfiSU/glvdNJ4Vsj0lgGcTlgBkzT4IaPDjdv
	L5uTm+n1wZ9fKENX5Y7R4qoPBOtzltw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-tjVSi_7GPM-UIQd9B7GxYg-1; Fri, 04 Jul 2025 06:26:28 -0400
X-MC-Unique: tjVSi_7GPM-UIQd9B7GxYg-1
X-Mimecast-MFC-AGG-ID: tjVSi_7GPM-UIQd9B7GxYg_1751624787
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4532514dee8so5054145e9.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624786; x=1752229586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV5TxHJVxkcIeudKWCbk5OXSzT/72+A13Qm9FGClEWo=;
        b=mesCV1ZS55/wcVm0jynZf6if3UB3agPryHVYdSA/rsz4bmpo4cxMdlIPW/LowLENgl
         oQu/M3KMtYe9Fdz4bJZd4lq7naQSPbdIJ/UVp+KGJuLEzFI+PE0YciV8lnjJXDnq6HG0
         BSKI0gMbSI8rg787tThrDHgmaWthR79flJ59WimRUlS+wuCdULiWvxkrQ6+Lh2rwq93Z
         2952jbabGV9LlBYt46rrTEx2LMhGfn1cG1xClFe2+Ea4nZGux2nzHBRip+ygDjjfPeZP
         QV+BCNFmPCPU/wKQgkDBtykg9D8Ic7yAdjjiV7WWjuih1/0lHR8oVJSUVbE31bNdJrgJ
         1Tyw==
X-Forwarded-Encrypted: i=1; AJvYcCXko/G5S4RNk2LoY6w6RzOkaJ8GBL8OUYPntBYBsx6ZUWLcmOe0Y1fAnKk3f23CDIgJ0NdsXrRMhJybK5ZQIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM0Hvovjzyc9a11YlDOUHDFukIMW6IYRBA6gdfVAcHX23O2BeV
	/vIM3icWYoCdp/y4povkxTRYJdIbgUgMsBrtO3+YhF1YCplges42Re14wzyc8dtkhY/vrkllwXl
	aBBl3dstlCNCLue23vHMXoNRPwGp06NKsu0aodVcvVo/6sA6wcxAyyRratn/YOqeZwAa5
X-Gm-Gg: ASbGnctYsB/hEb7+cSUIZyD0FQI7s45SG59iIl2Tbue8D472WhOF85jjN0NEA89P7qz
	Am3stc73R7dCGkmHJnJ4ayA/T21Sj4rhP2uTURCVyKBkir96/m0mkbQwSAjJt56VL6hitTYQ7qM
	P6taSH2pM0d/UDoIWZtDLpzf0mfVL6+raWbN/VZqXjw5KIqpNCrr2svr7t3EhDG3iB5c4E8V0nU
	dcO9rBqkVZVKKqrvF8LkrfxEpSiEMIdArbcG9H/uFO7D+GLGe8M76ESGuoZJQ18RXZDnGgTpnZd
	y/M9ZJxRcdqzdwaNGCNUqpgzOLNahbpWE2QNcQSYbUJ74Wpdm77ONCWzbE7cTbLx69k32LGk3MB
	+9EugHw==
X-Received: by 2002:a05:6000:250f:b0:3a4:ebc2:d6ec with SMTP id ffacd0b85a97d-3b4964f8b3cmr1912201f8f.14.1751624786383;
        Fri, 04 Jul 2025 03:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYzN00fFm73NixytzJyssEXPIKOjCSlRb2NM6DBPHsu+yzHnAEmiJul0LvFdC9y1xbNexZhg==
X-Received: by 2002:a05:6000:250f:b0:3a4:ebc2:d6ec with SMTP id ffacd0b85a97d-3b4964f8b3cmr1912120f8f.14.1751624785787;
        Fri, 04 Jul 2025 03:26:25 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d0aebsm2166371f8f.37.2025.07.04.03.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:25 -0700 (PDT)
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
Subject: [PATCH v2 20/29] mm: convert "movable" flag in page->mapping to a page flag
Date: Fri,  4 Jul 2025 12:25:14 +0200
Message-ID: <20250704102524.326966-21-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7bh1JNCFp390pvBY-j97NfG06iNnXxlgLQ1Uc7UzCGc_1751624787
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Instead, let's use a page flag. As the page flag can result in
false-positives, glue it to the page types for which we
support/implement movable_ops page migration.

We are reusing PG_uptodate, that is for example used to track file
system state and does not apply to movable_ops pages. So
warning in case it is set in page_has_movable_ops() on other page types
could result in false-positive warnings.

Likely we could set the bit using a non-atomic update: in contrast to
page->mapping, we could have others trying to update the flags
concurrently when trying to lock the folio. In
isolate_movable_ops_page(), we already take care of that by checking if
the page has movable_ops before locking it. Let's start with the atomic
variant, we could later switch to the non-atomic variant once we are
sure other cases are similarly fine. Once we perform the switch, we'll
have to introduce __SETPAGEFLAG_NOOP().

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  2 +-
 include/linux/migrate.h            |  8 -----
 include/linux/page-flags.h         | 54 ++++++++++++++++++++++++------
 mm/compaction.c                    |  6 ----
 mm/zpdesc.h                        |  2 +-
 5 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index a8a1706cc56f3..b222b0737c466 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -92,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	__SetPageMovable(page);
+	SetPageMovableOps(page);
 	set_page_private(page, (unsigned long)balloon);
 	list_add(&page->lru, &balloon->pages);
 }
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 6aece3f3c8be8..acadd41e0b5cf 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -103,14 +103,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 #endif /* CONFIG_MIGRATION */
 
-#ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page);
-#else
-static inline void __SetPageMovable(struct page *page)
-{
-}
-#endif
-
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4c27ebb689e3c..5f2b570735852 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -170,6 +170,11 @@ enum pageflags {
 	/* non-lru isolated movable page */
 	PG_isolated = PG_reclaim,
 
+#ifdef CONFIG_MIGRATION
+	/* this is a movable_ops page (for selected typed pages only) */
+	PG_movable_ops = PG_uptodate,
+#endif
+
 	/* Only valid for buddy pages. Used to track pages that are reported */
 	PG_reported = PG_uptodate,
 
@@ -698,9 +703,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * bit; and then folio->mapping points, not to an anon_vma, but to a private
  * structure which KSM associates with that merged page.  See ksm.h.
  *
- * PAGE_MAPPING_KSM without PAGE_MAPPING_ANON is used for non-lru movable
- * page and then folio->mapping points to a struct movable_operations.
- *
  * Please note that, confusingly, "folio_mapping" refers to the inode
  * address_space which maps the folio from disk; whereas "folio_mapped"
  * refers to user virtual address space into which the folio is mapped.
@@ -743,13 +745,6 @@ static __always_inline bool PageAnon(const struct page *page)
 {
 	return folio_test_anon(page_folio(page));
 }
-
-static __always_inline bool page_has_movable_ops(const struct page *page)
-{
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
-				PAGE_MAPPING_MOVABLE;
-}
-
 #ifdef CONFIG_KSM
 /*
  * A KSM page is one of those write-protected "shared pages" or "merged pages"
@@ -1133,6 +1128,45 @@ bool is_free_buddy_page(const struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
 
+#ifdef CONFIG_MIGRATION
+/*
+ * This page is migratable through movable_ops (for selected typed pages
+ * only).
+ *
+ * Page migration of such pages might fail, for example, if the page is
+ * already isolated by somebody else, or if the page is about to get freed.
+ *
+ * While a subsystem might set selected typed pages that support page migration
+ * as being movable through movable_ops, it must never clear this flag.
+ *
+ * This flag is only cleared when the page is freed back to the buddy.
+ *
+ * Only selected page types support this flag (see page_movable_ops()) and
+ * the flag might be used in other context for other pages. Always use
+ * page_has_movable_ops() instead.
+ */
+TESTPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+SETPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+#else /* !CONFIG_MIGRATION */
+TESTPAGEFLAG_FALSE(MovableOps, movable_ops);
+SETPAGEFLAG_NOOP(MovableOps, movable_ops);
+#endif /* CONFIG_MIGRATION */
+
+/**
+ * page_has_movable_ops - test for a movable_ops page
+ * @page The page to test.
+ *
+ * Test whether this is a movable_ops page. Such pages will stay that
+ * way until freed.
+ *
+ * Returns true if this is a movable_ops page, otherwise false.
+ */
+static inline bool page_has_movable_ops(const struct page *page)
+{
+	return PageMovableOps(page) &&
+	       (PageOffline(page) || PageZsmalloc(page));
+}
+
 static __always_inline int PageAnonExclusive(const struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
diff --git a/mm/compaction.c b/mm/compaction.c
index 348eb754cb227..349f4ea0ec3e5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -114,12 +114,6 @@ static unsigned long release_free_list(struct list_head *freepages)
 }
 
 #ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	page->mapping = (void *)(PAGE_MAPPING_MOVABLE);
-}
-EXPORT_SYMBOL(__SetPageMovable);
 
 /* Do not skip compaction more than 64 times */
 #define COMPACT_MAX_DEFER_SHIFT 6
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 6855d9e2732d8..25bf5ea0beb83 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -154,7 +154,7 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
 
 static inline void __zpdesc_set_movable(struct zpdesc *zpdesc)
 {
-	__SetPageMovable(zpdesc_page(zpdesc));
+	SetPageMovableOps(zpdesc_page(zpdesc));
 }
 
 static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
-- 
2.49.0

