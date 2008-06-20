From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction abstraction
Date: Fri, 20 Jun 2008 21:56:20 +0200
Message-ID: <20080620195620.GA20183@elte.hu>
References: <alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
	<4859AA47.2020903@goop.org>
	<alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
	<alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org>
	<20080619115832.GM15228@elte.hu>
	<alpine.LFD.1.10.0806190928100.2907@woody.linux-foundation.org>
	<20080619164708.GA32190@elte.hu>
	<20080620101028.GA23664@elte.hu> <485BFFC4.3070902@goop.org>
	<alpine.LFD.1.10.0806201211560.3167@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806201211560.3167@woody.linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, benh@kernel.crashing.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 20 Jun 2008, Jeremy Fitzhardinge wrote:
> > 
> > Blows up on "gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)":
> 
> Yeah, I was a bit worried about that. Gcc sometimes does insane 
> things.
> 
> We literally just tested that the asm should only _ever_ be generated 
> with a constant value, but if some gcc dead-code removal thing doesn't 
> work, it will then screw up and try to generate the asm even for a 
> non-constant thing.
> 
> The fairly trivial fix is probably to just change the "i" to "ir", 
> safe in the knowledge that any _sane_ case will never use the "r" 
> possibility. I suspect even your insane case will end up then killing 
> the bad choice later.

okay - Jeremy, could you try the fix below? (or tip/master, i just 
pushed this out)

(i dont use gcc 3.x myself to build the kernel, had way too many 
miscompilations in randconfig tests in the past.)

	Ingo

-------------->
commit b68b80b8ab39c42707dc126c41e87d46edc97c27
Author: Ingo Molnar <mingo@elte.hu>
Date:   Fri Jun 20 21:50:20 2008 +0200

    x86, bitops: make constant-bit set/clear_bit ops faster, gcc workaround
    
    Jeremy Fitzhardinge reported this compiler bug:
    
    Suggestion from Linus: add "r" to the input constraint of the
    set_bit()/clear_bit()'s constant 'nr' branch:
    
    Blows up on "gcc version 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)":
    
     CC      init/main.o
    include2/asm/bitops.h: In function `start_kernel':
    include2/asm/bitops.h:59: warning: asm operand 1 probably doesn't match constraints
    include2/asm/bitops.h:59: warning: asm operand 1 probably doesn't match constraints
    include2/asm/bitops.h:59: warning: asm operand 1 probably doesn't match constraints
    include2/asm/bitops.h:59: error: impossible constraint in `asm'
    include2/asm/bitops.h:59: error: impossible constraint in `asm'
    include2/asm/bitops.h:59: error: impossible constraint in `asm'
    
    Reported-by: Jeremy Fitzhardinge <jeremy@goop.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/include/asm-x86/bitops.h b/include/asm-x86/bitops.h
index 6c50548..4575de4 100644
--- a/include/asm-x86/bitops.h
+++ b/include/asm-x86/bitops.h
@@ -58,7 +58,7 @@ static inline void set_bit(unsigned int nr, volatile unsigned long *addr)
 	if (IS_IMMEDIATE(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "i" (CONST_MASK(nr))
+			: "ir" (CONST_MASK(nr))
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX "bts %1,%0"
@@ -95,7 +95,7 @@ static inline void clear_bit(int nr, volatile unsigned long *addr)
 	if (IS_IMMEDIATE(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "i" (~CONST_MASK(nr)));
+			: "ir" (~CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX "btr %1,%0"
 			: BITOP_ADDR(addr)
