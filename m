From: rusty@rustcorp.com.au
Subject: [patch 23/43] lguest: Make hypercalls arch-independent.
Date: Wed, 26 Sep 2007 16:36:41 +1000
Message-ID: <20070926063649.274255885@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-hcall-i386-disentangle-v2.diff
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

Clean up the hypercall code to make the code in hypercalls.c
architecture independent. First process the common hypercalls and
then call lguest_arch_do_hcall() if the call hasn't been handled.
Rename struct hcall_ring to hcall_args.

This patch requires the previous patch which reorganize the layout of
struct lguest_regs on i386 so they match the layout of struct
hcall_args.

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/i386/lguest/boot.c         |    8 +-
 drivers/lguest/hypercalls.c     |  120 ++++++++++++---------------------------
 drivers/lguest/i386_core.c      |   62 +++++++++++++++++++-
 drivers/lguest/lg.h             |    4 -
 include/asm-i386/lguest_hcall.h |    8 +-
 include/linux/lguest.h          |    2
 6 files changed, 112 insertions(+), 92 deletions(-)

diff -r 5da9ffae9f41 arch/i386/lguest/boot.c
--- a/arch/i386/lguest/boot.c	Wed Sep 26 14:47:38 2007 +1000
+++ b/arch/i386/lguest/boot.c	Wed Sep 26 14:48:14 2007 +1000
@@ -158,10 +158,10 @@ void async_hcall(unsigned long call,
 		/* Table full, so do normal hcall which will flush table. */
 		hcall(call, arg1, arg2, arg3);
 	} else {
-		lguest_data.hcalls[next_call].eax = call;
-		lguest_data.hcalls[next_call].edx = arg1;
-		lguest_data.hcalls[next_call].ebx = arg2;
-		lguest_data.hcalls[next_call].ecx = arg3;
+		lguest_data.hcalls[next_call].arg0 = call;
+		lguest_data.hcalls[next_call].arg1 = arg1;
+		lguest_data.hcalls[next_call].arg2 = arg2;
+		lguest_data.hcalls[next_call].arg3 = arg3;
 		/* Arguments must all be written before we mark it to go */
 		wmb();
 		lguest_data.hcall_status[next_call] = 0;
diff -r 5da9ffae9f41 drivers/lguest/hypercalls.c
--- a/drivers/lguest/hypercalls.c	Wed Sep 26 14:47:38 2007 +1000
+++ b/drivers/lguest/hypercalls.c	Wed Sep 26 14:48:14 2007 +1000
@@ -25,17 +25,13 @@
 #include <linux/mm.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <irq_vectors.h>
 #include "lg.h"
 
-/*H:120 This is the core hypercall routine: where the Guest gets what it
- * wants.  Or gets killed.  Or, in the case of LHCALL_CRASH, both.
- *
- * Remember from the Guest: %eax == which call to make, and the arguments are
- * packed into %edx, %ebx and %ecx if needed. */
-static void do_hcall(struct lguest *lg, struct lguest_regs *regs)
-{
-	switch (regs->eax) {
+/*H:120 This is the core hypercall routine: where the Guest gets what it wants.
+ * Or gets killed.  Or, in the case of LHCALL_CRASH, both. */
+static void do_hcall(struct lguest *lg, struct hcall_args *args)
+{
+	switch (args->arg0) {
 	case LHCALL_FLUSH_ASYNC:
 		/* This call does nothing, except by breaking out of the Guest
 		 * it makes us process all the asynchronous hypercalls. */
@@ -51,7 +47,7 @@ static void do_hcall(struct lguest *lg, 
 		char msg[128];
 		/* If the lgread fails, it will call kill_guest() itself; the
 		 * kill_guest() with the message will be ignored. */
-		lgread(lg, msg, regs->edx, sizeof(msg));
+		lgread(lg, msg, args->arg1, sizeof(msg));
 		msg[sizeof(msg)-1] = '\0';
 		kill_guest(lg, "CRASH: %s", msg);
 		break;
@@ -59,7 +55,7 @@ static void do_hcall(struct lguest *lg, 
 	case LHCALL_FLUSH_TLB:
 		/* FLUSH_TLB comes in two flavors, depending on the
 		 * argument: */
-		if (regs->edx)
+		if (args->arg1)
 			guest_pagetable_clear_all(lg);
 		else
 			guest_pagetable_flush_user(lg);
@@ -71,55 +67,47 @@ static void do_hcall(struct lguest *lg, 
 		 * it here.  This can legitimately fail, since we currently
 		 * place a limit on the number of DMA pools a Guest can have.
 		 * So we return true or false from this call. */
-		regs->eax = bind_dma(lg, regs->edx, regs->ebx,
-				     regs->ecx >> 8, regs->ecx & 0xFF);
+		args->arg0 = bind_dma(lg, args->arg1, args->arg2,
+				     args->arg3 >> 8, args->arg3 & 0xFF);
 		break;
 
 	/* All these calls simply pass the arguments through to the right
 	 * routines. */
 	case LHCALL_SEND_DMA:
-		send_dma(lg, regs->edx, regs->ebx);
-		break;
-	case LHCALL_LOAD_GDT:
-		load_guest_gdt(lg, regs->edx, regs->ebx);
-		break;
-	case LHCALL_LOAD_IDT_ENTRY:
-		load_guest_idt_entry(lg, regs->edx, regs->ebx, regs->ecx);
+		send_dma(lg, args->arg1, args->arg2);
 		break;
 	case LHCALL_NEW_PGTABLE:
-		guest_new_pagetable(lg, regs->edx);
+		guest_new_pagetable(lg, args->arg1);
 		break;
 	case LHCALL_SET_STACK:
-		guest_set_stack(lg, regs->edx, regs->ebx, regs->ecx);
+		guest_set_stack(lg, args->arg1, args->arg2, args->arg3);
 		break;
 	case LHCALL_SET_PTE:
-		guest_set_pte(lg, regs->edx, regs->ebx, mkgpte(regs->ecx));
+		guest_set_pte(lg, args->arg1, args->arg2, mkgpte(args->arg3));
 		break;
 	case LHCALL_SET_PMD:
-		guest_set_pmd(lg, regs->edx, regs->ebx);
-		break;
-	case LHCALL_LOAD_TLS:
-		guest_load_tls(lg, regs->edx);
+		guest_set_pmd(lg, args->arg1, args->arg2);
 		break;
 	case LHCALL_SET_CLOCKEVENT:
-		guest_set_clockevent(lg, regs->edx);
-		break;
-
+		guest_set_clockevent(lg, args->arg1);
+		break;
 	case LHCALL_TS:
 		/* This sets the TS flag, as we saw used in run_guest(). */
-		lg->ts = regs->edx;
+		lg->ts = args->arg1;
 		break;
 	case LHCALL_HALT:
 		/* Similarly, this sets the halted flag for run_guest(). */
 		lg->halted = 1;
 		break;
 	default:
-		kill_guest(lg, "Bad hypercall %li\n", regs->eax);
-	}
-}
-
-/* Asynchronous hypercalls are easy: we just look in the array in the Guest's
- * "struct lguest_data" and see if there are any new ones marked "ready".
+		if (lguest_arch_do_hcall(lg, args))
+			kill_guest(lg, "Bad hypercall %li\n", args->arg0);
+	}
+}
+/*:*/
+
+/*H:124 Asynchronous hypercalls are easy: we just look in the array in the
+ * Guest's "struct lguest_data" to see if any new ones are marked "ready".
  *
  * We are careful to do these in order: obviously we respect the order the
  * Guest put them in the ring, but we also promise the Guest that they will
@@ -134,10 +122,9 @@ static void do_async_hcalls(struct lgues
 	if (copy_from_user(&st, &lg->lguest_data->hcall_status, sizeof(st)))
 		return;
 
-
 	/* We process "struct lguest_data"s hcalls[] ring once. */
 	for (i = 0; i < ARRAY_SIZE(st); i++) {
-		struct lguest_regs regs;
+		struct hcall_args args;
 		/* We remember where we were up to from last time.  This makes
 		 * sure that the hypercalls are done in the order the Guest
 		 * places them in the ring. */
@@ -152,18 +139,16 @@ static void do_async_hcalls(struct lgues
 		if (++lg->next_hcall == LHCALL_RING_SIZE)
 			lg->next_hcall = 0;
 
-		/* We copy the hypercall arguments into a fake register
-		 * structure.  This makes life simple for do_hcall(). */
-		if (get_user(regs.eax, &lg->lguest_data->hcalls[n].eax)
-		    || get_user(regs.edx, &lg->lguest_data->hcalls[n].edx)
-		    || get_user(regs.ecx, &lg->lguest_data->hcalls[n].ecx)
-		    || get_user(regs.ebx, &lg->lguest_data->hcalls[n].ebx)) {
+		/* Copy the hypercall arguments into a local copy of
+		 * the hcall_args struct. */
+		if (copy_from_user(&args, &lg->lguest_data->hcalls[n],
+				   sizeof(struct hcall_args))) {
 			kill_guest(lg, "Fetching async hypercalls");
 			break;
 		}
 
 		/* Do the hypercall, same as a normal one. */
-		do_hcall(lg, &regs);
+		do_hcall(lg, &args);
 
 		/* Mark the hypercall done. */
 		if (put_user(0xFF, &lg->lguest_data->hcall_status[n])) {
@@ -182,41 +167,16 @@ static void do_async_hcalls(struct lgues
  * Guest makes a hypercall, we end up here to set things up: */
 static void initialize(struct lguest *lg)
 {
-	u32 tsc_speed;
 
 	/* You can't do anything until you're initialized.  The Guest knows the
 	 * rules, so we're unforgiving here. */
-	if (lg->regs->eax != LHCALL_LGUEST_INIT) {
-		kill_guest(lg, "hypercall %li before LGUEST_INIT",
-			   lg->regs->eax);
-		return;
-	}
-
-	/* We insist that the Time Stamp Counter exist and doesn't change with
-	 * cpu frequency.  Some devious chip manufacturers decided that TSC
-	 * changes could be handled in software.  I decided that time going
-	 * backwards might be good for benchmarks, but it's bad for users.
-	 *
-	 * We also insist that the TSC be stable: the kernel detects unreliable
-	 * TSCs for its own purposes, and we use that here. */
-	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) && !check_tsc_unstable())
-		tsc_speed = tsc_khz;
-	else
-		tsc_speed = 0;
-
-	/* The pointer to the Guest's "struct lguest_data" is the only
-	 * argument.  We check that address now. */
-	if (!lguest_address_ok(lg, lg->regs->edx, sizeof(*lg->lguest_data))) {
+	if (lg->hcall->arg0 != LHCALL_LGUEST_INIT) {
+		kill_guest(lg, "hypercall %li before INIT", lg->hcall->arg0);
+		return;
+	}
+
+	if (lguest_arch_init_hypercalls(lg))
 		kill_guest(lg, "bad guest page %p", lg->lguest_data);
-		return;
-	}
-
-	/* Having checked it, we simply set lg->lguest_data to point straight
-	 * into the Launcher's memory at the right place and then use
-	 * copy_to_user/from_user from now on, instead of lgread/write.  I put
-	 * this in to show that I'm not immune to writing stupid
-	 * optimizations. */
-	lg->lguest_data = lg->mem_base + lg->regs->edx;
 
 	/* The Guest tells us where we're not to deliver interrupts by putting
 	 * the range of addresses into "struct lguest_data". */
@@ -224,8 +184,7 @@ static void initialize(struct lguest *lg
 	    || get_user(lg->noirq_end, &lg->lguest_data->noirq_end)
 	    /* We tell the Guest that it can't use the top 4MB of virtual
 	     * addresses used by the Switcher. */
-	    || put_user(4U*1024*1024, &lg->lguest_data->reserve_mem)
-	    || put_user(tsc_speed, &lg->lguest_data->tsc_khz))
+	    || put_user(4U*1024*1024, &lg->lguest_data->reserve_mem))
 		kill_guest(lg, "bad guest page %p", lg->lguest_data);
 
 	/* We write the current time into the Guest's data page once now. */
@@ -237,9 +196,6 @@ static void initialize(struct lguest *lg
 	 * page. */
 	guest_pagetable_clear_all(lg);
 }
-/* Now we've examined the hypercall code; our Guest can make requests.  There
- * is one other way we can do things for the Guest, as we see in
- * emulate_insn(). */
 
 /*H:100
  * Hypercalls
diff -r 5da9ffae9f41 drivers/lguest/i386_core.c
--- a/drivers/lguest/i386_core.c	Wed Sep 26 14:47:38 2007 +1000
+++ b/drivers/lguest/i386_core.c	Wed Sep 26 14:48:14 2007 +1000
@@ -323,7 +323,9 @@ void lguest_arch_handle_trap(struct lgue
 		cond_resched();
 		return;
 	case LGUEST_TRAP_ENTRY:
-		lg->hcall = lg->regs;
+		/* Our 'struct hcall_args' maps directly over our regs: we set
+		 * up the pointer now to indicate a hypercall is pending. */
+		lg->hcall = (struct hcall_args *)lg->regs;
 		return;
 	}
 
@@ -475,3 +477,61 @@ void __exit lguest_arch_host_fini(void)
 	}
 	unlock_cpu_hotplug();
 }
+
+
+/*H:122 The i386-specific hypercalls simply farm out to the right functions. */
+int lguest_arch_do_hcall(struct lguest *lg, struct hcall_args *args)
+{
+	switch (args->arg0) {
+	case LHCALL_LOAD_GDT:
+		load_guest_gdt(lg, args->arg1, args->arg2);
+		break;
+	case LHCALL_LOAD_IDT_ENTRY:
+		load_guest_idt_entry(lg, args->arg1, args->arg2, args->arg3);
+		break;
+	case LHCALL_LOAD_TLS:
+		guest_load_tls(lg, args->arg1);
+		break;
+	default:
+		/* Bad Guest.  Bad! */
+		return -EIO;
+	}
+	return 0;
+}
+
+/*H:126 i386-specific hypercall initialization: */
+int lguest_arch_init_hypercalls(struct lguest *lg)
+{
+	u32 tsc_speed;
+
+	/* The pointer to the Guest's "struct lguest_data" is the only
+	 * argument.  We check that address now. */
+	if (!lguest_address_ok(lg, lg->hcall->arg1, sizeof(*lg->lguest_data)))
+		return -EFAULT;
+
+	/* Having checked it, we simply set lg->lguest_data to point straight
+	 * into the Launcher's memory at the right place and then use
+	 * copy_to_user/from_user from now on, instead of lgread/write.  I put
+	 * this in to show that I'm not immune to writing stupid
+	 * optimizations. */
+	lg->lguest_data = lg->mem_base + lg->hcall->arg1;
+
+	/* We insist that the Time Stamp Counter exist and doesn't change with
+	 * cpu frequency.  Some devious chip manufacturers decided that TSC
+	 * changes could be handled in software.  I decided that time going
+	 * backwards might be good for benchmarks, but it's bad for users.
+	 *
+	 * We also insist that the TSC be stable: the kernel detects unreliable
+	 * TSCs for its own purposes, and we use that here. */
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) && !check_tsc_unstable())
+		tsc_speed = tsc_khz;
+	else
+		tsc_speed = 0;
+	if (put_user(tsc_speed, &lg->lguest_data->tsc_khz))
+		return -EFAULT;
+
+	return 0;
+}
+/* Now we've examined the hypercall code; our Guest can make requests.  There
+ * is one other way we can do things for the Guest, as we see in
+ * emulate_insn(). :*/
diff -r 5da9ffae9f41 drivers/lguest/lg.h
--- a/drivers/lguest/lg.h	Wed Sep 26 14:47:38 2007 +1000
+++ b/drivers/lguest/lg.h	Wed Sep 26 14:48:14 2007 +1000
@@ -108,7 +108,7 @@ struct lguest
 	u8 ss1;
 
 	/* If a hypercall was asked for, this points to the arguments. */
-	struct lguest_regs *hcall;
+	struct hcall_args *hcall;
 
 	/* Do we need to stop what we're doing and return to userspace? */
 	int break_out;
@@ -198,6 +198,8 @@ void lguest_arch_host_fini(void);
 void lguest_arch_host_fini(void);
 void lguest_arch_run_guest(struct lguest *lg);
 void lguest_arch_handle_trap(struct lguest *lg);
+int lguest_arch_init_hypercalls(struct lguest *lg);
+int lguest_arch_do_hcall(struct lguest *lg, struct hcall_args *args);
 
 /* <arch>_switcher.S: */
 extern char start_switcher_text[], end_switcher_text[], switch_to_guest[];
diff -r 5da9ffae9f41 include/asm-i386/lguest_hcall.h
--- a/include/asm-i386/lguest_hcall.h	Wed Sep 26 14:47:38 2007 +1000
+++ b/include/asm-i386/lguest_hcall.h	Wed Sep 26 14:48:14 2007 +1000
@@ -1,6 +1,8 @@
 /* Architecture specific portion of the lguest hypercalls */
 #ifndef _I386_LGUEST_HCALL_H
 #define _I386_LGUEST_HCALL_H
+
+#include <irq_vectors.h>
 
 #define LHCALL_FLUSH_ASYNC	0
 #define LHCALL_LGUEST_INIT	1
@@ -59,9 +61,9 @@ void async_hcall(unsigned long call,
 #define LGUEST_IRQS (NR_IRQS < 32 ? NR_IRQS: 32)
 
 #define LHCALL_RING_SIZE 64
-struct hcall_ring
+struct hcall_args
 {
-	u32 eax, edx, ebx, ecx;
+	/* These map directly onto eax, ebx, ecx, edx in struct lguest_regs */
+	unsigned long arg0, arg2, arg3, arg1;
 };
-
 #endif	/* _I386_LGUEST_HCALL_H */
diff -r 5da9ffae9f41 include/linux/lguest.h
--- a/include/linux/lguest.h	Wed Sep 26 14:47:38 2007 +1000
+++ b/include/linux/lguest.h	Wed Sep 26 14:48:14 2007 +1000
@@ -36,7 +36,7 @@ struct lguest_data
 	/* 0xFF == done (set by Host), 0 == pending (set by Guest). */
 	u8 hcall_status[LHCALL_RING_SIZE];
 	/* The actual registers for the hypercalls. */
-	struct hcall_ring hcalls[LHCALL_RING_SIZE];
+	struct hcall_args hcalls[LHCALL_RING_SIZE];
 
 /* Fields initialized by the Host at boot: */
 	/* Memory not to try to access */

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
