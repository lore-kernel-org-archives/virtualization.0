Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8F28B514
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288476; cv=none; b=Jym6HEQDbnSiwvSo/D1ILcP+wy+/y08tcfofURfmpaRa2lyri7zxEBhz+hXXLezPpfSnNK/ZNO1SsLMpX42yJsgFm4XdGKj8Z7S8pMhnW+LoaiCbMhSbVrgeSR1yBJxUqXjLIRmke7Rfig3EC3BHL4GX3WSKBsp5CCI+qprD0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288476; c=relaxed/simple;
	bh=JYH/x/ortLB+OYxymb8gQIrEBsMUH0D5wYAFvvj+W2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Dv6BajzPi8Na0GDSLtRiglIhz9o7zM/MCrRpEXfFmyn432I9W5icW9igN/qvnidEG52lGJ9dTISEHVlGHVr8zYTAU4vgOaHCXDHMu08o0JDB9dFf8v3NUu/GzopS6RR2Wi4EJOV0BBYTy2G1vgYX/6wAin3sJD0ItGdtnImfjgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJ9hWOgd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJ9hWOgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7h0E3JSTi0/tTXxhJU2J3wMLvxjdNIbt9+WrjT2dUzo=;
	b=hJ9hWOgdIcpsGWxXZEy4JceXOdsl/XinhBjaidzMgxqkUbzSX3l1iDtoh55Dm/nJolBBmx
	6fuow1b7pKrnp2VxRgDyy7hA7/gkvOAR144n4lYdElJVGa2fWZmZw6T02REIxLfnpaa3ho
	ZqZJKwcinQknmurxhzU2ED/kmkEsOgE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-9ub6B4W_OqifHPTrsVeE2Q-1; Mon, 30 Jun 2025 09:01:09 -0400
X-MC-Unique: 9ub6B4W_OqifHPTrsVeE2Q-1
X-Mimecast-MFC-AGG-ID: 9ub6B4W_OqifHPTrsVeE2Q_1751288468
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so2208272f8f.2
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288468; x=1751893268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h0E3JSTi0/tTXxhJU2J3wMLvxjdNIbt9+WrjT2dUzo=;
        b=kyC3Tjnw7c0wzp2JjIQVebwFv8vkUnRouUu6lao2nsXw9gBHTaH8e+3/fhLF1mZn7p
         NYiO7Ydlt3tOfois9avw0Mbyu/KpVN7AutjekvvLW7ihcieK/4GpLGZI1EASXJlFt83o
         8Ni4m0zcR6upUejS2h9bH7qpaYLsuB50ZgPUiQ3FLniFxyT2nauiSMKLO/dC9g5KOe9x
         i4rYslaFTXdBEFzGlmd92+DLTm0yrM/kZcQC6PK3ycSaLgbgkGnkwrCcVRTExT5OPXDB
         yLrjolhA5JYpW2QKV0dyCYzx5RsZAIg+VVxLHrx+IJIQXR9eyg5O5xkEP3wopE08PKH+
         HnrA==
X-Forwarded-Encrypted: i=1; AJvYcCXR40obaximkiXVFMh/zT1z1OyjKbxKC1qS+xl0ZJR3nqgBpgPbCwJFd/4VX4tRaYUqVdL/qdEY/lZ7wb78fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZHJeiKwKwLQAbD/Tv/pSMGxEzPe2wkfivl4NUWiBdyi9dVGgn
	bU7f/FHgHFPg9SVIh26xk6jbhyb1coocWG4gtX0uxyE2GJncShKeJXCeTXcP7LuY4tTDkqU9ASA
	WbU2oP+MeElNEoCjmlzEbm1a/wnjbaI5Y5yB5lho1puXI74KT6aPaO76duHndG2rQx6DM
X-Gm-Gg: ASbGncsPOk0Ez0qnPY9QFsOa5Cs5xENa5+jzMmFIWioSP8Z2h+zEp8c3hQsjCr+sEAv
	YcEIWEsB5DSi8G3QH8rX5W8kjMx6poANALr9qIRfrA/HIhay+8NwUhpA0lBKNxFR31YpKt0bNoA
	SthGjlozAqBvRcOahC0bM2LetygqpUNmK3/nPrSLnncg1OIUbtuLe/3Oq1rCTk6L4uqceIBtywE
	1LiKIA2diCjwFj8T3kb0Bcd0Vq3LF+JSugtETuCAjpBMQv/fmMiXP72x81v6q0j5nQRFrQl87me
	q6Pxz6E+3cEj94dVdDNZx7Xy1Wm2BjmkBFFDAnF2UyMwow+OOw9c/rwq6vkJvsMKUOzvNUouXcC
	33kn7bZk=
X-Received: by 2002:a05:6000:1789:b0:3a4:dbdf:7154 with SMTP id ffacd0b85a97d-3a90be88de8mr11746760f8f.54.1751288467070;
        Mon, 30 Jun 2025 06:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJi8Mvk9HNQG/V6DvaTdZ9vax3u5pZXK1PzboQ8KoLkq4f/Yx4ezN8OGoebh91nmBSeSp6MQ==
X-Received: by 2002:a05:6000:1789:b0:3a4:dbdf:7154 with SMTP id ffacd0b85a97d-3a90be88de8mr11746576f8f.54.1751288465725;
        Mon, 30 Jun 2025 06:01:05 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e52a26sm10500359f8f.51.2025.06.30.06.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:05 -0700 (PDT)
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
Subject: [PATCH v1 18/29] mm: remove __folio_test_movable()
Date: Mon, 30 Jun 2025 14:59:59 +0200
Message-ID: <20250630130011.330477-19-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: bWbAvg80AKFMHeNOm4kbW-fKWccPsh6nDtNUs_B96W4_1751288468
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Convert to page_has_movable_ops(). While at it, cleanup relevant code
a bit.

The data_race() in migrate_folio_unmap() is questionable: we already
hold a page reference, and concurrent modifications can no longer
happen (iow: __ClearPageMovable() no longer exists). Drop it for now,
we'll rework page_has_movable_ops() soon either way to no longer
rely on page->mapping.

Wherever we cast from folio to page now is a clear sign that this
code has to be decoupled.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h |  6 ------
 mm/migrate.c               | 43 ++++++++++++--------------------------
 mm/vmscan.c                |  6 ++++--
 3 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index c67163b73c5ec..4c27ebb689e3c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -744,12 +744,6 @@ static __always_inline bool PageAnon(const struct page *page)
 	return folio_test_anon(page_folio(page));
 }
 
-static __always_inline bool __folio_test_movable(const struct folio *folio)
-{
-	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
-			PAGE_MAPPING_MOVABLE;
-}
-
 static __always_inline bool page_has_movable_ops(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
diff --git a/mm/migrate.c b/mm/migrate.c
index 587af35b7390d..15d3c1031530c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -219,12 +219,7 @@ void putback_movable_pages(struct list_head *l)
 			continue;
 		}
 		list_del(&folio->lru);
-		/*
-		 * We isolated non-lru movable folio so here we can use
-		 * __folio_test_movable because LRU folio's mapping cannot
-		 * have PAGE_MAPPING_MOVABLE.
-		 */
-		if (unlikely(__folio_test_movable(folio))) {
+		if (unlikely(page_has_movable_ops(&folio->page))) {
 			putback_movable_ops_page(&folio->page);
 		} else {
 			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
@@ -237,26 +232,20 @@ void putback_movable_pages(struct list_head *l)
 /* Must be called with an elevated refcount on the non-hugetlb folio */
 bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	bool isolated, lru;
-
 	if (folio_test_hugetlb(folio))
 		return folio_isolate_hugetlb(folio, list);
 
-	lru = !__folio_test_movable(folio);
-	if (lru)
-		isolated = folio_isolate_lru(folio);
-	else
-		isolated = isolate_movable_ops_page(&folio->page,
-						    ISOLATE_UNEVICTABLE);
-
-	if (!isolated)
-		return false;
-
-	list_add(&folio->lru, list);
-	if (lru)
+	if (page_has_movable_ops(&folio->page)) {
+		if (!isolate_movable_ops_page(&folio->page,
+					      ISOLATE_UNEVICTABLE))
+			return false;
+	} else {
+		if (!folio_isolate_lru(folio))
+			return false;
 		node_stat_add_folio(folio, NR_ISOLATED_ANON +
 				    folio_is_file_lru(folio));
-
+	}
+	list_add(&folio->lru, list);
 	return true;
 }
 
@@ -1140,12 +1129,7 @@ static void migrate_folio_undo_dst(struct folio *dst, bool locked,
 static void migrate_folio_done(struct folio *src,
 			       enum migrate_reason reason)
 {
-	/*
-	 * Compaction can migrate also non-LRU pages which are
-	 * not accounted to NR_ISOLATED_*. They can be recognized
-	 * as __folio_test_movable
-	 */
-	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
+	if (likely(!page_has_movable_ops(&src->page)) && reason != MR_DEMOTION)
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
 				    folio_is_file_lru(src), -folio_nr_pages(src));
 
@@ -1164,7 +1148,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	int rc = -EAGAIN;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = data_race(!__folio_test_movable(src));
 	bool locked = false;
 	bool dst_locked = false;
 
@@ -1265,7 +1248,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		goto out;
 	dst_locked = true;
 
-	if (unlikely(!is_lru)) {
+	if (unlikely(page_has_movable_ops(&src->page))) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
 		return MIGRATEPAGE_UNMAP;
 	}
@@ -1330,7 +1313,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	prev = dst->lru.prev;
 	list_del(&dst->lru);
 
-	if (unlikely(__folio_test_movable(src))) {
+	if (unlikely(page_has_movable_ops(&src->page))) {
 		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
 		if (rc)
 			goto out;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 098bcc821fc74..103dfc729a823 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1658,9 +1658,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	unsigned int noreclaim_flag;
 
 	list_for_each_entry_safe(folio, next, folio_list, lru) {
+		/* TODO: these pages should not even appear in this list. */
+		if (page_has_movable_ops(&folio->page))
+			continue;
 		if (!folio_test_hugetlb(folio) && folio_is_file_lru(folio) &&
-		    !folio_test_dirty(folio) && !__folio_test_movable(folio) &&
-		    !folio_test_unevictable(folio)) {
+		    !folio_test_dirty(folio) && !folio_test_unevictable(folio)) {
 			folio_clear_active(folio);
 			list_move(&folio->lru, &clean_folios);
 		}
-- 
2.49.0

