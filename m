From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v4 08/13] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Date: Thu, 12 Dec 2019 18:11:32 +0100
Message-ID: <20191212171137.13872-9-david__49694.1696781263$1576170799$gmane$org@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Oscar Salvador <osalvador@suse.com>, virtio-dev@lists.oasis-open.org, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Dan Williams <dan.j.williams@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

virtio-mem wants to offline and remove a memory block once it unplugged
all subblocks (e.g., using alloc_contig_range()). Let's provide
an interface to do that from a driver. virtio-mem already supports to
offline partially unplugged memory blocks. Offlining a fully unplugged
memory block will not require to migrate any pages. All unplugged
subblocks are PageOffline() and have a reference count of 0 - so
offlining code will simply skip them.

All we need an interface to trigger the "offlining" and the removing in a
single operation - to make sure the memory block cannot get onlined by
user space again before it gets removed.

To keep things simple, allow to only work on a single memory block.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h |  1 +
 mm/memory_hotplug.c            | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ba0dca6aac6e..586f5c59c291 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -310,6 +310,7 @@ extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
+extern int offline_and_remove_memory(int nid, u64 start, u64 size);
 
 #else
 static inline bool is_mem_section_removable(unsigned long pfn,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index da01453a04e6..d04369e6d3cc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1825,4 +1825,39 @@ int remove_memory(int nid, u64 start, u64 size)
 	return rc;
 }
 EXPORT_SYMBOL_GPL(remove_memory);
+
+/*
+ * Try to offline and remove a memory block. Might take a long time to
+ * finish in case memory is still in use. Primarily useful for memory devices
+ * that logically unplugged all memory (so it's no longer in use) and want to
+ * offline + remove the memory block.
+ */
+int offline_and_remove_memory(int nid, u64 start, u64 size)
+{
+	struct memory_block *mem;
+	int rc = -EINVAL;
+
+	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
+	    size != memory_block_size_bytes())
+		return rc;
+
+	lock_device_hotplug();
+	mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
+	if (mem)
+		rc = device_offline(&mem->dev);
+	/* Ignore if the device is already offline. */
+	if (rc > 0)
+		rc = 0;
+
+	/*
+	 * In case we succeeded to offline the memory block, remove it.
+	 * This cannot fail as it cannot get onlined in the meantime.
+	 */
+	if (!rc && try_remove_memory(nid, start, size))
+		BUG();
+	unlock_device_hotplug();
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(offline_and_remove_memory);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
-- 
2.23.0
