Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A13009B4
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268469; cv=none; b=WhvxAhM4U8caPjbOb4RAnfBlHbMIN79B5WWKF4JI/OyYb9Qye3MPD+H2WJNgxKt4tFTiq9myB6Z5pmmZYoPmFyCQIo0jhHO5GvUCgQ4naYh4wJWNsbn+T0yWx9FT+leny/c9ZHSOupDhep/YFH95LtqC599VUWOx8cFrE6MEbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268469; c=relaxed/simple;
	bh=medYXpX+TMULRTtTMKcGdqcFj+q0FGabFVW2TyLbuho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GAaocB/f9MfKufHQ2OevD+p50aGr3MGGTNKgdGQ+uWYlzwLNzTXOM6gIXkBZy5DZwP85p4e3LUjOzDYPHU0zBt/bFl8Xtk3QveOGt82SX2OgbwA2GcVbf4uXgL/YxABtQyFtbPaP9YGmCk2XQMnNQwM64UOWwB8qrdY4nnyZ+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNrCC7+a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNrCC7+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ASXfJp4RHbfj4rINsJONSvcqE1rahDwcrPqymsVLDE=;
	b=RNrCC7+asXA8BRYnoGrcMZ0/CGGcB2ODGSU9qaiPTxDHJ2jmKGlmRYuxbGjm2V/dwoC4In
	KGBdYf53BjJr1i7mHCgUkPiyUbmtgLs+cJEpC16r1NHT5ycmrbeuDn2YOL/r9slrdoIXMd
	kR8D7TCJEjZ3HWdw4EFkb/FnaVEHIGA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-lMgv2zbePcin2nD--uPv4A-1; Wed, 18 Jun 2025 13:41:00 -0400
X-MC-Unique: lMgv2zbePcin2nD--uPv4A-1
X-Mimecast-MFC-AGG-ID: lMgv2zbePcin2nD--uPv4A_1750268458
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso47060685e9.2
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268458; x=1750873258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ASXfJp4RHbfj4rINsJONSvcqE1rahDwcrPqymsVLDE=;
        b=Aw+NOdxAJUXjFAMVrhyCox/Z31y9fjI5HCz5H3Uz3TfGnrBWYnmfysTiJ0TzvfKaag
         v/RMvXnS/NGkt2gRu39G+0eMv4w8SpQufSkiONJJrniHrQU4qzzgCYlYX01mbUmhb2Iu
         Z8CAnDpo3kDAeqWbTqFHZGGRfqr4favVos2htnU5j+BSAqW2vRjt8Jb9yEdwRr9s2B/D
         D4uEG8qogKq0vuHtNZGTXNYVe9r899CBWTuzAle55qpj1lTZrXwidZIq7Jz2vb4yJ/Pa
         pOM5wcOV+3tj1cBdCp6IYyRSeZHYtr3FSVlWow4cZupoR4C1MwTk8GDYtVE6fRPb0ZPW
         y4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlMq6IUIvlHWOWMzNOVzwpKgI7IoUNLDFjr7pKtvyZDnCZfBhTVhOso3HEc/Cwm1UVtcwbg5CnaJMFsLJPYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSE/XUI0Jx7bhH/bjaPLn7KoxP2lJMpMfRXXnExYDATwzZuzsD
	IKEm8ZMyMZfIYuKgxnNMXxDTHKxdR0/X4z2eyEZNYfgr4oEh1P2ovCvjAKzRgJdwrRLuiVx5ElW
	bgGymwmYWsDJZ0S3+LHjNdAnqY14KohA9ysNXdWR0PrAKbPkw22ZM2c/7ahgUIB4L9KID
X-Gm-Gg: ASbGncvSbb8sY1GReSYWwtUH5bv20+WSJ005g79qLE0e1qb+2WyvjddJ+vIrZ4jp2mh
	36FvPEtdrXFBT1W3XR2zi86Q/mIl8QsWRezYFy9nDn8QMjPUNKX47sUyCYQiujd2Gg4LKmAQnHM
	NpEJNzcAsyZO8GyfQYNiLaXSvKH7ker67ZlRBuf1NOSyjWgbTxbq5nnA67Ucs9MJ0DMn3um3zId
	fqj9XaYBwsAO1wTd/nI+vABWacHmh1z0HYpGABepT+VLeoF79oywjb3nw3QNb38gvDfzgmoB8t2
	uE/DgS9Ar/DugB0//2e48RNzQ7m1aaiMoL1HiNn4+HpcnGJJM6Y3ClsbC0qcGzThseXKr8ta/JN
	7SOBGVQ==
X-Received: by 2002:a05:6000:402a:b0:3a5:2208:41e3 with SMTP id ffacd0b85a97d-3a572398dcfmr14347280f8f.4.1750268457662;
        Wed, 18 Jun 2025 10:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxU0kwdlscA0a/TfkuoDPVpV0SY0h1I0z821bVOupD96O2QJDPBeoneLN1ts9zfh0zY6p91g==
X-Received: by 2002:a05:6000:402a:b0:3a5:2208:41e3 with SMTP id ffacd0b85a97d-3a572398dcfmr14347224f8f.4.1750268457179;
        Wed, 18 Jun 2025 10:40:57 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b74313sm17643014f8f.96.2025.06.18.10.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:56 -0700 (PDT)
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
Subject: [PATCH RFC 15/29] mm/migration: remove PageMovable()
Date: Wed, 18 Jun 2025 19:39:58 +0200
Message-ID: <20250618174014.1168640-16-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: SJY4Y5X4ZTglKJmFKnmWDvmz37Nw-gOZancrE1bbLMY_1750268458
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

As __ClearPageMovable() is gone that would have only made
PageMovable()==false but still __PageMovable()==true, now
PageMovable() == __PageMovable().

So we can replace PageMovable() checks by __PageMovable(). In fact,
__PageMovable() cannot change until a page is freed, so we can turn
some PageMovable() into sanity checks for __PageMovable().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  2 --
 mm/compaction.c         | 15 ---------------
 mm/migrate.c            | 18 ++++++++++--------
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index fb6e9612e9f0b..204e89eac998f 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -104,10 +104,8 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
-bool PageMovable(struct page *page);
 void __SetPageMovable(struct page *page, const struct movable_operations *ops);
 #else
-static inline bool PageMovable(struct page *page) { return false; }
 static inline void __SetPageMovable(struct page *page,
 		const struct movable_operations *ops)
 {
diff --git a/mm/compaction.c b/mm/compaction.c
index 889ec696ba96a..5c37373017014 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -114,21 +114,6 @@ static unsigned long release_free_list(struct list_head *freepages)
 }
 
 #ifdef CONFIG_COMPACTION
-bool PageMovable(struct page *page)
-{
-	const struct movable_operations *mops;
-
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	if (!__PageMovable(page))
-		return false;
-
-	mops = page_movable_ops(page);
-	if (mops)
-		return true;
-
-	return false;
-}
-
 void __SetPageMovable(struct page *page, const struct movable_operations *mops)
 {
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
diff --git a/mm/migrate.c b/mm/migrate.c
index db807f9bbf975..cf92075108f0c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -87,9 +87,12 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 		goto out;
 
 	/*
-	 * Check movable flag before taking the page lock because
+	 * Check for movable_ops pages before taking the page lock because
 	 * we use non-atomic bitops on newly allocated page flags so
 	 * unconditionally grabbing the lock ruins page's owner side.
+	 *
+	 * Note that once a page has movable_ops, it will stay that way
+	 * until the page was freed.
 	 */
 	if (unlikely(!__PageMovable(page)))
 		goto out_putfolio;
@@ -108,7 +111,8 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 	if (unlikely(!folio_trylock(folio)))
 		goto out_putfolio;
 
-	if (!PageMovable(page) || PageIsolated(page))
+	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
+	if (PageIsolated(page))
 		goto out_no_isolated;
 
 	mops = page_movable_ops(page);
@@ -149,11 +153,10 @@ static void putback_movable_ops_page(struct page *page)
 	 */
 	struct folio *folio = page_folio(page);
 
+	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
 	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
 	folio_lock(folio);
-	/* If the page was released by it's owner, there is nothing to do. */
-	if (PageMovable(page))
-		page_movable_ops(page)->putback_page(page);
+	page_movable_ops(page)->putback_page(page);
 	ClearPageIsolated(page);
 	folio_unlock(folio);
 	folio_put(folio);
@@ -189,10 +192,9 @@ static int migrate_movable_ops_page(struct page *dst, struct page *src,
 {
 	int rc = MIGRATEPAGE_SUCCESS;
 
+	VM_WARN_ON_ONCE_PAGE(!__PageMovable(src), src);
 	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
-	/* If the page was released by it's owner, there is nothing to do. */
-	if (PageMovable(src))
-		rc = page_movable_ops(src)->migrate_page(dst, src, mode);
+	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		ClearPageIsolated(src);
 	return rc;
-- 
2.49.0

