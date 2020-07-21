From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 10/10] block: scsi: sr: use
 blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 11:29:48 +0000
Message-ID: <CY4PR04MB37517861074A4A448180E136E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-11-mlevitsk@redhat.com>
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
> Plus some tiny refactoring.=0A=
> =0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
> ---=0A=
>  drivers/scsi/sr.c | 31 +++++++++++++------------------=0A=
>  1 file changed, 13 insertions(+), 18 deletions(-)=0A=
> =0A=
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c=0A=
> index 0c4aa4665a2f9..0e96338029310 100644=0A=
> --- a/drivers/scsi/sr.c=0A=
> +++ b/drivers/scsi/sr.c=0A=
> @@ -866,31 +866,26 @@ static void get_sectorsize(struct scsi_cd *cd)=0A=
>  			cd->capacity =3D max_t(long, cd->capacity, last_written);=0A=
>  =0A=
>  		sector_size =3D get_unaligned_be32(&buffer[4]);=0A=
> -		switch (sector_size) {=0A=
> -			/*=0A=
> -			 * HP 4020i CD-Recorder reports 2340 byte sectors=0A=
> -			 * Philips CD-Writers report 2352 byte sectors=0A=
> -			 *=0A=
> -			 * Use 2k sectors for them..=0A=
> -			 */=0A=
> -		case 0:=0A=
> -		case 2340:=0A=
> -		case 2352:=0A=
> +=0A=
> +		/*=0A=
> +		 * HP 4020i CD-Recorder reports 2340 byte sectors=0A=
> +		 * Philips CD-Writers report 2352 byte sectors=0A=
> +		 *=0A=
> +		 * Use 2k sectors for them..=0A=
> +		 */=0A=
> +=0A=
=0A=
No need for the blank line here.=0A=
=0A=
> +		if (!sector_size || sector_size =3D=3D 2340 || sector_size =3D=3D 2352=
)=0A=
>  			sector_size =3D 2048;=0A=
> -			/* fall through */=0A=
> -		case 2048:=0A=
> -			cd->capacity *=3D 4;=0A=
> -			/* fall through */=0A=
> -		case 512:=0A=
> -			break;=0A=
> -		default:=0A=
> +=0A=
> +		cd->capacity *=3D (sector_size >> SECTOR_SHIFT);=0A=
=0A=
Where does this come from ? There is no such code in sr get_sectorsize()...=
=0A=
=0A=
> +=0A=
> +		if (!blk_is_valid_logical_block_size(sector_size)) {=0A=
>  			sr_printk(KERN_INFO, cd,=0A=
>  				  "unsupported sector size %d.", sector_size);=0A=
>  			cd->capacity =3D 0;=0A=
>  		}=0A=
>  =0A=
>  		cd->device->sector_size =3D sector_size;=0A=
> -=0A=
=0A=
White line change.=0A=
=0A=
>  		/*=0A=
>  		 * Add this so that we have the ability to correctly gauge=0A=
>  		 * what the device is capable of.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
