Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265228A73D
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288455; cv=none; b=UjrAhkXY5hWyVjPTuY7IU61Cm8+j4gUgBxyTqG+yVjeWc63aOOg5CxMX/pmUpIWOZ4SWBMuwZP0rVKW1+9M6xcnU3S9eLtBapANE+BLH/nqCytdJxOEUYerW9n0E3QZHY48Et+4hByBlYx33W12xprQDa6SX+8Ba5b+gs8i2gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288455; c=relaxed/simple;
	bh=bzT3f8SbOSFmP0mAT3t54D4YW+inx1tEVm83+OWEEC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZuJtGW8PCLmrp/S6flzSd0lxz0iTjG/Bbmt/i/UdhqBPV9UvBxVWUaafxFx2TRRDZqjYnpArLW+0IC5fnIoYC9KkayQejen5osKdE2/IFyz69wE+J075W9yrNslQ0o4k1E7kFxQNbWbBhtbPkYSWwIxddg5FZdk2u7t33lDI3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0fAKJlz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0fAKJlz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLSy27pHIWSaumHdHZbZB7d4Xse7WARvWeqJ4bM0kJg=;
	b=S0fAKJlz3k0GOIKTm1+NwYII2cp1kPgQnYezQazh1TZ1e5OJ6Qe0v4hUI7CD+f/i9w/8Wx
	NXBspU0GJ6QLvTBfFzRYVL2NtSQ2/o3ou/Ln3pURrHG5FLSiXvO5OhXIQHFDlnfw6L3LFL
	xPVNTHgDwHYhnGLBEiHhxNwvMs7fwPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-jjIyRpAXOFqP3zwW4ci0qA-1; Mon, 30 Jun 2025 09:00:48 -0400
X-MC-Unique: jjIyRpAXOFqP3zwW4ci0qA-1
X-Mimecast-MFC-AGG-ID: jjIyRpAXOFqP3zwW4ci0qA_1751288447
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso1303646f8f.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288447; x=1751893247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLSy27pHIWSaumHdHZbZB7d4Xse7WARvWeqJ4bM0kJg=;
        b=rZWgV2lp3FkEEZEQmj7aIl+DwzjeYDP6pwyaTSd4W+vQ55UpJWMbH39Kv/4QpCm6gf
         crvT8GM3J7uI4FTHIi3uZd5vXhwoh1p9aHNacyn9ZGsTzzoOf1WRUP3FbcNsB1AhbEXm
         B6XFZaB0XgUk5MuPncAyQLNGRyztepPb1+mIeRsFZEB8NTSmDEOS+zfJMO2pO0CYuQKC
         o389m/KUp3uhsrs5vX5ikwuHMT6gYJAir8ou+UnEzlKk5HAgIRIXQzOe2sIfNhBGD6vp
         mtqcUGuRGDgkAkjCGTn3VgKehhVAhWcHJHhuoni6/lkK+6H+C156NHicOgN2y4QQ5BnR
         KL+A==
X-Forwarded-Encrypted: i=1; AJvYcCWYjgOC8FZU8gcdlQSnrI4gYA2PKXAInQwlNrRPIohmTXlfvNpeSfmMq5cF62WZPR/JM21ODTmwQksBNqRQqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTkq43fR8lH9fsegtJODJm1gxNufchLRuffQq6eNXSMQQ9mlRJ
	7+3H13vK2nkASW59s8H0SzTdoSca1JT5CV3nDz2F78yJp458a+VJVehBCgXG00SnvG89aksh4Zs
	f+LMgloI1y9lE20GJ8MVWGOmlLb9C8yff/FHrPxvwUciYya0kgtNLRZdWLfP7HOU5wfBJ
X-Gm-Gg: ASbGncu+b3YNjCouwYcnsbG8VSL68acpeLS3TOKl4XQ1Jdp9rus3oP80iaqXHCwh31Z
	vzCgPR3Tuv2tdEb5xZlGk/9SBrsltfYOPitL8uJEIYCLond1ZIiCP0bW1snDrN+jkH92lsXIsJ1
	exYsUQDK3ZtpGrbdQ9BvZx0nimcHfdP2N8ZoxWO6jdj8sxfUoKZE7dp5oxJdSL2KWABm/RZlCrE
	S1+QJfOZu50kPchkorUy36vvnuMZSfTVis34N42TUGNW8k9HoRO32r3aiMFdl/ESZc0Cn/dWEr/
	DaGizZUmcR4npVB2k3S/C15FCqVMF/XRdtDuH6r9gPoi9ffIKyoaSaSMsxxAIlUTrCqGS7Effn7
	ngW3aJb8=
X-Received: by 2002:a05:6000:440b:b0:3a5:287b:da02 with SMTP id ffacd0b85a97d-3a8fe4bd16fmr7883144f8f.40.1751288445791;
        Mon, 30 Jun 2025 06:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZT4aB5+IKBjQnh+yncb7ZFTxj1NuN2dDZeVwVJqvRnlRrWkNRGfP/el4NU32fGgywSRoLtA==
X-Received: by 2002:a05:6000:440b:b0:3a5:287b:da02 with SMTP id ffacd0b85a97d-3a8fe4bd16fmr7883079f8f.40.1751288445063;
        Mon, 30 Jun 2025 06:00:45 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a88c7e72c1sm10293032f8f.1.2025.06.30.06.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:44 -0700 (PDT)
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
Subject: [PATCH v1 11/29] mm/migrate: move movable_ops page handling out of move_to_new_folio()
Date: Mon, 30 Jun 2025 14:59:52 +0200
Message-ID: <20250630130011.330477-12-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: bgdnFl5G6FIOvtAybfiXWZ813_ps51K01fQr4lX8esg_1751288447
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
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 63 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0898ddd2f661f..22c115710d0e2 100644
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

