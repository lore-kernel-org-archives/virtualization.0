From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: imply disable_cb on callbacks
Date: Wed, 19 May 2010 14:07:34 +0930
Message-ID: <201005191407.34607.rusty__39265.4555420906$1274243902$gmane$org@rustcorp.com.au>
References: <20100518113316.GA26757@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100518113316.GA26757@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 18 May 2010 09:03:17 pm Michael S. Tsirkin wrote:
> Rusty, the patch "virtio: imply disable_cb on callbacks" is on your tree.
> I'd like to figure out how it works: for example:
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -69,6 +69,8 @@ static void blk_done(struct virtqueue *v
>         /* In case queue is stopped waiting for more buffers. */
>         blk_start_queue(vblk->disk->queue);
>         spin_unlock_irqrestore(&vblk->lock, flags);
> +
> +       vq->vq_ops->enable_cb(vq);
>  }
> 
>  static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
> 
> 
> Since this does not check the return status from enable_cb,
> it seems we could loose an interrupt if it arrives
> between poll and callback enable?

It's been quite a while since I wrote this patch, and never really liked it
enough to polish it.

We would need to enable this *before* reading the queue, AFAICT.

I'll remove it from my series; it's in the wilderness area already :)

Thanks!
Rusty.
