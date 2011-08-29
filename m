From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0000/0046] Staging: hv: Driver cleanup
Date: Mon, 29 Aug 2011 11:15:02 -0700
Message-ID: <20110829181502.GC19668@kroah.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314469874-7017-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 27, 2011 at 11:31:14AM -0700, K. Y. Srinivasan wrote:
> Further cleanup of the hv drivers. 
> 
> 	1) Cleanup reference counting.
> 
> 	2) Handle all block devices using the storvsc driver. I have modified
> 	   the implementation here based on Christoph's feedback on my earlier
> 	   implementation.
> 
> 	3) Fix bugs.
> 
> 	4) Accomodate some host side scsi emulation bugs.
> 
> 	5) In case of scsi errors off-line the device.
> 
> This patch-set further reduces the size of Hyper-V drivers - the code is
> about 10% smaller. This reduction is mainly because we have eliminated the
> blkvsc driver.

If my tracking is correct, I applied everything in this series except
the following patches
	[PATCH 37/46] Staging: hv: vmbus: Check for events before messages
	[PATCH 41/46] Staging: hv: vmbus: Fix a bug in error handling in vmbus_bus_init()
	[PATCH 46/46] Staging: hv: Update the TODO file

Please fix up patches 37 and 41 and resend, and for 46, that should be
totally different as mentioned, but you might want to send a patch that
at the least adds your name to the file at the bottom, as you wanted.
Also note that the MAINTAINERS file should also be adjusted to match.

thanks,

greg k-h
