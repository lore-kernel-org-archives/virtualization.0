From: KY Srinivasan <kys@microsoft.com>
Subject: RE: various vmbus review comments
Date: Wed, 4 May 2011 16:20:11 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481DFCFA@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <20110503204641.GA11132@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110503204641.GA11132@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, May 03, 2011 4:47 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: various vmbus review comments
> 
> I just took a quick look at the vmbus code, and have the following
> comments:
> 	- why is count_hv_channel() even a function?

I will fix this.

> 	- your .h files need to be consolidated and renamed.  You will
> 	  need a single hyperv.h file for include/linux/ that will
> 	  contain some of what the vmbus*.h files have in it, but not
> 	  all.  Please merge things together to have:
> 	  	- include/linux/hyperv.h
> 		   What is needed to build the drivers that attach to
> 		   the bus
> 		- drivers/staging/hv/hyperv.h
> 		   The local .h file will have the vmbus*.h remaining
> 		   stuff that is only needed by the hv_vmbus.ko module
> 		   to be build.

I have currently consolidated all the header files as follows:

1) hyperv.h - this will have all the vmbus related definitions
needed to build drivers that attach to the bus (as you have suggested).

2) hyperv_storage.h - this has all the definitions needed to build storage
drivers for Hyper-V. Storage drivers will include hyperv.h and 
hyperv_storage.h.

3) hyperv_net.h - this has all the definitions needed to build the network
driver for Hyper-V. The netvsc driver will include hyperv.h and hyperv_net.h.

4) hyperv_utils.h - this has all the definitions needed to build the util driver.
The util driver would include hyperv.h and hyperv_utils.h.

All these four header files could potentially be under include/linux.
I have also created a private header file that has the definitions to 
build the vmbus driver - hyperv_vmbus.h.

Let me know if this is what you had in mind.


> 	- the instances of hv_driver structures need to be static and
> 	  not programatically defined, like all other USB and PCI
> 	  drivers are handled.
> 	- module reference counting.  Are you sure you got it all right
> 	  for the individual modules that attach to the bus?  I don't
> 	  see any reference counting happening, is that correct?

For this round, I want to concentrate on just the vmbus driver. So,
module reference counting is I don't think an issue for the vmbus driver
given that the driver is not unlodable. Once I am done with the vmbus driver
I will address the module reference counting issues for other drivers. 
I will also address your comment on static initialization hv_driver instances
as part of other driver cleanup.

> 	- fix the sparse warnings.

Will do. Just out of curiosity I ran sparse and was relieved to see only a handful
warnings!

> 	- fix the use of volatile in the ring buffer code.  It should
> 	  not be needed and if you are relying on it, then the code is
> 	  wrong.
> 	- fix the namespace on the ringbuffer code to show that it
> 	  really is only for the hyperv bus code internally.

I will fix these.

Regards,

K. Y
