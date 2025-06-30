Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580C28A73C
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288443; cv=none; b=agAs2sOv/1k7JJfo9Zf4IhkktJwCWCBoKMZBYfeqeTQoKn9TwXteeVfTibR4Nx6QD0cQQwvNpv5z54UHzaLpXY8ynsk9nPL25JFu3brYPTA3U5WzM/+xDNSNAwzPz2AL0MQ+96eaOaugnNC2cRyUfUbu2N9A62dkFbuoQHIE4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288443; c=relaxed/simple;
	bh=VUTFI3+8sn+Bo7jfgsxfJB7XgkCxxsX8WPCDC/hYNNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Sf8B9pz05p4aEAxMCJS5evKZhLYET7dgendM33G3KQ9R9PIlQ6T37X1K9//gBg3g2xWWz1+DiH32pJDFsgm0ok35XHF8AGuEiLezzfb6nAkWLXcCo0K+0JxIIk6FtMhR4heJU8V6g7/ZdJIZ8qWmnZpf/uPftQ6YsH2iBONCubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvWQ+O7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvWQ+O7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9VQLTS9DDIxmZmB+neo2FcUhAnDYm//4qg3iAtoZVM=;
	b=SvWQ+O7gClByCcSLAokN+nEVv28iXq6hvW235B6I7Uvz91ysm8bPjoQUAGU+iU59FT/hq+
	PtTDGPaCscFq/fYBE1dgioAanM+EBQXJ11mVRk+7WxuWFB4GIFkeaFZSfmL+YYNvRrjq60
	ETeKfwLCn+bV/+r90xZoCYghTjUCN7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-0CzH51Y9NbmVXQy1Z9U7VQ-1; Mon, 30 Jun 2025 09:00:39 -0400
X-MC-Unique: 0CzH51Y9NbmVXQy1Z9U7VQ-1
X-Mimecast-MFC-AGG-ID: 0CzH51Y9NbmVXQy1Z9U7VQ_1751288439
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso22225165e9.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288438; x=1751893238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9VQLTS9DDIxmZmB+neo2FcUhAnDYm//4qg3iAtoZVM=;
        b=SGLbwWdXX5QpNzYi+BsAZOUV/m+eJda9XYl0CgVX/NHihtQ3rOpeXiVc9bJa/diONX
         47V7yYxoSuC6VSGLJ/d+B+NA/MlmxwTS+0uhwrlKwIreZAYozEtGWud8lsmHmFU7MgDU
         M/yVUTzal0kCRZF3BS12+eE1uGl9xBrzvqe90An28H+0uadXX/UDf3NHGztxmdkkAniS
         w+IAJi8Rn3XEkdKRdYLCa5MEBIdAZMaoERe0ICwJ+dn9H0mZftJhe0ArlPcXlrZT9vFz
         V3VM5J70akZGs0O0wc8+ENcLcadXTnsQDKWrnZnr79nhvhMp0ZJtaZ2tq5b/zhK/VG0W
         WvSA==
X-Forwarded-Encrypted: i=1; AJvYcCU+veDRajyqGH0a8EdU1q27Kl8NXY1DZWpr2SXvNXXXSAKLJLxCz+sncu9ZYughSTj+jNdQqPgPt4AEQvPLOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlfeSC3q+3URB3f9iqLxUvtS0kpC6O8JEISH9FEwJyasOxdeqW
	+j8g2FiKP/TBUzgE9f/5nBOSHQrQV810yt5RnDLyIbnmgjpcammfVdSl/ml3OAWchjTYhafhZbg
	afPtXLwIydU8THL10VOeiW5JcbV7DzWYYSZTTZfgzY11JHLztdsGHlzYgjEi8I9QUmtRc
X-Gm-Gg: ASbGncvvBXht8I/6WMOqKNeGTGgpIU70UX5/A+r4jw2zAofAbcZ9h9srGKB0P9bNLsD
	JTG5ley1XfVZDMmxwrT/aRolWCxNe6Tn9JxxTqcce8GShvhcBIQLYYx8CYWnU6LyGVEP/xt3SMe
	1XWXvO6ockWK/+FQn23T5NQ9H3+OMI/mkzmVu5DxyAAc5k+ILpzq23r0fXjGEbBsFkytZAYWCbk
	nyOi0UVtDQ5J9YH7G+NKPQlR3hoDMKZNGlPJ00RBFUpC3bdjZTkVVBiGJF7TKKZSW0qgHuDw6nC
	wJZkTr4tp9GUb7DUMtjtbjaf9vedkT0g+YXo1zfOPWSbG57F/u11/kOcC76OQSSG4qxRE9C72af
	uAcou3G8=
X-Received: by 2002:a05:600c:5251:b0:453:6c45:ce14 with SMTP id 5b1f17b1804b1-4538f2c6a5bmr116867315e9.4.1751288436028;
        Mon, 30 Jun 2025 06:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcKPudq4hAX3ZUQbBxj7a9OFNaExkIT0GfF2UdhGugpVpmsHfKtz6PBCtjyRSKpLMaHzgIYg==
X-Received: by 2002:a05:600c:5251:b0:453:6c45:ce14 with SMTP id 5b1f17b1804b1-4538f2c6a5bmr116864905e9.4.1751288433794;
        Mon, 30 Jun 2025 06:00:33 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a406489sm136741305e9.27.2025.06.30.06.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:33 -0700 (PDT)
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
Subject: [PATCH v1 07/29] mm/migrate: rename isolate_movable_page() to isolate_movable_ops_page()
Date: Mon, 30 Jun 2025 14:59:48 +0200
Message-ID: <20250630130011.330477-8-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: PBTEUKhCr5fla7iHZeM8HT_PEPTtNDtdiLgzgbfAf3Y_1751288439
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
index 767f503f08758..d4b4a7eefb6bd 100644
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

