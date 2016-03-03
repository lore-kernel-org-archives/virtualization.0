From: Liang Li <liang.z.li@intel.com>
Subject: [RFC kernel 1/2] mm: Add the functions used to get free pages
	information
Date: Thu,  3 Mar 2016 18:46:58 +0800
Message-ID: <1457002019-15998-2-git-send-email-liang.z.li__14287.3899116696$1457019680$gmane$org@intel.com>
References: <1457002019-15998-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1457002019-15998-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, Liang Li <liang.z.li@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, dgilbert@redhat.com, rth@twiddle.net
List-Id: virtualization@lists.linuxfoundation.org

get_total_pages_count() tries to get the page count of the system
RAM.
get_free_pages() is intend to construct a free pages bitmap by
traversing the free_list.

The free pages information will be sent to QEMU through virtio
and used for live migration optimization.

Signed-off-by: Liang Li <liang.z.li@intel.com>
---
 mm/page_alloc.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 838ca8bb..81922e6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3860,6 +3860,63 @@ void show_free_areas(unsigned int filter)
 	show_swap_cache_info();
 }
 
+#define PFN_4G (0x100000000 >> PAGE_SHIFT)
+
+unsigned long get_total_pages_count(unsigned long low_mem)
+{
+	if (max_pfn >= PFN_4G) {
+		unsigned long pfn_gap = PFN_4G - (low_mem >> PAGE_SHIFT);
+
+		return max_pfn - pfn_gap;
+	} else
+		return max_pfn;
+}
+EXPORT_SYMBOL(get_total_pages_count);
+
+static void mark_free_pages_bitmap(struct zone *zone,
+		 unsigned long *free_page_bitmap, unsigned long pfn_gap)
+{
+	unsigned long pfn, flags, i;
+	unsigned int order, t;
+	struct list_head *curr;
+
+	if (zone_is_empty(zone))
+		return;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	for_each_migratetype_order(order, t) {
+		list_for_each(curr, &zone->free_area[order].free_list[t]) {
+
+			pfn = page_to_pfn(list_entry(curr, struct page, lru));
+			for (i = 0; i < (1UL << order); i++) {
+				if ((pfn + i) >= PFN_4G)
+					set_bit_le(pfn + i - pfn_gap,
+						   free_page_bitmap);
+				else
+					set_bit_le(pfn + i, free_page_bitmap);
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
+void get_free_pages(unsigned long *free_page_bitmap,
+		unsigned long *free_pages_count,
+		unsigned long low_mem)
+{
+	struct zone *zone;
+	unsigned long pfn_gap;
+
+	pfn_gap = PFN_4G - (low_mem >> PAGE_SHIFT);
+	for_each_populated_zone(zone)
+		mark_free_pages_bitmap(zone, free_page_bitmap, pfn_gap);
+
+	*free_pages_count = global_page_state(NR_FREE_PAGES);
+}
+EXPORT_SYMBOL(get_free_pages);
+
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
 	zoneref->zone = zone;
-- 
1.8.3.1
