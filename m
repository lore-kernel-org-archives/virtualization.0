From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 41/46] Staging: hv: vmbus: Fix a bug in error handling
 in vmbus_bus_init()
Date: Tue, 30 Aug 2011 17:25:23 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B537B@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-41-git-send-email-kys@microsoft.com>
 <20110829180842.GA23618@kroah.com> <20110830102949.GD3705@shale.localdomain>
 <20110830140725.GA16570@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110830140725.GA16570@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, Dan Carpenter <error27@gmail.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, August 30, 2011 10:07 AM
> To: Dan Carpenter
> Cc: KY Srinivasan; devel@linuxdriverproject.org; Haiyang Zhang; gregkh@suse.de;
> linux-kernel@vger.kernel.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 41/46] Staging: hv: vmbus: Fix a bug in error handling in
> vmbus_bus_init()
> 
> On Tue, Aug 30, 2011 at 01:29:49PM +0300, Dan Carpenter wrote:
> > > err3:
> > > 	free_irq(irq, hv_acpi_dev);
> > > err2:
> > > 	bus_unregister(&hv_bus);
> > > err1:
> > > 	hv_cleanup();
> >
> > Also here is an oldbie trick.  You could use multiples of ten like
> > err30, err20, and err10.  That way if you can add more error handling
> > in the middle without changing the numbering.  I knew my GW-BASIC
> > experience would come in handy one day.  :)
> >
> > The better way to label things is based on what happens when you get
> > there: err_irq, err_unregister, err_cleanup.
> 
> Yes, that's the best way to do this, thanks for pointing it out.

I will fix this up.

Regards,

K. Y
> 
> greg k-h
