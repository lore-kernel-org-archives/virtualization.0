From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/2] staging: hv: Fix race condition in hv_utils module
 initialization.
Date: Wed, 19 May 2010 15:21:05 -0700
Message-ID: <20100519222104.GA19365@suse.de>
References: <1FB5E1D5CA062146B38059374562DF7266B8930E@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100519161011.GA20266@suse.de>
 <1FB5E1D5CA062146B38059374562DF7266B894B0@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100519203901.GA23214@suse.de>
 <1FB5E1D5CA062146B38059374562DF7266B8951F@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7266B8951F@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 19, 2010 at 10:12:51PM +0000, Haiyang Zhang wrote:
> > > Actually, we already assign a default callback function,
> > chn_cb_negotiate(),
> > > when the channels are opened in vmbus module. It's a real function
> > and can
> > > handle common negotiation messages.
> > 
> > Then why don't you use it here?
> 
> When vmbus is loaded and channel is offered from HyperV host, the default
> callback function, chn_cb_negotiate(), is assigned to the function ptr, and
> used to do basic responses of negotiation messages. 

Great, so that works.

> After hv_utils modules is loaded the callback function ptr is overridden by 
> a specialized function in hv_utils module, and handles each feature (shutdown, 
> timesync, etc.) differently.

That's the problem.  Provide a "correct" interface to properly change
the callback function.  Just setting function pointers in a random
manner is ripe for all sorts of bad problems, don't you agree?  Heck, I
don't see any locking happening here which could cause messages to be
handled when things are only half-way set up.  Also, what's to say your
function pointer write is atomic in the first place :)

In short, use proper locking for something like this.

> > I still think there's a real problem somewhere else in the architecture
> > if such a sleep is necessary...
> > 
> > Is the issue that the modprobe of the hv_vmbus can return before the
> > bus
> > is really all set up and ready to go?  If so, just fix that, then you
> > will not need any "sleep" calls anywhere, right?
> 
> After vmbus is loaded, the channel offering will come from the host, then
> it initializes the channel. The channel offering can happen a little later
> after vmbus_init() is done and modprobe returns. So I think we should let
> vmbus_init function wait(sleep) until all channel offerings are received before
> returning. This will ensure all channels are ready before modprobe returns.

That sounds like a good idea.

thanks,

greg k-h
