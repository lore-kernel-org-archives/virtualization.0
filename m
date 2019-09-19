From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v3 7/9] virtio-mem: Allow to offline partially unplugged
	memory blocks
Date: Thu, 19 Sep 2019 16:22:26 +0200
Message-ID: <20190919142228.5483-8-david__18012.6650653378$1568903049$gmane$org@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190919142228.5483-1-david@redhat.com>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Dropping the reference count of PageOffline() pages allows offlining
code to skip them. However, we also have to convert PG_reserved to
another flag - let's use PG_dirty - so has_unmovable_pages() will
properly handle them. PG_reserved pages get detected as unmovable right
away.

We need the flag to see if we are onlining pages the first time, or if
we allocated them via alloc_contig_range().

Properly take care of offlining code also modifying the stats and
special handling in case the driver gets unloaded.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 102 ++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 91052a37d10d..9cb31459b211 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -561,6 +561,30 @@ static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id,
 		virtio_mem_retry(vm);
 }
 
+/*
+ * When we unplug subblocks, we already modify stats (e.g., subtract them
+ * from totalram_pages). Offlining code will modify the stats, too. So
+ * properly fixup the stats when GOING_OFFLINE and revert that when
+ * CANCEL_OFFLINE.
+ */
+static void virtio_mem_mb_going_offline_fixup_stats(struct virtio_mem *vm,
+						    unsigned long mb_id,
+						    bool cancel)
+{
+	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
+	int sb_id;
+
+	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
+		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+			continue;
+
+		if (cancel)
+			totalram_pages_add(-nr_pages);
+		else
+			totalram_pages_add(nr_pages);
+	}
+}
+
 /*
  * This callback will either be called synchonously from add_memory() or
  * asynchronously (e.g., triggered via user space). We have to be careful
@@ -608,6 +632,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 			mutex_lock(&vm->hotplug_mutex);
 			vm->hotplug_active = true;
 		}
+		virtio_mem_mb_going_offline_fixup_stats(vm, mb_id, false);
 		break;
 	case MEM_GOING_ONLINE:
 		spin_lock_irq(&vm->removal_lock);
@@ -633,6 +658,8 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
 	case MEM_CANCEL_OFFLINE:
+		virtio_mem_mb_going_offline_fixup_stats(vm, mb_id, true);
+		/* fall through */
 	case MEM_CANCEL_ONLINE:
 		/* We might not get a MEM_GOING* if somebody else canceled */
 		if (vm->hotplug_active) {
@@ -648,23 +675,55 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 }
 
 /*
- * Set a range of pages PG_offline.
+ * Convert PG_reserved to PG_dirty. Needed to allow isolation code to
+ * not immediately consider them as unmovable.
+ */
+static void virtio_mem_reserved_to_dirty(unsigned long pfn,
+					 unsigned int nr_pages)
+{
+	for (; nr_pages--; pfn++) {
+		SetPageDirty(pfn_to_page(pfn));
+		ClearPageReserved(pfn_to_page(pfn));
+	}
+}
+
+/*
+ * Convert PG_dirty to PG_reserved. Needed so generic_online_page()
+ * works correctly.
+ */
+static void virtio_mem_dirty_to_reserved(unsigned long pfn,
+					 unsigned int nr_pages)
+{
+	for (; nr_pages--; pfn++) {
+		SetPageReserved(pfn_to_page(pfn));
+		ClearPageDirty(pfn_to_page(pfn));
+	}
+}
+
+/*
+ * Set a range of pages PG_offline and drop the reference. The dropped
+ * reference (0) and the flag allows isolation code to isolate this range
+ * and offline code to offline it.
  */
 static void virtio_mem_set_fake_offline(unsigned long pfn,
 					unsigned int nr_pages)
 {
-	for (; nr_pages--; pfn++)
+	for (; nr_pages--; pfn++) {
 		__SetPageOffline(pfn_to_page(pfn));
+		page_ref_dec(pfn_to_page(pfn));
+	}
 }
 
 /*
- * Clear PG_offline from a range of pages.
+ * Get a reference and clear PG_offline from a range of pages.
  */
 static void virtio_mem_clear_fake_offline(unsigned long pfn,
 					  unsigned int nr_pages)
 {
-	for (; nr_pages--; pfn++)
+	for (; nr_pages--; pfn++) {
+		page_ref_inc(pfn_to_page(pfn));
 		__ClearPageOffline(pfn_to_page(pfn));
+	}
 }
 
 /*
@@ -679,7 +738,7 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
 	/*
 	 * We are always called with subblock granularity, which is at least
 	 * aligned to MAX_ORDER - 1. All pages in a subblock are either
-	 * reserved or not.
+	 * PG_dirty (converted PG_reserved) or not.
 	 */
 	BUG_ON(!IS_ALIGNED(pfn, 1 << order));
 	BUG_ON(!IS_ALIGNED(nr_pages, 1 << order));
@@ -690,13 +749,14 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
 		struct page *page = pfn_to_page(pfn + i);
 
 		/*
-		 * If the page is reserved, it was kept fake-offline when
+		 * If the page is PG_dirty, it was kept fake-offline when
 		 * onlining the memory block. Otherwise, it was allocated
 		 * using alloc_contig_range().
 		 */
-		if (PageReserved(page))
+		if (PageDirty(page)) {
+			virtio_mem_dirty_to_reserved(pfn + i, 1 << order);
 			generic_online_page(page, order);
-		else {
+		} else {
 			free_contig_range(pfn + i, 1 << order);
 			totalram_pages_add(1 << order);
 		}
@@ -728,8 +788,10 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 		 */
 		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
 			generic_online_page(page, order);
-		else
+		else {
 			virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order);
+			virtio_mem_reserved_to_dirty(PFN_DOWN(addr), 1 << order);
+		}
 		rcu_read_unlock();
 		return;
 	}
@@ -1674,7 +1736,8 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 static void virtio_mem_remove(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm = vdev->priv;
-	unsigned long mb_id;
+	unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
+	unsigned long pfn, mb_id, sb_id;
 	int rc;
 
 	/*
@@ -1701,6 +1764,25 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 		BUG_ON(rc);
 		mutex_lock(&vm->hotplug_mutex);
 	}
+	/*
+	 * After we unregistered our callbacks, user space can offline +
+	 * re-online partially plugged online blocks. Make sure they can't
+	 * get offlined by getting a reference. Also, restore PG_reserved.
+	 */
+	virtio_mem_for_each_mb_state(vm, mb_id,
+				     VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
+		for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
+			if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+				continue;
+			pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+			      sb_id * vm->subblock_size);
+
+			if (PageDirty(pfn_to_page(pfn)))
+				virtio_mem_dirty_to_reserved(pfn, nr_pages);
+			for (; nr_pages--; pfn++)
+				page_ref_inc(pfn_to_page(pfn));
+		}
+	}
 	mutex_unlock(&vm->hotplug_mutex);
 
 	/* unregister callbacks */
-- 
2.21.0
