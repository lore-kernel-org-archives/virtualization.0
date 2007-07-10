From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] Virtio draft IV: the block driver
Date: Tue, 10 Jul 2007 14:42:55 +1000
Message-ID: <1184042575.6005.483.camel@localhost.localdomain>
References: <46924364.3070006@de.ibm.com>  <1183996470.9982.30.camel@dix>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183996470.9982.30.camel@dix>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Martin Peschke <mp3@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-07-09 at 17:54 +0200, Martin Peschke wrote:
> static void do_virtblk_request(request_queue_t *q)
> {
> 	struct virtio_blk *vblk = q->queuedata;
> 	struct request *req;
> 	struct virtblk_req *vbr;
> 	int issued = 0;
> 
> 	while ((req = elv_next_request(q)) != NULL) {
> 		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
> 		if (!vbr) {
> 			blk_stop_queue(q);
> 			break;
> 		}
> 
> 		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
> 		vbr->req = req;
> 		if (!do_req(q, vblk, req, vbr)) {
> 			/* Queue full?  Wait. */
> 			blk_stop_queue(q);
> 			mempool_free(vbr, vblk->pool);
> 			break;
> 		}
> 		blkdev_dequeue_request(req);
> 		issued++;
> 	}
> 
> 	if (issued)
> 		vblk->vq->ops->sync(vblk->vq);
> }

Hi Martin!

	I like this: moving the allocation into do_req() makes it even simpler:

static void do_virtblk_request(request_queue_t *q)
{
	struct virtio_blk *vblk = NULL;
	struct request *req;
	unsigned int issued = 0;

	while ((req = elv_next_request(q)) != NULL) {
		vblk = req->rq_disk->private_data;
		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));

		if (!do_req(q, vblk, req)) {
			/* Queue full?  Wait. */
			blk_stop_queue(q);
			break;
		}
		blkdev_dequeue_request(req);
		issued++;
	}

	if (issued)
		vblk->vq->ops->sync(vblk->vq);
}

Thanks!
Rusty.
