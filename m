From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 9/9] unify system.h
Date: Wed,  5 Dec 2007 13:08:33 -0200
Message-ID: <11968673573299-git-send-email-gcosta@redhat.com>
References: 20071204204931.GC32018@elte.hu
	<1196867313972-git-send-email-gcosta@redhat.com>
	<1196867319253-git-send-email-gcosta@redhat.com>
	<11968673241599-git-send-email-gcosta@redhat.com>
	<11968673291072-git-send-email-gcosta@redhat.com>
	<1196867333728-git-send-email-gcosta@redhat.com>
	<11968673383347-git-send-email-gcosta@redhat.com>
	<1196867342420-git-send-email-gcosta@redhat.com>
	<11968673473254-git-send-email-gcosta@redhat.com>
	<11968673522098-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11968673522098-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch finishes the unification of system.h file.
i386 needs a constant to be defined, and it is defined inside an ifdef

Other than that, pretty much nothing but includes are left in the arch
specific headers, and they are deleted.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/system.h    |   10 ++++++++--
 include/asm-x86/system_32.h |   15 ---------------
 include/asm-x86/system_64.h |   10 ----------
 3 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/include/asm-x86/system.h b/include/asm-x86/system.h
index fd2abfd..9460db4 100644
--- a/include/asm-x86/system.h
+++ b/include/asm-x86/system.h
@@ -2,8 +2,12 @@
 #define _ASM_X86_SYSTEM_H_
 
 #include <asm/asm.h>
+#include <asm/segment.h>
+#include <asm/cpufeature.h>
+#include <asm/cmpxchg.h>
 
 #include <linux/kernel.h>
+#include <linux/irqflags.h>
 
 #ifdef CONFIG_X86_32
 #define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
@@ -34,7 +38,10 @@ extern struct task_struct *FASTCALL(__switch_to(struct task_struct *prev,
 		      "2" (prev), "d" (next));				\
 } while (0)
 
-# include "system_32.h"
+/*
+ * disable hlt during certain critical i/o operations
+ */
+#define HAVE_DISABLE_HLT
 #else
 #define __SAVE(reg, offset) "movq %%" #reg ",(14-" #offset ")*8(%%rsp)\n\t"
 #define __RESTORE(reg, offset) "movq (14-" #offset ")*8(%%rsp),%%" #reg "\n\t"
@@ -69,7 +76,6 @@ extern struct task_struct *FASTCALL(__switch_to(struct task_struct *prev,
 	       [thread_info] "i" (offsetof(struct task_struct, stack)),   \
 	       [pda_pcurrent] "i" (offsetof(struct x8664_pda, pcurrent))  \
 	     : "memory", "cc" __EXTRA_CLOBBER)
-# include "system_64.h"
 #endif
 
 #ifdef __KERNEL__
diff --git a/include/asm-x86/system_32.h b/include/asm-x86/system_32.h
deleted file mode 100644
index 83af464..0000000
--- a/include/asm-x86/system_32.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __ASM_SYSTEM_H
-#define __ASM_SYSTEM_H
-
-#include <asm/segment.h>
-#include <asm/cpufeature.h>
-#include <asm/cmpxchg.h>
-
-#include <linux/irqflags.h>
-
-/*
- * disable hlt during certain critical i/o operations
- */
-#define HAVE_DISABLE_HLT
-
-#endif
diff --git a/include/asm-x86/system_64.h b/include/asm-x86/system_64.h
deleted file mode 100644
index 8d2059f..0000000
--- a/include/asm-x86/system_64.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __ASM_SYSTEM_H
-#define __ASM_SYSTEM_H
-
-#include <asm/segment.h>
-#include <asm/cmpxchg.h>
-
-
-#include <linux/irqflags.h>
-
-#endif
-- 
1.4.4.2
