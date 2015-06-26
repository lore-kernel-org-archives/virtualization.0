From: Gioh Kim <gioh.kim@lge.com>
Subject: [RFCv2 1/5] mm/compaction: enable driver page migration
Date: Fri, 26 Jun 2015 18:58:26 +0900
Message-ID: <1435312710-15108-2-git-send-email-gioh.kim__31889.199865009$1435312686$gmane$org@lge.com>
References: <1435312710-15108-1-git-send-email-gioh.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1435312710-15108-1-git-send-email-gioh.kim@lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jlayton@poochiereds.net, bfields@fieldses.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com, viro@zeniv.linux.org.uk, mst@redhat.com, koct9i@gmail.com, minchan@kernel.org, aquini@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, Gioh Kim <gioh.kim@lge.com>
List-Id: virtualization@lists.linuxfoundation.org

Add framework to register callback functions and
check pages migratable.
There are some modes of page isolation so that isolate interface
has an arguments of page address and isolation mode.

Signed-off-by: Gioh Kim <gioh.kim@lge.com>
---
 include/linux/compaction.h | 11 +++++++++++
 include/linux/fs.h         |  2 ++
 include/linux/page-flags.h | 19 +++++++++++++++++++
 include/linux/pagemap.h    | 27 +++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index aa8f61c..4e91a07 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -1,6 +1,9 @@
 #ifndef _LINUX_COMPACTION_H
 #define _LINUX_COMPACTION_H
 
+#include <linux/pagemap.h>
+#include <linux/mm.h>
+
 /* Return values for compact_zone() and try_to_compact_pages() */
 /* compaction didn't start as it was deferred due to past failures */
 #define COMPACT_DEFERRED	0
@@ -51,6 +54,10 @@ extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
 extern bool compaction_restarting(struct zone *zone, int order);
 
+static inline bool driver_page_migratable(struct page *page)
+{
+	return PageMigratable(page) && mapping_migratable(page->mapping);
+}
 #else
 static inline unsigned long try_to_compact_pages(gfp_t gfp_mask,
 			unsigned int order, int alloc_flags,
@@ -83,6 +90,10 @@ static inline bool compaction_deferred(struct zone *zone, int order)
 	return true;
 }
 
+static inline bool driver_page_migratable(struct page *page)
+{
+	return false
+}
 #endif /* CONFIG_COMPACTION */
 
 #if defined(CONFIG_COMPACTION) && defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a0653e5..2cc4b24 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -396,6 +396,8 @@ struct address_space_operations {
 	 */
 	int (*migratepage) (struct address_space *,
 			struct page *, struct page *, enum migrate_mode);
+	bool (*isolatepage) (struct page *, isolate_mode_t);
+	void (*putbackpage) (struct page *);
 	int (*launder_page) (struct page *);
 	int (*is_partially_uptodate) (struct page *, unsigned long,
 					unsigned long);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 91b7f9b..c8a66de 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -649,6 +649,25 @@ static inline void __ClearPageBalloon(struct page *page)
 	atomic_set(&page->_mapcount, -1);
 }
 
+#define PAGE_MIGRATABLE_MAPCOUNT_VALUE (-255)
+
+static inline int PageMigratable(struct page *page)
+{
+	return atomic_read(&page->_mapcount) == PAGE_MIGRATABLE_MAPCOUNT_VALUE;
+}
+
+static inline void __SetPageMigratable(struct page *page)
+{
+	VM_BUG_ON_PAGE(atomic_read(&page->_mapcount) != -1, page);
+	atomic_set(&page->_mapcount, PAGE_MIGRATABLE_MAPCOUNT_VALUE);
+}
+
+static inline void __ClearPageMigratable(struct page *page)
+{
+	VM_BUG_ON_PAGE(!PageMigratable(page), page);
+	atomic_set(&page->_mapcount, -1);
+}
+
 /*
  * If network-based swap is enabled, sl*b must keep track of whether pages
  * were allocated from pfmemalloc reserves.
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3e95fb6..a306798 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -25,8 +25,35 @@ enum mapping_flags {
 	AS_MM_ALL_LOCKS	= __GFP_BITS_SHIFT + 2,	/* under mm_take_all_locks() */
 	AS_UNEVICTABLE	= __GFP_BITS_SHIFT + 3,	/* e.g., ramdisk, SHM_LOCK */
 	AS_EXITING	= __GFP_BITS_SHIFT + 4, /* final truncate in progress */
+	AS_MIGRATABLE   = __GFP_BITS_SHIFT + 5,
 };
 
+static inline void mapping_set_migratable(struct address_space *mapping)
+{
+	set_bit(AS_MIGRATABLE, &mapping->flags);
+}
+
+static inline void mapping_clear_migratable(struct address_space *mapping)
+{
+	clear_bit(AS_MIGRATABLE, &mapping->flags);
+}
+
+static inline int __mapping_ops(struct address_space *mapping)
+{
+	/* migrating page should define all following methods */
+	return mapping->a_ops &&
+		mapping->a_ops->migratepage &&
+		mapping->a_ops->isolatepage &&
+		mapping->a_ops->putbackpage;
+}
+
+static inline int mapping_migratable(struct address_space *mapping)
+{
+	if (mapping && __mapping_ops(mapping))
+		return test_bit(AS_MIGRATABLE, &mapping->flags);
+	return !!mapping;
+}
+
 static inline void mapping_set_error(struct address_space *mapping, int error)
 {
 	if (unlikely(error)) {
-- 
1.9.1
