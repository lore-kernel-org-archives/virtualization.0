From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 01/17] paravirt_ops - core changes
Date: Thu, 08 Mar 2007 01:01:52 -0500
Message-ID: <1173333712.25848.2.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
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
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-core.patch)
Paravirt Ops core files.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>



Index: clean-start/arch/x86_64/kernel/paravirt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ clean-start/arch/x86_64/kernel/paravirt.c
@@ -0,0 +1,504 @@
+/*  Paravirtualization interfaces
+    Copyright (C) 2007 Glauber de Oliveira Costa, Red Hat Inc.
+    Based on i386 work by Rusty Russell.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+*/
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/efi.h>
+#include <linux/bcd.h>
+#include <linux/start_kernel.h>
+
+#include <asm/bug.h>
+#include <asm/paravirt.h>
+#include <asm/desc.h>
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/delay.h>
+#include <asm/fixmap.h>
+#include <asm/apic.h>
+#include <asm/tlbflush.h>
+#include <asm/msr.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/proto.h>
+#include <asm/time.h>
+#include <asm/e820.h>
+
+/* nop stub */
+void native_nop(void)
+{
+}
+
+static void __init default_banner(void)
+{
+	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
+	       paravirt_ops.name);
+}
+
+void memory_setup(void)
+{
+	paravirt_ops.memory_setup();
+}
+
+void syscall_init(void)
+{
+	paravirt_ops.syscall_init();
+}
+
+/* Simple instruction patching code. */
+#define DEF_NATIVE(name, code)					\
+	extern const char start_##name[], end_##name[];		\
+	asm("start_" #name ": " code "; end_" #name ":")
+DEF_NATIVE(cli, "cli");
+DEF_NATIVE(sti, "sti");
+/* We push rdi , and pop in rda. This is due to x86_64 calling conventions
+ * Recall that we are patching a function call */
+DEF_NATIVE(popfq, "pushq %rdi; popfq");
+DEF_NATIVE(pushfq, "pushfq; popq %rax");
+DEF_NATIVE(pushfq_cli, "pushfq; popq %rax; cli");
+DEF_NATIVE(iret, "iretq");
+DEF_NATIVE(sysretq, "sysretq");
+DEF_NATIVE(swapgs, "swapgs");
+
+static const struct native_insns
+{
+	const char *start, *end;
+} native_insns[] =3D {
+	[PARAVIRT_IRQ_DISABLE] =3D { start_cli, end_cli },
+	[PARAVIRT_IRQ_ENABLE] =3D { start_sti, end_sti },
+	[PARAVIRT_RESTORE_FLAGS] =3D { start_popfq, end_popfq },
+	[PARAVIRT_SAVE_FLAGS] =3D { start_pushfq, end_pushfq },
+	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] =3D { start_pushfq_cli, end_pushfq_cli =
},
+	[PARAVIRT_INTERRUPT_RETURN] =3D { start_iret, end_iret },
+	[PARAVIRT_SYSRETQ] =3D { start_sysretq, end_sysretq },
+	[PARAVIRT_SWAPGS] =3D { start_swapgs, end_swapgs },
+};
+
+static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned =
len)
+{
+	unsigned int insn_len;
+
+	/* Don't touch it if we don't have a replacement */
+	if (type >=3D ARRAY_SIZE(native_insns) || !native_insns[type].start)
+		return len;
+
+	insn_len =3D native_insns[type].end - native_insns[type].start;
+
+	/* Similarly if we can't fit replacement. */
+	if (len < insn_len)
+		return len;
+
+	memcpy(insns, native_insns[type].start, insn_len);
+	return insn_len;
+}
+
+static unsigned long native_get_debugreg(int regno)
+{
+	unsigned long val =3D 0; 	/* Damn you, gcc! */
+
+	switch (regno) {
+	case 0:
+		asm("movq %%db0, %0" :"=3Dr" (val)); break;
+	case 1:
+		asm("movq %%db1, %0" :"=3Dr" (val)); break;
+	case 2:
+		asm("movq %%db2, %0" :"=3Dr" (val)); break;
+	case 3:
+		asm("movq %%db3, %0" :"=3Dr" (val)); break;
+	case 6:
+		asm("movq %%db6, %0" :"=3Dr" (val)); break;
+	case 7:
+		asm("movq %%db7, %0" :"=3Dr" (val)); break;
+	default:
+		BUG();
+	}
+	return val;
+}
+
+static void native_set_debugreg(int regno, unsigned long value)
+{
+	switch (regno) {
+	case 0:
+		asm("movq %0,%%db0"	: /* no output */ :"r" (value));
+		break;
+	case 1:
+		asm("movq %0,%%db1"	: /* no output */ :"r" (value));
+		break;
+	case 2:
+		asm("movq %0,%%db2"	: /* no output */ :"r" (value));
+		break;
+	case 3:
+		asm("movq %0,%%db3"	: /* no output */ :"r" (value));
+		break;
+	case 6:
+		asm("movq %0,%%db6"	: /* no output */ :"r" (value));
+		break;
+	case 7:
+		asm("movq %0,%%db7"	: /* no output */ :"r" (value));
+		break;
+	default:
+		BUG();
+	}
+}
+
+void init_IRQ(void)
+{
+	paravirt_ops.init_IRQ();
+}
+
+static unsigned long native_save_fl(void)
+{
+	unsigned long f;
+	asm volatile("pushfq ; popq %0":"=3Dg" (f): /* no input */);
+	return f;
+}
+
+static void native_restore_fl(unsigned long f)
+{
+	asm volatile("pushq %0 ; popfq": /* no output */
+			     :"g" (f)
+			     :"memory", "cc");
+}
+
+static void native_irq_disable(void)
+{
+	asm volatile("cli": : :"memory");
+}
+
+static void native_irq_enable(void)
+{
+	asm volatile("sti": : :"memory");
+}
+
+static void native_safe_halt(void)
+{
+	asm volatile("sti; hlt": : :"memory");
+}
+
+static void native_halt(void)
+{
+	asm volatile("hlt": : :"memory");
+}
+
+static u64 native_read_tsc(void)
+{
+	unsigned long a, b;
+	asm volatile("rdtsc" : "=3Da" (a), "=3Dd" (b));
+	return a | (b << 32);
+}
+
+static u64 native_read_tscp(int *aux)
+{
+	u64 a, b;
+	asm volatile ("rdtscp" : "=3Da" (a), "=3Db" (b), "=3Dc" (aux));
+	return a | (b << 32);
+}
+
+static u64 native_read_pmc(void)
+{
+	unsigned long a, b;
+	asm volatile("rdpmc" : "=3Da" (a), "=3Db" (b));
+	return a | (b << 32);
+}
+
+static void native_store_gdt(struct desc_ptr *dtr)
+{
+	asm ("sgdt %w0":"=3Dm" (*dtr));
+}
+
+static void native_store_idt(struct desc_ptr *dtr)
+{
+	asm ("sidt %w0":"=3Dm" (*dtr));
+}
+
+static unsigned long native_store_tr(void)
+{
+	unsigned long tr;
+	asm ("str %w0":"=3Dr" (tr));
+	return tr;
+}
+
+static void native_load_tls(struct thread_struct *t, unsigned int cpu)
+{
+	u64 *gdt =3D (u64 *)(cpu_gdt(cpu) + GDT_ENTRY_TLS_MIN);
+	gdt[0] =3D t->tls_array[0];
+	gdt[1] =3D t->tls_array[1];
+	gdt[2] =3D t->tls_array[2];
+}
+
+static inline void native_write_dt_entry(void *dt, int entry, u32 entry_lo=
w, u32 entry_high)
+{
+	u32 *lp =3D (u32 *)((char *)dt + entry*8);
+	lp[0] =3D entry_low;
+	lp[1] =3D entry_high;
+}
+
+static void native_write_ldt_entry(void *dt, int entrynum, u32 low, u32 hi=
gh)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static void native_write_gdt_entry(void *dt, int entrynum, u32 low, u32 hi=
gh)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static void native_write_idt_entry(void *dt, int entrynum, u32 low, u32 hi=
gh)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static void native_load_rsp0(struct tss_struct *tss,
+				      struct thread_struct *thread)
+{
+	tss->rsp0 =3D thread->rsp0;
+}
+
+static void native_io_delay(void)
+{
+	asm volatile("outb %al,$0x80");
+}
+
+void native_pagetable_setup_start(pgd_t *base)
+{
+	int i;
+
+	/*
+	 * Init entries of the first-level page table to the
+	 * zero page, if they haven't already been set up.
+	 *
+	 * In a normal native boot, we'll be running on a
+	 * pagetable rooted in swapper_pg_dir, but not in PAE
+	 * mode, so this will end up clobbering the mappings
+	 * for the lower 24Mbytes of the address space,
+	 * without affecting the kernel address space.
+	 */
+	for (i =3D 0; i < USER_PTRS_PER_PGD; i++)
+		set_pgd(&base[i],
+			__pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
+	memset(&base[USER_PTRS_PER_PGD], 0, sizeof(pgd_t));
+}
+
+void native_pagetable_setup_done(pgd_t *base)
+{
+	/*
+	 * Add low memory identity-mappings - SMP needs it when
+	 * starting up on an AP from real-mode. In the non-PAE
+	 * case we already have these mappings through head.S.
+	 * All user-space mappings are explicitly cleared after
+	 * SMP startup.
+	 */
+	set_pgd(&base[0], base[USER_PTRS_PER_PGD]);
+}
+
+
+static void native_flush_tlb(void)
+{
+	__native_flush_tlb();
+}
+
+/*
+ * Global pages have to be flushed a bit differently. Not a real
+ * performance problem because this does not happen often.
+ */
+static void native_flush_tlb_all(void)
+{
+	__native_flush_tlb_all();
+}
+
+static void native_flush_tlb_one(u64 addr)
+{
+	__native_flush_tlb_one(addr);
+}
+
+pte_t native_make_pte(unsigned long pte)
+{
+	return (pte_t){ pte };
+}
+
+pud_t native_make_pud(unsigned long pud)
+{
+	return (pud_t){ pud };
+}
+
+pmd_t native_make_pmd(unsigned long pmd)
+{
+	return (pmd_t){ pmd };
+}
+
+pgd_t native_make_pgd(unsigned long pgd)
+{
+	return (pgd_t){ pgd };
+}
+
+pte_t native_ptep_get_and_clear(struct mm_struct *mm, u64 addr,
+					 pte_t *ptep)
+{
+	return __pte(xchg(&(ptep)->pte, 0));
+}
+
+void native_set_pte_at(struct mm_struct *mm, u64 addr, pte_t *ptep,
+				pte_t pteval)
+{
+	native_set_pte(ptep,pteval);
+}
+
+void native_pte_clear(struct mm_struct *mm, u64 addr, pte_t *ptep)
+{
+	native_set_pte_at(mm,addr,ptep,__pte(0));
+}
+
+void native_pmd_clear(pmd_t *pmd)
+{
+	native_set_pmd(pmd,__pmd(0));
+}
+
+void native_swapgs(unsigned long rip)
+{
+	asm volatile ("swapgs" :: :"memory" );
+}
+
+/* These are in entry.S */
+extern void native_iret(void);
+extern void native_sysret(void);
+
+static int __init print_banner(void)
+{
+	paravirt_ops.banner();
+	return 0;
+}
+core_initcall(print_banner);
+
+/* We simply declare start_kernel to be the paravirt probe of last resort.=
 */
+paravirt_probe_failsafe(start_kernel);
+
+extern unsigned long __vsyscall_0;
+struct paravirt_ops paravirt_ops =3D {
+	.name =3D "bare hardware",
+	.mem_type =3D "BIOS-e820",
+	.paravirt_enabled =3D 0,
+	.pgd_alignment =3D sizeof(pgd_t) * PTRS_PER_PGD,
+
+	.vsyscall_page =3D &__vsyscall_0,
+ 	.patch =3D native_patch,
+	.banner =3D default_banner,
+	.arch_setup =3D native_nop,
+	.memory_setup =3D setup_memory_region,
+	.syscall_init =3D x86_64_syscall_init,
+	.get_wallclock =3D do_get_cmos_time,
+	.set_wallclock =3D do_set_rtc_mmss,
+	.time_init =3D time_init_hook,
+	.init_IRQ =3D native_init_IRQ,
+
+	.cpuid =3D native_cpuid,
+	.get_debugreg =3D native_get_debugreg,
+	.set_debugreg =3D native_set_debugreg,
+	.clts =3D native_clts,
+	.read_cr0 =3D native_read_cr0,
+	.write_cr0 =3D native_write_cr0,
+	.read_cr2 =3D native_read_cr2,
+	.write_cr2 =3D native_write_cr2,
+	.read_cr3 =3D native_read_cr3,
+	.write_cr3 =3D native_write_cr3,
+	.read_cr4 =3D native_read_cr4,
+	.write_cr4 =3D native_write_cr4,
+	.save_fl =3D native_save_fl,
+	.restore_fl =3D native_restore_fl,
+	.irq_disable =3D native_irq_disable,
+	.irq_enable =3D native_irq_enable,
+	.safe_halt =3D native_safe_halt,
+	.halt =3D native_halt,
+	.wbinvd =3D native_wbinvd,
+	.read_msr =3D native_read_msr_safe,
+	.write_msr =3D native_write_msr_safe,
+	.read_tsc =3D native_read_tsc,
+	.read_tscp =3D native_read_tscp,
+	.read_pmc =3D native_read_pmc,
+	.load_tr_desc =3D native_load_tr_desc,
+	.set_ldt =3D native_set_ldt,
+	.load_gdt =3D native_load_gdt,
+	.load_idt =3D native_load_idt,
+	.store_gdt =3D native_store_gdt,
+	.store_idt =3D native_store_idt,
+	.store_tr =3D native_store_tr,
+	.load_tls =3D native_load_tls,
+	.write_ldt_entry =3D native_write_ldt_entry,
+	.write_gdt_entry =3D native_write_gdt_entry,
+	.write_idt_entry =3D native_write_idt_entry,
+	.load_rsp0 =3D native_load_rsp0,
+
+	.io_delay =3D native_io_delay,
+	.const_udelay =3D __const_udelay,
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	.apic_write =3D native_apic_write,
+	.apic_read =3D native_apic_read,
+#endif
+	.set_lazy_mode =3D (void *)native_nop,
+	.ebda_info =3D native_ebda_info,
+
+	.pagetable_setup_start =3D native_pagetable_setup_start,
+	.pagetable_setup_done =3D native_pagetable_setup_done,
+
+	.flush_tlb_user =3D native_flush_tlb,
+	.flush_tlb_kernel =3D native_flush_tlb_all,
+	.flush_tlb_single =3D native_flush_tlb_one,
+
+	.alloc_pt =3D (void *)native_nop,
+	.alloc_pd =3D (void *)native_nop,
+	.alloc_pd_clone =3D (void *)native_nop,
+	.release_pt =3D (void *)native_nop,
+	.release_pd =3D (void *)native_nop,
+
+	.set_pte =3D native_set_pte,
+	.set_pte_at =3D native_set_pte_at,
+	.set_pmd =3D native_set_pmd,
+	.set_pud =3D native_set_pud,
+	.set_pgd =3D native_set_pgd,
+
+	.pte_update =3D (void *)native_nop,
+	.pte_update_defer =3D (void *)native_nop,
+
+	.ptep_get_and_clear =3D native_ptep_get_and_clear,
+
+	.pte_clear =3D native_pte_clear,
+	.pmd_clear =3D native_pmd_clear,
+	.pud_clear =3D native_pud_clear,
+	.pgd_clear =3D native_pgd_clear,
+
+	.pte_val =3D native_pte_val,
+	.pud_val =3D native_pud_val,
+	.pmd_val =3D native_pmd_val,
+	.pgd_val =3D native_pgd_val,
+
+	.make_pte =3D native_make_pte,
+	.make_pmd =3D native_make_pmd,
+	.make_pud =3D native_make_pud,
+	.make_pgd =3D native_make_pgd,
+
+	.swapgs =3D native_swapgs,
+	.sysret =3D native_sysret,
+	.iret =3D native_iret,
+
+	.dup_mmap =3D (void *)native_nop,
+	.exit_mmap =3D (void *)native_nop,
+	.activate_mm =3D (void *)native_nop,
+
+	.startup_ipi_hook =3D (void *)native_nop,
+};
+
+EXPORT_SYMBOL(paravirt_ops);
Index: clean-start/include/asm-x86_64/paravirt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ clean-start/include/asm-x86_64/paravirt.h
@@ -0,0 +1,678 @@
+#ifndef __ASM_PARAVIRT_H
+#define __ASM_PARAVIRT_H
+/* Various instructions on x86 need to be replaced for
+ * para-virtualization: those hooks are defined here. */
+#include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/page.h>
+#include <asm/types.h>
+#include <asm/pda.h>
+
+#ifdef CONFIG_PARAVIRT
+/* These are the most performance critical ops, so we want to be able to p=
atch
+ * callers */
+#define PARAVIRT_IRQ_DISABLE 0
+#define PARAVIRT_IRQ_ENABLE 1
+#define PARAVIRT_RESTORE_FLAGS 2
+#define PARAVIRT_SAVE_FLAGS 3
+#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE 4
+#define PARAVIRT_INTERRUPT_RETURN 5
+#define PARAVIRT_SYSRETQ 6
+#define PARAVIRT_SWAPGS	7
+
+/* Bitmask of what can be clobbered: usually at least rax. */
+#define CLBR_NONE 0x0
+#define CLBR_RAX 0x1
+#define CLBR_RCX 0x2
+#define CLBR_RDX 0x4
+#define CLBR_ANY 0xf
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct thread_struct;
+struct desc_struct;
+struct desc_ptr;
+struct tss_struct;
+struct mm_struct;
+
+struct paravirt_ops
+{
+	int paravirt_enabled;
+
+	int pgd_alignment;
+
+	const char *name;
+	char *mem_type;
+
+	unsigned long *vsyscall_page;
+
+	/*
+	 * Patch may replace one of the defined code sequences with arbitrary
+	 * code, subject to the same register constraints.  This generally
+	 * means the code is not free to clobber any registers other than RAX.
+	 * The patch function should return the number of bytes of code
+	 * generated, as we nop pad the rest in generic code.
+	 */
+	unsigned (*patch)(u8 type, u16 clobber, void *firstinsn, unsigned len);
+
+	void (*arch_setup)(void);
+	void (*memory_setup)(void);
+	void (*init_IRQ)(void);
+	/* entry point for our hypervisor syscall handler */
+	void (*syscall_init)(void);
+
+	void (*pagetable_setup_start)(pgd_t *pgd_base);
+	void (*pagetable_setup_done)(pgd_t *pgd_base);
+
+	void (*banner)(void);
+
+	unsigned long (*get_wallclock)(void);
+	void (*set_wallclock)(unsigned long);
+	void (*time_init)(void);
+
+	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
+		      unsigned int *ecx, unsigned int *edx);
+
+	unsigned long (*get_debugreg)(int regno);
+	void (*set_debugreg)(int regno, unsigned long value);
+
+	void (*clts)(void);
+
+	unsigned long (*read_cr0)(void);
+	void (*write_cr0)(unsigned long);
+
+	unsigned long (*read_cr2)(void);
+	void (*write_cr2)(unsigned long);
+
+	unsigned long (*read_cr3)(void);
+	void (*write_cr3)(unsigned long);
+
+	unsigned long (*read_cr4)(void);
+	void (*write_cr4)(unsigned long);
+
+	unsigned long (*save_fl)(void);
+	void (*restore_fl)(unsigned long);
+	void (*irq_disable)(void);
+	void (*irq_enable)(void);
+
+	void (*safe_halt)(void);
+	void (*halt)(void);
+	void (*wbinvd)(void);
+
+	/* err =3D 0/-EFAULT.  wrmsr returns 0/-EFAULT. */
+	unsigned long (*read_msr)(unsigned int msr, int *err);
+	int (*write_msr)(unsigned int msr, unsigned long val);
+
+	u64 (*read_tsc)(void);
+	u64 (*read_tscp)(int *aux);
+	u64 (*read_pmc)(void);
+
+	void (*load_tr_desc)(void);
+	void (*load_gdt)(const struct desc_ptr *);
+	void (*load_idt)(const struct desc_ptr *);
+	void (*store_gdt)(struct desc_ptr *);
+	void (*store_idt)(struct desc_ptr *);
+	void (*set_ldt)(const void *desc, unsigned entries);
+	unsigned long (*store_tr)(void);
+	void (*load_tls)(struct thread_struct *t, unsigned int cpu);
+	void (*write_ldt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (*write_gdt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (*write_idt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (*load_rsp0)(struct tss_struct *tss,
+				   struct thread_struct *thread);
+
+	void (*io_delay)(void);
+	void (*const_udelay)(unsigned long loops);
+
+	void (*activate_mm)(struct mm_struct *prev,
+				     struct mm_struct *next);
+	void (*dup_mmap)(struct mm_struct *oldmm,
+				  struct mm_struct *mm);
+	void (*exit_mmap)(struct mm_struct *mm);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	void (*apic_write)(unsigned long reg, unsigned int v);
+	unsigned int (*apic_read)(unsigned long reg);
+#endif
+
+	void (*flush_tlb_user)(void);
+	void (*flush_tlb_kernel)(void);
+	void (*flush_tlb_single)(u64 addr);
+
+	void (*alloc_pt)(u64 pfn);
+	void (*alloc_pd)(u64 pfn);
+	void (*alloc_pd_clone)(u64 pfn, u64 clonepfn, u64 start, u64 count);
+	void (*release_pt)(u64 pfn);
+	void (*release_pd)(u64 pfn);
+
+	void (*set_pte)(pte_t *ptep, pte_t pteval);
+	void (*set_pte_at)(struct mm_struct *mm, u64 addr, pte_t *ptep, pte_t pte=
val);
+	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
+	void (*set_pud)(pud_t *pudp, pud_t pudval);
+	void (*set_pgd)(pgd_t *pgdp, pgd_t pgdval);
+
+	void (*pte_update)(struct mm_struct *mm, u64 addr, pte_t *ptep);
+	void (*pte_update_defer)(struct mm_struct *mm, u64 addr, pte_t *ptep);
+
+	pte_t (*ptep_get_and_clear)(struct mm_struct *mm, u64 addr, pte_t *ptep);
+
+	void (*pte_clear)(struct mm_struct *mm, u64 addr, pte_t *ptep);
+	void (*pmd_clear)(pmd_t *pmdp);
+	void (*pud_clear)(pud_t *pudp);
+	void (*pgd_clear)(pgd_t *pgdp);
+
+	unsigned long (*pte_val)(pte_t);
+	unsigned long (*pud_val)(pud_t);
+	unsigned long (*pmd_val)(pmd_t);
+	unsigned long (*pgd_val)(pgd_t);
+
+	pte_t (*make_pte)(unsigned long pte);
+	pud_t (*make_pud)(unsigned long pud);
+	pmd_t (*make_pmd)(unsigned long pmd);
+	pgd_t (*make_pgd)(unsigned long pgd);
+
+	void (*swapgs)(unsigned long rip);
+	void (*ebda_info)(unsigned *addr, unsigned *size);
+	void (*set_lazy_mode)(int mode);
+
+	/* These two are jmp to, not actually called. */
+	void (*sysret)(void);
+	void (*iret)(void);
+
+	void (*startup_ipi_hook)(int phys_apicid, unsigned long start_eip, unsign=
ed long start_esp);
+};
+
+#define MAP_TYPE_STR paravirt_ops.mem_type
+
+/* Mark a paravirt probe function. */
+#define paravirt_probe(fn)						\
+ static asmlinkage void (*__paravirtprobe_##fn)(void) __attribute_used__ \
+		__attribute__((__section__(".paravirtprobe"))) =3D fn
+
+#define paravirt_probe_failsafe(fn)						\
+ static asmlinkage void (*__paravirtprobe_##fn)(void) __attribute_used__ \
+		__attribute__((__section__(".paravirtprobe_failsafe"))) =3D fn
+extern struct paravirt_ops paravirt_ops;
+
+void native_pagetable_setup_start(pgd_t *pgd);
+
+pte_t native_make_pte(unsigned long pte);
+pud_t native_make_pud(unsigned long pud);
+pmd_t native_make_pmd(unsigned long pmd);
+pgd_t native_make_pgd(unsigned long pgd);
+
+#define paravirt_enabled() (paravirt_ops.paravirt_enabled)
+
+static inline void load_rsp0(struct tss_struct *tss,
+			     struct thread_struct *thread)
+{
+	paravirt_ops.load_rsp0(tss, thread);
+}
+
+#define ARCH_SETUP			paravirt_ops.arch_setup();
+
+static inline unsigned long get_wallclock(void)
+{
+	return paravirt_ops.get_wallclock();
+}
+
+static inline void set_wallclock(unsigned long nowtime)
+{
+	paravirt_ops.set_wallclock(nowtime);
+}
+
+static inline void do_time_init(void)
+{
+	return paravirt_ops.time_init();
+}
+
+/* The paravirtualized CPUID instruction. */
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	paravirt_ops.cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, reg) var =3D paravirt_ops.get_debugreg(reg)
+#define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
+
+#define clts() paravirt_ops.clts()
+
+#define read_cr0() paravirt_ops.read_cr0()
+#define write_cr0(x) paravirt_ops.write_cr0(x)
+
+#define read_cr2() paravirt_ops.read_cr2()
+#define write_cr2(x) paravirt_ops.write_cr2(x)
+
+#define read_cr3() paravirt_ops.read_cr3()
+#define write_cr3(x) paravirt_ops.write_cr3(x)
+
+#define read_cr4() paravirt_ops.read_cr4()
+#define write_cr4(x) paravirt_ops.write_cr4(x)
+
+
+#define ptep_get_and_clear(mm,addr,xp)	\
+			(paravirt_ops.ptep_get_and_clear(mm,addr,xp))
+
+static inline void raw_safe_halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+
+static inline void halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+#define wbinvd() paravirt_ops.wbinvd()
+
+
+#define rdmsr(msr,val1,val2) do {				\
+	int _err;						\
+	u64 _l =3D paravirt_ops.read_msr(msr,&_err);		\
+	val1 =3D (u32)_l;						\
+	val2 =3D _l >> 32;					\
+} while(0)
+
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr,a,b) ({					\
+	int _err;						\
+	u64 _l =3D paravirt_ops.read_msr(msr,&_err);		\
+	(*a) =3D (u32)_l;						\
+	(*b) =3D _l >> 32;					\
+	_err; })
+
+#define wrmsr(msr,val1,val2) do {				\
+	u64 _l =3D ((u64)(val2) << 32) | (val1);			\
+	paravirt_ops.write_msr((msr), _l);			\
+} while(0)
+
+#define rdmsrl(msr,val) do {					\
+	int _err;						\
+	val =3D paravirt_ops.read_msr((msr),&_err);		\
+} while(0)
+
+#define checking_wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+
+#define wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+
+#define wrmsr_safe(msr,a,b) ({					\
+	u64 _l =3D ((u64)(b) << 32) | (a);			\
+	paravirt_ops.write_msr((msr),_l);			\
+})
+
+#define rdtsc(low,high) do {					\
+	u64 _l =3D paravirt_ops.read_tsc();			\
+	low =3D (u32)_l;						\
+	high =3D _l >> 32;					\
+} while(0)
+
+#define rdtscl(low) do {					\
+	u64 _l =3D paravirt_ops.read_tsc();			\
+	low =3D (int)_l;						\
+} while(0)
+
+#define rdtscll(val) (val =3D paravirt_ops.read_tsc())
+
+#define rdtscp(low,high,aux) do {				\
+	u64 _val =3D paravirt_ops.read_tscp(&aux);		\
+	low =3D (int)_val;					\
+	high =3D _val >> 32;					\
+} while (0)
+
+#define rdtscpll(val, aux) (val) =3D paravirt_ops.read_tscp(&aux)
+
+#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
+
+#define rdpmc(counter,low,high) do {				\
+	u64 _l =3D paravirt_ops.read_pmc();			\
+	low =3D (u32)_l;						\
+	high =3D _l >> 32;					\
+} while(0)
+
+#define load_TR_desc() (paravirt_ops.load_tr_desc())
+#define load_gdt(dtr) (paravirt_ops.load_gdt(dtr))
+#define load_idt(dtr) (paravirt_ops.load_idt(dtr))
+#define set_ldt(addr, entries) (paravirt_ops.set_ldt((addr), (entries)))
+#define store_gdt(dtr) (paravirt_ops.store_gdt(dtr))
+#define store_idt(dtr) (paravirt_ops.store_idt(dtr))
+#define store_tr(tr) ((tr) =3D paravirt_ops.store_tr())
+#define load_TLS(t,cpu) (paravirt_ops.load_tls((t),(cpu)))
+#define write_ldt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_ldt_entry((dt), (entry), (low), (high)))
+#define write_gdt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_gdt_entry((dt), (entry), (low), (high)))
+#define write_idt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_idt_entry((dt), (entry), (low), (high)))
+
+#define __pte(x)	paravirt_ops.make_pte(x)
+#define pte_val(x)	paravirt_ops.pte_val(x)
+
+#define __pgd(x)	paravirt_ops.make_pgd(x)
+#define pgd_val(x)	paravirt_ops.pgd_val(x)
+
+#define __pud(x)	paravirt_ops.make_pud(x)
+#define pud_val(x)	paravirt_ops.pud_val(x)
+
+#define __pmd(x)	paravirt_ops.make_pmd(x)
+#define pmd_val(x)	paravirt_ops.pmd_val(x)
+
+#define ebda_info(addr,size) paravirt_ops.ebda_info(addr,size)
+
+/* The paravirtualized I/O functions */
+static inline void slow_down_io(void) {
+	paravirt_ops.io_delay();
+#ifdef REALLY_SLOW_IO
+	paravirt_ops.io_delay();
+	paravirt_ops.io_delay();
+	paravirt_ops.io_delay();
+#endif
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+/*
+ * Basic functions accessing APICs.
+ */
+static inline void apic_write(unsigned long reg, unsigned long v)
+{
+	paravirt_ops.apic_write(reg,v);
+}
+
+static inline unsigned long apic_read(unsigned long reg)
+{
+	return paravirt_ops.apic_read(reg);
+}
+#endif
+
+static inline void paravirt_pagetable_setup_start(pgd_t *base)
+{
+	if (paravirt_ops.pagetable_setup_start)
+		(*paravirt_ops.pagetable_setup_start)(base);
+}
+
+static inline void paravirt_pagetable_setup_done(pgd_t *base)
+{
+	if (paravirt_ops.pagetable_setup_done)
+		(*paravirt_ops.pagetable_setup_done)(base);
+}
+
+void native_pte_clear(struct mm_struct *mm, u64 addr, pte_t *ptep);
+void native_pmd_clear(pmd_t *pmd);
+void native_nop(void);
+
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+	paravirt_ops.activate_mm(prev, next);
+}
+
+static inline void paravirt_dup_mmap(struct mm_struct *oldmm,
+				     struct mm_struct *mm)
+{
+	paravirt_ops.dup_mmap(oldmm, mm);
+}
+
+static inline void paravirt_exit_mmap(struct mm_struct *mm)
+{
+	paravirt_ops.exit_mmap(mm);
+}
+
+#define __flush_tlb() paravirt_ops.flush_tlb_user()
+#define __flush_tlb_all() paravirt_ops.flush_tlb_kernel()
+#define __flush_tlb_one(addr) paravirt_ops.flush_tlb_single(addr)
+
+#define paravirt_alloc_pt(pfn) paravirt_ops.alloc_pt(pfn)
+#define paravirt_release_pt(pfn) paravirt_ops.release_pt(pfn)
+
+#define paravirt_alloc_pd(pfn) paravirt_ops.alloc_pd(pfn)
+#define paravirt_alloc_pd_clone(pfn, clonepfn, start, count) \
+	paravirt_ops.alloc_pd_clone(pfn, clonepfn, start, count)
+#define paravirt_release_pd(pfn) paravirt_ops.release_pd(pfn)
+
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	paravirt_ops.set_pte(ptep, pteval);
+}
+
+static inline void set_pte_at(struct mm_struct *mm, u64 addr, pte_t *ptep,=
 pte_t pteval)
+{
+	paravirt_ops.set_pte_at(mm, addr, ptep, pteval);
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+	paravirt_ops.set_pmd(pmdp, pmdval);
+}
+
+static inline void pte_update(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+	paravirt_ops.pte_update(mm, addr, ptep);
+}
+
+static inline void pte_update_defer(struct mm_struct *mm, u32 addr, pte_t =
*ptep)
+{
+	paravirt_ops.pte_update_defer(mm, addr, ptep);
+}
+
+
+static inline void set_pgd(pgd_t *pgdp, pgd_t pgdval)
+{
+	paravirt_ops.set_pgd(pgdp, pgdval);
+}
+
+static inline void set_pud(pud_t *pudp, pud_t pudval)
+{
+	paravirt_ops.set_pud(pudp, pudval);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte=
_t *ptep)
+{
+	paravirt_ops.pte_clear(mm, addr, ptep);
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	paravirt_ops.pmd_clear(pmdp);
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	paravirt_ops.pud_clear(pudp);
+}
+
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	paravirt_ops.pgd_clear(pgdp);
+}
+
+/* Lazy mode for batching updates / context switch */
+#define PARAVIRT_LAZY_NONE 0
+#define PARAVIRT_LAZY_MMU  1
+#define PARAVIRT_LAZY_CPU  2
+
+#define  __HAVE_ARCH_ENTER_LAZY_CPU_MODE
+#define arch_enter_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZ=
Y_CPU)
+#define arch_leave_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZ=
Y_NONE)
+
+#define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
+#define arch_enter_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZ=
Y_MMU)
+#define arch_leave_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZ=
Y_NONE)
+
+/* These all sit in the .parainstructions section to tell us what to patch=
. */
+struct paravirt_patch {
+	u8 *instr; 		/* original instructions */
+	u8 instrtype;		/* type of this instruction */
+	u8 len;			/* length of original instruction */
+	u16 clobbers;		/* what registers you may clobber */
+} __attribute__((aligned(8)));
+
+#define paravirt_alt(insn_string, typenum, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	".align 8\n"					\
+	"  .quad 771b\n"				\
+	"  .byte " __stringify(typenum) "\n"		\
+	"  .byte 772b-771b\n"				\
+	"  .short " __stringify(clobber) "\n"		\
+	".popsection"
+
+/* These functions tends to be very simple. So, if they touch any register,
+ * the calle-saved ones may already fulfill their needs, and hopefully we
+ * have no need to save any. */
+static inline unsigned long __raw_local_save_flags(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt("call *%1;",
+					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
+			     : "=3Da"(f): "m"(paravirt_ops.save_fl)
+			     : "memory", "cc");
+	return f;
+}
+
+static inline void raw_local_irq_restore(unsigned long f)
+{
+	__asm__ __volatile__(paravirt_alt("call *%1;", PARAVIRT_RESTORE_FLAGS,
+					CLBR_NONE)
+			     : : "D" (f) , "m" (paravirt_ops.restore_fl)
+			     : "memory", "rax", "cc");
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	__asm__ __volatile__(paravirt_alt("call *%0;",
+					  PARAVIRT_IRQ_DISABLE, CLBR_NONE)
+			     : : "m" (paravirt_ops.irq_disable)
+			     : "memory", "rax", "cc");
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	__asm__ __volatile__(paravirt_alt("call *%0;",
+					  PARAVIRT_IRQ_ENABLE, CLBR_NONE)
+			     : : "m" (paravirt_ops.irq_enable)
+			     : "memory", "rax", "cc");
+}
+
+static inline unsigned long __raw_local_irq_save(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt( "call *%1;"
+					   "call *%2;",
+					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE,
+					  CLBR_NONE)
+			     : "=3Da"(f)
+			     : "m" (paravirt_ops.save_fl),
+			       "m" (paravirt_ops.irq_disable)
+			     : "memory", "cc");
+	return f;
+}
+
+#define CLI_STRING paravirt_alt("call *paravirt_ops+%c[irq_disable];",	\
+		     PARAVIRT_IRQ_DISABLE, CLBR_NONE)
+
+#define STI_STRING paravirt_alt("call *paravirt_ops+%c[irq_enable];",	\
+		     PARAVIRT_IRQ_ENABLE, CLBR_NONE)
+
+#define CLI_STI_CLOBBERS , "%rax"
+#define CLI_STI_INPUT_ARGS \
+	,								\
+	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
+	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
+
+#else  /* __ASSEMBLY__ */
+
+#define PARA_PATCH(ptype, clobbers, ops)	\
+771:;						\
+	ops;					\
+772:;						\
+	.pushsection .parainstructions,"a";	\
+	.align 8;				\
+	 .quad 771b;				\
+	 .byte ptype;				\
+	 .byte 772b-771b;			\
+	 .short clobbers;			\
+	.popsection
+
+#define INTERRUPT_RETURN				\
+	PARA_PATCH(PARAVIRT_INTERRUPT_RETURN, CLBR_ANY,	\
+	jmp *%cs:paravirt_ops+PARAVIRT_iret)
+
+#define DISABLE_INTERRUPTS(clobbers)			\
+	PARA_PATCH(PARAVIRT_IRQ_DISABLE, clobbers,	\
+	call *paravirt_ops+PARAVIRT_irq_disable)
+
+#define ENABLE_INTERRUPTS(clobbers)			\
+	PARA_PATCH(PARAVIRT_IRQ_ENABLE, clobbers,	\
+	call *%cs:paravirt_ops+PARAVIRT_irq_enable)
+
+#define SYSRETQ						\
+	PARA_PATCH(PARAVIRT_SYSRETQ, CLBR_ANY,		\
+	jmp *%cs:paravirt_ops+PARAVIRT_sysret)
+
+#define SWAPGS						\
+	PARA_PATCH(PARAVIRT_SWAPGS, CLBR_NONE,		\
+	call *paravirt_ops+PARAVIRT_swapgs)		\
+
+/* this is needed in early_idt_handler */
+#define GET_CR2_INTO_RAX 				\
+	call *paravirt_ops+PARAVIRT_read_cr2
+
+#endif /* __ASSEMBLY__ */
+#else  /* !CONFIG_PARAVIRT */
+
+static inline void paravirt_pagetable_setup_start(pgd_t *base)
+{
+	int i;
+
+	/*
+	 * Init entries of the first-level page table to the
+	 * zero page, if they haven't already been set up.
+	 *
+	 * In a normal native boot, we'll be running on a
+	 * pagetable rooted in swapper_pg_dir, but not in PAE
+	 * mode, so this will end up clobbering the mappings
+	 * for the lower 24Mbytes of the address space,
+	 * without affecting the kernel address space.
+	 */
+	for (i =3D 0; i < USER_PTRS_PER_PGD; i++)
+		set_pgd(&base[i],
+			__pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
+	memset(&base[USER_PTRS_PER_PGD], 0, sizeof(pgd_t));
+}
+
+static inline void paravirt_pagetable_setup_done(pgd_t *base)
+{
+	/*
+	 * Add low memory identity-mappings - SMP needs it when
+	 * starting up on an AP from real-mode. In the non-PAE
+	 * case we already have these mappings through head.S.
+	 * All user-space mappings are explicitly cleared after
+	 * SMP startup.
+	 */
+	set_pgd(&base[0], base[USER_PTRS_PER_PGD]);
+}
+
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+}
+
+static inline void paravirt_dup_mmap(struct mm_struct *oldmm,
+				     struct mm_struct *mm)
+{
+}
+
+static inline void paravirt_exit_mmap(struct mm_struct *mm)
+{
+}
+
+#endif /* CONFIG_PARAVIRT */
+#endif	/* __ASM_PARAVIRT_H */
Index: clean-start/arch/x86_64/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/Makefile
+++ clean-start/arch/x86_64/kernel/Makefile
@@ -41,6 +41,8 @@ obj-$(CONFIG_AUDIT)		+=3D audit.o
 obj-$(CONFIG_MODULES)		+=3D module.o
 obj-$(CONFIG_PCI)		+=3D early-quirks.o
 =

+obj-$(CONFIG_PARAVIRT)		+=3D paravirt.o
+
 obj-y				+=3D topology.o
 obj-y				+=3D intel_cacheinfo.o
 =


--
