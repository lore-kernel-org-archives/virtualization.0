From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction abstraction
Date: Sat, 21 Jun 2008 08:06:36 +0200
Message-ID: <20080621060635.GA26422@elte.hu>
References: <20080619115832.GM15228@elte.hu>
	<alpine.LFD.1.10.0806190928100.2907@woody.linux-foundation.org>
	<20080619164708.GA32190@elte.hu>
	<20080620101028.GA23664@elte.hu> <485BFFC4.3070902@goop.org>
	<alpine.LFD.1.10.0806201211560.3167@woody.linux-foundation.org>
	<20080620195620.GA20183@elte.hu>
	<alpine.LFD.1.10.0806201302350.3167@woody.linux-foundation.org>
	<485C1000.8020806@goop.org> <485C117E.8070706@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <485C117E.8070706@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, benh@kernel.crashing.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Jeremy Fitzhardinge wrote:
>> Linus Torvalds wrote:
>>   
>>> On Fri, 20 Jun 2008, Ingo Molnar wrote:
>>>       
>>>> okay - Jeremy, could you try the fix below? (or tip/master, i just  
>>>> pushed this out)
>>>>           
>>> Actually, don't try that one.
>>>
>>> It needs to be a _byte_ registers, so "ir" was wrong. You need "iq".
>>>       
>>
>> Doesn't work, unfortunately:
>> {standard input}:20511: Error: Incorrect register `%eax' used with `b'  
>> suffix
>>
>>         lock; orb %eax,1(%rdi)  # tmp64,
>>   
>
> This does work:
>
>                asm volatile(LOCK_PREFIX "orb %1,%0"
>                        : CONST_MASK_ADDR(nr, addr)
>                        : "iq" ((u8)CONST_MASK(nr))
>                        : "memory");
>
> (ie, explicitly casting the mask to u8)

ok, i've pushed out the fix with this.

	Ingo
