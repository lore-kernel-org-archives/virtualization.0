From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 1/2] virtio_balloon: Use a workqueue instead of "vballoon"
	kthread
Date: Mon, 25 Jan 2016 17:38:05 +0100
Message-ID: <1453739886-29458-2-git-send-email-pmladek@suse.com>
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
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.cz>, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

This patch moves the deferred work from the "vballoon" kthread into a
system freezable workqueue.

We do not need to maintain and run a dedicated kthread. Also the event
driven workqueues API makes the logic much easier. Especially, we do
not longer need an own wait queue, wait function, and freeze point.

The conversion is pretty straightforward. One cycle of the main loop
is put into a work. The work is queued instead of waking the kthread.

fill_balloon() and leak_balloon() have a limit for the amount of modified
pages. The work re-queues itself when necessary. For this, we make
fill_balloon() to return the number of really modified pages.
Note that leak_balloon() already did this.

virtballoon_restore() queues the work only when really needed.

The only complication is that we need to prevent queuing the work
when the balloon is being removed. It was easier before because the
kthread simply removed itself from the wait queue. We need an
extra boolean and spin lock now.

My initial idea was to use a dedicated workqueue. Michael S. Tsirkin
suggested using a system one. Tejun Heo confirmed that the system
workqueue has a pretty high concurrency level (256) by default.
Therefore we need not be afraid of too long blocking.

Signed-off-by: Petr Mladek <pmladek@suse.cz>
---
 drivers/virtio/virtio_balloon.c | 108 +++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 57 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 0c3691f46575..2c9a92f1e525 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -22,8 +22,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
-#include <linux/kthread.h>
-#include <linux/freezer.h>
+#include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -49,11 +48,12 @@ struct virtio_balloon {
 	struct virtio_device *vdev;
 	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq;
 
-	/* Where the ballooning thread waits for config to change. */
-	wait_queue_head_t config_change;
+	/* The balloon servicing is delegated to a freezable workqueue. */
+	struct work_struct work;
 
-	/* The thread servicing the balloon. */
-	struct task_struct *thread;
+	/* Prevent updating balloon when it is being canceled. */
+	spinlock_t stop_update_lock;
+	bool stop_update;
 
 	/* Waiting for host to ack the pages we released. */
 	wait_queue_head_t acked;
@@ -135,9 +135,10 @@ static void set_page_pfns(u32 pfns[], struct page *page)
 		pfns[i] = page_to_balloon_pfn(page) + i;
 }
 
-static void fill_balloon(struct virtio_balloon *vb, size_t num)
+static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 {
 	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
+	unsigned num_allocated_pages;
 
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
@@ -162,10 +163,13 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
 			adjust_managed_page_count(page, -1);
 	}
 
+	num_allocated_pages = vb->num_pfns;
 	/* Did we get any? */
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->inflate_vq);
 	mutex_unlock(&vb->balloon_lock);
+
+	return num_allocated_pages;
 }
 
 static void release_pages_balloon(struct virtio_balloon *vb)
@@ -251,14 +255,19 @@ static void update_balloon_stats(struct virtio_balloon *vb)
  * with a single buffer.  From that point forward, all conversations consist of
  * a hypervisor request (a call to this function) which directs us to refill
  * the virtqueue with a fresh stats buffer.  Since stats collection can sleep,
- * we notify our kthread which does the actual work via stats_handle_request().
+ * we delegate the job to a freezable workqueue that will do the actual work via
+ * stats_handle_request().
  */
 static void stats_request(struct virtqueue *vq)
 {
 	struct virtio_balloon *vb = vq->vdev->priv;
 
 	vb->need_stats_update = 1;
-	wake_up(&vb->config_change);
+
+	spin_lock(&vb->stop_update_lock);
+	if (!vb->stop_update)
+		queue_work(system_freezable_wq, &vb->work);
+	spin_unlock(&vb->stop_update_lock);
 }
 
 static void stats_handle_request(struct virtio_balloon *vb)
@@ -281,8 +290,12 @@ static void stats_handle_request(struct virtio_balloon *vb)
 static void virtballoon_changed(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
+	unsigned long flags;
 
-	wake_up(&vb->config_change);
+	spin_lock_irqsave(&vb->stop_update_lock, flags);
+	if (!vb->stop_update)
+		queue_work(system_freezable_wq, &vb->work);
+	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
 }
 
 static inline s64 towards_target(struct virtio_balloon *vb)
@@ -345,43 +358,25 @@ static int virtballoon_oom_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static int balloon(void *_vballoon)
+static void balloon(struct work_struct *work)
 {
-	struct virtio_balloon *vb = _vballoon;
-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-
-	set_freezable();
-	while (!kthread_should_stop()) {
-		s64 diff;
-
-		try_to_freeze();
-
-		add_wait_queue(&vb->config_change, &wait);
-		for (;;) {
-			if ((diff = towards_target(vb)) != 0 ||
-			    vb->need_stats_update ||
-			    kthread_should_stop() ||
-			    freezing(current))
-				break;
-			wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
-		}
-		remove_wait_queue(&vb->config_change, &wait);
+	struct virtio_balloon *vb;
+	s64 diff;
 
-		if (vb->need_stats_update)
-			stats_handle_request(vb);
-		if (diff > 0)
-			fill_balloon(vb, diff);
-		else if (diff < 0)
-			leak_balloon(vb, -diff);
-		update_balloon_size(vb);
+	vb = container_of(work, struct virtio_balloon, work);
+	diff = towards_target(vb);
 
-		/*
-		 * For large balloon changes, we could spend a lot of time
-		 * and always have work to do.  Be nice if preempt disabled.
-		 */
-		cond_resched();
-	}
-	return 0;
+	if (vb->need_stats_update)
+		stats_handle_request(vb);
+
+	if (diff > 0)
+		diff -= fill_balloon(vb, diff);
+	else if (diff < 0)
+		diff += leak_balloon(vb, -diff);
+	update_balloon_size(vb);
+
+	if (diff)
+		queue_work(system_freezable_wq, work);
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -499,9 +494,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		goto out;
 	}
 
+	INIT_WORK(&vb->work, balloon);
+	spin_lock_init(&vb->stop_update_lock);
+	vb->stop_update = false;
 	vb->num_pages = 0;
 	mutex_init(&vb->balloon_lock);
-	init_waitqueue_head(&vb->config_change);
 	init_waitqueue_head(&vb->acked);
 	vb->vdev = vdev;
 	vb->need_stats_update = 0;
@@ -523,16 +520,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	vb->thread = kthread_run(balloon, vb, "vballoon");
-	if (IS_ERR(vb->thread)) {
-		err = PTR_ERR(vb->thread);
-		goto out_del_vqs;
-	}
-
 	return 0;
 
-out_del_vqs:
-	unregister_oom_notifier(&vb->nb);
 out_oom_notify:
 	vdev->config->del_vqs(vdev);
 out_free_vb:
@@ -559,7 +548,12 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	struct virtio_balloon *vb = vdev->priv;
 
 	unregister_oom_notifier(&vb->nb);
-	kthread_stop(vb->thread);
+
+	spin_lock_irq(&vb->stop_update_lock);
+	vb->stop_update = true;
+	spin_unlock_irq(&vb->stop_update_lock);
+	cancel_work_sync(&vb->work);
+
 	remove_common(vb);
 	kfree(vb);
 }
@@ -570,10 +564,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
 	struct virtio_balloon *vb = vdev->priv;
 
 	/*
-	 * The kthread is already frozen by the PM core before this
+	 * The workqueue is already frozen by the PM core before this
 	 * function is called.
 	 */
-
 	remove_common(vb);
 	return 0;
 }
@@ -589,7 +582,8 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	fill_balloon(vb, towards_target(vb));
+	if (towards_target(vb))
+		virtballoon_changed(vdev);
 	update_balloon_size(vb);
 	return 0;
 }
-- 
1.8.5.6
