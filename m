From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH v2] blkfront: don't change to closing if
	we're	busy
Date: Mon, 20 Feb 2012 13:26:13 -0500 (EST)
Message-ID: <564062b4-ee3a-46b7-b0f3-1d861175af7d@zmail17.collab.prod.int.phx2.redhat.com>
References: <1329497959-19427-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1329497959-19427-1-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: jeremy@goop.org, konrad wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> We just reported to xenbus that we can't close yet, because we're
> still
> in use. So we shouldn't then immediately tell xenbus that we are
> closing. If we do, then we risk bypassing the chance to complain
> again,
> if we're told to close again, and we're still in use. The reason this
> code was here was to implement a deferred close. We can still support
> this feature by adding a member to our private data, and setting that
> instead. Besides being able to complain each time, this patch fixes
> a problem when running on hosts with legacy tools that may interpret
> the lack of a complaint or state=Closing incorrectly, and then yank
> the device out from under the guest.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  drivers/block/xen-blkfront.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c
> b/drivers/block/xen-blkfront.c
> index 2f22874..d7f2e03 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -103,6 +103,7 @@ struct blkfront_info
>  	unsigned int discard_granularity;
>  	unsigned int discard_alignment;
>  	int is_ready;
> +	int closing;
>  };
>  
>  static DEFINE_SPINLOCK(blkif_io_lock);
> @@ -1134,7 +1135,7 @@ blkfront_closing(struct blkfront_info *info)
>  	if (bdev->bd_openers) {
>  		xenbus_dev_error(xbdev, -EBUSY,
>  				 "Device in use; refusing to close");
> -		xenbus_switch_state(xbdev, XenbusStateClosing);
> +		info->closing = 1;
>  	} else {
>  		xlvbd_release_gendisk(info);
>  		xenbus_frontend_closed(xbdev);
> @@ -1423,8 +1424,10 @@ static int blkif_release(struct gendisk *disk,
> fmode_t mode)
>  	mutex_lock(&info->mutex);
>  	xbdev = info->xbdev;
>  
> -	if (xbdev && xbdev->state == XenbusStateClosing) {
> +	if (xbdev && (xbdev->state == XenbusStateClosing || info->closing))

Ugh. This isn't right either. After discussing with Igor Mammedov, I
see that I missed that xbdev->state will now never be XenbusStateClosing.
We need the xenbus_read_driver_state() to come back for getting the
state (that was also changed with 7fd152f4b6ae).

However, I'm starting to wonder if supporting "deferred detach" is
worth the complexity. If we took a pass through xen-blkfront.c and
removed all code related to it, and perhaps also all code related to a
"forced detach", then I suspect the driver could be nicely simplified.

Do we need deferred and forced detach support? Forced seems like a bad
idea. For what would a guest use a disk that could disappear with little
notice? Deferred also seems strange. It seems like the host and guest
admins should generally better coordinate and synchronize these types
of activities. It's possible there are good usecases that I'm missing.
I'd be happy to hear examples.

Thanks,
Drew

> {
>  		/* pending switch to state closed */
> +		if (xbdev->state != XenbusStateClosing)
> +			xenbus_switch_state(xbdev, XenbusStateClosing);
>  		dev_info(disk_to_dev(bdev->bd_disk), "releasing disk\n");
>  		xlvbd_release_gendisk(info);
>  		xenbus_frontend_closed(info->xbdev);
> --
> 1.7.7.5
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
> 
