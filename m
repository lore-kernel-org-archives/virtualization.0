From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction abstraction
Date: Wed, 18 Jun 2008 17:37:27 -0700
Message-ID: <4859AA47.2020903@goop.org>
References: <b020e42384197b824320.1213615800@localhost>
	<1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>
	<4859A528.1010107@goop.org>
	<alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, benh@kernel.crashing.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Linus Torvalds wrote:
> On Wed, 18 Jun 2008, Jeremy Fitzhardinge wrote:
>   
>> Along the lines of:
>>     
>
> Hell no. There's a reason we have a special set_wrprotect() thing. We can 
> do it more efficiently on native hardware by just clearing the bit 
> atomically. No need to do the cmpxchg games.
>   

It's not cmpxchg, just xchg. 

In other words, is:

	lock btr $_PAGE_BIT_RW, (%rbx)

much cheaper than

	mov	$0, %rax
	xchg	%rax, (%rbx)
	and	$~_PAGE_RW, %rax
	mov	%rax, (%rbx)

?

It's the same number of locked RMW operations, so aside from being a few 
instructions longer, I think it would be much the same.

I guess the correct answer is "lmbench".

    J
