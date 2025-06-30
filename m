Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D828DF07
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288469; cv=none; b=f9C5jW1Z9IF91VvExCP00abYkQR7UhQfD7dhqDmXadVWnOe3hVggWIUV1C8D1Ep20j0fBI1hvlpXvflABgdoEVAJgU+rVeCCllCzKRSETJA7rV+DxBjip/aM+8qNXXydlTXq4UGS67INq2d96FDkTdEqYPQ2gfsmFlz/6L9Iqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288469; c=relaxed/simple;
	bh=E2Kk/3B1Zvc/DrpiBo6mfnVkxxScIN5ozXUblSaxVOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=W0rfUk/tJmgHTIE8WbQC1w20aGp96uei2M8CXemY5o/y7qFvX4yksJpf/Bal6WobC+hR5UVtxLF/SU7MxNWk6azGikvsie23VncynHPUxxE5IP77x7tXPe9fDuwVjeDSaWX2murov0Xl9H1/L+gXIQ1Bnad4z3agRR0mKNWednE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=La2NiZ4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="La2NiZ4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02uSef5lp6Y5cEfWyIGZlJA9ZbaH5mB3gdVPjlakXLo=;
	b=La2NiZ4lozxsjMmUzZFw1NbplMJhKrOfF4eljVYiyHtxuY12qxJEE1BTmi+QlvSgs2MREE
	ZQslUp0PW8uujzHTSK64SQnyyecLffg8GoJAehTMXbc7ulRYFGrtR1xAtWDilISqK9i3Vg
	NPEmftxynD07XrNhZcwvDPoqRRJqS2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-iFsYWEYHM9mq_SFWjbWrXg-1; Mon, 30 Jun 2025 09:01:00 -0400
X-MC-Unique: iFsYWEYHM9mq_SFWjbWrXg-1
X-Mimecast-MFC-AGG-ID: iFsYWEYHM9mq_SFWjbWrXg_1751288460
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450eaae2934so15173605e9.2
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288459; x=1751893259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02uSef5lp6Y5cEfWyIGZlJA9ZbaH5mB3gdVPjlakXLo=;
        b=MqSBHrfUxsjDTKEIq2rFZdBclqYktn2YxkbXf+dbduCci5XIpTDbriFyOV/LH3UJyA
         6kI5wxek5kjLmAtg9TWQDzarTPr4GbiBTZhOLPeq5ckZnadBnU4o5wO5wvpFi4ne+v2A
         Vd3bhIrc4LGZpD0x8J6pUyAacUe/ct2LEQ6u3A4bwzTQ/ntXfk4I2HvyBbFPMAJwifQw
         7RkklSEs5hOeiZ2J0KBydDicSNieHeI8xwRZICyN4xTEkEN4PLBnxwvKG1lUkEqF8yeb
         E+eAkqTyFmYkDYZeXnGNgdm1sKXcIgebvLhY191lc/iQuhXOiF3fcPUqGbhuWIPjSYnz
         iQXw==
X-Forwarded-Encrypted: i=1; AJvYcCWHpth2obN/1M8XfqeT50wY7+/04wHL3wZX7LWKbarHbwHeMccpjdxokwUbi8janYiJmwkdlXOzGxYdF7Povw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT0915Mcbs6R0BS6uR7xwNWK80Aehk/8xkLcy6XP8v3OW0HSCo
	6Wc6VVZ1+JFjln1mFJ8tHqLlgSOO9oZshHSR8Tj6z/305hes7qPeyWAf7KX0VLUb/CVpiill59r
	UNHRF+luNAMncbVwknVLr9n+xTEa6wOBmRyzJ1PsWtpZ5kOK4UDuQTrziUJGqW7j+CNqC
X-Gm-Gg: ASbGnctxSIzqHJn1p9HgISxpNwehqSMTOQfXH/Epr8CafcHVtlAjnuWVUGKufhtI0xP
	n7ifuxH9/fo0HaSUk5ivMnvX93u9WQVezCwpr94gbsKnkVfqNPS7VhLlktqprChz3y1thrfn3HU
	IdZEuAGHYVS1SH/csoSUEBGaz6yKoac5TfLTp9b9I4PvMfLURysBHAkYHqGjmF8dnVeKUNmohfN
	kJFeDKpM9sCSy/rt+XrPbWiMRco5cUw+mP+pUPMZYVwumyZYiNFot71MTcLeapGLmPTpfrWYEix
	nwdSLSrn4Hg2b4zLemUIqA1j68gyhRY2KYeLM15gr+vincOPrTfDComAyQ9kaVr6VK5VYzgfK8g
	hccoowQ4=
X-Received: by 2002:a05:600c:a46:b0:44d:a244:4983 with SMTP id 5b1f17b1804b1-4539726acc1mr92868675e9.3.1751288458005;
        Mon, 30 Jun 2025 06:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCs0m13Yqq4GukWpM+4uHJmOOd6amI/nvHYcsB4z72aw1swyUlytQ8Ivx43yHYvtcBEII8eg==
X-Received: by 2002:a05:600c:a46:b0:44d:a244:4983 with SMTP id 5b1f17b1804b1-4539726acc1mr92865605e9.3.1751288455974;
        Mon, 30 Jun 2025 06:00:55 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e5f8absm10554612f8f.95.2025.06.30.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:55 -0700 (PDT)
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
Subject: [PATCH v1 15/29] mm/migration: remove PageMovable()
Date: Mon, 30 Jun 2025 14:59:56 +0200
Message-ID: <20250630130011.330477-16-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: mvRe0rG8cMBcsQ_f0pHeXrupXHBfZLyZB3M4Sa12J1o_1751288460
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

As __ClearPageMovable() is gone that would have only made
PageMovable()==false but still __PageMovable()==true, now
PageMovable() == __PageMovable().

So we can replace PageMovable() checks by __PageMovable(). In fact,
__PageMovable() cannot change until a page is freed, so we can turn
some PageMovable() into sanity checks for __PageMovable().

Reviewed-by: Zi Yan <ziy@nvidia.com>
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
index 22c115710d0e2..040484230aebc 100644
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

