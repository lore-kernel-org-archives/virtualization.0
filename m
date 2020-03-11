From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 06/10] virtio-mem: Allow to offline partially unplugged memory blocks
Date: Wed, 11 Mar 2020 18:14:18 +0100
Message-ID: <20200311171422.10484-7-david@redhat.com>
References: <20200311171422.10484-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-6927-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200311171422.10484-1-david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

Dropping the reference count of PageOffline() pages during MEM_GOING_ONLI=
NE
allows offlining code to skip them. However, we also have to clear
PG_reserved, because PG_reserved pages get detected as unmovable right
away. Take care of restoring the reference count when offlining is
canceled.

Clarify why we don't have to perform any action when unloading the
driver. Also, let's add a warning if anybody is still holding a
reference to unplugged pages when offlining.

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
 drivers/virtio/virtio_mem.c | 68 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 5b26d57be551..35f20232770c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -570,6 +570,57 @@ static void virtio_mem_notify_online(struct virtio_m=
em *vm, unsigned long mb_id,
 		virtio_mem_retry(vm);
 }
=20
+static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
+					    unsigned long mb_id)
+{
+	const unsigned long nr_pages =3D PFN_DOWN(vm->subblock_size);
+	struct page *page;
+	unsigned long pfn;
+	int sb_id, i;
+
+	for (sb_id =3D 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
+		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+			continue;
+		/*
+		 * Drop our reference to the pages so the memory can get
+		 * offlined and add the unplugged pages to the managed
+		 * page counters (so offlining code can correctly subtract
+		 * them again).
+		 */
+		pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+			       sb_id * vm->subblock_size);
+		adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
+		for (i =3D 0; i < nr_pages; i++) {
+			page =3D pfn_to_page(pfn + i);
+			if (WARN_ON(!page_ref_dec_and_test(page)))
+				dump_page(page, "unplugged page referenced");
+		}
+	}
+}
+
+static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
+					     unsigned long mb_id)
+{
+	const unsigned long nr_pages =3D PFN_DOWN(vm->subblock_size);
+	unsigned long pfn;
+	int sb_id, i;
+
+	for (sb_id =3D 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
+		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+			continue;
+		/*
+		 * Get the reference we dropped when going offline and
+		 * subtract the unplugged pages from the managed page
+		 * counters.
+		 */
+		pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+			       sb_id * vm->subblock_size);
+		adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
+		for (i =3D 0; i < nr_pages; i++)
+			page_ref_inc(pfn_to_page(pfn + i));
+	}
+}
+
 /*
  * This callback will either be called synchronously from add_memory() o=
r
  * asynchronously (e.g., triggered via user space). We have to be carefu=
l
@@ -616,6 +667,7 @@ static int virtio_mem_memory_notifier_cb(struct notif=
ier_block *nb,
 			break;
 		}
 		vm->hotplug_active =3D true;
+		virtio_mem_notify_going_offline(vm, mb_id);
 		break;
 	case MEM_GOING_ONLINE:
 		mutex_lock(&vm->hotplug_mutex);
@@ -640,6 +692,12 @@ static int virtio_mem_memory_notifier_cb(struct noti=
fier_block *nb,
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
 	case MEM_CANCEL_OFFLINE:
+		if (!vm->hotplug_active)
+			break;
+		virtio_mem_notify_cancel_offline(vm, mb_id);
+		vm->hotplug_active =3D false;
+		mutex_unlock(&vm->hotplug_mutex);
+		break;
 	case MEM_CANCEL_ONLINE:
 		if (!vm->hotplug_active)
 			break;
@@ -666,8 +724,11 @@ static void virtio_mem_set_fake_offline(unsigned lon=
g pfn,
 		struct page *page =3D pfn_to_page(pfn);
=20
 		__SetPageOffline(page);
-		if (!onlined)
+		if (!onlined) {
 			SetPageDirty(page);
+			/* FIXME: remove after cleanups */
+			ClearPageReserved(page);
+		}
 	}
 }
=20
@@ -1717,6 +1778,11 @@ static void virtio_mem_remove(struct virtio_device=
 *vdev)
 		rc =3D virtio_mem_mb_remove(vm, mb_id);
 		BUG_ON(rc);
 	}
+	/*
+	 * After we unregistered our callbacks, user space can no longer
+	 * offline partially plugged online memory blocks. No need to worry
+	 * about them.
+	 */
=20
 	/* unregister callbacks */
 	unregister_virtio_mem_device(vm);
--=20
2.24.1
