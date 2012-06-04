From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio_blk: unlock vblk->lock during kick
Date: Mon, 4 Jun 2012 14:15:08 +0300
Message-ID: <20120604111507.GB28673@redhat.com>
References: <1338541986-8083-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1338541986-8083-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: khoa@us.ibm.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 01, 2012 at 10:13:06AM +0100, Stefan Hajnoczi wrote:
> Other block drivers (cciss, rbd, nbd) use spin_unlock_irq() so I followed that.
> To me this seems wrong: blk_run_queue() uses spin_lock_irqsave() but we enable
> irqs with spin_unlock_irq().  If the caller of blk_run_queue() had irqs
> disabled and we enable them again this could be a problem, right?  Can someone
> more familiar with kernel locking comment?

Why take the risk?  What's the advantage of enabling them here? VCPU is
not running while the hypervisor is processing the notification anyway.
And the next line returns from the function so the interrupts will get
enabled.

>  drivers/block/virtio_blk.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 774c31d..d674977 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -199,8 +199,14 @@ static void do_virtblk_request(struct request_queue *q)
>  		issued++;
>  	}
>  
> -	if (issued)
> -		virtqueue_kick(vblk->vq);
> +	if (!issued)
> +		return;
> +
> +	if (virtqueue_kick_prepare(vblk->vq)) {
> +		spin_unlock_irq(vblk->disk->queue->queue_lock);
> +		virtqueue_notify(vblk->vq);
> +		spin_lock_irq(vblk->disk->queue->queue_lock);
> +	}
>  }
>  
>  /* return id (s/n) string for *disk to *id_str
> -- 
> 1.7.10
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
