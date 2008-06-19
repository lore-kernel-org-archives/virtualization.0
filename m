From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction abstraction
Date: Wed, 18 Jun 2008 21:03:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org>
References: <b020e42384197b824320.1213615800@localhost>
	<1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>
	<4859A528.1010107@goop.org>
	<alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
	<4859AA47.2020903@goop.org>
	<alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, benh@kernel.crashing.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org



On Wed, 18 Jun 2008, Linus Torvalds wrote:
> 
> And yes, the "lock andl" should be noticeably faster than the xchgl.

I dunno. Here's a untested (!!) patch that turns constant-bit 
set/clear_bit ops into byte mask ops (lock orb/andb).

It's not exactly pretty. The reason for using the byte versions is that a 
locked op is serialized in the memory pipeline anyway, so there are no 
forwarding issues (that could slow down things when we access things with 
different sizes), and the byte ops are a lot smaller than 32-bit and 
particularly 64-bit ops (big constants, and the 64-bit ops need the REX 
prefix byte too).

[ Side note: I wonder if we should turn the "test_bit()" C version into a 
  "char *" version too.. It could actually help with alias analysis, since 
  char pointers can alias anything. So it might be the RightThing(tm) to 
  do for multiple reasons. I dunno. It's a separate issue. ]

It does actually shrink the kernel image a bit (a couple of hundred bytes 
on the text segment for my everything-compiled-in image), and while it's 
totally untested the (admittedly few) code generation points I looked at 
seemed sane. And "lock orb" should be noticeably faster than "lock bts".

If somebody wants to play with it, go wild. I didn't do "change_bit()", 
because nobody sane uses that thing anyway. I guarantee nothing. And if it 
breaks, nobody saw me do anything.  You can't prove this email wasn't sent 
by somebody who is good at forging smtp.

This does require a gcc that is recent enough for "__builtin_constant_p()" 
to work in an inline function, but I suspect our kernel requirements are 
already higher than that. And if you do have an old gcc that is supported, 
the worst that would happen is that the optimization doesn't trigger.

		Linus

---
 include/asm-x86/bitops.h |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/asm-x86/bitops.h b/include/asm-x86/bitops.h
index ee4b3ea..c1b7f91 100644
--- a/include/asm-x86/bitops.h
+++ b/include/asm-x86/bitops.h
@@ -23,11 +23,22 @@
 #if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 1)
 /* Technically wrong, but this avoids compilation errors on some gcc
    versions. */
-#define ADDR "=m" (*(volatile long *) addr)
+#define BITOP_ADDR(x) "=m" (*(volatile long *) (x))
 #else
-#define ADDR "+m" (*(volatile long *) addr)
+#define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
 #endif
 
+#define ADDR BITOP_ADDR(addr)
+
+/*
+ * We do the locked ops that don't return the old value as
+ * a mask operation on a byte.
+ */
+#define IS_IMMEDIATE(nr) \
+	(__builtin_constant_p(nr))
+#define CONST_MASK_ADDR BITOP_ADDR(addr + (nr>>3))
+#define CONST_MASK (1 << (nr & 7))
+
 /**
  * set_bit - Atomically set a bit in memory
  * @nr: the bit to set
@@ -43,9 +54,12 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void set_bit(int nr, volatile void *addr)
+static inline void set_bit(unsigned int nr, volatile void *addr)
 {
-	asm volatile(LOCK_PREFIX "bts %1,%0" : ADDR : "Ir" (nr) : "memory");
+	if (IS_IMMEDIATE(nr))
+		asm volatile(LOCK_PREFIX "orb %1,%0" : CONST_MASK_ADDR : "i" (CONST_MASK) : "memory");
+	else
+		asm volatile(LOCK_PREFIX "bts %1,%0" : ADDR : "Ir" (nr) : "memory");
 }
 
 /**
@@ -74,7 +88,10 @@ static inline void __set_bit(int nr, volatile void *addr)
  */
 static inline void clear_bit(int nr, volatile void *addr)
 {
-	asm volatile(LOCK_PREFIX "btr %1,%0" : ADDR : "Ir" (nr));
+	if (IS_IMMEDIATE(nr))
+		asm volatile(LOCK_PREFIX "andb %1,%0" : CONST_MASK_ADDR : "i" (~CONST_MASK));
+	else
+		asm volatile(LOCK_PREFIX "btr %1,%0" : ADDR : "Ir" (nr));
 }
 
 /*
