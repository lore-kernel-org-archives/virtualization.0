From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 4/6] virtio block driver
Date: Thu, 20 Sep 2007 15:05:19 +0200
Message-ID: <20070920130519.GL2367__14946.6722076342$1190298677$gmane$org@kernel.dk>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<1190290495.7262.235.camel@localhost.localdomain>
	<1190290606.7262.239.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1190290606.7262.239.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 20 2007, Rusty Russell wrote:
> +static void end_dequeued_request(struct request *req,
> +				 struct request_queue *q, int uptodate)
> +{
> +	/* And so the insanity of the block layer infects us here. */
> +	int nsectors = req->hard_nr_sectors;
> +
> +	if (blk_pc_request(req)) {
> +		nsectors = (req->data_len + 511) >> 9;
> +		if (!nsectors)
> +			nsectors = 1;
> +	}
> +	if (end_that_request_first(req, uptodate, nsectors))
> +		BUG();
> +	add_disk_randomness(req->rq_disk);
> +	end_that_request_last(req, uptodate);
> +}

We have end_queued_request(), lets add end_dequeued_request(). Below.

> +	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
> +	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
> +	vblk->sg[0].length = sizeof(vbr->out_hdr);
> +	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);

This wont work for chained sglists, but I gather (I'm so funny) that it
wont be an issue for you. How large are your sglists?

> +		if (!do_req(q, vblk, req)) {
> +			/* Queue full?  Wait. */
> +			blk_stop_queue(q);
> +			break;
> +		}

Personally I think this bool stuff is foul. You return false/true, but
still use ! to test. That is just more confusing than the canonical 0/1
good/bad return imho.


diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index f6d3994..c1dc23a 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3719,15 +3719,24 @@ void end_that_request_last(struct request *req, int uptodate)
 EXPORT_SYMBOL(end_that_request_last);
 
 static inline void __end_request(struct request *rq, int uptodate,
-				 unsigned int nr_bytes)
+				 unsigned int nr_bytes, int dequeue)
 {
 	if (!end_that_request_chunk(rq, uptodate, nr_bytes)) {
-		blkdev_dequeue_request(rq);
+		if (dequeue)
+			blkdev_dequeue_request(rq);
 		add_disk_randomness(rq->rq_disk);
 		end_that_request_last(rq, uptodate);
 	}
 }
 
+static unsigned int rq_byte_size(struct request *rq)
+{
+	if (blk_fs_request(rq))
+		return rq->hard_nr_sectors << 9;
+
+	return rq->data_len;
+}
+
 /**
  * end_queued_request - end all I/O on a queued request
  * @rq:		the request being processed
@@ -3741,18 +3750,29 @@ static inline void __end_request(struct request *rq, int uptodate,
  **/
 void end_queued_request(struct request *rq, int uptodate)
 {
-	unsigned int nr_bytes;
-
-	if (blk_fs_request(rq))
-		nr_bytes = rq->hard_nr_sectors << 9;
-	else
-		nr_bytes = rq->data_len;
-
-	__end_request(rq, uptodate, nr_bytes);
+	__end_request(rq, uptodate, rq_byte_size(rq), 1);
 }
 EXPORT_SYMBOL(end_queued_request);
 
 /**
+ * end_dequeued_request - end all I/O on a dequeued request
+ * @rq:		the request being processed
+ * @uptodate:	error value or 0/1 uptodate flag
+ *
+ * Description:
+ *     Ends all I/O on a request. The request must already have been
+ *     dequeued using blkdev_dequeue_request(), as is normally the case
+ *     for most drivers.
+ *
+ **/
+void end_dequeued_request(struct request *rq, int uptodate)
+{
+	__end_request(rq, uptodate, rq_byte_size(rq), 0);
+}
+EXPORT_SYMBOL(end_dequeued_request);
+
+
+/**
  * end_request - end I/O on the current segment of the request
  * @rq:		the request being processed
  * @uptodate:	error value or 0/1 uptodate flag
@@ -3773,7 +3793,7 @@ EXPORT_SYMBOL(end_queued_request);
  **/
 void end_request(struct request *req, int uptodate)
 {
-	__end_request(req, uptodate, req->hard_cur_sectors << 9);
+	__end_request(req, uptodate, req->hard_cur_sectors << 9, 1);
 }
 EXPORT_SYMBOL(end_request);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 12ab4d4..4b24265 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -732,6 +732,7 @@ extern int end_that_request_chunk(struct request *, int, int);
 extern void end_that_request_last(struct request *, int);
 extern void end_request(struct request *, int);
 extern void end_queued_request(struct request *, int);
+extern void end_dequeued_request(struct request *, int);
 extern void blk_complete_request(struct request *);
 
 /*

-- 
Jens Axboe
