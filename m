From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC] paravirt_ops: refactor struct paravirt_ops into smaller
 pv_*_ops
Date: Fri, 28 Sep 2007 16:36:01 -0700
Message-ID: <46FD8FE1.4090507@goop.org>
References: <46FD4388.6000106@goop.org> <97D612E30E1F88419025B06CB4CF1BE10396C957@scsmsx412.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756544AbXI1XgS@vger.kernel.org>
In-Reply-To: <97D612E30E1F88419025B06CB4CF1BE10396C957@scsmsx412.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

Nakajima, Jun wrote:
> Jeremy Fitzhardinge wrote:
>   
>> This patch refactors the paravirt_ops structure into groups of
>> functionally related ops:
>>
>> pv_info - random info, rather than function entrypoints
>> pv_init_ops - functions used at boot time (some for module_init too)
>> pv_misc_ops - lazy mode, which didn't fit well anywhere else
>> pv_time_ops - time-related functions
>> pv_cpu_ops - various privileged instruction ops
>> pv_irq_ops - operations for managing interrupt state
>> pv_apic_ops - APIC operations
>> pv_mmu_ops - operations for managing pagetables
>>
>>     
>
> Good. These make sense to me.
>
>   
>> +	.pv_irq_ops = {
>> +		 .init_IRQ = native_init_IRQ,
>> +		 .save_fl = native_save_fl,
>> +		 .restore_fl = native_restore_fl,
>> +		 .irq_disable = native_irq_disable,
>> +		 .irq_enable = native_irq_enable,
>> +		 .safe_halt = native_safe_halt,
>> +		 .halt = native_halt,
>> +	 },
>>     
>
> I think the halt stuff should be moved to pv_cpu_ops?
>   
You mean halt's alternate "shutdown vcpu" meaning if you call it with
interrupts disabled?  Yeah, I'd be happy to have an explicit op for
that, rather than making it a secondary overloaded meaning.  And use
"safe_halt" for all uses of "wait for next interrupt".

>> +	.pv_misc_ops = {
>> +		 .set_lazy_mode = paravirt_nop,
>> +	 },
>>     
>
> Or you can split it to pv_cpu_ops and pv_mmu_ops, assuming that they
> don't need to interact with each other in terms of the lazy handling.
>   

You mean have separate lazy_mmu and lazy_cpu (lazy_context_switch) ops? 
Possible, but they're still exclusive.  (I think VMI, at least, assumes
that you can't have lazy_mmu and lazy_cpu active at the same time, and
its nice to enforce this in the interface.)

But having a whole misc structure for this interface is pretty warty, I
admit.

    J
