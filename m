From: Daniel Walker <dwalker@mvista.com>
Subject: Re: hardwired VMI crap
Date: Thu, 08 Mar 2007 16:22:23 -0800
Message-ID: <1173399743.20300.3.camel@dwalker1>
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
Reply-To: dwalker@mvista.com
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
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-08 at 15:55 -0800, Zachary Amsden wrote:

> =

> We just don't drive the local timer interrupts through the APIC, we make =

> hypercalls to schedule local timer alarms.  Which is something we must =

> do for UP kernels as well, which use the PIT / PIC.  So there is a need =

> for having clockevents code which doesn't program timers through the APIC.

This getting a bit confusing to me .. When your talking about "local
timer interrupts" are you speaking of a periodic interrupt from the
lapic , or the jiffies increment inside the virtual machine?

Daniel
