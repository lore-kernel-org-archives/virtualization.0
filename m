From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Define EFLAGS_IF
Date: Thu, 22 Mar 2007 14:16:14 +1100
Message-ID: <1174533374.2713.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751558AbXCVDQc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Andi Kleen <andi@firstfloor.org>
List-Id: virtualization@lists.linuxfoundation.org

There is now more than one place where we use the fact that bit 9 of
eflags is the interrupt-enabled flag, so define EFLAGS_IF.  We make it
512 so it can be used in asm, too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

--- a/arch/i386/lguest/lguest.c
+++ b/arch/i386/lguest/lguest.c
@@ -107,9 +107,8 @@ static void fastcall irq_disable(void)
 
 static void fastcall irq_enable(void)
 {
-	/* Linux i386 code expects bit 9 set. */
 	/* FIXME: Check if interrupt pending... */
-	lguest_data.irq_enabled = 512;
+	lguest_data.irq_enabled = EFLAGS_IF;
 }
 
 static void fastcall lguest_load_gdt(const struct Xgt_desc_struct *desc)
@@ -394,7 +393,7 @@ static fastcall void lguest_write_idt_en
 	extern const char start_##name[], end_##name[];		\
 	asm("start_" #name ": " code "; end_" #name ":")
 DEF_LGUEST(cli, "movl $0," LGUEST_IRQ);
-DEF_LGUEST(sti, "movl $512," LGUEST_IRQ);
+DEF_LGUEST(sti, "movl $"__stringify(EFLAGS_IF)"," LGUEST_IRQ);
 DEF_LGUEST(popf, "movl %eax," LGUEST_IRQ);
 DEF_LGUEST(pushf, "movl " LGUEST_IRQ ",%eax");
 DEF_LGUEST(pushf_cli, "movl " LGUEST_IRQ ",%eax; movl $0," LGUEST_IRQ);
===================================================================
--- a/include/asm-i386/irqflags.h
+++ b/include/asm-i386/irqflags.h
@@ -87,6 +87,9 @@ static inline unsigned long __raw_local_
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PARAVIRT */
 
+/* Bit 9 of eflags means interrupts are enabled: a raw int for asm. */
+#define EFLAGS_IF 512
+
 #ifndef __ASSEMBLY__
 #define raw_local_save_flags(flags) \
 		do { (flags) = __raw_local_save_flags(); } while (0)
@@ -96,7 +99,7 @@ static inline unsigned long __raw_local_
 
 static inline int raw_irqs_disabled_flags(unsigned long flags)
 {
-	return !(flags & (1 << 9));
+	return !(flags & EFLAGS_IF);
 }
 
 static inline int raw_irqs_disabled(void)
