From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: [patch 17/24] Xen-paravirt_ops: avoid having
	a bad	selector in %gs during context switch
Date: Wed, 21 Feb 2007 15:29:37 -0800
Message-ID: <45DCD5E1.5070201@goop.org>
References: <20070221205254.169835700@goop.org>	<20070221205323.770169136@goop.org>
	<200702212310.02218.ak@suse.de> <45DCD4D0.2000101@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45DCD4D0.2000101@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Zachary Amsden <zach@vmware.com>
Cc: xen-devel@lists.xensource.com, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> I agree with that, but especially because this is not even the right
> place to save and clear gs; when userspace uses an LDT based %gs, you
> need to do this all the way back in mmu_context.h before you switch
> the LDT out. 

Yeah.  This patch was really just to shut my debug Xen build up.  
There's no correctness issue one way or the other, so it doesn't really
matter that it doesn't catch LDT-using processes.

> And I noticed this martian hanging out in mmu_context.h:
>
> #define deactivate_mm(tsk, mm)                  \
>        asm("movl %0,%%gs": :"r" (0));

Yeah, I've always wondered what this is for.  Its a remnant of a
remnant, I think.

    J
