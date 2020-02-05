From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Wed,  5 Feb 2020 17:34:02 +0100
Message-ID: <20200205163402.42627-4-david@redhat.com>
References: <20200205163402.42627-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200205163402.42627-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, David Hildenbrand <david@redhat.com>, Tyler Sanderson <tysand@google.com>, "Michael S . Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Rientjes <rientjes@google.com>, Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
changed the behavior when deflation happens automatically. Instead of
deflating when called by the OOM handler, the shrinker is used.

However, the balloon is not simply some slab cache that should be
shrunk when under memory pressure. The shrinker does not have a concept o=
f
priorities, so this behavior cannot be configured.

There was a report that this results in undesired side effects when
inflating the balloon to shrink the page cache. [1]
	"When inflating the balloon against page cache (i.e. no free memory
	 remains) vmscan.c will both shrink page cache, but also invoke the
	 shrinkers -- including the balloon's shrinker. So the balloon
	 driver allocates memory which requires reclaim, vmscan gets this
	 memory by shrinking the balloon, and then the driver adds the
	 memory back to the balloon. Basically a busy no-op."

The name "deflate on OOM" makes it pretty clear when deflation should
happen - after other approaches to reclaim memory failed, not while
reclaiming. This allows to minimize the footprint of a guest - memory
will only be taken out of the balloon when really needed.

Especially, a drop_slab() will result in the whole balloon getting
deflated - undesired. While handling it via the OOM handler might not be
perfect, it keeps existing behavior. If we want a different behavior, the=
n
we need a new feature bit and document it properly (although, there shoul=
d
be a clear use case and the intended effects should be well described).

Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
this has no such side effects. Always register the shrinker with
VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
pages that are still to be processed by the guest. The hypervisor takes
care of identifying and resolving possible races between processing a
hinting request and the guest reusing a page.

In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
notifier with shrinker"), don't add a moodule parameter to configure the
number of pages to deflate on OOM. Can be re-added if really needed.
Also, pay attention that leak_balloon() returns the number of 4k pages -
convert it properly in virtio_balloon_oom_notify().

Note1: using the OOM handler is frowned upon, but it really is what we
       need for this feature.

Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU) we
       could actually skip sending deflation requests to our hypervisor,
       making the OOM path *very* simple. Besically freeing pages and
       updating the balloon. If the communication with the host ever
       becomes a problem on this call path.

[1] https://www.spinics.net/lists/linux-virtualization/msg40863.html

Reported-by: Tyler Sanderson <tysand@google.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 107 +++++++++++++-------------------
 1 file changed, 44 insertions(+), 63 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
index 7e5d84caeb94..e7b18f556c5e 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/balloon_compaction.h>
+#include <linux/oom.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/mount.h>
@@ -27,7 +28,9 @@
  */
 #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >> VIRTIO_BAL=
LOON_PFN_SHIFT)
 #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
-#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
+/* Maximum number of (4k) pages to deflate on OOM notifications. */
+#define VIRTIO_BALLOON_OOM_NR_PAGES 256
+#define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80
=20
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWAR=
N | \
 					     __GFP_NOMEMALLOC)
@@ -112,8 +115,11 @@ struct virtio_balloon {
 	/* Memory statistics */
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
=20
-	/* To register a shrinker to shrink memory upon memory pressure */
+	/* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HINT */
 	struct shrinker shrinker;
+
+	/* OOM notifier to deflate on OOM - VIRTIO_BALLOON_F_DEFLATE_ON_OOM */
+	struct notifier_block oom_nb;
 };
=20
 static struct virtio_device_id id_table[] =3D {
@@ -786,50 +792,13 @@ static unsigned long shrink_free_pages(struct virti=
o_balloon *vb,
 	return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 }
=20
-static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
-                                          unsigned long pages_to_free)
-{
-	return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PAGE) =
/
-		VIRTIO_BALLOON_PAGES_PER_PAGE;
-}
-
-static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
-					  unsigned long pages_to_free)
-{
-	unsigned long pages_freed =3D 0;
-
-	/*
-	 * One invocation of leak_balloon can deflate at most
-	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
-	 * multiple times to deflate pages till reaching pages_to_free.
-	 */
-	while (vb->num_pages && pages_freed < pages_to_free)
-		pages_freed +=3D leak_balloon_pages(vb,
-						  pages_to_free - pages_freed);
-
-	update_balloon_size(vb);
-
-	return pages_freed;
-}
-
 static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrin=
ker,
 						  struct shrink_control *sc)
 {
-	unsigned long pages_to_free, pages_freed =3D 0;
 	struct virtio_balloon *vb =3D container_of(shrinker,
 					struct virtio_balloon, shrinker);
=20
-	pages_to_free =3D sc->nr_to_scan;
-
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
-		pages_freed =3D shrink_free_pages(vb, pages_to_free);
-
-	if (pages_freed >=3D pages_to_free)
-		return pages_freed;
-
-	pages_freed +=3D shrink_balloon_pages(vb, pages_to_free - pages_freed);
-
-	return pages_freed;
+	return shrink_free_pages(vb, sc->nr_to_scan);
 }
=20
 static unsigned long virtio_balloon_shrinker_count(struct shrinker *shri=
nker,
@@ -837,26 +806,22 @@ static unsigned long virtio_balloon_shrinker_count(=
struct shrinker *shrinker,
 {
 	struct virtio_balloon *vb =3D container_of(shrinker,
 					struct virtio_balloon, shrinker);
-	unsigned long count;
-
-	count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
-	count +=3D vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
=20
-	return count;
+	return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 }
=20
-static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb=
)
+static int virtio_balloon_oom_notify(struct notifier_block *nb,
+				     unsigned long dummy, void *parm)
 {
-	unregister_shrinker(&vb->shrinker);
-}
+	struct virtio_balloon *vb =3D container_of(nb,
+						 struct virtio_balloon, oom_nb);
+	unsigned long *freed =3D parm;
=20
-static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
-{
-	vb->shrinker.scan_objects =3D virtio_balloon_shrinker_scan;
-	vb->shrinker.count_objects =3D virtio_balloon_shrinker_count;
-	vb->shrinker.seeks =3D DEFAULT_SEEKS;
+	*freed +=3D leak_balloon(vb, VIRTIO_BALLOON_OOM_NR_PAGES) /
+		  VIRTIO_BALLOON_PAGES_PER_PAGE;
+	update_balloon_size(vb);
=20
-	return register_shrinker(&vb->shrinker);
+	return NOTIFY_OK;
 }
=20
 static int virtballoon_probe(struct virtio_device *vdev)
@@ -933,22 +898,35 @@ static int virtballoon_probe(struct virtio_device *=
vdev)
 			virtio_cwrite(vb->vdev, struct virtio_balloon_config,
 				      poison_val, &poison_val);
 		}
-	}
-	/*
-	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a
-	 * shrinker needs to be registered to relieve memory pressure.
-	 */
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
-		err =3D virtio_balloon_register_shrinker(vb);
+
+		/*
+		 * We're allowed to reuse any free pages, even if they are
+		 * still to be processed by the host.
+		 */
+		vb->shrinker.scan_objects =3D virtio_balloon_shrinker_scan;
+		vb->shrinker.count_objects =3D virtio_balloon_shrinker_count;
+		vb->shrinker.seeks =3D DEFAULT_SEEKS;
+		err =3D register_shrinker(&vb->shrinker);
 		if (err)
 			goto out_del_balloon_wq;
 	}
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
+		vb->oom_nb.notifier_call =3D virtio_balloon_oom_notify;
+		vb->oom_nb.priority =3D VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY;
+		err =3D register_oom_notifier(&vb->oom_nb);
+		if (err < 0)
+			goto out_unregister_shrinker;
+	}
+
 	virtio_device_ready(vdev);
=20
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	return 0;
=20
+out_unregister_shrinker:
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		unregister_shrinker(&vb->shrinker);
 out_del_balloon_wq:
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
@@ -987,8 +965,11 @@ static void virtballoon_remove(struct virtio_device =
*vdev)
 {
 	struct virtio_balloon *vb =3D vdev->priv;
=20
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-		virtio_balloon_unregister_shrinker(vb);
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		unregister_oom_notifier(&vb->oom_nb);
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		unregister_shrinker(&vb->shrinker);
+
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update =3D true;
 	spin_unlock_irq(&vb->stop_update_lock);
--=20
2.24.1
