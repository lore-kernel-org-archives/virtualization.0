From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 11/16] zsmalloc: separate free_zspage from putback_zspage
Date: Wed, 30 Mar 2016 16:12:10 +0900
Message-ID: <1459321935-3655-12-git-send-email-minchan__16918.3851372965$1459321978$gmane$org@kernel.org>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459321935-3655-1-git-send-email-minchan@kernel.org>
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
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, koct9i@gmail.com, Sangseok Lee <sangseok.lee@lge.com>, jlayton@poochiereds.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Currently, putback_zspage does free zspage under class->lock
if fullness become ZS_EMPTY but it makes trouble to implement
locking scheme for new zspage migration.
So, this patch is to separate free_zspage from putback_zspage
and free zspage out of class->lock which is preparation for
zspage migration.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 14bcc741eead..b11dcd718502 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -949,7 +949,8 @@ static void reset_page(struct page *page)
 	page->freelist = NULL;
 }
 
-static void free_zspage(struct page *first_page)
+static void free_zspage(struct zs_pool *pool, struct size_class *class,
+			struct page *first_page)
 {
 	struct page *nextp, *tmp, *head_extra;
 
@@ -972,6 +973,11 @@ static void free_zspage(struct page *first_page)
 	}
 	reset_page(head_extra);
 	__free_page(head_extra);
+
+	zs_stat_dec(class, OBJ_ALLOCATED, get_maxobj_per_zspage(
+			class->size, class->pages_per_zspage));
+	atomic_long_sub(class->pages_per_zspage,
+				&pool->pages_allocated);
 }
 
 /* Initialize a newly allocated zspage */
@@ -1559,13 +1565,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	spin_lock(&class->lock);
 	obj_free(class, obj);
 	fullness = fix_fullness_group(class, first_page);
-	if (fullness == ZS_EMPTY) {
-		zs_stat_dec(class, OBJ_ALLOCATED, get_maxobj_per_zspage(
-				class->size, class->pages_per_zspage));
-		atomic_long_sub(class->pages_per_zspage,
-				&pool->pages_allocated);
-		free_zspage(first_page);
-	}
+	if (fullness == ZS_EMPTY)
+		free_zspage(pool, class, first_page);
 	spin_unlock(&class->lock);
 	unpin_tag(handle);
 
@@ -1752,7 +1753,7 @@ static struct page *isolate_target_page(struct size_class *class)
  * @class: destination class
  * @first_page: target page
  *
- * Return @fist_page's fullness_group
+ * Return @first_page's updated fullness_group
  */
 static enum fullness_group putback_zspage(struct zs_pool *pool,
 			struct size_class *class,
@@ -1764,15 +1765,6 @@ static enum fullness_group putback_zspage(struct zs_pool *pool,
 	insert_zspage(class, fullness, first_page);
 	set_zspage_mapping(first_page, class->index, fullness);
 
-	if (fullness == ZS_EMPTY) {
-		zs_stat_dec(class, OBJ_ALLOCATED, get_maxobj_per_zspage(
-			class->size, class->pages_per_zspage));
-		atomic_long_sub(class->pages_per_zspage,
-				&pool->pages_allocated);
-
-		free_zspage(first_page);
-	}
-
 	return fullness;
 }
 
@@ -1835,23 +1827,31 @@ static void __zs_compact(struct zs_pool *pool, struct size_class *class)
 			if (!migrate_zspage(pool, class, &cc))
 				break;
 
-			putback_zspage(pool, class, dst_page);
+			VM_BUG_ON_PAGE(putback_zspage(pool, class,
+				dst_page) == ZS_EMPTY, dst_page);
 		}
 
 		/* Stop if we couldn't find slot */
 		if (dst_page == NULL)
 			break;
 
-		putback_zspage(pool, class, dst_page);
-		if (putback_zspage(pool, class, src_page) == ZS_EMPTY)
+		VM_BUG_ON_PAGE(putback_zspage(pool, class,
+				dst_page) == ZS_EMPTY, dst_page);
+		if (putback_zspage(pool, class, src_page) == ZS_EMPTY) {
 			pool->stats.pages_compacted += class->pages_per_zspage;
-		spin_unlock(&class->lock);
+			spin_unlock(&class->lock);
+			free_zspage(pool, class, src_page);
+		} else {
+			spin_unlock(&class->lock);
+		}
+
 		cond_resched();
 		spin_lock(&class->lock);
 	}
 
 	if (src_page)
-		putback_zspage(pool, class, src_page);
+		VM_BUG_ON_PAGE(putback_zspage(pool, class,
+				src_page) == ZS_EMPTY, src_page);
 
 	spin_unlock(&class->lock);
 }
-- 
1.9.1
