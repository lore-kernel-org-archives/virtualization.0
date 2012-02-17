From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] blkfront: don't change to closing if we're
	busy
Date: Fri, 17 Feb 2012 10:20:04 -0500
Message-ID: <20120217152004.GB30298@phenom.dumpdata.com>
References: <20120216194801.GB8023@andromeda.dapyr.net>
	<df073550-b049-4522-ac03-8f4ffcea426c@zmail17.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <df073550-b049-4522-ac03-8f4ffcea426c@zmail17.collab.prod.int.phx2.redhat.com>
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
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 17, 2012 at 07:50:11AM -0500, Andrew Jones wrote:
> 
> 
> ----- Original Message -----
> > On Thu, Feb 16, 2012 at 01:17:09PM +0100, Andrew Jones wrote:
> > > We just reported to xenbus that we can't close yet, because
> > > blkfront is still in use. So we shouldn't then immediately
> > > state that we are closing.
> > 
> > What happens if the user uses --force to unplug the device?
> > Will that still work?
> 
> With RHEL5 tooling I get the same results. That is, the device
> is forcibly detached, and then any task in the guest that still
> attempts to use (or even just unmount) the device hangs.
> 
> I don't know anything about xl, but afaict block-detach
> doesn't take a 'force' option?

konrad@phenom:~/ssd/linux$ xm block-detach
xend [ERROR] Config file does not exist: /etc/xen/xend-config.sxp
Error: 'xm block-detach' requires between 2 and 3 arguments.

Usage: xm block-detach <Domain> <DevId> [-f|--force]

Destroy a domain's virtual block device.


> 
> Drew
> 
> > > 
> > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > ---
> > >  drivers/block/xen-blkfront.c |    1 -
> > >  1 files changed, 0 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/block/xen-blkfront.c
> > > b/drivers/block/xen-blkfront.c
> > > index 5d45688..b53cae4 100644
> > > --- a/drivers/block/xen-blkfront.c
> > > +++ b/drivers/block/xen-blkfront.c
> > > @@ -1134,7 +1134,6 @@ blkfront_closing(struct blkfront_info *info)
> > >  	if (bdev->bd_openers) {
> > >  		xenbus_dev_error(xbdev, -EBUSY,
> > >  				 "Device in use; refusing to close");
> > > -		xenbus_switch_state(xbdev, XenbusStateClosing);
> > >  	} else {
> > >  		xlvbd_release_gendisk(info);
> > >  		xenbus_frontend_closed(xbdev);
> > > --
> > > 1.7.7.5
> > > 
> > > 
> > > _______________________________________________
> > > Xen-devel mailing list
> > > Xen-devel@lists.xensource.com
> > > http://lists.xensource.com/xen-devel
> > 
