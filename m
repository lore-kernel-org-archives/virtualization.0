From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: lguest PAE
Date: Tue, 26 May 2009 12:58:47 -0700
Message-ID: <4A1C49F7.6060804@goop.org>
References: <1239902474.7166.49.camel@zetabook> <49E7785D.1040501@goop.org>
	<1243268749.7267.40.camel@zetabook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1243268749.7267.40.camel@zetabook>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matias Zabaljauregui <zabaljauregui@gmail.com>
Cc: virtualization@lists.osdl.org, lguest@ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

Matias Zabaljauregui wrote:
> Jeremy, I fixed the code following your comments (hope you still
> remember).
>
> I'd like to ask you again about this one:
>   
>   
>>>  /* Found in switcher.S */
>>>  extern unsigned long default_idt_entries[];
>>> diff --git a/arch/x86/include/asm/lguest_hcall.h b/arch/x86/include/asm/lguest_hcall.h
>>> index 0f4ee71..3860153 100644
>>> --- a/arch/x86/include/asm/lguest_hcall.h
>>> +++ b/arch/x86/include/asm/lguest_hcall.h
>>> @@ -17,6 +17,7 @@
>>>  #define LHCALL_SET_PMD		15
>>>  #define LHCALL_LOAD_TLS		16
>>>  #define LHCALL_NOTIFY		17
>>> +#define LHCALL_SET_PUD		18
>>>   
>>>       
>> PGD is more accurate than PUD (here, and the rest of the patch).  The 
>> pud level of the pagetable is the 4th level used by 64-bit; PAE just has 
>> PGD, PMD and PTE levels.  Due to pagetable level folding, the PGD is 
>> sometimes referred to as the PUD when looking "up" the pagetable tree 
>> (ie, the PUD is logically the next level up from the PMD), but its still 
>> just an alias for the PGD.  Since the hypervisor interface shouldn't 
>> care about how the guest OS manages its pagetables, it should use a 
>> consistent naming for the levels as they "really" are.  Lguest 
>> traditionally uses the same names that Linux does, so PGD is appropriate.
>>     
>   
> I understand, but then should we change also the LHCALL_SET_PMD name ?
> this is the one used for setting a new pgd when PAE is NOT activated.
>   

Yeah, that would be consistent.  In non-PAE, the pmd is just the next 
logical level up from the pte,  but just an alias name for the pgd.

> So, just to confirm:  even if we are implementing pv_mmu_ops.set_pud
> replacement (lguest_set_pud in our case), we should use LHCALL_SET_PGD
> hypercall name in this code because that is what host is going to
> actually do? 
>   

Yeah, I guess.  The set_pud notation makes some sense within Linux 
because of its pagetable-folding, but the actual lguest implementation 
is mapping between the guest's abstractions to the hypervisor abi's.

(In Xen this wasn't much of an issue because its the same hypercall for 
updating a pagetable at any level, and the hypervisor can work out 
what's going on for itself.)

    J
