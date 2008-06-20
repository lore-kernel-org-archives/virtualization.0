From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction	abstraction
Date: Fri, 20 Jun 2008 12:06:44 -0700
Message-ID: <485BFFC4.3070902@goop.org>
References: <1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>
	<4859A528.1010107@goop.org>
	<alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
	<4859AA47.2020903@goop.org>
	<alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
	<alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org>
	<20080619115832.GM15228@elte.hu>
	<alpine.LFD.1.10.0806190928100.2907@woody.linux-foundation.org>
	<20080619164708.GA32190@elte.hu> <20080620101028.GA23664@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20080620101028.GA23664@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, benh@kernel.crashing.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>   
>> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>     
>>> On Thu, 19 Jun 2008, Ingo Molnar wrote:
>>>       
>>>> Below is the commit, it needed a small amount of massaging to apply the 
>>>> void * -> unsigned long * change in the x86/bitops topic.
>>>>         
>>> Well, that's your bug right there.
>>>
>>> The macros very much depended on the pointers being "void *", due to 
>>> the pointer arithmetic (which is a gcc extension that we use 
>>> extensively - "void *" arithmetic works as if it was a byte 
>>> pointer).
>>>       
>> duh, yeah - of course. Will retry with that fixed :)
>>     
>
> yep, the patch below got it all going and it passed 5 hours of testing 
> already. Thanks,
>   

Blows up on "gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)":

  CC      init/main.o
include2/asm/bitops.h: In function `start_kernel':
include2/asm/bitops.h:59: warning: asm operand 1 probably doesn't match constraints
include2/asm/bitops.h:59: warning: asm operand 1 probably doesn't match constraints
include2/asm/bitops.h:59: warning: asm operand 1 probably doesn't match constraints
include2/asm/bitops.h:59: error: impossible constraint in `asm'
include2/asm/bitops.h:59: error: impossible constraint in `asm'
include2/asm/bitops.h:59: error: impossible constraint in `asm'

	J
