From: KY Srinivasan <kys@microsoft.com>
Subject: RE: various vmbus review comments
Date: Tue, 3 May 2011 21:00:01 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481DFA51@TK5EX14MBXC124.redmond.corp.microsoft.com>
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
> 	- the instances of hv_driver structures need to be static and
> 	  not programatically defined, like all other USB and PCI
> 	  drivers are handled.
> 	- module reference counting.  Are you sure you got it all right
> 	  for the individual modules that attach to the bus?  I don't
> 	  see any reference counting happening, is that correct?
> 	- fix the sparse warnings.
> 	- fix the use of volatile in the ring buffer code.  It should
> 	  not be needed and if you are relying on it, then the code is
> 	  wrong.
> 	- fix the namespace on the ringbuffer code to show that it
> 	  really is only for the hyperv bus code internally.
> 
> That should be enough for at least one more set of patches for you all
> to work on :)

Thanks for taking the time to review this code. I will start work on addressing
your comments right away. As we had discussed on this list, my goal is to deal
with the vmbus related issues first. You had also suggested that I should ask for 
a community review once you had had applied my last set of patches. Now that
you have applied all my patches, should I formally ask for this review?

Regards,

K. Y
