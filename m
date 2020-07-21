From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 03/10] block: loop: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:08:40 +0000
Message-ID: <CY4PR04MB375172789B9725F132B94216E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-4-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-block-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <Ajay.Joshi@wdc.com>, Ming Lei <ming.lei@redhat.>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/07/21 19:54, Maxim Levitsky wrote:=0A=
> This allows to remove loop's own check for supported block size=0A=
> =0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/block/loop.c | 23 +++++------------------=0A=
>  1 file changed, 5 insertions(+), 18 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c=0A=
> index 475e1a738560d..9984c8f824271 100644=0A=
> --- a/drivers/block/loop.c=0A=
> +++ b/drivers/block/loop.c=0A=
> @@ -228,19 +228,6 @@ static void __loop_update_dio(struct loop_device *lo=
, bool dio)=0A=
>  		blk_mq_unfreeze_queue(lo->lo_queue);=0A=
>  }=0A=
>  =0A=
> -/**=0A=
> - * loop_validate_block_size() - validates the passed in block size=0A=
> - * @bsize: size to validate=0A=
> - */=0A=
> -static int=0A=
> -loop_validate_block_size(unsigned short bsize)=0A=
> -{=0A=
> -	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))=0A=
> -		return -EINVAL;=0A=
> -=0A=
> -	return 0;=0A=
> -}=0A=
> -=0A=
>  /**=0A=
>   * loop_set_size() - sets device size and notifies userspace=0A=
>   * @lo: struct loop_device to set the size for=0A=
> @@ -1119,9 +1106,10 @@ static int loop_configure(struct loop_device *lo, =
fmode_t mode,=0A=
>  	}=0A=
>  =0A=
>  	if (config->block_size) {=0A=
> -		error =3D loop_validate_block_size(config->block_size);=0A=
> -		if (error)=0A=
> +		if (!blk_is_valid_logical_block_size(config->block_size)) {=0A=
> +			error =3D -EINVAL;=0A=
>  			goto out_unlock;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	error =3D loop_set_status_from_info(lo, &config->info);=0A=
> @@ -1607,9 +1595,8 @@ static int loop_set_block_size(struct loop_device *=
lo, unsigned long arg)=0A=
>  	if (lo->lo_state !=3D Lo_bound)=0A=
>  		return -ENXIO;=0A=
>  =0A=
> -	err =3D loop_validate_block_size(arg);=0A=
> -	if (err)=0A=
> -		return err;=0A=
> +	if (!blk_is_valid_logical_block_size(arg))=0A=
> +		return -EINVAL;=0A=
>  =0A=
>  	if (lo->lo_queue->limits.logical_block_size =3D=3D arg)=0A=
>  		return 0;=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
