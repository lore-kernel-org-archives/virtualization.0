From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 1/6] mm/page_alloc: tweak comments in has_unmovable_pages()
Date: Tue, 30 Jun 2020 16:26:34 +0200
Message-ID: <20200630142639.22770-2-david@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200630142639.22770-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Let's move the split comment regarding bootmem allocations and memory
holes, especially in the context of ZONE_MOVABLE, to the PageReserved()
check.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d47..bd3ebf08f09b9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8207,14 +8207,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 	unsigned long iter = 0;
 	unsigned long pfn = page_to_pfn(page);
 
-	/*
-	 * TODO we could make this much more efficient by not checking every
-	 * page in the range if we know all of them are in MOVABLE_ZONE and
-	 * that the movable zone guarantees that pages are migratable but
-	 * the later is not the case right now unfortunatelly. E.g. movablecore
-	 * can still lead to having bootmem allocations in zone_movable.
-	 */
-
 	if (is_migrate_cma_page(page)) {
 		/*
 		 * CMA allocations (alloc_contig_range) really need to mark
@@ -8233,6 +8225,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 
 		page = pfn_to_page(pfn + iter);
 
+		/*
+		 * Both, bootmem allocations and memory holes are marked
+		 * PG_reserved and are unmovable. We can even have unmovable
+		 * allocations inside ZONE_MOVABLE, for example when
+		 * specifying "movable_core".
+		 */
 		if (PageReserved(page))
 			return page;
 
@@ -8306,14 +8304,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		 * it.  But now, memory offline itself doesn't call
 		 * shrink_node_slabs() and it still to be fixed.
 		 */
-		/*
-		 * If the page is not RAM, page_count()should be 0.
-		 * we don't need more check. This is an _used_ not-movable page.
-		 *
-		 * The problematic thing here is PG_reserved pages. PG_reserved
-		 * is set to both of a memory hole page and a _used_ kernel
-		 * page at boot.
-		 */
 		return page;
 	}
 	return NULL;
-- 
2.26.2
