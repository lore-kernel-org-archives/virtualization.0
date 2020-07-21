From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/10] block: virtio-blk: check logical block size
Date: Tue, 21 Jul 2020 17:14:37 +0200
Message-ID: <20200721151437.GB10620@lst.de>
References: <20200721105239.8270-1-mlevitsk@redhat.com> <20200721105239.8270-3-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721105239.8270-3-mlevitsk@redhat.com>
Sender: linux-block-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 21, 2020 at 01:52:31PM +0300, Maxim Levitsky wrote:
> Linux kernel only supports logical block sizes which are power of two,
> at least 512 bytes and no more that PAGE_SIZE.
> 
> Check this instead of crashing later on.
> 
> Note that there is no need to check physical block size since it is
> only a hint, and virtio-blk already only supports power of two values.
> 
> Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 980df853ee497..b5ee87cba00ed 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -809,10 +809,18 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err) {
> +		if (!blk_is_valid_logical_block_size(blk_size)) {
> +			dev_err(&vdev->dev,
> +				"%s failure: invalid logical block size %d\n",
> +				__func__, blk_size);
> +			err = -EINVAL;
> +			goto out_cleanup_queue;
> +		}
>  		blk_queue_logical_block_size(q, blk_size);

Hmm, I wonder if we should simply add the check and warning to
blk_queue_logical_block_size and add an error in that case.  Then
drivers only have to check the error return, which might add a lot
less boiler plate code.
