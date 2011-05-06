From: KY Srinivasan <kys@microsoft.com>
Subject: RE: various vmbus review comments
Date: Fri, 6 May 2011 13:10:38 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481E0694@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <20110503204641.GA11132@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DFCFA@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110504163228.GA19754@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110504163228.GA19754@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, May 04, 2011 12:32 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: various vmbus review comments
> 
> On Wed, May 04, 2011 at 04:20:11PM +0000, KY Srinivasan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:greg@kroah.com]
> > > Sent: Tuesday, May 03, 2011 4:47 PM
> > > To: KY Srinivasan
> > > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > > 	- module reference counting.  Are you sure you got it all right
> > > 	  for the individual modules that attach to the bus?  I don't
> > > 	  see any reference counting happening, is that correct?
> >
> > For this round, I want to concentrate on just the vmbus driver. So,
> > module reference counting is I don't think an issue for the vmbus driver
> > given that the driver is not unlodable. Once I am done with the vmbus driver
> > I will address the module reference counting issues for other drivers.
> 
> No, I am referring to the module reference counting of the bus drivers
> that register with the vmbus core.  You aren't doing that at all, and
> you probably need to make sure that this isn't needed.  That is
> concentrating on the vmbus driver.

I audited the block and the net drivers. As part of their exit routine,
they invoke vmbus_child_driver_unregister() after properly cleaning
up all the devices they are managing. Do you still see an issue with
regards to module reference counting.

> 
> > I will also address your comment on static initialization hv_driver instances
> > as part of other driver cleanup.
> 
> No, please do this now as it will show how to properly interact with the
> vmbus core code in the correct manner.  Hopefully that will be correct,
> but I have a feeling that it will show you some places in the API that
> need to be changed...

As opposed to run-time initialization of fields such as probe, etc; I have 
initialized them statically. For instance, in the blkvsc driver:

/* The one and only one */
static  struct storvsc_driver blkvsc_drv = {
        .base.probe =  blkvsc_probe,
        .base.remove =  blkvsc_remove,
        .base.shutdown = blkvsc_shutdown,
};

Is this what you had in mind.

Regards,

K. Y 
