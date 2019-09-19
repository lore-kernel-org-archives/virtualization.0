From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v3 3/9] virtio-mem: Paravirtualized memory hotunplug part 1
Date: Thu, 19 Sep 2019 16:22:22 +0200
Message-ID: <20190919142228.5483-4-david__38561.9865659223$1568903011$gmane$org@redhat.com>
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

Unplugging subblocks of memory blocks that are offline is easy. All we
have to do is watch out for concurrent onlining acticity.

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
 drivers/virtio/virtio_mem.c | 109 +++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 597fab4933f6..6fb55d4b6f6c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -119,7 +119,7 @@ struct virtio_mem {
 	 *
 	 * When this lock is held the pointers can't change, ONLINE and
 	 * OFFLINE blocks can't change the state and no subblocks will get
-	 * plugged.
+	 * plugged/unplugged.
 	 */
 	struct mutex hotplug_mutex;
 	bool hotplug_active;
@@ -322,6 +322,19 @@ static bool virtio_mem_mb_test_sb_plugged(struct virtio_mem *vm,
 	       bit + count;
 }
 
+/*
+ * Test if all selected subblocks are unplugged.
+ */
+static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
+					    unsigned long mb_id, int sb_id,
+					    int count)
+{
+	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+
+	/* TODO: Helper similar to bitmap_set() */
+	return find_next_bit(vm->sb_bitmap, bit + count, bit) >= bit + count;
+}
+
 /*
  * Find the first plugged subblock. Returns vm->nb_sb_per_mb in case there is
  * none.
@@ -512,6 +525,9 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 		BUG();
 		break;
 	}
+
+	/* trigger the workqueue, maybe we can now unplug memory. */
+	virtio_mem_retry(vm);
 }
 
 static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id,
@@ -1129,6 +1145,93 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 	return rc;
 }
 
+/*
+ * Unplug the desired number of plugged subblocks of an offline memory block.
+ * Will fail if any subblock cannot get unplugged (instead of skipping it).
+ *
+ * Will modify the state of the memory block. Might temporarily drop the
+ * hotplug_mutex.
+ *
+ * Note: Can fail after some subblocks were successfully unplugged.
+ */
+static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
+					       unsigned long mb_id,
+					       uint64_t *nb_sb)
+{
+	int rc;
+
+	rc = virtio_mem_mb_unplug_any_sb(vm, mb_id, nb_sb);
+
+	/* some subblocks might have been unplugged even on failure */
+	if (!virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
+		virtio_mem_mb_set_state(vm, mb_id,
+					VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL);
+	if (rc)
+		return rc;
+
+	if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+		/*
+		 * Remove the block from Linux - this should never fail.
+		 * Hinder the block from getting onlined by marking it
+		 * unplugged. Temporarily drop the mutex, so
+		 * any pending GOING_ONLINE requests can be serviced/rejected.
+		 */
+		virtio_mem_mb_set_state(vm, mb_id,
+					VIRTIO_MEM_MB_STATE_UNUSED);
+
+		mutex_unlock(&vm->hotplug_mutex);
+		rc = virtio_mem_mb_remove(vm, mb_id);
+		BUG_ON(rc);
+		mutex_lock(&vm->hotplug_mutex);
+	}
+	return 0;
+}
+
+/*
+ * Try to unplug the requested amount of memory.
+ */
+static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
+{
+	uint64_t nb_sb = diff / vm->subblock_size;
+	unsigned long mb_id;
+	int rc;
+
+	if (!nb_sb)
+		return 0;
+
+	/*
+	 * We'll drop the mutex a couple of times when it is safe to do so.
+	 * This might result in some blocks switching the state (online/offline)
+	 * and we could miss them in this run - we will retry again later.
+	 */
+	mutex_lock(&vm->hotplug_mutex);
+
+	/* Try to unplug subblocks of partially plugged offline blocks. */
+	virtio_mem_for_each_mb_state(vm, mb_id,
+				     VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL) {
+		rc = virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
+							 &nb_sb);
+		if (rc || !nb_sb)
+			goto out_unlock;
+		cond_resched();
+	}
+
+	/* Try to unplug subblocks of plugged offline blocks. */
+	virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_OFFLINE) {
+		rc = virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
+							 &nb_sb);
+		if (rc || !nb_sb)
+			goto out_unlock;
+		cond_resched();
+	}
+
+	mutex_unlock(&vm->hotplug_mutex);
+	return 0;
+out_unlock:
+	mutex_unlock(&vm->hotplug_mutex);
+	return rc;
+}
+
 /*
  * Try to unplug all blocks that couldn't be unplugged before, for example,
  * because the hypervisor was busy.
@@ -1209,8 +1312,10 @@ static void virtio_mem_run_wq(struct work_struct *work)
 		if (vm->requested_size > vm->plugged_size) {
 			diff = vm->requested_size - vm->plugged_size;
 			rc = virtio_mem_plug_request(vm, diff);
+		} else {
+			diff = vm->plugged_size - vm->requested_size;
+			rc = virtio_mem_unplug_request(vm, diff);
 		}
-		/* TODO: try to unplug memory */
 	}
 
 	switch (rc) {
-- 
2.21.0
