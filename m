From: Greg KH <greg@kroah.com>
Subject: various vmbus review comments
Date: Tue, 3 May 2011 13:46:41 -0700
Message-ID: <20110503204641.GA11132@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

I just took a quick look at the vmbus code, and have the following
comments:
	- why is count_hv_channel() even a function?
	- your .h files need to be consolidated and renamed.  You will
	  need a single hyperv.h file for include/linux/ that will
	  contain some of what the vmbus*.h files have in it, but not
	  all.  Please merge things together to have:
	  	- include/linux/hyperv.h
		   What is needed to build the drivers that attach to
		   the bus
		- drivers/staging/hv/hyperv.h
		   The local .h file will have the vmbus*.h remaining
		   stuff that is only needed by the hv_vmbus.ko module
		   to be build.
	- the instances of hv_driver structures need to be static and
	  not programatically defined, like all other USB and PCI
	  drivers are handled.
	- module reference counting.  Are you sure you got it all right
	  for the individual modules that attach to the bus?  I don't
	  see any reference counting happening, is that correct?
	- fix the sparse warnings.
	- fix the use of volatile in the ring buffer code.  It should
	  not be needed and if you are relying on it, then the code is
	  wrong.
	- fix the namespace on the ringbuffer code to show that it
	  really is only for the hyperv bus code internally.

That should be enough for at least one more set of patches for you all
to work on :)

thanks,

greg k-h
