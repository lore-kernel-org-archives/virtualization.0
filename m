Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482122F3C3A
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624808; cv=none; b=eSh42QESHziL4AMMGT8OXJsxpS/RagYeRXQPh48qZ+9SyGZSpXrOn9pCnoPzWYR5XrH+9lLgAHa+cd5pabUpZvOvsBc84Mc10Q4JV+8yaYJD+hMjE+uuppmADjUGTKY4W+yBWZmV6OKyGItAJ2CA2bcQVBTblCKvwC8XcngVOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624808; c=relaxed/simple;
	bh=vLPZe/AETOSx+MqNKvXX8AgfD+g/9x5PZ18a44XXkJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K5a9FgPG9eh4dGJW//0MPXpKPu963956KfyAU+iiu7aB8s5FlKltkQhQvw5dQcePdapajh0tO5u5V6s3dMsZPsl6Lqwnv0sfq6hww5vJkDsDygztCDCIgiPxF/d7Y4HMvvmV4Kwx5H6DR+5nP45vwnAt3XegCjb2dPUvxcPhKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMpOR49z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMpOR49z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbsxMz4pnUtjte7Dwwcfz26G/fUwTmSxga2gzR0g2S8=;
	b=BMpOR49zL6ntY3UfNHZprvl97HkwllTqZIY65i6BzwVQhDpPbtZS6X1PL2qnizm+iPe3jW
	rwTSTD7Atg2XAmKhTPTql1+9WjwFSqJcxj/3Rd/os3HKtIDj4ornVZcqHRV3J6xPTja1V6
	KqbuVnTZScvxKOuERYSgTxtLIBGTPPU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-znagBLNKM7CnRDD_4c6Z2Q-1; Fri, 04 Jul 2025 06:26:44 -0400
X-MC-Unique: znagBLNKM7CnRDD_4c6Z2Q-1
X-Mimecast-MFC-AGG-ID: znagBLNKM7CnRDD_4c6Z2Q_1751624803
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-454acc74f22so5107185e9.2
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624803; x=1752229603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbsxMz4pnUtjte7Dwwcfz26G/fUwTmSxga2gzR0g2S8=;
        b=s7DTBAAZTQcqH0Zx53gR/pmYez3XE0b2qHr4AKuzxYglJD6lSvKeUOXbkJuZXqgfrm
         AGLVEusCb9gufH96ofDB02p4oEPiFjG2NM6labsPQgqLPb3ja/Ds3GCTsROzCs756Yft
         ZHJsjM5SgUN/YHpugIJet9j+gKJOTtiJSy7xv5aRHzHTuCKj9xap3V8t0yZAtEktZduN
         /fF5QYrHsPgHVeJeLuiWuZZrRDC+YV4JWh0b36nwOkF8xij0n0HpxuUNJWI/IlSGURtY
         C8MLUC4sZhMfpqQqw2gu5/VvNXULHCDZ8fbSA4ll1pUG6R+mjMJiTniD7goMSCEn4vYA
         /qRA==
X-Forwarded-Encrypted: i=1; AJvYcCWr9mgebzgQH5UDbrGiStOmRchL/Lu6r74DX9u3Mzx/lwE7dpMPNLn1ZF/Iuggvan3j40Skz8mIB4SOs/Rlvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2F7dP13botF185FEQjnpAgzjiTv0chWx0cILtDPLFQQ+lZheY
	MbwDz+bfbcXxpswZ82KagaqOH69sv05IpQhEm4r4mBpiUV8q9uhH38DY2kLLTT+sJ2juWnH0xFF
	xZHvcekfybuBwL1SzkoZIz9fmbnkBUCXfC26U1mkImz3AQ08qMm7a1b1xD9l6bHsCfU6v
X-Gm-Gg: ASbGnctIYi0bpUUnbC9wj8O/khFR5AjcrDVlnxjR9MsvPzSt/LohTkao4NvSj8mnlep
	wYaEF62ZVfixrIf+PSJYmp6/4Dj3BmQp0T/Dvs3ZW+VHEjZOMbRFaiQpQYmBq2gjk61SQpZoZig
	OHHqputckCZ78Xo2w54HvJnMVaS4FRowzWLI09WtUQ1RDZcBfS/XdQFD8ZHeH8fijTZKq56Fo4U
	JDoePtBv9Q9MMGuEb5079oqegqgSlPhLNfIA4hSjp0zvl6bhZ0QGxVn1DlyZPq3tq6Rv2unHaDE
	M2Koonc4D89xJOS9xiX88I0NXDO0TzYGvio+3oRL4gkdRe2MhhnAW+pBix1lO1q73/l+9cyKCD5
	nMF/dnw==
X-Received: by 2002:a05:6000:18a3:b0:3a3:7753:20ff with SMTP id ffacd0b85a97d-3b4965fa2e1mr1774276f8f.35.1751624802525;
        Fri, 04 Jul 2025 03:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsSNFCdzwlfszOvmyvFL++7oCCWdECVfxUvS2Goz3Q6PQO8mU3XMxflzhs2qhG7E3kmUYu5Q==
X-Received: by 2002:a05:6000:18a3:b0:3a3:7753:20ff with SMTP id ffacd0b85a97d-3b4965fa2e1mr1774243f8f.35.1751624801975;
        Fri, 04 Jul 2025 03:26:41 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454b1628fcdsm22862115e9.16.2025.07.04.03.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:41 -0700 (PDT)
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
Subject: [PATCH v2 26/29] mm: rename PAGE_MAPPING_* to FOLIO_MAPPING_*
Date: Fri,  4 Jul 2025 12:25:20 +0200
Message-ID: <20250704102524.326966-27-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Hl8Qm5dcrJdVaaoYqqEV3D83jkymQ8CERkdC81fhMUc_1751624803
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that the mapping flags are only used for folios, let's rename the
defines.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
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
index e575ecf880e59..970600d79daca 100644
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
index b7131bd3d1ad1..5b0f71e5434b2 100644
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
index a15939453c41a..f93ce27132abc 100644
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
index ce826ca82a11d..68ea833ba25f1 100644
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

