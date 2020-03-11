From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 08/10] virtio-mem: Offline and remove completely unplugged memory blocks
Date: Wed, 11 Mar 2020 18:14:20 +0100
Message-ID: <20200311171422.10484-9-david@redhat.com>
References: <20200311171422.10484-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-6929-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200311171422.10484-1-david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
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
 drivers/virtio/virtio_mem.c | 47 +++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 35f20232770c..aa322e7732a4 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -443,6 +443,28 @@ static int virtio_mem_mb_remove(struct virtio_mem *v=
m, unsigned long mb_id)
 	return remove_memory(nid, addr, memory_block_size_bytes());
 }
=20
+/*
+ * Try to offline and remove a memory block from Linux.
+ *
+ * Must not be called with the vm->hotplug_mutex held (possible deadlock=
 with
+ * onlining code).
+ *
+ * Will not modify the state of the memory block.
+ */
+static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
+					    unsigned long mb_id)
+{
+	const uint64_t addr =3D virtio_mem_mb_id_to_phys(mb_id);
+	int nid =3D vm->nid;
+
+	if (nid =3D=3D NUMA_NO_NODE)
+		nid =3D memory_add_physaddr_to_nid(addr);
+
+	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
+		mb_id);
+	return offline_and_remove_memory(nid, addr, memory_block_size_bytes());
+}
+
 /*
  * Trigger the workqueue so the device can perform its magic.
  */
@@ -535,7 +557,13 @@ static void virtio_mem_notify_offline(struct virtio_=
mem *vm,
 		break;
 	}
=20
-	/* trigger the workqueue, maybe we can now unplug memory. */
+	/*
+	 * Trigger the workqueue, maybe we can now unplug memory. Also,
+	 * when we offline and remove a memory block, this will re-trigger
+	 * us immediately - which is often nice because the removal of
+	 * the memory block (e.g., memmap) might have freed up memory
+	 * on other memory blocks we manage.
+	 */
 	virtio_mem_retry(vm);
 }
=20
@@ -1282,7 +1310,8 @@ static int virtio_mem_mb_unplug_any_sb_offline(stru=
ct virtio_mem *vm,
  * Unplug the desired number of plugged subblocks of an online memory bl=
ock.
  * Will skip subblock that are busy.
  *
- * Will modify the state of the memory block.
+ * Will modify the state of the memory block. Might temporarily drop the
+ * hotplug_mutex.
  *
  * Note: Can fail after some subblocks were successfully unplugged. Can
  *       return 0 even if subblocks were busy and could not get unplugge=
d.
@@ -1338,9 +1367,19 @@ static int virtio_mem_mb_unplug_any_sb_online(stru=
ct virtio_mem *vm,
 	}
=20
 	/*
-	 * TODO: Once all subblocks of a memory block were unplugged, we want
-	 * to offline the memory block and remove it.
+	 * Once all subblocks of a memory block were unplugged, offline and
+	 * remove it. This will usually not fail, as no memory is in use
+	 * anymore - however some other notifiers might NACK the request.
 	 */
+	if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+		mutex_unlock(&vm->hotplug_mutex);
+		rc =3D virtio_mem_mb_offline_and_remove(vm, mb_id);
+		mutex_lock(&vm->hotplug_mutex);
+		if (!rc)
+			virtio_mem_mb_set_state(vm, mb_id,
+						VIRTIO_MEM_MB_STATE_UNUSED);
+	}
+
 	return 0;
 }
=20
--=20
2.24.1
