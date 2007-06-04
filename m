From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: [PATCH] xen: use iret directly where possible
Date: Mon, 04 Jun 2007 14:28:58 -0700
Message-ID: <4664841A.8040802@goop.org>
References: <46646662.9020707@goop.org> <200706042145.30339.ak@suse.de>
	<4664772A.20602@goop.org> <200706042305.05340.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200706042305.05340.ak@suse.de>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Xen-devel <xen-devel@lists.xensource.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> If you stay cli you don't need that. Why is it that it has to enable 
> interrupts?
>   

Bear in mind we're talking about running paravirt under Xen in ring 1.

The cli/sti instructions don't control the event mask, so they're
effectively expensive no-ops (they trap into the hypervisor, are
emulated as no-ops). But if you mean cli as a general term for
"events/interrupts masked", then they can't remain masked when you
return to usermode.   iret normally sets the current eflags IF state
from the on-stack IF, but that's irrelevent to Xen; we need to extract
eflags.IF from the on-stack eflags, and put that into the vcpu's event
mask.  That's inherently non-atomic with respect to iret.

>> In your sequence, the event may become pending after "check again", even
>> though it won't be delivered. 
>>     
>
> sti only takes affect one instruction after it. So if you can make 
> it that small it would also work. But that might not help you.

No, it doesn't.  sti can't be run directly in ring1, and trapping into
Xen is exactly what this patch is trying to avoid.  Even if it did, Xen
treats it as a no-op, and it has no effect on the event mask state. 
Even if Xen did use it to control the event mask state, it would lose
the 1-instruction shadow because it trapped into the hypervisor, and a
new event may be pending as it comes out.


    J
