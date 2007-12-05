From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 4/9] remove references to cr8 register
Date: Wed,  5 Dec 2007 13:08:28 -0200
Message-ID: <1196867333728-git-send-email-gcosta__32696.4406566278$1196877405$gmane$org@redhat.com>
References: 20071204204931.GC32018@elte.hu
	<1196867313972-git-send-email-gcosta@redhat.com>
	<1196867319253-git-send-email-gcosta@redhat.com>
	<11968673241599-git-send-email-gcosta@redhat.com>
	<11968673291072-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11968673291072-git-send-email-gcosta@redhat.com>
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

As pointed out by Andi, linux never really uses this register
so saving and restoring is not really necessary. This patch
removes all references to it.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/asm-offsets_64.c |    1 -
 arch/x86/kernel/suspend_64.c     |    2 --
 include/asm-x86/suspend_64.h     |    2 +-
 include/asm-x86/system_64.h      |   12 ------------
 4 files changed, 1 insertions(+), 16 deletions(-)

Index: linux-2.6-x86/arch/x86/kernel/asm-offsets_64.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/asm-offsets_64.c
+++ linux-2.6-x86/arch/x86/kernel/asm-offsets_64.c
@@ -107,7 +107,6 @@ int main(void)
 	ENTRY(cr2);
 	ENTRY(cr3);
 	ENTRY(cr4);
-	ENTRY(cr8);
 	BLANK();
 #undef ENTRY
 	DEFINE(TSS_ist, offsetof(struct tss_struct, ist));
Index: linux-2.6-x86/arch/x86/kernel/suspend_64.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/suspend_64.c
+++ linux-2.6-x86/arch/x86/kernel/suspend_64.c
@@ -53,7 +53,6 @@ void __save_processor_state(struct saved
 	ctxt->cr2 = read_cr2();
 	ctxt->cr3 = read_cr3();
 	ctxt->cr4 = read_cr4();
-	ctxt->cr8 = read_cr8();
 }
 
 void save_processor_state(void)
@@ -75,7 +74,6 @@ void __restore_processor_state(struct sa
 	 * control registers
 	 */
 	wrmsrl(MSR_EFER, ctxt->efer);
-	write_cr8(ctxt->cr8);
 	write_cr4(ctxt->cr4);
 	write_cr3(ctxt->cr3);
 	write_cr2(ctxt->cr2);
Index: linux-2.6-x86/include/asm-x86/suspend_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/suspend_64.h
+++ linux-2.6-x86/include/asm-x86/suspend_64.h
@@ -20,7 +20,7 @@ struct saved_context {
 	struct pt_regs regs;
   	u16 ds, es, fs, gs, ss;
 	unsigned long gs_base, gs_kernel_base, fs_base;
-	unsigned long cr0, cr2, cr3, cr4, cr8;
+	unsigned long cr0, cr2, cr3, cr4;
 	unsigned long efer;
 	u16 gdt_pad;
 	u16 gdt_limit;
Index: linux-2.6-x86/include/asm-x86/system_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/system_64.h
+++ linux-2.6-x86/include/asm-x86/system_64.h
@@ -95,18 +95,6 @@ static inline void write_cr4(unsigned lo
 	asm volatile("movq %0,%%cr4" :: "r" (val) : "memory");
 }
 
-static inline unsigned long read_cr8(void)
-{
-	unsigned long cr8;
-	asm volatile("movq %%cr8,%0" : "=r" (cr8));
-	return cr8;
-}
-
-static inline void write_cr8(unsigned long val)
-{
-	asm volatile("movq %0,%%cr8" :: "r" (val) : "memory");
-}
-
 #define stts() write_cr0(8 | read_cr0())
 
 #define wbinvd() \
