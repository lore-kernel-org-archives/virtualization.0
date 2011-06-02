From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] [virt] virtio-blk: Use ida to allocate disk index
Date: Thu, 2 Jun 2011 13:33:31 +0300
Message-ID: <20110602103331.GC7943__5437.35443284294$1307010887$gmane$org@redhat.com>
References: <1306913069-23637-1-git-send-email-dwu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1306913069-23637-1-git-send-email-dwu@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark Wu <dwu@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 01, 2011 at 03:24:29AM -0400, Mark Wu wrote:
> Current index allocation in virtio-blk is based on a monotonically
> increasing variable "index". It could cause some confusion about disk
> name in the case of hot-plugging disks. And it's impossible to find the
> lowest available index by just maintaining a simple index. So it's
> changed to use ida to allocate index via referring to the index
> allocation in scsi disk.
> 
> Signed-off-by: Mark Wu <dwu@redhat.com>
> ---
>  drivers/block/virtio_blk.c |   37 ++++++++++++++++++++++++++++++++-----
>  1 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 079c088..ba734b3 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -8,10 +8,14 @@
>  #include <linux/scatterlist.h>
>  #include <linux/string_helpers.h>
>  #include <scsi/scsi_cmnd.h>
> +#include <linux/idr.h>
>  
>  #define PART_BITS 4
>  
> -static int major, index;
> +static int major;
> +static DEFINE_SPINLOCK(vd_index_lock);
> +static DEFINE_IDA(vd_index_ida);
> +
>  struct workqueue_struct *virtblk_wq;
>  
>  struct virtio_blk
> @@ -23,6 +27,7 @@ struct virtio_blk
>  
>  	/* The disk structure for the kernel. */
>  	struct gendisk *disk;
> +	u32 index;
>  
>  	/* Request tracking. */
>  	struct list_head reqs;
> @@ -343,12 +348,26 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>  	struct request_queue *q;
>  	int err;
>  	u64 cap;
> -	u32 v, blk_size, sg_elems, opt_io_size;
> +	u32 v, blk_size, sg_elems, opt_io_size, index;
>  	u16 min_io_size;
>  	u8 physical_block_exp, alignment_offset;
>  
> -	if (index_to_minor(index) >= 1 << MINORBITS)
> -		return -ENOSPC;
> +	do {
> +		if (!ida_pre_get(&vd_index_ida, GFP_KERNEL))
> +			return err;
> +
> +		spin_lock(&vd_index_lock);
> +		err = ida_get_new(&vd_index_ida, &index);
> +		spin_unlock(&vd_index_lock);
> +	} while (err == -EAGAIN);
> +
> +	if (err)
> +		return err;
> +
> +	if (index_to_minor(index) >= 1 << MINORBITS) {
> +		err =  -ENOSPC;
> +		goto out_free_index;
> +	}
>  
>  	/* We need to know how many segments before we allocate. */
>  	err = virtio_config_val(vdev, VIRTIO_BLK_F_SEG_MAX,
> @@ -421,7 +440,7 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>  	vblk->disk->private_data = vblk;
>  	vblk->disk->fops = &virtblk_fops;
>  	vblk->disk->driverfs_dev = &vdev->dev;
> -	index++;
> +	vblk->index = index;
>  
>  	/* configure queue flush support */
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_FLUSH))
> @@ -516,6 +535,10 @@ out_free_vq:
>  	vdev->config->del_vqs(vdev);
>  out_free_vblk:
>  	kfree(vblk);
> +out_free_index:
> +	spin_lock(&vd_index_lock);
> +	ida_remove(&vd_index_ida, index);
> +	spin_unlock(&vd_index_lock);
>  out:
>  	return err;
>  }
> @@ -529,6 +552,10 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>  	/* Nothing should be pending. */
>  	BUG_ON(!list_empty(&vblk->reqs));
>  
> +	spin_lock(&vd_index_lock);
> +	ida_remove(&vd_index_ida, vblk->index);
> +	spin_unlock(&vd_index_lock);
> +
>  	/* Stop all the virtqueues. */
>  	vdev->config->reset(vdev);

As we get index first thing in _probe, let's remove last thing
in _remove.

I'm not sure violating the rule of cleanup
in the reverse order of initialization can lead
to problems here, but it's better to stick to this rule regardless,
IMO.

> -- 
> 1.7.1
