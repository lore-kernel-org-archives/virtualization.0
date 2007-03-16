From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 04/26] Xen-paravirt_ops: Add pagetable
 accessors to pack and unpack pagetable entries
Date: Fri, 16 Mar 2007 11:42:19 -0700
Message-ID: <45FAE50B.7030004@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232526.502172500@goop.org>
	<20070316093844.GT23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316093844.GT23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
>> +static inline pmd_t native_make_pmd(unsigned long long val)
>> +{
>> +	return (pmd_t) { val };
>> +}
>> +static inline pte_t native_make_pte(unsigned long long val)
>> +{
>> +	return (pte_t) { .pte_low = val, .pte_high = (val >> 32) } ;
>> +}
>>     
>
> missing newlines between inline functions.
>   

OK.

>> +#ifndef CONFIG_PARAVIRT
>> +#define pmd_val(x)	native_pmd_val(x)
>> +#define __pmd(x)	native_make_pmd(x)
>> +#endif	/* !CONFIG_PARAVIRT */
>>     
>
> no need for the closing !CONFIG_PARAVIRT comment: this define is 2 lines 
> long so it's not that hard to find the start of the block. We typically 
> do the /* !CONFIG_XX */ comment only for larger blocks, and when 
> multiple #endif's intermix.
>   

Yeah, I tend to put them there reflexively.  Its so easy for an #endif
to drift away over time, and suddenly you have no idea what's going on. 
I agree its overkill in this case.

>>  #define HPAGE_SHIFT	22
>>  #include <asm-generic/pgtable-nopmd.h>
>> -#endif
>> +#endif	/* CONFIG_X86_PAE */
>>     
>
> (for example here the #endif comment is justified.)
>   

Yeah, and it probably started life much closer to the #ifdef...

    J
