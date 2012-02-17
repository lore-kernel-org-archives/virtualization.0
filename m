From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH] blkfront: don't put bdev right after getting
	it
Date: Fri, 17 Feb 2012 07:03:45 -0500 (EST)
Message-ID: <432bdad6-a4f5-44ff-9de6-ccb34f70e1ac@zmail17.collab.prod.int.phx2.redhat.com>
References: <20120216194422.GA8023@andromeda.dapyr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120216194422.GA8023@andromeda.dapyr.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> On Thu, Feb 16, 2012 at 01:16:25PM +0100, Andrew Jones wrote:
> > We should hang onto bdev until we're done with it.
> 
> Looks ok. Is there a BZ that sparked this? Thanks.

Nope. Just came across it while I was looking at the code.

Drew

> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  drivers/block/xen-blkfront.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/block/xen-blkfront.c
> > b/drivers/block/xen-blkfront.c
> > index 2f22874..5d45688 100644
> > --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -1410,7 +1410,6 @@ static int blkif_release(struct gendisk
> > *disk, fmode_t mode)
> >  	mutex_lock(&blkfront_mutex);
> >  
> >  	bdev = bdget_disk(disk, 0);
> > -	bdput(bdev);
> >  
> >  	if (bdev->bd_openers)
> >  		goto out;
> > @@ -1441,6 +1440,7 @@ static int blkif_release(struct gendisk
> > *disk, fmode_t mode)
> >  	}
> >  
> >  out:
> > +	bdput(bdev);
> >  	mutex_unlock(&blkfront_mutex);
> >  	return 0;
> >  }
> > --
> > 1.7.7.5
> > 
> > 
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel@lists.xensource.com
> > http://lists.xensource.com/xen-devel
> 
