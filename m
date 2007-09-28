From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [PATCH RFC] paravirt_ops: refactor struct paravirt_ops into smaller pv_*_ops
Date: Fri, 28 Sep 2007 16:25:11 -0700
Message-ID: <97D612E30E1F88419025B06CB4CF1BE10396C957@scsmsx412.amr.corp.intel.com>
References: <46FD4388.6000106@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756161AbXI1XZ1@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <46FD4388.6000106@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>, Gla
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
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

Good. These make sense to me.

> +	.pv_irq_ops = {
> +		 .init_IRQ = native_init_IRQ,
> +		 .save_fl = native_save_fl,
> +		 .restore_fl = native_restore_fl,
> +		 .irq_disable = native_irq_disable,
> +		 .irq_enable = native_irq_enable,
> +		 .safe_halt = native_safe_halt,
> +		 .halt = native_halt,
> +	 },

I think the halt stuff should be moved to pv_cpu_ops?

> +	.pv_misc_ops = {
> +		 .set_lazy_mode = paravirt_nop,
> +	 },

Or you can split it to pv_cpu_ops and pv_mmu_ops, assuming that they
don't need to interact with each other in terms of the lazy handling.

Jun
---
Intel Open Source Technology Center
