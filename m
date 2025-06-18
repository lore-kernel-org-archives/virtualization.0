Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719A2F4A15
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268476; cv=none; b=j8fgTMmYM1XKhpnDzXswbbztY5a9dhNi/+0m0MnMn63ECrOvKaxLY0LebzC2iVOtf6TKSFm3i+yVWPtZz8pbVnqOqS6lYOS20EWnuLbQhjenXUSukYcIRIJVX+95jE1Y0jz8+yKPqmMTLsW5YqZ94R8+c3a6MGLw4Fg2v5+LBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268476; c=relaxed/simple;
	bh=xdS5HD4MUJ1SAp8T3v4mmHtDVA5N2mYHTeOtyErEsCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CnUQCtPDzAz054YhmeIr4CeLdAG+Zlgxya6RT99F310GJAiYDImdmuBrJVZwzr/xiSeOcCP544AzsRXspmJgP8EardtxR8Vl+JwJr3KBcnp0u0gJJWgSHNNxpl5RtlgdbImKWN5uolX6xX2FKBll6BoXNBxFhC8ARWTPtDK6a2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvevACSi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvevACSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAf4Dh14UAIqeNeWRGXlrmZ3XJWuUden7rJ9s11c67A=;
	b=cvevACSi4VucHNQjJ6pJQnCVYR5ScHGn56gINBx0fJhLj4S3/gpLaTbnwSKY3G7ybCW2M0
	a0MhJHo+fUvUBRJ50ZYQJlPcjiB/Uz5TmLhs1Z5O8ZSjC68ytBIr4lDeUQsy7BSG1FbJLl
	acpOfTa2Y00t7nnjBgwKUPcQjeOcFts=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-nQwZRlhsMWC99GVyLphnpw-1; Wed, 18 Jun 2025 13:41:12 -0400
X-MC-Unique: nQwZRlhsMWC99GVyLphnpw-1
X-Mimecast-MFC-AGG-ID: nQwZRlhsMWC99GVyLphnpw_1750268471
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816cc58so2470415f8f.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268471; x=1750873271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAf4Dh14UAIqeNeWRGXlrmZ3XJWuUden7rJ9s11c67A=;
        b=eIpjQb5NreErLvWG+3xDJZGqV0XrqNnZP/ACKKTHAkAFRgdF6E4n13iZAdM8MWsYzf
         p1AwMMw+PD4rRq52P5LcCEUHRXZnudXXtMD2ipq5aHSBu4PR/EYh3kj/rgLPEa4za1oB
         cKGmeN18kwtQWxYCqMV7fgvuZhK9VbW/l/D7wkmCOooZMVJtYo01VPoY5b3B+eaLMvck
         GR+0XvoArJuandWMG8wLE1s4cns9vyIzntAo617LyELnSPCHS71sU1SDkTUb9zbr4m3T
         YwOIZycLD8Qw9VaxXNOk093zU/xJt04n984crOCb9yTAzw0qfq+BwfXQwKfB95s4/1Jv
         y8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJveAdfZB+5Qa99f2Jk9dw0L13KzW8cSU9YJWPrrlLDwofsvD0cvhPut/a29LQTA7mnQgDgbHqPkTd6vpWXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZfXV+2+vbcXch04Tym4tn3EsOz2FZlZUFBlcsF6zOvY2goVxK
	aY0ux4H7YI069coN4Wu++/M3EHp9vVFJz/rY4yWblOn34iTYm1Jw890b+WNp0Cwc7mwUF2w+H2O
	S5zCYqZwskLwVTFa6VBW42U+B7oqhJIFaid2GcxVsC2evJgdn5ZEKAGs69sqbfdq8UPZP
X-Gm-Gg: ASbGncvoKAUpdKygCzMgLRqupGCeErD3EXsg9utpZMs7f6Kc39sszj0wIlAmE4FSWMT
	Rnu/BGwyHIfZd2neE1I0OC+orKyZeps8JEECbEImtkZjjsrSGqERISRaqUi6LxBt15novocDqIK
	ZAEDYpfQIFpOxJGzVqnQ4Tgp8IpghPjmCVBexrYWc0DjcjsDj9tV3t2Idql+xMke1BvZwIjOJXh
	HTLrPRv1RLS9uXbHO8Wy6aTuEOdlRAC+LDdDNED5+kMH+HkG0FUlRhkXG2YyYXDuTUzP9zK5Vgs
	Jx9aoXnjbz5LyUQ3AVAQniBOjEP2HBQxJubWHnCdNGA2f+Evyg0c3AYii04DGCZJQR+iPzhrknD
	H0BECtA==
X-Received: by 2002:a05:6000:643:b0:3a5:858f:f6c4 with SMTP id ffacd0b85a97d-3a5858ff721mr7648570f8f.24.1750268471042;
        Wed, 18 Jun 2025 10:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+8+c12bV3QXFpelqf7ZUsWU+nueVuiLXazDhi/qX6uph+PN90J8FEbsBo/IgcCAbkgHz7uw==
X-Received: by 2002:a05:6000:643:b0:3a5:858f:f6c4 with SMTP id ffacd0b85a97d-3a5858ff721mr7648508f8f.24.1750268470566;
        Wed, 18 Jun 2025 10:41:10 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a7ddefsm17533369f8f.39.2025.06.18.10.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:10 -0700 (PDT)
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
Subject: [PATCH RFC 20/29] mm: convert "movable" flag in page->mapping to a page flag
Date: Wed, 18 Jun 2025 19:40:03 +0200
Message-ID: <20250618174014.1168640-21-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mjiTG5yNK4vgPVTUv24J72-LVMJXVAMMPwNMbOGgYEg_1750268471
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Instead, let's use a page flag. As the page flag can result in
false-positives, glue it to the page types for which we
support/implement movable_ops page migration.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  2 +-
 include/linux/migrate.h            |  8 -----
 include/linux/page-flags.h         | 52 ++++++++++++++++++++++++------
 mm/compaction.c                    |  6 ----
 mm/zpdesc.h                        |  2 +-
 5 files changed, 44 insertions(+), 26 deletions(-)

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
index 64639dab92b91..314cbeba1bb91 100644
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
index 4c27ebb689e3c..016a6e6fa428a 100644
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
@@ -1133,6 +1128,43 @@ bool is_free_buddy_page(const struct page *page);
 
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
+PAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+#else
+PAGEFLAG_FALSE(MovableOps, movable_ops);
+#endif
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
index a10f23df9396e..86d671a520e91 100644
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

