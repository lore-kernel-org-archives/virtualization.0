From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH RFC] paravirt_ops: refactor struct paravirt_ops into
	smaller pv_*_ops
Date: Fri, 28 Sep 2007 11:39:36 -0700
Message-ID: <1191004776.18310.16.camel@bodhitayantram.eng.vmware.com>
References: <46FD4388.6000106@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757980AbXI1Sj0@vger.kernel.org>
In-Reply-To: <46FD4388.6000106@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-09-28 at 11:10 -0700, Jeremy Fitzhardinge wrote:
> This patch refactors the paravirt_ops structure into groups of
> functionally related ops:
> 
> pv_info - random info, rather than function entrypoints
> pv_init_ops - functions used at boot time (some for module_init too)
> pv_misc_ops - lazy mode, which didn't fit well anywhere else
> pv_time_ops - time-related functions
> pv_cpu_ops - various privileged instruction ops
> pv_irq_ops - operations for managing interrupt state
> pv_apic_ops - APIC operations
> pv_mmu_ops - operations for managing pagetables
> 
> There are several motivations for this:
> 
> 1. Some of these ops will be general to all x86, and some will be
>    i386/x86-64 specific.  This makes it easier to share common stuff
>    while allowing separate implementations where needed.
> 
> 2. At the moment we must export all of paravirt_ops, but modules only
>    need selected parts of it.  This allows us to export on a case by case
>    basis (and also choose which export license we want to apply).

We shouldn't need to export pv_init_ops.  It is debatable whether
CR2/CR3 should be part of CPU or MMU ops.  Also, can we drop write_cr2?
It isn't used anywhere, so the only reason to keep it is symmetry.
Which was a fine argument when it was an inline, but now it just adds
unused junk to the code.

> This still needs to be reconciled with the x86 merge and glommer's
> paravirt_ops unification work.

Those issues aside, this looks great.  I'll give it a whirl today.

Zach
