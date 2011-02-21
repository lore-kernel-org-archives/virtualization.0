From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
Date: Mon, 21 Feb 2011 14:40:52 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048013C67@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1297799735-25917-1-git-send-email-kys@microsoft.com>
 <alpine.LFD.2.00.1102191046220.2701@localhost6.localdomain6>
 <6E21E5352C11B742B20C142EB499E048011738@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <alpine.LFD.2.00.1102191540290.2701@localhost6.localdomain6>
 <6E21E5352C11B742B20C142EB499E048011787@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <alpine.LFD.2.00.1102201705380.2701@localhost6.localdomain6>
 <6E21E5352C11B742B20C142EB499E04801191C@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <alpine.LFD.2.00.1102211200270.2701@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1102211200270.2701@localhost6.localdomain6>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Monday, February 21, 2011 6:03 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Hank
> Janssen
> Subject: RE: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
> 
> On Mon, 21 Feb 2011, KY Srinivasan wrote:
> > > > Like most virtualization platforms, Hyper-V also emulates the full PC
> > > > platform. So, it is possible that the driver of some other emulated
> > > > devices might register for the IRQ line we might have selected. That
> > > > is the race this code addresses. For performance reasons, we want
> > > > both storage and network traffic to go over the PV drivers.
> > >
> > > So in case your driver gets the interrupt line first, which the other
> > > driver wants to acquire as well, then what? Do you want to do that
> > > probe magic in the other driver as well? What if this is a regular
> > > device driver which gets its irq number from ACPI/PCI or
> > > whatever. Then that driver simply wont work as it's interrupt line is
> > > busy.
> > >
> > > > >
> > > > > I don't know why the previous reviewer wanted to have that
> > > > > dynamic. That just does not make sense to me.
> > > >
> > > > Prior to this patch, we had a hard coded interrupt line for use by
> > > > this driver. If that line was already in use, the load of this driver
> > > > would fail. This would be a fatal issue especially for distributions
> > > > that have embedded these PV drivers as part of their installation
> > > > media. This patch deals with such collisions in a more graceful way -
> > > > we would not bail until we have scanned all low interrupt lines.
> > >
> > > So you trade breaking the PV stuff against breaking random other
> > > drivers? That doesn't sound like a brilliant idea.
> > >
> > > There are various ways to solve that proper.
> > >
> > >  - You can provide the interrupt number from ACPI/PCI or whatever your HV
> > >    provides as enumeration.
> > >
> > >  - Use a fixed vector like XEN does for the event channel
> > >
> > >  - Use dynamic allocation in the IOAPIC space like the kernel does for
> > >    MSI(-X)
> > >
> > > Thanks,
> > >
> > > 	tglx
> >
> > I am not claiming that what I have done here is the best possible solution.
> > However, I will submit to you that it is better than what we had here
> > prior to this patch.  I will address this and a  whole lot of other issues
> > in future patches.
> 
> No, it's _NOT_ better in any way. You trade breaking your PV thing
> against breaking random other drivers. Care to explain why you think
> that's better ?

The root device for the VM is bound to the PV driver on some distributions.
So, if we cannot load the PV drivers, we do not have a system that boots.
In general, the system performance without these PV drivers is so poor that
for all practical purposes, having the PV drivers is almost a requirement
for having a useable system. While the platform supports configuration of the VM with
some emulated devices, it is not a recommended configuration (because of
performance reasons) for Linux virtual machines on the Hyper-V platform.

I have spent significantly more time debating this patch than developing this patch
that I still think improves the current driver. I will leave it to  Greg and other powers 
that be to decide if this patch will be accepted. Let me know what your verdict is. 

Regards,

K. Y 
