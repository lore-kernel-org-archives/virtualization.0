From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 08/19] zsmalloc: remove unused pool param in obj_free
Date: Fri, 11 Mar 2016 16:30:12 +0900
Message-ID: <1457681423-26664-9-git-send-email-minchan__27246.1511697204$1457682334$gmane$org@kernel.org>
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
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, jlayton@poochiereds.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Let's remove unused pool param in obj_free

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 156edf909046..b4fb11831acb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1435,8 +1435,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size)
 }
 EXPORT_SYMBOL_GPL(zs_malloc);
 
-static void obj_free(struct zs_pool *pool, struct size_class *class,
-			unsigned long obj)
+static void obj_free(struct size_class *class, unsigned long obj)
 {
 	struct link_free *link;
 	struct page *first_page, *f_page;
@@ -1482,7 +1481,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	class = pool->size_class[class_idx];
 
 	spin_lock(&class->lock);
-	obj_free(pool, class, obj);
+	obj_free(class, obj);
 	fullness = fix_fullness_group(class, first_page);
 	if (fullness == ZS_EMPTY) {
 		zs_stat_dec(class, OBJ_ALLOCATED, get_maxobj_per_zspage(
@@ -1645,7 +1644,7 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		free_obj |= BIT(HANDLE_PIN_BIT);
 		record_obj(handle, free_obj);
 		unpin_tag(handle);
-		obj_free(pool, class, used_obj);
+		obj_free(class, used_obj);
 	}
 
 	/* Remember last position in this iteration */
-- 
1.9.1
