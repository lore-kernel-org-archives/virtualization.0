From: Zachary Amsden <zach@vmware.com>
Subject: Re: Re: [patch 17/24] Xen-paravirt_ops: avoid having
	a bad	selector in %gs during context switch
Date: Wed, 21 Feb 2007 15:25:04 -0800
Message-ID: <45DCD4D0.2000101@vmware.com>
References: <20070221205254.169835700@goop.org>	<20070221205323.770169136@goop.org>
	<200702212310.02218.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200702212310.02218.ak@suse.de>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>>  	/*
>> +	 * Temporary hack: zero gs now that we've saved it so that Xen
>> +	 * doesn't try to reload the old value after changing the GDT
>> +	 * during the context switch.  This can go away once Xen has
>> +	 * been taught to only reload %gs when it absolutely must.
>> +	 */
>> +	loadsegment(gs, 0);
>>     
>
> Sorry, but i don't really want that unconditionally in the context switch.
> Adding a paravirt ops for it would be also ugly. Can Xen be fixed?
>   

I agree with that, but especially because this is not even the right 
place to save and clear gs; when userspace uses an LDT based %gs, you 
need to do this all the way back in mmu_context.h before you switch the 
LDT out.  We have the same bug, but I was loathe to try to fix it yet, 
since it could mean some strange code movement.  The awkward bit is that 
switch_mm doesn't have the pointer to the previous task, only it's mm, 
so there is no place to save gs.  Perhaps it is time to move the LDT 
switch into switch_to instead of switch_mm?  It's not like there are 
different per-process LDTs in the fixmap or something, which I could see 
as a valid reason to associate this with the mm switch.  But all process 
LDTs are global, so there isn't an issue.

And I noticed this martian hanging out in mmu_context.h:

#define deactivate_mm(tsk, mm)                  \
        asm("movl %0,%%gs": :"r" (0));

Zach
