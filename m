From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 19/19] unify set_tss_desc
Date: Wed, 12 Dec 2007 10:54:04 -0200
Message-ID: <11974641631993-git-send-email-gcosta__8736.63191819123$1197475152$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11974640441088-git-send-email-gcosta@redhat.com>
	<11974640522688-git-send-email-gcosta@redhat.com>
	<1197464057242-git-send-email-gcosta@redhat.com>
	<11974640653022-git-send-email-gcosta@redhat.com>
	<1197464070228-git-send-email-gcosta@redhat.com>
	<11974640752137-git-send-email-gcosta@redhat.com>
	<11974640813511-git-send-email-gcosta@redhat.com>
	<11974640872474-git-send-email-gcosta@redhat.com>
	<11974640932406-git-send-email-gcosta@redhat.com>
	<11974640983333-git-send-email-gcosta@redhat.com>
	<11974641042757-git-send-email-gcosta@redhat.com>
	<11974641102691-git-send-email-gcosta@redhat.com>
	<11974641172402-git-send-email-gcosta@redhat.com>
	<11974641243264-git-send-email-gcosta@redhat.com>
	<11974641314148-git-send-email-gcosta@redhat.com>
	<1197464139284-git-send-email-gcosta@redhat.com>
	<1197464145737-git-send-email-gcosta@redhat.com>
	<11974641501854-git-send-email-gcosta@redhat.com>
	<11974641572562-git-send-email-g! costa@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11974641572562-git-send-email-gcosta@redhat.com>
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
@@ -147,6 +147,39 @@ static inline void pack_ldt(ldt_desc *ld
 #endif
 }
 
+static inline void pack_tss(tss_desc *tss, unsigned long addr,
+			   unsigned size, unsigned entry)
+{
+#ifdef CONFIG_X86_64
+		set_tssldt_descriptor(tss,
+			     addr, entry, size);
+#else
+		pack_descriptor(tss, (unsigned long)addr,
+				size,
+				0x80 | entry, 0);
+#endif
+}
+
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
+	pack_tss(&tss, (unsigned long)addr,
+		IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1,
+		DESC_TSS);
+	write_gdt_entry(d, entry, &tss, sizeof(tss));
+}
+
+#define set_tss_desc(cpu, addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
+
 static inline void native_set_ldt(const void *addr, unsigned int entries)
 {
 	if (likely(entries == 0))
@@ -205,13 +238,6 @@ static inline void native_load_tls(struc
 }
 #endif /* __ASSEMBLY__ */
 
-
-#ifdef CONFIG_X86_32
-# include "desc_32.h"
-#else
-# include "desc_64.h"
-#endif
-
 #ifndef __ASSEMBLY__
 
 #define _LDT_empty(info) (\
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
+++ /dev/null
@@ -1,34 +0,0 @@
-/* Written 2000 by Andi Kleen */
-#ifndef __ARCH_DESC_H
-#define __ARCH_DESC_H
-
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
-	write_gdt_entry(d, GDT_ENTRY_TSS, &tss, sizeof(tss_desc));
-}
-
-#endif /* !__ASSEMBLY__ */
-
-#endif
