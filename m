From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
Date: Sat, 19 Feb 2011 16:46:17 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048011787@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1297799735-25917-1-git-send-email-kys@microsoft.com>
 <alpine.LFD.2.00.1102191046220.2701@localhost6.localdomain6>
 <6E21E5352C11B742B20C142EB499E048011738@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <alpine.LFD.2.00.1102191540290.2701@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1102191540290.2701@localhost6.localdomain6>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Saturday, February 19, 2011 10:12 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Hank
> Janssen
> Subject: RE: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
> 
> On Sat, 19 Feb 2011, KY Srinivasan wrote:
> > > From: Thomas Gleixner [mailto:tglx@linutronix.de]
> > > Please do not use probe_irq_on for dynamic irq allocation. Highjacking
> > > the lower PIC irqs is really not a good idea. Depending on when this
> > > runs, you might grab an irq required by a driver which gets loaded
> > > later.
> > >
> > > Could you please explain what you're trying to do here ?
> >
> > The IRQ being allocated is for the VMBUS driver for Linux guests running on
> > a Windows virtualization platform (Hyper-V hypervisor).
> > The hypervisor is capable of notifying events on the VMBUS via
> > a guest specified interrupt line. Prior to this patch,
> > the code was statically selecting an interrupt line for
> > use by VMBUS. One of the long standing review comments
> > on  that code was to make this irq allocation dynamic and that
> > is what this patch does. For the Linux guest running as a VM
> > on Hyper-V, the concern you raise is not an issue.
> 
> That patch does a whole lot of useless crap.
> 
> When grabbing some random irq from the PIC is not an issue, then
> what's the point of this probing, retry loop and the comments about
> racing ? What races here? That does not make sense at all.

Like most virtualization platforms, Hyper-V also emulates the full PC 
platform. So, it is possible that the driver of some other emulated
devices might register for the IRQ line we might have selected. That 
is the race this code addresses. For performance reasons, we want
both storage and network traffic to go over the PV drivers. 

> 
> I don't know why the previous reviewer wanted to have that
> dynamic. That just does not make sense to me.

Prior to this patch, we had a hard coded interrupt line for use by
this driver. If that line was already in use, the load of this driver 
would fail. This would be a fatal issue especially for distributions
that have embedded these PV drivers as part of their installation
media. This patch deals with such collisions in a more graceful way -
we would not bail until we have scanned all low interrupt lines.
 
> 
> Btw, that whole interrupt handler with two tasklets, one of them
> scheduling work is just screaming threaded interrupt handler.

We are in the process of cleaning up these drivers; I am looking at
some of these and other issues.

Regards,

K. Y  
