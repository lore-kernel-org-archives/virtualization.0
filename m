From: rusty@rustcorp.com.au
Subject: [patch 20/43] lguest: Move i386 part of core.c to i386_core.c.
Date: Wed, 26 Sep 2007 16:36:38 +1000
Message-ID: <20070926063648.741601185@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-core-i386-seperate-v3.diff
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
Cc: Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Separate i386 architecture specific from core.c and move it to
i386_core.c and add asm-i386/lguest.h header file to match.

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 46a53d30a8c0 arch/i386/lguest/boot.c
--- a/arch/i386/lguest/boot.c	Wed Sep 26 14:47:35 2007 +1000
+++ b/arch/i386/lguest/boot.c	Wed Sep 26 16:07:52 2007 +1000
@@ -65,6 +65,7 @@
 #include <asm/e820.h>
 #include <asm/mce.h>
 #include <asm/io.h>
+#include <asm/i387.h>
 
 /*G:010 Welcome to the Guest!
  *
diff -r 46a53d30a8c0 drivers/lguest/Makefile
--- a/drivers/lguest/Makefile	Wed Sep 26 14:47:35 2007 +1000
+++ b/drivers/lguest/Makefile	Wed Sep 26 16:07:52 2007 +1000
@@ -6,7 +6,7 @@ lg-y = core.o hypercalls.o page_tables.o
 lg-y = core.o hypercalls.o page_tables.o interrupts_and_traps.o \
 	segments.o io.o lguest_user.o
 
-lg-$(CONFIG_X86_32) += i386_switcher.o
+lg-$(CONFIG_X86_32) += i386_switcher.o i386_core.o
 
 Preparation Preparation!: PREFIX=P
 Guest: PREFIX=G
diff -r 46a53d30a8c0 drivers/lguest/core.c
--- a/drivers/lguest/core.c	Wed Sep 26 14:47:35 2007 +1000
+++ b/drivers/lguest/core.c	Wed Sep 26 16:07:52 2007 +1000
@@ -11,54 +11,20 @@
 #include <linux/vmalloc.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <linux/highmem.h>
 #include <asm/paravirt.h>
-#include <asm/desc.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/poll.h>
-#include <asm/highmem.h>
 #include <asm/asm-offsets.h>
-#include <asm/i387.h>
 #include "lg.h"
 
-/* Found in switcher.S */
-extern char start_switcher_text[], end_switcher_text[], switch_to_guest[];
-extern unsigned long default_idt_entries[];
-
-/* Every guest maps the core switcher code. */
-#define SHARED_SWITCHER_PAGES \
-	DIV_ROUND_UP(end_switcher_text - start_switcher_text, PAGE_SIZE)
-/* Pages for switcher itself, then two pages per cpu */
-#define TOTAL_SWITCHER_PAGES (SHARED_SWITCHER_PAGES + 2 * NR_CPUS)
-
-/* We map at -4M for ease of mapping into the guest (one PTE page). */
-#define SWITCHER_ADDR 0xFFC00000
 
 static struct vm_struct *switcher_vma;
 static struct page **switcher_page;
 
-static int cpu_had_pge;
-static struct {
-	unsigned long offset;
-	unsigned short segment;
-} lguest_entry;
-
 /* This One Big lock protects all inter-guest data structures. */
 DEFINE_MUTEX(lguest_lock);
-static DEFINE_PER_CPU(struct lguest *, last_guest);
-
-/* Offset from where switcher.S was compiled to where we've copied it */
-static unsigned long switcher_offset(void)
-{
-	return SWITCHER_ADDR - (unsigned long)start_switcher_text;
-}
-
-/* This cpu's struct lguest_pages. */
-static struct lguest_pages *lguest_pages(unsigned int cpu)
-{
-	return &(((struct lguest_pages *)
-		  (SWITCHER_ADDR + SHARED_SWITCHER_PAGES*PAGE_SIZE))[cpu]);
-}
 
 /*H:010 We need to set up the Switcher at a high virtual address.  Remember the
  * Switcher is a few hundred bytes of assembler code which actually changes the
@@ -69,9 +35,7 @@ static struct lguest_pages *lguest_pages
  * Host since it will be running as the switchover occurs.
  *
  * Trying to map memory at a particular address is an unusual thing to do, so
- * it's not a simple one-liner.  We also set up the per-cpu parts of the
- * Switcher here.
- */
+ * it's not a simple one-liner. */
 static __init int map_switcher(void)
 {
 	int i, err;
@@ -128,89 +92,10 @@ static __init int map_switcher(void)
 		goto free_vma;
 	}
 
-	/* Now the switcher is mapped at the right address, we can't fail!
-	 * Copy in the compiled-in Switcher code (from switcher.S). */
+	/* Now the Switcher is mapped at the right address, we can't fail!
+	 * Copy in the compiled-in Switcher code (from <arch>_switcher.S). */
 	memcpy(switcher_vma->addr, start_switcher_text,
 	       end_switcher_text - start_switcher_text);
-
-	/* Most of the switcher.S doesn't care that it's been moved; on Intel,
-	 * jumps are relative, and it doesn't access any references to external
-	 * code or data.
-	 *
-	 * The only exception is the interrupt handlers in switcher.S: their
-	 * addresses are placed in a table (default_idt_entries), so we need to
-	 * update the table with the new addresses.  switcher_offset() is a
-	 * convenience function which returns the distance between the builtin
-	 * switcher code and the high-mapped copy we just made. */
-	for (i = 0; i < IDT_ENTRIES; i++)
-		default_idt_entries[i] += switcher_offset();
-
-	/*
-	 * Set up the Switcher's per-cpu areas.
-	 *
-	 * Each CPU gets two pages of its own within the high-mapped region
-	 * (aka. "struct lguest_pages").  Much of this can be initialized now,
-	 * but some depends on what Guest we are running (which is set up in
-	 * copy_in_guest_info()).
-	 */
-	for_each_possible_cpu(i) {
-		/* lguest_pages() returns this CPU's two pages. */
-		struct lguest_pages *pages = lguest_pages(i);
-		/* This is a convenience pointer to make the code fit one
-		 * statement to a line. */
-		struct lguest_ro_state *state = &pages->state;
-
-		/* The Global Descriptor Table: the Host has a different one
-		 * for each CPU.  We keep a descriptor for the GDT which says
-		 * where it is and how big it is (the size is actually the last
-		 * byte, not the size, hence the "-1"). */
-		state->host_gdt_desc.size = GDT_SIZE-1;
-		state->host_gdt_desc.address = (long)get_cpu_gdt_table(i);
-
-		/* All CPUs on the Host use the same Interrupt Descriptor
-		 * Table, so we just use store_idt(), which gets this CPU's IDT
-		 * descriptor. */
-		store_idt(&state->host_idt_desc);
-
-		/* The descriptors for the Guest's GDT and IDT can be filled
-		 * out now, too.  We copy the GDT & IDT into ->guest_gdt and
-		 * ->guest_idt before actually running the Guest. */
-		state->guest_idt_desc.size = sizeof(state->guest_idt)-1;
-		state->guest_idt_desc.address = (long)&state->guest_idt;
-		state->guest_gdt_desc.size = sizeof(state->guest_gdt)-1;
-		state->guest_gdt_desc.address = (long)&state->guest_gdt;
-
-		/* We know where we want the stack to be when the Guest enters
-		 * the switcher: in pages->regs.  The stack grows upwards, so
-		 * we start it at the end of that structure. */
-		state->guest_tss.esp0 = (long)(&pages->regs + 1);
-		/* And this is the GDT entry to use for the stack: we keep a
-		 * couple of special LGUEST entries. */
-		state->guest_tss.ss0 = LGUEST_DS;
-
-		/* x86 can have a finegrained bitmap which indicates what I/O
-		 * ports the process can use.  We set it to the end of our
-		 * structure, meaning "none". */
-		state->guest_tss.io_bitmap_base = sizeof(state->guest_tss);
-
-		/* Some GDT entries are the same across all Guests, so we can
-		 * set them up now. */
-		setup_default_gdt_entries(state);
-		/* Most IDT entries are the same for all Guests, too.*/
-		setup_default_idt_entries(state, default_idt_entries);
-
-		/* The Host needs to be able to use the LGUEST segments on this
-		 * CPU, too, so put them in the Host GDT. */
-		get_cpu_gdt_table(i)[GDT_ENTRY_LGUEST_CS] = FULL_EXEC_SEGMENT;
-		get_cpu_gdt_table(i)[GDT_ENTRY_LGUEST_DS] = FULL_SEGMENT;
-	}
-
-	/* In the Switcher, we want the %cs segment register to use the
-	 * LGUEST_CS GDT entry: we've put that in the Host and Guest GDTs, so
-	 * it will be undisturbed when we switch.  To change %cs and jump we
-	 * need this structure to feed to Intel's "lcall" instruction. */
-	lguest_entry.offset = (long)switch_to_guest + switcher_offset();
-	lguest_entry.segment = LGUEST_CS;
 
 	printk(KERN_INFO "lguest: mapped switcher at %p\n",
 	       switcher_vma->addr);
@@ -243,80 +128,6 @@ static void unmap_switcher(void)
 		__free_pages(switcher_page[i], 0);
 }
 
-/*H:130 Our Guest is usually so well behaved; it never tries to do things it
- * isn't allowed to.  Unfortunately, "struct paravirt_ops" isn't quite
- * complete, because it doesn't contain replacements for the Intel I/O
- * instructions.  As a result, the Guest sometimes fumbles across one during
- * the boot process as it probes for various things which are usually attached
- * to a PC.
- *
- * When the Guest uses one of these instructions, we get trap #13 (General
- * Protection Fault) and come here.  We see if it's one of those troublesome
- * instructions and skip over it.  We return true if we did. */
-static int emulate_insn(struct lguest *lg)
-{
-	u8 insn;
-	unsigned int insnlen = 0, in = 0, shift = 0;
-	/* The eip contains the *virtual* address of the Guest's instruction:
-	 * guest_pa just subtracts the Guest's page_offset. */
-	unsigned long physaddr = guest_pa(lg, lg->regs->eip);
-
-	/* The guest_pa() function only works for Guest kernel addresses, but
-	 * that's all we're trying to do anyway. */
-	if (lg->regs->eip < lg->page_offset)
-		return 0;
-
-	/* Decoding x86 instructions is icky. */
-	lgread(lg, &insn, physaddr, 1);
-
-	/* 0x66 is an "operand prefix".  It means it's using the upper 16 bits
-	   of the eax register. */
-	if (insn == 0x66) {
-		shift = 16;
-		/* The instruction is 1 byte so far, read the next byte. */
-		insnlen = 1;
-		lgread(lg, &insn, physaddr + insnlen, 1);
-	}
-
-	/* We can ignore the lower bit for the moment and decode the 4 opcodes
-	 * we need to emulate. */
-	switch (insn & 0xFE) {
-	case 0xE4: /* in     <next byte>,%al */
-		insnlen += 2;
-		in = 1;
-		break;
-	case 0xEC: /* in     (%dx),%al */
-		insnlen += 1;
-		in = 1;
-		break;
-	case 0xE6: /* out    %al,<next byte> */
-		insnlen += 2;
-		break;
-	case 0xEE: /* out    %al,(%dx) */
-		insnlen += 1;
-		break;
-	default:
-		/* OK, we don't know what this is, can't emulate. */
-		return 0;
-	}
-
-	/* If it was an "IN" instruction, they expect the result to be read
-	 * into %eax, so we change %eax.  We always return all-ones, which
-	 * traditionally means "there's nothing there". */
-	if (in) {
-		/* Lower bit tells is whether it's a 16 or 32 bit access */
-		if (insn & 0x1)
-			lg->regs->eax = 0xFFFFFFFF;
-		else
-			lg->regs->eax |= (0xFFFF << shift);
-	}
-	/* Finally, we've "done" the instruction, so move past it. */
-	lg->regs->eip += insnlen;
-	/* Success! */
-	return 1;
-}
-/*:*/
-
 /*L:305
  * Dealing With Guest Memory.
  *
@@ -380,104 +191,6 @@ void lgwrite(struct lguest *lg, unsigned
 }
 /* (end of memory access helper routines) :*/
 
-static void set_ts(void)
-{
-	u32 cr0;
-
-	cr0 = read_cr0();
-	if (!(cr0 & 8))
-		write_cr0(cr0|8);
-}
-
-/*S:010
- * We are getting close to the Switcher.
- *
- * Remember that each CPU has two pages which are visible to the Guest when it
- * runs on that CPU.  This has to contain the state for that Guest: we copy the
- * state in just before we run the Guest.
- *
- * Each Guest has "changed" flags which indicate what has changed in the Guest
- * since it last ran.  We saw this set in interrupts_and_traps.c and
- * segments.c.
- */
-static void copy_in_guest_info(struct lguest *lg, struct lguest_pages *pages)
-{
-	/* Copying all this data can be quite expensive.  We usually run the
-	 * same Guest we ran last time (and that Guest hasn't run anywhere else
-	 * meanwhile).  If that's not the case, we pretend everything in the
-	 * Guest has changed. */
-	if (__get_cpu_var(last_guest) != lg || lg->last_pages != pages) {
-		__get_cpu_var(last_guest) = lg;
-		lg->last_pages = pages;
-		lg->changed = CHANGED_ALL;
-	}
-
-	/* These copies are pretty cheap, so we do them unconditionally: */
-	/* Save the current Host top-level page directory. */
-	pages->state.host_cr3 = __pa(current->mm->pgd);
-	/* Set up the Guest's page tables to see this CPU's pages (and no
-	 * other CPU's pages). */
-	map_switcher_in_guest(lg, pages);
-	/* Set up the two "TSS" members which tell the CPU what stack to use
-	 * for traps which do directly into the Guest (ie. traps at privilege
-	 * level 1). */
-	pages->state.guest_tss.esp1 = lg->esp1;
-	pages->state.guest_tss.ss1 = lg->ss1;
-
-	/* Copy direct-to-Guest trap entries. */
-	if (lg->changed & CHANGED_IDT)
-		copy_traps(lg, pages->state.guest_idt, default_idt_entries);
-
-	/* Copy all GDT entries which the Guest can change. */
-	if (lg->changed & CHANGED_GDT)
-		copy_gdt(lg, pages->state.guest_gdt);
-	/* If only the TLS entries have changed, copy them. */
-	else if (lg->changed & CHANGED_GDT_TLS)
-		copy_gdt_tls(lg, pages->state.guest_gdt);
-
-	/* Mark the Guest as unchanged for next time. */
-	lg->changed = 0;
-}
-
-/* Finally: the code to actually call into the Switcher to run the Guest. */
-static void run_guest_once(struct lguest *lg, struct lguest_pages *pages)
-{
-	/* This is a dummy value we need for GCC's sake. */
-	unsigned int clobber;
-
-	/* Copy the guest-specific information into this CPU's "struct
-	 * lguest_pages". */
-	copy_in_guest_info(lg, pages);
-
-	/* Set the trap number to 256 (impossible value).  If we fault while
-	 * switching to the Guest (bad segment registers or bug), this will
-	 * cause us to abort the Guest. */
-	lg->regs->trapnum = 256;
-
-	/* Now: we push the "eflags" register on the stack, then do an "lcall".
-	 * This is how we change from using the kernel code segment to using
-	 * the dedicated lguest code segment, as well as jumping into the
-	 * Switcher.
-	 *
-	 * The lcall also pushes the old code segment (KERNEL_CS) onto the
-	 * stack, then the address of this call.  This stack layout happens to
-	 * exactly match the stack of an interrupt... */
-	asm volatile("pushf; lcall *lguest_entry"
-		     /* This is how we tell GCC that %eax ("a") and %ebx ("b")
-		      * are changed by this routine.  The "=" means output. */
-		     : "=a"(clobber), "=b"(clobber)
-		     /* %eax contains the pages pointer.  ("0" refers to the
-		      * 0-th argument above, ie "a").  %ebx contains the
-		      * physical address of the Guest's top-level page
-		      * directory. */
-		     : "0"(pages), "1"(__pa(lg->pgdirs[lg->pgdidx].pgdir))
-		     /* We tell gcc that all these registers could change,
-		      * which means we don't have to save and restore them in
-		      * the Switcher. */
-		     : "memory", "%edx", "%ecx", "%edi", "%esi");
-}
-/*:*/
-
 /*H:030 Let's jump straight to the the main loop which runs the Guest.
  * Remember, this is called by the Launcher reading /dev/lguest, and we keep
  * going around and around until something interesting happens. */
@@ -485,11 +198,6 @@ int run_guest(struct lguest *lg, unsigne
 {
 	/* We stop running once the Guest is dead. */
 	while (!lg->dead) {
-		/* We need to initialize this, otherwise gcc complains.  It's
-		 * not (yet) clever enough to see that it's initialized when we
-		 * need it. */
-		unsigned int cr2 = 0; /* Damn gcc */
-
 		/* First we run any hypercalls the Guest wants done: either in
 		 * the hypercall ring in "struct lguest_data", or directly by
 		 * using int 31 (LGUEST_TRAP_ENTRY). */
@@ -538,130 +246,18 @@ int run_guest(struct lguest *lg, unsigne
 		 * the "Do Not Disturb" sign: */
 		local_irq_disable();
 
-		/* Remember the awfully-named TS bit?  If the Guest has asked
-		 * to set it we set it now, so we can trap and pass that trap
-		 * to the Guest if it uses the FPU. */
-		if (lg->ts)
-			set_ts();
-
-		/* SYSENTER is an optimized way of doing system calls.  We
-		 * can't allow it because it always jumps to privilege level 0.
-		 * A normal Guest won't try it because we don't advertise it in
-		 * CPUID, but a malicious Guest (or malicious Guest userspace
-		 * program) could, so we tell the CPU to disable it before
-		 * running the Guest. */
-		if (boot_cpu_has(X86_FEATURE_SEP))
-			wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);
-
-		/* Now we actually run the Guest.  It will pop back out when
-		 * something interesting happens, and we can examine its
-		 * registers to see what it was doing. */
-		run_guest_once(lg, lguest_pages(raw_smp_processor_id()));
-
-		/* The "regs" pointer contains two extra entries which are not
-		 * really registers: a trap number which says what interrupt or
-		 * trap made the switcher code come back, and an error code
-		 * which some traps set.  */
-
-		/* If the Guest page faulted, then the cr2 register will tell
-		 * us the bad virtual address.  We have to grab this now,
-		 * because once we re-enable interrupts an interrupt could
-		 * fault and thus overwrite cr2, or we could even move off to a
-		 * different CPU. */
-		if (lg->regs->trapnum == 14)
-			cr2 = read_cr2();
-		/* Similarly, if we took a trap because the Guest used the FPU,
-		 * we have to restore the FPU it expects to see. */
-		else if (lg->regs->trapnum == 7)
-			math_state_restore();
-
-		/* Restore SYSENTER if it's supposed to be on. */
-		if (boot_cpu_has(X86_FEATURE_SEP))
-			wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
+		/* Actually run the Guest until something happens. */
+		lguest_arch_run_guest(lg);
 
 		/* Now we're ready to be interrupted or moved to other CPUs */
 		local_irq_enable();
 
-		/* OK, so what happened? */
-		switch (lg->regs->trapnum) {
-		case 13: /* We've intercepted a GPF. */
-			/* Check if this was one of those annoying IN or OUT
-			 * instructions which we need to emulate.  If so, we
-			 * just go back into the Guest after we've done it. */
-			if (lg->regs->errcode == 0) {
-				if (emulate_insn(lg))
-					continue;
-			}
-			break;
-		case 14: /* We've intercepted a page fault. */
-			/* The Guest accessed a virtual address that wasn't
-			 * mapped.  This happens a lot: we don't actually set
-			 * up most of the page tables for the Guest at all when
-			 * we start: as it runs it asks for more and more, and
-			 * we set them up as required. In this case, we don't
-			 * even tell the Guest that the fault happened.
-			 *
-			 * The errcode tells whether this was a read or a
-			 * write, and whether kernel or userspace code. */
-			if (demand_page(lg, cr2, lg->regs->errcode))
-				continue;
-
-			/* OK, it's really not there (or not OK): the Guest
-			 * needs to know.  We write out the cr2 value so it
-			 * knows where the fault occurred.
-			 *
-			 * Note that if the Guest were really messed up, this
-			 * could happen before it's done the INITIALIZE
-			 * hypercall, so lg->lguest_data will be NULL */
-			if (lg->lguest_data
-			    && put_user(cr2, &lg->lguest_data->cr2))
-				kill_guest(lg, "Writing cr2");
-			break;
-		case 7: /* We've intercepted a Device Not Available fault. */
-			/* If the Guest doesn't want to know, we already
-			 * restored the Floating Point Unit, so we just
-			 * continue without telling it. */
-			if (!lg->ts)
-				continue;
-			break;
-		case 32 ... 255:
-			/* These values mean a real interrupt occurred, in
-			 * which case the Host handler has already been run.
-			 * We just do a friendly check if another process
-			 * should now be run, then fall through to loop
-			 * around: */
-			cond_resched();
-		case LGUEST_TRAP_ENTRY: /* Handled at top of loop */
-			continue;
-		}
-
-		/* If we get here, it's a trap the Guest wants to know
-		 * about. */
-		if (deliver_trap(lg, lg->regs->trapnum))
-			continue;
-
-		/* If the Guest doesn't have a handler (either it hasn't
-		 * registered any yet, or it's one of the faults we don't let
-		 * it handle), it dies with a cryptic error message. */
-		kill_guest(lg, "unhandled trap %li at %#lx (%#lx)",
-			   lg->regs->trapnum, lg->regs->eip,
-			   lg->regs->trapnum == 14 ? cr2 : lg->regs->errcode);
-	}
+		/* Now we deal with whatever happened to the Guest. */
+		lguest_arch_handle_trap(lg);
+	}
+
 	/* The Guest is dead => "No such file or directory" */
 	return -ENOENT;
-}
-
-/* Now we can look at each of the routines this calls, in increasing order of
- * complexity: do_hypercalls(), emulate_insn(), maybe_do_interrupt(),
- * deliver_trap() and demand_page().  After all those, we'll be ready to
- * examine the Switcher, and our philosophical understanding of the Host/Guest
- * duality will be complete. :*/
-static void adjust_pge(void *on)
-{
-	if (on)
-		write_cr4(read_cr4() | X86_CR4_PGE);
-	else
-		write_cr4(read_cr4() & ~X86_CR4_PGE);
 }
 
 /*H:000
@@ -705,31 +301,8 @@ static int __init init(void)
 		return err;
 	}
 
-	/* Finally, we need to turn off "Page Global Enable".  PGE is an
-	 * optimization where page table entries are specially marked to show
-	 * they never change.  The Host kernel marks all the kernel pages this
-	 * way because it's always present, even when userspace is running.
-	 *
-	 * Lguest breaks this: unbeknownst to the rest of the Host kernel, we
-	 * switch to the Guest kernel.  If you don't disable this on all CPUs,
-	 * you'll get really weird bugs that you'll chase for two days.
-	 *
-	 * I used to turn PGE off every time we switched to the Guest and back
-	 * on when we return, but that slowed the Switcher down noticibly. */
-
-	/* We don't need the complexity of CPUs coming and going while we're
-	 * doing this. */
-	lock_cpu_hotplug();
-	if (cpu_has_pge) { /* We have a broader idea of "global". */
-		/* Remember that this was originally set (for cleanup). */
-		cpu_had_pge = 1;
-		/* adjust_pge is a helper function which sets or unsets the PGE
-		 * bit on its CPU, depending on the argument (0 == unset). */
-		on_each_cpu(adjust_pge, (void *)0, 0, 1);
-		/* Turn off the feature in the global feature set. */
-		clear_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability);
-	}
-	unlock_cpu_hotplug();
+	/* Finally we do some architecture-specific setup. */
+	lguest_arch_host_init();
 
 	/* All good! */
 	return 0;
@@ -742,15 +315,9 @@ static void __exit fini(void)
 	free_pagetables();
 	unmap_switcher();
 
-	/* If we had PGE before we started, turn it back on now. */
-	lock_cpu_hotplug();
-	if (cpu_had_pge) {
-		set_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability);
-		/* adjust_pge's argument "1" means set PGE. */
-		on_each_cpu(adjust_pge, (void *)1, 0, 1);
-	}
-	unlock_cpu_hotplug();
-}
+	lguest_arch_host_fini();
+}
+/*:*/
 
 /* The Host side of lguest can be a module.  This is a nice way for people to
  * play with it.  */
diff -r 46a53d30a8c0 drivers/lguest/i386_core.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/lguest/i386_core.c	Wed Sep 26 16:07:52 2007 +1000
@@ -0,0 +1,476 @@
+/*
+ * Copyright (C) 2006, Rusty Russell <rusty@rustcorp.com.au> IBM Corporation.
+ * Copyright (C) 2007, Jes Sorensen <jes@sgi.com> SGI.
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
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/lguest.h>
+#include <linux/lguest_launcher.h>
+#include <linux/lguest_bus.h>
+#include <asm/paravirt.h>
+#include <asm/param.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/desc.h>
+#include <asm/setup.h>
+#include <asm/lguest.h>
+#include <asm/uaccess.h>
+#include <asm/i387.h>
+#include "lg.h"
+
+static int cpu_had_pge;
+
+static struct {
+	unsigned long offset;
+	unsigned short segment;
+} lguest_entry;
+
+/* Offset from where switcher.S was compiled to where we've copied it */
+static unsigned long switcher_offset(void)
+{
+	return SWITCHER_ADDR - (unsigned long)start_switcher_text;
+}
+
+/* This cpu's struct lguest_pages. */
+static struct lguest_pages *lguest_pages(unsigned int cpu)
+{
+	return &(((struct lguest_pages *)
+		  (SWITCHER_ADDR + SHARED_SWITCHER_PAGES*PAGE_SIZE))[cpu]);
+}
+
+static DEFINE_PER_CPU(struct lguest *, last_guest);
+
+/*S:010
+ * We are getting close to the Switcher.
+ *
+ * Remember that each CPU has two pages which are visible to the Guest when it
+ * runs on that CPU.  This has to contain the state for that Guest: we copy the
+ * state in just before we run the Guest.
+ *
+ * Each Guest has "changed" flags which indicate what has changed in the Guest
+ * since it last ran.  We saw this set in interrupts_and_traps.c and
+ * segments.c.
+ */
+static void copy_in_guest_info(struct lguest *lg, struct lguest_pages *pages)
+{
+	/* Copying all this data can be quite expensive.  We usually run the
+	 * same Guest we ran last time (and that Guest hasn't run anywhere else
+	 * meanwhile).  If that's not the case, we pretend everything in the
+	 * Guest has changed. */
+	if (__get_cpu_var(last_guest) != lg || lg->last_pages != pages) {
+		__get_cpu_var(last_guest) = lg;
+		lg->last_pages = pages;
+		lg->changed = CHANGED_ALL;
+	}
+
+	/* These copies are pretty cheap, so we do them unconditionally: */
+	/* Save the current Host top-level page directory. */
+	pages->state.host_cr3 = __pa(current->mm->pgd);
+	/* Set up the Guest's page tables to see this CPU's pages (and no
+	 * other CPU's pages). */
+	map_switcher_in_guest(lg, pages);
+	/* Set up the two "TSS" members which tell the CPU what stack to use
+	 * for traps which do directly into the Guest (ie. traps at privilege
+	 * level 1). */
+	pages->state.guest_tss.esp1 = lg->esp1;
+	pages->state.guest_tss.ss1 = lg->ss1;
+
+	/* Copy direct-to-Guest trap entries. */
+	if (lg->changed & CHANGED_IDT)
+		copy_traps(lg, pages->state.guest_idt, default_idt_entries);
+
+	/* Copy all GDT entries which the Guest can change. */
+	if (lg->changed & CHANGED_GDT)
+		copy_gdt(lg, pages->state.guest_gdt);
+	/* If only the TLS entries have changed, copy them. */
+	else if (lg->changed & CHANGED_GDT_TLS)
+		copy_gdt_tls(lg, pages->state.guest_gdt);
+
+	/* Mark the Guest as unchanged for next time. */
+	lg->changed = 0;
+}
+
+/* Finally: the code to actually call into the Switcher to run the Guest. */
+static void run_guest_once(struct lguest *lg, struct lguest_pages *pages)
+{
+	/* This is a dummy value we need for GCC's sake. */
+	unsigned int clobber;
+
+	/* Copy the guest-specific information into this CPU's "struct
+	 * lguest_pages". */
+	copy_in_guest_info(lg, pages);
+
+	/* Set the trap number to 256 (impossible value).  If we fault while
+	 * switching to the Guest (bad segment registers or bug), this will
+	 * cause us to abort the Guest. */
+	lg->regs->trapnum = 256;
+
+	/* Now: we push the "eflags" register on the stack, then do an "lcall".
+	 * This is how we change from using the kernel code segment to using
+	 * the dedicated lguest code segment, as well as jumping into the
+	 * Switcher.
+	 *
+	 * The lcall also pushes the old code segment (KERNEL_CS) onto the
+	 * stack, then the address of this call.  This stack layout happens to
+	 * exactly match the stack of an interrupt... */
+	asm volatile("pushf; lcall *lguest_entry"
+		     /* This is how we tell GCC that %eax ("a") and %ebx ("b")
+		      * are changed by this routine.  The "=" means output. */
+		     : "=a"(clobber), "=b"(clobber)
+		     /* %eax contains the pages pointer.  ("0" refers to the
+		      * 0-th argument above, ie "a").  %ebx contains the
+		      * physical address of the Guest's top-level page
+		      * directory. */
+		     : "0"(pages), "1"(__pa(lg->pgdirs[lg->pgdidx].pgdir))
+		     /* We tell gcc that all these registers could change,
+		      * which means we don't have to save and restore them in
+		      * the Switcher. */
+		     : "memory", "%edx", "%ecx", "%edi", "%esi");
+}
+/*:*/
+
+/*H:040 This is the i386-specific code to setup and run the Guest.  Interrupts
+ * are disabled: we own the CPU. */
+void lguest_arch_run_guest(struct lguest *lg)
+{
+	/* Remember the awfully-named TS bit?  If the Guest has asked
+	 * to set it we set it now, so we can trap and pass that trap
+	 * to the Guest if it uses the FPU. */
+	if (lg->ts)
+		lguest_set_ts();
+
+	/* SYSENTER is an optimized way of doing system calls.  We
+	 * can't allow it because it always jumps to privilege level 0.
+	 * A normal Guest won't try it because we don't advertise it in
+	 * CPUID, but a malicious Guest (or malicious Guest userspace
+	 * program) could, so we tell the CPU to disable it before
+	 * running the Guest. */
+	if (boot_cpu_has(X86_FEATURE_SEP))
+		wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);
+
+	/* Now we actually run the Guest.  It will pop back out when
+	 * something interesting happens, and we can examine its
+	 * registers to see what it was doing. */
+	run_guest_once(lg, lguest_pages(raw_smp_processor_id()));
+
+	/* The "regs" pointer contains two extra entries which are not
+	 * really registers: a trap number which says what interrupt or
+	 * trap made the switcher code come back, and an error code
+	 * which some traps set.  */
+
+	/* If the Guest page faulted, then the cr2 register will tell
+	 * us the bad virtual address.  We have to grab this now,
+	 * because once we re-enable interrupts an interrupt could
+	 * fault and thus overwrite cr2, or we could even move off to a
+	 * different CPU. */
+	if (lg->regs->trapnum == 14)
+		lg->arch.last_pagefault = read_cr2();
+	/* Similarly, if we took a trap because the Guest used the FPU,
+	 * we have to restore the FPU it expects to see. */
+	else if (lg->regs->trapnum == 7)
+		math_state_restore();
+
+	/* Restore SYSENTER if it's supposed to be on. */
+	if (boot_cpu_has(X86_FEATURE_SEP))
+		wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
+}
+
+/*H:130 Our Guest is usually so well behaved; it never tries to do things it
+ * isn't allowed to.  Unfortunately, "struct paravirt_ops" isn't quite
+ * complete, because it doesn't contain replacements for the Intel I/O
+ * instructions.  As a result, the Guest sometimes fumbles across one during
+ * the boot process as it probes for various things which are usually attached
+ * to a PC.
+ *
+ * When the Guest uses one of these instructions, we get trap #13 (General
+ * Protection Fault) and come here.  We see if it's one of those troublesome
+ * instructions and skip over it.  We return true if we did. */
+static int emulate_insn(struct lguest *lg)
+{
+	u8 insn;
+	unsigned int insnlen = 0, in = 0, shift = 0;
+	/* The eip contains the *virtual* address of the Guest's instruction:
+	 * guest_pa just subtracts the Guest's page_offset. */
+	unsigned long physaddr = guest_pa(lg, lg->regs->eip);
+
+	/* The guest_pa() function only works for Guest kernel addresses, but
+	 * that's all we're trying to do anyway. */
+	if (lg->regs->eip < lg->page_offset)
+		return 0;
+
+	/* Decoding x86 instructions is icky. */
+	lgread(lg, &insn, physaddr, 1);
+
+	/* 0x66 is an "operand prefix".  It means it's using the upper 16 bits
+	   of the eax register. */
+	if (insn == 0x66) {
+		shift = 16;
+		/* The instruction is 1 byte so far, read the next byte. */
+		insnlen = 1;
+		lgread(lg, &insn, physaddr + insnlen, 1);
+	}
+
+	/* We can ignore the lower bit for the moment and decode the 4 opcodes
+	 * we need to emulate. */
+	switch (insn & 0xFE) {
+	case 0xE4: /* in     <next byte>,%al */
+		insnlen += 2;
+		in = 1;
+		break;
+	case 0xEC: /* in     (%dx),%al */
+		insnlen += 1;
+		in = 1;
+		break;
+	case 0xE6: /* out    %al,<next byte> */
+		insnlen += 2;
+		break;
+	case 0xEE: /* out    %al,(%dx) */
+		insnlen += 1;
+		break;
+	default:
+		/* OK, we don't know what this is, can't emulate. */
+		return 0;
+	}
+
+	/* If it was an "IN" instruction, they expect the result to be read
+	 * into %eax, so we change %eax.  We always return all-ones, which
+	 * traditionally means "there's nothing there". */
+	if (in) {
+		/* Lower bit tells is whether it's a 16 or 32 bit access */
+		if (insn & 0x1)
+			lg->regs->eax = 0xFFFFFFFF;
+		else
+			lg->regs->eax |= (0xFFFF << shift);
+	}
+	/* Finally, we've "done" the instruction, so move past it. */
+	lg->regs->eip += insnlen;
+	/* Success! */
+	return 1;
+}
+
+/*H:050 Once we've re-enabled interrupts, we look at why the Guest exited. */
+void lguest_arch_handle_trap(struct lguest *lg)
+{
+	switch (lg->regs->trapnum) {
+	case 13: /* We've intercepted a GPF. */
+		 /* Check if this was one of those annoying IN or OUT
+		  * instructions which we need to emulate.  If so, we
+		  * just go back into the Guest after we've done it. */
+		if (lg->regs->errcode == 0) {
+			if (emulate_insn(lg))
+				return;
+		}
+		break;
+	case 14: /* We've intercepted a page fault. */
+		 /* The Guest accessed a virtual address that wasn't
+		  * mapped.  This happens a lot: we don't actually set
+		  * up most of the page tables for the Guest at all when
+		  * we start: as it runs it asks for more and more, and
+		  * we set them up as required. In this case, we don't
+		  * even tell the Guest that the fault happened.
+		  *
+		  * The errcode tells whether this was a read or a
+		  * write, and whether kernel or userspace code. */
+		if (demand_page(lg, lg->arch.last_pagefault, lg->regs->errcode))
+			return;
+
+		 /* OK, it's really not there (or not OK): the Guest
+		  * needs to know.  We write out the cr2 value so it
+		  * knows where the fault occurred.
+		  *
+		  * Note that if the Guest were really messed up, this
+		  * could happen before it's done the INITIALIZE
+		  * hypercall, so lg->lguest_data will be NULL */
+		if (lg->lguest_data &&
+		    put_user(lg->arch.last_pagefault, &lg->lguest_data->cr2))
+			kill_guest(lg, "Writing cr2");
+		break;
+	case 7: /* We've intercepted a Device Not Available fault. */
+		/* If the Guest doesn't want to know, we already
+		 * restored the Floating Point Unit, so we just
+		 * continue without telling it. */
+		if (!lg->ts)
+			return;
+		break;
+	case 32 ... 255:
+		/* These values mean a real interrupt occurred, in
+		 * which case the Host handler has already been run.
+		 * We just do a friendly check if another process
+		 * should now be run, then fall through to loop
+		 * around: */
+		cond_resched();
+	case LGUEST_TRAP_ENTRY: /* Handled before re-entering Guest */
+		return;
+	}
+
+	/* We didn't handle the trap, so it needs to go to the Guest. */
+	if (!deliver_trap(lg, lg->regs->trapnum))
+		/* If the Guest doesn't have a handler (either it hasn't
+		 * registered any yet, or it's one of the faults we don't let
+		 * it handle), it dies with a cryptic error message. */
+		kill_guest(lg, "unhandled trap %li at %#lx (%#lx)",
+			   lg->regs->trapnum, lg->regs->eip,
+			   lg->regs->trapnum == 14 ? lg->arch.last_pagefault
+			   : lg->regs->errcode);
+}
+
+/* Now we can look at each of the routines this calls, in increasing order of
+ * complexity: do_hypercalls(), emulate_insn(), maybe_do_interrupt(),
+ * deliver_trap() and demand_page().  After all those, we'll be ready to
+ * examine the Switcher, and our philosophical understanding of the Host/Guest
+ * duality will be complete. :*/
+static void adjust_pge(void *on)
+{
+	if (on)
+		write_cr4(read_cr4() | X86_CR4_PGE);
+	else
+		write_cr4(read_cr4() & ~X86_CR4_PGE);
+}
+
+/*H:020 Now the Switcher is mapped and every thing else is ready, we need to do
+ * some more i386-specific initialization. */
+void __init lguest_arch_host_init(void)
+{
+	int i;
+
+	/* Most of the i386_switcher.S doesn't care that it's been moved; on
+	 * Intel, jumps are relative, and it doesn't access any references to
+	 * external code or data.
+	 *
+	 * The only exception is the interrupt handlers in switcher.S: their
+	 * addresses are placed in a table (default_idt_entries), so we need to
+	 * update the table with the new addresses.  switcher_offset() is a
+	 * convenience function which returns the distance between the builtin
+	 * switcher code and the high-mapped copy we just made. */
+	for (i = 0; i < IDT_ENTRIES; i++)
+		default_idt_entries[i] += switcher_offset();
+
+	/*
+	 * Set up the Switcher's per-cpu areas.
+	 *
+	 * Each CPU gets two pages of its own within the high-mapped region
+	 * (aka. "struct lguest_pages").  Much of this can be initialized now,
+	 * but some depends on what Guest we are running (which is set up in
+	 * copy_in_guest_info()).
+	 */
+	for_each_possible_cpu(i) {
+		/* lguest_pages() returns this CPU's two pages. */
+		struct lguest_pages *pages = lguest_pages(i);
+		/* This is a convenience pointer to make the code fit one
+		 * statement to a line. */
+		struct lguest_ro_state *state = &pages->state;
+
+		/* The Global Descriptor Table: the Host has a different one
+		 * for each CPU.  We keep a descriptor for the GDT which says
+		 * where it is and how big it is (the size is actually the last
+		 * byte, not the size, hence the "-1"). */
+		state->host_gdt_desc.size = GDT_SIZE-1;
+		state->host_gdt_desc.address = (long)get_cpu_gdt_table(i);
+
+		/* All CPUs on the Host use the same Interrupt Descriptor
+		 * Table, so we just use store_idt(), which gets this CPU's IDT
+		 * descriptor. */
+		store_idt(&state->host_idt_desc);
+
+		/* The descriptors for the Guest's GDT and IDT can be filled
+		 * out now, too.  We copy the GDT & IDT into ->guest_gdt and
+		 * ->guest_idt before actually running the Guest. */
+		state->guest_idt_desc.size = sizeof(state->guest_idt)-1;
+		state->guest_idt_desc.address = (long)&state->guest_idt;
+		state->guest_gdt_desc.size = sizeof(state->guest_gdt)-1;
+		state->guest_gdt_desc.address = (long)&state->guest_gdt;
+
+		/* We know where we want the stack to be when the Guest enters
+		 * the switcher: in pages->regs.  The stack grows upwards, so
+		 * we start it at the end of that structure. */
+		state->guest_tss.esp0 = (long)(&pages->regs + 1);
+		/* And this is the GDT entry to use for the stack: we keep a
+		 * couple of special LGUEST entries. */
+		state->guest_tss.ss0 = LGUEST_DS;
+
+		/* x86 can have a finegrained bitmap which indicates what I/O
+		 * ports the process can use.  We set it to the end of our
+		 * structure, meaning "none". */
+		state->guest_tss.io_bitmap_base = sizeof(state->guest_tss);
+
+		/* Some GDT entries are the same across all Guests, so we can
+		 * set them up now. */
+		setup_default_gdt_entries(state);
+		/* Most IDT entries are the same for all Guests, too.*/
+		setup_default_idt_entries(state, default_idt_entries);
+
+		/* The Host needs to be able to use the LGUEST segments on this
+		 * CPU, too, so put them in the Host GDT. */
+		get_cpu_gdt_table(i)[GDT_ENTRY_LGUEST_CS] = FULL_EXEC_SEGMENT;
+		get_cpu_gdt_table(i)[GDT_ENTRY_LGUEST_DS] = FULL_SEGMENT;
+	}
+
+	/* In the Switcher, we want the %cs segment register to use the
+	 * LGUEST_CS GDT entry: we've put that in the Host and Guest GDTs, so
+	 * it will be undisturbed when we switch.  To change %cs and jump we
+	 * need this structure to feed to Intel's "lcall" instruction. */
+	lguest_entry.offset = (long)switch_to_guest + switcher_offset();
+	lguest_entry.segment = LGUEST_CS;
+
+	/* Finally, we need to turn off "Page Global Enable".  PGE is an
+	 * optimization where page table entries are specially marked to show
+	 * they never change.  The Host kernel marks all the kernel pages this
+	 * way because it's always present, even when userspace is running.
+	 *
+	 * Lguest breaks this: unbeknownst to the rest of the Host kernel, we
+	 * switch to the Guest kernel.  If you don't disable this on all CPUs,
+	 * you'll get really weird bugs that you'll chase for two days.
+	 *
+	 * I used to turn PGE off every time we switched to the Guest and back
+	 * on when we return, but that slowed the Switcher down noticibly. */
+
+	/* We don't need the complexity of CPUs coming and going while we're
+	 * doing this. */
+	lock_cpu_hotplug();
+	if (cpu_has_pge) { /* We have a broader idea of "global". */
+		/* Remember that this was originally set (for cleanup). */
+		cpu_had_pge = 1;
+		/* adjust_pge is a helper function which sets or unsets the PGE
+		 * bit on its CPU, depending on the argument (0 == unset). */
+		on_each_cpu(adjust_pge, (void *)0, 0, 1);
+		/* Turn off the feature in the global feature set. */
+		clear_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability);
+	}
+	unlock_cpu_hotplug();
+};
+/*:*/
+
+void __exit lguest_arch_host_fini(void)
+{
+	/* If we had PGE before we started, turn it back on now. */
+	lock_cpu_hotplug();
+	if (cpu_had_pge) {
+		set_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability);
+		/* adjust_pge's argument "1" means set PGE. */
+		on_each_cpu(adjust_pge, (void *)1, 0, 1);
+	}
+	unlock_cpu_hotplug();
+}
diff -r 46a53d30a8c0 drivers/lguest/i386_switcher.S
--- a/drivers/lguest/i386_switcher.S	Wed Sep 26 14:47:35 2007 +1000
+++ b/drivers/lguest/i386_switcher.S	Wed Sep 26 16:07:52 2007 +1000
@@ -48,6 +48,8 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
+#include <asm/segment.h>
+#include <asm/lguest.h>
 #include "lg.h"
 
 // We mark the start of the code to copy
diff -r 46a53d30a8c0 drivers/lguest/interrupts_and_traps.c
--- a/drivers/lguest/interrupts_and_traps.c	Wed Sep 26 14:47:35 2007 +1000
+++ b/drivers/lguest/interrupts_and_traps.c	Wed Sep 26 16:07:52 2007 +1000
@@ -165,7 +165,7 @@ void maybe_do_interrupt(struct lguest *l
 	/* Look at the IDT entry the Guest gave us for this interrupt.  The
 	 * first 32 (FIRST_EXTERNAL_VECTOR) entries are for traps, so we skip
 	 * over them. */
-	idt = &lg->idt[FIRST_EXTERNAL_VECTOR+irq];
+	idt = &lg->arch.idt[FIRST_EXTERNAL_VECTOR+irq];
 	/* If they don't have a handler (yet?), we just ignore it */
 	if (idt_present(idt->a, idt->b)) {
 		/* OK, mark it no longer pending and deliver it. */
@@ -197,14 +197,14 @@ int deliver_trap(struct lguest *lg, unsi
 {
 	/* Trap numbers are always 8 bit, but we set an impossible trap number
 	 * for traps inside the Switcher, so check that here. */
-	if (num >= ARRAY_SIZE(lg->idt))
+	if (num >= ARRAY_SIZE(lg->arch.idt))
 		return 0;
 
 	/* Early on the Guest hasn't set the IDT entries (or maybe it put a
 	 * bogus one in): if we fail here, the Guest will be killed. */
-	if (!idt_present(lg->idt[num].a, lg->idt[num].b))
+	if (!idt_present(lg->arch.idt[num].a, lg->arch.idt[num].b))
 		return 0;
-	set_guest_interrupt(lg, lg->idt[num].a, lg->idt[num].b, has_err(num));
+	set_guest_interrupt(lg, lg->arch.idt[num].a, lg->arch.idt[num].b, has_err(num));
 	return 1;
 }
 
@@ -341,10 +341,10 @@ void load_guest_idt_entry(struct lguest 
 	lg->changed |= CHANGED_IDT;
 
 	/* Check that the Guest doesn't try to step outside the bounds. */
-	if (num >= ARRAY_SIZE(lg->idt))
+	if (num >= ARRAY_SIZE(lg->arch.idt))
 		kill_guest(lg, "Setting idt entry %u", num);
 	else
-		set_trap(lg, &lg->idt[num], num, lo, hi);
+		set_trap(lg, &lg->arch.idt[num], num, lo, hi);
 }
 
 /* The default entry for each interrupt points into the Switcher routines which
@@ -387,7 +387,7 @@ void copy_traps(const struct lguest *lg,
 
 	/* We can simply copy the direct traps, otherwise we use the default
 	 * ones in the Switcher: they will return to the Host. */
-	for (i = 0; i < ARRAY_SIZE(lg->idt); i++) {
+	for (i = 0; i < ARRAY_SIZE(lg->arch.idt); i++) {
 		/* If no Guest can ever override this trap, leave it alone. */
 		if (!direct_trap(i))
 			continue;
@@ -396,8 +396,8 @@ void copy_traps(const struct lguest *lg,
 		 * Interrupt gates (type 14) disable interrupts as they are
 		 * entered, which we never let the Guest do.  Not present
 		 * entries (type 0x0) also can't go direct, of course. */
-		if (idt_type(lg->idt[i].a, lg->idt[i].b) == 0xF)
-			idt[i] = lg->idt[i];
+		if (idt_type(lg->arch.idt[i].a, lg->arch.idt[i].b) == 0xF)
+			idt[i] = lg->arch.idt[i];
 		else
 			/* Reset it to the default. */
 			default_idt_entry(&idt[i], i, def[i]);
diff -r 46a53d30a8c0 drivers/lguest/lg.h
--- a/drivers/lguest/lg.h	Wed Sep 26 14:47:35 2007 +1000
+++ b/drivers/lguest/lg.h	Wed Sep 26 16:08:02 2007 +1000
@@ -1,12 +1,5 @@
 #ifndef _LGUEST_H
 #define _LGUEST_H
-
-#include <asm/desc.h>
-
-#define GDT_ENTRY_LGUEST_CS	10
-#define GDT_ENTRY_LGUEST_DS	11
-#define LGUEST_CS		(GDT_ENTRY_LGUEST_CS * 8)
-#define LGUEST_DS		(GDT_ENTRY_LGUEST_DS * 8)
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
@@ -19,33 +12,11 @@
 #include <linux/wait.h>
 #include <linux/err.h>
 #include <asm/semaphore.h>
-#include "irq_vectors.h"
-
-#define GUEST_PL 1
-
-struct lguest_regs
-{
-	/* Manually saved part. */
-	unsigned long ebx, ecx, edx;
-	unsigned long esi, edi, ebp;
-	unsigned long gs;
-	unsigned long eax;
-	unsigned long fs, ds, es;
-	unsigned long trapnum, errcode;
-	/* Trap pushed part */
-	unsigned long eip;
-	unsigned long cs;
-	unsigned long eflags;
-	unsigned long esp;
-	unsigned long ss;
-};
+
+#include <asm/lguest.h>
 
 void free_pagetables(void);
 int init_pagetables(struct page **switcher_page, unsigned int pages);
-
-/* Full 4G segment descriptors, suitable for CS and DS. */
-#define FULL_EXEC_SEGMENT ((struct desc_struct){0x0000ffff, 0x00cf9b00})
-#define FULL_SEGMENT ((struct desc_struct){0x0000ffff, 0x00cf9300})
 
 struct lguest_dma_info
 {
@@ -97,23 +68,6 @@ struct pgdir
 {
 	unsigned long cr3;
 	spgd_t *pgdir;
-};
-
-/* This is a guest-specific page (mapped ro) into the guest. */
-struct lguest_ro_state
-{
-	/* Host information we need to restore when we switch back. */
-	u32 host_cr3;
-	struct Xgt_desc_struct host_idt_desc;
-	struct Xgt_desc_struct host_gdt_desc;
-	u32 host_sp;
-
-	/* Fields which are used when guest is running. */
-	struct Xgt_desc_struct guest_idt_desc;
-	struct Xgt_desc_struct guest_gdt_desc;
-	struct i386_hw_tss guest_tss;
-	struct desc_struct guest_idt[IDT_ENTRIES];
-	struct desc_struct guest_gdt[GDT_ENTRIES];
 };
 
 /* We have two pages shared with guests, per cpu.  */
@@ -181,11 +135,7 @@ struct lguest
 	/* Dead? */
 	const char *dead;
 
-	/* The GDT entries copied into lguest_ro_state when running. */
-	struct desc_struct gdt[GDT_ENTRIES];
-
-	/* The IDT entries: some copied into lguest_ro_state when running. */
-	struct desc_struct idt[IDT_ENTRIES];
+	struct lguest_arch arch;
 
 	/* Virtual clock device */
 	struct hrtimer hrt;
@@ -240,6 +190,15 @@ int demand_page(struct lguest *info, uns
 int demand_page(struct lguest *info, unsigned long cr2, int errcode);
 void pin_page(struct lguest *lg, unsigned long vaddr);
 
+/* <arch>_core.c: */
+void lguest_arch_host_init(void);
+void lguest_arch_host_fini(void);
+void lguest_arch_run_guest(struct lguest *lg);
+void lguest_arch_handle_trap(struct lguest *lg);
+
+/* <arch>_switcher.S: */
+extern char start_switcher_text[], end_switcher_text[], switch_to_guest[];
+
 /* lguest_user.c: */
 int lguest_device_init(void);
 void lguest_device_remove(void);
diff -r 46a53d30a8c0 drivers/lguest/segments.c
--- a/drivers/lguest/segments.c	Wed Sep 26 14:47:35 2007 +1000
+++ b/drivers/lguest/segments.c	Wed Sep 26 14:48:14 2007 +1000
@@ -73,14 +73,14 @@ static void fixup_gdt_table(struct lgues
 		/* Segment descriptors contain a privilege level: the Guest is
 		 * sometimes careless and leaves this as 0, even though it's
 		 * running at privilege level 1.  If so, we fix it here. */
-		if ((lg->gdt[i].b & 0x00006000) == 0)
-			lg->gdt[i].b |= (GUEST_PL << 13);
+		if ((lg->arch.gdt[i].b & 0x00006000) == 0)
+			lg->arch.gdt[i].b |= (GUEST_PL << 13);
 
 		/* Each descriptor has an "accessed" bit.  If we don't set it
 		 * now, the CPU will try to set it when the Guest first loads
 		 * that entry into a segment register.  But the GDT isn't
 		 * writable by the Guest, so bad things can happen. */
-		lg->gdt[i].b |= 0x00000100;
+		lg->arch.gdt[i].b |= 0x00000100;
 	}
 }
 
@@ -106,12 +106,12 @@ void setup_guest_gdt(struct lguest *lg)
 void setup_guest_gdt(struct lguest *lg)
 {
 	/* Start with full 0-4G segments... */
-	lg->gdt[GDT_ENTRY_KERNEL_CS] = FULL_EXEC_SEGMENT;
-	lg->gdt[GDT_ENTRY_KERNEL_DS] = FULL_SEGMENT;
+	lg->arch.gdt[GDT_ENTRY_KERNEL_CS] = FULL_EXEC_SEGMENT;
+	lg->arch.gdt[GDT_ENTRY_KERNEL_DS] = FULL_SEGMENT;
 	/* ...except the Guest is allowed to use them, so set the privilege
 	 * level appropriately in the flags. */
-	lg->gdt[GDT_ENTRY_KERNEL_CS].b |= (GUEST_PL << 13);
-	lg->gdt[GDT_ENTRY_KERNEL_DS].b |= (GUEST_PL << 13);
+	lg->arch.gdt[GDT_ENTRY_KERNEL_CS].b |= (GUEST_PL << 13);
+	lg->arch.gdt[GDT_ENTRY_KERNEL_DS].b |= (GUEST_PL << 13);
 }
 
 /* Like the IDT, we never simply use the GDT the Guest gives us.  We set up the
@@ -126,7 +126,7 @@ void copy_gdt_tls(const struct lguest *l
 	unsigned int i;
 
 	for (i = GDT_ENTRY_TLS_MIN; i <= GDT_ENTRY_TLS_MAX; i++)
-		gdt[i] = lg->gdt[i];
+		gdt[i] = lg->arch.gdt[i];
 }
 
 /* This is the full version */
@@ -138,7 +138,7 @@ void copy_gdt(const struct lguest *lg, s
 	 * replaced.  See ignored_gdt() above. */
 	for (i = 0; i < GDT_ENTRIES; i++)
 		if (!ignored_gdt(i))
-			gdt[i] = lg->gdt[i];
+			gdt[i] = lg->arch.gdt[i];
 }
 
 /* This is where the Guest asks us to load a new GDT (LHCALL_LOAD_GDT). */
@@ -146,12 +146,12 @@ void load_guest_gdt(struct lguest *lg, u
 {
 	/* We assume the Guest has the same number of GDT entries as the
 	 * Host, otherwise we'd have to dynamically allocate the Guest GDT. */
-	if (num > ARRAY_SIZE(lg->gdt))
+	if (num > ARRAY_SIZE(lg->arch.gdt))
 		kill_guest(lg, "too many gdt entries %i", num);
 
 	/* We read the whole thing in, then fix it up. */
-	lgread(lg, lg->gdt, table, num * sizeof(lg->gdt[0]));
-	fixup_gdt_table(lg, 0, ARRAY_SIZE(lg->gdt));
+	lgread(lg, lg->arch.gdt, table, num * sizeof(lg->arch.gdt[0]));
+	fixup_gdt_table(lg, 0, ARRAY_SIZE(lg->arch.gdt));
 	/* Mark that the GDT changed so the core knows it has to copy it again,
 	 * even if the Guest is run on the same CPU. */
 	lg->changed |= CHANGED_GDT;
@@ -159,7 +159,7 @@ void load_guest_gdt(struct lguest *lg, u
 
 void guest_load_tls(struct lguest *lg, unsigned long gtls)
 {
-	struct desc_struct *tls = &lg->gdt[GDT_ENTRY_TLS_MIN];
+	struct desc_struct *tls = &lg->arch.gdt[GDT_ENTRY_TLS_MIN];
 
 	lgread(lg, tls, gtls, sizeof(*tls)*GDT_ENTRY_TLS_ENTRIES);
 	fixup_gdt_table(lg, GDT_ENTRY_TLS_MIN, GDT_ENTRY_TLS_MAX+1);
diff -r 46a53d30a8c0 include/asm-i386/lguest.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/lguest.h	Wed Sep 26 16:08:02 2007 +1000
@@ -0,0 +1,87 @@
+#ifndef _I386_LGUEST_H
+#define _I386_LGUEST_H
+
+#define GDT_ENTRY_LGUEST_CS	10
+#define GDT_ENTRY_LGUEST_DS	11
+#define LGUEST_CS		(GDT_ENTRY_LGUEST_CS * 8)
+#define LGUEST_DS		(GDT_ENTRY_LGUEST_DS * 8)
+
+#ifndef __ASSEMBLY__
+#include <asm/desc.h>
+
+#define GUEST_PL 1
+
+/* Every guest maps the core switcher code. */
+#define SHARED_SWITCHER_PAGES \
+	DIV_ROUND_UP(end_switcher_text - start_switcher_text, PAGE_SIZE)
+/* Pages for switcher itself, then two pages per cpu */
+#define TOTAL_SWITCHER_PAGES (SHARED_SWITCHER_PAGES + 2 * NR_CPUS)
+
+/* We map at -4M for ease of mapping into the guest (one PTE page). */
+#define SWITCHER_ADDR 0xFFC00000
+
+/* Found in switcher.S */
+extern unsigned long default_idt_entries[];
+
+struct lguest_regs
+{
+	/* Manually saved part. */
+	unsigned long ebx, ecx, edx;
+	unsigned long esi, edi, ebp;
+	unsigned long gs;
+	unsigned long eax;
+	unsigned long fs, ds, es;
+	unsigned long trapnum, errcode;
+	/* Trap pushed part */
+	unsigned long eip;
+	unsigned long cs;
+	unsigned long eflags;
+	unsigned long esp;
+	unsigned long ss;
+};
+
+/* This is a guest-specific page (mapped ro) into the guest. */
+struct lguest_ro_state
+{
+	/* Host information we need to restore when we switch back. */
+	u32 host_cr3;
+	struct Xgt_desc_struct host_idt_desc;
+	struct Xgt_desc_struct host_gdt_desc;
+	u32 host_sp;
+
+	/* Fields which are used when guest is running. */
+	struct Xgt_desc_struct guest_idt_desc;
+	struct Xgt_desc_struct guest_gdt_desc;
+	struct i386_hw_tss guest_tss;
+	struct desc_struct guest_idt[IDT_ENTRIES];
+	struct desc_struct guest_gdt[GDT_ENTRIES];
+};
+
+struct lguest_arch
+{
+	/* The GDT entries copied into lguest_ro_state when running. */
+	struct desc_struct gdt[GDT_ENTRIES];
+
+	/* The IDT entries: some copied into lguest_ro_state when running. */
+	struct desc_struct idt[IDT_ENTRIES];
+
+	/* The address of the last guest-visible pagefault (ie. cr2). */
+	unsigned long last_pagefault;
+};
+
+static inline void lguest_set_ts(void)
+{
+	u32 cr0;
+
+	cr0 = read_cr0();
+	if (!(cr0 & 8))
+		write_cr0(cr0|8);
+}
+
+/* Full 4G segment descriptors, suitable for CS and DS. */
+#define FULL_EXEC_SEGMENT ((struct desc_struct){0x0000ffff, 0x00cf9b00})
+#define FULL_SEGMENT ((struct desc_struct){0x0000ffff, 0x00cf9300})
+
+#endif /* __ASSEMBLY__ */
+
+#endif

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
