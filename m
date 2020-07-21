From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 09/10] block: scsi: sd: use
 blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:25:06 +0000
Message-ID: <CY4PR04MB375113B7D781BF2949FE5B33E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-10-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-block-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <Ajay.Joshi@wdc.com>, Ming Lei <ming.lei@redhat.>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/07/21 19:55, Maxim Levitsky wrote:=0A=
> Use blk_is_valid_logical_block_size instead of hardcoded list=0A=
=0A=
s/hardcoded list/hardcoded checks./=0A=
=0A=
> =0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/scsi/sd.c | 5 +----=0A=
>  1 file changed, 1 insertion(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
> index d90fefffe31b7..f012e7397b058 100644=0A=
> --- a/drivers/scsi/sd.c=0A=
> +++ b/drivers/scsi/sd.c=0A=
> @@ -2520,10 +2520,7 @@ sd_read_capacity(struct scsi_disk *sdkp, unsigned =
char *buffer)=0A=
>  			  "assuming 512.\n");=0A=
>  	}=0A=
>  =0A=
> -	if (sector_size !=3D 512 &&=0A=
> -	    sector_size !=3D 1024 &&=0A=
> -	    sector_size !=3D 2048 &&=0A=
> -	    sector_size !=3D 4096) {=0A=
> +	if (!blk_is_valid_logical_block_size(sector_size)) {=0A=
>  		sd_printk(KERN_NOTICE, sdkp, "Unsupported sector size %d.\n",=0A=
>  			  sector_size);=0A=
>  		/*=0A=
> =0A=
=0A=
With the commit message fixed, looks OK.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
