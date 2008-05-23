From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0 of 4] mm+paravirt+xen: add pte
	read-modify-write	abstraction
Date: Fri, 23 May 2008 21:32:39 +0100
Message-ID: <483729E7.9010002@goop.org>
References: <patchbomb.1211552448@localhost>
	<1211567273.7465.36.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1211567273.7465.36.camel@bodhitayantram.eng.vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Zachary Amsden <zach@vmware.com>
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> I'm a bit skeptical you can get such a semantic to work without a very
> heavyweight method in the hypervisor.  How do you guarantee no other CPU
> is fizzling the A/D bits in the page table (it can be done by hardware
> with direct page tables), unless you use some kind of IPI?  Is this why
> it is still 7x?
>   

No, you just use cmpxchg.  It's pretty lightweight really.  Xen holds a 
lock internally to stop other cpus from updating the pte in software, so 
the only source of modification is the hardware itself; the cmpxchg loop 
is guaranteed to terminate because the A/D bits can only transition from 
0->1.

I haven't really gone into depth as to exactly where the 7x number comes 
from.  I could increase the batch size (currently max of 32 pte 
updates/hypercall), and some of it is plain overhead from the in-kernel 
infrastructure.  A simpler and more hackish approach which basically 
pastes the Xen hypercall directly into the mprotect loop gets the 
overhead down to about 5.5x.

> Still, a 7x gain from asynchronous batching is very nice.  I wonder if
> that means the average mprotect size in your benchmark is 7 pages.
>   

Yeah, it's around 7x.  The batching pays off even for single page 
mprotects, because the trap and emulate of xchg is so expensive.


>> I believe that other virtualization systems, whether they use direct
>> paging like Xen, or a shadow pagetable scheme (vmi, kvm, lguest), can
>> make use of this interface to improve the performance.
>>     
>
> On VMI, we don't trap the xchg of the pte, thus we don't have any
> bottleneck here to begin with.

If you're doing code rewriting then I guess you can effectively do the 
same trick at that point.  If not, then presumably you take a fault for 
the first pte updated in the mprotect and then sync the shadow up when 
the tlb flush happens; batching that trap and the tlb flush would give 
you some benefit for small mprotects.

    J
