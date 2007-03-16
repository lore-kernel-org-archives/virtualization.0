From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 20/26] Xen-paravirt_ops: Core Xen implementation
Date: Fri, 16 Mar 2007 09:44:25 -0700
Message-ID: <45FAC969.6070006@goop.org>
References: <20070301232443.195603797@goop.org> <20070301232528.812011702@goop.org> <20070316091411.GF23174@elte.hu> <20070316163338.GI10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965515AbXCPQo0@vger.kernel.org>
In-Reply-To: <20070316163338.GI10574@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Adrian Bunk <bunk@stusta.de>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Ingo Molnar (mingo@elte.hu) wrote:
>   
>> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>>
>>     
>>> Core Xen Implementation
>>>
>>> This patch is a rollup of all the core pieces of the Xen 
>>> implementation, including booting, memory management, interrupts, time 
>>> and so on.
>>>       
>>> --- a/arch/i386/kernel/head.S
>>> +++ b/arch/i386/kernel/head.S
>>> @@ -535,6 +535,10 @@ unhandled_paravirt:
>>>  	ud2
>>>  #endif
>>>  
>>> +#ifdef CONFIG_XEN
>>> +#include "../xen/xen-head.S"
>>> +#endif
>>>       
>> i'd suggest to remove the #ifdef and push it into xen-head.S.
>>     
>
> That's been fixed, the two are built as seperate objects now.
>   

Actually, we tried it but it causes bad kernel images with some
binutils, so it has to be included for now.

>>> @@ -437,9 +437,9 @@ static unsigned long native_store_tr(voi
>>>  
>>>  static void native_load_tls(struct thread_struct *t, unsigned int cpu)
>>>  {
>>> -#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
>>> -	C(0); C(1); C(2);
>>> -#undef C
>>> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 0] = t->tls_array[0];
>>> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 1] = t->tls_array[1];
>>> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 2] = t->tls_array[2];
>>>  }
>>>       
>> this is a cleanup unrelated to the purpose of the patch.
>>     
>
> Sure, will split out.
>   

Already done in Rusty's cleanup patch.

    J
