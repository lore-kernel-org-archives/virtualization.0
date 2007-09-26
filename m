From: rusty@rustcorp.com.au
Subject: [patch 29/43] lguest: Introduce "used_vectors" bitmap which can be
	used to reserve vectors.
Date: Wed, 26 Sep 2007 16:36:47 +1000
Message-ID: <20070926063650.358133002@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=vector-bitmap.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This simplifies the io_apic.c __assign_irq_vector() logic and removes
the explicit SYSCALL_VECTOR check, and also allows for vectors to be
reserved by other mechanisms (ie. lguest).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 arch/i386/kernel/i8259.c   |    3 ++-
 arch/i386/kernel/io_apic.c |   13 ++++++++-----
 arch/i386/kernel/traps.c   |   10 ++++++++++
 include/asm-i386/irq.h     |    3 +++
 4 files changed, 23 insertions(+), 6 deletions(-)

===================================================================
--- a/arch/i386/kernel/i8259.c
+++ b/arch/i386/kernel/i8259.c
@@ -400,7 +400,8 @@ void __init native_init_IRQ(void)
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (i >= NR_IRQS)
 			break;
-		if (vector != SYSCALL_VECTOR) 
+		/* SYSCALL_VECTOR was reserved in trap_init. */
+		if (!test_bit(vector, used_vectors))
 			set_intr_gate(vector, interrupt[i]);
 	}
 
===================================================================
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1198,7 +1198,7 @@ static int __assign_irq_vector(int irq)
 static int __assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, current_offset = 0;
-	int vector, offset, i;
+	int vector, offset;
 
 	BUG_ON((unsigned)irq >= NR_IRQ_VECTORS);
 
@@ -1215,11 +1215,8 @@ next:
 	}
 	if (vector == current_vector)
 		return -ENOSPC;
-	if (vector == SYSCALL_VECTOR)
+	if (test_and_set_bit(vector, used_vectors))
 		goto next;
-	for (i = 0; i < NR_IRQ_VECTORS; i++)
-		if (irq_vector[i] == vector)
-			goto next;
 
 	current_vector = vector;
 	current_offset = offset;
@@ -2290,6 +2287,12 @@ static inline void __init check_timer(vo
 
 void __init setup_IO_APIC(void)
 {
+	int i;
+
+	/* Reserve all the system vectors. */
+	for (i = FIRST_SYSTEM_VECTOR; i < NR_VECTORS; i++)
+		set_bit(i, used_vectors);
+
 	enable_IO_APIC();
 
 	if (acpi_ioapic)
===================================================================
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -64,6 +64,9 @@
 #include "mach_traps.h"
 
 int panic_on_unrecovered_nmi;
+
+DECLARE_BITMAP(used_vectors, NR_VECTORS);
+EXPORT_SYMBOL_GPL(used_vectors);
 
 asmlinkage int system_call(void);
 
@@ -1156,6 +1159,8 @@ static void __init set_task_gate(unsigne
 
 void __init trap_init(void)
 {
+	int i;
+
 #ifdef CONFIG_EISA
 	void __iomem *p = ioremap(0x0FFFD9, 4);
 	if (readl(p) == 'E'+('I'<<8)+('S'<<16)+('A'<<24)) {
@@ -1215,6 +1220,11 @@ void __init trap_init(void)
 
 	set_system_gate(SYSCALL_VECTOR,&system_call);
 
+	/* Reserve all the builtin and the syscall vector. */
+	for (i = 0; i < FIRST_EXTERNAL_VECTOR; i++)
+		set_bit(i, used_vectors);
+	set_bit(SYSCALL_VECTOR, used_vectors);
+
 	/*
 	 * Should be a barrier for any external CPU state.
 	 */
===================================================================
--- a/include/asm-i386/irq.h
+++ b/include/asm-i386/irq.h
@@ -45,4 +45,7 @@ void init_IRQ(void);
 void init_IRQ(void);
 void __init native_init_IRQ(void);
 
+/* Interrupt vector management */
+extern DECLARE_BITMAP(used_vectors, NR_VECTORS);
+
 #endif /* _ASM_IRQ_H */

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
