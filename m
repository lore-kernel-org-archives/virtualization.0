Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2612FCFF5
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268454; cv=none; b=Z/YvbqMZ84VDdJcofoukYsP/nqU2w6bIYdJ2DIHiMGHPlR1YJXH/eA1a2wXZjs2Z6/x18PrAtLf83MuvFu/PKUv0Mc8j6X4BwP736EFQxm9Qy4I4TY3BkBc1qJ3jSyBt/LXlLXmdxgTLxy5R3YoMJdjU/SfZ1wgFHf2rmyXf1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268454; c=relaxed/simple;
	bh=kK+1H5O+WM/ACnNcL3KxA88ivXOG9CXAUU38rvMnDO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZlV0qvIlByoAFH84pl9vWnyYXR7HzmkMeVTnLClDs2btSxqGGEsJy0ukpC+nWRAkBWs/zbpDhW3ATf2I6N1lnLwNtg8etPSZUEI6wI90i5YG6tZcWc28aBJp2ap67k85VpnlCsotfr/tSqK9E3jc2j3qZl4U1MuCpEVyvu84Kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCBWO//Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCBWO//Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdGmEg3KxJkHEQxrZBJZz4koG+H5rtVXjjGZN1RlWcM=;
	b=UCBWO//YBQvFTOCacgbXLmiDLZ8jFmX3FgRYHsgJ4RVQHTPyuu8+pT/Qpn2bfGW9+i8qFM
	R4Fy0FvzboRBdbGiAkTBrk+WjzsNp+rHVTMwH2Lf1GhNvDGibb9tdXYOO76JV7Vyn31H9i
	mIo/5LqTWN9/GzlKklC1kYV5Gm5mfcI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-SbuB1z8INzyb3yx7NWqQ4A-1; Wed, 18 Jun 2025 13:40:47 -0400
X-MC-Unique: SbuB1z8INzyb3yx7NWqQ4A-1
X-Mimecast-MFC-AGG-ID: SbuB1z8INzyb3yx7NWqQ4A_1750268447
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso43919045e9.0
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268446; x=1750873246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdGmEg3KxJkHEQxrZBJZz4koG+H5rtVXjjGZN1RlWcM=;
        b=kEmPgx3XRuzTKAnz1y7LPJ48eFUowSq+rViJuGtK72G6mHHK1ARu0KLz1eU1ssKIZM
         KJ9YMIOVIEEFqS7RZmj19aIKlkb5O7Ddlkn/sKMwRNSb11x8b+o/VgaGAp53Pytzd6oH
         zK6f+ZrczzxT934d/8yWI5zlSBvV0fpIay35YjqEqIHz+21lrR2/3gQZetUPfBsbPiJa
         IWYnC4iWTX9aR4TMwMUUiEjMAbrbK1z5LpTT19TXosHgDDaABLg8/4e6xx2bGzPqIysj
         yzFDWLH4DcsFFFzqi0tc68my0ysgqiJn+uBxc3YQtlluTT3LKQvNg9w1N7BIZN7NGWcJ
         Y6sA==
X-Forwarded-Encrypted: i=1; AJvYcCVD+7nKHB+yJYLXjpUy5faVk6p6EDOYzQFBwKf1i4/B2x0BI7mhKoDfF7JppdOWdgQ+L1yKtGL+KxOqxJMvWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj7VzXGXi5oiWfgFx1bfJcWkCHqU2YL/Rle14uxYPaTuo+DQ9o
	qswb005gCgUccS07rJAqq5f4sqrDzekoGO/0kRULlLNHEkFRKU7dkTVKJrjjialPCklPomlYPwL
	tC5svina07uhPGa44xzMo2iAkkAB87DbZc7R8kz7I96GmCajm9TAGK3gGnHQFCmT+Ze8R
X-Gm-Gg: ASbGncv8+PBac1HBKl5f55gT/Mgp1xiRMmRwoHJAaMf7H0DCmUdu0wi6sb3a7s9k34f
	PFlVYz8d9lCW3HEcejHmT1Cg/CRz+JBBZD91H+NsrseZS3eA9OgXYJThED/9duq+1uMqJGcqRQT
	1OirZ2xgrbjJNk+EsIWv6/deGSeblj56oemZZMIvHKNvJARPRdTl5rBX8ud1HTwsN4gXMJ/VqC4
	xdiWooNkb0sui2SHDwzTnnnVP3jhm3kwjjU5HaYNzEQlqrB/C4+L9lHJjM8VVCfSkGX1YTkkfoH
	/H52F3VIQjIZIOOuyqONnPNKI/hwPyW2CWq6adY0dcGmOmOfh2Yzz2m16NnB+38SpbUatHh6CNB
	JsM78aQ==
X-Received: by 2002:a05:600c:5253:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4534219a64fmr154402995e9.11.1750268446580;
        Wed, 18 Jun 2025 10:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXftk3ZXBXIBGlT1RpZSgQfC+IysEY/Lblmm+ealanQwQ/CfiKMmfIF1BFjPpj67LfRQmzUw==
X-Received: by 2002:a05:600c:5253:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4534219a64fmr154402755e9.11.1750268446175;
        Wed, 18 Jun 2025 10:40:46 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e97aa15sm3975415e9.2.2025.06.18.10.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:45 -0700 (PDT)
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
Subject: [PATCH RFC 11/29] mm/migrate: move movable_ops page handling out of move_to_new_folio()
Date: Wed, 18 Jun 2025 19:39:54 +0200
Message-ID: <20250618174014.1168640-12-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: F1qId1CTqzDd2XrfSEd3yi6IIqrqvF3pMfPAHalomHs_1750268447
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's move that handling directly into migrate_folio_move(), so we can
simplify move_to_new_folio(). While at it, fixup the documentation a
bit.

Note that unmap_and_move_huge_page() does not care, because it only
deals with actual folios. (we only support migration of
individual movable_ops pages)

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 61 ++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 456e41dad83a2..db807f9bbf975 100644
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
 
@@ -1328,20 +1322,21 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
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

