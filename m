From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] xen block: remove driver_data direct access of struct
	device
Date: Thu, 30 Apr 2009 15:37:57 -0700
Message-ID: <20090430223757.GB16369@kroah.com>
References: <20090430222448.GA18690@kroah.com>
	<20090430223535.GO3036@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090430223535.GO3036@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 30, 2009 at 03:35:35PM -0700, Chris Wright wrote:
> * Greg Kroah-Hartman (gregkh@suse.de) wrote:
> > In the near future, the driver core is going to not allow direct access
> > to the driver_data pointer in struct device.  Instead, the functions
> > dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> > have been around since the beginning, so are backwards compatible with
> > all older kernel versions.
> > 
> > Cc: xen-devel@lists.xensource.com
> > Cc: virtualization@lists.osdl.org
> > Cc: Chris Wright <chrisw@sous-sol.org>
> > Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Acked-by: Chris Wright <chrisw@sous-sol.org>

Thanks, will add it.  Any objections for this to go through my
driver-core tree to Linus for 2.6.31?

> after...
> 
> > -		dev->dev.driver_data = NULL;
> > +		dev_det_drvdata(&dev->dev, NULL);
> 
> ...fixing your fingers/script so it compiles ;-)

Doh!

And here I thought I had built that one, I guess I hadn't, my mistake.
Thanks for catching that, I've now fixed it.

greg k-h
