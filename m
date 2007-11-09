From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 3/24] consolidate spinlock.h
Date: Fri,  9 Nov 2007 16:42:44 -0200
Message-ID: <11946338053158-git-send-email-gcosta__29192.2330543914$1194643910$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11946337991750-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

The cli and sti instructions need to be replaced by paravirt hooks.
For the i386 architecture, this is already done. The code requirements
aren't much different from x86_64 POV, so this part is consolidated in
the common header

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 include/asm-x86/spinlock.h    |   14 ++++++++++++++
 include/asm-x86/spinlock_32.h |    9 ---------
 include/asm-x86/spinlock_64.h |    8 +++++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/asm-x86/spinlock.h b/include/asm-x86/spinlock.h
index d74d85e..e1d555a 100644
--- a/include/asm-x86/spinlock.h
+++ b/include/asm-x86/spinlock.h
@@ -1,5 +1,19 @@
+#ifndef _X86_SPINLOCK_H_
+#define _X86_SPINLOCK_H_
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define CLI_STRING	"cli"
+#define STI_STRING	"sti"
+#define CLI_STI_CLOBBERS
+#define CLI_STI_INPUT_ARGS
+#endif /* CONFIG_PARAVIRT */
+
 #ifdef CONFIG_X86_32
 # include "spinlock_32.h"
 #else
 # include "spinlock_64.h"
 #endif
+
+#endif
diff --git a/include/asm-x86/spinlock_32.h b/include/asm-x86/spinlock_32.h
index d3bcebe..ebbf371 100644
--- a/include/asm-x86/spinlock_32.h
+++ b/include/asm-x86/spinlock_32.h
@@ -7,15 +7,6 @@
 #include <asm/processor.h>
 #include <linux/compiler.h>
 
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#else
-#define CLI_STRING	"cli"
-#define STI_STRING	"sti"
-#define CLI_STI_CLOBBERS
-#define CLI_STI_INPUT_ARGS
-#endif /* CONFIG_PARAVIRT */
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  *
diff --git a/include/asm-x86/spinlock_64.h b/include/asm-x86/spinlock_64.h
index 88bf981..e56b17e 100644
--- a/include/asm-x86/spinlock_64.h
+++ b/include/asm-x86/spinlock_64.h
@@ -48,12 +48,12 @@ static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long fla
 		"jns 5f\n"
 		"testl $0x200, %1\n\t"	/* interrupts were disabled? */
 		"jz 4f\n\t"
-	        "sti\n"
+		STI_STRING "\n"
 		"3:\t"
 		"rep;nop\n\t"
 		"cmpl $0, %0\n\t"
 		"jle 3b\n\t"
-		"cli\n\t"
+		CLI_STRING "\n\t"
 		"jmp 1b\n"
 		"4:\t"
 		"rep;nop\n\t"
@@ -61,7 +61,9 @@ static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long fla
 		"jg 1b\n\t"
 		"jmp 4b\n"
 		"5:\n\t"
-		: "+m" (lock->slock) : "r" ((unsigned)flags) : "memory");
+		: "+m" (lock->slock)
+		: "r" ((unsigned)flags) CLI_STI_INPUT_ARGS
+		: "memory" CLI_STI_CLOBBERS);
 }
 #endif
 
-- 
1.4.4.2
