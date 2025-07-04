Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAD2F4A0A
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624753; cv=none; b=KwDJBVhbuB/WRDQ3YNvEHhNHwvv8UJYG0r0snAtiz2wRDPUMQkH2etDRXwkzZ2B9sUtDcykgnIrCJ/v+tPkwz0zFYWPcXLz5VWIBSTzCn770gir2+1Yd5wcEEGR6PEPIdUn45gvqxKuhtAKhh4hYeDQDiD+msGFLKzC08l27TwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624753; c=relaxed/simple;
	bh=7TUaaUyg2IzBDFvzKzP8aimVtjWSRKkvRG2kLM2JAsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XXdAQ8dfKsPuUzgLaHPQvF2/BVtSjlCgP67HkQMIM+RdQ/Bt43Q2sPqMbrPPZIun2ie+E57Z2r9YdFpkxHx51ZqZn9Q7m8cBd5ZS6eSowaroJ5YIl1IFWiFQy77rcnBWZDBqNRi4LDPVZMTAKoPbIDvXWNvlFD+IacC8lWuVhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8z/cyO4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8z/cyO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hFW2iBTC0y3bbUq+s26fylaJsmqdGOzvykr6tgw4lA=;
	b=D8z/cyO4UMSFfw6LZj3xBFeQXbGEGIzzBonbU8GJCu3EDOzzdNAqp/REvcNdzZLWobAaVt
	O5O3FnRXUZFobdM/O59vKpmCYEoTeT8iqreuBhp8cXj3AakwD+sr23iLZHfAnQrt5Fu3fK
	C88F0da84C4m9TYQKHN4f8lOgPxpYmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-jpij01bYOkCGr6vKYMmIig-1; Fri, 04 Jul 2025 06:25:49 -0400
X-MC-Unique: jpij01bYOkCGr6vKYMmIig-1
X-Mimecast-MFC-AGG-ID: jpij01bYOkCGr6vKYMmIig_1751624748
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450de98b28eso9357215e9.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624748; x=1752229548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hFW2iBTC0y3bbUq+s26fylaJsmqdGOzvykr6tgw4lA=;
        b=SiSO+jOG8MJFE7EvTnEI59NrPeh7S7eoxz08TJb9oP7FvMR2rx5i5peD+m1xaC9X84
         QimjFHNUz9MIxkvImOgrhvlTiUwFbF6d50dlQ0EJqCz49qj8rQuAkDONzjDpNX7OC2zs
         GUtSNM70pdTWcH4rNN4jikmW+7oayE7/AoVvHt93qUhqZlQ0tOONjlL0xn12Qz81jz86
         BKP1t1xC29c+GrjzC5mMklggak0LSIyX7YwxEB04mkPYysHKUbe53mK3D8rHfBBJx9nW
         IdCBLBrrjDZxScchBICdQz1vvT9PrLnfJJGB+QMQRJrUAD7UmairrlL4uhQ8Ik3o+vKj
         jwQA==
X-Forwarded-Encrypted: i=1; AJvYcCXrQ6mlOswq4a3ZLzKidz15qmpeJsBJMR5Cq4wcFdvxcJdU2q18/deWTFWfB2BL0T7HUiCTOmgLjxiwZjyeFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy74yZTBfFr33A8v75YAKBkQ0iaHFc6Aq5HkSHByVhYgTf57fE
	47d6DrIskpbZHw44vWUSqrTO4EmgodVZyhnlfFPR952IOx8DXjgN38u89t1VulOoQ0D7DhGWYO8
	B4/dAzezp5RNZ/0GEQIVCBVgbfrj+27N2x1vTU4LcqvQYdpTjWEsZemg0vuzYeVwFNiVr
X-Gm-Gg: ASbGncvnA8r8DZ4awer+1jXXiq1Obj/4gxbdTIAvibJ1I+SLrBPvrcT3oP9KV0eSd/g
	wfgOeYCbCDROKAf+/oz+NWUZF+L5L6JvYdWClafhuNe4E+nFMF9V3DEp6xzykB+xy5Mm0PV34Jc
	YIBo1IuB7jwbWNKA+nLPYlet08I9jdi0u23q1NhrHCDMxkx0CBY67fwLtPDS8owqyW56bQHcFiS
	ktvc4kD+k5N3xCeATYHzPYEFkzZwA5wFtLRoH+GuzBXdqSAEsoWgLJBPbOyq/0XEKXXqyGUup8t
	i+npFTR0cJNeDgyEwH1oBMyLOce8ljzR57lyDkxpEAfI0jgZOJtVcAv4tKwu44OPFSshacmF9qc
	nuR35kA==
X-Received: by 2002:a05:600c:4fc9:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-454b3ab874dmr19033045e9.3.1751624748219;
        Fri, 04 Jul 2025 03:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYcpd9SFcoaWfQeqRe14xBG83tSrWUHlht+bCd9eNO7YiXJuE62xvkx/e2Wc1s4dDi7NCxDg==
X-Received: by 2002:a05:600c:4fc9:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-454b3ab874dmr19032085e9.3.1751624747587;
        Fri, 04 Jul 2025 03:25:47 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9bcef22sm52038125e9.19.2025.07.04.03.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:46 -0700 (PDT)
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
Subject: [PATCH v2 07/29] mm/migrate: rename isolate_movable_page() to isolate_movable_ops_page()
Date: Fri,  4 Jul 2025 12:25:01 +0200
Message-ID: <20250704102524.326966-8-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DlqrX--S9awnYRnmqNpQcZA7PbHt9N4FqnWILHHd93s_1751624748
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... and start moving back to per-page things that will absolutely not be
folio things in the future. Add documentation and a comment that the
remaining folio stuff (lock, refcount) will have to be reworked as well.

While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
it gracefully (relevant with further changes), and convert a
WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().

Note that we will leave anything that needs a rework (lock, refcount,
->lru) to be using folios for now: that perfectly highlights the
problematic bits.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  4 ++--
 mm/compaction.c         |  2 +-
 mm/migrate.c            | 39 +++++++++++++++++++++++++++++----------
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index aaa2114498d6d..c0ec7422837bd 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -69,7 +69,7 @@ int migrate_pages(struct list_head *l, new_folio_t new, free_folio_t free,
 		  unsigned long private, enum migrate_mode mode, int reason,
 		  unsigned int *ret_succeeded);
 struct folio *alloc_migration_target(struct folio *src, unsigned long private);
-bool isolate_movable_page(struct page *page, isolate_mode_t mode);
+bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode);
 bool isolate_folio_to_list(struct folio *folio, struct list_head *list);
 
 int migrate_huge_page_move_mapping(struct address_space *mapping,
@@ -90,7 +90,7 @@ static inline int migrate_pages(struct list_head *l, new_folio_t new,
 static inline struct folio *alloc_migration_target(struct folio *src,
 		unsigned long private)
 	{ return NULL; }
-static inline bool isolate_movable_page(struct page *page, isolate_mode_t mode)
+static inline bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 	{ return false; }
 static inline bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 	{ return false; }
diff --git a/mm/compaction.c b/mm/compaction.c
index 3925cb61dbb8f..17455c5a4be05 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1093,7 +1093,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 					locked = NULL;
 				}
 
-				if (isolate_movable_page(page, mode)) {
+				if (isolate_movable_ops_page(page, mode)) {
 					folio = page_folio(page);
 					goto isolate_success;
 				}
diff --git a/mm/migrate.c b/mm/migrate.c
index 208d2d4a2f8d4..2e648d75248e4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -51,8 +51,26 @@
 #include "internal.h"
 #include "swap.h"
 
-bool isolate_movable_page(struct page *page, isolate_mode_t mode)
+/**
+ * isolate_movable_ops_page - isolate a movable_ops page for migration
+ * @page: The page.
+ * @mode: The isolation mode.
+ *
+ * Try to isolate a movable_ops page for migration. Will fail if the page is
+ * not a movable_ops page, if the page is already isolated for migration
+ * or if the page was just was released by its owner.
+ *
+ * Once isolated, the page cannot get freed until it is either putback
+ * or migrated.
+ *
+ * Returns true if isolation succeeded, otherwise false.
+ */
+bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 {
+	/*
+	 * TODO: these pages will not be folios in the future. All
+	 * folio dependencies will have to be removed.
+	 */
 	struct folio *folio = folio_get_nontail_page(page);
 	const struct movable_operations *mops;
 
@@ -73,7 +91,7 @@ bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 	 * we use non-atomic bitops on newly allocated page flags so
 	 * unconditionally grabbing the lock ruins page's owner side.
 	 */
-	if (unlikely(!__folio_test_movable(folio)))
+	if (unlikely(!__PageMovable(page)))
 		goto out_putfolio;
 
 	/*
@@ -90,18 +108,19 @@ bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 	if (unlikely(!folio_trylock(folio)))
 		goto out_putfolio;
 
-	if (!folio_test_movable(folio) || folio_test_isolated(folio))
+	if (!PageMovable(page) || PageIsolated(page))
 		goto out_no_isolated;
 
-	mops = folio_movable_ops(folio);
-	VM_BUG_ON_FOLIO(!mops, folio);
+	mops = page_movable_ops(page);
+	if (WARN_ON_ONCE(!mops))
+		goto out_no_isolated;
 
-	if (!mops->isolate_page(&folio->page, mode))
+	if (!mops->isolate_page(page, mode))
 		goto out_no_isolated;
 
 	/* Driver shouldn't use the isolated flag */
-	WARN_ON_ONCE(folio_test_isolated(folio));
-	folio_set_isolated(folio);
+	VM_WARN_ON_ONCE_PAGE(PageIsolated(page), page);
+	SetPageIsolated(page);
 	folio_unlock(folio);
 
 	return true;
@@ -175,8 +194,8 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 	if (lru)
 		isolated = folio_isolate_lru(folio);
 	else
-		isolated = isolate_movable_page(&folio->page,
-						ISOLATE_UNEVICTABLE);
+		isolated = isolate_movable_ops_page(&folio->page,
+						    ISOLATE_UNEVICTABLE);
 
 	if (!isolated)
 		return false;
-- 
2.49.0

