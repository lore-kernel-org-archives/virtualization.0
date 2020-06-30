From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] virtio-blk: free vblk-vqs in error path of
 virtblk_probe()
Date: Wed, 1 Jul 2020 06:30:12 +0800
Message-ID: <20200630223012.GA2251557@T590>
References: <20200615041459.22477-1-houtao1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200615041459.22477-1-houtao1@huawei.com>
Sender: linux-block-owner@vger.kernel.org
To: Hou Tao <houtao1@huawei.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 15, 2020 at 12:14:59PM +0800, Hou Tao wrote:
> Else there will be memory leak if alloc_disk() fails.
> 
> Fixes: 6a27b656fc02 ("block: virtio-blk: support multi virt queues per virtio-blk device")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/block/virtio_blk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9d21bf0f155e..980df853ee49 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -878,6 +878,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	put_disk(vblk->disk);
>  out_free_vq:
>  	vdev->config->del_vqs(vdev);
> +	kfree(vblk->vqs);
>  out_free_vblk:
>  	kfree(vblk);
>  out_free_index:
> -- 
> 2.25.0.4.g0ad7144999
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
