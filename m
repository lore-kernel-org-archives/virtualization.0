From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 11/15] virtio-mem: Add parent resource for all added "System RAM"
Date: Thu,  7 May 2020 12:31:15 +0200
Message-ID: <20200507103119.11219-12-david@redhat.com>
References: <20200507103119.11219-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-7249-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200507103119.11219-1-david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Let's add a parent resource, named after the virtio device (inspired by
drivers/dax/kmem.c). This allows user space to identify which memory
belongs to which virtio-mem device.

With this change and two virtio-mem devices:
	:/# cat /proc/iomem
	00000000-00000fff : Reserved
	00001000-0009fbff : System RAM
	[...]
	140000000-333ffffff : virtio0
	  140000000-147ffffff : System RAM
	  148000000-14fffffff : System RAM
	  150000000-157ffffff : System RAM
	[...]
	334000000-3033ffffff : virtio1
	  338000000-33fffffff : System RAM
	  340000000-347ffffff : System RAM
	  348000000-34fffffff : System RAM
	[...]

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 52 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index eb4c16d634e0..80cdb9e6b3c4 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -99,6 +99,9 @@ struct virtio_mem {
 	/* Id of the next memory bock to prepare when needed. */
 	unsigned long next_mb_id;
=20
+	/* The parent resource for all memory added via this device. */
+	struct resource *parent_resource;
+
 	/* Summary of all memory block states. */
 	unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
 #define VIRTIO_MEM_NB_OFFLINE_THRESHOLD		10
@@ -1741,6 +1744,44 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	return 0;
 }
=20
+static int virtio_mem_create_resource(struct virtio_mem *vm)
+{
+	/*
+	 * When force-unloading the driver and removing the device, we
+	 * could have a garbage pointer. Duplicate the string.
+	 */
+	const char *name =3D kstrdup(dev_name(&vm->vdev->dev), GFP_KERNEL);
+
+	if (!name)
+		return -ENOMEM;
+
+	vm->parent_resource =3D __request_mem_region(vm->addr, vm->region_size,
+						   name, IORESOURCE_SYSTEM_RAM);
+	if (!vm->parent_resource) {
+		kfree(name);
+		dev_warn(&vm->vdev->dev, "could not reserve device region\n");
+		return -EBUSY;
+	}
+
+	/* The memory is not actually busy - make add_memory() work. */
+	vm->parent_resource->flags &=3D ~IORESOURCE_BUSY;
+	return 0;
+}
+
+static void virtio_mem_delete_resource(struct virtio_mem *vm)
+{
+	const char *name;
+
+	if (!vm->parent_resource)
+		return;
+
+	name =3D vm->parent_resource->name;
+	release_resource(vm->parent_resource);
+	kfree(vm->parent_resource);
+	kfree(name);
+	vm->parent_resource =3D NULL;
+}
+
 static int virtio_mem_probe(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm;
@@ -1770,11 +1811,16 @@ static int virtio_mem_probe(struct virtio_device =
*vdev)
 	if (rc)
 		goto out_del_vq;
=20
+	/* create the parent resource for all memory */
+	rc =3D virtio_mem_create_resource(vm);
+	if (rc)
+		goto out_del_vq;
+
 	/* register callbacks */
 	vm->memory_notifier.notifier_call =3D virtio_mem_memory_notifier_cb;
 	rc =3D register_memory_notifier(&vm->memory_notifier);
 	if (rc)
-		goto out_del_vq;
+		goto out_del_resource;
 	rc =3D register_virtio_mem_device(vm);
 	if (rc)
 		goto out_unreg_mem;
@@ -1788,6 +1834,8 @@ static int virtio_mem_probe(struct virtio_device *v=
dev)
 	return 0;
 out_unreg_mem:
 	unregister_memory_notifier(&vm->memory_notifier);
+out_del_resource:
+	virtio_mem_delete_resource(vm);
 out_del_vq:
 	vdev->config->del_vqs(vdev);
 out_free_vm:
@@ -1848,6 +1896,8 @@ static void virtio_mem_remove(struct virtio_device =
*vdev)
 	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL] ||
 	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE])
 		dev_warn(&vdev->dev, "device still has system memory added\n");
+	else
+		virtio_mem_delete_resource(vm);
=20
 	/* remove all tracking data - no locking needed */
 	vfree(vm->mb_state);
--=20
2.25.3
