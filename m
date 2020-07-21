From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 07/10] block: mspro_blk: use
 blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:17:38 +0000
Message-ID: <CY4PR04MB375189EEABA0475AB9460DA0E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-8-mlevitsk@redhat.com>
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
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/memstick/core/mspro_block.c | 6 ++++++=0A=
>  1 file changed, 6 insertions(+)=0A=
> =0A=
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/=
mspro_block.c=0A=
> index cd6b8d4f23350..86c9eb0aef512 100644=0A=
> --- a/drivers/memstick/core/mspro_block.c=0A=
> +++ b/drivers/memstick/core/mspro_block.c=0A=
> @@ -1199,6 +1199,12 @@ static int mspro_block_init_disk(struct memstick_d=
ev *card)=0A=
>  =0A=
>  	msb->page_size =3D be16_to_cpu(sys_info->unit_size);=0A=
>  =0A=
> +	if (!(blk_is_valid_logical_block_size(msb->page_size))) {=0A=
> +		dev_warn(&card->dev,=0A=
> +			 "unsupported block size %d", msb->page_size);=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
>  	mutex_lock(&mspro_block_disk_lock);=0A=
>  	disk_id =3D idr_alloc(&mspro_block_disk_idr, card, 0, 256, GFP_KERNEL);=
=0A=
>  	mutex_unlock(&mspro_block_disk_lock);=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
