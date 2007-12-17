From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 15/21] [PATCH] remove legacy stuff from processor_64.h
Date: Mon, 17 Dec 2007 20:52:38 -0200
Message-ID: <11979320401316-git-send-email-gcosta__23407.9773458236$1197942619$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
	<11979319903443-git-send-email-gcosta@redhat.com>
	<11979319953427-git-send-email-gcosta@redhat.com>
	<11979320011968-git-send-email-gcosta@redhat.com>
	<1197932006634-git-send-email-gcosta@redhat.com>
	<11979320114180-git-send-email-gcosta@redhat.com>
	<11979320163651-git-send-email-gcosta@redhat.com>
	<11979320211287-git-send-email-gcosta@redhat.com>
	<11979320252102-git-send-email-gcosta@redhat.com>
	<11979320302030-git-send-email-gcosta@redhat.com>
	<11979320354186-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979320354186-git-send-email-gcosta@redhat.com>
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

This patch removes definitions and macros that are not used anymore
from processor_64.h

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/processor_64.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

Index: linux-2.6-x86/include/asm-x86/processor_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_64.h
+++ linux-2.6-x86/include/asm-x86/processor_64.h
@@ -18,8 +18,6 @@
 #include <linux/personality.h>
 #include <asm/desc_defs.h>
 
-extern char ignore_irq13;
-
 extern void identify_cpu(struct cpuinfo_x86 *);
 
 /*
@@ -68,9 +66,6 @@ DECLARE_PER_CPU(struct orig_ist, orig_is
 	.x86_tss.sp0 = (unsigned long)&init_stack + sizeof(init_stack) \
 }
 
-#define INIT_MMAP \
-{ &init_mm, 0, 0, NULL, PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define start_thread(regs,new_rip,new_rsp) do { \
 	asm volatile("movl %0,%%fs; movl %0,%%es; movl %0,%%ds": :"r" (0));	 \
 	load_gs_index(0);							\
@@ -144,13 +139,4 @@ static inline void prefetchw(void *x) 
 			  "r" (x));
 } 
 
-
-#define stack_current() \
-({								\
-	struct thread_info *ti;					\
-	asm("andq %%rsp,%0; ":"=r" (ti) : "0" (CURRENT_MASK));	\
-	ti->task;					\
-})
-
-
 #endif /* __ASM_X86_64_PROCESSOR_H */
