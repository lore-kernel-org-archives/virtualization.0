Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5013B19AC
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907706; cv=none; b=PF4T7IK1o3HsjFKyA2MXoTAx88vjpdgBo3HIo8w8mdLIqZO5xLTUCLUE8On+HpYlrFQ6aWhyqqrt7dmJ4f0ve0wQYq6/Dvttwjzp8ZC8uHzGaOqzFp5h++zbOllKcpU96gb+MV3dG7W2wv8/3ZPQ4wiUem60actGAVILJDxdz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907706; c=relaxed/simple;
	bh=9FkU2pdAQ7jw+NV4TdycQajDAfwAm44W9k92o71ADO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gNeV5qBssPmAWgoGl4GnrL1T6kQDTnBZc53hRb5N7zUqc19ayOkiJiODLwl2zk7BYxboHeN7snxG+PyzgSJCmfB+9/s+u+3x8Ba1Zkz6XADs71sSepmI6vmJJXAqFVb7E4SEmcuebhmq95gvkYYNqV5mESZs0laE7f5zihwsJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yre1EPEI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yre1EPEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BG5vFIZuWkBfCpPnsH5jvRyFO8VXn5agYH6VILwADzw=;
	b=Yre1EPEID5clNc9kRzB8dmHho26WgO4x5XZH7oxIWzZqs539B1z37PbuUaZsoUUvKJQ1bu
	oBR0cFra9kyNw00SC+n6qyx0jN9Wjq9xeC1rLlOPyQMtwhOIxDCizN+3051mDIfeAFLrSe
	J/vlIg5TzQL6V4FQWxf9Ic/yE25+xlI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-1TqJmsRxNfGmG4o88L6yEQ-1; Mon, 08 Jun 2026 04:34:52 -0400
X-MC-Unique: 1TqJmsRxNfGmG4o88L6yEQ-1
X-Mimecast-MFC-AGG-ID: 1TqJmsRxNfGmG4o88L6yEQ_1780907691
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490abeb7298so41156915e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907691; x=1781512491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BG5vFIZuWkBfCpPnsH5jvRyFO8VXn5agYH6VILwADzw=;
        b=WAKAm+AvEBInzURxMW4V4dW9oZ+4FWRrbAXcolfRZl0+B3AysGNyaXZ2F8qNY7M/oB
         Uclpd+sTTA+cArC24/OUw/0Kk8Q1cHly3VJZTZms/R8hhfMFbGb5nK1oEG/lR0A/P0mF
         muMG0EoX/q6MKcj5rqCAV2nf+uZGyd/R6G1LqkXEVv38oer/rdDJLnd19Ki7gg8qwOUO
         /F8gHWdNJsBODiBIDcZ27MgZbRSe0uUXYqvC39xqkYa44X40CJ29Vhoi8zczjdbIjCRA
         8gOqSjdDqe+vueJvEe3XkSK2ORQ9cKp7bSMaMRo9LNrXU4wlB0UWylusLhTjW6IA9d8N
         12SA==
X-Forwarded-Encrypted: i=1; AFNElJ+MSEiow+L9KZKAlZZaw0rcUCQRzPF74YqYMEr78rgDmvEBdJVU6+W6fkWqGuImw6lWc3m//zZTsJaBfbC2vg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1NJuDaPvuYKRmYsJBX2HDhnZlVBD2mrz7cGb6f3jk0+V8aWGH
	b0bv6e/mcI2duaxVnngtpFeBtSPTl5IWa/Q/nbN7ZpupwFw/Wg6MxtlNAjrJy32UAQRPnf4KiJ3
	7cjKGIvNeAL2qDY7ry2WKnpNYI6n4JKOCVVVYL2/5aVXxiXsRt/R0wQsl1Wj1oGC45XrJ
X-Gm-Gg: Acq92OGiy3oxIbct6l5KVWyXn8B+umybPIdxEopA/fdjplc1QFB7wWTcTYeqGNHOLdk
	BUCL5kjzRvSKCS+8Ygy6R9Tag9T+nYITCdn6yXhoqc1gvFj7LdASD3doWdtvWOssSTnJXD4LFH5
	ExhT+bA7FpXxktQ/z3brpDQ4lCKaidQcDiitNj17Ho2+Ni5Vsd9lSU0BeGcER4kMtx+/kfPFH6k
	07XX457DtI+u8QLt34lxLABUypitqgBCzWlOljMT1668tCDEnAwyxakNcZ8QqiwQ/18IebR4HTc
	OrTNvoQWvEY7Kjj9y28rPcxw9IbvIqP3UhJOOmY0FdGMxB7lp1pM73rDOh6N8jR9bGlhDb6ynwU
	bFMYRpiFOzdr+aRufLWcvLQg=
X-Received: by 2002:a05:600c:a011:b0:490:58ef:cea7 with SMTP id 5b1f17b1804b1-490c25ee058mr246872585e9.22.1780907690629;
        Mon, 08 Jun 2026 01:34:50 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:490:58ef:cea7 with SMTP id 5b1f17b1804b1-490c25ee058mr246870995e9.22.1780907690081;
        Mon, 08 Jun 2026 01:34:50 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm52009994f8f.13.2026.06.08.01.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:34:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:34:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v10 03/37] mm: page_alloc: propagate PageReported flag across
 buddy splits
Message-ID: <1a407d39a9ebd95e9de67e44f9ad2db37c9f31e9.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nb2OgZeZOdw7e9R1p8KQn9SWU7UaeX8ZlfshhKPfEgI_1780907691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a reported free page is split via expand() to satisfy a
smaller allocation, the sub-pages placed back on the free lists
lose the PageReported flag.  This means they will be unnecessarily
re-reported to the hypervisor in the next reporting cycle, wasting
work.

While I was unable to quantify the performance difference, it is
an obvious waste, even if small.

Propagate the PageReported flag to sub-pages during expand(),
both in page_del_and_expand() and try_to_claim_block(), so

split_large_buddy() also propagates PageReported via a bool
parameter: the caller saves PageReported before
del_page_from_free_list() clears it, then passes the saved
value. The flag is set after __free_one_page() with a
PageBuddy check, matching the page_reporting_drain() pattern.
Free-path callers pass false (freshly freed pages are never
reported).
that they are recognized as already-reported.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d49c254174da..8dae5b3f5876 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1502,7 +1502,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 /* Split a multi-block free page into its individual pageblocks. */
 static void split_large_buddy(struct zone *zone, struct page *page,
-			      unsigned long pfn, int order, fpi_t fpi)
+			      unsigned long pfn, int order, fpi_t fpi,
+			      bool reported)
 {
 	unsigned long end = pfn + (1 << order);
 
@@ -1517,6 +1518,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 		int mt = get_pfnblock_migratetype(page, pfn);
 
 		__free_one_page(page, pfn, zone, order, mt, fpi);
+		if (reported && PageBuddy(page) && buddy_order(page) == order)
+			__SetPageReported(page);
 		pfn += 1 << order;
 		if (pfn == end)
 			break;
@@ -1559,11 +1562,12 @@ static void free_one_page(struct zone *zone, struct page *page,
 		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
 			unsigned int p_order = p->private;
 
-			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
+			split_large_buddy(zone, p, page_to_pfn(p), p_order,
+					  fpi_flags, false);
 			__count_vm_events(PGFREE, 1 << p_order);
 		}
 	}
-	split_large_buddy(zone, page, pfn, order, fpi_flags);
+	split_large_buddy(zone, page, pfn, order, fpi_flags, false);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	__count_vm_events(PGFREE, 1 << order);
@@ -1694,7 +1698,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype)
+				  int high, int migratetype, bool reported)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1716,6 +1720,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
 		nr_added += size;
+
+		/*
+		 * The parent page has been reported to the host.  The
+		 * sub-pages are part of the same reported block, so mark
+		 * them reported too.  This avoids re-reporting pages that
+		 * the host already knows about.
+		 */
+		if (reported)
+			__SetPageReported(&page[size]);
 	}
 
 	return nr_added;
@@ -1726,9 +1739,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 						int high, int migratetype)
 {
 	int nr_pages = 1 << high;
+	bool was_reported = page_reported(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
-	nr_pages -= expand(zone, page, low, high, migratetype);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2116,11 +2130,13 @@ static bool __move_freepages_block_isolate(struct zone *zone,
 	/* We're a part of a larger buddy */
 	if (PageBuddy(buddy) && buddy_order(buddy) > pageblock_order) {
 		int order = buddy_order(buddy);
+		bool reported = PageReported(buddy);
 
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, buddy_pfn));
 		toggle_pageblock_isolate(page, isolate);
-		split_large_buddy(zone, buddy, buddy_pfn, order, FPI_NONE);
+		split_large_buddy(zone, buddy, buddy_pfn, order, FPI_NONE,
+				  reported);
 		return true;
 	}
 
@@ -2283,10 +2299,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		unsigned int nr_added;
+		bool was_reported = page_reported(page);
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
-		nr_added = expand(zone, page, order, current_order, start_type);
+		nr_added = expand(zone, page, order, current_order, start_type,
+				  was_reported);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

