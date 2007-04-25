From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 11/25] xen: Xen SMP guest support
Date: Wed, 25 Apr 2007 11:45:32 -0700
Message-ID: <462FA1CC.5010002@goop.org>
References: <20070423215638.563901986@goop.org> <20070423215711.197402369@goop.org> <200704251124.48445.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992899AbXDYSpA@vger.kernel.org>
In-Reply-To: <200704251124.48445.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Benjamin LaHaise <bcrl@kvack.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>   
>>  #ifdef CONFIG_X86_LOCAL_APIC
>>  static unsigned long xen_apic_read(unsigned long reg)
>>     
>
> Can't you just make them all NULL? Crashing here should be correct.
>   

No.  The APIC setup code does at least one unconditional read to get the
APIC version before deciding the APIC is disabled/not present.  In my
testing that's the only access to the APIC which happens under Xen, but
it wouldn't surprise me if there were other stray accesses with
different configurations (like the P4_THERMAL stuff).

>> +#ifdef CONFIG_SMP
>> +static const struct smp_ops xen_smp_ops __initdata = {
>>     
>
> Why __initdata? 
>   

It gets copied into the real smp_ops early on, so it isn't needed after
that.

>> +/* VCPUs are single-cored, and have no siblings */
>> +static void set_cpu_sibling_map(int cpu)
>>     
>
> Can you put this somewhere generic and use it everywhere? Don't want
> duplication of this code.
>   

OK.

> Strange check?
>   

Er, yes, that does look odd.

>> +
>> + * We need to reload %cr3 since the page tables may be going
>> + * away from under us..
>> + */
>> +static inline void leave_mm (unsigned long cpu)
>> +{
>> +#ifdef CONFIG_SMP
>> +	if (per_cpu(cpu_tlbstate, cpu).state == TLBSTATE_OK)
>> +		BUG();
>> +	cpu_clear(cpu, per_cpu(cpu_tlbstate, cpu).active_mm->cpu_vm_mask);
>> +#endif
>> +	load_cr3(swapper_pg_dir);
>>  }
>>     
>
> Should be out of line
>   

OK.

    J
