Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E93337BB4
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051597; cv=none; b=u3q+8048j5gI9GaY38j6lfqzWlUCKMhtrhDE2w++7VFBAMci95rDl3w+hfCQ3nui6UZvCRSeBPz2T2yob7yW0GReAIipGAGlvN1uIE1XYqzmlL4ZzKb8+Ka5wYLx1pJKgQgphxtC1oC9owKlR/kXizdihqZdt44SypllDlAA5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051597; c=relaxed/simple;
	bh=LaFRDe669/qyxoAgaKp/3mWBmsPHM6MaYHxIvdsNMVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KEz544vxa6w1VtFQ5KjeSLHezDAWm5VAYlJjbVFOyABWvwOC3NqZmd7k3L50iB2/oqe6ZhYtE2x/AnRBhO0z9AnUX0eCX/XliiZ28Q0vs21jiOYvy77FRLAqL/C23Z9Nn3jxU9Qhpg4aAW5Sj2G3nV9L1hX+ELLzeG5VpFhvP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpePrNdv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpePrNdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bd8gqizIzdxCBecoKAkM92GzGk5zRQnzgqcXQENTV8k=;
	b=CpePrNdvF6Ar7k/JFy3Kh0CQtXhwjGzCqQcy6ASjvMTcIIclXW5gBfMSbG6KGcCxOg82n6
	gWOhHtoRzhb6irI5HR6YOEZGcClzdeOjci3HlFbTFe38JPnX4rH15kGQ6D56S4zyiZ1dmE
	pNTPIWJ6vDw6VKEZIC3VpcqMR9A1gao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-l_PbvYf4OfqHnZB5oENZbQ-1; Tue, 21 Oct 2025 08:59:51 -0400
X-MC-Unique: l_PbvYf4OfqHnZB5oENZbQ-1
X-Mimecast-MFC-AGG-ID: l_PbvYf4OfqHnZB5oENZbQ_1761051591
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47108163eeaso26924925e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051591; x=1761656391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bd8gqizIzdxCBecoKAkM92GzGk5zRQnzgqcXQENTV8k=;
        b=k0GoARt48d3yYo4qdvGCVDA+wzMxbcjdEHNh3oisXLpRQqo1YBfxhYxgzJ6q8hXi5F
         Ym8p78KWpwGd6kK/XONUtVK/01Ftc7Q7YbW2hWl+6LcVXv3dGHJzqPXtGvdBxx55rq03
         lynEWAyEgWiBSYQSJn2ClqkasHOyBP+qqopeB9DIfuSlIDrG72xjqNquMvTVc7Pop7HD
         jizj1KpgTMB3PeLhZOjBRqcOVrexnSuBRwm6fBaZMGG7G6grYb6WeAn0509d442aO3yG
         P5KxBasu2yaZ3EiQx5FX+fikJGVlqYLobtAcZoU7bFA8notcxyn9Tb9rZNdQAolqMNuW
         j5sw==
X-Forwarded-Encrypted: i=1; AJvYcCWikPrDQTpVyA62oON6ZBPp1ElCk1Kjj5+hupXum/rjcYrnSKt6a1zhymoW1u+dT9cmpa6gJbfrSKcFPnj+rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw88BgkcFqfwrFVX8ADsPRQ/9hHpi60zwgAmpiZ9pgLptxNSIEY
	blXetz8u/Kgp51FjjOoGqpSSJICugx/Y6SQD4Wf77/P9PJDhWsuOa/On5UfuTbmbVXXNnnK0Jn9
	BRjPWrnSawFmvEs+YZSvpsKivxCFGXCjTms4AAMwtuW5bgBBYBcXy5N1RzfBPb/mO50SS
X-Gm-Gg: ASbGncs6kmRjht1zBNm/fwuT1f7wgVmL/OCtzqIMIlNZtY/us+X21dOhjd3EVEfBb2F
	yM4lIpcARhsYr7pQCjGrV5yoEP0bYsWP8lCd1bcJLHqb3gEyOJUdTzrhl8fDyc/6EwGoLQxy6kj
	+h6s/mZRzaeZlA6WSYpeqx+MBpabw/b1AveprqKegfiK8chhGlfLDnaDWOWJ7FkdWNhVke8kfUF
	07c1MgxvKHCFehVK2TxFUoCYtK22Hf4KoHAGDDTihhxqStt1F6VFwlmSKtT8KtIwCzugFtdXMqL
	QMSExQNeF213CZ1jU080PiZAhxbRAqa/bNxzAnDN1QE68czeNwMZAwCmP0xtXpGAm921sNd8FT6
	OlO0YorE2ftikUzRPtlUJ3c+b05yMVY4cEJSubTSuZryEiDx0f+trNckC4ORR
X-Received: by 2002:a05:600c:3e17:b0:46f:c576:189a with SMTP id 5b1f17b1804b1-4711791c3c3mr130359975e9.29.1761051590572;
        Tue, 21 Oct 2025 05:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdxh7ZKT7824WXcxtADh1plje6WLOr4tApQ2cZuBwyOs4GdyEk8i7jKfPxnpNj/2+0EbpvXg==
X-Received: by 2002:a05:600c:3e17:b0:46f:c576:189a with SMTP id 5b1f17b1804b1-4711791c3c3mr130359575e9.29.1761051590107;
        Tue, 21 Oct 2025 05:59:50 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47494aa0336sm18536345e9.1.2025.10.21.05.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:49 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 08/23] mm/balloon_compaction: remove dependency on page lock
Date: Tue, 21 Oct 2025 14:59:13 +0200
Message-ID: <20251021125929.377194-9-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zrRJ2ptAiY8uoLg8qqwO_VTZA_cn7E0tMRVXx-XLu1Q_1761051591
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's stop using the page lock in balloon code and instead use only the
balloon_device_lock.

As soon as we set the PG_movable_ops flag, we might now get isolation
callbacks for that page as we are no longer holding the page lock. In
there, we'll simply synchronize using the balloon_device_lock.

So in balloon_page_isolate() lookup the balloon_dev_info through
page->private under balloon_device_lock.

It's crucial that we update page->private under the balloon_device_lock,
so the isolation callback can properly deal with concurrent deflation.

Consequently, make sure that balloon_page_finalize() is called under
balloon_device_lock as we remove a page from the list and clear
page->private. balloon_page_insert() is already called with the
balloon_device_lock held.

Note that the core will still lock the pages, for example in
isolate_movable_ops_page(). The lock is there still relevant for
handling the PageMovableOpsIsolated flag, but that can be later changed
to use an atomic test-and-set instead, or moved into the movable_ops
backends.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 27 +++++++++++----------
 mm/balloon_compaction.c            | 38 ++++++++++--------------------
 2 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index e2d9eb40e1fbb..ad594af6ed100 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -12,24 +12,26 @@
  * is derived from the page type (PageOffline()) combined with the
  * PG_movable_ops flag (PageMovableOps()).
  *
+ * Once the page type and the PG_movable_ops are set, migration code
+ * can initiate page isolation by invoking the
+ * movable_operations()->isolate_page() callback
+ *
+ * As long as page->private is set, the page is either on the balloon list
+ * or isolated for migration. If page->private is not set, the page is
+ * either still getting inflated, or was deflated to be freed by the balloon
+ * driver soon. Isolation is impossible in both cases.
+ *
  * As the page isolation scanning step a compaction thread does is a lockless
  * procedure (from a page standpoint), it might bring some racy situations while
  * performing balloon page compaction. In order to sort out these racy scenarios
  * and safely perform balloon's page compaction and migration we must, always,
  * ensure following these simple rules:
  *
- *   i. Setting the PG_movable_ops flag and page->private with the following
- *	lock order
- *	    +-page_lock(page);
- *	      +--spin_lock_irq(&balloon_pages_lock);
+ *   i. Inflation/deflation must set/clear page->private under the
+ *      balloon_pages_lock
  *
  *  ii. isolation or dequeueing procedure must remove the page from balloon
- *      device page list under &balloon_pages_lock
- *
- * The functions provided by this interface are placed to help on coping with
- * the aforementioned balloon page corner case, as well as to ensure the simple
- * set of exposed rules are satisfied while we are dealing with balloon pages
- * compaction / migration.
+ *      device page list under balloon_pages_lock
  *
  * Copyright (C) 2012, Red Hat, Inc.  Rafael Aquini <aquini@redhat.com>
  */
@@ -93,8 +95,7 @@ static inline struct balloon_dev_info *balloon_page_device(struct page *page)
  * @balloon : pointer to balloon device
  * @page    : page to be assigned as a 'balloon page'
  *
- * Caller must ensure the page is locked and the spin_lock protecting balloon
- * pages list is held before inserting a page into the balloon device.
+ * Caller must ensure the balloon_pages_lock is held.
  */
 static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
@@ -119,7 +120,7 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
  *			   balloon list for release to the page allocator
  * @page: page to be released to the page allocator
  *
- * Caller must ensure that the page is locked.
+ * Caller must ensure the balloon_pages_lock is held.
  */
 static inline void balloon_page_finalize(struct page *page)
 {
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 97e838795354d..28ef0cb6b3bbc 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -20,15 +20,7 @@ static DEFINE_SPINLOCK(balloon_pages_lock);
 static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 				     struct page *page)
 {
-	/*
-	 * Block others from accessing the 'page' when we get around to
-	 * establishing additional references. We should be the only one
-	 * holding a reference to the 'page' at this point. If we are not, then
-	 * memory corruption is possible and we should stop execution.
-	 */
-	BUG_ON(!trylock_page(page));
 	balloon_page_insert(b_dev_info, page);
-	unlock_page(page);
 	if (b_dev_info->adjust_managed_page_count)
 		adjust_managed_page_count(page, -1);
 	__count_vm_event(BALLOON_INFLATE);
@@ -93,22 +85,12 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
 		if (n_pages == n_req_pages)
 			break;
-
-		/*
-		 * Block others from accessing the 'page' while we get around to
-		 * establishing additional references and preparing the 'page'
-		 * to be released by the balloon driver.
-		 */
-		if (!trylock_page(page))
-			continue;
-
 		list_del(&page->lru);
 		if (b_dev_info->adjust_managed_page_count)
 			adjust_managed_page_count(page, 1);
 		balloon_page_finalize(page);
 		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
-		unlock_page(page);
 		dec_node_page_state(page, NR_BALLOON_PAGES);
 		n_pages++;
 	}
@@ -213,13 +195,19 @@ EXPORT_SYMBOL_GPL(balloon_page_dequeue);
 static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 
 {
-	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
+	struct balloon_dev_info *b_dev_info;
 	unsigned long flags;
 
-	if (!b_dev_info)
-		return false;
-
 	spin_lock_irqsave(&balloon_pages_lock, flags);
+	b_dev_info = balloon_page_device(page);
+	if (!b_dev_info) {
+		/*
+		 * The page already got deflated and removed from the
+		 * balloon list.
+		 */
+		spin_unlock_irqrestore(&balloon_pages_lock, flags);
+		return false;
+	}
 	list_del(&page->lru);
 	b_dev_info->isolated_pages++;
 	spin_unlock_irqrestore(&balloon_pages_lock, flags);
@@ -249,9 +237,6 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	unsigned long flags;
 	int rc;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
-
 	/* Isolated balloon pages cannot get deflated. */
 	if (WARN_ON_ONCE(!b_dev_info))
 		return -EAGAIN;
@@ -291,10 +276,11 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	}
 
 	b_dev_info->isolated_pages--;
-	spin_unlock_irqrestore(&balloon_pages_lock, flags);
 
 	/* Free the now-deflated page we isolated in balloon_page_isolate(). */
 	balloon_page_finalize(page);
+	spin_unlock_irqrestore(&balloon_pages_lock, flags);
+
 	put_page(page);
 
 	return 0;
-- 
2.51.0

