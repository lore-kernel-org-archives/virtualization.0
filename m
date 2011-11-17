From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 06/11] virtio: blk: Add freeze, restore handlers to
	support S4
Date: Thu, 17 Nov 2011 14:28:26 +0200
Message-ID: <20111117122825.GC19682@redhat.com>
References: <cover.1321530505.git.amit.shah@redhat.com>
	<81e98fc00370152ded2eef20f0953f19fad6f0f5.1321530505.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <81e98fc00370152ded2eef20f0953f19fad6f0f5.1321530505.git.amit.shah@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 17, 2011 at 05:27:37PM +0530, Amit Shah wrote:
> Delete the vq and flush any pending requests from the block queue on the
> freeze callback to prepare for hibernation.
> 
> Re-create the vq in the restore callback to resume normal function.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/block/virtio_blk.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 467f218..f73fb2d 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -568,6 +568,38 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>  	ida_simple_remove(&vd_index_ida, index);
>  }
>  
> +#ifdef CONFIG_PM
> +static int virtblk_freeze(struct virtio_device *vdev)
> +{
> +	struct virtio_blk *vblk = vdev->priv;
> +
> +	flush_work(&vblk->config_work);

What if a new config_work is scheduled after this point?
The right thing to do seems to be to flush after disabling interrupts.

> +	spin_lock_irq(vblk->disk->queue->queue_lock);
> +	blk_stop_queue(vblk->disk->queue);
> +	spin_unlock_irq(vblk->disk->queue->queue_lock);
> +	blk_sync_queue(vblk->disk->queue);
> +
> +	/* Stop all the virtqueues. */
> +	vdev->config->reset(vdev);
> +	vdev->config->del_vqs(vdev);

I think del_vqs should be followed by reset:
del_vqs assumes the device in a state find put it in.

> +	return 0;
> +}
> +
> +static int virtblk_restore(struct virtio_device *vdev)
> +{
> +	struct virtio_blk *vblk = vdev->priv;
> +	int ret;
> +
> +	ret = init_vq(vdev->priv);
> +	if (!ret) {
> +		spin_lock_irq(vblk->disk->queue->queue_lock);
> +		blk_start_queue(vblk->disk->queue);
> +		spin_unlock_irq(vblk->disk->queue->queue_lock);
> +	}
> +	return ret;
> +}
> +#endif
> +
>  static const struct virtio_device_id id_table[] = {
>  	{ VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
>  	{ 0 },
> @@ -593,6 +625,10 @@ static struct virtio_driver __refdata virtio_blk = {
>  	.probe			= virtblk_probe,
>  	.remove			= __devexit_p(virtblk_remove),
>  	.config_changed		= virtblk_config_changed,
> +#ifdef CONFIG_PM
> +	.freeze			= virtblk_freeze,
> +	.restore		= virtblk_restore,
> +#endif
>  };
>  
>  static int __init init(void)
> -- 
> 1.7.7.1
