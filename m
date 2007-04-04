From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] lguest32 kallsyms backtrace of guest.
Date: Wed, 04 Apr 2007 14:23:43 -0400
Message-ID: <1175711023.9371.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This is taken from the work I did on lguest64.

When killing a guest, we read the guest stack to do a nice back trace of
the guest and send it via printk to the host.

So instead of just getting an error message from the lguest launcher of:

lguest: bad read address 537012178 len 1

I also get in my dmesg:

called from  [<c0405f30>] show_trace_log_lvl+0x1a/0x2f
 [<c04069aa>] show_trace+0x12/0x14
 [<c0406a03>] dump_stack+0x16/0x18
 [<f8c746de>] lguest_dump_lg_regs+0x22/0x13c [lg]
 [<f8c7131b>] lgread+0x59/0x90 [lg]
 [<f8c715bd>] run_guest+0x26b/0x406 [lg]
 [<f8c739be>] read+0x73/0x7d [lg]
 [<c04825e9>] vfs_read+0xad/0x161
 [<c0482a75>] sys_read+0x3d/0x61
 [<c0404f34>] syscall_call+0x7/0xb
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[<f8c7131b>] lgread+0x59/0x90 [lg]
Printing LG 0 regs cr3: 021eb000
EIP: 0061:  [<00000000e00227d2>]
ESP: 0069:c236fe3c  EFLAGS: 00010202
EAX: 00000004 EBX: e001fb20 ECX: 00000008 EDX: 000003f2
ESI: e001ee00 EDI: e001fb60 EBP: c236fea0
 CR2: 1278000  lguest_data->cr2: 80011380
errcode: 0   trapnum: d
Stack Dump:
 [<00000000c1042b7a>] trace_hardirqs_on+0x125/0x149
 [<00000000c123b0ea>] wait_for_completion+0x90/0x98
 [<00000000c123bddc>] __mutex_unlock_slowpath+0x129/0x13e
 [<00000000c1048769>] unlock_cpu_hotplug+0x62/0x64
 [<00000000c104b5b6>] sys_init_module+0x14e3/0x162c
 [<00000000c1081d44>] do_sync_read+0xc2/0xff
 [<00000000c1004f85>] restore_nocheck+0x12/0x15
 [<00000000c1004f34>] syscall_call+0x7/0xb


TODO:

  - Clean up a little (still has stuff from lguest64 in it).
  - Perhaps make a config option or runtime switch to turn it off.
  - Send to the launcher the dump instead of printk.
  - make modules work too.

Also I need to change the %u of the bad read print to a %x, because
seeing 0x200227d2 is better than seeing 537012178 for addresses.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.21-rc5-mm2/drivers/lguest/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5-mm2.orig/drivers/lguest/Makefile
+++ linux-2.6.21-rc5-mm2/drivers/lguest/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_LGUEST_GUEST) +=3D lguest.o l
 # Host requires the other files, which can be a module.
 obj-$(CONFIG_LGUEST)	+=3D lg.o
 lg-objs :=3D core.o hypercalls.o page_tables.o interrupts_and_traps.o \
-	segments.o io.o lguest_user.o hypervisor.o
+	segments.o io.o lguest_user.o hypervisor.o lguest_debug.o
Index: linux-2.6.21-rc5-mm2/drivers/lguest/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5-mm2.orig/drivers/lguest/core.c
+++ linux-2.6.21-rc5-mm2/drivers/lguest/core.c
@@ -210,6 +210,28 @@ int lguest_address_ok(const struct lgues
 }
 =

 /* Just like get_user, but don't let guest access lguest binary. */
+u8 lgread_u8(struct lguest *lg, u32 addr)
+{
+	u8 val =3D 0;
+
+	/* Don't let them access lguest binary */
+	if (!lguest_address_ok(lg, addr)
+	    || get_user(val, (u32 __user *)addr) !=3D 0)
+		kill_guest(lg, "bad read address %u", addr);
+	return val;
+}
+
+u16 lgread_u16(struct lguest *lg, u32 addr)
+{
+	u16 val =3D 0;
+
+	/* Don't let them access lguest binary */
+	if (!lguest_address_ok(lg, addr)
+	    || get_user(val, (u32 __user *)addr) !=3D 0)
+		kill_guest(lg, "bad read address %u", addr);
+	return val;
+}
+
 u32 lgread_u32(struct lguest *lg, u32 addr)
 {
 	u32 val =3D 0;
Index: linux-2.6.21-rc5-mm2/drivers/lguest/lg.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5-mm2.orig/drivers/lguest/lg.h
+++ linux-2.6.21-rc5-mm2/drivers/lguest/lg.h
@@ -176,6 +176,8 @@ extern struct mutex lguest_lock;
 /* core.c: */
 /* Entry points in hypervisor */
 const unsigned long *__lguest_default_idt_entries(void);
+u8 lgread_u8(struct lguest *lg, u32 addr);
+u16 lgread_u16(struct lguest *lg, u32 addr);
 u32 lgread_u32(struct lguest *lg, u32 addr);
 void lgwrite_u32(struct lguest *lg, u32 val, u32 addr);
 void lgread(struct lguest *lg, void *buf, u32 addr, unsigned bytes);
@@ -238,6 +240,7 @@ int hypercall(struct lguest *info, struc
 #define kill_guest(lg, fmt...)					\
 do {								\
 	if (!(lg)->dead) {					\
+		lguest_dump_lg_regs(lg);			\
 		(lg)->dead =3D kasprintf(GFP_ATOMIC, fmt);	\
 		if (!(lg)->dead)				\
 			(lg)->dead =3D (void *)1;			\
@@ -248,5 +251,11 @@ static inline unsigned long guest_pa(str
 {
 	return vaddr - lg->page_offset;
 }
+
+/* lguest_debug.c */
+void lguest_print_address(struct lguest *lg, unsigned long address);
+void lguest_dump_trace(struct lguest *lg, struct lguest_regs *regs);
+void lguest_dump_lg_regs(struct lguest *lg);
+
 #endif	/* __ASSEMBLY__ */
 #endif	/* _LGUEST_H */
Index: linux-2.6.21-rc5-mm2/drivers/lguest/lguest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5-mm2.orig/drivers/lguest/lguest.c
+++ linux-2.6.21-rc5-mm2/drivers/lguest/lguest.c
@@ -48,6 +48,14 @@ extern const char lgstart_iret[], lgend_
 extern asmlinkage void lguest_maybe_init(void);
 extern void lguest_iret(void);
 =

+/* For back tracing from the HV */
+extern const unsigned long kallsyms_addresses[] __attribute__((weak));
+extern const unsigned long kallsyms_num_syms __attribute__((weak));
+extern const u8 kallsyms_names[] __attribute__((weak));
+extern const u8 kallsyms_token_table[] __attribute__((weak));
+extern const u16 kallsyms_token_index[] __attribute__((weak));
+extern const unsigned long kallsyms_markers[] __attribute__((weak));
+
 struct lguest_data lguest_data =3D {
 	.hcall_status =3D { [0 ... LHCALL_RING_SIZE-1] =3D 0xFF },
 	.noirq_start =3D (u32)lguest_noirq_start,
@@ -56,6 +64,7 @@ struct lguest_data lguest_data =3D {
 };
 struct lguest_device_desc *lguest_devices;
 static __initdata const struct lguest_boot_info *boot =3D __va(0);
+static struct lguest_text_ptr code_stack[2];
 =

 static int lazy_mode;
 static void lguest_lazy_mode(int mode)
@@ -468,6 +477,22 @@ __init void lguest_init(void)
 	paravirt_ops.set_lazy_mode =3D lguest_lazy_mode;
 	paravirt_ops.wbinvd =3D lguest_wbinvd;
 =

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
 	hcall(LHCALL_LGUEST_INIT, __pa(&lguest_data), 0, 0);
 	strncpy(boot_command_line, boot->cmdline, COMMAND_LINE_SIZE);
 =

Index: linux-2.6.21-rc5-mm2/drivers/lguest/lguest_debug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.21-rc5-mm2/drivers/lguest/lguest_debug.c
@@ -0,0 +1,458 @@
+/*
+    lguest debug utils. Modified from various other parts of Linux.
+    What was modified is Copyright 2007 Steven Rostedt, Red Hat
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
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/freezer.h>
+#include <linux/kallsyms.h>
+#include <asm/paravirt.h>
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include "lg.h"
+
+#if 1
+#define DEBUG_DUMP_STACK() dump_stack()
+#else
+#define DEBUG_DUMP_STACK() do { } while(0)
+#endif
+
+int lguest_debug;
+
+static DEFINE_SPINLOCK(lgdebug_print_lock);
+#define LGDEBUG_BUF_SIZ 1024
+static char lgdebug_print_buf[LGDEBUG_BUF_SIZ];
+
+void lgdebug_vprint(const char *fmt, va_list ap)
+{
+	unsigned long flags;
+
+	if (!lguest_debug)
+		return;
+
+	spin_lock_irqsave(&lgdebug_print_lock, flags);
+	vsnprintf(lgdebug_print_buf, LGDEBUG_BUF_SIZ-1, fmt, ap);
+	printk("%s", lgdebug_print_buf);
+	spin_unlock_irqrestore(&lgdebug_print_lock, flags);
+}
+
+void lgdebug_print(const char *fmt, ...)
+{
+	va_list ap;
+
+	if (!lguest_debug)
+		return;
+
+	/* irq save? */
+	va_start(ap, fmt);
+	lgdebug_vprint(fmt, ap);
+	va_end(ap);
+}
+
+void lgdebug_lprint(unsigned flags, const char *fmt, ...)
+{
+	va_list ap;
+
+	if (!(lguest_debug & flags))
+		return;
+
+	va_start(ap, fmt);
+	lgdebug_vprint(fmt, ap);
+	va_end(ap);
+}
+
+void lgdebug_lvprint(unsigned flags, const char *fmt, va_list ap)
+{
+	if (!(lguest_debug & flags))
+		return;
+
+	lgdebug_vprint(fmt, ap);
+}
+
+void lguest_dump_lg_regs(struct lguest *lg)
+{
+	struct lguest_regs *regs =3D lg->regs;
+	struct pgdir *pgdir =3D &lg->pgdirs[lg->pgdidx];
+	unsigned long cr2, data_cr2;
+
+	printk("called from ");
+	DEBUG_DUMP_STACK();
+	print_ip_sym((unsigned long)__builtin_return_address(0));
+	printk("Printing LG %d regs cr3: %08lx\n",
+	       lg->guestid, pgdir->cr3);
+	printk("EIP: %04x: ", regs->cs & 0xffff);
+	lguest_print_address(lg, regs->eip);
+	printk("ESP: %04x:%08x  EFLAGS: %08x\n", regs->ss, regs->esp,
+		regs->eflags);
+	printk("EAX: %08x EBX: %08x ECX: %08x EDX: %08x\n",
+	       regs->eax, regs->ebx, regs->ecx, regs->edx);
+	printk("ESI: %08x EDI: %08x EBP: %08x\n",
+	       regs->esi, regs->edi, regs->ebp);
+#if 0
+	printk("FS %04llx: Base: %016lx  Desc: %08lx\n",
+	       regs->fs, vcpu->guest_fs_base, vcpu->guest_fs_desc);
+#endif
+
+	if (get_user(data_cr2, &lg->lguest_data->cr2))
+		data_cr2 =3D 0;
+	cr2 =3D read_cr2();
+	printk(" CR2: %lx  lguest_data->cr2: %lx\n", cr2, data_cr2);
+
+	printk("errcode: %x   trapnum: %x\n",
+	       regs->errcode, regs->trapnum);
+
+	lguest_dump_trace(lg, regs);
+}
+
+struct guest_ksym_stuff {
+	unsigned long *addresses;
+	unsigned long num_syms;
+	u8 *names;
+	u8 *token_table;
+	u16 *token_index;
+	unsigned long *markers;
+};
+
+static struct lguest_text_ptr *get_text_segs(struct lguest *lg)
+{
+	struct lguest_text_ptr *segs, **p;
+	struct lguest_text_ptr *g;
+	unsigned long addr;
+	int i;
+
+	if (!lg->lguest_data)
+		return NULL;
+
+	addr =3D lgread_u32(lg, (unsigned long)&lg->lguest_data->text);
+	if (!addr)
+		return NULL;
+
+	g =3D (struct lguest_text_ptr*)addr;
+
+	p =3D &segs;
+
+	/* only allow for 10 segs */
+	for (i=3D0; i < 10; i++) {
+		*p =3D kmalloc(sizeof(*segs), GFP_KERNEL);
+		if (!*p)
+			goto free_me;
+		(*p)->start =3D lgread_u32(lg, (u32)&g->start);
+		(*p)->end =3D lgread_u32(lg, (u32)&g->end);
+		addr =3D lgread_u32(lg, (u32)&g->next);
+		p =3D (struct lguest_text_ptr**)&((*p)->next);
+		if (!addr)
+			break;
+		g =3D (struct lguest_text_ptr*)addr;
+	}
+	*p =3D NULL;
+
+	return segs;
+
+free_me:
+	while (segs) {
+		g =3D (struct lguest_text_ptr*)segs->next;
+		kfree(segs);
+		segs =3D g;
+	}
+	return NULL;
+}
+
+static int is_text_seg(struct lguest_text_ptr *segs, unsigned long addr)
+{
+	while (segs) {
+		if (addr >=3D segs->start &&
+		    addr <=3D segs->end)
+			return 1;
+		segs =3D (struct lguest_text_ptr*)segs->next;
+	}
+	return 0;
+}
+
+static void put_text_segs(struct lguest_text_ptr *segs)
+{
+	struct lguest_text_ptr *p;
+
+	while (segs) {
+		p =3D (struct lguest_text_ptr*)segs->next;
+		kfree(segs);
+		segs =3D p;
+	}
+}
+
+static unsigned int expand_symbol(struct lguest *lg,
+				  struct guest_ksym_stuff *kstuff,
+				  unsigned int off, char *result)
+{
+	int len, skipped_first =3D 0;
+	const u8 *tptr, *data;
+
+	/* get the compressed symbol length from the first symbol byte */
+	data =3D &kstuff->names[off];
+
+	len =3D lgread_u8(lg, (unsigned long)data);
+
+	data++;
+
+	/* update the offset to return the offset for the next symbol on
+	 * the compressed stream */
+	off +=3D len + 1;
+
+	/* for every byte on the compressed symbol data, copy the table
+	   entry for that byte */
+	while(len) {
+		u8 idx;
+		u16 tok;
+		idx =3D lgread_u8(lg, (unsigned long)data);
+		tok =3D lgread_u16(lg, (unsigned long)(&kstuff->token_index[idx]));
+		tptr =3D &kstuff->token_table[ tok ];
+		data++;
+		len--;
+
+		idx =3D lgread_u8(lg, (unsigned long)tptr);
+		while (idx) {
+			if(skipped_first) {
+				*result =3D idx;
+				result++;
+			} else
+				skipped_first =3D 1;
+			tptr++;
+			idx =3D lgread_u8(lg, (unsigned long)tptr);
+		}
+	}
+
+	*result =3D '\0';
+
+	/* return to offset to the next symbol */
+	return off;
+}
+
+static unsigned long get_symbol_pos(struct lguest *lg,
+				    struct guest_ksym_stuff *kstuff,
+				    unsigned long addr,
+				    unsigned long *symbolsize,
+				    unsigned long *offset)
+{
+	unsigned long symbol_start =3D 0, symbol_end =3D 0;
+	unsigned long i, low, high, mid;
+
+	/* do a binary search on the sorted kallsyms_addresses array */
+	low =3D 0;
+	high =3D kstuff->num_syms;
+
+	while (high - low > 1) {
+		mid =3D (low + high) / 2;
+		if (kstuff->addresses[mid] <=3D addr)
+			low =3D mid;
+		else
+			high =3D mid;
+	}
+
+	/*
+	 * search for the first aliased symbol. Aliased
+	 * symbols are symbols with the same address
+	 */
+	while (low && kstuff->addresses[low-1] =3D=3D kstuff->addresses[low])
+		--low;
+
+	symbol_start =3D kstuff->addresses[low];
+
+	/* Search for next non-aliased symbol */
+	for (i =3D low + 1; i < kstuff->num_syms; i++) {
+		if (kstuff->addresses[i] > symbol_start) {
+			symbol_end =3D kstuff->addresses[i];
+			break;
+		}
+	}
+
+	/* if we found no next symbol, we use the end of the section */
+	if (!symbol_end) {
+		return (unsigned long)(-1UL);
+#if 0
+		if (is_kernel_inittext(addr))
+			symbol_end =3D (unsigned long)_einittext;
+		else if (all_var)
+			symbol_end =3D (unsigned long)_end;
+		else
+			symbol_end =3D (unsigned long)_etext;
+#endif
+	}
+
+	*symbolsize =3D symbol_end - symbol_start;
+	*offset =3D addr - symbol_start;
+
+	return low;
+}
+
+static int is_ksym_addr(struct lguest *lg,
+			unsigned long addr)
+{
+	/* need to look up the segs */
+	return 1;
+}
+
+static unsigned int get_symbol_offset(struct lguest *lg,
+				      struct guest_ksym_stuff *kstuff,
+				      unsigned long pos)
+{
+	const u8 *name;
+	int i;
+	unsigned long idx;
+
+	idx =3D lgread_u32(lg, (unsigned long)&kstuff->markers[pos>>8]);
+
+	/* use the closest marker we have. We have markers every 256 positions,
+	 * so that should be close enough */
+	name =3D &kstuff->names[ idx ];
+
+	/* sequentially scan all the symbols up to the point we're searching for.
+	 * Every symbol is stored in a [<len>][<len> bytes of data] format, so we
+	 * just need to add the len to the current pointer for every symbol we
+	 * wish to skip */
+	for(i =3D 0; i < (pos&0xFF); i++) {
+		u8 c;
+		c =3D lgread_u8(lg, (unsigned long)name);
+		name =3D name + c + 1;
+	}
+
+	return name - kstuff->names;
+}
+
+static const char *lguest_syms_lookup(struct lguest *lg,
+				      unsigned long addr,
+				      unsigned long *symbolsize,
+				      unsigned long *offset,
+				      char **modname, char *namebuf)
+{
+	struct lguest_data *data =3D lg->lguest_data;
+	struct guest_ksym_stuff kstuff;
+	const char *msym;
+	unsigned long *ptr;
+	int i;
+
+	kstuff.addresses =3D (unsigned long*)lgread_u32(lg,
+					      (unsigned long)&data->kallsyms_addresses);
+	kstuff.num_syms =3D lgread_u32(lg, (unsigned long)&data->kallsyms_num_sym=
s);
+	kstuff.names =3D (u8*)lgread_u32(lg, (unsigned long)&data->kallsyms_names=
);
+	kstuff.token_table =3D (u8*)lgread_u32(lg,
+					     (unsigned long)&data->kallsyms_token_table);
+	kstuff.token_index =3D (u16*)lgread_u32(lg,
+					      (unsigned long)&data->kallsyms_token_index);
+	kstuff.markers =3D (unsigned long*)lgread_u32(lg,
+					       (unsigned long)&data->kallsyms_markers);
+
+	if (!kstuff.addresses || !kstuff.num_syms || !kstuff.names ||
+	    !kstuff.token_table || !kstuff.token_index || !kstuff.markers)
+		return NULL;
+
+	/* FIXME: Validate all the kstuff here!! */
+
+	ptr =3D kmalloc(sizeof(unsigned long)*kstuff.num_syms, GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	for (i=3D0; i < kstuff.num_syms; i++) {
+		/* FIXME: do this better! */
+		ptr[i] =3D lgread_u32(lg, (unsigned long)&kstuff.addresses[i]);
+		if (i && ptr[i] < ptr[i-1]) {
+			kill_guest(lg, "bad kallsyms table\n");
+			kstuff.addresses =3D ptr;
+			goto out;
+		}
+	}
+	kstuff.addresses =3D ptr;
+
+	namebuf[KSYM_NAME_LEN] =3D 0;
+	namebuf[0] =3D 0;
+
+	if (is_ksym_addr(lg, addr)) {
+		unsigned long pos;
+
+		pos =3D get_symbol_pos(lg, &kstuff, addr, symbolsize, offset);
+		if (pos =3D=3D (unsigned long)(-1UL))
+			goto out;
+
+		/* Grab name */
+		expand_symbol(lg, &kstuff,
+			      get_symbol_offset(lg, &kstuff, pos), namebuf);
+		*modname =3D NULL;
+		kfree(kstuff.addresses);
+		return namebuf;
+	}
+
+	/* see if it's in a module */
+	msym =3D module_address_lookup(addr, symbolsize, offset, modname);
+	if (msym) {
+		kfree(kstuff.addresses);
+		return strncpy(namebuf, msym, KSYM_NAME_LEN);
+	}
+
+out:
+	kfree(kstuff.addresses);
+	return NULL;
+}
+
+void lguest_print_address(struct lguest *lg, unsigned long address)
+{
+	unsigned long offset =3D 0, symsize;
+	const char *symname;
+	char *modname;
+	char *delim =3D ":";
+	char namebuf[KSYM_NAME_LEN+1];
+
+	symname =3D lguest_syms_lookup(lg, address, &symsize, &offset,
+				     &modname, namebuf);
+	if (!symname) {
+		printk(" [<%016lx>]\n", address);
+		return;
+	}
+	if (!modname)
+		modname =3D delim =3D "";
+	printk(" [<%016lx>] %s%s%s%s+0x%lx/0x%lx\n",
+	       address, delim, modname, delim, symname, offset, symsize);
+
+}
+
+void lguest_dump_trace(struct lguest *lg, struct lguest_regs *regs)
+{
+	unsigned long stack =3D regs->esp;
+	unsigned long stack_end =3D (regs->esp & PAGE_MASK) + PAGE_SIZE;
+	unsigned long addr;
+	struct lguest_text_ptr *segs;
+
+	printk("Stack Dump:\n");
+	if (stack < lg->page_offset) {
+		printk("  <USER STACK>\n");
+		goto out;
+	}
+
+	segs =3D get_text_segs(lg);
+	if (!segs)
+		return;
+
+	for (; stack < stack_end; stack +=3D sizeof(stack)) {
+		addr =3D lgread_u32(lg, guest_pa(lg, stack));
+		if (is_text_seg(segs, addr)) {
+			lguest_print_address(lg, addr);
+		}
+	}
+
+	put_text_segs(segs);
+
+out:
+	printk("=3D=3D=3D=3D=3D=3D=3D\n");
+}
+
Index: linux-2.6.21-rc5-mm2/include/linux/lguest.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5-mm2.orig/include/linux/lguest.h
+++ linux-2.6.21-rc5-mm2/include/linux/lguest.h
@@ -54,6 +54,13 @@ struct hcall_ring
 	u32 eax, edx, ebx, ecx;
 };
 =

+/* for kallsyms dumping */
+struct lguest_text_ptr {
+	unsigned long next; /* guest pa address of next pointer */
+	unsigned long start;
+	unsigned long end;
+};
+
 /* All the good stuff happens here: guest registers it with LGUEST_INIT */
 struct lguest_data
 {
@@ -76,6 +83,16 @@ struct lguest_data
 	/* ID of this guest (used by network driver to set ethernet address) */
 	u16 guestid;
 =

+	/* pa address of lguest_text_ptr addresses */
+	unsigned long text;
+/* If the kernel has kallsyms, we can use it to do backtraces of a guest */
+	unsigned long kallsyms_addresses;
+	unsigned long kallsyms_num_syms;
+	unsigned long kallsyms_names;
+	unsigned long kallsyms_token_table;
+	unsigned long kallsyms_token_index;
+	unsigned long kallsyms_markers;
+
 /* Fields initialized by the guest at boot: */
 	/* Instruction range to suppress interrupts even if enabled */
 	unsigned long noirq_start, noirq_end;
