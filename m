Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF328B7D7
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288501; cv=none; b=im1lb0T4DnKYCvjmyU3DfDl+ohz98tFhgQ0fqVsMdKoPlEY4d7y/fEyv1e9fFT8yqU7d/KYiMJWe3LnzkJ2KyyTKyhB2yAX92uqoiZP1oixs6FtR59BBkk7TWXJ5W0oArgMr4AezLSULf3Ojt9tP13NJNu3S1MjHu0+OHF8YW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288501; c=relaxed/simple;
	bh=sY41E8QlryNIz/N60cOOIdEBgQ2GOqTNOd7DJG88wKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JQty/x8g9iZgidGwIMxXtKjX/zZFCo2dG9EFrC9wEoVRyx8+lD9BODFLqjxCMvCgnO7mLktQCKHw9u3VjsW7xxBwOfNnuGmQu6bukynIQ5V95vLUS1bC9ttDMbl7MJwmvKPAPrDSs+rwcxZyta5q4I6a9z7UzAxqlMxBh0M3+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjCfcC6F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjCfcC6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BiKNy1Je5I/aSf6ESo6pQ+N6U0Nvk4b2III6Kq4QTYQ=;
	b=CjCfcC6Fj0brTbBweA9lyLfkFo0ULhYZ1I2GYbeA/+MDFNpPi+eWCxo4HaY4/dVwmEiJ1B
	TnJAE/qB2+9Dh6RpHpJfnaRzZCdY3FFeOW+CvlGndkpHxX9OXM/lVB/Xio4M73u23nc4SY
	cjGFAXeak0FR/LSP8YdR+28O69CMymY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ODGYC_nvPgCVlPgL0s3xyQ-1; Mon, 30 Jun 2025 09:01:37 -0400
X-MC-Unique: ODGYC_nvPgCVlPgL0s3xyQ-1
X-Mimecast-MFC-AGG-ID: ODGYC_nvPgCVlPgL0s3xyQ_1751288495
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d244bfabso18182805e9.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288495; x=1751893295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiKNy1Je5I/aSf6ESo6pQ+N6U0Nvk4b2III6Kq4QTYQ=;
        b=SYJVubvHsoZyds0p62boxul8hObl+Cdpr4pwY3o7fdJZ9+WmhBbSiKDvAul9MaXE0A
         vsLm5vkZEhTwW1g/9Q/AExk6MrHBKXZ5O7qS+x2eMYenSf7WgfjSPGfaLuUz2q6CFotP
         d1hblfwFQFzvjI5f168sUZW+uzGLNWzZ91X4BOSuKypqEM0yYeDoIwZUDdN+FtC+xqzq
         7tMYws0ooOqH2TdjMf7TyXm5vwATeLnD86kpHnVRaxpJfvVcmoLB8xHeJ9KfgkWHOQ4H
         4DHEbgRDR5H98/7v25an0decCaADROpwqeJHJNHc4KOktGGNsnUqXPbFXHacHWsJfRX2
         g/gA==
X-Forwarded-Encrypted: i=1; AJvYcCU5eg8hSQVx09NNKTKhvXBb8uZ1I3aBb9SJKMle4WzLbOAYXzQz3MdqsOxp5tenAX81h2wqaWil9uRJAM7jew==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEf+rxHwN97ZR2YPH6jszS5V68qedm8CpVKxT1JNGtdsb3EJm2
	eiGEKWkLP2fSaq+erc0KAFRnMbPAYgdPS6L5YB6+QT6f3vtbzg+It2ixmmgmYgOHIPi7lA7APW0
	66wV89k8nU4FIKqkAXjvsrdzmVtdHeIMdcP0JoTHV7Uq0tzPwgKxsGOnajx+l/sWh5cnO
X-Gm-Gg: ASbGncsn2j5w8Bm5+ECQY57L7fFdQ4Z8kV0xaiS6bVmpjn7kIWttY6SYNGihtwYdO73
	gf3B8rg1YAo85a6iTVw8ylt3f6NAWHuKNC3ZabC9LA5cnyQiHp7LbjffSseY/hCqMChHigXY8Nm
	cq5hCEBuIo02vcLu+LzDRttBUfsbqCiDBKSE68m5huzrxINhiRnfpsNn4MlTN+xq6RPJ8jH3gZ0
	bvMvVlqBFLQ8g9CQfw1p6PW/lfrkygDDZa+0Nmyfempxz0esF72U6EI64b+NG7SEHAwIadkziV4
	hw/12pNWNMqHlwJELpW4pxf8K6DWbssFxGMB0GB62Fgnw3FMOVdhrmR9bWliOw3kUrrlWGxj4dY
	Lfedj3kk=
X-Received: by 2002:a05:600c:4589:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-4538ee8c469mr119764645e9.26.1751288493903;
        Mon, 30 Jun 2025 06:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiJmwoKLZcCxWychQade1/84yFZ9EU0gll620+fxkzbn8N5oVEpXl6i+ceDpg9b8O44fsYZg==
X-Received: by 2002:a05:600c:4589:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-4538ee8c469mr119763175e9.26.1751288492802;
        Mon, 30 Jun 2025 06:01:32 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823b6fa2sm165793365e9.27.2025.06.30.06.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:32 -0700 (PDT)
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
Subject: [PATCH v1 26/29] mm: rename PAGE_MAPPING_* to FOLIO_MAPPING_*
Date: Mon, 30 Jun 2025 15:00:07 +0200
Message-ID: <20250630130011.330477-27-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XyMey-WlNoo6pLdvBAEIyJSqVBAHypdQzUJ_caxYA6Y_1751288495
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that the mapping flags are only used for folios, let's rename the
defines.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/page.c             |  4 ++--
 include/linux/fs.h         |  2 +-
 include/linux/mm_types.h   |  1 -
 include/linux/page-flags.h | 20 ++++++++++----------
 include/linux/pagemap.h    |  2 +-
 mm/gup.c                   |  4 ++--
 mm/internal.h              |  2 +-
 mm/ksm.c                   |  4 ++--
 mm/rmap.c                  | 16 ++++++++--------
 mm/util.c                  |  6 +++---
 10 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 999af26c72985..0cdc78c0d23fa 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -149,7 +149,7 @@ u64 stable_page_flags(const struct page *page)
 
 	k = folio->flags;
 	mapping = (unsigned long)folio->mapping;
-	is_anon = mapping & PAGE_MAPPING_ANON;
+	is_anon = mapping & FOLIO_MAPPING_ANON;
 
 	/*
 	 * pseudo flags for the well known (anonymous) memory mapped pages
@@ -158,7 +158,7 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_MMAP;
 	if (is_anon) {
 		u |= 1 << KPF_ANON;
-		if (mapping & PAGE_MAPPING_KSM)
+		if (mapping & FOLIO_MAPPING_KSM)
 			u |= 1 << KPF_KSM;
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c68c9a07cda33..9b0de18746815 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -526,7 +526,7 @@ struct address_space {
 	/*
 	 * On most architectures that alignment is already the case; but
 	 * must be enforced here for CRIS, to let the least significant bit
-	 * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
+	 * of struct folio's "mapping" pointer be used for FOLIO_MAPPING_ANON.
 	 */
 
 /* XArray tags, for tagging dirty and writeback pages in the pagecache. */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 804d269a4f5e8..1ec273b066915 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -105,7 +105,6 @@ struct page {
 					unsigned int order;
 				};
 			};
-			/* See page-flags.h for PAGE_MAPPING_FLAGS */
 			struct address_space *mapping;
 			union {
 				pgoff_t __folio_index;		/* Our offset within mapping. */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b42986a578b71..23b1e458dfeda 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -695,10 +695,10 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 /*
  * On an anonymous folio mapped into a user virtual memory area,
  * folio->mapping points to its anon_vma, not to a struct address_space;
- * with the PAGE_MAPPING_ANON bit set to distinguish it.  See rmap.h.
+ * with the FOLIO_MAPPING_ANON bit set to distinguish it.  See rmap.h.
  *
  * On an anonymous folio in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
- * the PAGE_MAPPING_ANON_KSM bit may be set along with the PAGE_MAPPING_ANON
+ * the FOLIO_MAPPING_ANON_KSM bit may be set along with the FOLIO_MAPPING_ANON
  * bit; and then folio->mapping points, not to an anon_vma, but to a private
  * structure which KSM associates with that merged folio.  See ksm.h.
  *
@@ -713,21 +713,21 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * false before calling the following functions (e.g., folio_test_anon).
  * See mm/slab.h.
  */
-#define PAGE_MAPPING_ANON	0x1
-#define PAGE_MAPPING_ANON_KSM	0x2
-#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
-#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
+#define FOLIO_MAPPING_ANON	0x1
+#define FOLIO_MAPPING_ANON_KSM	0x2
+#define FOLIO_MAPPING_KSM	(FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM)
+#define FOLIO_MAPPING_FLAGS	(FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM)
 
 static __always_inline bool folio_test_anon(const struct folio *folio)
 {
-	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
+	return ((unsigned long)folio->mapping & FOLIO_MAPPING_ANON) != 0;
 }
 
 static __always_inline bool PageAnonNotKsm(const struct page *page)
 {
 	unsigned long flags = (unsigned long)page_folio(page)->mapping;
 
-	return (flags & PAGE_MAPPING_FLAGS) == PAGE_MAPPING_ANON;
+	return (flags & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_ANON;
 }
 
 static __always_inline bool PageAnon(const struct page *page)
@@ -743,8 +743,8 @@ static __always_inline bool PageAnon(const struct page *page)
  */
 static __always_inline bool folio_test_ksm(const struct folio *folio)
 {
-	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
-				PAGE_MAPPING_KSM;
+	return ((unsigned long)folio->mapping & FOLIO_MAPPING_FLAGS) ==
+				FOLIO_MAPPING_KSM;
 }
 #else
 FOLIO_TEST_FLAG_FALSE(ksm)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f3..10a222e68b851 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -502,7 +502,7 @@ static inline pgoff_t mapping_align_index(struct address_space *mapping,
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
 	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
-	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
+	VM_WARN_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON,
 			"Anonymous mapping always supports large folio");
 
 	return mapping_max_folio_order(mapping) > 0;
diff --git a/mm/gup.c b/mm/gup.c
index 30d320719fa23..adffe663594dc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2804,9 +2804,9 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 		return false;
 
 	/* Anonymous folios pose no problem. */
-	mapping_flags = (unsigned long)mapping & PAGE_MAPPING_FLAGS;
+	mapping_flags = (unsigned long)mapping & FOLIO_MAPPING_FLAGS;
 	if (mapping_flags)
-		return mapping_flags & PAGE_MAPPING_ANON;
+		return mapping_flags & FOLIO_MAPPING_ANON;
 
 	/*
 	 * At this point, we know the mapping is non-null and points to an
diff --git a/mm/internal.h b/mm/internal.h
index e84217e27778d..c29ddec7ade3d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -149,7 +149,7 @@ static inline void *folio_raw_mapping(const struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
 
-	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
+	return (void *)(mapping & ~FOLIO_MAPPING_FLAGS);
 }
 
 /*
diff --git a/mm/ksm.c b/mm/ksm.c
index ef73b25fd65a6..2b0210d41c553 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -893,7 +893,7 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
 	unsigned long kpfn;
 
 	expected_mapping = (void *)((unsigned long)stable_node |
-					PAGE_MAPPING_KSM);
+					FOLIO_MAPPING_KSM);
 again:
 	kpfn = READ_ONCE(stable_node->kpfn); /* Address dependency. */
 	folio = pfn_folio(kpfn);
@@ -1070,7 +1070,7 @@ static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
 	VM_WARN_ON_FOLIO(folio_test_anon(folio) && PageAnonExclusive(&folio->page), folio);
-	folio->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+	folio->mapping = (void *)((unsigned long)stable_node | FOLIO_MAPPING_KSM);
 }
 
 #ifdef CONFIG_SYSFS
diff --git a/mm/rmap.c b/mm/rmap.c
index 34311f654d0c2..de14fb6963c24 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -503,12 +503,12 @@ struct anon_vma *folio_get_anon_vma(const struct folio *folio)
 
 	rcu_read_lock();
 	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
-	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
+	if ((anon_mapping & FOLIO_MAPPING_FLAGS) != FOLIO_MAPPING_ANON)
 		goto out;
 	if (!folio_mapped(folio))
 		goto out;
 
-	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
+	anon_vma = (struct anon_vma *) (anon_mapping - FOLIO_MAPPING_ANON);
 	if (!atomic_inc_not_zero(&anon_vma->refcount)) {
 		anon_vma = NULL;
 		goto out;
@@ -550,12 +550,12 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
 retry:
 	rcu_read_lock();
 	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
-	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
+	if ((anon_mapping & FOLIO_MAPPING_FLAGS) != FOLIO_MAPPING_ANON)
 		goto out;
 	if (!folio_mapped(folio))
 		goto out;
 
-	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
+	anon_vma = (struct anon_vma *) (anon_mapping - FOLIO_MAPPING_ANON);
 	root_anon_vma = READ_ONCE(anon_vma->root);
 	if (down_read_trylock(&root_anon_vma->rwsem)) {
 		/*
@@ -1334,9 +1334,9 @@ void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_VMA(!anon_vma, vma);
 
-	anon_vma += PAGE_MAPPING_ANON;
+	anon_vma += FOLIO_MAPPING_ANON;
 	/*
-	 * Ensure that anon_vma and the PAGE_MAPPING_ANON bit are written
+	 * Ensure that anon_vma and the FOLIO_MAPPING_ANON bit are written
 	 * simultaneously, so a concurrent reader (eg folio_referenced()'s
 	 * folio_test_anon()) will not see one without the other.
 	 */
@@ -1367,10 +1367,10 @@ static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
 	/*
 	 * page_idle does a lockless/optimistic rmap scan on folio->mapping.
 	 * Make sure the compiler doesn't split the stores of anon_vma and
-	 * the PAGE_MAPPING_ANON type identifier, otherwise the rmap code
+	 * the FOLIO_MAPPING_ANON type identifier, otherwise the rmap code
 	 * could mistake the mapping for a struct address_space and crash.
 	 */
-	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
+	anon_vma = (void *) anon_vma + FOLIO_MAPPING_ANON;
 	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
 	folio->index = linear_page_index(vma, address);
 }
diff --git a/mm/util.c b/mm/util.c
index 0b270c43d7d12..20bbfe4ce1b8b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -670,9 +670,9 @@ struct anon_vma *folio_anon_vma(const struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
 
-	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
+	if ((mapping & FOLIO_MAPPING_FLAGS) != FOLIO_MAPPING_ANON)
 		return NULL;
-	return (void *)(mapping - PAGE_MAPPING_ANON);
+	return (void *)(mapping - FOLIO_MAPPING_ANON);
 }
 
 /**
@@ -699,7 +699,7 @@ struct address_space *folio_mapping(struct folio *folio)
 		return swap_address_space(folio->swap);
 
 	mapping = folio->mapping;
-	if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
+	if ((unsigned long)mapping & FOLIO_MAPPING_FLAGS)
 		return NULL;
 
 	return mapping;
-- 
2.49.0

