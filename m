From: Zachary Amsden <zach@vmware.com>
Subject: Re: hardwired VMI crap
Date: Thu, 08 Mar 2007 14:31:56 -0800
Message-ID: <45F08EDC.30003@vmware.com>
References: <45EE1EA3.90803@vmware.com>	
	<1173256666.24738.576.camel@localhost.localdomain>	
	<45EEF966.6060902@goop.org>
	<Line.LNX.4.64.0703071304080.1851@d.namei>	
	<45EF0CF5.5090305@goop.org> <45EF175D.6030609@vmware.com>	
	<1173302503.24738.795.camel@localhost.localdomain>	
	<45EF372E.7030600@goop.org>	
	<1173308717.24738.898.camel@localhost.localdomain>	
	<45EF49E9.7040509@vmware.com> <20070308091019.GA19460@elte.hu>	
	<45EFE010.7080108@vmware.com>
	<1173352154.24738.1023.camel@localhost.localdomain>
	<45F0761C.6060107@vmware.com> <45F07D07.5090003@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F07D07.5090003@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   =

>> We faithfully emulate lapic, io_apic, the pit, pic, and a normal
>> interrupt subsystem.
>>     =

>
> Can you not just use the apic clock driver directly then?  Do you need
> to do anything special?
>   =


The apic clock driver is going to program the apic, not our virtual =

clock, which tracks real time, available and stolen time.  APIC has no =

idea about any of this.

We want an APIC, just purely as a local interrupt controller, and a =

separate, paravirt timer device.  It is not very complicated.

The problem is that we are not supposed to fiddle with APIC internals, =

so we shouldn't be using their clock events, so we can't use their low =

level local timer interrupt, and we are not supposed to write our own.  =

So we need a weird hack somewhere because we are not allowed to use any =

of the paths that currently work for our code, because of the =

maintenance burden it imposes by misusing the interfaces.

The larger problem I am having is that nobody wants to give productive =

feedback on how to fix the problem, just sit around and fling muck.

Zach
