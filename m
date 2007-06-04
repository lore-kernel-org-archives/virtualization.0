From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example
	block driver
Date: Mon, 4 Jun 2007 16:31:15 +0200
Message-ID: <20070604143115.GJ32105__1161.44528515196$1180967638$gmane$org@kernel.dk>
References: <1180614091.11133.63.camel@localhost.localdomain>
	<465EC637.7020504@de.ibm.com>
	<1180654765.10999.6.camel@localhost.localdomain>
	<465FC65C.6020905@de.ibm.com>
	<20070601131315.GW32105@kernel.dk> <4664164A.40604@de.ibm.com>
	<20070604134322.GC32105@kernel.dk>
	<1180965161.25878.47.camel@localhost.localdomain>
	<20070604135433.GG32105@kernel.dk> <46641DC9.5050600@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46641DC9.5050600@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: carsteno@de.ibm.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 04 2007, Carsten Otte wrote:
> Jens Axboe wrote:
> >Most people should not fiddle with it, the defaults are there for good
> >reason. I can provide a blk_queue_unplug_thresholds(q, depth, delay)
> >helper that you could use for the virtualized drivers, perhaps that
> >would be better for that use?
> Yea, we should'nt change the defaults without a good reason. That 
> would change things for all device drivers.
> This interface provides all functionality we need. I think we need a 
> knob in /sys/block/mydevice/queue/ in addition to that.

Something like this, totally untested (but trivial, so it should work
:-)

diff --git a/block/elevator.c b/block/elevator.c
index ce866eb..81e2a2d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -638,7 +638,7 @@ void elv_insert(request_queue_t *q, struct request *rq, int where)
 		int nrq = q->rq.count[READ] + q->rq.count[WRITE]
 			- q->in_flight;
 
-		if (nrq >= q->unplug_thresh)
+		if (nrq >= q->unplug_thresh || !q->unplug_delay)
 			__generic_unplug_device(q);
 	}
 }
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 6b5173a..aaefb32 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -785,6 +785,30 @@ void blk_queue_dma_alignment(request_queue_t *q, int mask)
 EXPORT_SYMBOL(blk_queue_dma_alignment);
 
 /**
+ * blk_queue_unplug_threshold - set automatic unplug thresholds for the queue
+ * @q:     the request queue for the device
+ * @depth: the queue depth at which to do unplug
+ * @delay: maximum unplug timer delay
+ *
+ * Description:
+ *    Set the desired unplug depth/threshold and delay for a given queue.
+ *    The block layer has a set of good defaults for this, so this function
+ *    should ONLY be used by drivers for virtualized environments, where
+ *    you could potentially have several layers of queues that each do their
+ *    own delay.
+ *
+ *    If in doubt, don't use this function! The settings can also be
+ *    tweaked from sysfs.
+ *
+ **/
+void blk_queue_unplug_threshold(request_queue_t *q, unsigned int depth,
+				unsigned long delay)
+{
+	q->unplug_thresh = depth;
+	q->unplug_delay = delay;
+}
+
+/**
  * blk_queue_find_tag - find a request by its tag and queue
  * @q:	 The request queue for the device
  * @tag: The tag of the request
@@ -1550,7 +1574,8 @@ void blk_plug_device(request_queue_t *q)
 		return;
 
 	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags)) {
-		mod_timer(&q->unplug_timer, jiffies + q->unplug_delay);
+		if (q->unplug_delay)
+			mod_timer(&q->unplug_timer, jiffies + q->unplug_delay);
 		blk_add_trace_generic(q, NULL, 0, BLK_TA_PLUG);
 	}
 }
@@ -3975,6 +4000,54 @@ static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
 	return queue_var_show(max_hw_sectors_kb, (page));
 }
 
+static ssize_t queue_unplug_delay_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->unplug_delay, page);
+}
+
+/*
+ * We don't bother rearming a running timer. It's just not worth it, the
+ * next unplug will get it right.
+ */
+static ssize_t queue_unplug_delay_store(struct request_queue *q,
+					const char *page, size_t count)
+{
+	unsigned long delay;
+	int ret;
+
+	ret = queue_var_store(&delay, page, count);
+
+	spin_lock_irq(q->queue_lock);
+	q->unplug_delay = msecs_to_jiffies(delay);
+	spin_unlock_irq(q->queue_lock);
+
+	return ret;
+}
+
+static ssize_t queue_unplug_depth_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->unplug_thresh, page);
+}
+
+/*
+ * We don't bother unplugging if we depth was reduced and we just happened
+ * to have a current queue depth of somewhere in between the old and new
+ * value.
+ */
+static ssize_t queue_unplug_depth_store(struct request_queue *q,
+					const char *page, size_t count)
+{
+	unsigned long depth;
+	int ret;
+
+	ret = queue_var_store(&depth, page, count);
+
+	spin_lock_irq(q->queue_lock);
+	q->unplug_thresh = depth;
+	spin_unlock_irq(q->queue_lock);
+
+	return ret;
+}
 
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
@@ -4005,12 +4078,26 @@ static struct queue_sysfs_entry queue_iosched_entry = {
 	.store = elv_iosched_store,
 };
 
+static struct queue_sysfs_entry queue_unplug_depth_entry = {
+	.attr = {.name = "unplug_depth", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_unplug_depth_show,
+	.store = queue_unplug_depth_store,
+};
+
+static struct queue_sysfs_entry queue_unplug_delay_entry = {
+	.attr = {.name = "unplug_delay_ms", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_unplug_delay_show,
+	.store = queue_unplug_delay_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_iosched_entry.attr,
+	&queue_unplug_delay_entry.attr,
+	&queue_unplug_depth_entry.attr,
 	NULL,
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index db5b00a..04c09d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -747,6 +747,7 @@ extern void blk_queue_prep_rq(request_queue_t *, prep_rq_fn *pfn);
 extern void blk_queue_merge_bvec(request_queue_t *, merge_bvec_fn *);
 extern void blk_queue_dma_alignment(request_queue_t *, int);
 extern void blk_queue_softirq_done(request_queue_t *, softirq_done_fn *);
+extern void blk_queue_unplug_threshold(request_queue_t *q, unsigned int, unsigned long);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 extern int blk_queue_ordered(request_queue_t *, unsigned, prepare_flush_fn *);
 extern void blk_queue_issue_flush_fn(request_queue_t *, issue_flush_fn *);

-- 
Jens Axboe
