From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] add virtio disk geometry feature
Date: Wed, 16 Apr 2008 16:32:30 -0500
Message-ID: <4806706E.10701__21121.3651499294$1208381801$gmane$org@us.ibm.com>
References: <1208372197-20815-1-git-send-email-ryanh@us.ibm.com>
	<200804170715.55041.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804170715.55041.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Hollis Blanchard <hollisb@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Thursday 17 April 2008 04:56:37 Ryan Harper wrote:
>   
>> From: Ryan Harper <ryanh@us.ibm.com>
>>
>> Rather than faking up some geometry, allow the backend to push the disk
>> geometry via virtio pci config option.  Keep the old geo code around for
>> compatibility.
>>     
>
> Hi Ryan,
>
>    Looks good! Some brief review below.  Mainly just "how I would have done
> things" stuff.  BTW, does this help in real life?  I assume something in
> userspace wants it?
>   

Boot loaders (like grub) query the geometry from the kernel to figure 
out how to setup the stage1/stage2.  We've seen strange issues with grub 
thinking it has crazy geometries when installed on a virtio disk (as 
opposed to booting from virtio with an existing disk).

Ryan: have you tested a hardy install with your patches?  Does it help 
when installing to virtio?  I could pretty reliably reproduce the 
strangeness with a 20GB disk image FWIW.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -157,10 +157,25 @@ static int virtblk_ioctl(struct inode *i
>  /* We provide getgeo only to please some old bootloader/partitioning tools */
>  static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
> -	/* some standard values, similar to sd */
> -	geo->heads = 1 << 6;
> -	geo->sectors = 1 << 5;
> -	geo->cylinders = get_capacity(bd->bd_disk) >> 11;
> +	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	struct virtio_blk_geometry vgeo;
> +	int err;
> +
> +	/* see if the host passed in geometry config */
> +	err = virtio_config_val(vblk->vdev, VIRTIO_BLK_F_GEOMETRY,
> +				offsetof(struct virtio_blk_config, geometry),
> +				&vgeo);
> +
> +	if (!err) {
> +		geo->heads = vgeo.heads;
> +		geo->sectors = vgeo.sectors;
> +		geo->cylinders = vgeo.cylinders;
> +	} else {
> +		/* some standard values, similar to sd */
> +		geo->heads = 1 << 6;
> +		geo->sectors = 1 << 5;
> +		geo->cylinders = get_capacity(bd->bd_disk) >> 11;
> +	}
>  	return 0;
>  }
>   

You're probably breaking PPC since the values in the config space are in 
little endian format.  virtio_config_val does automagic endianness 
conversion if the size is 2, 4, or 8.  In this case, the structure size 
is 4 so the endianness conversion will do the wrong thing.

Magic endianness conversion based on read size is looking pretty evil to 
me... Perhaps we need explicit *_val[8,16,32,64]?

Regards,

Anthony Liguori
