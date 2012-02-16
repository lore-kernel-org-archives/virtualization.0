From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH] blkfront: don't change to closing if we're
	busy
Date: Thu, 16 Feb 2012 12:33:32 -0500 (EST)
Message-ID: <7bc7b30a-158e-411a-8eac-9650790c0bec@zmail17.collab.prod.int.phx2.redhat.com>
References: <1329394629-10299-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: xen-devel@lists.xensource.com
Cc: jeremy@goop.org, konrad wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> We just reported to xenbus that we can't close yet, because
> blkfront is still in use. So we shouldn't then immediately
> state that we are closing.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  drivers/block/xen-blkfront.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c
> b/drivers/block/xen-blkfront.c
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

Hmm, I should maybe self-nack this. The bug that led me to writing
it is likely only with older tooling, such as RHEL5's. The problem
was if you attempted to detach a mounted disk twice, then the second
time it would succeed. The guest had flipped to Closing on the first
try, and thus didn't issue an error to xenbus on the second. I see now
in libxl__initiate_device_remove() that it bails out if state != 4,
so that tooling shouldn't have this issue.

The reason I only say maybe self-nack though, is because this state
change seemed to be thrown in with another fix[1]. I'm not sure if
the new behavior on legacy hosts was considered or not. If not, then
we can consider it now. Do we want to have deferred asynch detaches
over protecting the guest from multiple detach calls on legacy hosts?

Drew

[1] b70f5fa blkfront: Lock blkfront_info when closing
