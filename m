From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Mon, 28 Jun 2010 12:55:05 -0300
Message-ID: <20100628155505.GB4717__15938.3249389522$1277740891$gmane$org@amt.cnet>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 23, 2010 at 10:24:02PM +0100, Stefan Hajnoczi wrote:
> The virtio block device holds a lock during I/O request processing.
> Kicking the virtqueue while the lock is held results in long lock hold
> times and increases contention for the lock.
> 
> This patch modifies virtqueue_kick() to optionally release a lock while
> notifying the host.  Virtio block is modified to pass in its lock.  This
> allows other vcpus to queue I/O requests during the time spent servicing
> the virtqueue notify in the host.
> 
> The virtqueue_kick() function is modified to know about locking because
> it changes the state of the virtqueue and should execute with the lock
> held (it would not be correct for virtio block to release the lock
> before calling virtqueue_kick()).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> ---
> I am not yet 100% happy with this patch which aims to reduce guest CPU
> consumption related to vblk->lock contention.  Although this patch reduces
> wait/hold times it does not affect I/O throughput or guest CPU utilization.
> More investigation is required to get to the bottom of why guest CPU
> utilization does not decrease when a lock bottleneck has been removed.
> 
> Performance figures:
> 
> Host: 2.6.34 upstream kernel, qemu-kvm-0.12.4 if=virtio,cache=none
> Guest: 2.6.35-rc3-kvm.git upstream kernel
> Storage: 12 disks as striped LVM volume
> Benchmark: 4 concurrent dd bs=4k iflag=direct
> 
> Lockstat data for &vblk->lock:
> 
> test       con-bounces contentions  waittime-min waittime-max waittime-total
> unmodified 7097        7108         0.31         956.09       161165.4
> patched    11484       11550        0.30         411.80       50245.83
> 
> The maximum wait time went down by 544.29 us (-57%) and the total wait time
> decreased by 69%.  This shows that the virtqueue kick is indeed hogging the
> lock.
> 
> The patched version actually has higher contention than the unmodified version.
> I think the reason for this is that each virtqueue kick now includes a short
> release and reacquire.  This short release gives other vcpus a chance to
> acquire the lock and progress, hence more contention but overall better wait
> time numbers.
> 
> name       acq-bounces acquisitions holdtime-min holdtime-max holdtime-total
> unmodified 10771       5038346      0.00         3271.81      59016905.47
> patched    31594       5857813      0.00         219.76       24104915.55
> 
> Here we see the full impact of this patch: hold time reduced to 219.76 us
> (-93%).
> 
> Again the acquisitions have increased since we're now doing an extra
> unlock+lock per virtqueue kick.
> 
> Testing, ideas, and comments appreciated.
> 
>  drivers/block/virtio_blk.c          |    2 +-
>  drivers/char/hw_random/virtio-rng.c |    2 +-
>  drivers/char/virtio_console.c       |    6 +++---
>  drivers/net/virtio_net.c            |    6 +++---
>  drivers/virtio/virtio_balloon.c     |    6 +++---
>  drivers/virtio/virtio_ring.c        |   13 +++++++++++--
>  include/linux/virtio.h              |    3 ++-
>  net/9p/trans_virtio.c               |    2 +-
>  8 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 258bc2a..de033bf 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -187,7 +187,7 @@ static void do_virtblk_request(struct request_queue *q)
>  	}
>  
>  	if (issued)
> -		virtqueue_kick(vblk->vq);
> +		virtqueue_kick(vblk->vq, &vblk->lock);
>  }
>  
>  static void virtblk_prepare_flush(struct request_queue *q, struct request *req)
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 75f1cbd..852d563 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -49,7 +49,7 @@ static void register_buffer(u8 *buf, size_t size)
>  	if (virtqueue_add_buf(vq, &sg, 0, 1, buf) < 0)
>  		BUG();
>  
> -	virtqueue_kick(vq);
> +	virtqueue_kick(vq, NULL);
>  }
>  
>  static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 942a982..677714d 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -328,7 +328,7 @@ static int add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
>  	sg_init_one(sg, buf->buf, buf->size);
>  
>  	ret = virtqueue_add_buf(vq, sg, 0, 1, buf);
> -	virtqueue_kick(vq);
> +	virtqueue_kick(vq, NULL);
>  	return ret;
>  }
>  
> @@ -400,7 +400,7 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
>  
>  	sg_init_one(sg, &cpkt, sizeof(cpkt));
>  	if (virtqueue_add_buf(vq, sg, 1, 0, &cpkt) >= 0) {
> -		virtqueue_kick(vq);
> +		virtqueue_kick(vq, NULL);
>  		while (!virtqueue_get_buf(vq, &len))
>  			cpu_relax();
>  	}
> @@ -444,7 +444,7 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
>  	ret = virtqueue_add_buf(out_vq, sg, 1, 0, in_buf);
>  
>  	/* Tell Host to go! */
> -	virtqueue_kick(out_vq);
> +	virtqueue_kick(out_vq, NULL);
>  
>  	if (ret < 0) {
>  		in_count = 0;
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1edb7a6..6a837b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -433,7 +433,7 @@ static bool try_fill_recv(struct virtnet_info *vi, gfp_t gfp)
>  	} while (err > 0);
>  	if (unlikely(vi->num > vi->max))
>  		vi->max = vi->num;
> -	virtqueue_kick(vi->rvq);
> +	virtqueue_kick(vi->rvq, NULL);
>  	return !oom;
>  }
>  
> @@ -581,7 +581,7 @@ again:
>  		}
>  		return NETDEV_TX_BUSY;
>  	}
> -	virtqueue_kick(vi->svq);
> +	virtqueue_kick(vi->svq, NULL);
>  
>  	/* Don't wait up for transmitted skbs to be freed. */
>  	skb_orphan(skb);
> @@ -680,7 +680,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  
>  	BUG_ON(virtqueue_add_buf(vi->cvq, sg, out, in, vi) < 0);
>  
> -	virtqueue_kick(vi->cvq);
> +	virtqueue_kick(vi->cvq, NULL);
>  
>  	/*
>  	 * Spin for a response, the kick causes an ioport write, trapping
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 0f1da45..c9c5c4a 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -91,7 +91,7 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>  	/* We should always be able to add one buffer to an empty queue. */
>  	if (virtqueue_add_buf(vq, &sg, 1, 0, vb) < 0)
>  		BUG();
> -	virtqueue_kick(vq);
> +	virtqueue_kick(vq, NULL);
>  
>  	/* When host has read buffer, this completes via balloon_ack */
>  	wait_for_completion(&vb->acked);
> @@ -223,7 +223,7 @@ static void stats_handle_request(struct virtio_balloon *vb)
>  	sg_init_one(&sg, vb->stats, sizeof(vb->stats));
>  	if (virtqueue_add_buf(vq, &sg, 1, 0, vb) < 0)
>  		BUG();
> -	virtqueue_kick(vq);
> +	virtqueue_kick(vq, NULL);
>  }
>  
>  static void virtballoon_changed(struct virtio_device *vdev)
> @@ -316,7 +316,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		sg_init_one(&sg, vb->stats, sizeof vb->stats);
>  		if (virtqueue_add_buf(vb->stats_vq, &sg, 1, 0, vb) < 0)
>  			BUG();
> -		virtqueue_kick(vb->stats_vq);
> +		virtqueue_kick(vb->stats_vq, NULL);
>  	}
>  
>  	vb->thread = kthread_run(balloon, vb, "vballoon");
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1ca8890..163a237 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -236,7 +236,7 @@ add_head:
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_buf_gfp);
>  
> -void virtqueue_kick(struct virtqueue *_vq)
> +void virtqueue_kick(struct virtqueue *_vq, spinlock_t *lock)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	START_USE(vq);
> @@ -250,10 +250,19 @@ void virtqueue_kick(struct virtqueue *_vq)
>  	/* Need to update avail index before checking if we should notify */
>  	virtio_mb();
>  
> -	if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
> +	if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY)) {
> +		/* Release lock while doing the kick because the guest should
> +		 * not exit with the lock held. */
> +		if (lock)
> +			spin_unlock(lock);
> +
>  		/* Prod other side to tell it about changes. */
>  		vq->notify(&vq->vq);
>  
> +		if (lock)
> +			spin_lock(lock);
> +	}
> +

The queue lock requires irq's to be disabled in addition to lock
acquision.
