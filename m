From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/8] lguest: the guest code
Date: Tue, 10 Apr 2007 21:05:30 +1000
Message-ID: <1176203130.26372.23.camel__14854.2947172702$1176214720$gmane$org@localhost.localdomain>
References: <1176203068.26372.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1176203068.26372.21.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is the code and headers required to make an i386 kernel an lguest gues=
t.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c     |  509 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/lguest/lguest_asm.S |   59 ++++
 drivers/lguest/lguest_bus.c |  148 ++++++++++++
 include/linux/lguest.h      |   85 +++++++
 include/linux/lguest_bus.h  |   33 ++
 5 files changed, 834 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/lguest/lguest.c
@@ -0,0 +1,509 @@
+/*
+ * Lguest specific paravirt-ops implementation
+ *
+ * Copyright (C) 2006, Rusty Russell <rusty@rustcorp.com.au> IBM Corporati=
on.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/kernel.h>
+#include <linux/start_kernel.h>
+#include <linux/string.h>
+#include <linux/console.h>
+#include <linux/screen_info.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/lguest.h>
+#include <linux/lguest_launcher.h>
+#include <asm/paravirt.h>
+#include <asm/param.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/desc.h>
+#include <asm/setup.h>
+#include <asm/e820.h>
+#include <asm/pda.h>
+#include <asm/mce.h>
+
+/* Declarations for definitions in lguest_guest.S */
+extern char lguest_noirq_start[], lguest_noirq_end[];
+extern const char lgstart_cli[], lgend_cli[];
+extern const char lgstart_sti[], lgend_sti[];
+extern const char lgstart_popf[], lgend_popf[];
+extern const char lgstart_pushf[], lgend_pushf[];
+extern const char lgstart_iret[], lgend_iret[];
+extern asmlinkage void lguest_maybe_init(void);
+extern void lguest_iret(void);
+
+struct lguest_data lguest_data =3D {
+	.hcall_status =3D { [0 ... LHCALL_RING_SIZE-1] =3D 0xFF },
+	.noirq_start =3D (u32)lguest_noirq_start,
+	.noirq_end =3D (u32)lguest_noirq_end,
+	.blocked_interrupts =3D { 1 }, /* Block timer interrupts */
+};
+struct lguest_device_desc *lguest_devices;
+static __initdata const struct lguest_boot_info *boot =3D __va(0);
+
+static enum paravirt_lazy_mode lazy_mode;
+static void lguest_lazy_mode(enum paravirt_lazy_mode mode)
+{
+	lazy_mode =3D mode;
+	if (mode =3D=3D PARAVIRT_LAZY_NONE)
+		hcall(LHCALL_FLUSH_ASYNC, 0, 0, 0);
+}
+
+static void lazy_hcall(unsigned long call,
+		       unsigned long arg1,
+		       unsigned long arg2,
+		       unsigned long arg3)
+{
+	if (lazy_mode =3D=3D PARAVIRT_LAZY_NONE)
+		hcall(call, arg1, arg2, arg3);
+	else
+		async_hcall(call, arg1, arg2, arg3);
+}
+
+void async_hcall(unsigned long call,
+		 unsigned long arg1, unsigned long arg2, unsigned long arg3)
+{
+	/* Note: This code assumes we're uniprocessor. */
+	static unsigned int next_call;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (lguest_data.hcall_status[next_call] !=3D 0xFF) {
+		/* Table full, so do normal hcall which will flush table. */
+		hcall(call, arg1, arg2, arg3);
+	} else {
+		lguest_data.hcalls[next_call].eax =3D call;
+		lguest_data.hcalls[next_call].edx =3D arg1;
+		lguest_data.hcalls[next_call].ebx =3D arg2;
+		lguest_data.hcalls[next_call].ecx =3D arg3;
+		/* Make sure host sees arguments before "valid" flag. */
+		wmb();
+		lguest_data.hcall_status[next_call] =3D 0;
+		if (++next_call =3D=3D LHCALL_RING_SIZE)
+			next_call =3D 0;
+	}
+	local_irq_restore(flags);
+}
+
+static unsigned long save_fl(void)
+{
+	return lguest_data.irq_enabled;
+}
+
+static void restore_fl(unsigned long flags)
+{
+	/* FIXME: Check if interrupt pending... */
+	lguest_data.irq_enabled =3D flags;
+}
+
+static void irq_disable(void)
+{
+	lguest_data.irq_enabled =3D 0;
+}
+
+static void irq_enable(void)
+{
+	/* FIXME: Check if interrupt pending... */
+	lguest_data.irq_enabled =3D X86_EFLAGS_IF;
+}
+
+static void lguest_write_idt_entry(struct desc_struct *dt,
+				   int entrynum, u32 low, u32 high)
+{
+	write_dt_entry(dt, entrynum, low, high);
+	hcall(LHCALL_LOAD_IDT_ENTRY, entrynum, low, high);
+}
+
+static void lguest_load_idt(const struct Xgt_desc_struct *desc)
+{
+	unsigned int i;
+	struct desc_struct *idt =3D (void *)desc->address;
+
+	for (i =3D 0; i < (desc->size+1)/8; i++)
+		hcall(LHCALL_LOAD_IDT_ENTRY, i, idt[i].a, idt[i].b);
+}
+
+static void lguest_load_gdt(const struct Xgt_desc_struct *desc)
+{
+	BUG_ON((desc->size+1)/8 !=3D GDT_ENTRIES);
+	hcall(LHCALL_LOAD_GDT, __pa(desc->address), GDT_ENTRIES, 0);
+}
+
+static void lguest_write_gdt_entry(struct desc_struct *dt,
+				   int entrynum, u32 low, u32 high)
+{
+	write_dt_entry(dt, entrynum, low, high);
+	hcall(LHCALL_LOAD_GDT, __pa(dt), GDT_ENTRIES, 0);
+}
+
+static void lguest_load_tls(struct thread_struct *t, unsigned int cpu)
+{
+	lazy_hcall(LHCALL_LOAD_TLS, __pa(&t->tls_array), cpu, 0);
+}
+
+static void lguest_set_ldt(const void *addr, unsigned entries)
+{
+}
+
+static void lguest_load_tr_desc(void)
+{
+}
+
+static void lguest_cpuid(unsigned int *eax, unsigned int *ebx,
+			 unsigned int *ecx, unsigned int *edx)
+{
+	int function =3D *eax;
+
+	native_cpuid(eax, ebx, ecx, edx);
+	switch (function) {
+	case 1:	/* Basic feature request. */
+		/* We only allow kernel to see SSE3, CMPXCHG16B and SSSE3 */
+		*ecx &=3D 0x00002201;
+		/* Similarly: SSE, SSE2, FXSR, MMX, CMOV, CMPXCHG8B, FPU. */
+		*edx &=3D 0x07808101;
+		/* Host wants to know when we flush kernel pages: set PGE. */
+		*edx |=3D 0x00002000;
+		break;
+	case 0x80000000:
+		/* Futureproof this a little: if they ask how much extended
+		 * processor information, limit it to known fields. */
+		if (*eax > 0x80000008)
+			*eax =3D 0x80000008;
+		break;
+	}
+}
+
+static unsigned long current_cr0, current_cr3;
+static void lguest_write_cr0(unsigned long val)
+{
+	hcall(LHCALL_TS, val & 8, 0, 0);
+	current_cr0 =3D val;
+}
+
+static unsigned long lguest_read_cr0(void)
+{
+	return current_cr0;
+}
+
+static void lguest_clts(void)
+{
+	lazy_hcall(LHCALL_TS, 0, 0, 0);
+	current_cr0 &=3D ~8U;
+}
+
+static unsigned long lguest_read_cr2(void)
+{
+	return lguest_data.cr2;
+}
+
+static void lguest_write_cr3(unsigned long cr3)
+{
+	hcall(LHCALL_NEW_PGTABLE, cr3, 0, 0);
+	current_cr3 =3D cr3;
+}
+
+static unsigned long lguest_read_cr3(void)
+{
+	return current_cr3;
+}
+
+/* Used to enable/disable PGE, but we don't care. */
+static unsigned long lguest_read_cr4(void)
+{
+	return 0;
+}
+
+static void lguest_write_cr4(unsigned long val)
+{
+}
+
+static void lguest_set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	*ptep =3D pteval;
+	lazy_hcall(LHCALL_SET_PTE, __pa(mm->pgd), addr, pteval.pte_low);
+}
+
+/* We only support two-level pagetables at the moment. */
+static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+	*pmdp =3D pmdval;
+	lazy_hcall(LHCALL_SET_PMD, __pa(pmdp)&PAGE_MASK,
+		   (__pa(pmdp)&(PAGE_SIZE-1))/4, 0);
+}
+
+/* FIXME: Eliminate all callers of this. */
+static void lguest_set_pte(pte_t *ptep, pte_t pteval)
+{
+	*ptep =3D pteval;
+	/* Don't bother with hypercall before initial setup. */
+	if (current_cr3)
+		hcall(LHCALL_FLUSH_TLB, 1, 0, 0);
+}
+
+static void lguest_flush_tlb_single(unsigned long addr)
+{
+	/* Simply set it to zero, and it will fault back in. */
+	lazy_hcall(LHCALL_SET_PTE, current_cr3, addr, 0);
+}
+
+static void lguest_flush_tlb_user(void)
+{
+	lazy_hcall(LHCALL_FLUSH_TLB, 0, 0, 0);
+}
+
+static void lguest_flush_tlb_kernel(void)
+{
+	lazy_hcall(LHCALL_FLUSH_TLB, 1, 0, 0);
+}
+
+static void disable_lguest_irq(unsigned int irq)
+{
+	set_bit(irq, lguest_data.blocked_interrupts);
+}
+
+static void enable_lguest_irq(unsigned int irq)
+{
+	clear_bit(irq, lguest_data.blocked_interrupts);
+	/* FIXME: If it's pending? */
+}
+
+static struct irq_chip lguest_irq_controller =3D {
+	.name		=3D "lguest",
+	.mask		=3D disable_lguest_irq,
+	.mask_ack	=3D disable_lguest_irq,
+	.unmask		=3D enable_lguest_irq,
+};
+
+static void __init lguest_init_IRQ(void)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < LGUEST_IRQS; i++) {
+		int vector =3D FIRST_EXTERNAL_VECTOR + i;
+		if (vector !=3D SYSCALL_VECTOR) {
+			set_intr_gate(vector, interrupt[i]);
+			set_irq_chip_and_handler(i, &lguest_irq_controller,
+						 handle_level_irq);
+		}
+	}
+	irq_ctx_init(smp_processor_id());
+}
+
+static unsigned long lguest_get_wallclock(void)
+{
+	return hcall(LHCALL_GET_WALLCLOCK, 0, 0, 0);
+}
+
+static void lguest_time_irq(unsigned int irq, struct irq_desc *desc)
+{
+	do_timer(hcall(LHCALL_TIMER_READ, 0, 0, 0));
+	update_process_times(user_mode_vm(get_irq_regs()));
+}
+
+static void lguest_time_init(void)
+{
+	set_irq_handler(0, lguest_time_irq);
+	hcall(LHCALL_TIMER_READ, 0, 0, 0);
+	enable_lguest_irq(0);
+}
+
+static void lguest_load_esp0(struct tss_struct *tss,
+				     struct thread_struct *thread)
+{
+	lazy_hcall(LHCALL_SET_STACK, __KERNEL_DS|0x1, thread->esp0,
+		   THREAD_SIZE/PAGE_SIZE);
+}
+
+static void lguest_set_debugreg(int regno, unsigned long value)
+{
+	/* FIXME: Implement */
+}
+
+static void lguest_wbinvd(void)
+{
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+static void lguest_apic_write(unsigned long reg, unsigned long v)
+{
+}
+
+static unsigned long lguest_apic_read(unsigned long reg)
+{
+	return 0;
+}
+#endif
+
+static void lguest_safe_halt(void)
+{
+	hcall(LHCALL_HALT, 0, 0, 0);
+}
+
+static void lguest_power_off(void)
+{
+	hcall(LHCALL_CRASH, __pa("Power down"), 0, 0);
+}
+
+static int lguest_panic(struct notifier_block *nb, unsigned long l, void *=
p)
+{
+	hcall(LHCALL_CRASH, __pa(p), 0, 0);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block paniced =3D {
+	.notifier_call =3D lguest_panic
+};
+
+static __init char *lguest_memory_setup(void)
+{
+	/* We do this here because lockcheck barfs if before start_kernel */
+	atomic_notifier_chain_register(&panic_notifier_list, &paniced);
+
+	e820.nr_map =3D 0;
+	add_memory_region(0, PFN_PHYS(boot->max_pfn), E820_RAM);
+	return "LGUEST";
+}
+
+static const struct lguest_insns
+{
+	const char *start, *end;
+} lguest_insns[] =3D {
+	[PARAVIRT_PATCH(irq_disable)] =3D { lgstart_cli, lgend_cli },
+	[PARAVIRT_PATCH(irq_enable)] =3D { lgstart_sti, lgend_sti },
+	[PARAVIRT_PATCH(restore_fl)] =3D { lgstart_popf, lgend_popf },
+	[PARAVIRT_PATCH(save_fl)] =3D { lgstart_pushf, lgend_pushf },
+	[PARAVIRT_PATCH(iret)] =3D { lgstart_iret, lgend_iret },
+};
+static unsigned lguest_patch(u8 type, u16 clobber, void *insns, unsigned l=
en)
+{
+	unsigned int insn_len;
+
+	/* Don't touch it if we don't have a replacement */
+	if (type >=3D ARRAY_SIZE(lguest_insns) || !lguest_insns[type].start)
+		return len;
+
+	insn_len =3D lguest_insns[type].end - lguest_insns[type].start;
+
+	/* Similarly if we can't fit replacement. */
+	if (len < insn_len)
+		return len;
+
+	memcpy(insns, lguest_insns[type].start, insn_len);
+	if (type =3D=3D PARAVIRT_PATCH(iret)) {
+		/* Jumps are relative. */
+		u32 off =3D (u32)lguest_iret - ((u32)insns + insn_len);
+		memcpy(insns+1, &off, sizeof(off));
+	}
+	return insn_len;
+}
+
+/* From head.S */
+extern void setup_pda(void);
+extern struct Xgt_desc_struct early_gdt_descr;
+
+__init void lguest_init(void)
+{
+	paravirt_ops.name =3D "lguest";
+	paravirt_ops.paravirt_enabled =3D 1;
+	paravirt_ops.kernel_rpl =3D 1;
+
+	paravirt_ops.save_fl =3D save_fl;
+	paravirt_ops.restore_fl =3D restore_fl;
+	paravirt_ops.irq_disable =3D irq_disable;
+	paravirt_ops.irq_enable =3D irq_enable;
+	paravirt_ops.load_gdt =3D lguest_load_gdt;
+	paravirt_ops.memory_setup =3D lguest_memory_setup;
+	paravirt_ops.cpuid =3D lguest_cpuid;
+	paravirt_ops.write_cr3 =3D lguest_write_cr3;
+	paravirt_ops.flush_tlb_user =3D lguest_flush_tlb_user;
+	paravirt_ops.flush_tlb_single =3D lguest_flush_tlb_single;
+	paravirt_ops.flush_tlb_kernel =3D lguest_flush_tlb_kernel;
+	paravirt_ops.set_pte =3D lguest_set_pte;
+	paravirt_ops.set_pte_at =3D lguest_set_pte_at;
+	paravirt_ops.set_pmd =3D lguest_set_pmd;
+#ifdef CONFIG_X86_LOCAL_APIC
+	paravirt_ops.apic_write =3D lguest_apic_write;
+	paravirt_ops.apic_write_atomic =3D lguest_apic_write;
+	paravirt_ops.apic_read =3D lguest_apic_read;
+#endif
+	paravirt_ops.load_idt =3D lguest_load_idt;
+	paravirt_ops.iret =3D lguest_iret;
+	paravirt_ops.load_esp0 =3D lguest_load_esp0;
+	paravirt_ops.load_tr_desc =3D lguest_load_tr_desc;
+	paravirt_ops.set_ldt =3D lguest_set_ldt;
+	paravirt_ops.load_tls =3D lguest_load_tls;
+	paravirt_ops.set_debugreg =3D lguest_set_debugreg;
+	paravirt_ops.clts =3D lguest_clts;
+	paravirt_ops.read_cr0 =3D lguest_read_cr0;
+	paravirt_ops.write_cr0 =3D lguest_write_cr0;
+	paravirt_ops.init_IRQ =3D lguest_init_IRQ;
+	paravirt_ops.read_cr2 =3D lguest_read_cr2;
+	paravirt_ops.read_cr3 =3D lguest_read_cr3;
+	paravirt_ops.read_cr4 =3D lguest_read_cr4;
+	paravirt_ops.write_cr4 =3D lguest_write_cr4;
+	paravirt_ops.write_gdt_entry =3D lguest_write_gdt_entry;
+	paravirt_ops.write_idt_entry =3D lguest_write_idt_entry;
+	paravirt_ops.patch =3D lguest_patch;
+	paravirt_ops.safe_halt =3D lguest_safe_halt;
+	paravirt_ops.get_wallclock =3D lguest_get_wallclock;
+	paravirt_ops.time_init =3D lguest_time_init;
+	paravirt_ops.set_lazy_mode =3D lguest_lazy_mode;
+	paravirt_ops.wbinvd =3D lguest_wbinvd;
+
+	hcall(LHCALL_LGUEST_INIT, __pa(&lguest_data), 0, 0);
+	strncpy(boot_command_line, boot->cmdline, COMMAND_LINE_SIZE);
+
+	/* We use top of mem for initial pagetables. */
+	init_pg_tables_end =3D __pa(pg0);
+
+	/* set up PDA descriptor */
+	setup_pda();
+	load_gdt(&early_gdt_descr);
+	asm volatile ("mov %0, %%fs" : : "r" (__KERNEL_PDA) : "memory");
+
+	reserve_top_address(lguest_data.reserve_mem);
+
+	cpu_detect(&new_cpu_data);
+	/* Need this before paging_init. */
+	set_bit(X86_FEATURE_PGE, new_cpu_data.x86_capability);
+	/* Math is always hard! */
+	new_cpu_data.hard_math =3D 1;
+
+#ifdef CONFIG_X86_MCE
+	mce_disabled =3D 1;
+#endif
+
+#ifdef CONFIG_ACPI
+	acpi_disabled =3D 1;
+	acpi_ht =3D 0;
+#endif
+
+	add_preferred_console("hvc", 0, NULL);
+
+	if (boot->initrd_size) {
+		/* We stash this at top of memory. */
+		INITRD_START =3D boot->max_pfn*PAGE_SIZE - boot->initrd_size;
+		INITRD_SIZE =3D boot->initrd_size;
+		LOADER_TYPE =3D 0xFF;
+	}
+
+	pm_power_off =3D lguest_power_off;
+	start_kernel();
+}
+paravirt_probe(lguest_maybe_init);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/lguest/lguest_asm.S
@@ -0,0 +1,59 @@
+#include <linux/linkage.h>
+#include <linux/lguest.h>
+#include <asm/asm-offsets.h>
+
+/* FIXME: Once asm/processor-flags.h goes in, include that */
+#define X86_EFLAGS_IF 0x00000200
+
+/*
+ * This is where we begin: head.S notes that paging is already enabled (wh=
ich
+ * doesn't happen in native boot) and calls the registered paravirt_probe
+ * functions one at a time.  Ours is a simple assembler test for magic
+ * registers.  If they're correct we jump to lguest_init.
+ *
+ * We put it in .init.text will be discarded after boot.
+ */
+.section .init.text, "ax", @progbits
+ENTRY(lguest_maybe_init)
+	cmpl $LGUEST_MAGIC_EBP, %ebp
+	jne out
+	cmpl $LGUEST_MAGIC_EDI, %edi
+	jne out
+	cmpl $LGUEST_MAGIC_ESI, %esi
+	jne out
+	je lguest_init
+out:
+	ret
+
+/* The templates for inline patching. */
+#define LGUEST_PATCH(name, insns...)			\
+	lgstart_##name:	insns; lgend_##name:;		\
+	.globl lgstart_##name; .globl lgend_##name
+
+LGUEST_PATCH(cli, movl $0, lguest_data+LGUEST_DATA_irq_enabled)
+LGUEST_PATCH(sti, movl $X86_EFLAGS_IF, lguest_data+LGUEST_DATA_irq_enabled)
+LGUEST_PATCH(popf, movl %eax, lguest_data+LGUEST_DATA_irq_enabled)
+LGUEST_PATCH(pushf, movl lguest_data+LGUEST_DATA_irq_enabled, %eax)
+LGUEST_PATCH(iret, .byte 0xE9,0,0,0,0) /* jmp <to-be-patched> */
+
+.text
+/* These demark the EIP range where host should never deliver interrupts. =
*/
+.global lguest_noirq_start
+.global lguest_noirq_end
+
+/*
+ * We move eflags word to lguest_data.irq_enabled to restore interrupt sta=
te.
+ * For page faults, gpfs and virtual interrupts, the hypervisor has saved
+ * eflags manually, otherwise it was delivered directly and so eflags refl=
ects
+ * the real machine IF state, ie. interrupts on.  Since the kernel always =
dies
+ * if it takes such a trap with interrupts disabled anyway, turning interr=
upts
+ * back on unconditionally here is OK.
+ */
+ENTRY(lguest_iret)
+	pushl	%eax
+	movl	12(%esp), %eax
+lguest_noirq_start:
+	movl	%eax,%ss:lguest_data+LGUEST_DATA_irq_enabled
+	popl	%eax
+	iret
+lguest_noirq_end:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/lguest/lguest_bus.c
@@ -0,0 +1,148 @@
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/lguest_bus.h>
+#include <asm/io.h>
+
+static ssize_t type_show(struct device *_dev,
+                         struct device_attribute *attr, char *buf)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	return sprintf(buf, "%hu", lguest_devices[dev->index].type);
+}
+static ssize_t features_show(struct device *_dev,
+                             struct device_attribute *attr, char *buf)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	return sprintf(buf, "%hx", lguest_devices[dev->index].features);
+}
+static ssize_t pfn_show(struct device *_dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	return sprintf(buf, "%u", lguest_devices[dev->index].pfn);
+}
+static ssize_t status_show(struct device *_dev,
+                           struct device_attribute *attr, char *buf)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	return sprintf(buf, "%hx", lguest_devices[dev->index].status);
+}
+static ssize_t status_store(struct device *_dev, struct device_attribute *=
attr,
+                            const char *buf, size_t count)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	if (sscanf(buf, "%hi", &lguest_devices[dev->index].status) !=3D 1)
+		return -EINVAL;
+	return count;
+}
+static struct device_attribute lguest_dev_attrs[] =3D {
+	__ATTR_RO(type),
+	__ATTR_RO(features),
+	__ATTR_RO(pfn),
+	__ATTR(status, 0644, status_show, status_store),
+	__ATTR_NULL
+};
+
+static int lguest_dev_match(struct device *_dev, struct device_driver *_dr=
v)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	struct lguest_driver *drv =3D container_of(_drv,struct lguest_driver,drv);
+
+	return (drv->device_type =3D=3D lguest_devices[dev->index].type);
+}
+
+struct lguest_bus {
+	struct bus_type bus;
+	struct device dev;
+};
+
+static struct lguest_bus lguest_bus =3D {
+	.bus =3D {
+		.name  =3D "lguest",
+		.match =3D lguest_dev_match,
+		.dev_attrs =3D lguest_dev_attrs,
+	},
+	.dev =3D {
+		.parent =3D NULL,
+		.bus_id =3D "lguest",
+	}
+};
+
+static int lguest_dev_probe(struct device *_dev)
+{
+	int ret;
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	struct lguest_driver *drv =3D container_of(dev->dev.driver,
+						struct lguest_driver, drv);
+
+	lguest_devices[dev->index].status |=3D LGUEST_DEVICE_S_DRIVER;
+	ret =3D drv->probe(dev);
+	if (ret =3D=3D 0)
+		lguest_devices[dev->index].status |=3D LGUEST_DEVICE_S_DRIVER_OK;
+	return ret;
+}
+
+int register_lguest_driver(struct lguest_driver *drv)
+{
+	if (!lguest_devices)
+		return 0;
+
+	drv->drv.bus =3D &lguest_bus.bus;
+	drv->drv.name =3D drv->name;
+	drv->drv.owner =3D drv->owner;
+	drv->drv.probe =3D lguest_dev_probe;
+
+	return driver_register(&drv->drv);
+}
+EXPORT_SYMBOL_GPL(register_lguest_driver);
+
+static void add_lguest_device(unsigned int index)
+{
+	struct lguest_device *new;
+
+	lguest_devices[index].status |=3D LGUEST_DEVICE_S_ACKNOWLEDGE;
+	new =3D kmalloc(sizeof(struct lguest_device), GFP_KERNEL);
+	if (!new) {
+		printk(KERN_EMERG "Cannot allocate lguest device %u\n", index);
+		lguest_devices[index].status |=3D LGUEST_DEVICE_S_FAILED;
+		return;
+	}
+
+	new->index =3D index;
+	new->private =3D NULL;
+	memset(&new->dev, 0, sizeof(new->dev));
+	new->dev.parent =3D &lguest_bus.dev;
+	new->dev.bus =3D &lguest_bus.bus;
+	sprintf(new->dev.bus_id, "%u", index);
+	if (device_register(&new->dev) !=3D 0) {
+		printk(KERN_EMERG "Cannot register lguest device %u\n", index);
+		lguest_devices[index].status |=3D LGUEST_DEVICE_S_FAILED;
+		kfree(new);
+	}
+}
+
+static void scan_devices(void)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < LGUEST_MAX_DEVICES; i++)
+		if (lguest_devices[i].type)
+			add_lguest_device(i);
+}
+
+static int __init lguest_bus_init(void)
+{
+	if (strcmp(paravirt_ops.name, "lguest") !=3D 0)
+		return 0;
+
+	/* Devices are in page above top of "normal" mem. */
+	lguest_devices =3D ioremap(max_pfn << PAGE_SHIFT, PAGE_SIZE);
+
+	if (bus_register(&lguest_bus.bus) !=3D 0
+	    || device_register(&lguest_bus.dev) !=3D 0)
+		panic("lguest bus registration failed");
+
+	scan_devices();
+	return 0;
+}
+postcore_initcall(lguest_bus_init);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/include/linux/lguest.h
@@ -0,0 +1,85 @@
+/* Things the lguest guest needs to know.  Note: like all lguest interface=
s,
+ * this is subject to wild and random change between versions. */
+#ifndef _ASM_LGUEST_H
+#define _ASM_LGUEST_H
+
+/* These are randomly chosen numbers which indicate we're an lguest at boo=
t */
+#define LGUEST_MAGIC_EBP 0x4C687970
+#define LGUEST_MAGIC_EDI 0x652D4D65
+#define LGUEST_MAGIC_ESI 0xFFFFFFFF
+
+#ifndef __ASSEMBLY__
+#include <asm/irq.h>
+
+#define LHCALL_FLUSH_ASYNC	0
+#define LHCALL_LGUEST_INIT	1
+#define LHCALL_CRASH		2
+#define LHCALL_LOAD_GDT		3
+#define LHCALL_NEW_PGTABLE	4
+#define LHCALL_FLUSH_TLB	5
+#define LHCALL_LOAD_IDT_ENTRY	6
+#define LHCALL_SET_STACK	7
+#define LHCALL_TS		8
+#define LHCALL_TIMER_READ	9
+#define LHCALL_HALT		10
+#define LHCALL_GET_WALLCLOCK	11
+#define LHCALL_BIND_DMA		12
+#define LHCALL_SEND_DMA		13
+#define LHCALL_SET_PTE		14
+#define LHCALL_SET_PMD		15
+#define LHCALL_LOAD_TLS		16
+
+#define LGUEST_TRAP_ENTRY 0x1F
+
+static inline unsigned long
+hcall(unsigned long call,
+      unsigned long arg1, unsigned long arg2, unsigned long arg3)
+{
+	asm volatile("int $" __stringify(LGUEST_TRAP_ENTRY)
+		     : "=3Da"(call)
+		     : "a"(call), "d"(arg1), "b"(arg2), "c"(arg3)
+		     : "memory");
+	return call;
+}
+
+void async_hcall(unsigned long call,
+		 unsigned long arg1, unsigned long arg2, unsigned long arg3);
+
+/* Can't use our min() macro here: needs to be a constant */
+#define LGUEST_IRQS (NR_IRQS < 32 ? NR_IRQS: 32)
+
+#define LHCALL_RING_SIZE 64
+struct hcall_ring
+{
+	u32 eax, edx, ebx, ecx;
+};
+
+/* All the good stuff happens here: guest registers it with LGUEST_INIT */
+struct lguest_data
+{
+/* Fields which change during running: */
+	/* 512 =3D=3D enabled (same as eflags) */
+	unsigned int irq_enabled;
+	/* Interrupts blocked by guest. */
+	DECLARE_BITMAP(blocked_interrupts, LGUEST_IRQS);
+
+	/* Virtual address of page fault. */
+	unsigned long cr2;
+
+	/* Async hypercall ring.  0xFF =3D=3D done, 0 =3D=3D pending. */
+	u8 hcall_status[LHCALL_RING_SIZE];
+	struct hcall_ring hcalls[LHCALL_RING_SIZE];
+
+/* Fields initialized by the hypervisor at boot: */
+	/* Memory not to try to access */
+	unsigned long reserve_mem;
+	/* ID of this guest (used by network driver to set ethernet address) */
+	u16 guestid;
+
+/* Fields initialized by the guest at boot: */
+	/* Instruction range to suppress interrupts even if enabled */
+	unsigned long noirq_start, noirq_end;
+};
+extern struct lguest_data lguest_data;
+#endif /* __ASSEMBLY__ */
+#endif	/* _ASM_LGUEST_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/include/linux/lguest_bus.h
@@ -0,0 +1,33 @@
+#ifndef _ASM_LGUEST_DEVICE_H
+#define _ASM_LGUEST_DEVICE_H
+/* Everything you need to know about lguest devices. */
+#include <linux/device.h>
+#include <linux/lguest.h>
+#include <linux/lguest_launcher.h>
+
+struct lguest_device {
+	/* Unique busid, and index into lguest_page->devices[] */
+	/* By convention, each device can use irq index+1 if it wants to. */
+	unsigned int index;
+
+	struct device dev;
+
+	/* Driver can hang data off here. */
+	void *private;
+};
+
+struct lguest_driver {
+	const char *name;
+	struct module *owner;
+	u16 device_type;
+	int (*probe)(struct lguest_device *dev);
+	void (*remove)(struct lguest_device *dev);
+
+	struct device_driver drv;
+};
+
+extern int register_lguest_driver(struct lguest_driver *drv);
+extern void unregister_lguest_driver(struct lguest_driver *drv);
+
+extern struct lguest_device_desc *lguest_devices; /* Just past max_pfn */
+#endif /* _ASM_LGUEST_DEVICE_H */
