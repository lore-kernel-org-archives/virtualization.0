From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] staging: hv: Fix race condition on IC channel
 initialization (modified)
Date: Thu, 27 May 2010 16:22:32 -0700
Message-ID: <20100527232232.GA15341@suse.de>
References: <1FB5E1D5CA062146B38059374562DF7266B8C4AC@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100526205134.GC7343@suse.de>
 <1FB5E1D5CA062146B38059374562DF7266B8C72B@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100526214842.GA27908@suse.de>
 <1FB5E1D5CA062146B38059374562DF7266B8C775@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100526223053.GA23521@suse.de>
 <1FB5E1D5CA062146B38059374562DF7266B8C7C4@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7266B8C7C4@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 26, 2010 at 10:52:36PM +0000, Haiyang Zhang wrote:
> > From: Greg KH [mailto:gregkh@suse.de]
> > How about a lock!
> > 
> > What's so scary about a pretty little semaphore?  They are all cute and
> > cuddley and don't bite anyone.  You should not be afraid to use them,
> > they are here to do your bidding.
> 
> No problem, we will add a lock here.
> 
> > > The VmbusChannelProcessOffer() is called from interrupt context, and
> > > initialize the channels, wake up vmbus_init when all channels are
> > > ready. If using local variable only, how to pass the channel ready
> > > info to vmbus_init() which is in a different context?
> > 
> > No, I mean move the logic you added here, into the vmbus_init() call.
> 
> Do you mean:
> Move the event creat/wait/free, which is currently in vmbus_init(),
> into vmbus_bus_init() function.

Yes.

> hv_channle_ready will still be a global variable.

That's fine.

> And, the wakeup call -- osd_WaitEventSet() --remains in
> VmbusChannelProcessOffer() ?

Yes.

And as Jiri pointed out, this should be a simple completion.

thanks,

greg k-h
