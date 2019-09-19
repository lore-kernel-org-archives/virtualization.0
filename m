From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v3 9/9] virtio-mem: Offline and remove completely
	unplugged memory blocks
Date: Thu, 19 Sep 2019 16:22:28 +0200
Message-ID: <20190919142228.5483-10-david__37913.3821510308$1568903069$gmane$org@redhat.com>
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

Let's offline+remove memory blocks once all subblocks are unplugged. We
can use the new Linux MM interface for that. As no memory is in use
anymore, this shouldn't take a long time and shouldn't fail. There might
be corner cases where the offlining could still fail (especially, if
another notifier NACKs the offlining request).

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
 drivers/virtio/virtio_mem.c | 39 ++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 9cb31459b211..01d5fc784d5d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -433,6 +433,28 @@ static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 	return remove_memory(nid, addr, memory_block_size_bytes());
 }
 
+/*
+ * Try to offline and remove a memory block from Linux.
+ *
+ * Must not be called with the vm->hotplug_mutex held (possible deadlock with
+ * onlining code).
+ *
+ * Will not modify the state of the memory block.
+ */
+static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
+					    unsigned long mb_id)
+{
+	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	int nid = vm->nid;
+
+	if (nid == NUMA_NO_NODE)
+		nid = memory_add_physaddr_to_nid(addr);
+
+	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
+		mb_id);
+	return offline_and_remove_memory(nid, addr, memory_block_size_bytes());
+}
+
 /*
  * Trigger the workqueue so the device can perform its magic.
  */
@@ -1263,7 +1285,8 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
  * Unplug the desired number of plugged subblocks of an online memory block.
  * Will skip subblock that are busy.
  *
- * Will modify the state of the memory block.
+ * Will modify the state of the memory block. Might temporarily drop the
+ * hotplug_mutex.
  *
  * Note: Can fail after some subblocks were successfully unplugged. Can
  *       return 0 even if subblocks were busy and could not get unplugged.
@@ -1319,9 +1342,19 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 	}
 
 	/*
-	 * TODO: Once all subblocks of a memory block were unplugged, we want
-	 * to offline the memory block and remove it.
+	 * Once all subblocks of a memory block were unplugged, offline and
+	 * remove it. This will usually not fail, as no memory is in use
+	 * anymore - however some other notifiers might NACK the request.
 	 */
+	if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+		mutex_unlock(&vm->hotplug_mutex);
+		rc = virtio_mem_mb_offline_and_remove(vm, mb_id);
+		mutex_lock(&vm->hotplug_mutex);
+		if (!rc)
+			virtio_mem_mb_set_state(vm, mb_id,
+						VIRTIO_MEM_MB_STATE_UNUSED);
+	}
+
 	return 0;
 }
 
-- 
2.21.0
