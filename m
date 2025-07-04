Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E782F5497
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624766; cv=none; b=KtVFbPxdzOT5zuhXVbJVOK9TM+sX/b3cL+x4OOQONchyoI4XiuAmdOmO1SHsVQbtlKP9Ljn2MXhf7Y+pGwZ6PO/6QbShk+ZRSEAfIMoKcoByxVI8PNbCHCEqav0dkyaNac9JXIvpfuAN0PIkBcbjDO3pz1J4s7SxR7emKMg0U2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624766; c=relaxed/simple;
	bh=swel6heCLe+a58/SBtwcEbCcsdg+XKI9KJ3bEmmRbuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aXt5elUOxgcKZvlJhvskgwwZfFpzlV09e4X1qFL2RpjcCZggwiveFMj8V41dMxNw4CJabdnU1Dlu/PSDoEvNaUFDhJF3QQgZK8mLb/YQwWt68jTXGZi81C4L/4JUj/QHpejaV/WieLShIxieZ+Y2ZHvQl9QNhvlvkUAyGqmLaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hvf6N3yC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hvf6N3yC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNuyprjgbIdX6AHgfTXgzVcFKi/kDd27yjboz7bS+HY=;
	b=Hvf6N3yC91gYoP2tUU49XiPBgzGG/L7VW6AdD2JBioeb7P2zJXcDT9Rysyh6RPXmsKf5Z6
	Pp1q3FJ/WC582x8U46Al8RZsJA+CU6pHtstqBzvYps6ErRqt2QvKNk+0mN2wf2zqgX2uyi
	5emTAxUerg3yzcg16NderkvxCz7RVZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-0ny-gsmHNF6zpfR41mPcUA-1; Fri, 04 Jul 2025 06:26:02 -0400
X-MC-Unique: 0ny-gsmHNF6zpfR41mPcUA-1
X-Mimecast-MFC-AGG-ID: 0ny-gsmHNF6zpfR41mPcUA_1751624761
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so5193195e9.1
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624761; x=1752229561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNuyprjgbIdX6AHgfTXgzVcFKi/kDd27yjboz7bS+HY=;
        b=K2bjtMLJb9y7m9DJMSl/D6VdlaFU0g2xCRYsCM6cmf05New2QqDIVg8OztIhYTJsch
         kHqknheezgoKvor7bS6b56Nm8nG+hIggNPyIlBKYL6Su0BpC0pobPxOnIqcPyuLGxZrc
         lJ7ns2QGy4Hge+Hg0v5oMuL6V2ee7520Fkgtkmt30S69/KlgclGpnOir5Wo9Qq5Frpp2
         ujDwN09gJeLv2v2L183RqvN/fzf78Q+X9d5e63N+kH7i924lV1K2g8qTE6q4oRmrDd+P
         4uyCdjcfDokLsXVq49LeBYf1RYZh9pXEZcOsu+Zaays7vc009BzJFFCdhL7dAxZe0Aas
         OujA==
X-Forwarded-Encrypted: i=1; AJvYcCXulbEr3zcDvLkAj/HFoiheqYPlg+ZFuq1K4qm9YDLWalJRLU5b/BwmpHVvooD9yPJpmTdxmXq2ysv0Ua0FGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl3EIMBSRs7is/6Sd0UGRtyWpMD1NTn+WRBSuWWrREESFxTvRK
	rtEujNt2kFIr6Z0VN9tDqQOBADPfsYlJiO28TiSh6vG9qXpYXFYXgvOBM3z+g6UrgzetLn9Dta1
	RulU2ULGXMRVHqQv/ocM1MGkTOBvEehCQamQJQCr6mvdplwz6RgCVPS0Czyj3nei4OzIB/1XR4X
	HB
X-Gm-Gg: ASbGncsO3jOJsCn7fZgsVUr4eCQpKUDJNtMDio/YiZdWKUaw8VWESgfE9BrcppRCe9Y
	rqgCUYNDARry4HU2tDBPlxgOXD6h3oWdBc98w0aqcAJH2TBfGNnFORROVfjBQTWGXdic/TPYcAt
	CJtlXPtzaxNmQBxCshWDyPSjTxGocJmbV5RMKYQX9WLSiCuiZWHFZcjtKW351SL6/BkYT1pqnpA
	PU30uoO7dQiUZwb4/YK+TILHba7Q86mAdb0jhIK0qApvTnS+h+fVEmmrcQm4AEIQ38REFfvgvxC
	0ED9sUXWXmTbVZdamGedSMnQ3ZYcVCeEsGkiNUcWqti8EeWS+s2G52NxJh6zhF6hhQJruDY9QP3
	sPdT+UQ==
X-Received: by 2002:a05:600c:8214:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454b4e74957mr16127845e9.14.1751624760466;
        Fri, 04 Jul 2025 03:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8vCOgrvNVf6Wu0EKSuY1xmeHKjerawOF5tOLzHfBQzCNUvjojZFchXxtXOEn9U9CGQYVIhQ==
X-Received: by 2002:a05:600c:8214:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454b4e74957mr16127045e9.14.1751624759877;
        Fri, 04 Jul 2025 03:25:59 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47030bd42sm2093511f8f.5.2025.07.04.03.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:59 -0700 (PDT)
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
Subject: [PATCH v2 11/29] mm/migrate: move movable_ops page handling out of move_to_new_folio()
Date: Fri,  4 Jul 2025 12:25:05 +0200
Message-ID: <20250704102524.326966-12-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: xiDl_ytQKrjdivzlILhI7ZDQjr1txnChYxygdyFONX0_1751624761
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's move that handling directly into migrate_folio_move(), so we can
simplify move_to_new_folio(). While at it, fixup the documentation a
bit.

Note that unmap_and_move_huge_page() does not care, because it only
deals with actual folios. (we only support migration of
individual movable_ops pages)

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 63 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d66d0776036c3..9a63bd338d30b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1024,11 +1024,12 @@ static int fallback_migrate_folio(struct address_space *mapping,
 }
 
 /*
- * Move a page to a newly allocated page
- * The page is locked and all ptes have been successfully removed.
+ * Move a src folio to a newly allocated dst folio.
  *
- * The new page will have replaced the old page if this function
- * is successful.
+ * The src and dst folios are locked and the src folios was unmapped from
+ * the page tables.
+ *
+ * On success, the src folio was replaced by the dst folio.
  *
  * Return value:
  *   < 0 - error code
@@ -1037,34 +1038,30 @@ static int fallback_migrate_folio(struct address_space *mapping,
 static int move_to_new_folio(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
 {
+	struct address_space *mapping = folio_mapping(src);
 	int rc = -EAGAIN;
-	bool is_lru = !__folio_test_movable(src);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
 	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
 
-	if (likely(is_lru)) {
-		struct address_space *mapping = folio_mapping(src);
-
-		if (!mapping)
-			rc = migrate_folio(mapping, dst, src, mode);
-		else if (mapping_inaccessible(mapping))
-			rc = -EOPNOTSUPP;
-		else if (mapping->a_ops->migrate_folio)
-			/*
-			 * Most folios have a mapping and most filesystems
-			 * provide a migrate_folio callback. Anonymous folios
-			 * are part of swap space which also has its own
-			 * migrate_folio callback. This is the most common path
-			 * for page migration.
-			 */
-			rc = mapping->a_ops->migrate_folio(mapping, dst, src,
-								mode);
-		else
-			rc = fallback_migrate_folio(mapping, dst, src, mode);
+	if (!mapping)
+		rc = migrate_folio(mapping, dst, src, mode);
+	else if (mapping_inaccessible(mapping))
+		rc = -EOPNOTSUPP;
+	else if (mapping->a_ops->migrate_folio)
+		/*
+		 * Most folios have a mapping and most filesystems
+		 * provide a migrate_folio callback. Anonymous folios
+		 * are part of swap space which also has its own
+		 * migrate_folio callback. This is the most common path
+		 * for page migration.
+		 */
+		rc = mapping->a_ops->migrate_folio(mapping, dst, src,
+							mode);
+	else
+		rc = fallback_migrate_folio(mapping, dst, src, mode);
 
-		if (rc != MIGRATEPAGE_SUCCESS)
-			goto out;
+	if (rc == MIGRATEPAGE_SUCCESS) {
 		/*
 		 * For pagecache folios, src->mapping must be cleared before src
 		 * is freed. Anonymous folios must stay anonymous until freed.
@@ -1074,10 +1071,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 
 		if (likely(!folio_is_zone_device(dst)))
 			flush_dcache_folio(dst);
-	} else {
-		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
 	}
-out:
 	return rc;
 }
 
@@ -1328,20 +1322,23 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	int rc;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = !__folio_test_movable(src);
 	struct list_head *prev;
 
 	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
 	prev = dst->lru.prev;
 	list_del(&dst->lru);
 
+	if (unlikely(__folio_test_movable(src))) {
+		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
+		if (rc)
+			goto out;
+		goto out_unlock_both;
+	}
+
 	rc = move_to_new_folio(dst, src, mode);
 	if (rc)
 		goto out;
 
-	if (unlikely(!is_lru))
-		goto out_unlock_both;
-
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
 	 * turns out to be an mlocked page, remove_migration_ptes() will
-- 
2.49.0

