From: Greg KH <greg@kroah.com>
Subject: Re: various vmbus review comments
Date: Wed, 4 May 2011 09:32:28 -0700
Message-ID: <20110504163228.GA19754@kroah.com>
References: <20110503204641.GA11132@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DFCFA@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481DFCFA@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 04, 2011 at 04:20:11PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Tuesday, May 03, 2011 4:47 PM
> > To: KY Srinivasan
> > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; virtualization@lists.osdl.org
> > Subject: various vmbus review comments
> > 
> > I just took a quick look at the vmbus code, and have the following
> > comments:
> > 	- why is count_hv_channel() even a function?
> 
> I will fix this.
> 
> > 	- your .h files need to be consolidated and renamed.  You will
> > 	  need a single hyperv.h file for include/linux/ that will
> > 	  contain some of what the vmbus*.h files have in it, but not
> > 	  all.  Please merge things together to have:
> > 	  	- include/linux/hyperv.h
> > 		   What is needed to build the drivers that attach to
> > 		   the bus
> > 		- drivers/staging/hv/hyperv.h
> > 		   The local .h file will have the vmbus*.h remaining
> > 		   stuff that is only needed by the hv_vmbus.ko module
> > 		   to be build.
> 
> I have currently consolidated all the header files as follows:
> 
> 1) hyperv.h - this will have all the vmbus related definitions
> needed to build drivers that attach to the bus (as you have suggested).

Great.

> 2) hyperv_storage.h - this has all the definitions needed to build storage
> drivers for Hyper-V. Storage drivers will include hyperv.h and 
> hyperv_storage.h.
> 
> 3) hyperv_net.h - this has all the definitions needed to build the network
> driver for Hyper-V. The netvsc driver will include hyperv.h and hyperv_net.h.
> 
> 4) hyperv_utils.h - this has all the definitions needed to build the util driver.
> The util driver would include hyperv.h and hyperv_utils.h.

No for all 3 of these.  Why would a simple driver need a .h file at all?
Just include the structures within the .c file, making it nice and
self-contained.  There's no need to clutter things up, and individual
driver .h files should _never_ be in include/linux.

> All these four header files could potentially be under include/linux.
> I have also created a private header file that has the definitions to 
> build the vmbus driver - hyperv_vmbus.h.

Sure, you can call it that, but as it will be local to the hyperv bus
directory, the name isn't all that important.

> Let me know if this is what you had in mind.
> 
> 
> > 	- the instances of hv_driver structures need to be static and
> > 	  not programatically defined, like all other USB and PCI
> > 	  drivers are handled.
> > 	- module reference counting.  Are you sure you got it all right
> > 	  for the individual modules that attach to the bus?  I don't
> > 	  see any reference counting happening, is that correct?
> 
> For this round, I want to concentrate on just the vmbus driver. So,
> module reference counting is I don't think an issue for the vmbus driver
> given that the driver is not unlodable. Once I am done with the vmbus driver
> I will address the module reference counting issues for other drivers. 

No, I am referring to the module reference counting of the bus drivers
that register with the vmbus core.  You aren't doing that at all, and
you probably need to make sure that this isn't needed.  That is
concentrating on the vmbus driver.

> I will also address your comment on static initialization hv_driver instances
> as part of other driver cleanup.

No, please do this now as it will show how to properly interact with the
vmbus core code in the correct manner.  Hopefully that will be correct,
but I have a feeling that it will show you some places in the API that
need to be changed...

thanks,

greg k-h
