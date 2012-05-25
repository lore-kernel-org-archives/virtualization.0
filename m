From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] virtio-blk: Call del_gendisk() before disable guest
	kick
Date: Fri, 25 May 2012 10:07:48 +0300
Message-ID: <20120525070747.GG15474@redhat.com>
References: <1337913289-23486-1-git-send-email-asias@redhat.com>
	<1337913289-23486-2-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1337913289-23486-2-git-send-email-asias@redhat.com>
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

On Fri, May 25, 2012 at 10:34:47AM +0800, Asias He wrote:
> del_gendisk() might not return due to failing to remove the
> /sys/block/vda/serial sysfs entry when another thread (udev) is
> trying to read it.
> 
> virtblk_remove()
>   vdev->config->reset() : guest will not kick us through interrupt
>     del_gendisk()
>       device_del()
>         kobject_del(): got stuck, sysfs entry ref count non zero
> 
> sysfs_open_file(): user space process read /sys/block/vda/serial
>    sysfs_get_active() : got sysfs entry ref count
>       dev_attr_show()
>         virtblk_serial_show()
>            blk_execute_rq() : got stuck, interrupt is disabled
>                               request cannot be finished
> 
> This patch fixes it by calling del_gendisk() before we disable guest's
> interrupt so that the request sent in virtblk_serial_show() will be
> finished and del_gendisk() will success.
> 
> This fixes another race in hot-unplug process.
> 
> It is save to call del_gendisk(vblk->disk) before
> flush_work(&vblk->config_work) which might access vblk->disk, because
> vblk->disk is not freed until put_disk(vblk->disk).
> 
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: Asias He <asias@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 693187d..1bed517 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -584,13 +584,13 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>  	vblk->config_enable = false;
>  	mutex_unlock(&vblk->config_lock);
>  
> +	del_gendisk(vblk->disk);
> +
>  	/* Stop all the virtqueues. */
>  	vdev->config->reset(vdev);
>  
>  	flush_work(&vblk->config_work);
>  
> -	del_gendisk(vblk->disk);
> -
>  	/* Abort requests dispatched to driver. */
>  	spin_lock_irqsave(&vblk->lock, flags);
>  	while ((vbr = virtqueue_detach_unused_buf(vblk->vq))) {
> -- 
> 1.7.10.2
