From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Sun, 19 Jun 2011 09:55:07 -0400
Message-ID: <20110619135507.GA25728@infradead.org>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<20110619074841.GA8613@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110619074841.GA8613@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: axboe@kernel.dk, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 19, 2011 at 10:48:41AM +0300, Michael S. Tsirkin wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4ce953f..a8672ec 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -433,6 +433,8 @@ void blk_run_queue(struct request_queue *q)
>  	spin_lock_irqsave(q->queue_lock, flags);
>  	__blk_run_queue(q);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
> +	if (q->request_done)
> +		q->request_done(q);

We have quite a few cases where __blk_run_queue is called directly, and
one more (although not applicable to virtio-blk) that calls ->request_fn
directly.

I think Stefan's way is the way to go for now, releasing and reacquiring
the queue lock once in ->request_fn is much less than the common IDE and
SCSI setups do today.

Eventually ->queue_lock should be split from the driver-internal lock,
and we could do a more efficient calling convention than the one per
request blk_peek_request.  I've started looking into that, but it's
going to take a while.
