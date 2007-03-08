From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 16:19:24 -0800
Message-ID: <45EF568C.50506@goop.org>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	 <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	 <20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>	 <1173178774.24738.311.camel@localhost.localdomain>	 <45EDD82F.90204@vmware.com>	 <1173225182.24738.507.camel@localhost.localdomain>	 <45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>	 <1173228544.24738.514.camel@localhost.localdomain>	 <45EE0D10.7070807@vmware.com>	 <1173230305.24738.529.camel@localhost.localdomain>	 <45EE1EA3.90803@vmware.com>	 <1173256666.24738.576.camel@localhost.localdomain>	 <45EEF966.6060902@goop.org>	<Line.LNX.4.64.0703071304080.1851@d.namei>	 <45EF0CF5.5090305@goop.org>  <45EF175D.6030609@vmware.com>	 <1173302503.24738.795.camel@localhost.localdomain>	 <45EF372E.7030600@goop.org> <1173308717.24738.898.camel@localhost.localdomain> <45EF4BD7.7060400@goop.org> <45EF5049.
 3060902@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992456AbXCHATb@vger.kernel.org>
In-Reply-To: <45EF5049.3060902@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Hecht <dhecht@vmware.com>
Cc: tglx@linutronix.de, James Morris <jmorris@namei.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> On 03/07/2007 03:33 PM, Jeremy Fitzhardinge wrote:
>> I know the vmi time code has coloured your view here, but I surely hope
>> it can be got into a better state before posting.  I'm biased of course,
>> but I would rather hope that all these drivers we're talking about will
>> be as stylistically clean as the Xen time code (which has room for
>> improvement, of course).
>>
>
> Could you send us comments on where you feel the style needs some
> fixing up?

I think Thomas has covered this in quite a bit of detail already.  But
the fact that the code mentions "apic" or "pit" at all seems
unfortunate, but I guess that's what you have to work with.

> VMI encapsulates all the implementation details away from the kernel,
> whereas the Xen time code puts it all out there in the kernel[...]

This is not an exercise in "my hypervisor is better than yours", it's a
matter of getting clean implementations within the constraints of each
hypervisor interface.  The Xen code may be more verbose than the
corresponding VMI code, but it's self-contained and doesn't make any
demands on the rest of the kernel.

The concern is that the vmi code reaches out and does things like set
global_clock_event, calls time_init_hook and so on - basically
complicating the already ugly lapic/pic legacy time mess, and therefore
making yourself part of the tangle if anyone wants to go in there and
change it.

The question is whether you can make the vmi clock implementation
free-standing, in that it has no dependencies other than well defined
interfaces like the clock api itself, the normal (non-legacy) interrupt
api and, of course, the underlying VMI interface.  But no reach-arounds
into the lapic/pit code.

    J
