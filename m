From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 08 Mar 2007 21:26:54 +1100
Message-ID: <1173349614.32234.23.camel@localhost.localdomain>
References: <45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>
	 <1173228544.24738.514.camel@localhost.localdomain>
	 <45EE0D10.7070807@vmware.com>
	 <1173230305.24738.529.camel@localhost.localdomain>
	 <45EE1EA3.90803@vmware.com>
	 <1173256666.24738.576.camel@localhost.localdomain>
	 <45EEF966.6060902@goop.org>
	 <1173300032.24738.750.camel@localhost.localdomain>
	 <45EF2991.1020204@goop.org>  <20070308080131.GB9295@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750755AbXCHK1q@vger.kernel.org>
In-Reply-To: <20070308080131.GB9295@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, tglx@linutronix.de, Dan Hecht <dhecht@vmware.com>, Zachary Amsden <zach@vmware.com>, akpm@linux-foundation.org, ak@suse.de, Virtualization Mailing List <virtualization@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>, James Morris <jmorris@namei.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-08 at 09:01 +0100, Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > > Your implementation is almost the perfect prototype, if you move the 
> > > 128 bit hackery into the hypervisor and hide it away from the kernel 
> > > :)
> > 
> > The point is to use the tsc to avoid making any hypercalls, so dealing 
> > with the tsc->ns conversion has to happen on the guest side somehow.
> 
> you are obsessed with avoiding a hypercall, but why? Granted it's slow 
> especially on things like SVN/VMX, but it's not fundamentally slow. We 
> definitely do not want to design our whole APIs and abstractions around 
> the temporary notion that 'hypercalls are slow'. I'd expect hypercalls 
> to be put into silicon just as much as SYSENTER was put into silicon. 

Indeed, I expect them to fall somewhere between system calls and context
switches.  Perhaps not slow, but definitely worth minimising.

> Anyway, in terms of guest time code, a /big/ amount of design junk can 
> be avoided by not trying to do sillynesses like 'virtual time'. The TSC 
> is awfully unreliable.

You mean stolen time?

I find this whole discussion really irritating, to be honest.  I just
want Thomas to implement the timer code for lguest, because that code
scares me...

I look forward to your patch 8)
Rusty.
