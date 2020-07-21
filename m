From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 08/10] block: nvme: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:23:36 +0000
Message-ID: <CY4PR04MB3751AA85412F2B654286ED2BE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-9-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <Ajay.Joshi@wdc.com>, Ming Lei <ming.lei@redhat.>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/07/21 19:55, Maxim Levitsky wrote:=0A=
> This replaces manual checking in the driver=0A=
> =0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/nvme/host/core.c | 17 ++++++++---------=0A=
>  1 file changed, 8 insertions(+), 9 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index add040168e67e..8014b3046992a 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1849,10 +1849,16 @@ static void nvme_update_disk_info(struct gendisk =
*disk,=0A=
>  	unsigned short bs =3D 1 << ns->lba_shift;=0A=
>  	u32 atomic_bs, phys_bs, io_opt =3D 0;=0A=
>  =0A=
> -	if (ns->lba_shift > PAGE_SHIFT) {=0A=
> -		/* unsupported block size, set capacity to 0 later */=0A=
> +	/*=0A=
> +	 * The block layer can't support LBA sizes larger than the page size=0A=
> +	 * yet, so catch this early and don't allow block I/O.=0A=
> +	 */=0A=
> +=0A=
=0A=
No need for the blank line here.=0A=
=0A=
> +	if (!blk_is_valid_logical_block_size(bs)) {=0A=
>  		bs =3D (1 << 9);=0A=
> +		capacity =3D 0;>  	}=0A=
> +=0A=
>  	blk_mq_freeze_queue(disk->queue);=0A=
>  	blk_integrity_unregister(disk);=0A=
>  =0A=
> @@ -1887,13 +1893,6 @@ static void nvme_update_disk_info(struct gendisk *=
disk,=0A=
>  	blk_queue_io_min(disk->queue, phys_bs);=0A=
>  	blk_queue_io_opt(disk->queue, io_opt);=0A=
>  =0A=
> -	/*=0A=
> -	 * The block layer can't support LBA sizes larger than the page size=0A=
> -	 * yet, so catch this early and don't allow block I/O.=0A=
> -	 */=0A=
> -	if (ns->lba_shift > PAGE_SHIFT)=0A=
> -		capacity =3D 0;=0A=
> -=0A=
>  	/*=0A=
>  	 * Register a metadata profile for PI, or the plain non-integrity NVMe=
=0A=
>  	 * metadata masquerading as Type 0 if supported, otherwise reject block=
=0A=
> =0A=
=0A=
Apart from the nit above, this looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
