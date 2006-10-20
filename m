From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 2/5] Interrupts subarch cleanup.patch
Date: Thu, 19 Oct 2006 17:09:22 -0700
Message-ID: <200610200009.k9K09M68027564@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

A brave attempt to be rid of an unnecessary subarch hook and clean things
up a bit.  First, all subarches use IRQ-2 as a cascade IRQ.  So do that in
the common code.  Second, there is no need for a pre_intr_init_hook.  We
can set up the interrupt gates at any time, as this doesn't touch any
real hardware, just the processor gates.  Now the subarch code still needs
to setup the appropriate irq descriptors, fill in any custom interrupt
gates, and initialize controllers, but it can do that all at once.

This removes the need for a pre_intr_init_hook.  The fpu_irq change is
a nop - it just looks nicer.

Signed-off-by: Zachary Amsden <zach@vmware.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/i8259.c
+++ b/arch/i386/kernel/i8259.c
@@ -347,7 +347,18 @@ static irqreturn_t math_error_irq(int cp
  * New motherboards sometimes make IRQ 13 be a PCI interrupt,
  * so allow interrupt sharing.
  */
-static struct irqaction fpu_irq =3D { math_error_irq, 0, CPU_MASK_NONE, "f=
pu", NULL, NULL };
+static struct irqaction fpu_irq =3D {
+	.handler =3D	math_error_irq,
+	.name =3D		"fpu"
+};
+
+/*
+ * Most legacy systems want to cascade IRQ2 to slave PIC
+ */
+static struct irqaction cascade_action =3D {
+	.handler =3D 	no_action,
+	.name =3D		"cascade",
+};
 =

 void __init init_ISA_irqs (void)
 {
@@ -382,9 +393,6 @@ void __init native_init_IRQ(void)
 {
 	int i;
 =

-	/* all the set up before the call gates are initialised */
-	pre_intr_init_hook();
-
 	/*
 	 * Cover the whole vector space, no vector can escape
 	 * us. (some of these will be overridden and become
@@ -398,10 +406,16 @@ void __init native_init_IRQ(void)
 			set_intr_gate(vector, interrupt[i]);
 	}
 =

-	/* setup after call gates are initialised (usually add in
-	 * the architecture specific gates)
+	/*
+	 * setup after interrupt gates are initialised (usually add in
+	 * the architecture specific gates) and initialize controllers
 	 */
 	intr_init_hook();
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
+	if (!acpi_ioapic)
+		setup_irq(2, &cascade_action);
 =

 	/*
 	 * Set the clock to HZ Hz, we already have a valid
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mach-default/setup.c
+++ b/arch/i386/mach-default/setup.c
@@ -18,24 +18,6 @@
 =

 int no_broadcast=3DDEFAULT_SEND_IPI;
 =

-/**
- * pre_intr_init_hook - initialisation prior to setting up interrupt vecto=
rs
- *
- * Description:
- *	Perform any necessary interrupt initialisation prior to setting up
- *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
- *	interrupts should be initialised here if the machine emulates a PC
- *	in any way.
- **/
-void __init pre_intr_init_hook(void)
-{
-	init_ISA_irqs();
-}
-
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 =3D { no_action, 0, CPU_MASK_NONE, "cascade",=
 NULL, NULL};
 =

 /**
  * intr_init_hook - post gate setup interrupt initialisation
@@ -43,17 +25,13 @@ static struct irqaction irq2 =3D { no_acti
  * Description:
  *	Fill in any interrupts that may have been left out by the general
  *	init_IRQ() routine.  interrupts having to do with the machine rather
- *	than the devices on the I/O bus (like APIC interrupts in intel MP
- *	systems) are started here.
+ *	than the devices on the I/O bus are started here.  For legacy reasons,
+ *	the ISA interrupts should be initialised here if the machine emulates
+ *	a PC in any way.
  **/
 void __init intr_init_hook(void)
 {
-#ifdef CONFIG_X86_LOCAL_APIC
-	apic_intr_init();
-#endif
-
-	if (!acpi_ioapic)
-		setup_irq(2, &irq2);
+	init_ISA_irqs();
 }
 =

 /**
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mach-visws/setup.c
+++ b/arch/i386/mach-visws/setup.c
@@ -96,16 +96,9 @@ void __init visws_get_board_type_and_rev
 		"unknown")), visws_board_rev);
 }
 =

-void __init pre_intr_init_hook(void)
+void __init intr_init_hook(void)
 {
 	init_VISWS_APIC_irqs();
-}
-
-void __init intr_init_hook(void)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	apic_intr_init();
-#endif
 }
 =

 void __init pre_setup_arch_hook()
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mach-visws/visws_apic.c
+++ b/arch/i386/mach-visws/visws_apic.c
@@ -261,12 +261,6 @@ static struct irqaction master_action =3D =

 	.name =3D		"PIIX4-8259",
 };
 =

-static struct irqaction cascade_action =3D {
-	.handler =3D 	no_action,
-	.name =3D		"cascade",
-};
-
-
 void init_VISWS_APIC_irqs(void)
 {
 	int i;
@@ -297,5 +291,4 @@ void init_VISWS_APIC_irqs(void)
 	}
 =

 	setup_irq(CO_IRQ_8259, &master_action);
-	setup_irq(2, &cascade_action);
-}
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mach-voyager/setup.c
+++ b/arch/i386/mach-voyager/setup.c
@@ -10,23 +10,12 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 =

-void __init pre_intr_init_hook(void)
+void __init intr_init_hook(void)
 {
 	init_ISA_irqs();
-}
-
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 =3D { no_action, 0, CPU_MASK_NONE, "cascade",=
 NULL, NULL};
-
-void __init intr_init_hook(void)
-{
 #ifdef CONFIG_SMP
 	smp_intr_init();
 #endif
-
-	setup_irq(2, &irq2);
 }
 =

 void __init pre_setup_arch_hook(void)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/arch_hooks.h
+++ b/include/asm-i386/arch_hooks.h
@@ -18,7 +18,6 @@ extern irqreturn_t timer_interrupt(int i
 =

 /* these are the defined hooks */
 extern void intr_init_hook(void);
-extern void pre_intr_init_hook(void);
 extern void pre_setup_arch_hook(void);
 extern void trap_init_hook(void);
 extern void time_init_hook(void);
