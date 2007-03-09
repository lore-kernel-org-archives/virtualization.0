From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: hardwired VMI crap
Date: Fri, 09 Mar 2007 01:28:25 +0100
Message-ID: <1173400106.24738.1123.camel@localhost.localdomain>
References: <45EF175D.6030609@vmware.com>
	<1173302503.24738.795.camel@localhost.localdomain>
	<45EF372E.7030600@goop.org>
	<1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com> <20070308091019.GA19460@elte.hu>
	<45EFE010.7080108@vmware.com>
	<1173352154.24738.1023.camel@localhost.localdomain>
	<45F0761C.6060107@vmware.com> <45F07D07.5090003@goop.org>
	<20070308213458.GA24634@elte.hu> <45F09EAE.6090908@goop.org>
	<45F0A254.4020002@vmware.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F0A254.4020002@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-08 at 15:55 -0800, Zachary Amsden wrote:
> Jeremy Fitzhardinge wrote:
> > No, but I'm not prejudiced against virtual hardware.  If we have a piece
> > of code that thinks its talking to an apic, then I think its OK to use
> > that code whether its a real apic or a virtual one, _so long as its
> > being used in a way that's consistent with its intended interface_.  I
> > have to admit I have not looked at apics - real or virtual - in any
> > detail, so I won't claim to really understand the details of the
> > existing arch/i386 code or what VMI's trying to do, but it does seem to
> > me that it could all be much cleaner.
> >
> > And clean is good, we all love clean - and so, agreement!
>
> For APICs, we have two operations - APICRead and APICWrite.  It is nice =

> and clean, and plugs in very easily to the APIC accessors available in =

> Linux.
> =

> Is this not clean?

No, because there is no need to use APIC. You just pave the road for
doing the same thing to IO_APIC and whatever is on your interest next.

> We just don't drive the local timer interrupts through the APIC, we make =

> hypercalls to schedule local timer alarms.  Which is something we must =

> do for UP kernels as well, which use the PIT / PIC.  So there is a need =

> for having clockevents code which doesn't program timers through the APIC.
>
> So we have one separate time device, independent from the traditional =

> hardware timers, and we just program that.  This design is not very =

> complex, nor is it unclean, IMHO.

And why exactly do you need the APIC operations for the complete
abstract and virtual clock event device ? To inject the interrupt, which
you anyway inject artificially into the paravirtualized kernel ? =


This is simply wrong and does not help anything. The 3 lines of code you
share with the apic timer code are not a valid reason to hook yourself
into the apic.

You can use any arbitrary interrupt number to fire your VMI timer and
this works on SMP as well, as we can pin interrupts on CPUs.

	tglx
