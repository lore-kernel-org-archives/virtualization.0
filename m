From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 06/10] block: ms_block: use
 blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:17:01 +0000
Message-ID: <CY4PR04MB37515103AF92B1BB196ED494E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-7-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <Ajay.Joshi@wdc.com>, Ming Lei <ming.lei@redhat.>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/07/21 19:54, Maxim Levitsky wrote:=0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/memstick/core/ms_block.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c=0A=
> index d9ee8e3dc72da..e4df03e10fb46 100644=0A=
> --- a/drivers/memstick/core/ms_block.c=0A=
> +++ b/drivers/memstick/core/ms_block.c=0A=
> @@ -1727,7 +1727,7 @@ static int msb_init_card(struct memstick_dev *card)=
=0A=
>  	msb->pages_in_block =3D boot_block->attr.block_size * 2;=0A=
>  	msb->block_size =3D msb->page_size * msb->pages_in_block;=0A=
>  =0A=
> -	if (msb->page_size > PAGE_SIZE) {=0A=
> +	if (!(blk_is_valid_logical_block_size(msb->page_size))) {=0A=
>  		/* this isn't supported by linux at all, anyway*/=0A=
>  		dbg("device page %d size isn't supported", msb->page_size);=0A=
>  		return -EINVAL;=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
