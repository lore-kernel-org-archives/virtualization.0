From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] Staging: hv: Add the necessary dependencies to
	hyperv	Kconfig
Date: Wed, 4 May 2011 11:53:38 -0700
Message-ID: <20110504185338.GB9823@suse.de>
References: <1304535105-26892-1-git-send-email-kys@microsoft.com>
	<0D753D10438DA54287A00B027084269764D295CE91@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <0D753D10438DA54287A00B027084269764D295CE91@AUSP01VMBX24.collaborationhost.net>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 04, 2011 at 01:44:27PM -0500, H Hartley Sweeten wrote:
> On Wednesday, May 04, 2011 11:52 AM, K. Y. Srinivasan wrote:
> >
> > The vmbus driver dependes on ACPI and PCI subsystems. Change 
> > Kconfig to reflect this.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/staging/hv/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/staging/hv/Kconfig b/drivers/staging/hv/Kconfig
> > index 76f0756..5e0c9f6 100644
> > --- a/drivers/staging/hv/Kconfig
> > +++ b/drivers/staging/hv/Kconfig
> > @@ -1,6 +1,6 @@
> >  config HYPERV
> >  	tristate "Microsoft Hyper-V client drivers"
> > -	depends on X86 && m
> > +	depends on X86 && ACPI && PCI && m
> >  	default n
> >  	help
> > 	  Select this option to run Linux as a Hyper-V client operating
> 
> ACPI itself depends on PCI.

Still?  I thought that got removed a while ago.

> It also depends on IA64 || X86.  Will the vmbus driver work with IA64?

No.

> If so the depends on could just be:
> 
> 	depends on ACPI && m

No, see above for the IA64 reason.

> Also, default n is redudant since n is the default anyway.

True, but it doesn't hurt either :)

thanks,

greg k-h
