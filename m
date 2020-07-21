From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 01/10] block: introduce blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:05:55 +0000
Message-ID: <CY4PR04MB37512BDEFD7B977FCD32A10AE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-2-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <Ajay.Joshi@wdc.com>, Ming Lei <ming.lei@redhat.>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/07/21 19:53, Maxim Levitsky wrote:=0A=
> Kernel block layer has never supported logical block=0A=
> sizes less that SECTOR_SIZE nor larger that PAGE_SIZE.=0A=
> =0A=
> Some drivers have runtime configurable block size,=0A=
> so it makes sense to have common helper for that.=0A=
=0A=
...common helper to check the validity of the logical block size set by the=
 driver.=0A=
=0A=
("for that" does not refer to a clear action)=0A=
=0A=
> =0A=
> Signed-off-by: Maxim Levitsky  <mlevitsk@redhat.com>=0A=
> ---=0A=
>  block/blk-settings.c   | 18 ++++++++++++++++++=0A=
>  include/linux/blkdev.h |  1 +=0A=
>  2 files changed, 19 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 9a2c23cd97007..3c4ef0d00c2bc 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -311,6 +311,21 @@ void blk_queue_max_segment_size(struct request_queue=
 *q, unsigned int max_size)=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_max_segment_size);=0A=
>  =0A=
> +=0A=
> +/**=0A=
> + * blk_check_logical_block_size - check if logical block size is support=
ed=0A=
> + * by the kernel=0A=
> + * @size:  the logical block size, in bytes=0A=
> + *=0A=
> + * Description:=0A=
> + *   This function checks if the block layers supports given block size=
=0A=
> + **/=0A=
> +bool blk_is_valid_logical_block_size(unsigned int size)=0A=
> +{=0A=
> +	return size >=3D SECTOR_SIZE && size <=3D PAGE_SIZE && !is_power_of_2(s=
ize);=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_is_valid_logical_block_size);=0A=
> +=0A=
>  /**=0A=
>   * blk_queue_logical_block_size - set logical block size for the queue=
=0A=
>   * @q:  the request queue for the device=0A=
> @@ -323,6 +338,8 @@ EXPORT_SYMBOL(blk_queue_max_segment_size);=0A=
>   **/=0A=
>  void blk_queue_logical_block_size(struct request_queue *q, unsigned int =
size)=0A=
>  {=0A=
> +	WARN_ON(!blk_is_valid_logical_block_size(size));=0A=
> +=0A=
>  	q->limits.logical_block_size =3D size;=0A=
>  =0A=
>  	if (q->limits.physical_block_size < size)=0A=
> @@ -330,6 +347,7 @@ void blk_queue_logical_block_size(struct request_queu=
e *q, unsigned int size)=0A=
>  =0A=
>  	if (q->limits.io_min < q->limits.physical_block_size)=0A=
>  		q->limits.io_min =3D q->limits.physical_block_size;=0A=
> +=0A=
=0A=
white line change.=0A=
=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_logical_block_size);=0A=
>  =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 57241417ff2f8..2ed3151397e41 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1099,6 +1099,7 @@ extern void blk_queue_max_write_same_sectors(struct=
 request_queue *q,=0A=
>  		unsigned int max_write_same_sectors);=0A=
>  extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,=
=0A=
>  		unsigned int max_write_same_sectors);=0A=
> +extern bool blk_is_valid_logical_block_size(unsigned int size);=0A=
>  extern void blk_queue_logical_block_size(struct request_queue *, unsigne=
d int);=0A=
>  extern void blk_queue_max_zone_append_sectors(struct request_queue *q,=
=0A=
>  		unsigned int max_zone_append_sectors);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
