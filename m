From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 05/10] block: null: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:15:51 +0000
Message-ID: <CY4PR04MB3751882A6BDF7C073D6ECF88E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-6-mlevitsk@redhat.com>
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
> This slightly changes the behavier of the driver,=0A=
=0A=
s/behavier/behavior=0A=
=0A=
> when given invalid block size (non power of two, or below 512 bytes),=0A=
> but shoudn't matter.=0A=
> =0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/block/null_blk_main.c | 6 +++---=0A=
>  1 file changed, 3 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 87b31f9ca362e..e4df4b903b90b 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1684,8 +1684,8 @@ static int null_init_tag_set(struct nullb *nullb, s=
truct blk_mq_tag_set *set)=0A=
>  =0A=
>  static int null_validate_conf(struct nullb_device *dev)=0A=
>  {=0A=
> -	dev->blocksize =3D round_down(dev->blocksize, 512);=0A=
> -	dev->blocksize =3D clamp_t(unsigned int, dev->blocksize, 512, 4096);=0A=
> +	if (!blk_is_valid_logical_block_size(dev->blocksize))=0A=
> +		return -ENODEV;=0A=
>  =0A=
>  	if (dev->queue_mode =3D=3D NULL_Q_MQ && dev->use_per_node_hctx) {=0A=
>  		if (dev->submit_queues !=3D nr_online_nodes)=0A=
> @@ -1865,7 +1865,7 @@ static int __init null_init(void)=0A=
>  	struct nullb *nullb;=0A=
>  	struct nullb_device *dev;=0A=
>  =0A=
> -	if (g_bs > PAGE_SIZE) {=0A=
> +	if (!blk_is_valid_logical_block_size(g_bs)) {=0A=
>  		pr_warn("invalid block size\n");=0A=
>  		pr_warn("defaults block size to %lu\n", PAGE_SIZE);=0A=
>  		g_bs =3D PAGE_SIZE;=0A=
=0A=
Not sure if this change is OK. Shouldn't the if here be kept as is and=0A=
blk_is_valid_logical_block_size() called after it to check values lower tha=
n 4K ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
