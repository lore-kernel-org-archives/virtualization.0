From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 06/19] zsmalloc: clean up many BUG_ON
Date: Fri, 11 Mar 2016 16:30:10 +0900
Message-ID: <1457681423-26664-7-git-send-email-minchan__13449.0155768164$1457682380$gmane$org@kernel.org>
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

There are many BUG_ON in zsmalloc.c which is not recommened so
change them as alternatives.

Normal rule is as follows:

1. avoid BUG_ON if possible. Instead, use VM_BUG_ON or VM_BUG_ON_PAGE
2. use VM_BUG_ON_PAGE if we need to see struct page's fields
3. use those assertion in primitive functions so higher functions
can rely on the assertion in the primitive function.
4. Don't use assertion if following instruction can trigger Oops

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index bb29203ec6b3..3c82011cc405 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -419,7 +419,7 @@ static void get_zspage_mapping(struct page *first_page,
 				enum fullness_group *fullness)
 {
 	unsigned long m;
-	BUG_ON(!is_first_page(first_page));
+	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 
 	m = (unsigned long)first_page->mapping;
 	*fullness = m & FULLNESS_MASK;
@@ -431,7 +431,7 @@ static void set_zspage_mapping(struct page *first_page,
 				enum fullness_group fullness)
 {
 	unsigned long m;
-	BUG_ON(!is_first_page(first_page));
+	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 
 	m = ((class_idx & CLASS_IDX_MASK) << FULLNESS_BITS) |
 			(fullness & FULLNESS_MASK);
@@ -626,7 +626,8 @@ static enum fullness_group get_fullness_group(struct page *first_page)
 {
 	int inuse, max_objects;
 	enum fullness_group fg;
-	BUG_ON(!is_first_page(first_page));
+
+	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 
 	inuse = first_page->inuse;
 	max_objects = first_page->objects;
@@ -654,7 +655,7 @@ static void insert_zspage(struct page *first_page, struct size_class *class,
 {
 	struct page **head;
 
-	BUG_ON(!is_first_page(first_page));
+	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 
 	if (fullness >= _ZS_NR_FULLNESS_GROUPS)
 		return;
@@ -686,13 +687,13 @@ static void remove_zspage(struct page *first_page, struct size_class *class,
 {
 	struct page **head;
 
-	BUG_ON(!is_first_page(first_page));
+	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 
 	if (fullness >= _ZS_NR_FULLNESS_GROUPS)
 		return;
 
 	head = &class->fullness_list[fullness];
-	BUG_ON(!*head);
+	VM_BUG_ON_PAGE(!*head, first_page);
 	if (list_empty(&(*head)->lru))
 		*head = NULL;
 	else if (*head == first_page)
@@ -719,8 +720,6 @@ static enum fullness_group fix_fullness_group(struct size_class *class,
 	int class_idx;
 	enum fullness_group currfg, newfg;
 
-	BUG_ON(!is_first_page(first_page));
-
 	get_zspage_mapping(first_page, &class_idx, &currfg);
 	newfg = get_fullness_group(first_page);
 	if (newfg == currfg)
@@ -806,7 +805,7 @@ static void *location_to_obj(struct page *page, unsigned long obj_idx)
 	unsigned long obj;
 
 	if (!page) {
-		BUG_ON(obj_idx);
+		VM_BUG_ON(obj_idx);
 		return NULL;
 	}
 
@@ -839,7 +838,7 @@ static unsigned long obj_to_head(struct size_class *class, struct page *page,
 			void *obj)
 {
 	if (class->huge) {
-		VM_BUG_ON(!is_first_page(page));
+		VM_BUG_ON_PAGE(!is_first_page(page), page);
 		return page_private(page);
 	} else
 		return *(unsigned long *)obj;
@@ -889,8 +888,8 @@ static void free_zspage(struct page *first_page)
 {
 	struct page *nextp, *tmp, *head_extra;
 
-	BUG_ON(!is_first_page(first_page));
-	BUG_ON(first_page->inuse);
+	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
+	VM_BUG_ON_PAGE(first_page->inuse, first_page);
 
 	head_extra = (struct page *)page_private(first_page);
 
@@ -916,7 +915,8 @@ static void init_zspage(struct page *first_page, struct size_class *class)
 	unsigned long off = 0;
 	struct page *page = first_page;
 
-	BUG_ON(!is_first_page(first_page));
+	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
+
 	while (page) {
 		struct page *next_page;
 		struct link_free *link;
@@ -1235,7 +1235,7 @@ static bool can_merge(struct size_class *prev, int size, int pages_per_zspage)
 
 static bool zspage_full(struct page *first_page)
 {
-	BUG_ON(!is_first_page(first_page));
+	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 
 	return first_page->inuse == first_page->objects;
 }
@@ -1273,14 +1273,12 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	struct page *pages[2];
 	void *ret;
 
-	BUG_ON(!handle);
-
 	/*
 	 * Because we use per-cpu mapping areas shared among the
 	 * pools/users, we can't allow mapping in interrupt context
 	 * because it can corrupt another users mappings.
 	 */
-	BUG_ON(in_interrupt());
+	WARN_ON_ONCE(in_interrupt());
 
 	/* From now on, migration cannot move the object */
 	pin_tag(handle);
@@ -1324,8 +1322,6 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	struct size_class *class;
 	struct mapping_area *area;
 
-	BUG_ON(!handle);
-
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	get_zspage_mapping(get_first_page(page), &class_idx, &fg);
@@ -1445,8 +1441,6 @@ static void obj_free(struct zs_pool *pool, struct size_class *class,
 	unsigned long f_objidx, f_offset;
 	void *vaddr;
 
-	BUG_ON(!obj);
-
 	obj &= ~OBJ_ALLOCATED_TAG;
 	obj_to_location(obj, &f_page, &f_objidx);
 	first_page = get_first_page(f_page);
@@ -1546,7 +1540,6 @@ static void zs_object_copy(unsigned long dst, unsigned long src,
 			kunmap_atomic(d_addr);
 			kunmap_atomic(s_addr);
 			s_page = get_next_page(s_page);
-			BUG_ON(!s_page);
 			s_addr = kmap_atomic(s_page);
 			d_addr = kmap_atomic(d_page);
 			s_size = class->size - written;
@@ -1556,7 +1549,6 @@ static void zs_object_copy(unsigned long dst, unsigned long src,
 		if (d_off >= PAGE_SIZE) {
 			kunmap_atomic(d_addr);
 			d_page = get_next_page(d_page);
-			BUG_ON(!d_page);
 			d_addr = kmap_atomic(d_page);
 			d_size = class->size - written;
 			d_off = 0;
@@ -1691,8 +1683,6 @@ static enum fullness_group putback_zspage(struct zs_pool *pool,
 {
 	enum fullness_group fullness;
 
-	BUG_ON(!is_first_page(first_page));
-
 	fullness = get_fullness_group(first_page);
 	insert_zspage(first_page, class, fullness);
 	set_zspage_mapping(first_page, class->index, fullness);
@@ -1753,8 +1743,6 @@ static void __zs_compact(struct zs_pool *pool, struct size_class *class)
 	spin_lock(&class->lock);
 	while ((src_page = isolate_source_page(class))) {
 
-		BUG_ON(!is_first_page(src_page));
-
 		if (!zs_can_compact(class))
 			break;
 
-- 
1.9.1
