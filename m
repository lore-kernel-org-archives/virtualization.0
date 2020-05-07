From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 12/15] virtio-mem: Drop manual check for already present
 memory
Date: Thu,  7 May 2020 12:31:16 +0200
Message-ID: <20200507103119.11219-13-david@redhat.com>
References: <20200507103119.11219-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200507103119.11219-1-david@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Registering our parent resource will fail if any memory is still present
(e.g., because somebody unloaded the driver and tries to reload it). No
need for the manual check.

Move our "unplug all" handling to after registering the resource.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 55 ++++++++-----------------------------
 1 file changed, 12 insertions(+), 43 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 80cdb9e6b3c4..8dd57b61b09b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1616,23 +1616,6 @@ static int virtio_mem_init_vq(struct virtio_mem *vm)
 	return 0;
 }
 
-/*
- * Test if any memory in the range is present in Linux.
- */
-static bool virtio_mem_any_memory_present(unsigned long start,
-					  unsigned long size)
-{
-	const unsigned long start_pfn = PFN_DOWN(start);
-	const unsigned long end_pfn = PFN_UP(start + size);
-	unsigned long pfn;
-
-	for (pfn = start_pfn; pfn != end_pfn; pfn++)
-		if (present_section_nr(pfn_to_section_nr(pfn)))
-			return true;
-
-	return false;
-}
-
 static int virtio_mem_init(struct virtio_mem *vm)
 {
 	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
@@ -1664,32 +1647,6 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	virtio_cread(vm->vdev, struct virtio_mem_config, region_size,
 		     &vm->region_size);
 
-	/*
-	 * If we still have memory plugged, we might have to unplug all
-	 * memory first. However, if somebody simply unloaded the driver
-	 * we would have to reinitialize the old state - something we don't
-	 * support yet. Detect if we have any memory in the area present.
-	 */
-	if (vm->plugged_size) {
-		uint64_t usable_region_size;
-
-		virtio_cread(vm->vdev, struct virtio_mem_config,
-			     usable_region_size, &usable_region_size);
-
-		if (virtio_mem_any_memory_present(vm->addr,
-						  usable_region_size)) {
-			dev_err(&vm->vdev->dev,
-				"reloading the driver is not supported\n");
-			return -EINVAL;
-		}
-		/*
-		 * Note: it might happen that the device is busy and
-		 * unplugging all memory might take some time.
-		 */
-		dev_info(&vm->vdev->dev, "unplugging all memory required\n");
-		vm->unplug_all_required = 1;
-	}
-
 	/*
 	 * We always hotplug memory in memory block granularity. This way,
 	 * we have to wait for exactly one memory block to online.
@@ -1760,6 +1717,8 @@ static int virtio_mem_create_resource(struct virtio_mem *vm)
 	if (!vm->parent_resource) {
 		kfree(name);
 		dev_warn(&vm->vdev->dev, "could not reserve device region\n");
+		dev_info(&vm->vdev->dev,
+			 "reloading the driver is not supported\n");
 		return -EBUSY;
 	}
 
@@ -1816,6 +1775,16 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_del_vq;
 
+	/*
+	 * If we still have memory plugged, we have to unplug all memory first.
+	 * Registering our parent resource makes sure that this memory isn't
+	 * actually in use (e.g., trying to reload the driver).
+	 */
+	if (vm->plugged_size) {
+		vm->unplug_all_required = 1;
+		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
+	}
+
 	/* register callbacks */
 	vm->memory_notifier.notifier_call = virtio_mem_memory_notifier_cb;
 	rc = register_memory_notifier(&vm->memory_notifier);
-- 
2.25.3
