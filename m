From: Martin Peschke <mp3@de.ibm.com>
Subject: Re: [PATCH 2/3] Virtio draft IV: the block driver
Date: Tue, 10 Jul 2007 14:12:01 +0200
Message-ID: <46937791.2000706@de.ibm.com>
References: <46924364.3070006@de.ibm.com> <1183996470.9982.30.camel@dix>
	<1184042575.6005.483.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184042575.6005.483.camel@localhost.localdomain>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Hi Martin!
> 
> 	I like this: moving the allocation into do_req() makes it even simpler:
> 
> static void do_virtblk_request(request_queue_t *q)
> {
> 	struct virtio_blk *vblk = NULL;
> 	struct request *req;
> 	unsigned int issued = 0;
> 
> 	while ((req = elv_next_request(q)) != NULL) {
> 		vblk = req->rq_disk->private_data;
> 		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
> 
> 		if (!do_req(q, vblk, req)) {
> 			/* Queue full?  Wait. */
> 			blk_stop_queue(q);
> 			break;
> 		}
> 		blkdev_dequeue_request(req);
> 		issued++;
> 	}
> 
> 	if (issued)
> 		vblk->vq->ops->sync(vblk->vq);
> }

ACK ;)

Thanks,
Martin
