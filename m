From: "Denis V. Lunev" <den@parallels.com>
Subject: [PATCH 2/2] virtio_balloon: free some memory from baloon on OOM
Date: Wed,  8 Oct 2014 14:21:09 +0400
Message-ID: <1412763669-2980-3-git-send-email-den@parallels.com>
References: <1412763669-2980-1-git-send-email-den@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412763669-2980-1-git-send-email-den@parallels.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: den@openvz.org, virtualization@lists.linux-foundation.org, Raushaniya Maksudova <rmaksudova@parallels.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Raushaniya Maksudova <rmaksudova@parallels.com>

Excessive virtio_balloon inflation can cause invocation of OOM-killer,
when Linux is under severe memory pressure. Various mechanisms are
responsible for correct virtio_balloon memory management. Nevertheless
it is often the case that these control tools does not have enough time
to react on fast changing memory load. As a result OS runs out of memory
and invokes OOM-killer. The balancing of memory by use of the virtio
balloon should not cause the termination of processes while there are
pages in the balloon. Now there is no way for virtio balloon driver to
free some memory at the last moment before some process will be get
killed by OOM-killer.

This does not provide a security breach as baloon itself is running
inside guest OS and is working in the cooperation with the host. Thus
some improvements from guest side should be considered as normal.

To solve the problem, introduce a virtio_balloon callback which is
expected to be called from the oom notifier call chain in out_of_memory()
function. If virtio balloon could release some memory, it will make
the system to return and retry the allocation that forced the out of
memory killer to run.

Signed-off-by: Raushaniya Maksudova <rmaksudova@parallels.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Rusty Russell <rusty@rustcorp.com.au>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: virtualization@lists.linux-foundation.org
---
 drivers/virtio/virtio_balloon.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 213da41..ca77831 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/balloon_compaction.h>
+#include <linux/oom.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -36,6 +37,12 @@
  */
 #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >> VIRTIO_BALLOON_PFN_SHIFT)
 #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
+#define OOM_VBALLOON_DEFAULT_PAGES 256
+#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
+
+static int oom_vballoon_pages = OOM_VBALLOON_DEFAULT_PAGES;
+module_param(oom_vballoon_pages, int, S_IRUSR | S_IWUSR);
+MODULE_PARM_DESC(oom_vballoon_pages, "pages to free on OOM");
 
 struct virtio_balloon
 {
@@ -71,6 +78,9 @@ struct virtio_balloon
 	/* Memory statistics */
 	int need_stats_update;
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
+
+	/* To register callback in oom notifier call chain */
+	struct notifier_block nb;
 };
 
 static struct virtio_device_id id_table[] = {
@@ -290,6 +300,33 @@ static void update_balloon_size(struct virtio_balloon *vb)
 		      &actual);
 }
 
+/*
+ * virtballoon_oom_notify - release pages when system is under severe
+ *                          memory pressure (called from out_of_memory())
+ * @self : notifier block struct
+ * @dummy: not used
+ * @parm : returned - number of freed pages
+ *
+ * The balancing of memory by use of the virtio balloon should not cause
+ * the termination of processes while there are pages in the balloon.
+ * If virtio balloon manages to release some memory, it will make the system
+ * return and retry the allocation that forced the OOM killer to run.
+ */
+static int virtballoon_oom_notify(struct notifier_block *self,
+				  unsigned long dummy, void *parm)
+{
+	unsigned int num_freed_pages;
+	unsigned long *freed = (unsigned long *)parm;
+	struct virtio_balloon *vb = container_of((struct notifier_block *)self,
+						 struct virtio_balloon, nb);
+
+	num_freed_pages = leak_balloon(vb, oom_vballoon_pages);
+	update_balloon_size(vb);
+	*freed += num_freed_pages;
+
+	return NOTIFY_OK;
+}
+
 static int balloon(void *_vballoon)
 {
 	struct virtio_balloon *vb = _vballoon;
@@ -474,6 +511,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_free_vb_mapping;
 
+	vb->nb.notifier_call = virtballoon_oom_notify;
+	vb->nb.priority = VIRTBALLOON_OOM_NOTIFY_PRIORITY;
+	err = register_oom_notifier(&vb->nb);
+	if (err < 0)
+		goto out_oom_notify;
+
 	vb->thread = kthread_run(balloon, vb, "vballoon");
 	if (IS_ERR(vb->thread)) {
 		err = PTR_ERR(vb->thread);
@@ -483,6 +526,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	return 0;
 
 out_del_vqs:
+	unregister_oom_notifier(&vb->nb);
+out_oom_notify:
 	vdev->config->del_vqs(vdev);
 out_free_vb_mapping:
 	balloon_mapping_free(vb_mapping);
@@ -511,6 +556,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 
+	unregister_oom_notifier(&vb->nb);
 	kthread_stop(vb->thread);
 	remove_common(vb);
 	balloon_mapping_free(vb->vb_dev_info->mapping);
-- 
1.9.1
