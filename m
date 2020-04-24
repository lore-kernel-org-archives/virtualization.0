From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Date: Fri, 24 Apr 2020 10:41:58 +0200
Message-ID: <20200424084158.uayekt5c3lus4532@steredhat>
References: <20200423123717.139141-1-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200423123717.139141-1-stefanha@redhat.com>
Sender: linux-block-owner@vger.kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux-foundation.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Lance Digby <ldigby@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 23, 2020 at 01:37:17PM +0100, Stefan Hajnoczi wrote:
> A virtio_blk block device can still be referenced after hot unplug by
> userspace processes that hold the file descriptor.  In this case
> virtblk_getgeo() can be invoked after virtblk_remove() was called.  For
> example, a program that has /dev/vdb open can call ioctl(HDIO_GETGEO)
> after hot unplug.
> 
> Fix this by clearing vblk->disk->private_data and checking that the
> virtio_blk driver instance is still around in virtblk_getgeo().
> 
> Note that the virtblk_getgeo() function itself is guaranteed to remain
> in memory after hot unplug because the virtio_blk module refcount is
> still held while a block device reference exists.
> 
> Originally-by: Lance Digby <ldigby@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 93468b7c6701..b50cdf37a6f7 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -300,6 +300,10 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
>  	struct virtio_blk *vblk = bd->bd_disk->private_data;
>  
> +	/* Driver instance has been removed */
> +	if (!vblk)
> +		return -ENOTTY;
> +
>  	/* see if the host passed in geometry config */
>  	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
>  		virtio_cread(vblk->vdev, struct virtio_blk_config,
> @@ -835,6 +839,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	vdev->config->reset(vdev);
>  
>  	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);
> +	vblk->disk->private_data = NULL;
>  	put_disk(vblk->disk);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);

As pointed out, can be a race. We had a very similar issue in
virtio-vsock, and we solved using RCU to assign and get the pointer [1],
maybe the same solution can work here.

Cheers,
Stefano

[1] 0deab087b16a vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock
