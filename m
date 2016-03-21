From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 16/18] zsmalloc: use single linked list for page chain
Date: Mon, 21 Mar 2016 15:31:05 +0900
Message-ID: <1458541867-27380-17-git-send-email-minchan__38.1872560412333$1458541985$gmane$org@kernel.org>
References: <1458541867-27380-1-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1458541867-27380-1-git-send-email-minchan@kernel.org>
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

For tail page migration, we shouldn't use page->lru which
was used for page chaining because VM will use it for own
purpose so that we need another field for chaining.
For chaining, singly linked list is enough and page->index
of tail page to point first object offset in the page could
be replaced in run-time calculation.

So, this patch change page->lru list for chaining with singly
linked list via page->freelist squeeze and introduces
get_first_obj_ofs to get first object offset in a page.

With that, it could maintain page chaining without using
page->lru.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 119 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 41 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b3b31fdfea0f..9b4b03d8f993 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -17,10 +17,7 @@
  *
  * Usage of struct page fields:
  *	page->private: points to the first component (0-order) page
- *	page->index (union with page->freelist): offset of the first object
- *		starting in this page.
- *	page->lru: links together all component pages (except the first page)
- *		of a zspage
+ *	page->index (union with page->freelist): override by struct zs_meta
  *
  *	For _first_ page only:
  *
@@ -271,10 +268,19 @@ struct zs_pool {
 };
 
 struct zs_meta {
-	unsigned long freeobj:FREEOBJ_BITS;
-	unsigned long class:CLASS_BITS;
-	unsigned long fullness:FULLNESS_BITS;
-	unsigned long inuse:INUSE_BITS;
+	union {
+		/* first page */
+		struct {
+			unsigned long freeobj:FREEOBJ_BITS;
+			unsigned long class:CLASS_BITS;
+			unsigned long fullness:FULLNESS_BITS;
+			unsigned long inuse:INUSE_BITS;
+		};
+		/* tail pages */
+		struct {
+			struct page *next;
+		};
+	};
 };
 
 struct mapping_area {
@@ -491,6 +497,34 @@ static unsigned long get_freeobj(struct page *first_page)
 	return m->freeobj;
 }
 
+static void set_next_page(struct page *page, struct page *next)
+{
+	struct zs_meta *m;
+
+	VM_BUG_ON_PAGE(is_first_page(page), page);
+
+	m = (struct zs_meta *)&page->index;
+	m->next = next;
+}
+
+static struct page *get_next_page(struct page *page)
+{
+	struct page *next;
+
+	if (is_last_page(page))
+		next = NULL;
+	else if (is_first_page(page))
+		next = (struct page *)page_private(page);
+	else {
+		struct zs_meta *m = (struct zs_meta *)&page->index;
+
+		VM_BUG_ON(!m->next);
+		next = m->next;
+	}
+
+	return next;
+}
+
 static void get_zspage_mapping(struct page *first_page,
 				unsigned int *class_idx,
 				enum fullness_group *fullness)
@@ -871,18 +905,30 @@ static struct page *get_first_page(struct page *page)
 		return (struct page *)page_private(page);
 }
 
-static struct page *get_next_page(struct page *page)
+int get_first_obj_ofs(struct size_class *class, struct page *first_page,
+			struct page *page)
 {
-	struct page *next;
+	int pos, bound;
+	int page_idx = 0;
+	int ofs = 0;
+	struct page *cursor = first_page;
 
-	if (is_last_page(page))
-		next = NULL;
-	else if (is_first_page(page))
-		next = (struct page *)page_private(page);
-	else
-		next = list_entry(page->lru.next, struct page, lru);
+	if (first_page == page)
+		goto out;
 
-	return next;
+	while (page != cursor) {
+		page_idx++;
+		cursor = get_next_page(cursor);
+	}
+
+	bound = PAGE_SIZE * page_idx;
+	pos = (((class->objs_per_zspage * class->size) *
+		page_idx / class->pages_per_zspage) / class->size
+		) * class->size;
+
+	ofs = (pos + class->size) % PAGE_SIZE;
+out:
+	return ofs;
 }
 
 static void objidx_to_page_and_offset(struct size_class *class,
@@ -1008,27 +1054,25 @@ void lock_zspage(struct page *first_page)
 
 static void free_zspage(struct zs_pool *pool, struct page *first_page)
 {
-	struct page *nextp, *tmp, *head_extra;
+	struct page *nextp, *tmp;
 
 	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 	VM_BUG_ON_PAGE(get_zspage_inuse(first_page), first_page);
 
 	lock_zspage(first_page);
-	head_extra = (struct page *)page_private(first_page);
+	nextp = (struct page *)page_private(first_page);
 
 	/* zspage with only 1 system page */
-	if (!head_extra)
+	if (!nextp)
 		goto out;
 
-	list_for_each_entry_safe(nextp, tmp, &head_extra->lru, lru) {
-		list_del(&nextp->lru);
-		reset_page(nextp);
-		unlock_page(nextp);
-		__free_page(nextp);
-	}
-	reset_page(head_extra);
-	unlock_page(head_extra);
-	__free_page(head_extra);
+	do {
+		tmp = nextp;
+		nextp = get_next_page(nextp);
+		reset_page(tmp);
+		unlock_page(tmp);
+		__free_page(tmp);
+	} while (nextp);
 out:
 	reset_page(first_page);
 	unlock_page(first_page);
@@ -1056,13 +1100,6 @@ static void init_zspage(struct size_class *class, struct page *first_page,
 		struct link_free *link;
 		void *vaddr;
 
-		/*
-		 * page->index stores offset of first object starting
-		 * in the page.
-		 */
-		if (page != first_page)
-			page->index = off;
-
 		vaddr = kmap_atomic(page);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
 
@@ -1104,7 +1141,6 @@ static void create_page_chain(struct page *pages[], int nr_pages)
 	for (i = 0; i < nr_pages; i++) {
 		page = pages[i];
 
-		INIT_LIST_HEAD(&page->lru);
 		if (i == 0) {
 			SetPagePrivate(page);
 			set_page_private(page, 0);
@@ -1113,10 +1149,12 @@ static void create_page_chain(struct page *pages[], int nr_pages)
 
 		if (i == 1)
 			set_page_private(first_page, (unsigned long)page);
-		if (i >= 1)
+		if (i >= 1) {
+			set_next_page(page, NULL);
 			set_page_private(page, (unsigned long)first_page);
+		}
 		if (i >= 2)
-			list_add(&page->lru, &prev_page->lru);
+			set_next_page(prev_page, page);
 		if (i == nr_pages - 1)
 			SetPagePrivate2(page);
 
@@ -2241,8 +2279,7 @@ int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	kunmap_atomic(d_addr);
 	kunmap_atomic(s_addr);
 
-	if (!is_first_page(page))
-		offset = page->index;
+	offset = get_first_obj_ofs(class, first_page, page);
 
 	addr = kmap_atomic(page);
 	do {
-- 
1.9.1
