From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v3 5/9] virtio-mem: Paravirtualized memory hotunplug part 2
Date: Thu, 19 Sep 2019 16:22:24 +0200
Message-ID: <20190919142228.5483-6-david__14196.6221200832$1568903033$gmane$org@redhat.com>
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

We can use alloc_contig_range() to try to unplug subblocks. Unplugged
blocks will be marked PG_offline, however, don't have the PG_reserved
flag set. This way, we can differentiate these allocated subblocks from
subblocks that were never onlined and handle them properly in
virtio_mem_fake_online(). free_contig_range() is used to hand back
subblocks to Linux.

It is worth noting that there are no guarantess on how much memory can
actually get unplugged again. All device memory might completely be
fragmented with unmovable data, such that no subblock can get unplugged.
We might want to improve the unplugging capability in the future.

We are not touching the ZONE_MOVABLE. If memory is onlined to the
ZONE_MOVABLE, it can only get unplugged after that memory was offlined
manually by user space. In normal operation, virtio-mem memory is
suggested to be onlined to ZONE_NORMAL. In the future, we will try to
make unplug more likely to succeed.

Future work:
- Offline + remove memory blocks once all subblocks were unplugged. This
  might then free up unmovable data un other memory blocks.
- Performance improvements:
-- Sense (lockless) if it make sense to try alloc_contig_range() at all
   before directly trying to isolate and taking locks.
-- Try to unplug bigger chunks if possible first.
-- Identify free areas first, that don't have to be evacuated.
- Make unplug more likely to succeed:
-- The "issue" is that in the ZONE_NORMAL, the buddy will randomly
   allocate memory. Only pageblocks somewhat limit fragmentation,
   however we would want to limit fragmentation on subblock granularity
   and even memory block granularity. One idea is to have a new
   ZONE_PREFER_MOVABLE. Memory blocks will then be onlined to ZONE_NORMAL
   / ZONE_PREFER_MOVABLE in a certain ratio per node (e.g.,
   1:4). This makes unplug of quite some memory likely to succeed in most
   setups. ZONE_PREFER_MOVABLE is then a mixture of ZONE_NORMAL and
   ZONE_MOVABlE. Especially, movable data can end up on that zone, but
   only if really required - avoiding running out of memory on ZONE
   imbalances. The zone fallback order would be
   MOVABLE=>PREFER_MOVABLE=>HIGHMEM=>NORMAL=>PREFER_MOVABLE=>DMA32=>DMA
-- Allocate memmap from added memory. This way, less unmovable data can
   end up on the memory blocks.
-- Call drop_slab() before trying to unplug. Eventually shrink other
   caches.
- Better retry handling in case memory is busy. We certainly don't want
  to try for ever in a short interval to try to get some memory back.
- OOM handling, e.g., via an OOM handler.

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
 drivers/virtio/Kconfig      |   1 +
 drivers/virtio/virtio_mem.c | 106 +++++++++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 294720d53057..75a760f32ec7 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -71,6 +71,7 @@ config VIRTIO_MEM
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG_SPARSE
 	depends on MEMORY_HOTREMOVE
+	select CONTIG_ALLOC
 	help
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 6fb55d4b6f6c..91052a37d10d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -689,7 +689,17 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
 	for (i = 0; i < nr_pages; i += 1 << order) {
 		struct page *page = pfn_to_page(pfn + i);
 
-		generic_online_page(page, order);
+		/*
+		 * If the page is reserved, it was kept fake-offline when
+		 * onlining the memory block. Otherwise, it was allocated
+		 * using alloc_contig_range().
+		 */
+		if (PageReserved(page))
+			generic_online_page(page, order);
+		else {
+			free_contig_range(pfn + i, 1 << order);
+			totalram_pages_add(1 << order);
+		}
 	}
 }
 
@@ -1187,6 +1197,72 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
 	return 0;
 }
 
+/*
+ * Unplug the desired number of plugged subblocks of an online memory block.
+ * Will skip subblock that are busy.
+ *
+ * Will modify the state of the memory block.
+ *
+ * Note: Can fail after some subblocks were successfully unplugged. Can
+ *       return 0 even if subblocks were busy and could not get unplugged.
+ */
+static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
+					      unsigned long mb_id,
+					      uint64_t *nb_sb)
+{
+	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
+	unsigned long start_pfn;
+	int rc, sb_id;
+
+	/*
+	 * TODO: To increase the performance we want to try bigger, consecutive
+	 * subblocks first before falling back to single subblocks. Also,
+	 * we should sense via something like is_mem_section_removable()
+	 * first if it makes sense to go ahead any try to allocate.
+	 */
+	for (sb_id = 0; sb_id < vm->nb_sb_per_mb && *nb_sb; sb_id++) {
+		/* Find the next candidate subblock */
+		while (sb_id < vm->nb_sb_per_mb &&
+		       !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+			sb_id++;
+		if (sb_id >= vm->nb_sb_per_mb)
+			break;
+
+		start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+				     sb_id * vm->subblock_size);
+		rc = alloc_contig_range(start_pfn, start_pfn + nr_pages,
+					MIGRATE_MOVABLE, GFP_KERNEL);
+		if (rc == -ENOMEM)
+			/* whoops, out of memory */
+			return rc;
+		if (rc)
+			/* memory busy, we can't unplug this chunk */
+			continue;
+
+		/* Mark it as fake-offline before unplugging it */
+		virtio_mem_set_fake_offline(start_pfn, nr_pages);
+		totalram_pages_add(-nr_pages);
+
+		/* Try to unplug the allocated memory */
+		rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, 1);
+		if (rc) {
+			/* Return the memory to the buddy. */
+			virtio_mem_fake_online(start_pfn, nr_pages);
+			return rc;
+		}
+
+		virtio_mem_mb_set_state(vm, mb_id,
+					VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
+		*nb_sb -= 1;
+	}
+
+	/*
+	 * TODO: Once all subblocks of a memory block were unplugged, we want
+	 * to offline the memory block and remove it.
+	 */
+	return 0;
+}
+
 /*
  * Try to unplug the requested amount of memory.
  */
@@ -1225,8 +1301,31 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 		cond_resched();
 	}
 
+	/* Try to unplug subblocks of partially plugged online blocks. */
+	virtio_mem_for_each_mb_state(vm, mb_id,
+				     VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
+		rc = virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
+							&nb_sb);
+		if (rc || !nb_sb)
+			goto out_unlock;
+		mutex_unlock(&vm->hotplug_mutex);
+		cond_resched();
+		mutex_lock(&vm->hotplug_mutex);
+	}
+
+	/* Try to unplug subblocks of plugged online blocks. */
+	virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_ONLINE) {
+		rc = virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
+							&nb_sb);
+		if (rc || !nb_sb)
+			goto out_unlock;
+		mutex_unlock(&vm->hotplug_mutex);
+		cond_resched();
+		mutex_lock(&vm->hotplug_mutex);
+	}
+
 	mutex_unlock(&vm->hotplug_mutex);
-	return 0;
+	return nb_sb ? -EBUSY : 0;
 out_unlock:
 	mutex_unlock(&vm->hotplug_mutex);
 	return rc;
@@ -1330,7 +1429,8 @@ static void virtio_mem_run_wq(struct work_struct *work)
 	case -EBUSY:
 		/*
 		 * The hypervisor cannot process our request right now
-		 * (e.g., out of memory, migrating).
+		 * (e.g., out of memory, migrating) or we cannot free up
+		 * any memory to unplug it (all plugged memory is busy).
 		 */
 	case -ENOMEM:
 		/* Out of memory, try again later. */
-- 
2.21.0
