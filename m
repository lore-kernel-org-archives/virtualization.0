From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Fix race condition on IC channel
 initialization
Date: Fri, 21 May 2010 22:07:17 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7266B8B5F2@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF7266B8AE7C@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100521201228.GA6712@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100521201228.GA6712@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:gregkh@suse.de]
> > +/* Counter of IC channels initialized */
> > +atomic_t hv_utils_initcnt = ATOMIC_INIT(0);
> 
> This doesn't need to be an atomic variable, does it really?
> 
> Why not have a simple bool variable "vmbus_initialized" or something.
> It starts out as false, and then turns true when you are up and ready.
> Then provide a function that tests it:
> 	bool hv_vmbus_ready(void)
> 	{
> 		return vmbus_initialized
> 	}
> 	EXPORT_SYMBOL_GPL(hv_vmbus_ready);
> 
> 
> this turns into a simple function call, again, never needing to know
> about message types or any other mess.

This looks good. I will add the hv_vmbus_ready() function. It doesn't even 
have to be exported symbol, because it's only used in vmbus module to ensure 
all channels are ready before vmbus_init() returns. Other modules won't get a 
chance to see uninitialized channels after hv_vmbus is loaded.

Also, I'll cleanup the printk in hv_utils load/unload.

Regarding the atomic variable -- the channel offer processing function is 
triggered by interrupts from host -- should we be concerned about "counter++" 
racing with each other in two interrupts happening around the same time?

Thanks,

- Haiyang
