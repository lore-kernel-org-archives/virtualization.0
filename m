From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 8/21] [PATCH] unify current_text_addr
Date: Mon, 17 Dec 2007 20:52:31 -0200
Message-ID: <1197932006634-git-send-email-gcosta__28528.2598612413$1197942532$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
	<11979319903443-git-send-email-gcosta@redhat.com>
	<11979319953427-git-send-email-gcosta@redhat.com>
	<11979320011968-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979320011968-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

current_text_addr() has a different implementation in x86_64 and
i386, but it is not fundamentally different. I stick to the i386
implementation, that seem to be a common base, and move it to processor.h

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/processor.h    |   11 +++++++++++
 include/asm-x86/processor_32.h |    6 ------
 include/asm-x86/processor_64.h |    6 ------
 3 files changed, 11 insertions(+), 12 deletions(-)

Index: linux-2.6-x86/include/asm-x86/processor.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor.h
+++ linux-2.6-x86/include/asm-x86/processor.h
@@ -6,6 +6,17 @@
 #include <asm/page.h>
 #include <asm/system.h>
 
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+static inline void *current_text_addr(void)
+{
+	void *pc;
+	asm volatile("mov $1f,%0\n1:":"=r" (pc));
+	return pc;
+}
+
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 					 unsigned int *ecx, unsigned int *edx)
 {
Index: linux-2.6-x86/include/asm-x86/processor_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_32.h
+++ linux-2.6-x86/include/asm-x86/processor_32.h
@@ -22,12 +22,6 @@
 #include <asm/desc_defs.h>
 
 /*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
-
-/*
  *  CPU type and hardware bug flags. Kept separately for each CPU.
  *  Members of this structure are referenced in head.S, so think twice
  *  before touching them. [mj]
Index: linux-2.6-x86/include/asm-x86/processor_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_64.h
+++ linux-2.6-x86/include/asm-x86/processor_64.h
@@ -21,12 +21,6 @@
 #include <asm/desc_defs.h>
 
 /*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ void *pc; asm volatile("leaq 1f(%%rip),%0\n1:":"=r"(pc)); pc; })
-
-/*
  *  CPU type and hardware bug flags. Kept separately for each CPU.
  */
