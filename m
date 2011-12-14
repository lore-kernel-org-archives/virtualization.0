From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] xen-blkfront: Use kcalloc instead of kzalloc to allocate
	array
Date: Wed, 14 Dec 2011 13:56:41 -0500
Message-ID: <20111214185641.GD24598@phenom.dumpdata.com>
References: <1322600880.1534.293.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1322600880.1534.293.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 29, 2011 at 10:08:00PM +0100, Thomas Meyer wrote:
> The advantage of kcalloc is, that will prevent integer overflows which could
> result from the multiplication of number of elements and size and it is also
> a bit nicer to read.
> 
> The semantic patch that makes this change is available
> in https://lkml.org/lkml/2011/11/25/107
> 

Thomas,

I put the xen-blkfront part of the patch in my tree and dropped the cciss_scsi one.

> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/drivers/block/cciss_scsi.c b/drivers/block/cciss_scsi.c
> --- a/drivers/block/cciss_scsi.c 2011-11-28 19:36:47.343430551 +0100
> +++ b/drivers/block/cciss_scsi.c 2011-11-28 19:49:24.922716381 +0100
> @@ -534,10 +534,10 @@ adjust_cciss_scsi_table(ctlr_info_t *h,
>  	int nadded, nremoved;
>  	struct Scsi_Host *sh = NULL;
>  
> -	added = kzalloc(sizeof(*added) * CCISS_MAX_SCSI_DEVS_PER_HBA,
> -			GFP_KERNEL);
> -	removed = kzalloc(sizeof(*removed) * CCISS_MAX_SCSI_DEVS_PER_HBA,
> +	added = kcalloc(CCISS_MAX_SCSI_DEVS_PER_HBA, sizeof(*added),
>  			GFP_KERNEL);
> +	removed = kcalloc(CCISS_MAX_SCSI_DEVS_PER_HBA, sizeof(*removed),
> +			  GFP_KERNEL);
>  
>  	if (!added || !removed) {
>  		dev_warn(&h->pdev->dev,
> @@ -1191,8 +1191,8 @@ cciss_update_non_disk_devices(ctlr_info_
>  
>  	ld_buff = kzalloc(reportlunsize, GFP_KERNEL);
>  	inq_buff = kmalloc(OBDR_TAPE_INQ_SIZE, GFP_KERNEL);
> -	currentsd = kzalloc(sizeof(*currentsd) *
> -			(CCISS_MAX_SCSI_DEVS_PER_HBA+1), GFP_KERNEL);
> +	currentsd = kcalloc(CCISS_MAX_SCSI_DEVS_PER_HBA + 1,
> +			    sizeof(*currentsd), GFP_KERNEL);
>  	if (ld_buff == NULL || inq_buff == NULL || currentsd == NULL) {
>  		printk(KERN_ERR "cciss: out of memory\n");
>  		goto out;
> diff -u -p a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> --- a/drivers/block/xen-blkfront.c 2011-11-13 11:07:22.680095573 +0100
> +++ b/drivers/block/xen-blkfront.c 2011-11-28 19:49:29.109460410 +0100
> @@ -156,7 +156,7 @@ static int xlbd_reserve_minors(unsigned
>  	if (end > nr_minors) {
>  		unsigned long *bitmap, *old;
>  
> -		bitmap = kzalloc(BITS_TO_LONGS(end) * sizeof(*bitmap),
> +		bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
>  				 GFP_KERNEL);
>  		if (bitmap == NULL)
>  			return -ENOMEM;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
