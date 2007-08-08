From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
	entry.S
Date: Wed, 8 Aug 2007 16:03:19 +0200
Message-ID: <20070808140319.GF14419__47558.2099556506$1186582003$gmane$org@one.firstfloor.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
	<Pine.LNX.4.58.0708080740490.5921@gandalf.stny.rr.com>
	<200708081424.49896.ak@suse.de>
	<Pine.LNX.4.58.0708080835350.6751@gandalf.stny.rr.com>
	<p738x8mrv4m.fsf@bingen.suse.de>
	<Pine.LNX.4.58.0708080919330.7236@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0708080924590.7236@gandalf.stny.rr.com>
	<20070808133001.GD14419@one.firstfloor.org>
	<Pine.LNX.4.58.0708080936070.7516@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0708080936070.7516@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lguest@ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, Andi Kleen <andi@firstfloor.org>, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 08, 2007 at 09:47:05AM -0400, Steven Rostedt wrote:
> /me working very hard to get lguest64 ready for public display
> 
> Here's a snippet from my version of core.c.  I've been thinking of ways to
> optimize it, but for now it works fine. This was done for both ring 3 and
> ring 1 lguest versions (this is the host running):
> 
> 
> 	/*
> 	 * Update the LSTAR to point to the HV syscall handler.
> 	 * Also update the fsbase if the guest uses one.
> 	 */
> 	wrmsrl(MSR_LSTAR, (unsigned long)HV_OFFSET(&lguest_syscall_trampoline));
> 
> [...]
> 	asm volatile ("pushq %2; pushq %%rsp; pushfq; pushq %3; call *%6;"
> 		      /* The stack we pushed is off by 8, due to the
> previous pushq */
> 		      "addq $8, %%rsp"

Weird stack inbalance, i'm surprised that works. %6 must be doing strange
things.

> 	/* Need to read manual, does rdmsr clear
> 	 * the top 32 bits of rax? */
> 	xor	%rax, %rax
> 
> 	movl  	$MSR_GS_BASE,%ecx
> 	rdmsr


This seems incredibly slow. Since GS changes are controlled in 
the kernel why don't you just cache them in the per cpu area? 
The only case where user can reload it is using segment
selector changes, which can be also handled.

Also why do you need the guest gs value anyways? 

You could just use your own stack and let the guest
switch to its own.

-Andi
