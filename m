Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE42FCFD7
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268453; cv=none; b=H0nE4IJmt1BVqPqsCPAPbeMrHLVqIAGg5hk+X/8Yo7O1vJrb8M4u8Yw470ET0fzfHGy8lywgRMbneTOLDdm3IFSUrqCF1IhF1p3MkZKnIA6q7EiWodc2wDKbCvh7VdqhXhRjYGx4mkAmNFjD2ecQVpB0ztorRCDk4qio0AA2cjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268453; c=relaxed/simple;
	bh=D5IKjl7h4uxnWuYRcVu+bMy926nngQzlNWfjJA6AuzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qt5PEjaBXarVkSqjHZa4bzFKRk+6IQw/t5UrV1j8sPS3N0TLb5OxdY9qrYcRBq4J99qZ5UssU3Ir4z7Nw0NU63I52nwb/CRFa/acStNXK8nuzQIdpti0az8dYEvI8DXh7Usk/X3dcOpRt+EuNHIDJFdlR9LGbh6FuYcCQf3R9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igCM1BxL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igCM1BxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYycAi7wypL2i/sUXw4R4ObGitZAt3xcPvEHBQISmjY=;
	b=igCM1BxLfH0M31w+FaG53bt2QtcZDxmx1m4dpF77WMaHLC0z7H9aLpRirODfUKl51pRa0h
	pYD1cIM36XT8FARx74hMyVOwll0Qv//cHedQnugdyHcs+I0lqBbWl4htm/ThjSJZ2E+KWa
	csIBBx40MB5tx34fijt7xrghnAl/tXg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467--4jgQiZ4MaK4rowzWU-Bcw-1; Wed, 18 Jun 2025 13:40:37 -0400
X-MC-Unique: -4jgQiZ4MaK4rowzWU-Bcw-1
X-Mimecast-MFC-AGG-ID: -4jgQiZ4MaK4rowzWU-Bcw_1750268436
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4535ee06160so490505e9.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268436; x=1750873236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYycAi7wypL2i/sUXw4R4ObGitZAt3xcPvEHBQISmjY=;
        b=esWV5nvuh18Zanr26a+vojJ/wmuD4SIe+rAl64useapPHeaLY2QzvdKr0PAB+Z7VqZ
         wrRjecL0ALeG1PaV8bkpqFG3GIjGgzuLBtc3OUCv8L/XIJpUbmax7wRojOGMdwSERBps
         b68sQLkfncU/fSRHNhNaOILMvfA9HU4qkQRNnhA3qfjumHxvcVJibc4KJ4wUYjYh7gRT
         go97S/cSToawODP2l//02y3WGPl0fkwGSDir2q9r4D0zMOtmhjxIHslPMFb1JhqTq4nm
         FpqkdxurYZCyvuwCwf3zkoqhKRMvFYww5yLykF35aNYUXqW/Qee6/j0rjjevHYaxaGOo
         XtEg==
X-Forwarded-Encrypted: i=1; AJvYcCXpk7itNJa/EyPZl4l3BFj4EsAcnwMqMZpFnsmMCTZ6i7pE3C50yMwk8Nuf8omh+r7G0VIxtZuTiod6faNgBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsP70ZHtHX1CVyqiqxmffAhkjnzS3pit7n5pPTDie43/i/AIiB
	BZANiFiMoU0CGlBf7Sw/+DD7G+Bn09p3rxyKGsq/x0Xeq+nnuxVUwxQw0mdtd6x6hFbLUrONZrt
	UrKMm0lfx1dDjKcDLk0YM4sTNA45ZWzVk+j6x0HbRZ8dm2V9Iio/sonZG9gjOuiKlejkt1MuSeS
	5U6vQ=
X-Gm-Gg: ASbGncvh4MLb2p3lAhA+PApdhGjWdRm13zRBqwR8OjSDsDyC3OsxO0C6ASSv7rILeP1
	ocNcGMwbaT6D5sifTBp8vxcgzuwEf/c2b/UriTgYjZoZoI2qdGp3OJIVm7bJoig2XxCf/FD1etT
	ncbW0OebcHBdkYFsZ5h8n7TFw92vpsjH+wAfgNZ09HM4ob4aqx6AFqmw5ogHtLVGn8CROhY5ABY
	51NnZhKLnTMekQmCnOyp21IbVXcfphFs5XAotGlSlGwt0FQ7sl/J63QwDyYY4Ob50mAyVD0p96M
	fGg8Of39vkPMBtJgeDt1x4pCsI37/ohJFOhr+f6TWGC8K4yhnLqYyEEGYEbAE+rCtv1fTxd+Dnj
	JkXv1kQ==
X-Received: by 2002:a05:600c:1c8d:b0:453:dbe:7574 with SMTP id 5b1f17b1804b1-4535018683amr106187415e9.12.1750268435827;
        Wed, 18 Jun 2025 10:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUDiWgwWbQgJVHFyRRixono5bEyE4cqQlAJV7lYOWhJt5afQ5kfI4WOQTfix7X+TWBj4ApqA==
X-Received: by 2002:a05:600c:1c8d:b0:453:dbe:7574 with SMTP id 5b1f17b1804b1-4535018683amr106187035e9.12.1750268435264;
        Wed, 18 Jun 2025 10:40:35 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e98b4bbsm3633515e9.15.2025.06.18.10.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:34 -0700 (PDT)
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
Subject: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to isolate_movable_ops_page()
Date: Wed, 18 Jun 2025 19:39:50 +0200
Message-ID: <20250618174014.1168640-8-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: wtPpM1v-cPbxOyZR9QtcxyMujvxZSnic8vzmwbJrdSk_1750268436
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... and start moving back to per-page things that will absolutely not be
folio things in the future. Add documentation and a comment that the
remaining folio stuff (lock, refcount) will have to be reworked as well.

While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
it gracefully (relevant with further changes), and convert a
WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().

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
index ea8c74d996592..6bbb455f8b593 100644
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

