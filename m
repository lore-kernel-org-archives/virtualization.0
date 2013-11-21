From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 2/3] virtio_blk: add virtblk_notify() as
	virtio_driver's notify() callback
Date: Thu, 21 Nov 2013 08:41:57 +0200
Message-ID: <20131121064157.GI19005@redhat.com>
References: <1384960923-31463-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1384960923-31463-3-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1384960923-31463-3-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 20, 2013 at 04:22:02PM +0100, Heinz Graalfs wrote:
> Add virtblk_notify() as virtio_driver's notify() callback.
> 
> When a transport driver is notified that a device disappeared it
> should invoke this callback to prevent further request queueing.
> 
> Subsequent block layer calls of virtio_blk's request function will
> fail, resulting in appropriate I/O errors.
> 
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> ---
>  drivers/block/virtio_blk.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2d43be4..7fc1d62 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -901,6 +901,19 @@ static void virtblk_remove(struct virtio_device *vdev)
>  		ida_simple_remove(&vd_index_ida, index);
>  }
>  
> +static int virtblk_notify(struct virtio_device *vdev, int event)
> +{
> +	struct virtio_blk *vblk = vdev->priv;
> +
> +	if (event == VDEV_GONE) {
> +		queue_flag_set_unlocked(QUEUE_FLAG_DYING, vblk->disk->queue);
> +		queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, vblk->disk->queue);
> +		queue_flag_set_unlocked(QUEUE_FLAG_NOXMERGES,
> +					vblk->disk->queue);
> +	}
> +	return NOTIFY_DONE;

Also pls include linux/notifier.h for this value.

> +}
> +
>  #ifdef CONFIG_PM
>  static int virtblk_freeze(struct virtio_device *vdev)
>  {
> @@ -961,6 +974,7 @@ static struct virtio_driver virtio_blk = {
>  	.probe			= virtblk_probe,
>  	.remove			= virtblk_remove,
>  	.config_changed		= virtblk_config_changed,
> +	.notify			= virtblk_notify,
>  #ifdef CONFIG_PM
>  	.freeze			= virtblk_freeze,
>  	.restore		= virtblk_restore,
> -- 
> 1.8.3.1
