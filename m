From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Date: Tue, 28 Apr 2020 11:25:07 -0400
Message-ID: <20200428110515-mutt-send-email-mst@kernel.org>
References: <20200428143009.107645-1-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428143009.107645-1-stefanha@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, cohuck@redhat.com, Stefano Garzarella <sgarzare@redhat.com>, Lance Digby <ldigby@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 03:30:09PM +0100, Stefan Hajnoczi wrote:
> A userspace process holding a file descriptor to a virtio_blk device can
> still invoke block_device_operations after hot unplug.  For example, a
> program that has /dev/vdb open can call ioctl(HDIO_GETGEO) after hot
> unplug to invoke virtblk_getgeo().


which causes what? a use after free?

> 
> Introduce a reference count in struct virtio_blk so that its lifetime
> covers both virtio_driver probe/remove and block_device_operations
> open/release users.  This ensures that block_device_operations functions
> like virtblk_getgeo() can safely access struct virtio_blk.
> 
> Add remove_mutex to prevent block_device_operations functions from
> accessing vblk->vdev during virtblk_remove() and let the safely check

let the -> let them?

> for !vblk->vdev after virtblk_remove() returns.
> 
> Switching to a reference count also solves the vd_index_ida leak where
> vda, vdb, vdc, etc indices were lost when the device was hot unplugged
> while the block device was still open.

Can you move this statement up so we list both issues (use after free
and leak) upfront, then discuss the fix?

> 
> Reported-by: Lance Digby <ldigby@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> If someone has a simpler solution please let me know.  I looked at
> various approaches including reusing device_lock(&vblk->vdev.dev) but
> they were more complex and extending the lifetime of virtio_device after
> remove() has been called seems questionable.
> ---
>  drivers/block/virtio_blk.c | 85 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 93468b7c6701..3dd53b445cc1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -44,6 +44,13 @@ struct virtio_blk {
>  	/* Process context for config space updates */
>  	struct work_struct config_work;
>  
> +	/*
> +	 * Tracks references from block_device_operations open/release and
> +	 * virtio_driver probe/remove so this object can be freed once no
> +	 * longer in use.
> +	 */
> +	refcount_t refs;
> +
>  	/* What host tells us, plus 2 for header & tailer. */
>  	unsigned int sg_elems;
>  
> @@ -53,6 +60,9 @@ struct virtio_blk {
>  	/* num of vqs */
>  	int num_vqs;
>  	struct virtio_blk_vq *vqs;
> +
> +	/* Provides mutual exclusion with virtblk_remove(). */

This is not the best way to document access rules.
Which fields does this protect, exactly?
I think it's just vdev. Right?
Pls add to the comment.

> +	struct mutex remove_mutex;
>  };
>  
>  struct virtblk_req {
> @@ -295,10 +305,54 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	return err;
>  }
>  
> +static void virtblk_get(struct virtio_blk *vblk)
> +{
> +	refcount_inc(&vblk->refs);
> +}
> +
> +static void virtblk_put(struct virtio_blk *vblk)
> +{
> +	if (refcount_dec_and_test(&vblk->refs)) {
> +		ida_simple_remove(&vd_index_ida, vblk->index);
> +		mutex_destroy(&vblk->remove_mutex);
> +		kfree(vblk);
> +	}
> +}
> +
> +static int virtblk_open(struct block_device *bd, fmode_t mode)
> +{
> +	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret = -ENXIO;


It's more common to do

	int ret = 0;

and on error:
	ret = -ENXIO;


let's do this.


> +
> +	mutex_lock(&vblk->remove_mutex);
> +
> +	if (vblk->vdev) {
> +		virtblk_get(vblk);
> +		ret = 0;
> +	}

I prefer
	else
		ret = -ENXIO

here.


> +
> +	mutex_unlock(&vblk->remove_mutex);
> +	return ret;
> +}
> +
> +static void virtblk_release(struct gendisk *disk, fmode_t mode)
> +{
> +	struct virtio_blk *vblk = disk->private_data;
> +
> +	virtblk_put(vblk);
> +}
> +
>  /* We provide getgeo only to please some old bootloader/partitioning tools */
>  static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
>  	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret = -ENXIO;

It's more common to do

	int ret = 0;

and on error:
	ret = -ENXIO;


let's do this.

> +
> +	mutex_lock(&vblk->remove_mutex);
> +
> +	if (!vblk->vdev) {
> +		goto out;
> +	}


single lines are not supposed to use {}.
if you add ret = -ENXIO here then it won't be a single line anymore
though.

>  
>  	/* see if the host passed in geometry config */
>  	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
> @@ -314,11 +368,17 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  		geo->sectors = 1 << 5;
>  		geo->cylinders = get_capacity(bd->bd_disk) >> 11;
>  	}
> -	return 0;
> +
> +	ret = 0;
> +out:
> +	mutex_unlock(&vblk->remove_mutex);
> +	return ret;
>  }
>  
>  static const struct block_device_operations virtblk_fops = {
>  	.owner  = THIS_MODULE,
> +	.open = virtblk_open,
> +	.release = virtblk_release,
>  	.getgeo = virtblk_getgeo,
>  };
>  
> @@ -655,6 +715,10 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		goto out_free_index;
>  	}
>  
> +	/* This reference is dropped in virtblk_remove(). */
> +	refcount_set(&vblk->refs, 1);
> +	mutex_init(&vblk->remove_mutex);
> +
>  	vblk->vdev = vdev;
>  	vblk->sg_elems = sg_elems;
>  
> @@ -820,8 +884,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;
> -	int index = vblk->index;
> -	int refc;
> +
> +	/*
> +	 * Virtqueue processing is stopped safely here but mutual exclusion is
> +	 * needed for block_device_operations.
> +	 */
> +	mutex_lock(&vblk->remove_mutex);
>  
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> @@ -834,15 +902,16 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	/* Stop all the virtqueues. */
>  	vdev->config->reset(vdev);
>  
> -	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);
> +	/* Virtqueue are stopped, nothing can use vblk->vdev anymore. */

Virtqueues?

> +	vblk->vdev = NULL;
> +
>  	put_disk(vblk->disk);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> -	kfree(vblk);
>  
> -	/* Only free device id if we don't have any users */
> -	if (refc == 1)
> -		ida_simple_remove(&vd_index_ida, index);
> +	mutex_unlock(&vblk->remove_mutex);
> +
> +	virtblk_put(vblk);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.25.3
> 
