From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/2] calculate 'available' memory in the separate function
Date: Tue, 16 Feb 2016 18:50:51 +0300
Message-ID: <1455637852-7323-2-git-send-email-den__46480.4203402766$1455639136$gmane$org@openvz.org>
References: <1455637852-7323-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1455637852-7323-1-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Igor Redko <redkoi@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Denis V. Lunev" <den@openvz.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Igor Redko <redkoi@virtuozzo.com>

Factor out calculation of the available memory counter into a separate
exportable function, in order to be able to use it in other parts of
the kernel.

In particular, it appears a relevant metric to report to the
hypervisor via virtio-balloon statistics interface (in a followup
patch).

Signed-off-by: Igor Redko <redkoi@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/meminfo.c  | 31 +------------------------------
 include/linux/mm.h |  1 +
 mm/page_alloc.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index df4661a..8372046 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -29,10 +29,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	unsigned long committed;
 	long cached;
 	long available;
-	unsigned long pagecache;
-	unsigned long wmark_low = 0;
 	unsigned long pages[NR_LRU_LISTS];
-	struct zone *zone;
 	int lru;
 
 /*
@@ -51,33 +48,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
 		pages[lru] = global_page_state(NR_LRU_BASE + lru);
 
-	for_each_zone(zone)
-		wmark_low += zone->watermark[WMARK_LOW];
-
-	/*
-	 * Estimate the amount of memory available for userspace allocations,
-	 * without causing swapping.
-	 */
-	available = i.freeram - totalreserve_pages;
-
-	/*
-	 * Not all the page cache can be freed, otherwise the system will
-	 * start swapping. Assume at least half of the page cache, or the
-	 * low watermark worth of cache, needs to stay.
-	 */
-	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
-	pagecache -= min(pagecache / 2, wmark_low);
-	available += pagecache;
-
-	/*
-	 * Part of the reclaimable slab consists of items that are in use,
-	 * and cannot be freed. Cap this estimate at the low watermark.
-	 */
-	available += global_page_state(NR_SLAB_RECLAIMABLE) -
-		     min(global_page_state(NR_SLAB_RECLAIMABLE) / 2, wmark_low);
-
-	if (available < 0)
-		available = 0;
+	available = si_mem_available();
 
 	/*
 	 * Tagged format, for easy grepping and expansion.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 516e149..a8c4144 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1862,6 +1862,7 @@ extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
 extern void __init mmap_init(void);
 extern void show_mem(unsigned int flags);
+extern long si_mem_available(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 838ca8bb..dae813c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3603,6 +3603,49 @@ static inline void show_node(struct zone *zone)
 		printk("Node %d ", zone_to_nid(zone));
 }
 
+long si_mem_available(void)
+{
+	long available;
+	unsigned long pagecache;
+	unsigned long wmark_low = 0;
+	unsigned long pages[NR_LRU_LISTS];
+	struct zone *zone;
+	int lru;
+
+	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
+		pages[lru] = global_page_state(NR_LRU_BASE + lru);
+
+	for_each_zone(zone)
+		wmark_low += zone->watermark[WMARK_LOW];
+
+	/*
+	 * Estimate the amount of memory available for userspace allocations,
+	 * without causing swapping.
+	 */
+	available = global_page_state(NR_FREE_PAGES) - totalreserve_pages;
+
+	/*
+	 * Not all the page cache can be freed, otherwise the system will
+	 * start swapping. Assume at least half of the page cache, or the
+	 * low watermark worth of cache, needs to stay.
+	 */
+	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
+	pagecache -= min(pagecache / 2, wmark_low);
+	available += pagecache;
+
+	/*
+	 * Part of the reclaimable slab consists of items that are in use,
+	 * and cannot be freed. Cap this estimate at the low watermark.
+	 */
+	available += global_page_state(NR_SLAB_RECLAIMABLE) -
+		     min(global_page_state(NR_SLAB_RECLAIMABLE) / 2, wmark_low);
+
+	if (available < 0)
+		available = 0;
+	return available;
+}
+EXPORT_SYMBOL_GPL(si_mem_available);
+
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-- 
2.5.0
