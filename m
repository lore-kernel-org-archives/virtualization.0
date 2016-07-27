From: Liang Li <liang.z.li@intel.com>
Subject: [PATCH v2 repost 6/7] mm: add the related functions to get free page
	info
Date: Wed, 27 Jul 2016 09:23:35 +0800
Message-ID: <1469582616-5729-7-git-send-email-liang.z.li__9455.99646443061$1469583145$gmane$org@intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, Liang Li <liang.z.li@intel.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, linux-mm@kvack.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

Save the free page info into a page bitmap, will be used in virtio
balloon device driver.

Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>
---
 mm/page_alloc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7da61ad..3ad8b10 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4523,6 +4523,52 @@ unsigned long get_max_pfn(void)
 }
 EXPORT_SYMBOL(get_max_pfn);
 
+static void mark_free_pages_bitmap(struct zone *zone, unsigned long start_pfn,
+	unsigned long end_pfn, unsigned long *bitmap, unsigned long len)
+{
+	unsigned long pfn, flags, page_num;
+	unsigned int order, t;
+	struct list_head *curr;
+
+	if (zone_is_empty(zone))
+		return;
+	end_pfn = min(start_pfn + len, end_pfn);
+	spin_lock_irqsave(&zone->lock, flags);
+
+	for_each_migratetype_order(order, t) {
+		list_for_each(curr, &zone->free_area[order].free_list[t]) {
+			pfn = page_to_pfn(list_entry(curr, struct page, lru));
+			if (pfn >= start_pfn && pfn <= end_pfn) {
+				page_num = 1UL << order;
+				if (pfn + page_num > end_pfn)
+					page_num = end_pfn - pfn;
+				bitmap_set(bitmap, pfn - start_pfn, page_num);
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
+int get_free_pages(unsigned long start_pfn, unsigned long end_pfn,
+		unsigned long *bitmap, unsigned long len)
+{
+	struct zone *zone;
+	int ret = 0;
+
+	if (bitmap == NULL || start_pfn > end_pfn || start_pfn >= max_pfn)
+		return 0;
+	if (end_pfn < max_pfn)
+		ret = 1;
+	if (end_pfn >= max_pfn)
+		ret = 0;
+
+	for_each_populated_zone(zone)
+		mark_free_pages_bitmap(zone, start_pfn, end_pfn, bitmap, len);
+	return ret;
+}
+EXPORT_SYMBOL(get_free_pages);
+
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
 	zoneref->zone = zone;
-- 
1.9.1
