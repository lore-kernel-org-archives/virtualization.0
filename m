From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio_blk: fix config handler race
Date: Tue, 20 Dec 2011 21:42:31 +0200
Message-ID: <20111220194231.GA26692@redhat.com>
References: <20111207153901.GA23820@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111207153901.GA23820@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 07, 2011 at 05:39:02PM +0200, Michael S. Tsirkin wrote:
> Fix a theoretical race related to config work
> handler: a config interrupt might happen
> after we flush config work but before we
> reset the device. It will then cause the
> config work to run during or after reset.
> 
> Two problems with this:
> - if this runs after device is gone we will get use after free
> - access of config while reset is in progress is racy
> (as layout is changing).
> 
> As a solution
> 1. flush after reset when we know there will be no more interrupts
> 2. add a flag to disable config access before reset
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> RFC only as it's untested.
> Bugfix so 3.2 material? Comments?

Works fine for me. Comments?

> 
>  drivers/block/virtio_blk.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4d0b70a..34633f3 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -4,6 +4,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/hdreg.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_blk.h>
>  #include <linux/scatterlist.h>
> @@ -36,6 +37,12 @@ struct virtio_blk
>  	/* Process context for config space updates */
>  	struct work_struct config_work;
>  
> +	/* Lock for config space updates */
> +	struct mutex config_lock;
> +
> +	/* enable config space updates */
> +	bool config_enable;
> +
>  	/* What host tells us, plus 2 for header & tailer. */
>  	unsigned int sg_elems;
>  
> @@ -318,6 +325,10 @@ static void virtblk_config_changed_work(struct work_struct *work)
>  	char cap_str_2[10], cap_str_10[10];
>  	u64 capacity, size;
>  
> +	mutex_lock(&vblk->config_lock);
> +	if (!vblk->config_enable)
> +		goto done;
> +
>  	/* Host must always specify the capacity. */
>  	vdev->config->get(vdev, offsetof(struct virtio_blk_config, capacity),
>  			  &capacity, sizeof(capacity));
> @@ -340,6 +351,8 @@ static void virtblk_config_changed_work(struct work_struct *work)
>  		  cap_str_10, cap_str_2);
>  
>  	set_capacity(vblk->disk, capacity);
> +done:
> +	mutex_lock(&vblk->config_lock);
>  }
>  
>  static void virtblk_config_changed(struct virtio_device *vdev)
> @@ -388,7 +401,9 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>  	vblk->vdev = vdev;
>  	vblk->sg_elems = sg_elems;
>  	sg_init_table(vblk->sg, vblk->sg_elems);
> +	mutex_init(&vblk->config_lock);
>  	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> +	vblk->config_enable = true;
>  
>  	/* We expect one virtqueue, for output. */
>  	vblk->vq = virtio_find_single_vq(vdev, blk_done, "requests");
> @@ -542,7 +557,10 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>  	struct virtio_blk *vblk = vdev->priv;
>  	int index = vblk->index;
>  
> -	flush_work(&vblk->config_work);
> +	/* Prevent config work handler from accessing the device. */
> +	mutex_lock(&vblk->config_lock);
> +	vblk->config_enable = false;
> +	mutex_unlock(&vblk->config_lock);
>  
>  	/* Nothing should be pending. */
>  	BUG_ON(!list_empty(&vblk->reqs));
> @@ -550,6 +568,8 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>  	/* Stop all the virtqueues. */
>  	vdev->config->reset(vdev);
>  
> +	flush_work(&vblk->config_work);
> +
>  	del_gendisk(vblk->disk);
>  	blk_cleanup_queue(vblk->disk->queue);
>  	put_disk(vblk->disk);
> -- 
> 1.7.5.53.gc233e
