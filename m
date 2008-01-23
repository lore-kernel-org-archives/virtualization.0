From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_blk: provide getgeo
Date: Thu, 24 Jan 2008 09:06:47 +1100
Message-ID: <200801240906.47658.rusty@rustcorp.com.au>
References: <200801231756.50224.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801231756.50224.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 24 January 2008 03:56:50 Christian Borntraeger wrote:
> Rusty,
>
> I currently try to make my guest boot from an virtio root device
> without having an external kernel. Some of the tools that I tried
> expect HDIO_GETGEO to work. The most interesting value is likely
> the geo.start value to get the offset of a partition. This value
> is filled by block/ioctl.c if fops->getgeo is set. This patch also
> fills in some standard values for heads, sectors and cylinders.
>
> Makes sense?

Perfect sense, applied.

I wonder if there's a standard helper for this?

> +/* We provide getgeo only to please some old bootloader/partitioning tools
> */ +static int virtblk_getgeo(struct block_device *bd, struct hd_geometry
> *geo) +{
> +	/* some standard values, similar to sd */
> +	geo->heads = 1 << 6;
> +	geo->sectors = 1 << 5;
> +	geo->cylinders = get_capacity(bd->bd_disk) >> 11;
> +	return 0;
> +}

Thanks,
Rusty.
