From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 04/13] Useful debugging
Date: Thu, 08 Mar 2007 12:38:51 -0500
Message-ID: <1173375531.32170.6.camel@localhost.localdomain>
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

plain text document attachment (lguest64-debug-utils.patch)
This patch contains some nice features used to debug the lguest64 guest.

It has a way to print page tables for either the host or the guest.

It incorporates kallsyms, and can do a nice back trace of a guest
when it crashes.  The guest needs kallsyms obviously compiled in.
Note: This code needs to be fixed to be more secure!

Implements a lgdebug_print that can be used within the host that
will only print when lguest_debug is true.  There's a hypercall
that the guest can call to turn this on.

There's also a function called lguest_set_debug(n) the makes it
easy for the guest to turn it on. Where n=3D1 will turn on debugging
prints, and n=3D0 will turn it off. (well n!=3D0 will turn it on).

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Cc: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>



Index: work-pv/arch/x86_64/lguest/lguest_debug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/lguest_debug.c
@@ -0,0 +1,532 @@
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
+#include <asm/hv_vm.h>
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include "lguest.h"
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
+void lguest_dump_vcpu_regs(struct lguest_vcpu *vcpu)
+{
+	struct lguest_regs *regs =3D &vcpu->regs;
+
+	printk("Printing VCPU %d regs cr3: %016llx\n", vcpu->id, regs->cr3);
+	printk("RIP: %04llx: ", regs->cs & 0xffff);
+	lguest_print_address(vcpu, regs->rip);
+	printk("RSP: %04llx:%016llx  EFLAGS: %08llx\n", regs->ss, regs->rsp,
+		regs->rflags);
+	printk("RAX: %016llx RBX: %016llx RCX: %016llx\n",
+	       regs->rax, regs->rbx, regs->rcx);
+	printk("RDX: %016llx RSI: %016llx RDI: %016llx\n",
+	       regs->rdx, regs->rsi, regs->rdi);
+	printk("RBP: %016llx R08: %016llx R09: %016llx\n",
+	       regs->rbp, regs->r8, regs->r9);
+	printk("R10: %016llx R11: %016llx R12: %016llx\n",
+	       regs->r10, regs->r11, regs->r12);
+	printk("R13: %016llx R14: %016llx R15: %016llx\n",
+	       regs->r13, regs->r14, regs->r15);
+
+	printk("errcode: %llx   trapnum: %llx\n",
+	       regs->errcode, regs->trapnum);
+
+	lguest_dump_trace(vcpu, regs);
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
+static struct lguest_text_ptr *get_text_segs(struct lguest_vcpu *vcpu)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_text_ptr *segs, **p;
+	struct lguest_text_ptr *g;
+	unsigned long addr;
+	int i;
+
+	if (!linfo->lguest_data)
+		return NULL;
+
+	addr =3D lhread_u64(vcpu, (u64)&linfo->lguest_data->text);
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
+		(*p)->start =3D lhread_u64(vcpu, (u64)&g->start);
+		(*p)->end =3D lhread_u64(vcpu, (u64)&g->end);
+		addr =3D lhread_u64(vcpu, (u64)&g->next);
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
+static unsigned int expand_symbol(struct lguest_vcpu *vcpu,
+				  struct guest_ksym_stuff *kstuff,
+				  unsigned int off, char *result)
+{
+	int len, skipped_first =3D 0;
+	const u8 *tptr, *data;
+
+	/* get the compressed symbol length from the first symbol byte */
+	data =3D &kstuff->names[off];
+
+	len =3D lhread_u8(vcpu, (u64)data);
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
+		idx =3D lhread_u8(vcpu, (u64)data);
+		tok =3D lhread_u16(vcpu, (u64)(&kstuff->token_index[idx]));
+		tptr =3D &kstuff->token_table[ tok ];
+		data++;
+		len--;
+
+		idx =3D lhread_u8(vcpu, (u64)tptr);
+		while (idx) {
+			if(skipped_first) {
+				*result =3D idx;
+				result++;
+			} else
+				skipped_first =3D 1;
+			tptr++;
+			idx =3D lhread_u8(vcpu, (u64)tptr);
+		}
+	}
+
+	*result =3D '\0';
+
+	/* return to offset to the next symbol */
+	return off;
+}
+
+static unsigned long get_symbol_pos(struct lguest_vcpu *vcpu,
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
+static int is_ksym_addr(struct lguest_guest_info *linfo,
+			unsigned long addr)
+{
+	/* need to look up the segs */
+	return 1;
+}
+
+static unsigned int get_symbol_offset(struct lguest_vcpu *vcpu,
+				      struct guest_ksym_stuff *kstuff,
+				      unsigned long pos)
+{
+	const u8 *name;
+	int i;
+	unsigned long idx;
+
+	idx =3D lhread_u64(vcpu, (u64)&kstuff->markers[pos>>8]);
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
+		c =3D lhread_u8(vcpu, (u64)name);
+		name =3D name + c + 1;
+	}
+
+	return name - kstuff->names;
+}
+
+static const char *lguest_syms_lookup(struct lguest_vcpu *vcpu,
+				      unsigned long addr,
+				      unsigned long *symbolsize,
+				      unsigned long *offset,
+				      char **modname, char *namebuf)
+{
+	struct lguest_guest_info *linfo =3D vcpu->guest;
+	struct lguest_data *data =3D linfo->lguest_data;
+	struct guest_ksym_stuff kstuff;
+	const char *msym;
+	unsigned long *ptr;
+	int i;
+
+	kstuff.addresses =3D (unsigned long*)lhread_u64(vcpu, (u64)&data->kallsym=
s_addresses);
+	kstuff.num_syms =3D lhread_u64(vcpu, (u64)&data->kallsyms_num_syms);
+	kstuff.names =3D (u8*)lhread_u64(vcpu, (u64)&data->kallsyms_names);
+	kstuff.token_table =3D (u8*)lhread_u64(vcpu, (u64)&data->kallsyms_token_t=
able);
+	kstuff.token_index =3D (u16*)lhread_u64(vcpu, (u64)&data->kallsyms_token_=
index);
+	kstuff.markers =3D (unsigned long*)lhread_u64(vcpu, (u64)&data->kallsyms_=
markers);
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
+		ptr[i] =3D lhread_u64(vcpu, (u64)&kstuff.addresses[i]);
+		if (i && ptr[i] < ptr[i-1]) {
+			kill_guest(linfo, "bad kallsyms table\n");
+			kstuff.addresses =3D ptr;
+			goto out;
+		}
+	}
+	kstuff.addresses =3D ptr;
+
+	namebuf[KSYM_NAME_LEN] =3D 0;
+	namebuf[0] =3D 0;
+
+	if (is_ksym_addr(linfo, addr)) {
+		unsigned long pos;
+
+		pos =3D get_symbol_pos(vcpu, &kstuff, addr, symbolsize, offset);
+		if (pos =3D=3D (unsigned long)(-1UL))
+			goto out;
+
+		/* Grab name */
+		expand_symbol(vcpu, &kstuff,
+			      get_symbol_offset(vcpu, &kstuff, pos), namebuf);
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
+void lguest_print_address(struct lguest_vcpu *vcpu, unsigned long address)
+{
+	unsigned long offset =3D 0, symsize;
+	const char *symname;
+	char *modname;
+	char *delim =3D ":";
+	char namebuf[KSYM_NAME_LEN+1];
+
+	symname =3D lguest_syms_lookup(vcpu, address, &symsize, &offset,
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
+void lguest_dump_trace(struct lguest_vcpu *vcpu, struct lguest_regs *regs)
+{
+	unsigned long stack =3D regs->rsp;
+	unsigned long stack_end =3D (regs->rsp & PAGE_MASK) + PAGE_SIZE;
+	unsigned long start_kernel_map;
+	unsigned long page_offset;
+	unsigned long addr;
+	struct lguest_text_ptr *segs;
+
+	printk("Stack Dump:\n");
+	start_kernel_map =3D vcpu->guest->start_kernel_map;
+	page_offset =3D vcpu->guest->page_offset;
+
+	segs =3D get_text_segs(vcpu);
+	if (!segs)
+		return;
+
+	for (; stack < stack_end; stack +=3D sizeof(stack)) {
+		addr =3D lhread_u64(vcpu, guest_pa(vcpu->guest, stack));
+		if (is_text_seg(segs, addr)) {
+			lguest_print_address(vcpu, addr);
+		}
+	}
+
+	put_text_segs(segs);
+}
+
+static u64 read_page(struct lguest_vcpu *vcpu, u64 page, u64 idx)
+{
+	u64 *ptr;
+
+	if (!vcpu) {
+		ptr =3D __va(page);
+		return ptr[idx];
+	}
+
+	return lhread_u64(vcpu, page+idx*sizeof(u64));
+}
+
+static void print_pte(u64 pte, u64 pgd_idx, u64 pud_idx, u64 pmd_idx, u64 =
pte_idx)
+{
+	printk("           %3llx: %llx\n", pte_idx, pte);
+	printk ("               (%llx)\n",
+		((pgd_idx&(1<<8)?(-1ULL):0ULL)<<48) |
+		(pgd_idx<<PGDIR_SHIFT) |
+		(pud_idx<<PUD_SHIFT) |
+		(pmd_idx<<PMD_SHIFT) |
+		(pte_idx<<PAGE_SHIFT));
+}
+
+static void print_pmd(struct lguest_vcpu *vcpu,
+		      u64 pmd, u64 pgd_idx, u64 pud_idx, u64 pmd_idx)
+{
+	u64 pte;
+	u64 ptr;
+	u64 i;
+
+	printk("        %3llx: %llx\n", pmd_idx, pmd);
+
+	/* 2M page? */
+	if (pmd & (1<<7)) {
+		printk ("            (%llx)\n",
+			((pgd_idx&(1<<8)?(-1ULL):0ULL)<<48) |
+			(pgd_idx<<PGDIR_SHIFT) |
+			(pud_idx<<PUD_SHIFT) |
+			(pmd_idx<<PMD_SHIFT));
+	} else {
+		pte =3D pmd & ~(0xfff) & ~(1UL << 63);
+		for (i=3D0; i < PTRS_PER_PTE; i++) {
+			ptr =3D read_page(vcpu, pte, i);
+			if (ptr)
+				print_pte(ptr, pgd_idx, pud_idx, pmd_idx, i);
+		}
+	}
+}
+
+static void print_pud(struct lguest_vcpu *vcpu,
+		      u64 pud, u64 pgd_idx, u64 pud_idx)
+{
+	u64 pmd;
+	u64 ptr;
+	u64 i;
+
+	printk("     %3llx: %llx\n", pud_idx, pud);
+
+	pmd =3D pud & ~(0xfff) & ~(1UL << 63);
+	for (i=3D0; i < PTRS_PER_PMD; i++) {
+		ptr =3D read_page(vcpu, pmd, i);
+		if (ptr)
+			print_pmd(vcpu, ptr, pgd_idx, pud_idx, i);
+	}
+}
+
+static void print_pgd(struct lguest_vcpu *vcpu,
+		      u64 pgd, u64 pgd_idx)
+{
+	u64 pud;
+	u64 ptr;
+	u64 i;
+
+	printk(" %3llx:  %llx\n", pgd_idx, pgd);
+	pud =3D pgd & ~(0xfff) & ~(1UL << 63);
+	for (i=3D0; i < PTRS_PER_PUD; i++) {
+		ptr =3D read_page(vcpu, pud, i);
+		if (ptr)
+			print_pud(vcpu, ptr, pgd_idx, i);
+	}
+
+}
+
+static void print_page_tables(struct lguest_vcpu *vcpu,
+			      u64 cr3)
+{
+	u64 pgd;
+	u64 ptr;
+	u64 i;
+
+	printk("cr3: %016llx\n", cr3);
+	pgd =3D cr3;
+
+	for (i=3D0; i < PTRS_PER_PGD; i++) {
+		ptr =3D read_page(vcpu, pgd, i);
+		if (ptr)
+			print_pgd(vcpu, ptr, i);
+	}
+}
+
+void lguest_print_page_tables(u64 *cr3)
+{
+	if (!cr3) {
+		printk("NULL cr3 pointer????\n");
+		return;
+	}
+	print_page_tables(NULL, __pa(cr3));
+}
+
+void lguest_print_guest_page_tables(struct lguest_vcpu *vcpu, u64 cr3)
+{
+	print_page_tables(vcpu, cr3);
+}

--
