From: Martin Peschke <mp3@de.ibm.com>
Subject: Re: [PATCH 2/3] Virtio draft IV: the block driver
Date: Mon, 09 Jul 2007 17:54:30 +0200
Message-ID: <1183996470.9982.30.camel@dix>
References: <46924364.3070006@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46924364.3070006@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-07-09 at 16:17 +0200, Martin Peschke wrote:
>  > +static void do_virtblk_request(request_queue_t *q)
>  > +{
>  > +	struct virtio_blk *vblk = NULL;
>  > +	struct request *req;
>  > +	struct virtblk_req *vbr;
>  > +
>  > +	while ((req = elv_next_request(q)) != NULL) {
>  > +		vblk = req->rq_disk->private_data;
>  > +
>  > +		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
>  > +		if (!vbr)
>  > +			goto stop;
>  > +
>  > +		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
>  > +		vbr->req = req;
>  > +		if (!do_req(q, vblk, vbr))
>  > +			goto stop;
>  > +		blkdev_dequeue_request(req);
>  > +	}
>  > +
>  > +sync:
>  > +	if (vblk)
> 
> 
> this check looks bogus, as vblk->pool has been accessed unconditionally above


Sorry, I have been seduced by the code to misread it.
The check is correct and needed.

Looks like we can make it more readable, though.

- get rid of convoluted goto's
- no need for calling mempool_free() with NULL-pointer
- read private data from q->queuedata once instead of poking inside
  every request
- use a local variable to track issued requests and the need for
  a sync-operation
- pass req to do_req() as it is used there throughout the function
  (nice symmetry in parameter list, isn't it?)

It's just an untested and incomplete sketch done while I am acquainting
myself with the virtio code without having set up lguest yet.


static void do_virtblk_request(request_queue_t *q)
{
	struct virtio_blk *vblk = q->queuedata;
	struct request *req;
	struct virtblk_req *vbr;
	int issued = 0;

	while ((req = elv_next_request(q)) != NULL) {
		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
		if (!vbr) {
			blk_stop_queue(q);
			break;
		}

		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
		vbr->req = req;
		if (!do_req(q, vblk, req, vbr)) {
			/* Queue full?  Wait. */
			blk_stop_queue(q);
			mempool_free(vbr, vblk->pool);
			break;
		}
		blkdev_dequeue_request(req);
		issued++;
	}

	if (issued)
		vblk->vq->ops->sync(vblk->vq);
}
