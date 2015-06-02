From: Gioh Kim <gioh.kim@lge.com>
Subject: [RFC 4/4] mm: remove direct calling of migration
Date: Tue,  2 Jun 2015 16:27:44 +0900
Message-ID: <1433230065-3573-5-git-send-email-gioh.kim__13462.2004385621$1433230094$gmane$org@lge.com>
References: <1433230065-3573-1-git-send-email-gioh.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1433230065-3573-1-git-send-email-gioh.kim@lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jlayton@poochiereds.net, bfields@fieldses.org, akpm@linux-foundation.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com, mst@redhat.com, kirill@shutemov.name, minchan@kernel.org, mgorman@suse.de
Cc: linux-mm@kvack.org, Gioh Kim <gioh.kim@lge.com>, gunho.lee@lge.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Migration is completely generalized.

Signed-off-by: Gioh Kim <gioh.kim@lge.com>
---
 mm/balloon_compaction.c |  8 --------
 mm/migrate.c            | 15 ---------------
 2 files changed, 23 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index f98a500..d29270aa 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -206,13 +206,6 @@ int balloon_page_migrate(struct address_space *mapping,
 	if (!isolated_balloon_page(page))
 		return rc;
 
-	/*
-	 * Block others from accessing the 'newpage' when we get around to
-	 * establishing additional references. We should be the only one
-	 * holding a reference to the 'newpage' at this point.
-	 */
-	BUG_ON(!trylock_page(newpage));
-
 	if (WARN_ON(!__is_movable_balloon_page(page))) {
 		dump_page(page, "not movable balloon page");
 		unlock_page(newpage);
@@ -222,7 +215,6 @@ int balloon_page_migrate(struct address_space *mapping,
 	if (balloon && balloon->migratepage)
 		rc = balloon->migratepage(balloon, newpage, page, mode);
 
-	unlock_page(newpage);
 	return rc;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 649b1cd..ca47b3e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -844,21 +844,6 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		}
 	}
 
-	if (unlikely(driver_page_migratable(page))) {
-		/*
-		 * A migratable-page does not need any special attention from
-		 * physical to virtual reverse mapping procedures.
-		 * Skip any attempt to unmap PTEs or to remap swap cache,
-		 * in order to avoid burning cycles at rmap level, and perform
-		 * the page migration right away (proteced by page lock).
-		 */
-		rc = page->mapping->a_ops->migratepage(page->mapping,
-						       newpage,
-						       page,
-						       mode);
-		goto out_unlock;
-	}
-
 	/*
 	 * Corner case handling:
 	 * 1. When a new swap-cache page is read into, it is added to the LRU
-- 
1.9.1
