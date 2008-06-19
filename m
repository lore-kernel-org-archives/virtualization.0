From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1 of 4] mm: add a
	ptep_modify_prot	transaction	abstraction
Date: Thu, 19 Jun 2008 10:57:00 -0700
Message-ID: <485A9DEC.8010406@goop.org>
References: <b020e42384197b824320.1213615800@localhost>	
	<1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>	
	<4859A528.1010107@goop.org>	
	<alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>	
	<1213835971.8011.54.camel@pasglop> <4859E8AF.30306@goop.org>
	<1213860031.8011.65.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1213860031.8011.65.camel@pasglop>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: benh@kernel.crashing.org
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Benjamin Herrenschmidt wrote:
>> Which architecture are you interested in?  If it isn't x86, you can 
>> probably get anything past Linus ;)
>>
>> I'll do some measurements to see what effect the batchable 
>> ptep_set_wrprotect() has on native.  If it's significant, I'll propose 
>> making it conditional on CONFIG_PARAVIRT.
>>     
>
> Oh, I mostly think about powerpc, I just wondered if I could re-use
> your new stuff in that context. Mostly idle thoughts at this stage, I
> haven't looked seriously.
>   

There are general-purpose hooks in the common code which architectures 
can implement however they like.  In x86-land we hook them up to pvops, 
but you can handle them however you want.

> I have an old patch set to batch forks (and mprotect etc...) TLB
> invalidations (which is what I really want to batch on powerpc, more
> than the actual PTE changes) that involves subtle changes to the
> batching mechanisms etc...
>   

Do you mean setting up batches of per-page tlb shootdowns rather than 
going a global tlb flush at the end?

    J
