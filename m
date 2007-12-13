From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 09/19] introduce fill_ldt
Date: Thu, 13 Dec 2007 11:57:57 -0200
Message-ID: <11975543592701-git-send-email-gcosta__21743.2096753784$1197565759$gmane$org@redhat.com>
References: <11975113122984-git-send-email-gcosta@redhat.com>
	<1197554287294-git-send-email-gcosta@redhat.com>
	<11975542952896-git-send-email-gcosta@redhat.com>
	<11975543001070-git-send-email-gcosta@redhat.com>
	<1197554307167-git-send-email-gcosta@redhat.com>
	<11975543173017-git-send-email-gcosta@redhat.com>
	<11975543382698-git-send-email-gcosta@redhat.com>
	<11975543442801-git-send-email-gcosta@redhat.com>
	<11975543492215-git-send-email-gcosta@redhat.com>
	<11975543543850-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11975543543850-git-send-email-gcosta@redhat.com>
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

This patch introduces fill_ldt(), which populates a ldt descriptor
from a user_desc in once, instead of relying in the LDT_entry_a and
LDT_entry_b macros

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/ldt.c        |    3 +--
 arch/x86/kernel/process_64.c |    3 +--
 arch/x86/kernel/tls.c        |    7 +++----
 include/asm-x86/desc_32.h    |   15 ---------------
 include/asm-x86/desc_64.h    |   17 -----------------
 include/asm-x86/ldt.h        |   19 +++++++++++++++++++
 6 files changed, 24 insertions(+), 40 deletions(-)

Index: linux-2.6-x86/arch/x86/kernel/ldt.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/ldt.c
+++ linux-2.6-x86/arch/x86/kernel/ldt.c
@@ -223,8 +223,7 @@ static int write_ldt(void __user *ptr, u
 		}
 	}
 
-	ldt.a = LDT_entry_a(&ldt_info);
-	ldt.b = LDT_entry_b(&ldt_info);
+	fill_ldt(&ldt, &ldt_info);
 	if (oldmode)
 		ldt.avl = 0;
 
Index: linux-2.6-x86/arch/x86/kernel/process_64.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/process_64.c
+++ linux-2.6-x86/arch/x86/kernel/process_64.c
@@ -446,8 +446,7 @@ static inline void set_32bit_tls(struct 
 	};
 	struct desc_struct *desc = (void *)t->thread.tls_array;
 	desc += tls;
-	desc->a = LDT_entry_a(&ud);
-	desc->b = LDT_entry_b(&ud);
+	fill_ldt(desc, &ud);
 }
 
 static inline u32 read_32bit_tls(struct task_struct *t, int tls)
Index: linux-2.6-x86/arch/x86/kernel/tls.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/tls.c
+++ linux-2.6-x86/arch/x86/kernel/tls.c
@@ -67,10 +67,9 @@ int do_set_thread_area(struct task_struc
 	if (LDT_empty(&info)) {
 		desc[0] = 0;
 		desc[1] = 0;
-	} else {
-		desc[0] = LDT_entry_a(&info);
-		desc[1] = LDT_entry_b(&info);
-	}
+	} else
+		fill_ldt((struct desc_struct *)desc, &info);
+
 	if (t == &current->thread)
 		load_TLS(t, cpu);
 
Index: linux-2.6-x86/include/asm-x86/desc_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc_32.h
+++ linux-2.6-x86/include/asm-x86/desc_32.h
@@ -163,21 +163,6 @@ static inline void __set_tss_desc(unsign
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
 
-#define LDT_entry_a(info) \
-	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
-
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
-	(((info)->base_addr & 0x00ff0000) >> 16) | \
-	((info)->limit & 0xf0000) | \
-	(((info)->read_exec_only ^ 1) << 9) | \
-	((info)->contents << 10) | \
-	(((info)->seg_not_present ^ 1) << 15) | \
-	((info)->seg_32bit << 22) | \
-	((info)->limit_in_pages << 23) | \
-	((info)->useable << 20) | \
-	0x7000)
-
 #define LDT_empty(info) (\
 	(info)->base_addr	== 0	&& \
 	(info)->limit		== 0	&& \
Index: linux-2.6-x86/include/asm-x86/desc_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc_64.h
+++ linux-2.6-x86/include/asm-x86/desc_64.h
@@ -147,23 +147,6 @@ static inline void set_ldt_desc(unsigned
 			     (unsigned long)addr, DESC_LDT, size * 8 - 1);
 }
 
-#define LDT_entry_a(info) \
-	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
-/* Don't allow setting of the lm bit. It is useless anyways because
-   64bit system calls require __USER_CS. */
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
-	(((info)->base_addr & 0x00ff0000) >> 16) | \
-	((info)->limit & 0xf0000) | \
-	(((info)->read_exec_only ^ 1) << 9) | \
-	((info)->contents << 10) | \
-	(((info)->seg_not_present ^ 1) << 15) | \
-	((info)->seg_32bit << 22) | \
-	((info)->limit_in_pages << 23) | \
-	((info)->useable << 20) | \
-	/* ((info)->lm << 21) | */ \
-	0x7000)
-
 #define LDT_empty(info) (\
 	(info)->base_addr	== 0	&& \
 	(info)->limit		== 0	&& \
Index: linux-2.6-x86/include/asm-x86/desc.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc.h
+++ linux-2.6-x86/include/asm-x86/desc.h
@@ -1,5 +1,34 @@
+#ifndef _ASM_DESC_H_
+#define _ASM_DESC_H_
+
+#ifndef __ASSEMBLY__
+#include <asm/desc_defs.h>
+#include <asm/ldt.h>
+
+static inline void fill_ldt(struct desc_struct *desc, struct user_desc *info)
+{
+	desc->limit0 = info->limit & 0x0ffff;
+	desc->base0 = info->base_addr & 0x0000ffff;
+
+	desc->base1 = (info->base_addr & 0x00ff0000) >> 16;
+	desc->type = (info->read_exec_only ^ 1) << 1;
+	desc->type |= info->contents << 2;
+	desc->s = 1;
+	desc->dpl = 0x3;
+	desc->p = info->seg_not_present ^ 1;
+	desc->limit = (info->limit & 0xf0000) >> 16;
+	desc->avl = info->useable;
+	desc->d = info->seg_32bit;
+	desc->g = info->limit_in_pages;
+	desc->base2 = (info->base_addr & 0xff000000) >> 24;
+}
+
+#endif
+
 #ifdef CONFIG_X86_32
 # include "desc_32.h"
 #else
 # include "desc_64.h"
 #endif
+
+#endif
