From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 0 of 4] mm+paravirt+xen: add
	pte	read-modify-write	abstraction
Date: Mon, 02 Jun 2008 13:09:53 -0700
Message-ID: <1212437393.972.50.camel@bodhitayantram.eng.vmware.com>
References: <patchbomb.1211552448@localhost>
	 <1211567273.7465.36.camel@bodhitayantram.eng.vmware.com>
	 <483729E7.9010002@goop.org>
	 <1211585122.7465.70.camel@bodhitayantram.eng.vmware.com>
	 <48409847.4000902@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755134AbYFBUJj@vger.kernel.org>
In-Reply-To: <48409847.4000902@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, xen-devel <xen-devel@lists.xensource.com>, Thomas Gleixner <tglx@linutronix.de>, Hugh Dickins <hugh@veritas.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2008-05-31 at 01:13 +0100, Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
> > We don't fault.  We write directly to the primary page tables, and clear
> > the pte just like native.  We just issue all mprotect updates in the
> > queue, and flush the queue when leaving lazy mmu mode.  You can't wait
> > for the TLB flush, you must flush the updates before releasing the
> > pagetable lock, or you could get misordered updates in an SMP system.
> >   
> 
> How do you track which ptes need shadow updates?  Do you walk the entire 
> pagetable on tlb flush?  Or just rebuild the shadow from scratch on demand?

No, we queue the updates as well as writing the primaries, we just flush
the queue before dropping the PT lock for one trip to the hypervisor.
