From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] staging: hv: Fix missing functions for
 net_device_ops
Date: Mon, 2 Aug 2010 10:17:54 -0700
Message-ID: <20100802171754.GA8213@suse.de>
References: <1FB5E1D5CA062146B38059374562DF7280E8547C@TK5EX14MBXC121.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7280E8547C@TK5EX14MBXC121.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 02, 2010 at 05:00:33PM +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Subject: staging: hv: Fix missing functions for net_device_ops
>   Unlike in older kernels, ether_setup() no longer sets default
> functions.

So what kernel versions are affected by this?

Please don't attach a patch and put it inline, it forces me to edit it
by hand.

Care to provide the above information and resend it so I can apply it?

thanks,

greg k-h
