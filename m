From: Martin Peschke <mp3@de.ibm.com>
Subject: Re: [PATCH 2/3] Virtio draft IV: the block driver
Date: Mon, 09 Jul 2007 16:17:08 +0200
Message-ID: <46924364.3070006@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

 > +static void do_virtblk_request(request_queue_t *q)
 > +{
 > +	struct virtio_blk *vblk = NULL;
 > +	struct request *req;
 > +	struct virtblk_req *vbr;
 > +
 > +	while ((req = elv_next_request(q)) != NULL) {
 > +		vblk = req->rq_disk->private_data;
 > +
 > +		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
 > +		if (!vbr)
 > +			goto stop;
 > +
 > +		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
 > +		vbr->req = req;
 > +		if (!do_req(q, vblk, vbr))
 > +			goto stop;
 > +		blkdev_dequeue_request(req);
 > +	}
 > +
 > +sync:
 > +	if (vblk)


this check looks bogus, as vblk->pool has been accessed unconditionally above


 > +		vblk->vq->ops->sync(vblk->vq);
 > +	return;
 > +
 > +stop:
 > +	/* Queue full?  Wait. */
 > +	blk_stop_queue(q);
 > +	mempool_free(vbr, vblk->pool);
 > +	goto sync;
 > +}
