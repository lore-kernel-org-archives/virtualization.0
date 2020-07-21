From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 02/10] block: virtio-blk: check logical block size
Date: Tue, 21 Jul 2020 11:07:36 +0000
Message-ID: <CY4PR04MB375159E32C34FD487EB33C5CE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-3-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <Ajay.Joshi@wdc.com>, Ming Lei <ming.lei@redhat.>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/07/21 19:54, Maxim Levitsky wrote:=0A=
> Linux kernel only supports logical block sizes which are power of two,=0A=
> at least 512 bytes and no more that PAGE_SIZE.=0A=
> =0A=
> Check this instead of crashing later on.=0A=
> =0A=
> Note that there is no need to check physical block size since it is=0A=
> only a hint, and virtio-blk already only supports power of two values.=0A=
> =0A=
> Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1664619=0A=
> =0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/block/virtio_blk.c | 15 +++++++++++++--=0A=
>  1 file changed, 13 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c=0A=
> index 980df853ee497..b5ee87cba00ed 100644=0A=
> --- a/drivers/block/virtio_blk.c=0A=
> +++ b/drivers/block/virtio_blk.c=0A=
> @@ -809,10 +809,18 @@ static int virtblk_probe(struct virtio_device *vdev=
)=0A=
>  	err =3D virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,=0A=
>  				   struct virtio_blk_config, blk_size,=0A=
>  				   &blk_size);=0A=
> -	if (!err)=0A=
> +	if (!err) {=0A=
> +		if (!blk_is_valid_logical_block_size(blk_size)) {=0A=
> +			dev_err(&vdev->dev,=0A=
> +				"%s failure: invalid logical block size %d\n",=0A=
> +				__func__, blk_size);=0A=
> +			err =3D -EINVAL;=0A=
> +			goto out_cleanup_queue;=0A=
> +		}=0A=
>  		blk_queue_logical_block_size(q, blk_size);=0A=
> -	else=0A=
> +	} else {=0A=
>  		blk_size =3D queue_logical_block_size(q);=0A=
> +	}=0A=
>  =0A=
>  	/* Use topology information if available */=0A=
>  	err =3D virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,=0A=
> @@ -872,6 +880,9 @@ static int virtblk_probe(struct virtio_device *vdev)=
=0A=
>  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);=0A=
>  	return 0;=0A=
>  =0A=
> +out_cleanup_queue:=0A=
> +	blk_cleanup_queue(vblk->disk->queue);=0A=
> +	vblk->disk->queue =3D NULL;=0A=
>  out_free_tags:=0A=
>  	blk_mq_free_tag_set(&vblk->tag_set);=0A=
>  out_put_disk:=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
