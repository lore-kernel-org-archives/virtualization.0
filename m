From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Fix missing functions for
 net_device_ops (resubmit)
Date: Tue, 3 Aug 2010 18:21:50 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF728380C2F4@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF7280E8556B@TK5EX14MBXC121.redmond.corp.microsoft.com>
 <20100803013013.GC3814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100803013013.GC3814@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'gregkh@suse.de'" <gregkh@suse.de>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, August 02, 2010 9:30 PM
> Why put the subject in the body of the email?  This forces me to edit
> it again :(

Sure, I'll remove it.

> > functions. We need to put them into net_device_ops. For example,
> > eth_change_mtu prevents setting MTU beyond 1500. This is necessary
> > because we don't support jumbo frame at this time.
> 
> What does this mean?  Is it a bug?  Just not going as fast as possible?
> Something else?

Yes, it's a bug when porting Linux IC from 2.6.27 to 2.6.32. In 2.6.27,
the default functions for Ethernet, like eth_change_mtu(), were assigned
by ether_setup(). But in 2.6.32, these function pointers moved to
net_device_ops structure and no longer be assigned in ether_setup(). So we
need to set these functions in our driver code. It will ensure the MTU won't
be set beyong 1500. Otherwise, this can cause an error on the server side,
because the HyperV linux driver doesn't support jumbo frame yet.

> >   It affects kernel 2.6.32 and later, which are all versions
> > containing Hyper-V drivers.
> 
> So is this fixing a bug that needs to be backported to these older
> kernels (i.e. the staging tree?)  Is this something that is causing
> people problems?

Yes it should be backported. The bug can cause error on guest and host.

Thanks,

- Haiyang
