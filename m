From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/1] Staging: hv: Add the necessary dependencies to
 hyperv Kconfig
Date: Wed, 4 May 2011 12:55:18 -0700
Message-ID: <20110504125518.e107af23.rdunlap@xenotime.net>
References: <1304535105-26892-1-git-send-email-kys@microsoft.com>
	<0D753D10438DA54287A00B027084269764D295CE91@AUSP01VMBX24.collaborationhost.net>
	<20110504185338.GB9823@suse.de>
	<20110504123302.1ef22682.rdunlap@xenotime.net>
	<20110504193954.GA30937@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110504193954.GA30937@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 4 May 2011 12:39:54 -0700 Greg KH wrote:

> On Wed, May 04, 2011 at 12:33:02PM -0700, Randy Dunlap wrote:
> > On Wed, 4 May 2011 11:53:38 -0700 Greg KH wrote:
> > 
> > > On Wed, May 04, 2011 at 01:44:27PM -0500, H Hartley Sweeten wrote:
> > > > On Wednesday, May 04, 2011 11:52 AM, K. Y. Srinivasan wrote:
> > > > >
> > > > > The vmbus driver dependes on ACPI and PCI subsystems. Change 
> > > > > Kconfig to reflect this.
> > > > >
> > > > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > > > ---
> > > > >  drivers/staging/hv/Kconfig |    2 +-
> > > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > >
> > > > > diff --git a/drivers/staging/hv/Kconfig b/drivers/staging/hv/Kconfig
> > > > > index 76f0756..5e0c9f6 100644
> > > > > --- a/drivers/staging/hv/Kconfig
> > > > > +++ b/drivers/staging/hv/Kconfig
> > > > > @@ -1,6 +1,6 @@
> > > > >  config HYPERV
> > > > >  	tristate "Microsoft Hyper-V client drivers"
> > > > > -	depends on X86 && m
> > > > > +	depends on X86 && ACPI && PCI && m
> > > > >  	default n
> > > > >  	help
> > > > > 	  Select this option to run Linux as a Hyper-V client operating
> > > > 
> > > > ACPI itself depends on PCI.
> > > 
> > > Still?  I thought that got removed a while ago.
> > 
> > Still.  Len has written in the past that technically there is no such
> > dependency, but in reality there is, for now at least.  IIRC.
> 
> Ok, but then we should still say we depend on PCI to handle if/when ACPI
> removes that dependancy in the future.  It doesn't hurt here at all.

Yes, I prefer that also.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
