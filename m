From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v4 13/13] virtio-mem: Drop slab objects when unplug
 continues to fail
Date: Thu, 12 Dec 2019 18:11:37 +0100
Message-ID: <20191212171137.13872-14-david__2415.1624691271$1576170829$gmane$org@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Pavel Tatashin <pasha.tatashin@soleen.com>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Start dropping slab objects after 30 minutes and repeat every 30 minutes
in case we can't unplug more memory using alloc_contig_range().
Log messages and make it configurable. Enable dropping slab objects as
default (especially, reclaimable slab objects that are not movable).

In the future, we might want to implement+use drop_slab_range(), which
will also come in handy for other users (e.g., offlining, gigantic huge
pages).

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 3a57434f92ed..8f25f7453a08 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -25,6 +25,11 @@ static bool unplug_online = true;
 module_param(unplug_online, bool, 0644);
 MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
 
+static bool drop_slab_objects = true;
+module_param(drop_slab_objects, bool, 0644);
+MODULE_PARM_DESC(drop_slab_objects,
+		 "Drop slab objects when unplug continues to fail");
+
 enum virtio_mem_mb_state {
 	/* Unplugged, not added to Linux. Can be reused later. */
 	VIRTIO_MEM_MB_STATE_UNUSED = 0,
@@ -1384,6 +1389,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
 	uint64_t nb_sb = diff / vm->subblock_size;
+	bool retried = false;
 	unsigned long mb_id;
 	int rc;
 
@@ -1421,6 +1427,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 		return 0;
 	}
 
+retry_locked:
 	/* Try to unplug subblocks of partially plugged online blocks. */
 	virtio_mem_for_each_mb_state(vm, mb_id,
 				     VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
@@ -1445,6 +1452,29 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	}
 
 	mutex_unlock(&vm->hotplug_mutex);
+
+	/*
+	 * If we can't unplug the requested amount of memory for a long time,
+	 * start freeing up memory in caches. This might harm performance,
+	 * is configurable, and we log a message. Retry imemdiately a second
+	 * time - then wait another VIRTIO_MEM_RETRY_TIMER_MAX_MS.
+	 */
+	if (nb_sb && !retried && drop_slab_objects &&
+	    vm->retry_timer_ms == VIRTIO_MEM_RETRY_TIMER_MAX_MS) {
+		if (vm->nid == NUMA_NO_NODE) {
+			dev_info(&vm->vdev->dev, "dropping all slab objects\n");
+			drop_slab();
+		} else {
+			dev_info(&vm->vdev->dev,
+				 "dropping all slab objects on node=%d\n",
+				 vm->nid);
+			drop_slab_node(vm->nid);
+		}
+		retried = true;
+		mutex_lock(&vm->hotplug_mutex);
+		goto retry_locked;
+	}
+
 	return nb_sb ? -EBUSY : 0;
 out_unlock:
 	mutex_unlock(&vm->hotplug_mutex);
-- 
2.23.0
