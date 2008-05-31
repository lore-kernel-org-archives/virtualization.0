From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0 of 4] mm+paravirt+xen: add pte	read-modify-write	abstraction
Date: Sat, 31 May 2008 01:13:59 +0100
Message-ID: <48409847.4000902@goop.org>
References: <patchbomb.1211552448@localhost>	 <1211567273.7465.36.camel@bodhitayantram.eng.vmware.com>	 <483729E7.9010002@goop.org> <1211585122.7465.70.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756987AbYEaAPy@vger.kernel.org>
In-Reply-To: <1211585122.7465.70.camel@bodhitayantram.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, xen-devel <xen-devel@lists.xensource.com>, Thomas Gleixner <tglx@linutronix.de>, Hugh Dickins <hugh@veritas.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> We don't fault.  We write directly to the primary page tables, and clear
> the pte just like native.  We just issue all mprotect updates in the
> queue, and flush the queue when leaving lazy mmu mode.  You can't wait
> for the TLB flush, you must flush the updates before releasing the
> pagetable lock, or you could get misordered updates in an SMP system.
>   

How do you track which ptes need shadow updates?  Do you walk the entire 
pagetable on tlb flush?  Or just rebuild the shadow from scratch on demand?

    J
