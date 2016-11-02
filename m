From: Liang Li <liang.z.li@intel.com>
Subject: [PATCH kernel v4 3/7] mm: add a function to get the max pfn
Date: Wed,  2 Nov 2016 14:17:23 +0800
Message-ID: <1478067447-24654-4-git-send-email-liang.z.li__36829.1617990055$1478068322$gmane$org@intel.com>
References: <1478067447-24654-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1478067447-24654-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, dave.hansen@intel.com
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Liang Li <liang.z.li@intel.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

Expose the function to get the max pfn, so it can be used in the
virtio-balloon device driver. Simply include the 'linux/bootmem.h'
is not enough, if the device driver is built to a module, directly
refer the max_pfn lead to build failed.

Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
---
 include/linux/mm.h |  1 +
 mm/page_alloc.c    | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a92c8d7..f47862a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1772,6 +1772,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 extern void free_area_init_node(int nid, unsigned long * zones_size,
 		unsigned long zone_start_pfn, unsigned long *zholes_size);
 extern void free_initmem(void);
+extern unsigned long get_max_pfn(void);
 
 /*
  * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8fd42aa..12cc8ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4428,6 +4428,16 @@ void show_free_areas(unsigned int filter)
 	show_swap_cache_info();
 }
 
+/*
+ * The max_pfn can change because of memory hot plug, so it's only good
+ * as a hint. e.g. for sizing data structures.
+ */
+unsigned long get_max_pfn(void)
+{
+	return max_pfn;
+}
+EXPORT_SYMBOL(get_max_pfn);
+
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
 	zoneref->zone = zone;
-- 
1.8.3.1
