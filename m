From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Fix race condition on IC channel
 initialization (modified)
Date: Wed, 26 May 2010 22:52:36 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7266B8C7C4@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF7266B8C4AC@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100526205134.GC7343@suse.de>
 <1FB5E1D5CA062146B38059374562DF7266B8C72B@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100526214842.GA27908@suse.de>
 <1FB5E1D5CA062146B38059374562DF7266B8C775@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100526223053.GA23521@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100526223053.GA23521@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:gregkh@suse.de]
> How about a lock!
> 
> What's so scary about a pretty little semaphore?  They are all cute and
> cuddley and don't bite anyone.  You should not be afraid to use them,
> they are here to do your bidding.

No problem, we will add a lock here.

> > The VmbusChannelProcessOffer() is called from interrupt context, and
> > initialize the channels, wake up vmbus_init when all channels are
> > ready. If using local variable only, how to pass the channel ready
> > info to vmbus_init() which is in a different context?
> 
> No, I mean move the logic you added here, into the vmbus_init() call.

Do you mean:
Move the event creat/wait/free, which is currently in vmbus_init(), into vmbus_bus_init() function.  hv_channle_ready will still be a global variable. And, the wakeup call -- osd_WaitEventSet() --remains in VmbusChannelProcessOffer() ?

Thanks,

- Haiyang
