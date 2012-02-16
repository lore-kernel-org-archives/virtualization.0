From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [Xen-devel] [PATCH] blkfront: don't change to closing if we're
	busy
Date: Thu, 16 Feb 2012 15:48:01 -0400
Message-ID: <20120216194801.GB8023@andromeda.dapyr.net>
References: <1329394629-10299-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1329394629-10299-1-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 16, 2012 at 01:17:09PM +0100, Andrew Jones wrote:
> We just reported to xenbus that we can't close yet, because
> blkfront is still in use. So we shouldn't then immediately
> state that we are closing.

What happens if the user uses --force to unplug the device?
Will that still work?
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  drivers/block/xen-blkfront.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 5d45688..b53cae4 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -1134,7 +1134,6 @@ blkfront_closing(struct blkfront_info *info)
>  	if (bdev->bd_openers) {
>  		xenbus_dev_error(xbdev, -EBUSY,
>  				 "Device in use; refusing to close");
> -		xenbus_switch_state(xbdev, XenbusStateClosing);
>  	} else {
>  		xlvbd_release_gendisk(info);
>  		xenbus_frontend_closed(xbdev);
> -- 
> 1.7.7.5
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
