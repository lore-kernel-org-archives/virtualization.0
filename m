From: Rafael Aquini <aquini@redhat.com>
Subject: [PATCH v7 3/4] mm: introduce putback_movable_pages()
Date: Fri, 10 Aug 2012 14:55:16 -0300
Message-ID: <9147e5cccc4bb2d3f2e5f155e640148eb5365af5.1344619987.git.aquini__41518.7487066307$1344621371$gmane$org@redhat.com>
References: <cover.1344619987.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1344619987.git.aquini@redhat.com>
In-Reply-To: <cover.1344619987.git.aquini@redhat.com>
References: <cover.1344619987.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-mm@kvack.org
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Minchan Kim <minchan@kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The PATCH "mm: introduce compaction and migration for virtio ballooned pages"
hacks around putback_lru_pages() in order to allow ballooned pages to be
re-inserted on balloon page list as if a ballooned page was like a LRU page.

As ballooned pages are not legitimate LRU pages, this patch introduces
putback_movable_pages() to properly cope with cases where the isolated
pageset contains ballooned pages and LRU pages, thus fixing the mentioned
inelegant hack around putback_lru_pages().

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 include/linux/migrate.h |  2 ++
 mm/compaction.c         |  4 ++--
 mm/migrate.c            | 20 ++++++++++++++++++++
 mm/page_alloc.c         |  2 +-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index ce7e667..ff103a1 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -10,6 +10,7 @@ typedef struct page *new_page_t(struct page *, unsigned long private, int **);
 #ifdef CONFIG_MIGRATION
 
 extern void putback_lru_pages(struct list_head *l);
+extern void putback_movable_pages(struct list_head *l);
 extern int migrate_page(struct address_space *,
 			struct page *, struct page *, enum migrate_mode);
 extern int migrate_pages(struct list_head *l, new_page_t x,
@@ -33,6 +34,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 #else
 
 static inline void putback_lru_pages(struct list_head *l) {}
+static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t x,
 		unsigned long private, bool offlining,
 		enum migrate_mode mode) { return -ENOSYS; }
diff --git a/mm/compaction.c b/mm/compaction.c
index e4e871b..8567bb8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -837,9 +837,9 @@ static int compact_zone(struct zone *zone, struct compact_control *cc)
 		trace_mm_compaction_migratepages(nr_migrate - nr_remaining,
 						nr_remaining);
 
-		/* Release LRU pages not migrated */
+		/* Release isolated pages not migrated */
 		if (err) {
-			putback_lru_pages(&cc->migratepages);
+			putback_movable_pages(&cc->migratepages);
 			cc->nr_migratepages = 0;
 			if (err == -ENOMEM) {
 				ret = COMPACT_PARTIAL;
diff --git a/mm/migrate.c b/mm/migrate.c
index 80f22bb..1165134 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -79,6 +79,26 @@ void putback_lru_pages(struct list_head *l)
 		list_del(&page->lru);
 		dec_zone_page_state(page, NR_ISOLATED_ANON +
 				page_is_file_cache(page));
+			putback_lru_page(page);
+	}
+}
+
+/*
+ * Put previously isolated pages back onto the appropriated lists
+ * from where they were once taken off for compaction/migration.
+ *
+ * This function shall be used instead of putback_lru_pages(),
+ * whenever the isolated pageset has been built by isolate_migratepages_range()
+ */
+void putback_movable_pages(struct list_head *l)
+{
+	struct page *page;
+	struct page *page2;
+
+	list_for_each_entry_safe(page, page2, l, lru) {
+		list_del(&page->lru);
+		dec_zone_page_state(page, NR_ISOLATED_ANON +
+				page_is_file_cache(page));
 		if (unlikely(movable_balloon_page(page)))
 			putback_balloon_page(page);
 		else
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 009ac28..78b7663 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5669,7 +5669,7 @@ static int __alloc_contig_migrate_range(unsigned long start, unsigned long end)
 				    0, false, MIGRATE_SYNC);
 	}
 
-	putback_lru_pages(&cc.migratepages);
+	putback_movable_pages(&cc.migratepages);
 	return ret > 0 ? 0 : ret;
 }
 
-- 
1.7.11.2
