From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 04/10] block: nbd: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:09:15 +0000
Message-ID: <CY4PR04MB3751EED308BB3AE6E028E3DFE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-5-mlevitsk@redhat.com>
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
> This allows to remove nbd's own check for valid block size=0A=
> =0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/block/nbd.c | 12 ++----------=0A=
>  1 file changed, 2 insertions(+), 10 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c=0A=
> index ce7e9f223b20b..2cd9c4e824f8b 100644=0A=
> --- a/drivers/block/nbd.c=0A=
> +++ b/drivers/block/nbd.c=0A=
> @@ -1347,14 +1347,6 @@ static void nbd_clear_sock_ioctl(struct nbd_device=
 *nbd,=0A=
>  		nbd_config_put(nbd);=0A=
>  }=0A=
>  =0A=
> -static bool nbd_is_valid_blksize(unsigned long blksize)=0A=
> -{=0A=
> -	if (!blksize || !is_power_of_2(blksize) || blksize < 512 ||=0A=
> -	    blksize > PAGE_SIZE)=0A=
> -		return false;=0A=
> -	return true;=0A=
> -}=0A=
> -=0A=
>  static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)=0A=
>  {=0A=
>  	nbd->tag_set.timeout =3D timeout * HZ;=0A=
> @@ -1379,7 +1371,7 @@ static int __nbd_ioctl(struct block_device *bdev, s=
truct nbd_device *nbd,=0A=
>  	case NBD_SET_BLKSIZE:=0A=
>  		if (!arg)=0A=
>  			arg =3D NBD_DEF_BLKSIZE;=0A=
> -		if (!nbd_is_valid_blksize(arg))=0A=
> +		if (!blk_is_valid_logical_block_size(arg))=0A=
>  			return -EINVAL;=0A=
>  		nbd_size_set(nbd, arg,=0A=
>  			     div_s64(config->bytesize, arg));=0A=
> @@ -1811,7 +1803,7 @@ static int nbd_genl_size_set(struct genl_info *info=
, struct nbd_device *nbd)=0A=
>  		bsize =3D nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);=0A=
>  		if (!bsize)=0A=
>  			bsize =3D NBD_DEF_BLKSIZE;=0A=
> -		if (!nbd_is_valid_blksize(bsize)) {=0A=
> +		if (!blk_is_valid_logical_block_size(bsize)) {=0A=
>  			printk(KERN_ERR "Invalid block size %llu\n", bsize);=0A=
>  			return -EINVAL;=0A=
>  		}=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
