From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 2/2] virtio_balloon: Allow to resize and update the balloon
	stats in parallel
Date: Mon, 25 Jan 2016 17:38:06 +0100
Message-ID: <1453739886-29458-3-git-send-email-pmladek@suse.com>
References: <1453739886-29458-1-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453739886-29458-1-git-send-email-pmladek@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

The virtio balloon statistics are not updated when the balloon
is being resized. But it seems that both tasks could be done
in parallel.

stats_handle_request() updates the statistics in the balloon
structure and then communicates with the host.

update_balloon_stats() calls all_vm_events() that just reads
some per-CPU variables. The values might change during and
after the call but it is expected and happens even without
this patch.

update_balloon_stats() also calls si_meminfo(). It is a bit
more complex function. It too just reads some variables and
looks lock-less safe. In each case, it seems to be called
lock-less on several similar locations, e.g. from post_status()
in dm_thread_func(), or from vmballoon_send_get_target().

The communication with the host is done via a separate virtqueue,
see vb->stats_vq vs. vb->inflate_vq and vb->deflate_vq. Therefore
it could be used in parallel with fill_balloon() and leak_balloon().

This patch splits the existing work into two pieces. One is for
updating the balloon stats. The other is for resizing of the balloon.
It seems that they can be proceed in parallel without any
extra locking.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/virtio/virtio_balloon.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 2c9a92f1e525..9057cc768ca5 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -49,7 +49,8 @@ struct virtio_balloon {
 	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq;
 
 	/* The balloon servicing is delegated to a freezable workqueue. */
-	struct work_struct work;
+	struct work_struct update_balloon_stats_work;
+	struct work_struct update_balloon_size_work;
 
 	/* Prevent updating balloon when it is being canceled. */
 	spinlock_t stop_update_lock;
@@ -76,7 +77,6 @@ struct virtio_balloon {
 	u32 pfns[VIRTIO_BALLOON_ARRAY_PFNS_MAX];
 
 	/* Memory statistics */
-	int need_stats_update;
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
 
 	/* To register callback in oom notifier call chain */
@@ -123,6 +123,7 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 
 	/* When host has read buffer, this completes via balloon_ack */
 	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
+
 }
 
 static void set_page_pfns(u32 pfns[], struct page *page)
@@ -262,11 +263,9 @@ static void stats_request(struct virtqueue *vq)
 {
 	struct virtio_balloon *vb = vq->vdev->priv;
 
-	vb->need_stats_update = 1;
-
 	spin_lock(&vb->stop_update_lock);
 	if (!vb->stop_update)
-		queue_work(system_freezable_wq, &vb->work);
+		queue_work(system_freezable_wq, &vb->update_balloon_stats_work);
 	spin_unlock(&vb->stop_update_lock);
 }
 
@@ -276,7 +275,6 @@ static void stats_handle_request(struct virtio_balloon *vb)
 	struct scatterlist sg;
 	unsigned int len;
 
-	vb->need_stats_update = 0;
 	update_balloon_stats(vb);
 
 	vq = vb->stats_vq;
@@ -294,7 +292,7 @@ static void virtballoon_changed(struct virtio_device *vdev)
 
 	spin_lock_irqsave(&vb->stop_update_lock, flags);
 	if (!vb->stop_update)
-		queue_work(system_freezable_wq, &vb->work);
+		queue_work(system_freezable_wq, &vb->update_balloon_size_work);
 	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
 }
 
@@ -358,17 +356,24 @@ static int virtballoon_oom_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static void balloon(struct work_struct *work)
+static void update_balloon_stats_func(struct work_struct *work)
+{
+	struct virtio_balloon *vb;
+
+	vb = container_of(work, struct virtio_balloon,
+			  update_balloon_stats_work);
+	stats_handle_request(vb);
+}
+
+static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
 	s64 diff;
 
-	vb = container_of(work, struct virtio_balloon, work);
+	vb = container_of(work, struct virtio_balloon,
+			  update_balloon_size_work);
 	diff = towards_target(vb);
 
-	if (vb->need_stats_update)
-		stats_handle_request(vb);
-
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
 	else if (diff < 0)
@@ -494,14 +499,14 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		goto out;
 	}
 
-	INIT_WORK(&vb->work, balloon);
+	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
+	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
 	spin_lock_init(&vb->stop_update_lock);
 	vb->stop_update = false;
 	vb->num_pages = 0;
 	mutex_init(&vb->balloon_lock);
 	init_waitqueue_head(&vb->acked);
 	vb->vdev = vdev;
-	vb->need_stats_update = 0;
 
 	balloon_devinfo_init(&vb->vb_dev_info);
 #ifdef CONFIG_BALLOON_COMPACTION
@@ -552,7 +557,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update = true;
 	spin_unlock_irq(&vb->stop_update_lock);
-	cancel_work_sync(&vb->work);
+	cancel_work_sync(&vb->update_balloon_size_work);
+	cancel_work_sync(&vb->update_balloon_stats_work);
 
 	remove_common(vb);
 	kfree(vb);
-- 
1.8.5.6
