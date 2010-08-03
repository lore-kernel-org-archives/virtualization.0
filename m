From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] staging: hv: Fix missing functions for
 net_device_ops (resubmit)
Date: Mon, 2 Aug 2010 18:30:14 -0700
Message-ID: <20100803013013.GC3814@kroah.com>
References: <1FB5E1D5CA062146B38059374562DF7280E8556B@TK5EX14MBXC121.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7280E8556B@TK5EX14MBXC121.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'gregkh@suse.de'" <gregkh@suse.de>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 02, 2010 at 05:46:01PM +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Subject: staging: hv: Fix missing functions for net_device_ops
>   Unlike in older kernels, ether_setup() no longer sets default

Why put the subject in the body of the email?  This forces me to edit it
again :(

> functions. We need to put them into net_device_ops. For example,
> eth_change_mtu prevents setting MTU beyond 1500. This is necessary
> because we don't support jumbo frame at this time.

What does this mean?  Is it a bug?  Just not going as fast as possible?
Something else?

>   It affects kernel 2.6.32 and later, which are all versions
> containing Hyper-V drivers.

So is this fixing a bug that needs to be backported to these older
kernels (i.e. the staging tree?)  Is this something that is causing
people problems?

Third time's a charm?

thanks,

greg k-h
