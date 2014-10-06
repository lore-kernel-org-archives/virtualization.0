From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 06/16] virtio_blk: drop config_enable
Date: Mon, 6 Oct 2014 13:42:29 +0200
Message-ID: <20141006134229.45465bf7.cornelia.huck@de.ibm.com>
References: <1412525038-15871-1-git-send-email-mst@redhat.com>
	<1412525038-15871-7-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412525038-15871-7-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 5 Oct 2014 19:07:07 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Now that virtio core ensures config changes don't
> arrive during probing, drop config_enable flag
> in virtio blk.
> On removal, flush is now sufficient to guarantee that
> no change work is queued.
> 
> This help simplify the driver, and will allow
> setting DRIVER_OK earlier without losing config
> change notifications.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 0a58140..c8cf6a1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c

> @@ -772,9 +766,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	int refc;
> 
>  	/* Prevent config work handler from accessing the device. */

/* Common code ensures no further work will be queued. */

instead?

> -	mutex_lock(&vblk->config_lock);
> -	vblk->config_enable = false;
> -	mutex_unlock(&vblk->config_lock);
> +	flush_work(&vblk->config_work);
> 
>  	del_gendisk(vblk->disk);
>  	blk_cleanup_queue(vblk->disk->queue);

> @@ -806,10 +796,6 @@ static int virtblk_freeze(struct virtio_device *vdev)
>  	vdev->config->reset(vdev);
> 
>  	/* Prevent config work handler from accessing the device. */

dito on the comment

> -	mutex_lock(&vblk->config_lock);
> -	vblk->config_enable = false;
> -	mutex_unlock(&vblk->config_lock);
> -
>  	flush_work(&vblk->config_work);
> 
>  	blk_mq_stop_hw_queues(vblk->disk->queue);
