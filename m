From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 19/19] unify set_tss_desc
Date: Thu, 13 Dec 2007 11:58:07 -0200
Message-ID: <1197554409924-git-send-email-gcosta__35764.5537973896$1197564944$gmane$org@redhat.com>
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
	<11975543592701-git-send-email-gcosta@redhat.com>
	<11975543641360-git-send-email-gcosta@redhat.com>
	<11975543691134-git-send-email-gcosta@redhat.com>
	<11975543742848-git-send-email-gcosta@redhat.com>
	<11975543792334-git-send-email-gcosta@redhat.com>
	<11975543843977-git-send-email-gcosta@redhat.com>
	<11975543892403-git-send-email-gcosta@redhat.com>
	<11975543942657-git-send-email-gcosta@redhat.com>
	<1197554399402-git-send-email-gcosta@redhat.com>
	<1197554404337-git-send-email-! gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1197554404337-git-send-email-gcosta@redhat.com>
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

This patch unifies the set_tss_desc between i386 and x86_64,
which can now have a common implementation. After the old
functions are removed from desc_{32,64}.h, nothing important is
left, and the files can be removed.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc.h    |   40 +++++++++++++++++++++++++++++++++-------
 include/asm-x86/desc_32.h |   27 ---------------------------
 include/asm-x86/desc_64.h |   34 ----------------------------------
 3 files changed, 33 insertions(+), 68 deletions(-)
 delete mode 100644 include/asm-x86/desc_32.h
 delete mode 100644 include/asm-x86/desc_64.h

Index: linux-2.6-x86/include/asm-x86/desc.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc.h
+++ linux-2.6-x86/include/asm-x86/desc.h
@@ -157,6 +157,26 @@ static inline void set_tssldt_descriptor
 #endif
 }
 
+static inline void __set_tss_desc(unsigned cpu, unsigned int entry, void *addr)
+{
+	struct desc_struct *d = get_cpu_gdt_table(cpu);
+	tss_desc tss;
+
+	/*
+	 * sizeof(unsigned long) coming from an extra "long" at the end
+	 * of the iobitmap. See tss_struct definition in processor.h
+	 *
+	 * -1? seg base+limit should be pointing to the address of the
+	 * last valid byte
+	 */
+	set_tssldt_descriptor(&tss, (unsigned long)addr,
+		IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1,
+		DESC_TSS);
+	write_gdt_entry(d, entry, &tss, DESC_TSS);
+}
+
+#define set_tss_desc(cpu, addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
+
 static inline void native_set_ldt(const void *addr, unsigned int entries)
 {
 	if (likely(entries == 0))
@@ -214,12 +234,6 @@ static inline void native_load_tls(struc
 		gdt[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i];
 }
 
-#ifdef CONFIG_X86_32
-# include "desc_32.h"
-#else
-# include "desc_64.h"
-#endif
-
 #define _LDT_empty(info) (\
 	(info)->base_addr	== 0	&& \
 	(info)->limit		== 0	&& \
Index: linux-2.6-x86/include/asm-x86/desc_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc_32.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef __ARCH_DESC_H
-#define __ARCH_DESC_H
-
-#include <asm/ldt.h>
-#include <asm/segment.h>
-#include <asm/desc_defs.h>
-
-#ifndef __ASSEMBLY__
-
-#include <linux/preempt.h>
-#include <linux/percpu.h>
-
-static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, const void *addr)
-{
-	tss_desc tss;
-	pack_descriptor(&tss, (unsigned long)addr,
-			offsetof(struct tss_struct, __cacheline_filler) - 1,
-			DESC_TSS, 0);
-	write_gdt_entry(get_cpu_gdt_table(cpu), entry, &tss, DESC_TSS);
-}
-
-
-#define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
-
-#endif /* !__ASSEMBLY__ */
-
-#endif
Index: linux-2.6-x86/include/asm-x86/desc_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc_64.h
+++ linux-2.6-x86/include/asm-x86/desc_64.h
@@ -1,34 +1 @@
-/* Written 2000 by Andi Kleen */
-#ifndef __ARCH_DESC_H
-#define __ARCH_DESC_H
 
-#include <linux/threads.h>
-#include <asm/ldt.h>
-
-#ifndef __ASSEMBLY__
-
-#include <linux/string.h>
-
-#include <asm/segment.h>
-
-static inline void set_tss_desc(unsigned cpu, void *addr)
-{
-	struct desc_struct *d = get_cpu_gdt_table(cpu);
-	tss_desc tss;
-
-	/*
-	 * sizeof(unsigned long) coming from an extra "long" at the end
-	 * of the iobitmap. See tss_struct definition in processor.h
-	 *
-	 * -1? seg base+limit should be pointing to the address of the
-	 * last valid byte
-	 */
-	set_tssldt_descriptor(&tss,
-		(unsigned long)addr, DESC_TSS,
-		IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1);
-	write_gdt_entry(d, GDT_ENTRY_TSS, &tss, DESC_TSS);
-}
-
-#endif /* !__ASSEMBLY__ */
-
-#endif
