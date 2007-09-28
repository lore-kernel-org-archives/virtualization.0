From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH RFC] paravirt_ops: refactor struct paravirt_ops
	into	smaller pv_*_ops
Date: Fri, 28 Sep 2007 12:02:48 -0700
Message-ID: <1191006168.18310.28.camel@bodhitayantram.eng.vmware.com>
References: <46FD4388.6000106@goop.org>
	 <1191004776.18310.16.camel@bodhitayantram.eng.vmware.com>
	 <46FD4CA2.30402@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755684AbXI1TCi@vger.kernel.org>
In-Reply-To: <46FD4CA2.30402@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-09-28 at 11:49 -0700, Jeremy Fitzhardinge wrote:
> > We shouldn't need to export pv_init_ops.  
> 
> No.  The only ones I export are:
> 
> EXPORT_SYMBOL_GPL(pv_time_ops);
> EXPORT_SYMBOL_GPL(pv_cpu_ops);
> EXPORT_SYMBOL_GPL(pv_mmu_ops);
> EXPORT_SYMBOL_GPL(pv_apic_ops);
> EXPORT_SYMBOL    (pv_irq_ops);

Nicely done.  I know of some out of tree modules which use part of the
pv_cpu_ops and pv_mmu_ops, but we should not worry about such things,
and it turns out those modules don't need to be virtualized anyway.

> 
> 
> > It is debatable whether
> > CR2/CR3 should be part of CPU or MMU ops.
> 
> Yeah, I was in two minds.  CR3, at least, should be grouped with the
> other tlb operations, wherever they go.  And while they're privileged
> CPU instructions (cpu_ops), they're more logically related to the rest
> of the mmu state.  On the other hand, we could have an ops structure
> specifically dedicated to pagetable manipulations, and put the cr3/tlb
> ops elsewhere.

I'm not against either approach.  I think the way you did it is fine.
If it were up to me, I would probably have driven myself crazy splitting
hairs on it until I was bald.

> >   Also, can we drop write_cr2?
> > It isn't used anywhere, so the only reason to keep it is symmetry.
> > Which was a fine argument when it was an inline, but now it just adds
> > unused junk to the code.
> >   
> 
> I think its used in some cpu state save/restore code, but its not
> relevant to pv-ops.

Ah yes, it is used there.  We actually exercise some of those paths, but
they don't need to be strictly virtualized.

Zach
