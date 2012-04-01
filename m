From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_blk: Drop unused request tracking list
Date: Sun, 1 Apr 2012 13:07:37 +0300
Message-ID: <20120401100737.GE22071@redhat.com>
References: <1333077850-21717-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1333077850-21717-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 30, 2012 at 11:24:10AM +0800, Asias He wrote:
> Benchmark shows small performance improvement on fusion io device.
> 
> Before:
>   seq-read : io=1,024MB, bw=19,982KB/s, iops=39,964, runt= 52475msec
>   seq-write: io=1,024MB, bw=20,321KB/s, iops=40,641, runt= 51601msec
>   rnd-read : io=1,024MB, bw=15,404KB/s, iops=30,808, runt= 68070msec
>   rnd-write: io=1,024MB, bw=14,776KB/s, iops=29,552, runt= 70963msec
> 
> After:
>   seq-read : io=1,024MB, bw=20,343KB/s, iops=40,685, runt= 51546msec
>   seq-write: io=1,024MB, bw=20,803KB/s, iops=41,606, runt= 50404msec
>   rnd-read : io=1,024MB, bw=16,221KB/s, iops=32,442, runt= 64642msec
>   rnd-write: io=1,024MB, bw=15,199KB/s, iops=30,397, runt= 68991msec
> 
> Signed-off-by: Asias He <asias@redhat.com>

Thanks, the patch makes sense to me.
Acked-by: Michael S. Tsirkin <mst@redhat.com>

This is 3.5 material, correct?

> ---
>  drivers/block/virtio_blk.c |   10 ----------
>  1 files changed, 0 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c4a60ba..338da9a 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -29,9 +29,6 @@ struct virtio_blk
>  	/* The disk structure for the kernel. */
>  	struct gendisk *disk;
>  
> -	/* Request tracking. */
> -	struct list_head reqs;
> -
>  	mempool_t *pool;
>  
>  	/* Process context for config space updates */
> @@ -55,7 +52,6 @@ struct virtio_blk
>  
>  struct virtblk_req
>  {
> -	struct list_head list;
>  	struct request *req;
>  	struct virtio_blk_outhdr out_hdr;
>  	struct virtio_scsi_inhdr in_hdr;
> @@ -99,7 +95,6 @@ static void blk_done(struct virtqueue *vq)
>  		}
>  
>  		__blk_end_request_all(vbr->req, error);
> -		list_del(&vbr->list);
>  		mempool_free(vbr, vblk->pool);
>  	}
>  	/* In case queue is stopped waiting for more buffers. */
> @@ -184,7 +179,6 @@ static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
>  		return false;
>  	}
>  
> -	list_add_tail(&vbr->list, &vblk->reqs);
>  	return true;
>  }
>  
> @@ -408,7 +402,6 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>  		goto out_free_index;
>  	}
>  
> -	INIT_LIST_HEAD(&vblk->reqs);
>  	spin_lock_init(&vblk->lock);
>  	vblk->vdev = vdev;
>  	vblk->sg_elems = sg_elems;
> @@ -571,9 +564,6 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>  	vblk->config_enable = false;
>  	mutex_unlock(&vblk->config_lock);
>  
> -	/* Nothing should be pending. */
> -	BUG_ON(!list_empty(&vblk->reqs));
> -
>  	/* Stop all the virtqueues. */
>  	vdev->config->reset(vdev);
>  
> -- 
> 1.7.7.6
