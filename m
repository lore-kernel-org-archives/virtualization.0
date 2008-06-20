From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction abstraction
Date: Fri, 20 Jun 2008 12:10:28 +0200
Message-ID: <20080620101028.GA23664@elte.hu>
References: <1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>
	<4859A528.1010107@goop.org>
	<alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
	<4859AA47.2020903@goop.org>
	<alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
	<alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org>
	<20080619115832.GM15228@elte.hu>
	<alpine.LFD.1.10.0806190928100.2907@woody.linux-foundation.org>
	<20080619164708.GA32190@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20080619164708.GA32190@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Thu, 19 Jun 2008, Ingo Molnar wrote:
> > > 
> > > Below is the commit, it needed a small amount of massaging to apply the 
> > > void * -> unsigned long * change in the x86/bitops topic.
> > 
> > Well, that's your bug right there.
> > 
> > The macros very much depended on the pointers being "void *", due to 
> > the pointer arithmetic (which is a gcc extension that we use 
> > extensively - "void *" arithmetic works as if it was a byte 
> > pointer).
> 
> duh, yeah - of course. Will retry with that fixed :)

yep, the patch below got it all going and it passed 5 hours of testing 
already. Thanks,

	Ingo

------------------->
commit 7dbceaf9bb68919651901b101f44edd5391ee489
Author: Ingo Molnar <mingo@elte.hu>
Date:   Fri Jun 20 07:28:24 2008 +0200

    x86, bitops: make constant-bit set/clear_bit ops faster, adapt, clean up
    
    fix integration bug introduced by "x86: bitops take an unsigned long *"
    which turned "(void *) + x" into "(long *) + x".
    
    small cleanups to make it more apparent which value get propagated where.
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/include/asm-x86/bitops.h b/include/asm-x86/bitops.h
index ab7635a..6c50548 100644
--- a/include/asm-x86/bitops.h
+++ b/include/asm-x86/bitops.h
@@ -28,16 +28,15 @@
 #define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
 #endif
 
-#define ADDR BITOP_ADDR(addr)
+#define ADDR				BITOP_ADDR(addr)
 
 /*
  * We do the locked ops that don't return the old value as
  * a mask operation on a byte.
  */
-#define IS_IMMEDIATE(nr) \
-	(__builtin_constant_p(nr))
-#define CONST_MASK_ADDR BITOP_ADDR(addr + (nr>>3))
-#define CONST_MASK (1 << (nr & 7))
+#define IS_IMMEDIATE(nr)		(__builtin_constant_p(nr))
+#define CONST_MASK_ADDR(nr, addr)	BITOP_ADDR((void *)(addr) + ((nr)>>3))
+#define CONST_MASK(nr)			(1 << ((nr) & 7))
 
 /**
  * set_bit - Atomically set a bit in memory
@@ -56,13 +55,17 @@
  */
 static inline void set_bit(unsigned int nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr))
-		asm volatile(LOCK_PREFIX "orb %1,%0" : CONST_MASK_ADDR : "i" (CONST_MASK) : "memory");
-	else
-		asm volatile(LOCK_PREFIX "bts %1,%0" : ADDR : "Ir" (nr) : "memory");
+	if (IS_IMMEDIATE(nr)) {
+		asm volatile(LOCK_PREFIX "orb %1,%0"
+			: CONST_MASK_ADDR(nr, addr)
+			: "i" (CONST_MASK(nr))
+			: "memory");
+	} else {
+		asm volatile(LOCK_PREFIX "bts %1,%0"
+			: BITOP_ADDR(addr) : "Ir" (nr) : "memory");
+	}
 }
 
-
 /**
  * __set_bit - Set a bit in memory
  * @nr: the bit to set
@@ -89,10 +92,15 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
  */
 static inline void clear_bit(int nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr))
-		asm volatile(LOCK_PREFIX "andb %1,%0" : CONST_MASK_ADDR : "i" (~CONST_MASK));
-	else
-		asm volatile(LOCK_PREFIX "btr %1,%0" : ADDR : "Ir" (nr));
+	if (IS_IMMEDIATE(nr)) {
+		asm volatile(LOCK_PREFIX "andb %1,%0"
+			: CONST_MASK_ADDR(nr, addr)
+			: "i" (~CONST_MASK(nr)));
+	} else {
+		asm volatile(LOCK_PREFIX "btr %1,%0"
+			: BITOP_ADDR(addr)
+			: "Ir" (nr));
+	}
 }
 
 /*
