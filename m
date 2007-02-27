From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 04/26] Xen-paravirt_ops: Add pagetable
 accessors to pack and unpack pagetable entries
Date: Tue, 27 Feb 2007 10:52:31 -0800
Message-ID: <45E47DEF.70405@goop.org>
References: <20070227081337.434798469@goop.org>
	<20070227081630.311681690@goop.org>
	<20070227100850.GA10827@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070227100850.GA10827@elte.hu>
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
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> ===================================================================
>> --- a/arch/i386/kernel/vmlinux.lds.S
>> +++ b/arch/i386/kernel/vmlinux.lds.S
>> @@ -21,6 +21,9 @@
>>  #include <asm/page.h>
>>  #include <asm/cache.h>
>>  #include <asm/boot.h>
>> +
>> +#undef ENTRY
>> +#undef ALIGN
>>     
>
> hm, what's this? The reason is not documented.
>   
Good point; I'll add some comments.  The reason is that asm/linkage.h
ends up being included as a result of the other header file changes, and
it conflicts with the use of ENTRY and ALIGN here.  But its possible
that asm/linkage isn't needed anymore; that would be ideal if true.

>> +#ifdef CONFIG_PARAVIRT
>> +/* After pte_t, etc, have been defined */
>> +#include <asm/paravirt.h>
>> +#endif
>>     
>
> hm - there's already a CONFIG_PARAVIRT conditional in 
> asm-i386/paravirt.h.
>   

Yes, but it happens after asm/paravirt.h has already included some
things, and it ends up causing problems.  paravirt.h still defines
various stub functions in the !CONFIG_PARAVIRT case, so it needs to do
the includes either way.

    J
