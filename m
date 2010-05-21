From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] staging: hv: Fix race condition on IC channel
 initialization
Date: Fri, 21 May 2010 13:55:27 -0700
Message-ID: <20100521205527.GB9594@suse.de>
References: <1FB5E1D5CA062146B38059374562DF7266B8AE7C@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100521201228.GA6712@suse.de>
 <4BF696FA0200003000085968@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BF696FA0200003000085968@sinclair.provo.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 21, 2010 at 02:21:46PM -0600, Ky Srinivasan wrote:
> 
> 
> >>> On 5/21/2010 at  4:12 PM, in message <20100521201228.GA6712@suse.de>, Greg KH
> <gregkh@suse.de> wrote: 
> > On Fri, May 21, 2010 at 07:58:26PM +0000, Haiyang Zhang wrote:
> >> From: Haiyang Zhang <haiyangz@microsoft.com>
> >> 
> >> Subject: staging: hv: Fix race condition on IC channel initialization
> >> There is a possible race condition when hv_utils starts to load immediately
> >> after hv_vmbus is loading - null pointer error could happen.
> >> This patch added an atomic counter to ensure all channels are ready before
> >> vmbus_init() returns. So another module won't have any uninitialized 
> > channel.
> > 
> > Better, but not quite ready...
> > 
> >> +/* Counter of IC channels initialized */
> >> +atomic_t hv_utils_initcnt = ATOMIC_INIT(0);
> > 
> > This doesn't need to be an atomic variable, does it really?
> > 
> > Why not have a simple bool variable "vmbus_initialized" or something.
> > It starts out as false, and then turns true when you are up and ready.
> > Then provide a function that tests it:
> > 	bool hv_vmbus_ready(void)
> > 	{
> > 		return vmbus_initialized
> > 	}
> > 	EXPORT_SYMBOL_GPL(hv_vmbus_ready);
> I agree with Greg; I would go a step further and deal with this issue
> as part of loading the bus driver. After all, we already have
> dependencies established for various LIC drivers  on the bus driver.
> The fact that even after the bus driver is loaded we cannot reliably
> load other drivers implies that there is an additional dependency that
> is not currently being handled. Why can't we ensure that the bus
> driver is fully initialized before we are done with loading the bus
> driver.

Um, I think that is what this patch fixes :)

It just doesn't do it in a way that I think is very good...

thanks,

greg k-h
