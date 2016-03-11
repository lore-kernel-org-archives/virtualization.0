From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 01/19] mm: use put_page to free page instead of
	putback_lru_page
Date: Fri, 11 Mar 2016 16:30:05 +0900
Message-ID: <1457681423-26664-2-git-send-email-minchan__20729.6274988495$1457682321$gmane$org@kernel.org>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1457681423-26664-1-git-send-email-minchan@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, jlayton@poochiereds.net, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Procedure of page migration is as follows:

First of all, it should isolate a page from LRU and try to
migrate the page. If it is successful, it releases the page
for freeing. Otherwise, it should put the page back to LRU
list.

For LRU pages, we have used putback_lru_page for both freeing
and putback to LRU list. It's okay because put_page is aware of
LRU list so if it releases last refcount of the page, it removes
the page from LRU list. However, It makes unnecessary operations
(e.g., lru_cache_add, pagevec and flags operations. It would be
not significant but no worth to do) and harder to support new
non-lru page migration because put_page isn't aware of non-lru
page's data structure.

To solve the problem, we can add new hook in put_page with
PageMovable flags check but it can increase overhead in
hot path and needs new locking scheme to stabilize the flag check
with put_page.

So, this patch cleans it up to divide two semantic(ie, put and putback).
If migration is successful, use put_page instead of putback_lru_page and
use putback_lru_page only on failure. That makes code more readable
and doesn't add overhead in put_page.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/migrate.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3ad0fea5c438..bf31ea9ffaf8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -907,6 +907,14 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		put_anon_vma(anon_vma);
 	unlock_page(page);
 out:
+	/* If migration is scucessful, move newpage to right list */
+	if (rc == MIGRATEPAGE_SUCCESS) {
+		if (unlikely(__is_movable_balloon_page(newpage)))
+			put_page(newpage);
+		else
+			putback_lru_page(newpage);
+	}
+
 	return rc;
 }
 
@@ -940,6 +948,12 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 
 	if (page_count(page) == 1) {
 		/* page was freed from under us. So we are done. */
+		ClearPageActive(page);
+		ClearPageUnevictable(page);
+		if (put_new_page)
+			put_new_page(newpage, private);
+		else
+			put_page(newpage);
 		goto out;
 	}
 
@@ -952,9 +966,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 	}
 
 	rc = __unmap_and_move(page, newpage, force, mode);
-	if (rc == MIGRATEPAGE_SUCCESS)
-		put_new_page = NULL;
-
 out:
 	if (rc != -EAGAIN) {
 		/*
@@ -966,28 +977,28 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		list_del(&page->lru);
 		dec_zone_page_state(page, NR_ISOLATED_ANON +
 				page_is_file_cache(page));
-		/* Soft-offlined page shouldn't go through lru cache list */
+	}
+
+	/*
+	 * If migration is successful, drop the reference grabbed during
+	 * isolation. Otherwise, restore the page to LRU list unless we
+	 * want to retry.
+	 */
+	if (rc == MIGRATEPAGE_SUCCESS) {
+		put_page(page);
 		if (reason == MR_MEMORY_FAILURE) {
-			put_page(page);
 			if (!test_set_page_hwpoison(page))
 				num_poisoned_pages_inc();
-		} else
+		}
+	} else {
+		if (rc != -EAGAIN)
 			putback_lru_page(page);
+		if (put_new_page)
+			put_new_page(newpage, private);
+		else
+			put_page(newpage);
 	}
 
-	/*
-	 * If migration was not successful and there's a freeing callback, use
-	 * it.  Otherwise, putback_lru_page() will drop the reference grabbed
-	 * during isolation.
-	 */
-	if (put_new_page)
-		put_new_page(newpage, private);
-	else if (unlikely(__is_movable_balloon_page(newpage))) {
-		/* drop our reference, page already in the balloon */
-		put_page(newpage);
-	} else
-		putback_lru_page(newpage);
-
 	if (result) {
 		if (rc)
 			*result = rc;
-- 
1.9.1
