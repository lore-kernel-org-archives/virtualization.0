Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97E2F94A1
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624782; cv=none; b=hzcEGyLCUSQPMSxOLSOq2KUAlCYcnu9i5TPieHq1daNRr7fjkUv4sXpqjXEiNddXN/vRl5HYjThP3YZ/7Q6QPec0meFwFNT1/kDwqxREX/bq0rr7LyTHGxTNtS2rN8/sGTg2QJ8qxEsfTT6vrbs+O7/3bhM85h2hkY2oY44F2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624782; c=relaxed/simple;
	bh=xp8NbfYpTMv4FsMLVs/wu/k+oe5U+/lKYXQQnLBQbmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gTD7EhHdXMDyjyzEQxDZ14Xj9LaYOkB+AxzstaZ2vJR8UI8jqPnR0HMS4hjMvAmUSVjoKsbyD+Xe6yGMGNS+O4k+7aRF7n18De6VJnbozev+l+uC+p99rqk714ynjDuzHtENyMS2rF5pTHjV0nj5mmtEYHsN/m2MlGt/oat363w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esK27rbE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esK27rbE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pR0cJEJLX/Xckea5AegahrKaeIbiLpLeDpONSEjx7tI=;
	b=esK27rbEF5n5USedE41bBZG7YI9IypXAI35wkkftvLzlbe5R4+m+HhavOW4tWGORqJtTbu
	gFd009bfRg986lcYxVIqYtSLsujA7/a1cjEloMBfewai14SoWVNHZYix+9xgY+Np7pnNgI
	sU3NjWBbrbH20q2aGtGrY/uCn6sNPOY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-ZTn3DUtcNkWmJKh8G_HjjA-1; Fri, 04 Jul 2025 06:26:13 -0400
X-MC-Unique: ZTn3DUtcNkWmJKh8G_HjjA-1
X-Mimecast-MFC-AGG-ID: ZTn3DUtcNkWmJKh8G_HjjA_1751624772
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso4075575e9.2
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624772; x=1752229572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pR0cJEJLX/Xckea5AegahrKaeIbiLpLeDpONSEjx7tI=;
        b=SWIv4ItkSM5Zt2ByU7rVOeS7PoylOtqQEw+zOCtQTCkfU4Y8eQ55E+GAZvw8pRafK+
         s8eK5BkK2NUTAItETUuMitkvlMI2PAIbOvxwb+AwOKrVQsBRPcc52gOvTAp5R/Towwa8
         gGwNewStRwaM2XptczuhyXXTshxNKez/r7wlUwncR8l4z0XJ8oapxhyyGvpix3k2Q/uI
         vIgePUFRM4vCOH9iZ+4t5wQsjJnn3zGHFXfMIdUMrgRFLpF8pwok+TWedi3a9AGXXEDy
         dikCv6c9dizR1LqA2a3LoT3A7G+i1VTenq0wh3wxY1DSbE9fhDn3tyQsMonP+XJKhToq
         ge3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3GuSr7LDPisJeegzILHPKOaFqPiWYp25LSA2Q100MWbBSY15aAd/HRW0Yez6TzzFSd569Gf5OGiSt7di8Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxV5Vst/pyegmdi1B5QYBGnMtyymr+ZqKbvQrwIL5xzgHcIhb6
	nGCkteLfRgezTJ/KxpGJfScwipLnvmDfx3XnOv6dO/gyU0nVo9ylHVdj9MdmKJh2nX/ekRdPiFt
	RdW+fLaBaIYfCfrQtpzFrzTj3m2T1kBJYUbr4Q4+BK+gIT5CsJbuP7uuMSFRHJdaz4oiJ
X-Gm-Gg: ASbGnctfahKWezu0a9U3dkppGVgYAOxWGQVV2mkXPLEnrREU96ZZP0mxxOVgYnl2Srr
	/5kV1OwWer8Aa4Dyrjw1peZz45AQbc+/khNCOgkERfEeHKJqToO3iRtye8xdPtg9AB24LeYCBPl
	csJwfNfMYEEPKo1ihSO8c615YkVkMXvsNt2uz5jzR2MZ93DA1KhHxD59vMW03l5/w6lk82Nc1SP
	yE/ikzyVaTqhhuYAKlNVpoHjMWyT+to7xO4E53RFbV32q1HZsZPPKnftwwBfG58OjBrZY+4fpcA
	y21QReH4HjS9H+52NU276jcYM4BCvoOK4evz4XtbtR423I1bX9ayhZScZMrTZsN8TQllwIiNUv9
	oE7Sq8g==
X-Received: by 2002:a05:600c:502b:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-454b3196658mr16377855e9.33.1751624772024;
        Fri, 04 Jul 2025 03:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp08CEDtezTqVTL+O56wTX6rAd2DO6G5SD1z9P14Ak5Y4B7FcklsRB1svcNIkfJhaHfAdZdQ==
X-Received: by 2002:a05:600c:502b:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-454b3196658mr16377165e9.33.1751624771466;
        Fri, 04 Jul 2025 03:26:11 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a1705ed5sm44913475e9.2.2025.07.04.03.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:10 -0700 (PDT)
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
Subject: [PATCH v2 15/29] mm/migration: remove PageMovable()
Date: Fri,  4 Jul 2025 12:25:09 +0200
Message-ID: <20250704102524.326966-16-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: exhqmAn5Hqg1r_hpMBE4Q7MHHeRixtgxjLqASy5A7UU_1751624772
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Previously, if __ClearPageMovable() were invoked on a page, this would
cause __PageMovable() to return false, but due to the continued
existence of page movable ops, PageMovable() would have returned true.

With __ClearPageMovable() gone, the two are exactly equivalent.

So we can replace PageMovable() checks by __PageMovable(). In fact,
__PageMovable() cannot change until a page is freed, so we can turn
some PageMovable() into sanity checks for __PageMovable().

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  2 --
 mm/compaction.c         | 15 ---------------
 mm/migrate.c            | 18 ++++++++++--------
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 6eeda8eb1e0d8..25659a685e2aa 100644
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
index 9a63bd338d30b..63a8c94c165e2 100644
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

