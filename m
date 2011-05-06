From: Greg KH <greg@kroah.com>
Subject: Re: various vmbus review comments
Date: Fri, 6 May 2011 07:59:44 -0700
Message-ID: <20110506145944.GA11871@kroah.com>
References: <20110503204641.GA11132@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DFCFA@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110504163228.GA19754@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481E0694@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481E0694@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 06, 2011 at 01:10:38PM +0000, KY Srinivasan wrote:
> > No, I am referring to the module reference counting of the bus drivers
> > that register with the vmbus core.  You aren't doing that at all, and
> > you probably need to make sure that this isn't needed.  That is
> > concentrating on the vmbus driver.
> 
> I audited the block and the net drivers. As part of their exit routine,
> they invoke vmbus_child_driver_unregister() after properly cleaning
> up all the devices they are managing. Do you still see an issue with
> regards to module reference counting.

I will look again, the next time I review the vmbus code.

> > > I will also address your comment on static initialization hv_driver instances
> > > as part of other driver cleanup.
> > 
> > No, please do this now as it will show how to properly interact with the
> > vmbus core code in the correct manner.  Hopefully that will be correct,
> > but I have a feeling that it will show you some places in the API that
> > need to be changed...
> 
> As opposed to run-time initialization of fields such as probe, etc; I have 
> initialized them statically. For instance, in the blkvsc driver:
> 
> /* The one and only one */
> static  struct storvsc_driver blkvsc_drv = {
>         .base.probe =  blkvsc_probe,
>         .base.remove =  blkvsc_remove,
>         .base.shutdown = blkvsc_shutdown,
> };
> 
> Is this what you had in mind.

Close.  The format is correct.

But what's with that ".base." crud?  That shows that something is wrong
as no USB or PCI or any other bus driver has to mess with a ".base"
subpointer in a driver structure.

See, I told you that when you converted to use this format the problems
would pop out at you :)

Please fix that.

thanks,

greg k-h
