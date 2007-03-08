From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 03/13] lguest64 core
Date: Thu, 08 Mar 2007 12:38:47 -0500
Message-ID: <1173375527.32170.5.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (lguest64.patch)
This is the main core code for the lguest64.

Have fun, and don't hurt the puppies!

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>


Index: work-pv/arch/x86_64/lguest/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/Makefile
@@ -0,0 +1,24 @@
+# Guest requires the paravirt_ops replacement and the bus driver.
+obj-$(CONFIG_LGUEST_GUEST) +=3D lguest.o lguest_bus.o
+
+# Host requires the other files, which can be a module.
+obj-$(CONFIG_LGUEST)	+=3D lg.o
+lg-objs :=3D core.o hypervisor.o lguest_user.o hv_vm.o page_tables.o \
+hypercalls.o io.o interrupts_and_traps.o lguest_debug.o
+
+# hypercalls.o page_tables.o interrupts_and_traps.o \
+#	segments.o io.o lguest_user.o
+
+# We use top 4MB for guest traps page, then hypervisor. */
+HYPE_ADDR :=3D (0xFFC00000+4096)
+# The data is only 1k (256 interrupt handler pointers)
+HYPE_DATA_SIZE :=3D 1024
+CFLAGS +=3D -DHYPE_ADDR=3D"$(HYPE_ADDR)" -DHYPE_DATA_SIZE=3D"$(HYPE_DATA_S=
IZE)"
+
+##$(obj)/core.o: $(obj)/hypervisor-blob.c
+### This links the hypervisor in the right place and turns it into a C arr=
ay.
+##$(obj)/hypervisor-raw: $(obj)/hypervisor.o
+##	@$(LD) -static -Tdata=3D`printf %#x $$(($(HYPE_ADDR)))` -Ttext=3D`print=
f %#x $$(($(HYPE_ADDR)+$(HYPE_DATA_SIZE)))` -o $@ $< && $(OBJCOPY) -O binar=
y $@
+##$(obj)/hypervisor-blob.c: $(obj)/hypervisor-raw
+##	@od -tx1 -An -v $< | sed -e 's/^ /0x/' -e 's/$$/,/' -e 's/ /,0x/g' > $@
+
Index: work-pv/arch/x86_64/lguest/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/core.c
@@ -0,0 +1,379 @@
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/freezer.h>
+#include <linux/kallsyms.h>
+#include <asm/paravirt.h>
+#include <asm/hv_vm.h>
+#include <asm/uaccess.h>
+#include <asm/i387.h>
+#include "lguest.h"
+
+#define HV_OFFSET(x) (typeof(x))((unsigned long)(x)+lguest_hv_offset)
+
+unsigned long lguest_hv_addr;
+unsigned long lguest_hv_offset;
+int lguest_hv_pages;
+
+int lguest_vcpu_pages;
+int lguest_vcpu_order;
+
+DEFINE_MUTEX(lguest_lock);
+
+int lguest_address_ok(const struct lguest_guest_info *linfo, u64 addr)
+{
+	return addr / PAGE_SIZE < linfo->pfn_limit;
+}
+
+u8 lhread_u8(struct lguest_vcpu *vcpu, u64 addr)
+{
+	u8 val =3D 0;
+
+	if (!lguest_address_ok(vcpu->guest, addr)
+	    || get_user(val, (u8 __user *)addr) !=3D 0)
+			kill_guest_dump(vcpu, "bad read address %llx", addr);
+	return val;
+}
+
+u16 lhread_u16(struct lguest_vcpu *vcpu, u64 addr)
+{
+	u16 val =3D 0;
+
+	if (!lguest_address_ok(vcpu->guest, addr)
+	    || get_user(val, (u16 __user *)addr) !=3D 0)
+			kill_guest_dump(vcpu, "bad read address %llx", addr);
+	return val;
+}
+
+u64 lhread_u64(struct lguest_vcpu *vcpu, u64 addr)
+{
+	u64 val =3D 0;
+
+	if (!lguest_address_ok(vcpu->guest, addr)
+	    || get_user(val, (u64 __user *)addr) !=3D 0)
+			kill_guest_dump(vcpu, "bad read address %llx", addr);
+	return val;
+}
+
+void lhwrite_u64(struct lguest_vcpu *vcpu, u64 addr, u64 val)
+{
+	if (!lguest_address_ok(vcpu->guest, addr)
+	    || put_user(val, (u64 __user *)addr) !=3D 0)
+			kill_guest_dump(vcpu, "bad read address %llx", addr);
+}
+
+void lhread(struct lguest_guest_info *linfo, void *b, u64 addr, unsigned b=
ytes)
+{
+	if (addr + bytes < addr || !lguest_address_ok(linfo, addr+bytes)
+	   || copy_from_user(b, (void __user *)addr, bytes) !=3D 0) {
+		/* copy_from_user should do this, but as we rely on it... */
+		memset(b, 0, bytes);
+		kill_guest(linfo, "bad read address %llx len %u", addr, bytes);
+	}
+}
+
+void lhwrite(struct lguest_guest_info *linfo, u64 addr, const void *b,
+								unsigned bytes)
+{
+	if (addr + bytes < addr
+	   || !lguest_address_ok(linfo, addr+bytes)
+	   || copy_to_user((void __user *)addr, b, bytes) !=3D 0)
+		kill_guest(linfo, "bad write address %llx len %u", addr, bytes);
+}
+
+static struct gate_struct *get_idt_table(void)
+{
+	struct desc_ptr idt;
+
+	asm("sidt %0":"=3Dm" (idt));
+	return (void *)idt.address;
+}
+
+static int emulate_insn(struct lguest_vcpu *vcpu)
+{
+	u8 insn;
+	unsigned int insnlen =3D 0, in =3D 0, shift =3D 0;
+	unsigned long physaddr =3D guest_pa(vcpu->guest, vcpu->regs.rip);
+
+	if (vcpu->regs.rip < vcpu->guest->page_offset)
+		return 0;
+
+	lhread(vcpu->guest, &insn, physaddr, 1);
+
+	/* Operand size prefix means it's actually for ax. */
+	if (insn =3D=3D 0x66) {
+		shift =3D 16;
+		insnlen =3D 1;
+		printk("physaddr + len: %lx\n",physaddr+insnlen);
+		lhread(vcpu->guest, &insn, physaddr + insnlen, 1);
+	}
+
+	switch (insn & 0xFE) {
+	case 0xE4: /* in     <next byte>,%al */
+		insnlen +=3D 2;
+		in =3D 1;
+		break;
+	case 0xEC: /* in     (%dx),%al */
+		insnlen +=3D 1;
+		in =3D 1;
+		break;
+	case 0xE6: /* out    %al,<next byte> */
+		insnlen +=3D 2;
+		break;
+	case 0xEE: /* out    %al,(%dx) */
+		insnlen +=3D 1;
+		break;
+	default:
+		printk("%llx: %02x unimplemented op\n", vcpu->regs.rip, insn);
+		kill_guest_dump(vcpu, "bad op");
+		return 0;
+	}
+	if (in) {
+		/* Lower bit tells is whether it's a 16 or 32 bit access */
+		if (insn & 0x1)
+			vcpu->regs.rax =3D 0xFFFFFFFF;
+		else
+			vcpu->regs.rax |=3D (0xFFFF << shift);
+	}
+	vcpu->regs.rip +=3D insnlen;
+	return 1;
+}
+
+#define SAVE_CR2(cr2)	asm volatile ("movq %%cr2, %0" : "=3Dr" (cr2))
+
+static void run_guest_once(struct lguest_vcpu *vcpu)
+{
+	void (*sw_guest)(struct lguest_vcpu *) =3D HV_OFFSET(&switch_to_guest);
+	unsigned long foo, bar;
+
+	BUG_ON(!vcpu->regs.cr3);
+	BUG_ON(!vcpu->pgdir);
+	BUG_ON(!vcpu->pgdir->pgdir);
+	asm volatile ("pushq %2; pushq %%rsp; pushfq; pushq %3; call *%6;"
+		      /* The stack we pushed is off by 8, due to the previous pushq */
+		      "addq $8, %%rsp"
+		      : "=3DD"(foo), "=3Da"(bar)
+		      : "i" (__KERNEL_DS), "i" (__KERNEL_CS), "0" (vcpu), "1"(get_idt_ta=
ble()),
+			"r" (sw_guest)
+		      : "memory", "cc");
+}
+
+/* FIXME: don't know yet the right parameters to put here */
+int run_guest(struct lguest_vcpu *vcpu, char *__user user)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct desc_struct *gdt_table;
+	struct lguest_regs *regs =3D &vcpu->regs;
+	int ret;
+
+	unsigned long cr2 =3D 0;
+
+	while (!linfo->dead) {
+
+		if (regs->trapnum =3D=3D LGUEST_TRAP_ENTRY) {
+
+			if (lguest_debug) {
+				printk("hit trap %lld rip=3D", regs->trapnum);
+				lguest_print_address(vcpu, regs->rip);
+				printk("calling hypercall %d!\n", (unsigned)regs->rax);
+			}
+
+			regs->trapnum =3D 255;
+			hypercall(vcpu);
+			if (linfo->dead)
+				lguest_dump_vcpu_regs(vcpu);
+		}
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		maybe_do_interrupt(vcpu);
+
+		try_to_freeze();
+
+		if (linfo->dead)
+			return -1;
+
+
+		local_irq_disable();
+
+		/*
+		 * keep a pointer to the host GDT tss address.
+		 * Do this after disabling interrupts to make sure we
+		 * are on the same CPU.
+		 */
+		gdt_table =3D cpu_gdt(smp_processor_id());
+		vcpu->host_gdt_ptr =3D (unsigned long)gdt_table;
+		asm volatile ("sidt %0" : "=3Dm"(vcpu->host_idt));
+
+		/* Even if *we* don't want FPU trap, guest might... */
+		if (vcpu->ts)
+			stts();
+
+		run_guest_once(vcpu);
+
+		if (regs->trapnum =3D=3D 14) {
+			SAVE_CR2(cr2);
+			lgdebug_print("faulting cr2: %lx\n",cr2);
+		}
+
+		else if (regs->trapnum =3D=3D 7)
+			math_state_restore();
+
+		if (lguest_debug && regs->trapnum < 32) {
+			printk("hit trap %lld rip=3D", regs->trapnum);
+			lguest_print_address(vcpu, regs->rip);
+		}
+
+		local_irq_enable();
+
+		BUG_ON(regs->trapnum > 0xFF);
+
+		switch (regs->trapnum) {
+		case 7:
+			/* We've intercepted a Device Not Available fault. */
+			/* If they don't want to know, just absorb it. */
+			if (!vcpu->ts)
+				continue;
+			if (reflect_trap(vcpu, 7, 1))
+				continue;
+			kill_guest(vcpu->guest, "Unhandled FPU trap at %#llx",
+								regs->rip);
+		case 13:
+			if (!regs->errcode) {
+				ret =3D emulate_insn(vcpu);
+				if (ret < 0) {
+					lguest_dump_vcpu_regs(vcpu);
+					return ret;
+				}
+				continue;
+			}
+			kill_guest_dump(vcpu, "took gfp errcode %lld\n", regs->errcode);
+			lguest_dump_vcpu_regs(vcpu);
+			break;
+		case 14:
+			if (demand_page(vcpu, cr2, regs->errcode & PF_WRITE))
+				continue;
+
+			if (lguest_debug) {
+				printk ("guest taking a page fault\n");
+				lguest_print_page_tables(vcpu->pgdir->pgdir);
+			}
+
+			/* inform guest on the current state of cr2 */
+			put_user(cr2, &linfo->lguest_data->cr2);
+			if (reflect_trap(vcpu, 14, 1))
+				continue;
+
+			lguest_dump_vcpu_regs(vcpu);
+			kill_guest_dump(vcpu, "unhandled page fault at %#lx"
+					" (rip=3D%#llx, errcode=3D%#llx)",
+					cr2, regs->rip, regs->errcode);
+			break;
+		case LGUEST_TRAP_ENTRY:
+			/* hypercall! */
+			continue;
+
+		case 32 ... 255:
+			cond_resched();
+			break;
+		default:
+			kill_guest_dump(vcpu, "bad trapnum %lld\n", regs->trapnum);
+			lguest_dump_vcpu_regs(vcpu);
+			return -EINVAL;
+		}
+	}
+	return -ENOENT;
+}
+
+extern long end_hyper_text;
+extern long start_hyper_text;
+
+static int __init init(void)
+{
+	unsigned long pages;
+	unsigned long hvaddr;
+#if 0
+	unsigned long lg_hcall =3D (unsigned long)HV_OFFSET(&hcall_teste);
+	unsigned long *lg_host_syscall =3D
+				(unsigned long *)HV_OFFSET(&host_syscall);
+#endif
+	int order;
+	int ret;
+
+	int i;
+	printk("start_hyper_text=3D%p\n",&start_hyper_text);
+	printk("end_hyper_text=3D%p\n",&end_hyper_text);
+	printk("default_idt_entries=3D%p\n",&_lguest_default_idt_entries);
+	printk("sizeof(vcpu)=3D%ld\n",sizeof(struct lguest_vcpu));
+
+	pages =3D (sizeof(struct lguest_vcpu)+(PAGE_SIZE-1))/PAGE_SIZE;
+	for (order =3D 0; (1<<order) < pages; order++)
+		;
+
+	lguest_vcpu_pages =3D pages;
+	lguest_vcpu_order =3D order;
+
+	ret =3D paravirt_enabled();
+	if (ret < 0)
+		return -EPERM;
+
+	ret =3D lguest_device_init();
+	if (ret < 0) {
+		return ret;
+	}
+
+	pages =3D (unsigned long)&end_hyper_text -
+		(unsigned long)&start_hyper_text;
+	pages =3D (pages + (PAGE_SIZE - 1)) / PAGE_SIZE;
+
+	ret =3D hvvm_map_pages(&start_hyper_text, pages, &hvaddr);
+	if (ret < 0)
+		goto out;
+	printk("hvaddr=3D%lx\n",hvaddr);
+
+	lguest_hv_addr =3D hvaddr;
+	lguest_hv_pages =3D pages;
+	lguest_hv_offset =3D hvaddr - (unsigned long)&start_hyper_text;
+
+	/* Setup LGUEST segments on all cpus */
+	for_each_possible_cpu(i) {
+		struct desc_struct *gdt_table;
+		gdt_table =3D cpu_gdt(i);
+		gdt_table[GDT_ENTRY_HV_CS] =3D gdt_table[gdt_index(__KERNEL_CS)];
+		gdt_table[GDT_ENTRY_HV_DS] =3D gdt_table[gdt_index(__KERNEL_DS)];
+	}
+
+//	rdmsrl(MSR_LSTAR, *lg_host_syscall);
+//	wrmsrl(MSR_LSTAR, lg_hcall);
+	return 0;
+#if 0
+	ret =3D init_pagetables(hvaddr);
+	if (ret < 0)
+		goto out2;
+
+	return 0;
+
+out2:
+	hvvm_unnmap_pages(hvaddr, pages);
+#endif
+out:
+	lguest_device_remove();
+	return ret;
+}
+
+
+static void __exit fini(void)
+{
+#if 0
+	unsigned long *lg_host_syscall =3D
+			(unsigned long *)HV_OFFSET(&host_syscall);
+
+	wrmsrl(MSR_LSTAR, *lg_host_syscall);
+#endif
+	hvvm_release_all();
+	lguest_device_remove();
+}
+
+module_init(init);
+module_exit(fini);
+MODULE_LICENSE("GPL");
Index: work-pv/arch/x86_64/lguest/hypercalls.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/hypercalls.c
@@ -0,0 +1,324 @@
+/*  Actual hypercalls, which allow guests to actually do something.
+    Copyright (C) 2007, Glauber de Oliveira Costa <gcosta@redhat.com>
+                        Steven Rostedt <srostedt@redhat.com>
+                        Red Hat Inc
+    Standing on the shoulders of Rusty Russell.
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
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+#include <linux/mm.h>
+#include <asm/lguest.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/msr.h>
+#include "lguest.h"
+
+/* FIXME: add this to Kconfig */
+#define CONFIG_LGUEST_DEBUG 1
+
+static void guest_set_stack(struct lguest_vcpu *vcpu,
+			    u64 rsp, unsigned int pages)
+{
+	/* You cannot have a stack segment with priv level 0. */
+	if (pages > 2)
+		kill_guest_dump(vcpu, "bad stack pages %u", pages);
+	vcpu->tss.rsp2 =3D rsp;
+	/* FIXME */
+//	lg->stack_pages =3D pages;
+//	pin_stack_pages(lg);
+}
+
+static DEFINE_MUTEX(hcall_print_lock);
+#define HCALL_PRINT_SIZ 1024
+static char hcall_print_buf[HCALL_PRINT_SIZ];
+
+/* Return true if DMA to host userspace now pending. */
+static int do_hcall(struct lguest_vcpu *vcpu)
+{
+	struct lguest_regs *regs =3D &vcpu->regs;
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	unsigned long val;
+	unsigned long ret;
+
+	switch (regs->rax) {
+	case LHCALL_PRINT:
+		mutex_lock(&hcall_print_lock);
+		ret =3D strncpy_from_user(hcall_print_buf,
+					(const char __user *)regs->rdx,
+					HCALL_PRINT_SIZ);
+		if (ret < 0) {
+			kill_guest_dump(vcpu,
+					"bad hcall print pointer (%llx)",
+					regs->rdx);
+			mutex_unlock(&hcall_print_lock);
+			return -EFAULT;
+		}
+		printk("LGUEST: %s", hcall_print_buf);
+		mutex_unlock(&hcall_print_lock);
+
+		break;
+	case LHCALL_FLUSH_ASYNC:
+		break;
+	case LHCALL_LGUEST_INIT:
+		kill_guest_dump(vcpu, "already have lguest_data");
+		break;
+	case LHCALL_RDMSR:
+		switch (regs->rdx) {
+		case MSR_KERNEL_GS_BASE:
+			val =3D (vcpu->guest_gs_shadow_a & ((1UL << 32)-1)) |
+				(vcpu->guest_gs_shadow_d << 32);
+			lhwrite_u64(vcpu, regs->rbx, val);
+			break;
+		case MSR_GS_BASE:
+			val =3D (vcpu->guest_gs_a & ((1UL << 32)-1)) |
+				(vcpu->guest_gs_d << 32);
+			lhwrite_u64(vcpu, regs->rbx, val);
+		break;
+		case MSR_FS_BASE:
+			lhwrite_u64(vcpu, regs->rbx, 0);
+		break;
+		case MSR_EFER:
+			val =3D EFER_SCE | EFER_LME | EFER_LMA | EFER_NX;
+			lhwrite_u64(vcpu, regs->rbx, val);
+		break;
+		default:
+			kill_guest_dump(vcpu, "bad read of msr %llx\n", regs->rdx);
+		}
+		break;
+	case LHCALL_WRMSR:
+		switch (regs->rdx) {
+		case MSR_KERNEL_GS_BASE:
+			if ((regs->rbx >=3D HVVM_START) &&
+			    (regs->rbx < (HVVM_START + HV_VIRT_SIZE))) {
+				kill_guest_dump(vcpu,
+						"guest trying to set GS shadow base"
+						" in hypervisor");
+				break;
+			}
+			vcpu->guest_gs_shadow_a =3D regs->rbx;
+			vcpu->guest_gs_shadow_d =3D regs->rbx >> 32;
+		break;
+		case MSR_GS_BASE:
+			if ((regs->rbx >=3D HVVM_START) &&
+			    (regs->rbx < (HVVM_START + HV_VIRT_SIZE))) {
+				kill_guest_dump(vcpu,
+						"guest trying to set GS base in hypervisor");
+				break;
+			}
+			vcpu->guest_gs_a =3D regs->rbx;
+			vcpu->guest_gs_d =3D regs->rbx >> 32;
+		break;
+		case MSR_FS_BASE:
+			/* always zero */
+		break;
+		default:
+			kill_guest(linfo, "bad write to msr %llx\n", regs->rdx);
+		}
+		break;
+	case LHCALL_SET_PMD:
+		guest_set_pmd(vcpu, regs->rdx, regs->rbx, regs->rcx);
+		break;
+	case LHCALL_SET_PUD:
+		guest_set_pud(vcpu, regs->rdx, regs->rbx, regs->rcx);
+		break;
+	case LHCALL_SET_PGD:
+		guest_set_pgd(vcpu, regs->rdx, regs->rbx, regs->rcx);
+		break;
+	case LHCALL_SET_PTE:
+		guest_set_pte(vcpu, regs->rdx, regs->rbx, regs->rcx);
+		break;
+
+	case LHCALL_FLUSH_TLB_SIG:
+		guest_flush_tlb_single(vcpu, regs->rdx, regs->rbx);
+		break;
+	case LHCALL_FLUSH_TLB:
+		if (regs->rdx)
+			guest_pagetable_clear_all(vcpu);
+		else
+			guest_pagetable_flush_user(vcpu);
+		break;
+
+	case LHCALL_NEW_PGTABLE:
+		guest_new_pagetable(vcpu, regs->rdx);
+		break;
+
+	case LHCALL_CRASH: {
+		char msg[128];
+		lhread(linfo, msg, regs->rdx, sizeof(msg));
+		msg[sizeof(msg)-1] =3D '\0';
+		kill_guest_dump(vcpu, "CRASH: %s", msg);
+		break;
+	}
+	case LHCALL_LOAD_GDT:
+		/* i386 does a lot of gdt reloads. We don't.
+		 * we may want to support it in the future for more
+		 * strange code paths. Not now */
+		return -ENOSYS;
+
+	case LHCALL_LOAD_IDT_ENTRY: {
+		struct gate_struct g;;
+		if (regs->rdx > 0xFF) {
+			kill_guest(linfo, "There are just 255 idt entries."
+					"What are you trying to do??");
+		}
+		lhread(linfo, &g, regs->rbx, sizeof(g));
+		load_guest_idt_entry(vcpu, regs->rdx,&g);
+		break;
+	}
+	case LHCALL_SET_STACK:
+		guest_set_stack(vcpu, regs->rdx, regs->rbx);
+		break;
+	case LHCALL_TS:
+		vcpu->ts =3D regs->rdx;
+		break;
+	case LHCALL_TIMER_READ: {
+		u32 now =3D jiffies;
+		mb();
+		regs->rax =3D now - linfo->last_timer;
+		linfo->last_timer =3D now;
+		break;
+	}
+	case LHCALL_TIMER_START:
+		linfo->timer_on =3D 1;
+		if (regs->rdx !=3D HZ)
+			kill_guest(linfo, "Bad clock speed %lli", regs->rdx);
+		linfo->last_timer =3D jiffies;
+		break;
+	case LHCALL_HALT:
+		linfo->halted =3D 1;
+		break;
+	case LHCALL_GET_WALLCLOCK: {
+		struct timeval tv;
+		do_gettimeofday(&tv);
+		regs->rax =3D tv.tv_sec;
+		break;
+	}
+	case LHCALL_BIND_DMA:
+		printk("Binding dma....\n");
+		regs->rax =3D bind_dma(linfo, regs->rdx, regs->rbx,
+				     regs->rcx >> 8, regs->rcx & 0xFF);
+		break;
+	case LHCALL_SEND_DMA:
+		printk("Sending dma....\n");
+		return send_dma(linfo, regs->rdx, regs->rbx);
+
+	case LHCALL_IRET:
+		guest_iret(vcpu);
+		break;
+#if 0
+	case LHCALL_LOAD_TLS:
+		guest_load_tls(lg, (struct desc_struct __user*)regs->rdx);
+		break;
+#endif
+
+	case LHCALL_DEBUG_ME:
+#ifdef CONFIG_LGUEST_DEBUG
+		lguest_debug =3D regs->rdx;
+		printk("lguest debug turned %s\n", regs->rdx ? "on" : "off");
+		lguest_dump_vcpu_regs(vcpu);
+#else
+		{
+			static int once =3D 1;
+			if (once) {
+				once =3D 0;
+				printk("lguest debug is disabled, to use this "
+				       "please enable CONFIG_LGUEST_DEBUG\n");
+			}
+		}
+#endif
+		break;
+	default:
+		kill_guest(linfo, "Bad hypercall %lli\n", regs->rax);
+	}
+	return 0;
+}
+
+#if 0
+/* We always do queued calls before actual hypercall. */
+int do_async_hcalls(struct lguest *lg)
+{
+	unsigned int i, pending;
+	u8 st[LHCALL_RING_SIZE];
+
+	if (!lg->lguest_data)
+		return 0;
+
+	if (copy_from_user(&st, &lg->lguest_data->hcall_status, sizeof(st)))
+		return -EFAULT;
+
+	for (i =3D 0; i < ARRAY_SIZE(st); i++) {
+		struct lguest_regs regs;
+		unsigned int n =3D lg->next_hcall;
+
+		if (st[n] =3D=3D 0xFF)
+			break;
+
+		if (++lg->next_hcall =3D=3D LHCALL_RING_SIZE)
+			lg->next_hcall =3D 0;
+
+		get_user(regs.rax, &lg->lguest_data->hcalls[n].eax);
+		get_user(regs.rdx, &lg->lguest_data->hcalls[n].edx);
+		get_user(regs.rcx, &lg->lguest_data->hcalls[n].ecx);
+		get_user(regs.rbx, &lg->lguest_data->hcalls[n].ebx);
+		pending =3D do_hcall(lg, &regs);
+		put_user(0xFF, &lg->lguest_data->hcall_status[n]);
+		if (pending)
+			return 1;
+	}
+
+	set_wakeup_process(lg, NULL);
+	return 0;
+}
+#endif
+
+int hypercall(struct lguest_vcpu *vcpu)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_regs *regs =3D &vcpu->regs;
+	int pending;
+
+	if (!linfo->lguest_data) {
+		if (regs->rax !=3D LHCALL_LGUEST_INIT) {
+			kill_guest(linfo, "hypercall %lli before LGUEST_INIT",
+				   regs->rax);
+			return 0;
+		}
+
+		linfo->lguest_data =3D (struct lguest_data __user *)regs->rdx;
+		/* We check here so we can simply copy_to_user/from_user */
+		if (!lguest_address_ok(linfo, (long)linfo->lguest_data)
+		    || !lguest_address_ok(linfo, (long)(linfo->lguest_data+1))){
+			kill_guest(linfo, "bad guest page %p", linfo->lguest_data);
+			return 0;
+		}
+		/* update the page_offset info */
+		get_user(linfo->page_offset, &linfo->lguest_data->page_offset);
+		get_user(linfo->start_kernel_map, &linfo->lguest_data->start_kernel_map);
+
+#if 0
+		get_user(linfo->noirq_start, &linfo->lguest_data->noirq_start);
+		get_user(linfo->noirq_end, &linfo->lguest_data->noirq_end);
+#endif
+		/* We reserve the top pgd entry. */
+		put_user(4U*1024*1024, &linfo->lguest_data->reserve_mem);
+		put_user(linfo->guest_id, &linfo->lguest_data->guest_id);
+		return 0;
+	}
+	pending =3D do_hcall(vcpu);
+	//set_wakeup_process(vcpu, NULL);
+	return pending;
+}
Index: work-pv/arch/x86_64/lguest/hypervisor.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/hypervisor.S
@@ -0,0 +1,711 @@
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+#include <asm/msr.h>
+#include <asm/segment.h>
+#include "lguest.h"
+
+.text
+.align PAGE_SIZE
+
+.global start_hyper_text
+	.type start_hyper_text, @function
+start_hyper_text:
+
+.global	host_syscall
+host_syscall:
+	.quad 0
+
+#define PRINT_L(L)				\
+        PRINT_OUT($L)
+
+#define PRINT_N(n)				\
+        PRINT_OUT($'0' + $n)
+
+#define PRINT_HEX(n)				\
+	mov     n, %cl;				\
+	and     $0xf, %cl;			\
+	cmp     $0xa, %cl;			\
+	jge     11f;				\
+	add     $'0', %cl;			\
+	jmp     12f;				\
+11:	add     $('a' - 10), %cl;               \
+12:	PRINT_OUT(%cl);
+
+#define PRINT_NUM_BX				\
+9:	PRINT_HEX(%bl);				\
+	shr     $4, %rbx;			\
+	jne     9b
+
+#define PRINT_NUM(n)				\
+	movl    $n, %ebx;			\
+	PRINT_NUM_BX;				\
+	PRINT_L('\n');				\
+	PRINT_L('\r')
+
+#define PRINT_LONG(n)				\
+	movl    n, %ebx;			\
+	PRINT_NUM_BX;				\
+	PRINT_L('\n');				\
+	PRINT_L('\r')
+
+#define PRINT_QUAD(n)				\
+	movq    n, %rbx;			\
+	PRINT_NUM_BX;				\
+	PRINT_L('\n');				\
+	PRINT_L('\r')
+
+#define PRINT_X					\
+	PRINT_L('x')
+
+#define PRINT_OUT(x)				\
+	mov $0x3f8, %esi;			\
+21:	lea  0x5(%esi), %edx;			\
+	movzwl %dx, %edx;			\
+	in  (%dx), %al;				\
+	test $0x20,%al;				\
+	jne 22f;				\
+	pause;					\
+	jmp 21b;				\
+22:						\
+	movl    %esi, %edx;			\
+	movzwl  %dx, %edx;			\
+	mov     x, %al;				\
+	out     %al, (%dx);			\
+31:						\
+	lea  0x5(%esi), %edx;			\
+	movzwl %dx, %edx;			\
+	in  (%dx), %al;				\
+	test $0x20,%al;				\
+	jne 32f;				\
+	pause;					\
+	jmp 31b;				\
+32:						\
+
+#define PUSH_NUM				\
+	pushq %rcx;				\
+	pushq %rbx;
+
+#define POP_NUM					\
+	pushq %rbx;				\
+	pushq %rcx;
+
+#define PUSH_PRINT				\
+	pushq %rsi;				\
+	pushq %rdx;				\
+	pushq %rax;				\
+
+#define POP_PRINT				\
+	popq %rax;				\
+	popq %rdx;				\
+	popq %rsi;
+
+#define S_PRINT_NUM(_n)				\
+	PUSH_PRINT;				\
+	PUSH_NUM;				\
+	PRINT_NUM(_n);				\
+	POP_NUM;				\
+	POP_PRINT;
+
+#define S_PRINT_L(x)				\
+	PUSH_PRINT;				\
+	PRINT_L(x);				\
+	POP_PRINT;
+
+#define S_PRINT_QUAD(_n)			\
+	PUSH_PRINT;				\
+	PUSH_NUM;				\
+	PRINT_QUAD(_n);				\
+	POP_NUM;				\
+	POP_PRINT;
+
+/* Save registers on the current stack. Both for
+ * switch_to_guest and switch_to_host usage */
+#define SAVE_REGS				\
+	/* Save old guest/host state */		\
+	pushq	%fs;				\
+	pushq	%rax;				\
+	pushq	%r15;				\
+	pushq	%r14;				\
+	pushq	%r13;				\
+	pushq	%r12;				\
+	pushq	%r11;				\
+	pushq	%r10;				\
+	pushq	%r9;				\
+	pushq	%r8;				\
+	pushq	%rbp;				\
+	pushq	%rdi;				\
+	pushq	%rsi;				\
+	pushq	%rdx;				\
+	pushq	%rcx;				\
+	pushq	%rbx;				\
+
+#define RESTORE_REGS				\
+	/* Save old guest/host state */		\
+	popq	%rbx;				\
+	popq	%rcx;				\
+	popq	%rdx;				\
+	popq	%rsi;				\
+	popq	%rdi;				\
+	popq	%rbp;				\
+	popq	%r8;				\
+	popq	%r9;				\
+	popq	%r10;				\
+	popq	%r11;				\
+	popq	%r12;				\
+	popq	%r13;				\
+	popq	%r14;				\
+	popq	%r15;				\
+	popq	%rax;				\
+	popq	%fs;				\
+
+.macro dump_stack_regs PREFIX
+	movq	$LGUEST_REGS_size, %r10
+	xorq	%r11, %r11
+1:	PRINT_L(\PREFIX);
+	movq	%r11, %rbx;
+	PRINT_NUM_BX;
+	PRINT_L(':'); PRINT_L(' ');
+	movq	%rsp, %r9
+	addq	%r11, %r9
+	PRINT_QUAD((%r9))
+	addq	$8, %r11
+	cmp	%r11, %r10
+	ja	1b
+.endm
+
+.macro debugme VCPU C
+	testb	$1,LGUEST_VCPU_debug(\VCPU)
+	jz	23f
+	PRINT_L(\C)
+23:
+.endm
+
+
+#if 0
+.global hcall_teste
+	.type hcall_teste, @function
+hcall_teste:
+	cmpq	$0, %gs:pda_vcpu
+	jne	handle_guest
+	jmp	*host_syscall
+handle_guest:
+	/* SAVE_REGS  maybe it is not the macro we want */
+	#cmpq	$__PAGE_OFFSET, %rcx;
+	jb	do_hypercall
+	movq	%gs:pda_vcpu, %rcx;
+	movq	LGUEST_VCPU_guest_syscall(%rcx), %rcx;
+#endif
+
+/**
+ * DECODE_IDT  parse a IDT descriptor to find the target.
+ *  @IDT     - The register that holds the IDT descriptor location
+ *  @IDTWORD - The word version of the IDT register
+ *	        (ie. IDT is %rax, then IDTWORD must be %ax)
+ *  @RESULT  - The regsiter to place the result.
+ *
+ * This clobbers both IDT and RESULT regs.
+ */
+.macro DECODE_IDT IDT IDTWORD RESULT
+	movzwq	(\IDT), \RESULT
+	movq	4(\IDT), \IDT
+	xorw	\IDTWORD, \IDTWORD
+	orq	\IDT, \RESULT
+.endm
+
+/**
+ * DECODE_SSEG  parse a System Segment descriptor to find the target.
+ *  @SEG       - The register that holds the Sys Seg descriptor location
+ *  @RESULT    - The regsiter to place the result.
+ *  @RW	       - The word version of the RESULT register
+ *  @RH	       - The high byte version of the RESULT register
+ *
+ * (ie. RESULT is %rax, then RW must be %ax and RH must be %ah)
+ *
+ * This clobbers both SEG and RESULT regs.
+ */
+/* Why does Intel need to make everything so darn complex! */
+.macro DECODE_SSEG SEG RESULT RW RH
+	movzbq	7(\SEG), \RESULT
+	shl	$16, \RESULT
+	movb	4(\SEG), \RH
+	shl	$8, \RESULT
+	movw	2(\SEG), \RW
+	movq	8(\SEG), \SEG
+	shlq	$32, \SEG
+	orq	\SEG, \RESULT
+.endm
+
+.global switch_to_guest
+	.type switch_to_guest, @function
+/* rdi holds the pointer to vcpu.
+ * Interrupts are off on entry   */
+switch_to_guest:
+	SAVE_REGS
+	/* save host stack */
+	movq	%rsp, LGUEST_VCPU_host_stack(%rdi)
+	/* put the guest's stack in */
+	movq	%rdi, %rsp
+	/* move the stack to point to guest regs */
+	addq	$LGUEST_VCPU_regs, %rsp
+	/* filling this pointer has the effect of signalizing we're
+	 * running guest code */
+	movq	%rdi, %gs:pda_vcpu
+
+	/* save this host's gdt and idt */
+	sgdt LGUEST_VCPU_host_gdt(%rdi)
+	sidt LGUEST_VCPU_host_idt(%rdi)
+
+	/* Save the gs base of the host (for nmi use) */
+	movl	$MSR_GS_BASE, %ecx
+	rdmsr
+	movq	%rax, LGUEST_VCPU_host_gs_a(%rdi)
+	movq	%rdx, LGUEST_VCPU_host_gs_d(%rdi)
+
+	/* Save the host proc gs pointer */
+	movl	$MSR_KERNEL_GS_BASE, %ecx
+	rdmsr
+	movq	%rax, LGUEST_VCPU_host_proc_gs_a(%rdi)
+	movq	%rdx, LGUEST_VCPU_host_proc_gs_d(%rdi)
+
+	/* save the hosts page tables */
+	movq %cr3, %rax
+	movq %rax, LGUEST_VCPU_host_cr3(%rdi)
+
+	/*
+	 * The NMI is a big PITA. There's no way to atomically load the
+	 * TSS and IDT, so we can't just switch to the guest TSS without
+	 * causing a race condition with  the NMI.
+	 * So we set up the host NMI stack in the guest TSS IST so that
+	 * in case we take an NMI after loading our TR register
+	 * but before we've updated the lidt, we still have a valid
+	 * stack for the host nmi handler to use.
+	 */
+	/* Load the guest gdt */
+	lgdt LGUEST_VCPU_gdt(%rdi)
+
+	/* Switch to guest's TSS (before loading the idt) */
+	movl	$(GDT_ENTRY_TSS*8), %ebx
+	ltr	%bx
+
+	/* Set host's TSS to available (clear byte 5 bit 2). */
+	movq	LGUEST_VCPU_host_gdt_ptr(%rdi), %rax
+	andb	$0xFD, (GDT_ENTRY_TSS*8+5)(%rax)
+
+	/* Now load the guest idt */
+	lidt LGUEST_VCPU_idt(%rdi)
+
+	/* Load the guest gs pointer */
+	movl	$MSR_KERNEL_GS_BASE, %ecx
+	movq	LGUEST_VCPU_guest_gs_a(%rdi), %rax
+	movq	LGUEST_VCPU_guest_gs_d(%rdi), %rdx
+	wrmsr
+
+	/* Flush the TLB */
+	movq	%cr4, %rax
+	movq	%rax, %rbx
+	andb	$~(1<<7), %al
+	movq	%rax, %cr4
+	movq	%rbx, %cr4
+
+	/* switch to the guests page tables */
+	popq %rax
+	movq %rax, %cr3
+
+	/* Now we swap gs to the guest gs base */
+	swapgs
+
+	/* restore guest registers */
+	RESTORE_REGS
+	/* skip trapnum and errorcode */
+	addq	$0x10, %rsp;
+	iretq
+
+.macro print_trap VCPU REG
+	movq	LGUEST_VCPU_trapnum(\VCPU), \REG
+	PRINT_QUAD(\REG)
+.endm
+
+#define SWITCH_TO_HOST							\
+	SAVE_REGS;							\
+	/* Save old pgdir */						\
+	movq	%cr3, %rax;						\
+	pushq	%rax;							\
+	/* Point rdi to the vcpu struct */				\
+	movq	%rsp, %rdi;						\
+	subq	$LGUEST_VCPU_regs, %rdi;				\
+	/* Load lguest ds segment for convenience. */			\
+	movq	$(__HV_DS), %rax;					\
+	movq	%rax, %ds;						\
+	/* Load the host page tables since that's where the gdt is */	\
+	movq    LGUEST_VCPU_host_cr3(%rdi), %rax;			\
+	movq    %rax, %cr3;						\
+	/* Switch to hosts gdt */					\
+	lgdt    LGUEST_VCPU_host_gdt(%rdi);				\
+	/* Set guest's TSS to available (clear byte 5 bit 2). */	\
+	movq    LGUEST_VCPU_vcpu(%rdi), %rax;				\
+	andb	$0xFD, (LGUEST_VCPU_gdt_table+GDT_ENTRY_TSS*8+5)(%rax);	\
+	/* Swap back to the host PDA */					\
+	swapgs;								\
+	/* Put back the host process gs as well */			\
+	movl  	$MSR_KERNEL_GS_BASE,%ecx;				\
+	movq    LGUEST_VCPU_host_proc_gs_a(%rdi), %rax;			\
+	movq    LGUEST_VCPU_host_proc_gs_d(%rdi), %rdx;			\
+	wrmsr;								\
+	/* With PDA back now switch to host idt */			\
+	lidt    LGUEST_VCPU_host_idt(%rdi);				\
+	/* Switch to host's TSS. */					\
+	movl	$(GDT_ENTRY_TSS*8), %eax;				\
+	ltr	%ax;							\
+	/* put flag down. We're in the host again */			\
+	movq	$0, %gs:pda_vcpu;					\
+	movq	LGUEST_VCPU_host_stack(%rdi), %rsp;			\
+	RESTORE_REGS;
+
+/* Return to run_guest_once. */
+return_to_host:
+	SWITCH_TO_HOST
+	iretq
+
+deliver_to_host:
+	SWITCH_TO_HOST
+decode_idt_and_jmp:
+	/* Decode IDT and jump to hosts' irq handler.  When that does iret, it
+	 * will return to run_guest_once.  This is a feature. */
+	/* We told gcc we'd clobber rdi and rax... */
+	movq	LGUEST_VCPU_trapnum(%rdi), %rdi
+	shl	$1, %rdi
+	leaq	(%rax,%rdi,8), %rdi
+	DECODE_IDT %rdi %di %rax
+	jmp	*%rax
+
+#define NMI_SWITCH_TO_HOST						\
+	/* Force switch to host, GDT, CR3, and both GS bases */		\
+	movl    $MSR_GS_BASE, %ecx;					\
+	movq    LGUEST_VCPU_host_gs_a(%rdi), %rax;			\
+	movq    LGUEST_VCPU_host_gs_d(%rdi), %rdx;			\
+	wrmsr;								\
+	movl    $MSR_KERNEL_GS_BASE, %ecx;				\
+	movq    LGUEST_VCPU_host_proc_gs_a(%rdi), %rax;			\
+	movq    LGUEST_VCPU_host_proc_gs_d(%rdi), %rdx;			\
+	wrmsr;								\
+	movq    LGUEST_VCPU_host_cr3(%rdi), %rax;			\
+	movq	%rax, %cr3;						\
+	lgdt    LGUEST_VCPU_host_gdt(%rdi);
+
+#if 0
+	/* Set host's TSS to available (clear byte 5 bit 2). */		\
+	movq	LGUEST_VCPU_host_gdt_ptr(%rdi), %rax;			\
+	andb	$0xFD, (GDT_ENTRY_TSS*8+5)(%rax);			\
+
+#endif
+
+/* Used by NMI only */
+/*
+ * The NMI is special because it uses its own stack, and needs to
+ * find the vcpu struct differently.
+ */
+nmi_trampoline:
+	/* nmi has it's own stack */
+	SAVE_REGS
+
+	/* save the cr3 */
+	movq     %cr3, %rax
+	pushq	 %rax
+
+	/* get the vcpu struct */
+	movq     %rsp, %rdi
+	subq     $LGUEST_VCPU_nmi_stack_end, %rdi
+	addq     $LGUEST_REGS_size, %rdi  /* compensate for saved regs */
+
+	/* compensate if our end pointer is not 16 bytes aligned */
+	movq	 $LGUEST_VCPU_nmi_stack_end, %rax
+	andq	 $0xf, %rax;
+	addq	 %rax, %rdi;
+
+#if 0 /* in case we want to see where the nmi hit */
+	movq	LGUEST_REGS_rip(%rsp), %r8
+	PRINT_L('R')
+	PRINT_QUAD(%r8)
+#endif
+
+	/*
+	 * All guest descriptors are above the HV text code (here!)
+	 * If we hit the suspected NMI race, our stack will be the host
+	 * kernel stack, and that is in lower address space than the HV.
+	 * So test to see if we are screwed. Don't do anything, but just
+	 * report it!
+	 */
+	call   1f
+1:
+	movq	0(%rsp), %rax /* put this RIP into rax */
+	/* If rsp >=3D rax; jmp */
+	cmpq	%rax, %rsp
+	jge	1f
+
+	PRINT_L('H'); PRINT_L('i'); PRINT_L('t'); PRINT_L(' ');
+	PRINT_L('N'); PRINT_L('M'); PRINT_L('I'); PRINT_L(' ');
+	PRINT_L('r'); PRINT_L('a'); PRINT_L('c');
+	PRINT_L('\n'); PRINT_L('\r');
+
+1:
+	/* put back the stack from the previous call */
+	addq   $8, %rsp
+
+	/*
+	 * If we take another NMI while saving, we need to start over
+	 * and try again. It's OK as long as we don't overwrite
+	 * the saved material.
+	 */
+	testq    $1,LGUEST_VCPU_nmi_sw(%rdi)
+	jnz      1f
+
+	/* Copy the saved regs */
+	cld
+	movq	%rdi,  %rbx   /* save off vcpu struct */
+	leaq	LGUEST_VCPU_nmi_regs(%rdi), %rdi
+	leaq	0(%rsp), %rsi
+	movq	$(LGUEST_REGS_size/8), %rcx
+	rep	movsq
+
+	movq	%rbx, %rdi  /* put back vcpu struct */
+
+	/* save the gs base and shadow */
+	movl	$MSR_GS_BASE, %ecx
+	rdmsr
+	movq	%rax, LGUEST_VCPU_nmi_gs_a(%rdi)
+	movq	%rdx, LGUEST_VCPU_nmi_gs_d(%rdi)
+
+	movl	$MSR_KERNEL_GS_BASE, %ecx
+	rdmsr
+	movq	%rax, LGUEST_VCPU_nmi_gs_shadow_a(%rdi)
+	movq	%rdx, LGUEST_VCPU_nmi_gs_shadow_d(%rdi)
+
+	/* save the gdt */
+	sgdt	LGUEST_VCPU_nmi_gdt(%rdi)
+
+	/* set the switch flag to prevent another nmi from saving over this */
+	movq   $1, LGUEST_VCPU_nmi_sw(%rdi)
+
+1:
+
+#if 0
+	S_PRINT_L('N')
+	S_PRINT_L('M')
+	S_PRINT_L('I')
+	S_PRINT_L(' ')
+	S_PRINT_L('l')
+	S_PRINT_L('g')
+	S_PRINT_L('u')
+	S_PRINT_L('e')
+	S_PRINT_L('s')
+	S_PRINT_L('t')
+	S_PRINT_L('\n')
+	S_PRINT_L('\r')
+#endif
+	NMI_SWITCH_TO_HOST
+
+	/* we want to come back here on the iret */
+	pushq  $__HV_DS
+	/* put the vcpu struct as our stack */
+	pushq %rdi
+	pushfq
+	pushq	$__HV_CS
+
+	movq    LGUEST_VCPU_host_idt_address(%rdi), %rax
+
+	/* Decode the location of the host NMI handler */
+	leaq   32(%rax), %rbx   /* NMI IDT entry */
+	DECODE_IDT %rbx %bx %rax
+
+	callq   *%rax
+
+	/*
+	 * Back from NMI, stack points to vcpu, and we can take
+	 * more NMIs at this point. That's OK, since we only
+	 * want to get to the original NMI interruption. We
+	 * just restart this restore process. Nested NMIs will
+	 * not destroy this data while the nmi_sw flag is set.
+	 */
+	movq    %rsp, %rdi
+
+	/* restore the cr3 */
+	addq   $(LGUEST_VCPU_nmi_regs), %rsp
+	popq   %rax
+	movq   %rax, %cr3
+
+	/* restore the gdt */
+	lgdt	LGUEST_VCPU_nmi_gdt(%rdi)
+
+#if 0 /* print magic */
+	movq	LGUEST_VCPU_magic(%rdi), %r8
+	movq	$(6*8), %r9
+1:	subq	$8, %r9
+	movq	%r9, %rcx
+	movq	%r8, %rbx
+	shr	%cl, %rbx
+	PRINT_OUT(%bl)
+	cmp	$0, %r9
+	jne	1b
+#endif
+
+	/* make both host and guest TSS available */
+#if 1
+	movq	LGUEST_VCPU_host_gdt_ptr(%rdi), %rax
+	andb	$0xFD, (GDT_ENTRY_TSS*8+5)(%rax)
+
+	andb	$0xFD, (LGUEST_VCPU_gdt_table+GDT_ENTRY_TSS*8+5)(%rdi)
+#endif
+
+#if 0
+	movl	$(GDT_ENTRY_TSS*8), %ebx
+	ltr	%bx
+#endif
+
+	/* restore the gs base and shadow */
+	movl   $MSR_GS_BASE, %ecx
+	movq   LGUEST_VCPU_nmi_gs_a(%rdi), %rax
+	movq   LGUEST_VCPU_nmi_gs_d(%rdi), %rdx
+	wrmsr
+
+	movl   $MSR_KERNEL_GS_BASE, %ecx
+	movq   LGUEST_VCPU_nmi_gs_shadow_a(%rdi), %rax
+	movq   LGUEST_VCPU_nmi_gs_shadow_d(%rdi), %rdx
+	wrmsr
+
+#if 0
+	PRINT_L('O')
+	PRINT_L('U')
+	PRINT_L('T')
+	PRINT_L('\n')
+	PRINT_L('\r')
+#endif
+
+#if 1
+	/* Flush the TLB */
+	movq	%cr4, %rax
+	movq	%rax, %rbx
+	andb	$~(1<<7), %al
+	movq	%rax, %cr4
+	movq	%rbx, %cr4
+#endif
+
+	RESTORE_REGS
+
+	/* skip trapnum and errcode */
+	addq	$0x10, %rsp
+
+	/*
+	 * Careful here, we can't modify any regs anymore
+	 * but we now have to zero out the nmi switch flag.
+	 * So all the work will be done by the stack pointer.
+	 */
+
+#define SW_OFFSET (LGUEST_VCPU_nmi_sw - \
+		   (LGUEST_VCPU_nmi_regs + LGUEST_REGS_rip))
+	 movq  $0, SW_OFFSET(%rsp)
+
+	 /* use iret to get back to where we were. */
+	 iretq;
+	 /* Whoo, all done! */
+
+do_crash:
+	SAVE_REGS
+	movq	%cr3, %rax;
+	pushq	%rax;
+	PRINT_L('C');PRINT_L('r');PRINT_L('a');PRINT_L('s');
+	PRINT_L('h');PRINT_L('i');PRINT_L('n');PRINT_L('g');
+	PRINT_L('\n');PRINT_L('\r');
+
+	dump_stack_regs 'S'
+
+	addq	$16, %rsp
+	sgdt	0(%rsp)
+	PRINT_L('G');PRINT_L('D');PRINT_L('T');PRINT_L('L');PRINT_L(':');PRINT_L(=
' ');
+	xorq	%r8, %r8
+	movw	(%rsp), %r8
+	PRINT_QUAD(%r8)
+	PRINT_L('G');PRINT_L('D');PRINT_L('T');PRINT_L('A');PRINT_L(':');PRINT_L(=
' ');
+	movq	2(%rsp), %r8
+	PRINT_QUAD(%r8)
+
+	PRINT_L('C');PRINT_L('S');PRINT_L(':');PRINT_L(' ');
+	movq	%cs, %rbx
+	PRINT_QUAD(%rbx)
+	movq	%cs, %rbx
+	andb	$(~3), %bl
+	addq	%rbx, %r8
+	movq	0(%r8), %r9
+	PRINT_L('S');PRINT_L('E');PRINT_L('G');PRINT_L(':');PRINT_L(' ');
+	PRINT_QUAD(%r9);
+	movq	$1, %r8;
+	shl	$47, %r8
+	andq	%r9, %r8
+	PRINT_L('P');PRINT_L(' ');PRINT_L(':');PRINT_L(' ');
+	PRINT_QUAD(%r8);
+	PRINT_L('D');PRINT_L('P');PRINT_L(':');PRINT_L(' ');
+	movq	$3, %r8;
+	shl	$45, %r8
+	andq	%r9, %r8
+	PRINT_QUAD(%r8);
+
+
+	/* just die! */
+2:
+	pause
+	jmp 2b
+
+
+/* Real hardware interrupts are delivered straight to the host.  Others
+   cause us to return to run_guest_once so it can decide what to do.  Note
+   that some of these are overridden by the guest to deliver directly, and
+   never enter here (see load_guest_idt_entry). */
+.macro IRQ_STUB N TARGET
+	.data; .quad 1f; .text; 1:
+ /* Make an error number for most traps, which don't have one. */
+/*  .if (\N <> 2) && (\N <> 8) && (\N < 10 || \N > 14) && (\N <> 17) */
+  .if (\N < 10 || \N > 14) && (\N <> 17)
+	pushq	$0
+ .endif
+	pushq	$\N
+	jmp	\TARGET
+	.align 8
+.endm
+
+.macro IRQ_STUBS FIRST LAST TARGET
+ irq=3D\FIRST
+ .rept \LAST-\FIRST+1
+	IRQ_STUB irq \TARGET
+  irq=3Dirq+1
+ .endr
+.endm
+
+/* We intercept every interrupt, because we may need to switch back to
+ * host.  Unfortunately we can't tell them apart except by entry
+ * point, so we need 256 entry points.
+ */
+irq_stubs:
+.data
+.global _lguest_default_idt_entries
+_lguest_default_idt_entries:
+.text
+	IRQ_STUBS 0 1 return_to_host		/* First two traps */
+	IRQ_STUB 2 nmi_trampoline	/* NMI */
+	IRQ_STUBS 3 7 return_to_host		/* Rest of traps */
+/*debug for now */
+	IRQ_STUB 8 do_crash			/* Double fault! */
+#if 1
+	IRQ_STUBS 9 31 return_to_host		/* Rest of traps */
+#else
+	IRQ_STUBS 9 12 return_to_host		/* Rest of traps */
+	IRQ_STUB 13 do_crash			/* GPF! */
+	IRQ_STUBS 14 31 return_to_host		/* Rest of traps */
+#endif
+	IRQ_STUBS 32 127 deliver_to_host	/* Real interrupts */
+	IRQ_STUB 128 return_to_host		/* System call (overridden) */
+	IRQ_STUBS 129 255 deliver_to_host	/* Other real interrupts */
+
+	.align PAGE_SIZE
+.global end_hyper_text
+	.type end_hyper_text, @function
+end_hyper_text:
+	nop
Index: work-pv/arch/x86_64/lguest/interrupts_and_traps.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/interrupts_and_traps.c
@@ -0,0 +1,292 @@
+#include <linux/uaccess.h>
+#include <asm/lguest.h>
+#include <asm/desc.h>
+#include <asm/hw_irq.h>
+#include "lguest.h"
+
+static void push_guest_stack(struct lguest_vcpu *vcpu,
+					u64 __user **gstack, u64 val)
+{
+	lhwrite_u64(vcpu, (u64)--(*gstack), val);
+}
+
+static u64 pop_guest_stack(struct lguest_vcpu *vcpu,
+			   u64 __user **gstack)
+{
+	return lhread_u64(vcpu, (u64)(*gstack)++);
+}
+
+void guest_iret(struct lguest_vcpu *vcpu)
+{
+	struct lguest_regs *regs =3D &vcpu->regs;
+	u64 __user *gstack;
+	u64 cs;
+
+	gstack =3D (u64 __user *)guest_pa(vcpu->guest, regs->rsp);
+
+	regs->rip =3D pop_guest_stack(vcpu, &gstack);
+	cs =3D pop_guest_stack(vcpu, &gstack);
+
+	/* FIXME: determine if we are going back to userland */
+
+	regs->rflags =3D pop_guest_stack(vcpu, &gstack);
+	/* FIXME: check if this is correct */
+
+	if (regs->rflags & 512)
+		put_user(512, &vcpu->guest->lguest_data->irq_enabled);
+
+	/* make sure interrupts are enabled */
+	regs->rflags |=3D 512;
+
+	regs->rsp =3D pop_guest_stack(vcpu, &gstack);
+	regs->ss =3D pop_guest_stack(vcpu, &gstack);
+
+	/* restore the rax reg, since it was used by the guest to do the hcall */
+	regs->rax =3D vcpu->rax;
+
+	return;
+}
+
+int reflect_trap(struct lguest_vcpu *vcpu, int trap_num, int has_err)
+{
+	struct lguest_regs *regs =3D &vcpu->regs;
+	u64 __user *gstack;
+	u64 rflags, irq_enable;
+	u64 offset;
+
+	if (!vcpu->interrupt[trap_num]) {
+		printk("Not yet registered trap handler for %d\n",trap_num);
+		return 0;
+	}
+
+	/* save off the rax reg */
+	vcpu->rax =3D regs->rax;
+
+	/* FIXME: test for ring change and set up vcpu->tss.rsp2 ? */
+	gstack =3D (u64 __user *)guest_pa(vcpu->guest, regs->rsp);
+	offset =3D regs->rsp - (u64)gstack;
+
+	/* We use IF bit in eflags to indicate whether irqs were disabled
+	   (it's always 0, since irqs are enabled when guest is running). */
+	get_user(irq_enable, &vcpu->guest->lguest_data->irq_enabled);
+	rflags =3D regs->rflags;
+	rflags |=3D (irq_enable & 512);
+
+	/* FIXME: Really? */
+	push_guest_stack(vcpu, &gstack, regs->ss);
+	push_guest_stack(vcpu, &gstack, regs->rsp);
+	push_guest_stack(vcpu, &gstack, rflags);
+	/* FIXME: determine if guest is in kernel or user mode */
+	push_guest_stack(vcpu, &gstack, __KERNEL_CS);
+	push_guest_stack(vcpu, &gstack, regs->rip);
+
+	if (has_err)
+		push_guest_stack(vcpu, &gstack, regs->errcode);
+
+	/* Change the real stack so hypervisor returns to trap handler */
+	regs->ss =3D __USER_DS;
+	regs->rsp =3D (u64)gstack + offset;
+	regs->cs =3D __USER_CS;
+	lgdebug_print("rip was at %p\n", (void*)regs->rip);
+	regs->rip =3D vcpu->interrupt[trap_num];
+
+	/* Disable interrupts for an interrupt gate. */
+	if (test_bit(trap_num, vcpu->interrupt_disabled))
+		put_user(0, &vcpu->guest->lguest_data->irq_enabled);
+	return 1;
+#if 0
+	/* Was ist da? */
+	/* GS will be neutered on way back to guest. */
+	put_user(0, &lg->lguest_data->gs_gpf_eip);
+#endif
+	return 0;
+}
+
+void maybe_do_interrupt(struct lguest_vcpu *vcpu)
+{
+	unsigned int irq;
+	DECLARE_BITMAP(irqs, LGUEST_IRQS);
+
+	if (!vcpu->guest->lguest_data)
+		return;
+
+	/* If timer has changed, set timer interrupt. */
+	if (vcpu->guest->timer_on && jiffies !=3D vcpu->guest->last_timer)
+		set_bit(0, vcpu->irqs_pending);
+
+	/* Mask out any interrupts they have blocked. */
+	if (copy_from_user(&irqs, vcpu->guest->lguest_data->interrupts,
+								sizeof(irqs)))
+		return;
+
+	bitmap_andnot(irqs, vcpu->irqs_pending, irqs, LGUEST_IRQS);
+
+	irq =3D find_first_bit(irqs, LGUEST_IRQS);
+	if (irq >=3D LGUEST_IRQS)
+		return;
+
+	/* If they're halted, we re-enable interrupts. */
+	if (vcpu->guest->halted) {
+		/* Re-enable interrupts. */
+		put_user(512, &vcpu->guest->lguest_data->irq_enabled);
+		vcpu->guest->halted =3D 0;
+	} else {
+		/* Maybe they have interrupts disabled? */
+		u32 irq_enabled;
+		get_user(irq_enabled, &vcpu->guest->lguest_data->irq_enabled);
+		if (!irq_enabled) {
+			lgdebug_print("Irqs are disabled\n");
+			return;
+		}
+	}
+
+	if (vcpu->interrupt[irq + FIRST_EXTERNAL_VECTOR] !=3D 0) {
+		lgdebug_print("Reflect trap: %x\n",irq+FIRST_EXTERNAL_VECTOR);
+		clear_bit(irq, vcpu->irqs_pending);
+		reflect_trap(vcpu, irq+FIRST_EXTERNAL_VECTOR, 0);
+	}
+	else {
+		lgdebug_print("out without doing it!!\n");
+	}
+
+}
+
+void check_bug_kill(struct lguest_vcpu *vcpu)
+{
+/* FIXME: Use rostedt magic kallsyms */
+#if 0
+#ifdef CONFIG_BUG
+	u32 eip =3D lg->state->regs.rip - PAGE_OFFSET;
+	u16 insn;
+
+	/* This only works for addresses in linear mapping... */
+	if (lg->state->regs.rip < PAGE_OFFSET)
+		return;
+	lhread(lg, &insn, eip, sizeof(insn));
+	if (insn =3D=3D 0x0b0f) {
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+		u16 l;
+		u32 f;
+		char file[128];
+		lhread(lg, &l, eip+sizeof(insn), sizeof(l));
+		lhread(lg, &f, eip+sizeof(insn)+sizeof(l), sizeof(f));
+		lhread(lg, file, f - PAGE_OFFSET, sizeof(file));
+		file[sizeof(file)-1] =3D 0;
+		kill_guest(lg, "BUG() at %#x %s:%u", eip, file, l);
+#else
+		kill_guest(lg, "BUG() at %#x", eip);
+#endif	/* CONFIG_DEBUG_BUGVERBOSE */
+	}
+#endif	/* CONFIG_BUG */
+#endif
+}
+
+static void copy_trap(struct lguest_vcpu *vcpu,
+		      unsigned int trap_num,
+		      const struct gate_struct *desc)
+{
+
+	/* Not present? */
+	if (!desc->p) {
+		vcpu->interrupt[trap_num] =3D 0;
+		return;
+	}
+
+	switch (desc->type) {
+		case 0xE:
+			set_bit(trap_num,vcpu->interrupt_disabled);
+			break;
+		case 0xF:
+			clear_bit(trap_num,vcpu->interrupt_disabled);
+			break;
+		default:
+			kill_guest(vcpu->guest, "bad IDT type %i for irq %x",
+				desc->type,trap_num);
+	}
+
+	vcpu->interrupt[trap_num] =3D GATE_ADDRESS((*desc));
+}
+
+#if 0
+
+/* FIXME: Put this in hypervisor.S and do something clever with relocs? */
+static u8 tramp[]
+=3D { 0x0f, 0xa8, 0x0f, 0xa9, /* push %gs; pop %gs */
+    0x36, 0xc7, 0x05, 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x00, 0x00,
+    /* movl 0, %ss:lguest_data.gs_gpf_eip */
+    0xe9, 0x55, 0x55, 0x55, 0x55 /* jmp dstaddr */
+};
+#define TRAMP_MOVL_TARGET_OFF 7
+#define TRAMP_JMP_TARGET_OFF 16
+
+static u32 setup_trampoline(struct lguest *lg, unsigned int i, u32 dstaddr)
+{
+	u32 addr, off;
+
+	off =3D sizeof(tramp)*i;
+	memcpy(lg->trap_page + off, tramp, sizeof(tramp));
+
+	/* 0 is to be placed in lguest_data.gs_gpf_eip. */
+	addr =3D (u32)&lg->lguest_data->gs_gpf_eip + lg->page_offset;
+	memcpy(lg->trap_page + off + TRAMP_MOVL_TARGET_OFF, &addr, 4);
+
+	/* Address is relative to where end of jmp will be. */
+	addr =3D dstaddr - ((-4*1024*1024) + off + sizeof(tramp));
+	memcpy(lg->trap_page + off + TRAMP_JMP_TARGET_OFF, &addr, 4);
+	return (-4*1024*1024) + off;
+}
+
+#endif
+/* We bounce through the trap page, for two reasons: firstly, we need
+   the interrupt destination always mapped, to avoid double faults,
+   secondly we want to reload %gs to make it innocuous on entering kernel.
+ */
+/* guest kernel will not be mapped. we'd better do another schema */
+static void setup_idt(struct lguest_vcpu *vcpu,
+		      unsigned int i,
+		      const struct gate_struct *desc)
+{
+	u64 taddr;
+
+	/* Not present? */
+	if (!desc->p) {
+		/* FIXME: When we need this, we'll know... */
+		if (vcpu->idt_table[i].p)
+			kill_guest(vcpu->guest, "trying to remove irq line %i:"
+					"removing interrupts not supported",i);
+		return;
+	}
+
+#if 0
+	/* We could reflect and disable interrupts, but guest can do itself. */
+	if (desc->type !=3D 0xF)
+		kill_guest(vcpu->guest, "bad direct IDT %i type 0x%x",
+								i, desc->type);
+#endif
+
+	/* FIXME: We may need to fix segment? */
+	_lguest_set_gate(&vcpu->idt_table[i], desc->type, GUEST_DPL, taddr, 0);
+#if 0
+	taddr =3D setup_trampoline(lg, i, (desc->a&0xFFFF)|(desc->b&0xFFFF0000));
+#endif
+}
+
+void load_guest_idt_entry(struct lguest_vcpu *vcpu, unsigned int i,
+				struct gate_struct *d)
+{
+	switch (i) {
+	/* Ignore NMI, doublefault, hypercall, spurious interrupt. */
+	case 2:
+	case 8:
+	case 14:
+	case 15:
+	case LGUEST_TRAP_ENTRY:
+	/* FIXME: We should handle debug and int3 */
+	case 1:
+	case 3:
+		return;
+	default:
+		copy_trap(vcpu,i,d);
+	}
+}
+
Index: work-pv/arch/x86_64/lguest/lguest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/lguest.c
@@ -0,0 +1,705 @@
+/*
+ * Lguest specific paravirt-ops implementation
+ *
+ * Copyright (C) 2007, Glauber de Oliveira Costa <gcosta@redhat.com>
+ *                     Steven Rostedt <srostedt@redhat.com>
+ *                     Red Hat Inc
+ * Standing on the shoulders of Rusty Russell.
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
+#include <linux/pfn.h>
+#include <asm/bootsetup.h>
+#include <asm/paravirt.h>
+#include <asm/lguest.h>
+#include <asm/lguest_user.h>
+#include <asm/param.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/desc.h>
+#include <asm/setup.h>
+#include <asm/e820.h>
+#include <asm/pda.h>
+#include <asm/asm-offsets.h>
+#include <asm/mce.h>
+#include <asm/proto.h>
+#include <asm/sections.h>
+
+struct lguest_data lguest_data;
+struct lguest_device_desc *lguest_devices;
+static __initdata const struct lguest_boot_info *boot =3D (void*)__START_K=
ERNEL_map;
+static struct lguest_text_ptr code_stack[2];
+extern int acpi_disabled;
+extern int acpi_ht;
+
+extern const unsigned long kallsyms_addresses[] __attribute__((weak));
+extern const unsigned long kallsyms_num_syms __attribute__((weak));
+extern const u8 kallsyms_names[] __attribute__((weak));
+extern const u8 kallsyms_token_table[] __attribute__((weak));
+extern const u16 kallsyms_token_index[] __attribute__((weak));
+extern const unsigned long kallsyms_markers[] __attribute__((weak));
+
+static DEFINE_SPINLOCK(hcall_print_lock);
+#define HCALL_BUFF_SIZ 1024
+static char hcall_buff[HCALL_BUFF_SIZ];
+
+/* Set to true when the lguest_init is called. */
+static int lguest_paravirt;
+
+struct lguest_print_ops {
+	void (*vprint)(const char *fmt, va_list ap);
+} *lguest_pops;
+
+void lguest_vprint(const char *fmt, va_list ap)
+{
+	if (lguest_pops)
+		lguest_pops->vprint(fmt, ap);
+}
+
+void lguest_print(const char *fmt, ...)
+{
+	va_list ap;
+
+	/* irq save? */
+	va_start(ap, fmt);
+	lguest_vprint(fmt, ap);
+	va_end(ap);
+}
+
+static void __lguest_vprint(const char *fmt, va_list ap)
+{
+	/* need to do this with interrupts disabled */
+//	spin_lock(&hcall_print_lock);
+	vsnprintf(hcall_buff, HCALL_BUFF_SIZ-1, fmt, ap);
+
+	hcall(LHCALL_PRINT, __pa(hcall_buff), 0, 0);
+//	spin_unlock(&hcall_print_lock);
+}
+
+struct lguest_print_ops local_pops =3D {__lguest_vprint };
+
+void lguest_set_debug(int d)
+{
+	if (lguest_paravirt)
+		hcall(LHCALL_DEBUG_ME, d, 0, 0);
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
+		wmb();
+		lguest_data.hcall_status[next_call] =3D 0;
+		if (++next_call =3D=3D LHCALL_RING_SIZE)
+			next_call =3D 0;
+	}
+	local_irq_restore(flags);
+}
+
+#ifdef PARAVIRT_LAZY_NONE 	/* Not in 2.6.20. */
+static int lazy_mode;
+static void lguest_lazy_mode(int mode)
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
+#else
+#define lazy_hcall hcall
+#endif
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
+	/* Linux i386 code expects bit 9 set. */
+	/* FIXME: Check if interrupt pending... */
+	lguest_data.irq_enabled =3D 512;
+}
+
+static void lguest_load_gdt(const struct desc_ptr *desc)
+{
+	/* Does nothing. HV should have done everything for us */
+}
+
+static void lguest_load_idt(const struct desc_ptr *desc)
+{
+	unsigned int i;
+	struct gate_struct *idt =3D (void *)desc->address;
+
+	for (i =3D 0; i < (desc->size+1)/16; i++) {
+		hcall(LHCALL_LOAD_IDT_ENTRY, i, __pa((u64)&idt[i]), 0);
+	}
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
+static void lguest_memory_setup(void)
+{
+	/* We do this here because lockcheck barfs if before start_kernel */
+	atomic_notifier_chain_register(&panic_notifier_list, &paniced);
+
+	e820.nr_map =3D 0;
+	add_memory_region(0, PFN_PHYS(boot->max_pfn), E820_RAM);
+}
+
+static void lguest_cpuid(unsigned int *eax, unsigned int *ebx,
+				 unsigned int *ecx, unsigned int *edx)
+{
+	int is_feature =3D (*eax =3D=3D 1);
+
+	native_cpuid(eax, ebx, ecx, edx);
+	if (is_feature) {
+		unsigned long *excap =3D (unsigned long *)ecx,
+			*features =3D (unsigned long *)edx;
+		/* Hypervisor needs to know when we flush kernel pages. */
+		set_bit(X86_FEATURE_PGE, features);
+		/* We don't have any features! */
+		clear_bit(X86_FEATURE_VME, features);
+		clear_bit(X86_FEATURE_DE, features);
+		clear_bit(X86_FEATURE_PSE, features);
+		clear_bit(X86_FEATURE_PAE, features);
+		clear_bit(X86_FEATURE_SEP, features);
+		clear_bit(X86_FEATURE_APIC, features);
+		clear_bit(X86_FEATURE_MTRR, features);
+		/* No MWAIT, either */
+		clear_bit(3, excap);
+	}
+}
+
+static unsigned long current_cr3;
+static void lguest_write_cr3(unsigned long cr3)
+{
+	hcall(LHCALL_NEW_PGTABLE, cr3, 0, 0);
+	current_cr3 =3D cr3;
+}
+
+static u64 lguest_read_msr(unsigned int msr, int *err)
+{
+	unsigned long val;
+
+	*err =3D 0;
+	hcall(LHCALL_RDMSR, msr, __pa(&val), 0);
+	return val;
+}
+
+static int lguest_write_msr(unsigned int msr, u64 val)
+{
+	hcall(LHCALL_WRMSR, msr, (unsigned long)val, 0);
+	return val;
+}
+
+static u64 lguest_read_tsc(void)
+{
+	/* we don't use natives, otherwise they can recurse */
+	unsigned int a,b;
+	asm volatile("rdtsc" : "=3Da" (a), "=3Dd" (b));
+	return a | (unsigned long)(b) << 32 ;
+}
+
+static void lguest_flush_tlb(void)
+{
+	lazy_hcall(LHCALL_FLUSH_TLB, 0, 0, 0);
+}
+
+static void lguest_flush_tlb_kernel(void)
+{
+	lazy_hcall(LHCALL_FLUSH_TLB, 1, 0, 0);
+}
+
+static void lguest_flush_tlb_single(u64 addr)
+{
+	lazy_hcall(LHCALL_FLUSH_TLB_SIG, current_cr3, addr, 0);
+}
+
+static void lguest_set_pte(pte_t *ptep, pte_t pteval)
+{
+	*ptep =3D pteval;
+	hcall(LHCALL_SET_PTE, current_cr3, __pa(ptep), pte_val(pteval));
+}
+
+static void lguest_set_pte_at(struct mm_struct *mm, u64 addr, pte_t *ptep,=
 pte_t pteval)
+{
+	*ptep =3D pteval;
+	lazy_hcall(LHCALL_SET_PTE, __pa(mm->pgd), __pa(ptep), pte_val(pteval));
+}
+
+static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+	*pmdp =3D pmdval;
+	lazy_hcall(LHCALL_SET_PMD, current_cr3, __pa(pmdp)&PTE_MASK,
+		   (__pa(pmdp)&(PAGE_SIZE-1))/8);
+}
+
+static void lguest_set_pud(pud_t *pudp, pud_t pudval)
+{
+	*pudp =3D pudval;
+	lazy_hcall(LHCALL_SET_PUD, current_cr3, __pa(pudp)&PTE_MASK,
+		   (__pa(pudp)&(PAGE_SIZE-1))/8);
+}
+
+static void lguest_set_pgd(pgd_t *pgdp, pgd_t pgdval)
+{
+	*pgdp =3D pgdval;
+	lazy_hcall(LHCALL_SET_PGD, current_cr3, __pa(pgdp)&PTE_MASK,
+		   (__pa(pgdp)&(PAGE_SIZE-1))/8);
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+static void lguest_apic_write(unsigned long reg, unsigned int v)
+{
+}
+
+static unsigned int lguest_apic_read(unsigned long reg)
+{
+	return 0;
+}
+#endif
+
+#if 0
+/* We move eflags word to lguest_data.irq_enabled to restore interrupt
+   state.  For page faults, gpfs and virtual interrupts, the
+   hypervisor has saved eflags manually, otherwise it was delivered
+   directly and so eflags reflects the real machine IF state,
+   ie. interrupts on.  Since the kernel always dies if it takes such a
+   trap with interrupts disabled anyway, turning interrupts back on
+   unconditionally here is OK. */
+asm("lguest_iret:"
+    " pushq	%rax;"
+    " movq	0x18(%rsp), %rax;"
+    "lguest_noirq_start:;"
+    " movq	%rax, lguest_data+"__stringify(LGUEST_DATA_irq_enabled)";"
+    " popq	%rax;"
+    " iretq;"
+    "lguest_noirq_end:");
+extern char lguest_noirq_start[], lguest_noirq_end[];
+#endif
+
+extern void lguest_iret(void);
+asm("lguest_iret:"
+    "  movq  $" __stringify(LHCALL_IRET) ", %rax\n"
+    "  int   $" __stringify(LGUEST_TRAP_ENTRY) );
+
+
+static void lguest_load_rsp0(struct tss_struct *tss,
+				     struct thread_struct *thread)
+{
+	lazy_hcall(LHCALL_SET_STACK, thread->rsp0, THREAD_SIZE/PAGE_SIZE, 0);
+}
+
+static void lguest_load_tr_desc(void)
+{
+}
+
+static void lguest_set_ldt(const void *addr, unsigned entries)
+{
+	/* FIXME: Implement. */
+	BUG_ON(entries);
+}
+
+static void lguest_load_tls(struct thread_struct *t, unsigned int cpu)
+{
+	lazy_hcall(LHCALL_LOAD_TLS, __pa(&t->tls_array), cpu, 0);
+}
+
+static void lguest_set_debugreg(int regno, unsigned long value)
+{
+	/* FIXME: Implement */
+}
+
+static unsigned int lguest_cr0;
+static void lguest_clts(void)
+{
+	lazy_hcall(LHCALL_TS, 0, 0, 0);
+	lguest_cr0 &=3D ~8U;
+}
+
+static unsigned long lguest_read_cr0(void)
+{
+	return lguest_cr0;
+}
+
+static void lguest_write_cr0(unsigned long val)
+{
+	hcall(LHCALL_TS, val & 8, 0, 0);
+	lguest_cr0 =3D val;
+}
+
+static unsigned long lguest_read_cr2(void)
+{
+	return lguest_data.cr2;
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
+static void lguest_time_irq(unsigned int irq, struct irq_desc *desc)
+{
+	do_timer(hcall(LHCALL_TIMER_READ, 0, 0, 0));
+	update_process_times(user_mode_vm(get_irq_regs()));
+}
+
+static void disable_lguest_irq(unsigned int irq)
+{
+	set_bit(irq, lguest_data.interrupts);
+}
+
+static void enable_lguest_irq(unsigned int irq)
+{
+	clear_bit(irq, lguest_data.interrupts);
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
+static void lguest_time_init(void)
+{
+	set_irq_handler(0, lguest_time_irq);
+	hcall(LHCALL_TIMER_START,HZ,0,0);
+}
+
+static void lguest_ebda_info(unsigned *addr, unsigned *size)
+{
+	*addr =3D *size =3D 0;
+}
+
+/* From i8259.c */
+extern void (*interrupt[])(void);
+static void __init lguest_init_IRQ(void)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < LGUEST_IRQS; i++) {
+		int vector =3D FIRST_EXTERNAL_VECTOR + i;
+		if (i >=3D NR_IRQS)
+			break;
+		/* FIXTHEM: We should be doing it in a lot of other places */
+		if (vector !=3D IA32_SYSCALL_VECTOR) {
+			printk("Setting vector %x as %p\n",vector, &interrupt[i]);
+			set_intr_gate(vector, interrupt[i]);
+			set_irq_chip_and_handler(i, &lguest_irq_controller,
+							 handle_level_irq);
+			hcall(LHCALL_LOAD_IDT_ENTRY, vector, __pa((u64)&idt_table[vector]), 0);
+		}
+	}
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
+static void lguest_write_ldt_entry(void *dt, int entrynum, u32 low, u32 hi=
gh)
+{
+	/* FIXME: Allow this. */
+	BUG();
+}
+
+static void lguest_write_gdt_entry(void *dt, int entrynum,
+					   u32 low, u32 high)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+	hcall(LHCALL_LOAD_GDT, __pa(dt), GDT_ENTRIES, 0);
+}
+
+static void lguest_write_idt_entry(void *dt, int entrynum,
+					   u32 low, u32 high)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+	hcall(LHCALL_CRASH, 0, 0 ,0);
+	hcall(LHCALL_LOAD_IDT_ENTRY, entrynum, low, high);
+}
+
+#define LGUEST_IRQ "lguest_data+"__stringify(LGUEST_DATA_irq_enabled)
+#define DEF_LGUEST(name, code)				\
+	extern const char start_##name[], end_##name[];		\
+	asm("start_" #name ": " code "; end_" #name ":")
+DEF_LGUEST(cli, "movl $0," LGUEST_IRQ);
+DEF_LGUEST(sti, "movl $512," LGUEST_IRQ);
+DEF_LGUEST(popf, "movl %eax," LGUEST_IRQ);
+DEF_LGUEST(pushf, "movl " LGUEST_IRQ ",%eax");
+DEF_LGUEST(pushf_cli, "movl " LGUEST_IRQ ",%eax; movl $0," LGUEST_IRQ);
+DEF_LGUEST(iret, ".byte 0xE9,0,0,0,0"); /* jmp ... */
+
+static const struct lguest_insns
+{
+	const char *start, *end;
+} lguest_insns[] =3D {
+	[PARAVIRT_IRQ_DISABLE] =3D { start_cli, end_cli },
+	[PARAVIRT_IRQ_ENABLE] =3D { start_sti, end_sti },
+	[PARAVIRT_RESTORE_FLAGS] =3D { start_popf, end_popf },
+	[PARAVIRT_SAVE_FLAGS] =3D { start_pushf, end_pushf },
+	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] =3D { start_pushf_cli, end_pushf_cli },
+	[PARAVIRT_INTERRUPT_RETURN] =3D { start_iret, end_iret },
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
+	if (type =3D=3D PARAVIRT_INTERRUPT_RETURN) {
+		/* Jumps are relative. */
+		u64 off =3D (u64)lguest_iret - ((u64)insns + insn_len);
+		memcpy(insns+1, &off, sizeof(off));
+	}
+	return insn_len;
+}
+
+static void lguest_safe_halt(void)
+{
+	hcall(LHCALL_HALT, 0, 0, 0);
+}
+
+static unsigned long lguest_get_wallclock(void)
+{
+	return hcall(LHCALL_GET_WALLCLOCK, 0, 0, 0);
+}
+
+static void lguest_power_off(void)
+{
+	hcall(LHCALL_CRASH, __pa("Power down"), 0, 0);
+}
+
+static void lguest_syscall_init(void)
+{
+	/* FIXME: Will have to implement it later */
+}
+
+static __attribute_used__ __init void lguest_init(void)
+{
+	int i;
+
+	current_cr3 =3D __pa(&boot_level4_pgt);
+	paravirt_ops.name =3D "lguest";
+	paravirt_ops.mem_type =3D "LGUEST";
+	paravirt_ops.paravirt_enabled =3D 1;
+	paravirt_ops.syscall_init =3D lguest_syscall_init;
+
+	paravirt_ops.save_fl =3D save_fl;
+	paravirt_ops.restore_fl =3D restore_fl;
+	paravirt_ops.irq_disable =3D irq_disable;
+	paravirt_ops.irq_enable =3D irq_enable;
+	paravirt_ops.load_gdt =3D lguest_load_gdt;
+	paravirt_ops.memory_setup =3D lguest_memory_setup;
+	paravirt_ops.cpuid =3D lguest_cpuid;
+	paravirt_ops.write_cr3 =3D lguest_write_cr3;
+	paravirt_ops.read_msr =3D lguest_read_msr,
+	paravirt_ops.write_msr =3D lguest_write_msr,
+	paravirt_ops.read_tsc =3D lguest_read_tsc,
+	paravirt_ops.flush_tlb_user =3D lguest_flush_tlb;
+	paravirt_ops.flush_tlb_single =3D lguest_flush_tlb_single;
+	paravirt_ops.flush_tlb_kernel =3D lguest_flush_tlb_kernel;
+	paravirt_ops.set_pte =3D lguest_set_pte;
+	paravirt_ops.set_pte_at =3D lguest_set_pte_at;
+	paravirt_ops.set_pmd =3D lguest_set_pmd;
+	paravirt_ops.set_pud =3D lguest_set_pud;
+	paravirt_ops.set_pgd =3D lguest_set_pgd;
+#ifdef CONFIG_X86_LOCAL_APIC
+	paravirt_ops.apic_write =3D lguest_apic_write;
+	paravirt_ops.apic_read =3D lguest_apic_read;
+#endif
+	paravirt_ops.load_idt =3D lguest_load_idt;
+	paravirt_ops.iret =3D lguest_iret;
+	paravirt_ops.load_rsp0 =3D lguest_load_rsp0;
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
+	paravirt_ops.write_ldt_entry =3D lguest_write_ldt_entry;
+	paravirt_ops.write_gdt_entry =3D lguest_write_gdt_entry;
+	paravirt_ops.write_idt_entry =3D lguest_write_idt_entry;
+	paravirt_ops.patch =3D lguest_patch;
+	paravirt_ops.safe_halt =3D lguest_safe_halt;
+	paravirt_ops.get_wallclock =3D lguest_get_wallclock;
+	paravirt_ops.time_init =3D lguest_time_init;
+#ifdef PARAVIRT_LAZY_NONE
+	paravirt_ops.set_lazy_mode =3D lguest_lazy_mode;
+#endif
+	paravirt_ops.ebda_info =3D lguest_ebda_info;
+
+	memset(lguest_data.hcall_status,0xFF,sizeof(lguest_data.hcall_status));
+#if 0
+	lguest_data.noirq_start =3D (u64)lguest_noirq_start;
+	lguest_data.noirq_end =3D (u64)lguest_noirq_end;
+#endif
+	lguest_data.start_kernel_map =3D __START_KERNEL_map; /* current page offs=
et */
+	lguest_data.page_offset =3D PAGE_OFFSET;
+
+	code_stack[0].next =3D __pa(&code_stack[1]);
+	code_stack[0].start =3D (unsigned long)_stext;
+	code_stack[0].end =3D (unsigned long)_etext;
+	code_stack[1].next =3D 0;
+	code_stack[1].start =3D (unsigned long)_sinittext;
+	code_stack[1].end =3D (unsigned long)_einittext;
+
+	lguest_data.text =3D __pa(&code_stack[0]);
+
+	lguest_data.kallsyms_addresses =3D __pa(&kallsyms_addresses);
+	lguest_data.kallsyms_num_syms =3D kallsyms_num_syms;
+	lguest_data.kallsyms_names =3D __pa(&kallsyms_names);
+	lguest_data.kallsyms_token_table =3D __pa(&kallsyms_token_table);
+	lguest_data.kallsyms_token_index =3D __pa(&kallsyms_token_index);
+	lguest_data.kallsyms_markers =3D __pa(&kallsyms_markers);
+
+	hcall(LHCALL_LGUEST_INIT, __pa(&lguest_data), 0, 0);
+
+	lguest_pops =3D &local_pops;
+	lguest_paravirt =3D 1;
+
+	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
+	lguest_write_cr3(__pa_symbol(&init_level4_pgt));
+
+ 	for (i =3D 0; i < NR_CPUS; i++)
+ 		cpu_pda(i) =3D &boot_cpu_pda[i];
+
+	pda_init(0);
+//	copy_bootdata(real_mode_data);
+#ifdef CONFIG_SMP
+	cpu_set(0, cpu_online_map);
+#endif
+
+//	strncpy(boot_command_line, boot->cmdline, COMMAND_LINE_SIZE);
+
+	/* We use top of mem for initial pagetables. */
+//	init_pg_tables_end =3D __pa(pg0);
+
+//	reserve_top_address(lguest_data.reserve_mem);
+
+	/* FIXME: Better way? */
+	/* Suppress vgacon startup code */
+	SCREEN_INFO.orig_video_isVGA =3D VIDEO_TYPE_VLFB;
+
+	add_preferred_console("hvc", 0, NULL);
+/*
+#ifdef CONFIG_X86_MCE
+	mcheck_disable(NULL);
+#endif
+*/
+#ifdef CONFIG_ACPI
+	acpi_disabled =3D 1;
+	acpi_ht =3D 0;
+#endif
+	if (boot->initrd_size) {
+		/* We stash this at top of memory. */
+		INITRD_START =3D boot->max_pfn*PAGE_SIZE - boot->initrd_size;
+		INITRD_SIZE =3D boot->initrd_size;
+		LOADER_TYPE =3D 0xFF;
+	}
+	pm_power_off =3D lguest_power_off;
+
+	start_kernel();
+}
+
+asm("lguest_maybe_init:\n"
+    "	cmpq $"__stringify(LGUEST_MAGIC_R13)", %r13\n"
+    "	jne 1f\n"
+    "	cmpq $"__stringify(LGUEST_MAGIC_R14)", %r14\n"
+    "	jne 1f\n"
+    "	cmpq $"__stringify(LGUEST_MAGIC_R15)", %r15\n"
+    "	je lguest_init\n"
+    "1: ret");
+
+extern void asmlinkage lguest_maybe_init(void);
+paravirt_probe(lguest_maybe_init);
Index: work-pv/arch/x86_64/lguest/lguest.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/lguest.h
@@ -0,0 +1,161 @@
+#ifndef _LGUEST_GUEST_H_
+#define _LGUEST_GUEST_H_
+
+#define GUEST_DPL 0x3
+
+#define gdt_index(x) ((x) >> 3)
+
+/*
+ * Must be less than fixmap!
+ *
+ * To keep the hypervisor from needing any data sections,
+ * we need to hard code the difference between what the hypervisor
+ * may put into the GS base, and what we let the guest put in.
+ * We allow the guest to put in "Kernel addresses" to simplify
+ * the guest PDA code.
+ */
+#define LGUEST_HV_OFFSET_HIGH 0xffffffff
+#define LGUEST_HV_OFFSET_LOW  0xff000000
+
+#define LGUEST_NMI_IST 7
+
+#define LGUEST_MAGIC 0x6c6775657374 /* "lguest" */
+
+#ifndef __ASSEMBLY__
+#include <asm/lguest.h>
+
+extern void switch_to_guest(struct lguest_vcpu *);
+extern unsigned long hcall_teste;
+extern unsigned long host_syscall;
+extern unsigned long _lguest_default_idt_entries[];
+extern unsigned long lguest_hv_addr;
+extern unsigned long lguest_hv_offset;
+extern int lguest_hv_pages;
+extern int lguest_vcpu_pages;
+extern int lguest_vcpu_order;
+extern struct mutex lguest_lock;
+
+/* FIXME: Those would live better in some main kernel header */
+/* Page fault error code bits */
+#define PF_PROT	(1<<0)		/* or no page found */
+#define PF_WRITE	(1<<1)
+#define PF_USER	(1<<2)
+#define PF_RSVD	(1<<3)
+#define PF_INSTR	(1<<4)
+
+#define kill_guest(guest, fmt...)				\
+do {								\
+	if (!(guest)->dead) {					\
+		(guest)->dead =3D kasprintf(GFP_ATOMIC, fmt);	\
+		if (!(guest)->dead)				\
+			(guest)->dead =3D (void *)-1;		\
+	}							\
+} while (0)
+
+#define kill_guest_dump(vcpu, fmt...)		\
+do {						\
+	kill_guest((vcpu)->guest, fmt);		\
+	lguest_dump_vcpu_regs(vcpu);		\
+}  while(0)
+
+static inline void _lguest_set_gate(struct gate_struct *s, unsigned type, =
unsigned long func,
+				    unsigned dpl, unsigned ist)
+{
+        s->offset_low =3D PTR_LOW(func);
+        s->segment =3D __HV_CS;
+        s->ist =3D ist;
+        s->p =3D 1;
+        s->dpl =3D dpl;
+        s->zero0 =3D 0;
+        s->zero1 =3D 0;
+        s->type =3D type;
+        s->offset_middle =3D PTR_MIDDLE(func);
+        s->offset_high =3D PTR_HIGH(func);
+}
+
+static inline unsigned long guest_pa(struct lguest_guest_info *linfo, u64 =
addr)
+{
+	return (addr >=3D linfo->start_kernel_map) ?
+		(addr - linfo->start_kernel_map) :
+		(addr - linfo->page_offset);
+}
+
+int lguest_address_ok(const struct lguest_guest_info *, u64);
+
+int demand_page(struct lguest_vcpu *, u64, int);
+/* FIXME: put this in hv_vm.h */
+unsigned long hvvm_get_actual_phys(void *addr, pgprot_t *prot);
+
+int lguest_device_init(void);
+void lguest_device_remove(void);
+
+/* page_tables.h */
+int lguest_map_hv_pages(struct lguest_guest_info *lguest,
+			   unsigned long vaddr, int pages,
+			   pgprot_t *prot);
+int lguest_map_guest_page(struct lguest_guest_info *lguest,
+			  unsigned long vaddr, unsigned long paddr,
+			  pgprot_t prot);
+void lguest_unmap_guest_pages(struct lguest_guest_info *lguest,
+			      unsigned long vaddr, int pages);
+void lguest_free_guest_pages(struct lguest_guest_info *lguest);
+
+void *lguest_mem_addr(struct lguest_vcpu *vcpu, u64 vaddr);
+
+void guest_set_pte(struct lguest_vcpu *vcpu,
+		   unsigned long cr3, unsigned long base,
+		   unsigned long idx);
+void guest_set_pmd(struct lguest_vcpu *vcpu,
+		   unsigned long cr3, unsigned long base,
+		   unsigned long val);
+void guest_set_pud(struct lguest_vcpu *vcpu,
+		   unsigned long cr3, unsigned long base,
+		   unsigned long val);
+void guest_set_pgd(struct lguest_vcpu *vcpu,
+		   unsigned long cr3, unsigned long base,
+		   unsigned long val);
+void guest_flush_tlb_single(struct lguest_vcpu *vcpu, u64 cr3, u64 vaddr);
+void guest_pagetable_clear_all(struct lguest_vcpu *vcpu);
+void guest_pagetable_flush_user(struct lguest_vcpu *vcpu);
+void guest_new_pagetable(struct lguest_vcpu *vcpu, u64 pgtable);
+
+int init_guest_pagetable(struct lguest_guest_info *linfo, u64 pgtable);
+int lguest_init_vcpu_pagetable(struct lguest_vcpu *vcpu);
+
+int hypercall(struct lguest_vcpu *vcpu);
+
+/* core.c */
+u8 lhread_u8(struct lguest_vcpu *vcpu, u64 addr);
+u16 lhread_u16(struct lguest_vcpu *vcpu, u64 addr);
+u64 lhread_u64(struct lguest_vcpu *vcpu, u64 addr);
+void lhwrite_u64(struct lguest_vcpu *vcpu, u64 addr, u64 val);
+
+void lhread(struct lguest_guest_info *, void *, u64, unsigned);
+void lhwrite(struct lguest_guest_info *, u64, const void *, unsigned);
+
+/* io.c */
+u32 bind_dma(struct lguest_guest_info *, unsigned long, unsigned long,
+					u16, u8);
+int send_dma(struct lguest_guest_info *, unsigned long, unsigned long);
+
+/* interrupts_and_traps.c */
+
+void load_guest_idt_entry(struct lguest_vcpu *, unsigned int,
+						struct gate_struct *);
+void maybe_do_interrupt(struct lguest_vcpu *);
+void guest_iret(struct lguest_vcpu *vcpu);
+int reflect_trap(struct lguest_vcpu *, int, int);
+
+/* lguest_debug.c */
+extern int lguest_debug;
+void lgdebug_print(const char *fmt, ...);
+void lgdebug_vprint(const char *fmt, va_list ap);
+void lguest_dump_vcpu_regs(struct lguest_vcpu *vcpu);
+void lguest_dump_trace(struct lguest_vcpu *vcpu, struct lguest_regs *regs);
+void lguest_print_address(struct lguest_vcpu *vcpu, unsigned long address);
+void lguest_print_page_tables(u64 *cr3);
+void lguest_print_guest_page_tables(struct lguest_vcpu *vcpu, u64 cr3);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif
Index: work-pv/arch/x86_64/lguest/lguest_user.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/lguest_user.c
@@ -0,0 +1,436 @@
+/* Userspace control of the guest, via /dev/lguest. */
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <asm/lguest_user.h>
+#include <asm/hv_vm.h>
+#include "lguest.h"
+
+static int next_guest_id;
+
+#if 0
+/* + addr */
+static long user_get_dma(struct lguest *lg, const u32 __user *input)
+{
+	unsigned long addr, udma, irq;
+
+	if (get_user(addr, input) !=3D 0)
+		return -EFAULT;
+	udma =3D get_dma_buffer(lg, addr, &irq);
+	if (!udma)
+		return -ENOENT;
+
+	/* We put irq number in udma->used_len. */
+	lhwrite_u32(lg, udma + offsetof(struct lguest_dma, used_len), irq);
+	return udma;
+}
+
+/* + irq */
+static int user_send_irq(struct lguest *lg, const u32 __user *input)
+{
+	u32 irq;
+
+	if (get_user(irq, input) !=3D 0)
+		return -EFAULT;
+	if (irq >=3D LGUEST_IRQS)
+		return -EINVAL;
+	set_bit(irq, lg->irqs_pending);
+	return 0;
+}
+#endif
+
+static ssize_t read(struct file *file, char __user *user, size_t size,loff=
_t*o)
+{
+	struct lguest_vcpu *vcpu =3D file->private_data;
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	int ret;
+
+	if (!vcpu)
+		return -EINVAL;
+
+	if (linfo->dead) {
+		size_t len;
+
+		if (linfo->dead =3D=3D (void *)-1)
+			return -ENOMEM;
+
+		len =3D min(size, strlen(linfo->dead)+1);
+		if (copy_to_user(user, linfo->dead, len) !=3D 0)
+			return -EFAULT;
+		return len;
+	}
+
+#if 0
+	if (lg->dma_is_pending)
+		lg->dma_is_pending =3D 0;
+#endif
+
+	ret =3D run_guest(vcpu, user);
+	if (ret !=3D -EINTR)
+		ret =3D -ENOENT;
+	return ret;
+}
+
+struct lguest_vcpu *allocate_vcpu(struct lguest_guest_info *linfo)
+{
+	struct lguest_vcpu *vcpu;
+	unsigned long hv_vcpu;
+	int ret;
+
+	vcpu =3D (void*)__get_free_pages(GFP_KERNEL, lguest_vcpu_order);
+	if (!vcpu)
+		return NULL;
+	memset(vcpu, 0, sizeof(*vcpu));
+
+	ret =3D hvvm_map_pages(vcpu, lguest_vcpu_pages, &hv_vcpu);
+	if (ret < 0)
+		goto out;
+
+	ret =3D lguest_map_hv_pages(linfo, hv_vcpu, lguest_vcpu_pages, NULL);
+	if (ret < 0)
+		goto out2;
+
+	vcpu->host_page =3D (unsigned long)vcpu;
+
+	return (struct lguest_vcpu*)hv_vcpu;
+
+out2:
+	hvvm_unmap_pages(hv_vcpu, lguest_vcpu_pages);
+out:
+	free_pages((unsigned long)vcpu, lguest_vcpu_order);
+
+	return NULL;
+}
+
+void free_vcpu(struct lguest_guest_info *linfo, struct lguest_vcpu *vcpu)
+{
+	unsigned long hv_vcpu =3D (unsigned long)vcpu;
+	free_pages(vcpu->host_page, lguest_vcpu_order);
+	lguest_unmap_guest_pages(linfo, hv_vcpu, lguest_vcpu_pages);
+	hvvm_unmap_pages(hv_vcpu, lguest_vcpu_pages);
+	lguest_free_guest_pages(linfo);
+}
+
+#if 0
+static void print_tss(struct ldttss_desc *tss)
+{
+	u64 base;
+	u64 limit;
+	int i;
+	u16 iobp =3D 0x64;
+
+	base =3D (tss->base0) + ((u64)tss->base1 << 16) +
+		((u64)tss->base2 << 24) + ((u64)tss->base3 << 32);
+	limit =3D (tss->limit0) + ((u64)tss->limit1 << 16);
+	if (tss->g)
+		limit <<=3D 12;
+	printk("    base: %016llx\n", base);
+	printk("   limit: %llx\n", limit);
+	printk("    type: %x\n", tss->type);
+	printk("     dpl: %d\n", tss->dpl);
+	printk("       p: %d\n", tss->p);
+	printk("       g: %d\n", tss->g);
+
+	for (i=3D0; i < limit; i +=3D 4) {
+		printk("   %8x: %08x\n", i, *(u32*)(base+i));
+		if (i =3D=3D 0x64) {
+			iobp =3D (u16)((*(u32*)(base+i))>>16);
+		}
+		if (i >=3D iobp && *(s32*)(base+i) =3D=3D -1L)
+			break;
+	}
+}
+#endif
+
+/* should be in some other file ? */
+int vcpu_start(int cpu, struct lguest_guest_info *linfo,
+				unsigned long entry_point,
+				void *pgd)
+{
+	struct lguest_vcpu *vcpu;
+	struct desc_struct *gdt_table;
+	struct lguest_regs *regs;
+	struct ldttss_desc *tss;
+	struct lguest_tss_struct *tss_ptr;
+	u64 target;
+	u64 limit;
+	u64 base;
+	int i;
+
+	if (cpu > LGUEST_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu =3D allocate_vcpu(linfo);
+	if (!vcpu)
+		return -ENOMEM;
+
+	printk("vcpu: %p\n", vcpu);
+
+	/*
+	 * Point back to itself to make it easier to read from gs:base in
+	 * hypervisor.S
+	 */
+	vcpu->vcpu =3D vcpu;
+	vcpu->magic =3D LGUEST_MAGIC;
+	gdt_table =3D cpu_gdt(get_cpu());
+	put_cpu();
+
+	/* Our gdt is basically host's, except for the privilege level */
+	for (i =3D 0; i < GDT_ENTRIES; i++) {
+		vcpu->gdt_table[i] =3D gdt_table[i];
+
+		if (!gdt_table[i].type)
+			continue;
+
+		switch (i) {
+		/* Keep TSS, and HV, and Host KERNEL segments the same */
+		case GDT_ENTRY_TSS:
+			/* The TSS will be modified below */
+		case GDT_ENTRY_HV_CS:
+		case GDT_ENTRY_HV_DS:
+		case __KERNEL_CS >> 3:
+		case __KERNEL_DS >> 3:
+			break;
+		default:
+			vcpu->gdt_table[i].dpl =3D GUEST_DPL;
+		}
+	}
+
+	for (i =3D 0; i < IDT_ENTRIES; i++) {
+		unsigned dpl =3D i =3D=3D LGUEST_TRAP_ENTRY ? GUEST_DPL : 0;
+		/* NMI gets its own stack */
+		int ist =3D (i =3D=3D 2) ? LGUEST_NMI_IST :
+			/* temp debug for now */
+			(i =3D=3D 8) ? 6 :   /* Double Fault */
+//			(i =3D=3D 13) ? 5 :  /* GPF */
+			0;
+
+		_lguest_set_gate(&vcpu->idt_table[i], 0xe,
+				 _lguest_default_idt_entries[i] +
+				 lguest_hv_offset, dpl, ist);
+	}
+
+	vcpu->gdt.size =3D 8 * GDT_ENTRIES - 1;
+	vcpu->gdt.address =3D (unsigned long)&vcpu->gdt_table;
+
+	vcpu->idt.size =3D 16 * IDT_ENTRIES -1;
+	vcpu->idt.address =3D (unsigned long)vcpu->idt_table;
+	rdmsrl(MSR_LSTAR, vcpu->host_syscall);
+
+	vcpu->id =3D cpu;
+	vcpu->guest =3D linfo;
+	linfo->vcpu[cpu] =3D vcpu;
+
+	lguest_init_vcpu_pagetable(vcpu);
+
+	/* setup the tss */
+	tss =3D (struct ldttss_desc*)&vcpu->gdt_table[GDT_ENTRY_TSS];
+	limit =3D sizeof(struct lguest_tss_struct);
+	base =3D (u64)&vcpu->tss;
+	tss->limit0 =3D (u16)limit;
+	tss->base0 =3D (u16)base;
+	tss->base1 =3D (u8)(base>>16);
+	tss->base2 =3D (u8)(base>>24);
+	tss->base3 =3D (u32)(base>>32);
+	tss->type =3D 0x9;
+	tss->g =3D 0; /* small tss */
+
+	vcpu->tss.rsp0 =3D (unsigned long)(&vcpu->regs.size);
+
+	/* NMI can happen at any time, so give it its own stack */
+	vcpu->tss.ist[LGUEST_NMI_IST-1] =3D (unsigned long)(&vcpu->nmi_stack_end);
+	printk("nmi stack at: %llx\n", vcpu->tss.ist[LGUEST_NMI_IST-1]);
+
+	/* temp debug stuff */
+	vcpu->tss.ist[5-1] =3D (unsigned long)(&vcpu->gpf_stack_end);
+	vcpu->tss.ist[6-1] =3D (unsigned long)(&vcpu->df_stack_end);
+	/*
+	 * Load the host nmi stack into the guest tss. This prevents races
+	 * in loading the TR and IDT.
+	 */
+	tss =3D (struct ldttss_desc *)&gdt_table[GDT_ENTRY_TSS];
+	target =3D (u64)tss->base0 |
+		((u64)tss->base1 << 16) |
+		((u64)tss->base2 << 24) |
+		((u64)tss->base3 << 32);
+
+	tss_ptr =3D (struct lguest_tss_struct*)target;
+
+	vcpu->tss.ist[NMI_STACK-1] =3D tss_ptr->ist[NMI_STACK-1];
+
+	/*
+	 * The rsp0 had better be on 16 bytes aligned, or the interrupt
+	 * will put the stack at a undesireable location.
+	 */
+	/* Don't remove this test!!! */
+	if (unlikely(vcpu->tss.rsp0 & 0xf)) {
+		printk("HV ALIGNMENT BUG! don't put stack here!!\n");
+		printk(" tss.rsp0 stack was set to %llx\n",
+		       vcpu->tss.rsp0);
+		goto out;
+	}
+
+	vcpu->tss.io_bitmap_base =3D 0x68;
+	vcpu->tss.io_bitmap[0] =3D -1UL;
+
+	regs =3D &vcpu->regs;
+	regs->cr3 =3D __pa(vcpu->pgdir->pgdir);
+	regs->rax =3D regs->rbx =3D regs->rcx =3D regs->rdx =3D
+	regs->r8 =3D regs->r9 =3D regs->r10 =3D regs->r11 =3D
+	regs->r12 =3D regs->rdi =3D regs->rsi =3D regs->rbp =3D 0;
+	regs->r13 =3D LGUEST_MAGIC_R13;
+	regs->r14 =3D LGUEST_MAGIC_R14;
+	regs->r15 =3D LGUEST_MAGIC_R15;
+	regs->fs =3D 0;
+	regs->trapnum =3D 0;
+	regs->errcode =3D 0;
+	regs->rip =3D entry_point;
+//	regs->rip =3D 0x1000100;
+	regs->cs =3D __USER_CS;
+	regs->rflags =3D 0x202;   /* Interrupts enabled. */
+	regs->rsp =3D 0;
+	regs->ss =3D __USER_DS;
+
+	return 0;
+out:
+	free_vcpu(linfo, vcpu);
+	return -EINVAL;
+}
+
+static int initialize_guest(struct file *file, const u64 __user *input)
+{
+	struct lguest_guest_info *linfo;
+	int err;
+	u64 args[4];
+	int i;
+
+	if (file->private_data)
+		return -EBUSY;
+
+	if (copy_from_user(args, input, sizeof(args)) !=3D 0)
+		return -EFAULT;
+
+	linfo =3D kzalloc(sizeof(*linfo), GFP_KERNEL);
+	if (!linfo)
+		return -ENOMEM;
+
+	mutex_init(&linfo->page_lock);
+
+	/* FIXME: protect the guest_id counter */
+	linfo->guest_id =3D ++next_guest_id;
+
+	linfo->pfn_limit =3D args[0];
+	linfo->page_offset =3D args[3];
+	linfo->start_kernel_map =3D args[3];
+
+	mutex_init(&linfo->page_lock);
+	INIT_LIST_HEAD(&linfo->pgd_list);
+
+	for (i=3D0; i < PUD_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&linfo->pud_hash[i]);
+
+	for (i=3D0; i < PMD_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&linfo->pmd_hash[i]);
+
+	for (i=3D0; i < PTE_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&linfo->pte_hash[i]);
+
+	err =3D init_guest_pagetable(linfo, args[1]);
+	if (err)
+		return -ENOMEM; /* what else to return ?? */
+#if 0
+
+	lg->state =3D setup_guest_state(i, lg->pgdirs[lg->pgdidx].pgdir,args[2]);
+	if (!lg->state) {
+		err =3D -ENOEXEC;
+		goto release_pgtable;
+	}
+#endif
+	err =3D vcpu_start(0, linfo, args[2], __va(read_cr3()));
+	if (err < 0)
+		return err;
+
+	file->private_data =3D linfo->vcpu[0];
+
+	return sizeof(args);
+}
+
+static ssize_t write(struct file *file, const char __user *input,
+		     size_t size, loff_t *off)
+{
+	struct lguest_vcpu *vcpu =3D file->private_data;
+	u64 req;
+
+	if (get_user(req, input) !=3D 0)
+		return -EFAULT;
+	input +=3D sizeof(req);
+
+	if (req !=3D LHREQ_INITIALIZE && !vcpu)
+		return -EINVAL;
+#if 0
+	if (lg && lg->dead)
+		return -ENOENT;
+#endif
+
+	switch (req) {
+	case LHREQ_INITIALIZE:
+		return initialize_guest(file, (const u64 __user *)input);
+#if 0
+	case LHREQ_GETDMA:
+		return user_get_dma(lg, (const u32 __user *)input);
+	case LHREQ_IRQ:
+		return user_send_irq(lg, (const u32 __user *)input);
+#endif
+	default:
+		return -EINVAL;
+	}
+}
+
+static int close(struct inode *inode, struct file *file)
+{
+	struct lguest_vcpu *vcpu =3D file->private_data;
+	struct lguest_guest_info *linfo;
+
+	if (!vcpu)
+		return -EBADFD;
+
+	linfo =3D vcpu->guest;
+	/* FIXME: need to handle multiple vcpus */
+	free_vcpu(linfo, vcpu);
+	kfree(linfo);
+#if 0
+	mutex_lock(&lguest_lock);
+	release_all_dma(lg);
+	free_page((long)lg->trap_page);
+	free_guest_pagetable(lg);
+	mmput(lg->mm);
+	if (lg->dead !=3D (void *)1)
+		kfree(lg->dead);
+	memset(lg->state, 0, sizeof(*lg->state));
+	memset(lg, 0, sizeof(*lg));
+	mutex_unlock(&lguest_lock);
+#endif
+	return 0;
+}
+
+static struct file_operations lguest_fops =3D {
+	.owner	 =3D THIS_MODULE,
+	.release =3D close,
+	.write	 =3D write,
+	.read	 =3D read,
+};
+static struct miscdevice lguest_dev =3D {
+	.minor	=3D MISC_DYNAMIC_MINOR,
+	.name	=3D "lguest",
+	.fops	=3D &lguest_fops,
+};
+
+int __init lguest_device_init(void)
+{
+	return misc_register(&lguest_dev);
+}
+
+void __exit lguest_device_remove(void)
+{
+	misc_deregister(&lguest_dev);
+}
Index: work-pv/arch/x86_64/lguest/page_tables.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/page_tables.c
@@ -0,0 +1,1285 @@
+/* Shadow page table operations.
+ * Copyright (C) Steven Rostedt, Red Hat Inc, 2007
+ * GPL v2 and any later version */
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/random.h>
+#include <linux/percpu.h>
+#include <asm/tlbflush.h>
+#include <asm/hv_vm.h>
+#include "lguest.h"
+
+/* move this to hv_vm.h */
+#define HVVM_END (HVVM_START + HV_VIRT_SIZE)
+
+#define HASH_PUD(x) (((u64)(x)>>PAGE_SHIFT) & (PUD_HASH_SIZE-1))
+#define HASH_PMD(x) (((u64)(x)>>PAGE_SHIFT) & (PMD_HASH_SIZE-1))
+#define HASH_PTE(x) (((u64)(x)>>PAGE_SHIFT) & (PTE_HASH_SIZE-1))
+
+/* guest and host share the same offset into the page tables */
+/* 9 bits at 8 byte increments */
+#define guest_host_idx(vaddr) ((vaddr) & (0x1ff<<3))
+
+
+/* These access the guest versions. */
+static u64 gtoplev(struct lguest_vcpu *vcpu, unsigned long vaddr)
+{
+	unsigned index =3D pgd_index(vaddr);
+
+	return vcpu->pgdir->cr3 + index * sizeof(u64);
+}
+
+
+#if 0
+
+/* FIXME: we need to put these in and make it more secure! */
+static u32 check_pgtable_entry(struct lguest *lg, u32 entry)
+{
+	if ((entry & (_PAGE_PWT|_PAGE_PSE))
+	    || (entry >> PAGE_SHIFT) >=3D lg->pfn_limit)
+		kill_guest(lg, "bad page table entry");
+	return entry & ~_PAGE_GLOBAL;
+}
+
+void pin_stack_pages(struct lguest *lg)
+{
+	unsigned int i;
+	u32 stack =3D lg->state->tss.esp1;
+
+	for (i =3D 0; i < lg->stack_pages; i++)
+		if (!demand_page(lg, stack - i*PAGE_SIZE, 1))
+			kill_guest(lg, "bad stack page %i@%#x", i, stack);
+}
+
+void free_guest_pagetable(struct lguest *lg)
+{
+	unsigned int i;
+
+	release_all_pagetables(lg);
+	for (i =3D 0; i < ARRAY_SIZE(lg->pgdirs); i++)
+		free_page((long)lg->pgdirs[i].pgdir);
+}
+
+/* Caller must be preempt-safe */
+void map_trap_page(struct lguest *lg)
+{
+	int cpu =3D smp_processor_id();
+
+	hypervisor_pte_page(cpu)[0] =3D (__pa(lg->trap_page)|_PAGE_PRESENT);
+
+	/* Since hypervisor less that 4MB, we simply mug top pte page. */
+	lg->pgdirs[lg->pgdidx].pgdir[HYPERVISOR_PGD_ENTRY] =3D
+		(__pa(hypervisor_pte_page(cpu))| __PAGE_KERNEL);
+}
+
+#endif
+
+static int __lguest_map_guest_page(struct lguest_guest_info *linfo, u64 *c=
r3,
+				   unsigned long vaddr, unsigned long paddr,
+				   pgprot_t pprot);
+
+/* Do a virtual -> physical mapping on a user page. */
+static unsigned long get_pfn(unsigned long virtpfn, int write)
+{
+	struct vm_area_struct *vma;
+	struct page *page;
+	unsigned long ret =3D -1UL;
+
+	down_read(&current->mm->mmap_sem);
+	if (get_user_pages(current, current->mm, virtpfn << PAGE_SHIFT,
+			   1, write, 1, &page, &vma) =3D=3D 1)
+		ret =3D page_to_pfn(page);
+	up_read(&current->mm->mmap_sem);
+	return ret;
+}
+
+static int is_hv_page(int pgd_idx, int pud_idx, int pmd_idx, int pte_idx)
+{
+	/* Never release the hv pages */
+	u64 addr =3D (u64)pgd_idx << PGDIR_SHIFT |
+		(u64)pud_idx << PUD_SHIFT |
+		(u64)pmd_idx << PMD_SHIFT |
+		(u64)pte_idx << PAGE_SHIFT;
+	/* sign extend */
+	if (pgd_idx & (1<<8))
+		addr |=3D 0xffffULL << 48;
+	return (addr >=3D HVVM_START) &&
+		(addr < (HVVM_START + HV_VIRT_SIZE));
+}
+
+static void release_pte(u64 pte)
+{
+	if (pte & _PAGE_PRESENT)
+		put_page(pfn_to_page(pte >> PAGE_SHIFT));
+}
+
+static int release_pmd(int pgd_idx, int pud_idx, u64 *pmd, int idx)
+{
+	int save =3D 0;
+	if (pmd[idx] & _PAGE_PRESENT) {
+		int i;
+		u64 *ptepage =3D __va(pmd[idx] & PTE_MASK);
+		for (i=3D0; i < PTRS_PER_PMD; i++)
+			if (is_hv_page(pgd_idx, pud_idx, idx, i))
+				save =3D 1;
+			else
+				release_pte(ptepage[i]);
+		/* never free the HV pmds */
+		if (!save) {
+			free_page((unsigned long)ptepage);
+			pmd[idx] =3D 0;
+		}
+	}
+	return save;
+}
+
+static int release_pud(int pgd_idx, u64 *pud, int idx)
+{
+	int save =3D 0;
+	if (pud[idx] & _PAGE_PRESENT) {
+		int i;
+		u64 *pmdpage =3D __va(pud[idx] & PTE_MASK);
+		for (i=3D0; i < PTRS_PER_PUD; i++)
+			if (release_pmd(pgd_idx, idx, pmdpage, i))
+				save =3D 1;
+		/* never free the HV puds */
+		if (!save) {
+			free_page((unsigned long)pmdpage);
+			pud[idx] =3D 0;
+		}
+	}
+	return save;
+}
+
+static int release_pgd(u64 *pgd, int idx)
+{
+	int save =3D 0;
+
+	if (pgd[idx] & _PAGE_PRESENT) {
+		int i;
+		u64 *pudpage =3D __va(pgd[idx] & PTE_MASK);
+		for (i=3D0; i < PTRS_PER_PGD; i++) {
+			if (release_pud(idx, pudpage, i))
+				save =3D 1;
+		}
+		/* never free the HV pgd */
+		if (!save) {
+			free_page((unsigned long)pudpage);
+			pgd[idx] =3D 0;
+		}
+	}
+	return save;
+}
+
+static struct lguest_pgd *find_pgd(struct lguest_guest_info *linfo, u64 cr=
3)
+{
+	struct lguest_pgd *pgdir;
+
+	list_for_each_entry(pgdir, &linfo->pgd_list, list)
+		if (!(pgdir->flags & LGUEST_PGD_MASTER_FL) && pgdir->cr3 =3D=3D cr3)
+			break;
+
+	if (pgdir =3D=3D list_entry(&linfo->pgd_list, struct lguest_pgd, list))
+		return NULL;
+
+	return pgdir;
+}
+
+static struct lguest_pud *find_pud(struct lguest_guest_info *linfo, u64 gp=
ud)
+{
+	unsigned idx =3D HASH_PUD(gpud);
+	struct lguest_pud *pudir;
+
+	list_for_each_entry(pudir, &linfo->pud_hash[idx], list)
+		if (pudir->gpud =3D=3D gpud)
+			break;
+
+	if (pudir =3D=3D list_entry(&linfo->pud_hash[idx], struct lguest_pud, lis=
t))
+		return NULL;
+
+	return pudir;
+}
+
+static struct lguest_pmd *find_pmd(struct lguest_guest_info *linfo, u64 gp=
md)
+{
+	unsigned idx =3D HASH_PMD(gpmd);
+	struct lguest_pmd *pmdir;
+
+	list_for_each_entry(pmdir, &linfo->pmd_hash[idx], list)
+		if (pmdir->gpmd =3D=3D gpmd)
+			break;
+
+	if (pmdir =3D=3D list_entry(&linfo->pmd_hash[idx], struct lguest_pmd, lis=
t))
+		return NULL;
+
+	return pmdir;
+}
+
+static struct lguest_pte *find_pte(struct lguest_guest_info *linfo, u64 gp=
te)
+{
+	unsigned idx =3D HASH_PTE(gpte);
+	struct lguest_pte *pte;
+
+	list_for_each_entry(pte, &linfo->pte_hash[idx], list)
+		if (pte->gpte =3D=3D gpte)
+			break;
+
+	if (pte =3D=3D list_entry(&linfo->pte_hash[idx], struct lguest_pte, list))
+		return NULL;
+
+	return pte;
+}
+
+static void __release_pte_hash(struct lguest_vcpu *vcpu, struct lguest_pte=
 *pte)
+{
+	list_del(&pte->list);
+	kfree(pte);
+}
+
+static void __release_pmd_hash(struct lguest_vcpu *vcpu, struct lguest_pmd=
 *pmdir)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pte *pte;
+	int i;
+
+	list_del(&pmdir->list);
+
+	for (i=3D0; i < PTRS_PER_PMD; i++) {
+		u64 gpte;
+
+		gpte =3D lhread_u64(vcpu, pmdir->gpmd+i*sizeof(u64));
+		if (!gpte)
+			continue;
+		pte =3D find_pte(linfo, gpte & PTE_MASK);
+		if (!pte)
+			continue;
+		__release_pte_hash(vcpu, pte);
+	}
+
+	kfree(pmdir);
+}
+
+static void __release_pud_hash(struct lguest_vcpu *vcpu, struct lguest_pud=
 *pudir)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pmd *pmdir;
+	int i;
+
+	list_del(&pudir->list);
+
+	for (i=3D0; i < PTRS_PER_PUD; i++) {
+		u64 gpmd;
+
+		gpmd =3D lhread_u64(vcpu, pudir->gpud+i*sizeof(u64));
+		if (!gpmd)
+			continue;
+		pmdir =3D find_pmd(linfo, gpmd & PTE_MASK);
+		if (!pmdir)
+			continue;
+		__release_pmd_hash(vcpu, pmdir);
+	}
+
+	kfree(pudir);
+}
+
+static struct lguest_pud *hash_pud(struct lguest_vcpu *vcpu, u64 gpud, uns=
igned idx)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pud *pudir;
+	unsigned h;
+
+	mutex_lock(&linfo->page_lock);
+	pudir =3D find_pud(linfo, gpud);
+	if (!pudir) {
+		/* FIXME: make this a slab? */
+		pudir =3D kzalloc(sizeof(*pudir), GFP_KERNEL);
+		if (!pudir)
+			goto out;
+		h =3D HASH_PUD(gpud);
+		list_add(&pudir->list, &linfo->pud_hash[h]);
+		pudir->pgdir =3D vcpu->pgdir;
+		pudir->gpud =3D gpud;
+		pudir->idx =3D idx;
+	}
+out:
+	mutex_unlock(&linfo->page_lock);
+
+	return pudir;
+}
+
+static struct lguest_pmd *hash_pmd(struct lguest_vcpu *vcpu, struct lguest=
_pud *pudir,
+				   u64 gpmd, unsigned idx)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pmd *pmdir;
+	unsigned h;
+
+	mutex_lock(&linfo->page_lock);
+	pmdir =3D find_pmd(linfo, gpmd);
+	if (!pmdir) {
+		/* FIXME: make this a slab? */
+		pmdir =3D kzalloc(sizeof(*pmdir), GFP_KERNEL);
+		if (!pmdir)
+			goto out;
+		h =3D HASH_PMD(gpmd);
+		list_add(&pmdir->list, &linfo->pmd_hash[h]);
+		pmdir->pudir =3D pudir;
+		pmdir->gpmd =3D gpmd;
+		pmdir->idx =3D idx;
+	}
+out:
+	mutex_unlock(&linfo->page_lock);
+
+	return pmdir;
+}
+
+static struct lguest_pte *hash_pte(struct lguest_vcpu *vcpu, struct lguest=
_pmd *pmdir,
+				   u64 gpte, unsigned idx)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pte *pte;
+	unsigned h;
+
+	mutex_lock(&linfo->page_lock);
+	pte =3D find_pte(linfo, gpte);
+	if (!pte) {
+		/* FIXME: make this a slab? */
+		pte =3D kzalloc(sizeof(*pte), GFP_KERNEL);
+		if (!pte)
+			goto out;
+		h =3D HASH_PTE(gpte);
+		list_add(&pte->list, &linfo->pte_hash[h]);
+		pte->pmdir =3D pmdir;
+		pte->gpte =3D gpte;
+		pte->idx =3D idx;
+	}
+out:
+	mutex_unlock(&linfo->page_lock);
+
+	return pte;
+}
+
+void guest_set_pte(struct lguest_vcpu *vcpu,
+		   unsigned long cr3, unsigned long vaddr,
+		   unsigned long value)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pud *pudir;
+	struct lguest_pmd *pmdir;
+	struct lguest_pte *ptedir;
+	unsigned long idx =3D (vaddr & (PAGE_SIZE-1)) / 8;
+	u64 base =3D vaddr & PTE_MASK;
+	u64 pgd;
+	u64 pud;
+	u64 pmd;
+	u64 pte;
+	u64 *pudpage;
+	u64 *pmdpage;
+	u64 *ptepage;
+
+	mutex_lock(&linfo->page_lock);
+
+	ptedir =3D find_pte(linfo, base);
+	if (!ptedir)
+		goto out;
+
+	pmdir =3D ptedir->pmdir;
+	pudir =3D pmdir->pudir;
+
+	pgd =3D vcpu->pgdir->pgdir[pudir->idx];
+	if (!(pgd & _PAGE_PRESENT))
+		goto out;
+
+	pudpage =3D __va(pgd & PTE_MASK);
+	pud =3D pudpage[pmdir->idx];
+
+	if (!(pud & _PAGE_PRESENT))
+		goto out;
+
+	pmdpage =3D __va(pud & PTE_MASK);
+	pmd =3D pmdpage[ptedir->idx];
+
+	if (!(pmd & _PAGE_PRESENT))
+		goto out;
+
+	ptepage =3D __va(pmd & PTE_MASK);
+	pte =3D ptepage[idx];
+
+	if (!(pte & _PAGE_PRESENT))
+		goto out;
+
+	/* If the guest is trying to touch HV area, kill it! */
+	if (is_hv_page(pudir->idx, pmdir->idx, ptedir->idx, idx)) {
+		kill_guest_dump(vcpu, "guest trying to write to HV area\n");
+		goto out;
+	}
+
+	/* FIXME: perhaps we could set the pte now ? */
+
+	release_pte(ptepage[idx]);
+	__release_pte_hash(vcpu, ptedir);
+
+out:
+	mutex_unlock(&linfo->page_lock);
+}
+
+void guest_set_pmd(struct lguest_vcpu *vcpu,
+		   unsigned long cr3, unsigned long base,
+		   unsigned long idx)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pud *pudir;
+	struct lguest_pmd *pmdir;
+	u64 pgd;
+	u64 pud;
+	u64 pmd;
+	u64 *pudpage;
+	u64 *pmdpage;
+	int save;
+
+	if (idx >=3D PTRS_PER_PMD) {
+		kill_guest_dump(vcpu, "illegal index for pgd (%ld)\n", idx);
+		return;
+	}
+
+	mutex_lock(&linfo->page_lock);
+
+	pmdir =3D find_pmd(linfo, base);
+	if (!pmdir)
+		goto out;
+
+	pudir =3D pmdir->pudir;
+
+	pgd =3D vcpu->pgdir->pgdir[pudir->idx];
+	if (!(pgd & _PAGE_PRESENT))
+		goto out;
+
+	pudpage =3D __va(pgd & PTE_MASK);
+	pud =3D pudpage[pmdir->idx];
+
+	if (!(pud & _PAGE_PRESENT))
+		goto out;
+
+	pmdpage =3D __va(pud & PTE_MASK);
+	pmd =3D pmdpage[idx];
+
+	if (!(pmd & _PAGE_PRESENT))
+		goto out;
+
+	save =3D release_pmd(pudir->idx, pmdir->idx, pmdpage, idx);
+	if (!save)
+		__release_pmd_hash(vcpu, pmdir);
+
+out:
+	mutex_unlock(&linfo->page_lock);
+}
+
+void guest_set_pud(struct lguest_vcpu *vcpu,
+		   unsigned long cr3, unsigned long base,
+		   unsigned long idx)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pud *pudir;
+	u64 pgd;
+	u64 pud;
+	u64 *pudpage;
+	int save;
+
+	if (idx >=3D PTRS_PER_PUD) {
+		kill_guest_dump(vcpu, "illegal index for pgd (%ld)\n", idx);
+		return;
+	}
+
+	mutex_lock(&linfo->page_lock);
+
+	pudir =3D find_pud(linfo, base);
+	if (!pudir)
+		goto out;
+
+	pgd =3D vcpu->pgdir->pgdir[pudir->idx];
+	if (!(pgd & _PAGE_PRESENT))
+		goto out;
+
+	pudpage =3D __va(pgd & PTE_MASK);
+	pud =3D pudpage[idx];
+
+	if (!(pud & _PAGE_PRESENT))
+		goto out;
+
+	save =3D release_pud(pudir->idx, pudpage, idx);
+	if (!save)
+		__release_pud_hash(vcpu, pudir);
+
+out:
+	mutex_unlock(&linfo->page_lock);
+}
+
+void guest_set_pgd(struct lguest_vcpu *vcpu, unsigned long cr3,
+		   unsigned long base, unsigned long idx)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pgd *pgdir;
+	struct lguest_pud *pudir;
+	u64 gpud;
+	u64 pgd;
+	u64 pud;
+	int save;
+
+	pgdir =3D vcpu->pgdir;
+
+	if (idx >=3D PTRS_PER_PGD) {
+		kill_guest_dump(vcpu, "illegal index for pgd (%ld)\n", idx);
+		return;
+	}
+
+	mutex_lock(&linfo->page_lock);
+
+	pgd =3D pgdir->pgdir[idx];
+	if (!(pgd & _PAGE_PRESENT))
+		goto out;
+
+	pud =3D pgd & PTE_MASK;
+
+	gpud =3D lhread_u64(vcpu, base + idx * sizeof(u64));
+	pudir =3D find_pud(linfo, gpud & PTE_MASK);
+	if (pudir)
+		__release_pud_hash(vcpu, pudir);
+	save =3D release_pgd(pgdir->pgdir, idx);
+
+	if (!save && idx >=3D guest_host_idx(linfo->page_offset >> (PGDIR_SHIFT-3=
))) {
+		/* All guest procesess share the same kernel PML4Es */
+		/*
+		 * So we only free the tree once, but then reset
+		 * all the others.
+		 */
+		list_for_each_entry(pgdir, &linfo->pgd_list, list) {
+			pgd =3D pgdir->pgdir[idx];
+			if (!(pgd & _PAGE_PRESENT))
+				continue;
+			BUG_ON((pgd & PTE_MASK) !=3D pud);
+			pgdir->pgdir[idx] =3D 0;
+		}
+	}
+out:
+	mutex_unlock(&linfo->page_lock);
+}
+
+void guest_flush_tlb_single(struct lguest_vcpu *vcpu, u64 cr3, u64 vaddr)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pgd *pgdir;
+	unsigned long pgd_idx;
+	unsigned long pud_idx;
+	unsigned long pmd_idx;
+	unsigned long idx;
+	u64 pgd;
+	u64 pud;
+	u64 pmd;
+	u64 pte;
+	u64 *pudpage;
+	u64 *pmdpage;
+	u64 *ptepage;
+
+	mutex_lock(&linfo->page_lock);
+
+	if (vaddr > linfo->page_offset)
+		pgdir =3D &linfo->kpgdir;
+	else
+		pgdir =3D find_pgd(linfo, cr3);
+
+	pgd_idx =3D pgd_index(vaddr);
+	pgd =3D pgdir->pgdir[pgd_idx];
+	if (!(pgd & _PAGE_PRESENT))
+		goto out;
+
+	pud_idx =3D pud_index(vaddr);
+	pudpage =3D __va(pgd & PTE_MASK);
+	pud =3D pudpage[pud_idx];
+
+	if (!(pud & _PAGE_PRESENT))
+		goto out;
+
+	pmd_idx =3D pmd_index(vaddr);
+	pmdpage =3D __va(pud & PTE_MASK);
+	pmd =3D pmdpage[pmd_idx];
+
+	if (!(pmd & _PAGE_PRESENT))
+		goto out;
+
+	idx =3D pte_index(vaddr);
+	ptepage =3D __va(pmd & PTE_MASK);
+	pte =3D ptepage[idx];
+
+	if (!(pte & _PAGE_PRESENT))
+		goto out;
+
+	/* If the guest is trying to touch HV area, kill it! */
+	if (is_hv_page(pgd_idx, pud_idx, pmd_idx, idx)) {
+		kill_guest_dump(vcpu, "guest trying to write to HV area\n");
+		goto out;
+	}
+
+	release_pte(ptepage[idx]);
+	/* FIXME: what about the hash?? */
+
+out:
+	mutex_unlock(&linfo->page_lock);
+}
+
+static void flush_user_mappings(struct lguest_guest_info *linfo, struct lg=
uest_pgd *pgdir)
+{
+	unsigned int i;
+	for (i =3D 0; i < pgd_index(linfo->page_offset); i++)
+		release_pgd(pgdir->pgdir, i);
+}
+
+static struct lguest_pgd *new_pgdir(struct lguest_guest_info *linfo, u64 c=
r3)
+{
+	unsigned int next;
+	unsigned int i;
+
+	next =3D random32() % LGUEST_PGDIRS;
+	for (i=3D(next+1) % LGUEST_PGDIRS; i !=3D next; i =3D (i+1) % LGUEST_PGDI=
RS) {
+		if (linfo->pgdirs[i].flags & LGUEST_PGD_BUSY_FL)
+			continue;
+		break;
+	}
+	BUG_ON(linfo->pgdirs[i].flags & LGUEST_PGD_BUSY_FL);
+
+	next =3D i;
+
+	linfo->pgdirs[next].cr3 =3D cr3;
+	if (!linfo->pgdirs[next].pgdir) {
+		linfo->pgdirs[next].pgdir =3D (u64 *)get_zeroed_page(GFP_KERNEL);
+		if (!linfo->pgdirs[next].pgdir)
+			return NULL;
+		/* all kernel pages are the same */
+		for (i=3Dpgd_index(linfo->page_offset); i < PTRS_PER_PGD; i++)
+			linfo->pgdirs[next].pgdir[i] =3D linfo->kpgdir.pgdir[i];
+	} else {
+		BUG_ON(!(linfo->pgdirs[next].flags & LGUEST_PGD_LINK_FL));
+		/* Release all the non-kernel mappings. */
+		flush_user_mappings(linfo, &linfo->pgdirs[next]);
+	}
+
+	return &linfo->pgdirs[next];
+}
+
+void guest_new_pagetable(struct lguest_vcpu *vcpu, u64 pgtable)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pgd *newpgdir;
+
+	mutex_lock(&linfo->page_lock);
+	newpgdir =3D find_pgd(linfo, pgtable);
+	if (vcpu->pgdir) {
+		if (!(--vcpu->pgdir->count))
+			vcpu->pgdir->flags &=3D ~(LGUEST_PGD_BUSY_FL);
+	}
+	if (!newpgdir)
+		newpgdir =3D new_pgdir(linfo, pgtable);
+	if (!newpgdir) {
+		kill_guest_dump(vcpu, "no more pgd's available!\n");
+		goto out;
+	}
+	vcpu->pgdir =3D newpgdir;
+	if (!vcpu->pgdir->count++)
+		vcpu->pgdir->flags |=3D LGUEST_PGD_BUSY_FL;
+	vcpu->regs.cr3 =3D __pa(vcpu->pgdir->pgdir);
+	if (!(vcpu->pgdir->flags & LGUEST_PGD_LINK_FL)) {
+		list_add(&vcpu->pgdir->list, &linfo->pgd_list);
+		vcpu->pgdir->flags |=3D LGUEST_PGD_LINK_FL;
+	}
+//	pin_stack_pages(lg);
+out:
+	mutex_unlock(&linfo->page_lock);
+}
+
+static void release_all_pagetables(struct lguest_guest_info *linfo)
+{
+	struct lguest_pgd *pgdir, *next;
+	int i;
+
+	/* We share the kernel pages, so do them once */
+	for (i=3D0; i < PTRS_PER_PGD; i++)
+		release_pgd(linfo->kpgdir.pgdir, i);
+
+	list_for_each_entry(pgdir, &linfo->pgd_list, list) {
+		if (pgdir->pgdir)
+			for (i=3D0; i < pgd_index(linfo->page_offset); i++)
+				release_pgd(pgdir->pgdir, i);
+	}
+	/* now release any pgdirs that are not busy */
+	list_for_each_entry_safe(pgdir, next, &linfo->pgd_list, list) {
+		if (!(pgdir->flags & LGUEST_PGD_BUSY_FL)) {
+			BUG_ON(pgdir->count);
+			pgdir->flags &=3D ~LGUEST_PGD_LINK_FL;
+			list_del(&pgdir->list);
+			free_page((u64)pgdir->pgdir);
+			pgdir->cr3 =3D 0;
+			pgdir->pgdir =3D NULL;
+		}
+	}
+}
+
+void guest_pagetable_clear_all(struct lguest_vcpu *vcpu)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+
+	mutex_lock(&linfo->page_lock);
+	release_all_pagetables(linfo);
+//	pin_stack_pages(lg);
+	mutex_unlock(&linfo->page_lock);
+}
+
+void guest_pagetable_flush_user(struct lguest_vcpu *vcpu)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	unsigned int i;
+
+	for (i =3D 0; i < pgd_index(linfo->page_offset); i++)
+		release_pgd(vcpu->pgdir->pgdir, i);
+}
+
+/* FIXME: We hold reference to pages, which prevents them from being
+   swapped.  It'd be nice to have a callback when Linux wants to swap out.=
 */
+
+/* We fault pages in, which allows us to update accessed/dirty bits.
+ * Return 0 if failed, 1 if good */
+static int page_in(struct lguest_vcpu *vcpu, u64 vaddr, pgprot_t prot)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_pud *pudir;
+	struct lguest_pmd *pmdir;
+	struct lguest_pte *ptedir;
+	u64 val;
+	u64 paddr;
+	u64 gpgd, gpud, gpmd, gpte;
+	u64 flags =3D pgprot_val(prot);
+	int write;
+	int ret;
+
+	gpgd =3D gtoplev(vcpu, vaddr);
+	val =3D lhread_u64(vcpu, gpgd);
+	if (!(val & _PAGE_PRESENT)) {
+		printk("pgd not present pgd:%llx vaddr:%llx val:%llx\n", gpgd, vaddr, va=
l);
+		return 0;
+	}
+
+	gpud =3D val & PTE_MASK;
+
+	pudir =3D hash_pud(vcpu, gpud, pgd_index(vaddr));
+	if (!pudir)
+		return 0; /* -ENOMEM */
+
+	if (vaddr >=3D linfo->page_offset)
+		pudir->flags |=3D LGUEST_PUD_KERNEL_FL;
+
+	gpud +=3D pud_index(vaddr) * sizeof(u64);
+	val =3D lhread_u64(vcpu, gpud);
+	if (!(val & _PAGE_PRESENT)) {
+		printk("pud not present?\n");
+		return 0;
+	}
+
+	gpmd =3D val & PTE_MASK;
+
+	pmdir =3D hash_pmd(vcpu, pudir, gpmd, pud_index(vaddr));
+	if (!pmdir)
+		return 0; /* -ENOMEM */
+
+	if (vaddr >=3D linfo->page_offset)
+		pmdir->flags |=3D LGUEST_PMD_KERNEL_FL;
+
+	gpmd +=3D pmd_index(vaddr) * sizeof(u64);
+	val =3D lhread_u64(vcpu, gpmd);
+	if (!(val & _PAGE_PRESENT)) {
+		printk("pmd not present?\n");
+		return 0;
+	}
+
+	/* The guest might have set up a 2M page */
+	if (val & (1<<7)) {
+		/* 2M pages */
+		/*
+		 * Although the guest may have mapped this into 2M pages
+		 * we haven't and wont. So we still need to find the 4K
+		 * page position.
+		 */
+		paddr =3D val & ~((1<<20)-1);
+		paddr +=3D pte_index(vaddr) << PAGE_SHIFT;
+		paddr &=3D PTE_MASK; /* can still have the NX bit set */
+	} else {
+		/* 4K pages */
+		gpte =3D val & PTE_MASK;
+
+		ptedir =3D hash_pte(vcpu, pmdir, gpte, pmd_index(vaddr));
+		if (!ptedir)
+			return 0; /* -ENOMEM */
+
+		gpte +=3D pte_index(vaddr) * sizeof(u64);
+		val =3D lhread_u64(vcpu, gpte);
+		if (!(val & _PAGE_PRESENT) || ((flags & _PAGE_DIRTY) && !(val & _PAGE_RW=
))) {
+			printk("pte not present or dirty?\n");
+			return 0;
+		}
+		/* this is the guest's paddr */
+		paddr =3D val & PTE_MASK;
+
+	}
+
+	/* FIXME: check these values */
+
+	/*
+	 * FIXME: if this isn't write, we lose the lguest_data when we do
+	 *  a put_user in the hypercall init.
+	 */
+	write =3D 1; // val & _PAGE_DIRTY ? 1 : 0;
+
+	val =3D get_pfn(paddr >> PAGE_SHIFT, write);
+	if (val =3D=3D (unsigned long)-1UL) {
+		printk("bad 1\n");
+		kill_guest_dump(vcpu, "page %llx not mapped", paddr);
+		return 0;
+	}
+
+	/* now we have the actual paddr */
+	val <<=3D PAGE_SHIFT;
+
+	ret =3D __lguest_map_guest_page(vcpu->guest, vcpu->pgdir->pgdir,
+				      vaddr, val, __pgprot(flags));
+	if (ret < 0) {
+		printk("bad 2\n");
+		kill_guest_dump(vcpu, "can't map page");
+		return 0;
+	}
+	return 1;
+}
+
+int demand_page(struct lguest_vcpu *vcpu, u64 vaddr, int write)
+{
+	return page_in(vcpu, vaddr, (write ? PAGE_SHARED_EXEC : PAGE_COPY_EXEC));
+}
+
+
+static pud_t *pud_from_index(unsigned long addr, unsigned index)
+{
+	pud_t *pud =3D (pud_t*)addr;
+
+	return &pud[index];
+}
+
+static pmd_t *pmd_from_index(unsigned long addr, unsigned index)
+{
+	pmd_t *pmd =3D (pmd_t*)addr;
+
+	return &pmd[index];
+}
+
+static pte_t *pte_from_index(unsigned long addr, unsigned index)
+{
+	pte_t *pte =3D (pte_t*)addr;
+
+	return &pte[index];
+}
+
+static int __lguest_map_guest_pte(pmd_t *pmd, unsigned long vaddr,
+				  unsigned long paddr, pgprot_t prot)
+{
+	unsigned long page;
+	pte_t *pte;
+	unsigned index;
+
+	page =3D pmd_page_vaddr(*pmd);
+
+	index =3D pte_index(vaddr);
+	pte =3D pte_from_index(page, index);
+	if (pte_val(*pte) & _PAGE_PRESENT &&
+	    pte_val(*pte) =3D=3D pte_val(pfn_pte(paddr>>PAGE_SHIFT, prot)) ) {
+		printk("stange page faulting!\n");
+		printk("paddr=3D%lx (paddr)=3D%lx\n", paddr, *(unsigned long *)__va(padd=
r));
+		printk("vaddr: %lx pte %x val: %lx\n", vaddr, index, pte_val(*pte));
+	}
+
+	set_pte(pte, mk_pte(pfn_to_page(paddr >> PAGE_SHIFT), prot));
+
+	return 0;
+}
+
+static int __lguest_map_guest_pmd(pud_t *pud, unsigned long vaddr, unsigne=
d long paddr,
+				  pgprot_t prot)
+{
+	unsigned long page;
+	pmd_t *pmd;
+	unsigned index;
+
+	page =3D pud_page_vaddr(*pud);
+
+	index =3D pmd_index(vaddr);
+	pmd =3D pmd_from_index(page, index);
+	if (!pmd_val(*pmd)) {
+		page =3D get_zeroed_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+		set_pmd(pmd, __pmd(_PAGE_TABLE | __pa(page)));
+	}
+
+	return __lguest_map_guest_pte(pmd, vaddr, paddr, prot);
+}
+
+static int __lguest_map_guest_pud(pgd_t *pgd, unsigned long vaddr, unsigne=
d long paddr,
+				  pgprot_t prot)
+{
+	unsigned long page;
+	pud_t *pud;
+	unsigned index;
+
+	page =3D pgd_page_vaddr(*pgd);
+
+	index =3D pud_index(vaddr);
+	pud =3D pud_from_index(page, index);
+	if (!pud_val(*pud)) {
+		page =3D get_zeroed_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+		set_pud(pud, __pud(_PAGE_TABLE | __pa(page)));
+	}
+
+	return __lguest_map_guest_pmd(pud, vaddr, paddr, prot);
+}
+
+static int __lguest_map_guest_pgd(u64 *cr3,
+				  unsigned long vaddr, unsigned long paddr,
+				  pgprot_t prot)
+{
+	unsigned long page;
+	unsigned index;
+	pgd_t *pgd;
+
+	index =3D pgd_index(vaddr);
+	pgd =3D (pgd_t*)&cr3[index];
+	if (!pgd_val(*pgd)) {
+		page =3D get_zeroed_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+		set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(page)));
+	}
+
+	return __lguest_map_guest_pud(pgd, vaddr, paddr, prot);
+}
+
+static int __lguest_map_guest_page(struct lguest_guest_info *linfo, u64 *c=
r3,
+				   unsigned long vaddr, unsigned long paddr,
+				   pgprot_t prot)
+{
+	int ret;
+
+	ret =3D __lguest_map_guest_pgd(cr3, vaddr, paddr, prot);
+	if (ret < 0)
+		return ret;
+
+	/* All guest kernel pages are the same */
+	if (vaddr >=3D linfo->page_offset) {
+		struct lguest_pgd *pgdir;
+		unsigned index;
+		pgd_t *pgd;
+		u64 val;
+
+		index =3D pgd_index(vaddr);
+		pgd =3D (pgd_t*)&cr3[index];
+		val =3D pgd_val(*pgd);
+
+		list_for_each_entry(pgdir, &linfo->pgd_list, list)
+			pgdir->pgdir[index] =3D val;
+	}
+	return ret;
+}
+
+static void __lguest_unmap_page_pmd(pmd_t *pmd, unsigned long vaddr)
+{
+	pte_t *pte;
+	unsigned index;
+	unsigned long page;
+
+	page =3D pmd_page_vaddr(*pmd);
+
+	index =3D pte_index(vaddr);
+	pte =3D pte_from_index(page, index);
+	if (pte_val(*pte) & 1)
+		set_pte(pte, __pte(0));
+}
+
+static void __lguest_unmap_page_pud(pud_t *pud, unsigned long vaddr)
+{
+	pmd_t *pmd;
+	unsigned index;
+	unsigned long page;
+
+	page =3D pud_page_vaddr(*pud);
+
+	index =3D pmd_index(vaddr);
+	pmd =3D pmd_from_index(page, index);
+	if (pmd_val(*pmd) & 1)
+		__lguest_unmap_page_pmd(pmd, vaddr);
+}
+
+static void __lguest_unmap_page_pgd(pgd_t *pgd, unsigned long vaddr)
+{
+	pud_t *pud;
+	unsigned index;
+	unsigned long page;
+
+	page =3D pgd_page_vaddr(*pgd);
+
+	index =3D pud_index(vaddr);
+	pud =3D pud_from_index(page, index);
+	if (pud_val(*pud) & 1)
+		__lguest_unmap_page_pud(pud, vaddr);
+}
+
+static void __lguest_unmap_guest_page(struct lguest_guest_info *linfo,
+				      unsigned long vaddr)
+{
+	pgd_t *pgd;
+	unsigned index;
+	u64 *cr3 =3D linfo->kpgdir.pgdir;
+
+	if (!cr3)
+		return;
+
+	index =3D pgd_index(vaddr);
+	pgd =3D (pgd_t*)&cr3[index];
+	if (!(pgd_val(*pgd)&1))
+		return;
+
+	__lguest_unmap_page_pgd(pgd, vaddr);
+}
+
+int lguest_map_hv_pages(struct lguest_guest_info *lguest,
+			unsigned long vaddr, int pages,
+			pgprot_t *pprot)
+{
+	unsigned long page;
+	int i;
+	int ret;
+	pgprot_t prot;
+
+	ret =3D -ENOMEM;
+	for (i=3D0; i < pages; i++) {
+		/* now add the page we want */
+		page =3D hvvm_get_actual_phys((void*)vaddr+PAGE_SIZE*i, &prot);
+		if (!page)
+			goto failed;
+
+		if (pprot)
+			prot =3D *pprot;
+		ret =3D __lguest_map_guest_page(lguest, lguest->kpgdir.pgdir,
+					      vaddr+PAGE_SIZE*i, page, prot);
+		if (ret < 0)
+			goto failed;
+	}
+	return 0;
+failed:
+	for (--i; i >=3D 0; i--)
+		__lguest_unmap_guest_page(lguest, vaddr+PAGE_SIZE*i);
+	return ret;
+}
+
+/**
+ * lguest_mem_addr - retrieve page that's mapped from guest.
+ * @vcpu: lguest vcpu descriptor.
+ * @addr: address to get from the guest's address space.
+ *
+ *  ONLY USE WHEN ALL ELSE FAILS!
+ */
+void *lguest_mem_addr(struct lguest_vcpu *vcpu, u64 addr)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	u64 *cr3 =3D linfo->kpgdir.pgdir;
+	unsigned long page;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned index =3D pgd_index(addr);
+
+	pgd =3D (pgd_t*)&cr3[index];
+	if (!(pgd_val(*pgd) & 1))
+		return NULL;
+
+	page =3D pgd_page_vaddr(*pgd);
+	index =3D pud_index(addr);
+	pud =3D pud_from_index(page, index);
+	if (!(pud_val(*pud) & 1))
+		return NULL;
+
+	page =3D pud_page_vaddr(*pud);
+	index =3D pmd_index(addr);
+	pmd =3D pmd_from_index(page, index);
+	if (!(pmd_val(*pmd) & 1))
+		return NULL;
+
+	page =3D pmd_page_vaddr(*pmd);
+	index =3D pte_index(addr);
+	pte =3D pte_from_index(page, index);
+	if (!(pte_val(*pte) & 1))
+		return NULL;
+
+	page =3D ((pte_val(*pte) & PAGE_MASK) + (addr & (PAGE_SIZE-1)));
+
+	return (void *)(page + PAGE_OFFSET);
+}
+
+void __lguest_free_guest_pmd(pmd_t *pmd)
+{
+	pte_t *pte;
+	unsigned long page;
+	int i;
+
+	page =3D pmd_page_vaddr(*pmd);
+
+	for (i=3D0; i < PTRS_PER_PTE; i++) {
+		pte =3D pte_from_index(page, i);
+		if (!(pte_val(*pte) & 1))
+			continue;
+		/* FIXME: do some checks here??? */
+	}
+	set_pmd(pmd, __pmd(0));
+	free_page(page);
+}
+
+void __lguest_free_guest_pud(pud_t *pud)
+{
+	pmd_t *pmd;
+	unsigned long page;
+	int i;
+
+	page =3D pud_page_vaddr(*pud);
+
+	for (i=3D0; i < PTRS_PER_PMD; i++) {
+		pmd =3D pmd_from_index(page, i);
+		if (!(pmd_val(*pmd) & 1))
+			continue;
+		__lguest_free_guest_pmd(pmd);
+	}
+	set_pud(pud, __pud(0));
+	free_page(page);
+}
+
+void __lguest_free_guest_pgd(pgd_t *pgd)
+{
+	pud_t *pud;
+	unsigned long page;
+	int i;
+
+	page =3D pgd_page_vaddr(*pgd);
+
+	for (i=3D0; i < PTRS_PER_PUD; i++) {
+		pud =3D pud_from_index(page, i);
+		if (!(pud_val(*pud) & 1))
+			continue;
+		__lguest_free_guest_pud(pud);
+	}
+	set_pgd(pgd, __pgd(0));
+	free_page(page);
+}
+
+void __lguest_free_guest_pages(u64 *cr3)
+{
+	pgd_t *pgd;
+	int i;
+
+	if (!cr3)
+		return;
+
+	for (i=3D0; i < PTRS_PER_PGD; i++) {
+		pgd =3D (pgd_t*)&cr3[i];
+		if (!(pgd_val(*pgd) & 1))
+			continue;
+		__lguest_free_guest_pgd(pgd);
+	}
+	free_page((u64)cr3);
+}
+
+void __lguest_free_guest_upages(struct lguest_guest_info *linfo, u64 *cr3)
+{
+	pgd_t *pgd;
+	int i;
+
+	if (!cr3)
+		return;
+
+	for (i=3D0; i < pgd_index(linfo->page_offset); i++) {
+		pgd =3D (pgd_t*)&cr3[i];
+		if (!(pgd_val(*pgd) & 1))
+			continue;
+		__lguest_free_guest_pgd(pgd);
+	}
+	free_page((u64)cr3);
+}
+
+void lguest_free_guest_pages(struct lguest_guest_info *linfo)
+{
+	int i;
+
+	/* This frees all the guest kernel pages */
+	__lguest_free_guest_pages(linfo->kpgdir.pgdir);
+
+	for (i=3D0; i < LGUEST_PGDIRS; i++)
+		__lguest_free_guest_upages(linfo, linfo->pgdirs[i].pgdir);
+}
+
+void lguest_unmap_guest_pages(struct lguest_guest_info *lguest,
+			     unsigned long vaddr, int pages)
+{
+	int i;
+
+	for (i=3D0; i < pages; i++)
+		__lguest_unmap_guest_page(lguest, vaddr+PAGE_SIZE*i);
+}
+
+int lguest_init_vcpu_pagetable(struct lguest_vcpu *vcpu)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+
+	mutex_lock(&linfo->page_lock);
+	vcpu->pgdir =3D new_pgdir(linfo, linfo->kpgdir.cr3);
+	BUG_ON(!vcpu->pgdir);
+	if (!vcpu->pgdir->count++)
+		vcpu->pgdir->flags |=3D LGUEST_PGD_BUSY_FL;
+	list_add(&vcpu->pgdir->list, &linfo->pgd_list);
+	mutex_unlock(&linfo->page_lock);
+
+	return 0;
+}
+
+int init_guest_pagetable(struct lguest_guest_info *linfo, u64 pgtable)
+{
+	int ret =3D -ENOMEM;
+
+	linfo->kpgdir.cr3 =3D pgtable;
+	linfo->kpgdir.pgdir =3D (u64*)get_zeroed_page(GFP_KERNEL);
+	if (!linfo->kpgdir.pgdir)
+		return -ENOMEM;
+	linfo->kpgdir.flags |=3D LGUEST_PGD_BUSY_FL | LGUEST_PGD_MASTER_FL;
+	linfo->kpgdir.count =3D -1;
+
+	/*
+	 * The list is used to update all the kernel page tables,
+	 * so that they all have the same mappings.
+	 */
+	list_add(&linfo->kpgdir.list, &linfo->pgd_list);
+
+	ret =3D lguest_map_hv_pages(linfo, lguest_hv_addr,
+				  lguest_hv_pages, NULL);
+	if (ret < 0)
+		goto out;
+
+	return 0;
+ out:
+	free_page((u64)linfo->kpgdir.pgdir);
+
+	return ret;
+}
+
Index: work-pv/arch/x86_64/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/arch/x86_64/Makefile
+++ work-pv/arch/x86_64/Makefile
@@ -84,6 +84,7 @@ core-y					+=3D arch/x86_64/kernel/ \
 core-$(CONFIG_IA32_EMULATION)		+=3D arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+=3D arch/x86_64/pci/
 drivers-$(CONFIG_OPROFILE)		+=3D arch/x86_64/oprofile/
+drivers-$(CONFIG_LGUEST_GUEST)		+=3D arch/x86_64/lguest/
 =

 boot :=3D arch/x86_64/boot
 =

Index: work-pv/include/asm-x86_64/lguest.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/include/asm-x86_64/lguest.h
@@ -0,0 +1,350 @@
+#ifndef _LGUEST_H_
+#define _LGUEST_H_
+#include <asm/desc.h>
+#include <asm/hw_irq.h>
+#include <linux/futex.h>
+#include <asm/lguest_user.h>
+
+/* XXX: Come up with better magic later on */
+#define LGUEST_MAGIC_R13 0x1
+#define LGUEST_MAGIC_R14 0x2
+#define LGUEST_MAGIC_R15 0x3
+
+#define LGUEST_MAX_VCPUS 64
+
+#define LGUEST_PGDS_PER_VCPU 8
+#define LGUEST_PGDIRS (LGUEST_MAX_VCPUS * LGUEST_PGDS_PER_VCPU)
+
+#define LGUEST_IRQS 32
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
+#define LHCALL_TIMER_START	10
+#define LHCALL_HALT		11
+#define LHCALL_GET_WALLCLOCK	12
+#define LHCALL_BIND_DMA		13
+#define LHCALL_SEND_DMA		14
+#define LHCALL_FLUSH_TLB_SIG	15
+#define LHCALL_SET_PTE		16
+#define LHCALL_SET_PMD		17
+#define LHCALL_SET_PUD		18
+#define LHCALL_SET_PGD		19
+#define LHCALL_CLEAR_PTE	20
+#define LHCALL_CLEAR_PMD	21
+#define LHCALL_CLEAR_PUD	22
+#define LHCALL_CLEAR_PGD	23
+#define LHCALL_LOAD_TLS		24
+#define LHCALL_RDMSR		25
+#define LHCALL_WRMSR		26
+#define LHCALL_IRET		27
+
+#define LHCALL_PRINT		60
+#define LHCALL_DEBUG_ME		99
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
+struct lguest_vcpu;
+
+struct lguest_dma_info
+{
+	struct list_head list;
+	union futex_key key;
+	unsigned long dmas;
+	u16 next_dma;
+	u16 num_dmas;
+	u32 guest_id;
+	u8 interrupt; 	/* 0 when not registered */
+};
+
+
+/* these must be powers of two */
+#define PUD_HASH_SIZE 256
+#define PMD_HASH_SIZE 256
+#define PTE_HASH_SIZE 256
+
+#define LGUEST_PGD_BUSY_FL	(1<<0)
+#define LGUEST_PGD_MASTER_FL	(1<<1)
+#define LGUEST_PGD_LINK_FL	(1<<2)
+
+#define LGUEST_PUD_KERNEL_FL	(1<<1)
+#define LGUEST_PMD_KERNEL_FL	(1<<1)
+#define LGUEST_PTE_KERNEL_FL	(1<<1)
+
+struct lguest_pgd {
+	struct list_head list;
+	u64 cr3;
+	u64 *pgdir;
+	u64 *user_pgdir;
+	unsigned count;
+	unsigned flags;
+};
+
+struct lguest_pud {
+	struct list_head list;
+	struct lguest_pgd *pgdir;
+	u64 gpud;  /* guest pud */
+	unsigned flags;
+	unsigned idx;
+};
+
+struct lguest_pmd {
+	struct list_head list;
+	struct lguest_pud *pudir;
+	u64 gpmd;  /* guest pmd */
+	unsigned flags;
+	unsigned idx;
+};
+
+struct lguest_pte {
+	struct list_head list;
+	struct lguest_pmd *pmdir;
+	u64 gpte;  /* guest pte */
+	unsigned flags;
+	unsigned idx;
+};
+
+struct lguest_guest_info {
+	struct lguest_data __user *lguest_data;
+	struct task_struct *tsk;
+	struct mm_struct *mm;
+	u32 guest_id;
+	u64 pfn_limit;
+	u64 start_kernel_map;
+	u64 page_offset;
+
+	int halted;
+	/* does it really belong here? */
+	char *dead;
+#if 0
+	unsigned long noirq_start, noirq_end;
+#endif
+	int dma_is_pending;
+	unsigned long pending_dma; /* struct lguest_dma */
+	unsigned long pending_addr; /* address they're sending to */
+
+	struct lguest_pgd kpgdir;
+	struct lguest_pgd pgdirs[LGUEST_PGDIRS];
+	struct list_head pgd_list;
+	struct list_head pud_hash[PUD_HASH_SIZE];
+	struct list_head pmd_hash[PMD_HASH_SIZE];
+	struct list_head pte_hash[PTE_HASH_SIZE];
+	struct mutex page_lock;
+
+	int timer_on;
+	int last_timer;
+
+	/* Cached wakeup: we hold a reference to this task. */
+	struct task_struct *wake;
+
+	struct lguest_dma_info dma[LGUEST_MAX_DMA];
+
+	struct lguest_vcpu *vcpu[LGUEST_MAX_VCPUS];
+};
+
+/* copied from old lguest code. Not sure if it's the best layout for us */
+struct lguest_regs
+{
+	u64 cr3;			/*   0 ( 0x0) */
+        /* Manually saved part. */
+        u64 rbx, rcx, rdx;		/*   8 ( 0x8) */
+        u64 rsi, rdi, rbp;		/*  32 (0x20) */
+        u64 r8, r9, r10, r11;		/*  56 (0x38) */
+        u64 r12, r13, r14, r15;		/*  88 (0x58) */
+        u64 rax;			/* 120 (0x78) */
+        u64 fs; /* ds; */		/* 128 (0x80) */
+        u64 trapnum, errcode;		/* 136 (0x88) */
+        /* Trap pushed part */
+        u64 rip;			/* 152 (0x98) */
+        u64 cs;				/* 160 (0xa0) */
+        u64 rflags;			/* 168 (0xa8) */
+        u64 rsp;			/* 176 (0xb0) */
+	u64 ss; /* Crappy Segment! */	/* 184 (0xb8) */
+	/* size =3D 192  (0xc0) */
+	char size[0];
+};
+
+struct lguest_tss_struct {
+	u32 reserved1;
+	u64 rsp0;
+	u64 rsp1;
+	u64 rsp2;
+	u64 reserved2;
+	u64 ist[7];
+	u32 reserved3;
+	u32 reserved4;
+	u16 reserved5;
+	u16 io_bitmap_base;
+	/* we don't let the guest have io privileges (yet) */
+	unsigned long io_bitmap[1];
+} __attribute__((packed)) ____cacheline_aligned;
+
+struct lguest_vcpu {
+	unsigned long host_syscall;
+	unsigned long guest_syscall;
+
+	/* Must be 16 bytes aligned at regs+sizeof(regs) */
+	struct lguest_regs regs;
+
+	struct lguest_vcpu *vcpu; /* pointer to itself */
+	unsigned long debug;
+	unsigned long magic;
+	unsigned int  id;
+	unsigned long host_stack;
+	unsigned long guest_stack;
+	unsigned long host_cr3;
+	unsigned long host_page;
+	struct desc_ptr host_gdt;
+	u16 host_gdt_buff[3];
+	struct desc_ptr host_idt;
+	u16 host_idt_buff[3];
+	unsigned long host_gdt_ptr;
+	/* Save rax on interrupts, it's used for iret hcall */
+	unsigned long rax;
+
+	/* Host save gs base pointer */
+	unsigned long host_gs_a;
+	unsigned long host_gs_d;
+
+	/* save host process gs base pointer */
+	unsigned long host_proc_gs_a;
+	unsigned long host_proc_gs_d;
+
+	/* save guest gs base pointer */
+	unsigned long guest_gs_a;
+	unsigned long guest_gs_d;
+
+	/* used for guest calling swapgs */
+	unsigned long guest_gs_shadow_a;
+	unsigned long guest_gs_shadow_d;
+
+	struct lguest_pgd *pgdir;
+
+	struct desc_ptr gdt; /* address of the GDT at this vcpu */
+	u16 gdt_buff[3];
+	struct desc_struct gdt_table[GDT_ENTRIES];
+
+	struct desc_ptr idt; /* address of the IDT at this vcpu */
+	u16 idt_buff[3];
+	struct gate_struct idt_table[IDT_ENTRIES];
+
+	struct lguest_guest_info *guest;
+
+	struct lguest_tss_struct tss;
+
+	unsigned long ts;
+
+	/* host ist 7 - we use it to prevent the NMI race */
+	unsigned long host_ist;
+
+	/* only for those above FIRST_EXTERNAL_VECTOR */
+	DECLARE_BITMAP(irqs_pending, LGUEST_IRQS);
+	/* those are general. We catch every possible interrupt */
+	DECLARE_BITMAP(interrupt_disabled, LGUEST_IRQS + FIRST_EXTERNAL_VECTOR);
+	unsigned long interrupt[LGUEST_IRQS + FIRST_EXTERNAL_VECTOR];
+
+	/* nmi trampoline storage */
+
+	struct lguest_regs nmi_regs;
+	unsigned long nmi_gs_a;
+	unsigned long nmi_gs_d;
+	unsigned long nmi_gs_shadow_a;
+	unsigned long nmi_gs_shadow_d;
+	struct desc_ptr nmi_gdt;
+	u16 nmi_gdt_buff[3];
+
+	/* set when we take an nmi */
+	unsigned long nmi_sw;
+
+	/* is this enough? */
+	char nmi_stack[1048];
+	char nmi_stack_end[0];
+	char gpf_stack[1048];
+	char gpf_stack_end[0];
+	char df_stack[1048];
+	char df_stack_end[0];
+};
+
+
+#define LHCALL_RING_SIZE 64
+struct hcall_ring
+{
+	u32 eax, edx, ebx, ecx;
+};
+
+struct lguest_text_ptr {
+	unsigned long next; /* guest pa address of next pointer */
+	unsigned long start;
+	unsigned long end;
+};
+
+struct lguest_data
+{
+/* Fields which change during running: */
+	/* 512 =3D=3D enabled (same as eflags) */
+	unsigned int irq_enabled;
+	/* Blocked interrupts. */
+	DECLARE_BITMAP(interrupts, LGUEST_IRQS);
+
+	/* Last (userspace) address we got a GPF & reloaded gs. */
+	unsigned int gs_gpf_eip;
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
+	u32 guest_id;
+
+/* Fields initialized by the guest at boot: */
+	/* Instruction range to suppress interrupts even if enabled */
+#if 0
+	unsigned long noirq_start, noirq_end;
+#endif
+	unsigned long start_kernel_map;
+	unsigned long page_offset;
+	unsigned long text; /* pa address of lguest_text_ptr addresses */
+
+/* If the kernel has kallsyms, we can use it to do backtraces of a guest */
+	unsigned long kallsyms_addresses;
+	unsigned long kallsyms_num_syms;
+	unsigned long kallsyms_names;
+	unsigned long kallsyms_token_table;
+	unsigned long kallsyms_token_index;
+	unsigned long kallsyms_markers;
+
+	unsigned long return_address;
+};
+
+extern struct lguest_data lguest_data;
+extern struct lguest_device_desc *lguest_devices; /* Just past max_pfn */
+int run_guest(struct lguest_vcpu *vcpu, char *__user user);
+
+#endif

--
