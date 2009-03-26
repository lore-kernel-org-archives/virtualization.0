From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: [PATCH 4/5] lguest: use KVM hypercalls
Date: Fri, 27 Mar 2009 10:22:37 +1030
Message-ID: <200903271022.38244.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Cc: virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Matias Zabaljauregui <zabaljaureguiatgmail.com-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

From: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Impact: cleanup

This patch allow us to use KVM hypercalls

Signed-off-by: Matias Zabaljauregui <zabaljauregui at gmail.com>
Signed-off-by: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
---
 arch/x86/include/asm/lguest_hcall.h   |   24 +---------
 arch/x86/lguest/boot.c                |   80 +++++++++++++++++++++-------------
 arch/x86/lguest/i386_head.S           |    4 -
 drivers/lguest/interrupts_and_traps.c |    7 +-
 drivers/lguest/lguest_device.c        |    4 -
 drivers/lguest/x86/core.c             |   62 +++++++++++++++++++++++++-
 6 files changed, 123 insertions(+), 58 deletions(-)

diff --git a/arch/x86/include/asm/lguest_hcall.h b/arch/x86/include/asm/lguest_hcall.h
--- a/arch/x86/include/asm/lguest_hcall.h
+++ b/arch/x86/include/asm/lguest_hcall.h
@@ -27,36 +27,20 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/hw_irq.h>
+#include <asm/kvm_para.h>
 
 /*G:031 But first, how does our Guest contact the Host to ask for privileged
  * operations?  There are two ways: the direct way is to make a "hypercall",
  * to make requests of the Host Itself.
  *
- * Our hypercall mechanism uses the highest unused trap code (traps 32 and
- * above are used by real hardware interrupts).  Fifteen hypercalls are
+ * We use the KVM hypercall mechanism. Eighteen hypercalls are
  * available: the hypercall number is put in the %eax register, and the
- * arguments (when required) are placed in %edx, %ebx and %ecx.  If a return
+ * arguments (when required) are placed in %ebx, %ecx and %edx.  If a return
  * value makes sense, it's returned in %eax.
  *
  * Grossly invalid calls result in Sudden Death at the hands of the vengeful
  * Host, rather than returning failure.  This reflects Winston Churchill's
  * definition of a gentleman: "someone who is only rude intentionally". */
-static inline unsigned long
-hcall(unsigned long call,
-      unsigned long arg1, unsigned long arg2, unsigned long arg3)
-{
-	/* "int" is the Intel instruction to trigger a trap. */
-	asm volatile("int $" __stringify(LGUEST_TRAP_ENTRY)
-		     /* The call in %eax (aka "a") might be overwritten */
-		     : "=a"(call)
-		       /* The arguments are in %eax, %edx, %ebx & %ecx */
-		     : "a"(call), "d"(arg1), "b"(arg2), "c"(arg3)
-		       /* "memory" means this might write somewhere in memory.
-			* This isn't true for all calls, but it's safe to tell
-			* gcc that it might happen so it doesn't get clever. */
-		     : "memory");
-	return call;
-}
 /*:*/
 
 /* Can't use our min() macro here: needs to be a constant */
@@ -65,7 +49,7 @@ hcall(unsigned long call,
 #define LHCALL_RING_SIZE 64
 struct hcall_args {
 	/* These map directly onto eax, ebx, ecx, edx in struct lguest_regs */
-	unsigned long arg0, arg2, arg3, arg1;
+	unsigned long arg0, arg1, arg2, arg3;
 };
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -107,7 +107,7 @@ static void async_hcall(unsigned long ca
 	local_irq_save(flags);
 	if (lguest_data.hcall_status[next_call] != 0xFF) {
 		/* Table full, so do normal hcall which will flush table. */
-		hcall(call, arg1, arg2, arg3);
+		kvm_hypercall3(call, arg1, arg2, arg3);
 	} else {
 		lguest_data.hcalls[next_call].arg0 = call;
 		lguest_data.hcalls[next_call].arg1 = arg1;
@@ -134,13 +134,32 @@ static void async_hcall(unsigned long ca
  *
  * So, when we're in lazy mode, we call async_hcall() to store the call for
  * future processing: */
-static void lazy_hcall(unsigned long call,
+static void lazy_hcall1(unsigned long call,
+		       unsigned long arg1)
+{
+	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_NONE)
+		kvm_hypercall1(call, arg1);
+	else
+		async_hcall(call, arg1, 0, 0);
+}
+
+static void lazy_hcall2(unsigned long call,
+		       unsigned long arg1,
+		       unsigned long arg2)
+{
+	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_NONE)
+		kvm_hypercall2(call, arg1, arg2);
+	else
+		async_hcall(call, arg1, arg2, 0);
+}
+
+static void lazy_hcall3(unsigned long call,
 		       unsigned long arg1,
 		       unsigned long arg2,
 		       unsigned long arg3)
 {
 	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_NONE)
-		hcall(call, arg1, arg2, arg3);
+		kvm_hypercall3(call, arg1, arg2, arg3);
 	else
 		async_hcall(call, arg1, arg2, arg3);
 }
@@ -150,7 +169,7 @@ static void lguest_leave_lazy_mode(void)
 static void lguest_leave_lazy_mode(void)
 {
 	paravirt_leave_lazy(paravirt_get_lazy_mode());
-	hcall(LHCALL_FLUSH_ASYNC, 0, 0, 0);
+	kvm_hypercall0(LHCALL_FLUSH_ASYNC);
 }
 
 /*G:033
@@ -224,7 +243,7 @@ static void lguest_write_idt_entry(gate_
 	/* Keep the local copy up to date. */
 	native_write_idt_entry(dt, entrynum, g);
 	/* Tell Host about this new entry. */
-	hcall(LHCALL_LOAD_IDT_ENTRY, entrynum, desc[0], desc[1]);
+	kvm_hypercall3(LHCALL_LOAD_IDT_ENTRY, entrynum, desc[0], desc[1]);
 }
 
 /* Changing to a different IDT is very rare: we keep the IDT up-to-date every
@@ -236,7 +255,7 @@ static void lguest_load_idt(const struct
 	struct desc_struct *idt = (void *)desc->address;
 
 	for (i = 0; i < (desc->size+1)/8; i++)
-		hcall(LHCALL_LOAD_IDT_ENTRY, i, idt[i].a, idt[i].b);
+		kvm_hypercall3(LHCALL_LOAD_IDT_ENTRY, i, idt[i].a, idt[i].b);
 }
 
 /*
@@ -256,8 +275,8 @@ static void lguest_load_idt(const struct
  */
 static void lguest_load_gdt(const struct desc_ptr *desc)
 {
-	BUG_ON((desc->size+1)/8 != GDT_ENTRIES);
-	hcall(LHCALL_LOAD_GDT, __pa(desc->address), GDT_ENTRIES, 0);
+	BUG_ON((desc->size + 1) / 8 != GDT_ENTRIES);
+	kvm_hypercall2(LHCALL_LOAD_GDT, __pa(desc->address), GDT_ENTRIES);
 }
 
 /* For a single GDT entry which changes, we do the lazy thing: alter our GDT,
@@ -267,7 +286,7 @@ static void lguest_write_gdt_entry(struc
 				   const void *desc, int type)
 {
 	native_write_gdt_entry(dt, entrynum, desc, type);
-	hcall(LHCALL_LOAD_GDT, __pa(dt), GDT_ENTRIES, 0);
+	kvm_hypercall2(LHCALL_LOAD_GDT, __pa(dt), GDT_ENTRIES);
 }
 
 /* OK, I lied.  There are three "thread local storage" GDT entries which change
@@ -279,7 +298,7 @@ static void lguest_load_tls(struct threa
 	 * can't handle us removing entries we're currently using.  So we clear
 	 * the GS register here: if it's needed it'll be reloaded anyway. */
 	loadsegment(gs, 0);
-	lazy_hcall(LHCALL_LOAD_TLS, __pa(&t->tls_array), cpu, 0);
+	lazy_hcall2(LHCALL_LOAD_TLS, __pa(&t->tls_array), cpu);
 }
 
 /*G:038 That's enough excitement for now, back to ploughing through each of
@@ -377,7 +396,7 @@ static unsigned long current_cr0;
 static unsigned long current_cr0;
 static void lguest_write_cr0(unsigned long val)
 {
-	lazy_hcall(LHCALL_TS, val & X86_CR0_TS, 0, 0);
+	lazy_hcall1(LHCALL_TS, val & X86_CR0_TS);
 	current_cr0 = val;
 }
 
@@ -391,7 +410,7 @@ static unsigned long lguest_read_cr0(voi
  * the vowels have been optimized out. */
 static void lguest_clts(void)
 {
-	lazy_hcall(LHCALL_TS, 0, 0, 0);
+	lazy_hcall1(LHCALL_TS, 0);
 	current_cr0 &= ~X86_CR0_TS;
 }
 
@@ -413,7 +432,7 @@ static void lguest_write_cr3(unsigned lo
 static void lguest_write_cr3(unsigned long cr3)
 {
 	lguest_data.pgdir = cr3;
-	lazy_hcall(LHCALL_NEW_PGTABLE, cr3, 0, 0);
+	lazy_hcall1(LHCALL_NEW_PGTABLE, cr3);
 	cr3_changed = true;
 }
 
@@ -488,7 +507,7 @@ static void lguest_pte_update(struct mm_
 static void lguest_pte_update(struct mm_struct *mm, unsigned long addr,
 			       pte_t *ptep)
 {
-	lazy_hcall(LHCALL_SET_PTE, __pa(mm->pgd), addr, ptep->pte_low);
+	lazy_hcall3(LHCALL_SET_PTE, __pa(mm->pgd), addr, ptep->pte_low);
 }
 
 static void lguest_set_pte_at(struct mm_struct *mm, unsigned long addr,
@@ -504,8 +523,8 @@ static void lguest_set_pmd(pmd_t *pmdp, 
 static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
 	*pmdp = pmdval;
-	lazy_hcall(LHCALL_SET_PMD, __pa(pmdp)&PAGE_MASK,
-		   (__pa(pmdp)&(PAGE_SIZE-1))/4, 0);
+	lazy_hcall2(LHCALL_SET_PMD, __pa(pmdp) & PAGE_MASK,
+		   (__pa(pmdp) & (PAGE_SIZE - 1)) / 4);
 }
 
 /* There are a couple of legacy places where the kernel sets a PTE, but we
@@ -521,7 +540,7 @@ static void lguest_set_pte(pte_t *ptep, 
 {
 	*ptep = pteval;
 	if (cr3_changed)
-		lazy_hcall(LHCALL_FLUSH_TLB, 1, 0, 0);
+		lazy_hcall1(LHCALL_FLUSH_TLB, 1);
 }
 
 /* Unfortunately for Lguest, the pv_mmu_ops for page tables were based on
@@ -537,7 +556,7 @@ static void lguest_flush_tlb_single(unsi
 static void lguest_flush_tlb_single(unsigned long addr)
 {
 	/* Simply set it to zero: if it was not, it will fault back in. */
-	lazy_hcall(LHCALL_SET_PTE, lguest_data.pgdir, addr, 0);
+	lazy_hcall3(LHCALL_SET_PTE, lguest_data.pgdir, addr, 0);
 }
 
 /* This is what happens after the Guest has removed a large number of entries.
@@ -545,7 +564,7 @@ static void lguest_flush_tlb_single(unsi
  * have changed, ie. virtual addresses below PAGE_OFFSET. */
 static void lguest_flush_tlb_user(void)
 {
-	lazy_hcall(LHCALL_FLUSH_TLB, 0, 0, 0);
+	lazy_hcall1(LHCALL_FLUSH_TLB, 0);
 }
 
 /* This is called when the kernel page tables have changed.  That's not very
@@ -553,14 +572,14 @@ static void lguest_flush_tlb_user(void)
  * slow), so it's worth separating this from the user flushing above. */
 static void lguest_flush_tlb_kernel(void)
 {
-	lazy_hcall(LHCALL_FLUSH_TLB, 1, 0, 0);
+	lazy_hcall1(LHCALL_FLUSH_TLB, 1);
 }
 
 /* This routine is called when a process exits, and we're throwing away the
  * page table. */
 static void lguest_pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	lazy_hcall(LHCALL_INVALIDATE_PGTABLE, __pa(pgd), 0, 0);
+	lazy_hcall1(LHCALL_INVALIDATE_PGTABLE, __pa(pgd));
 }
 
 /*
@@ -697,7 +716,7 @@ static int lguest_clockevent_set_next_ev
 	}
 
 	/* Please wake us this far in the future. */
-	hcall(LHCALL_SET_CLOCKEVENT, delta, 0, 0);
+	kvm_hypercall1(LHCALL_SET_CLOCKEVENT, delta);
 	return 0;
 }
 
@@ -708,7 +727,7 @@ static void lguest_clockevent_set_mode(e
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		/* A 0 argument shuts the clock down. */
-		hcall(LHCALL_SET_CLOCKEVENT, 0, 0, 0);
+		kvm_hypercall0(LHCALL_SET_CLOCKEVENT);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* This is what we expect. */
@@ -783,8 +802,8 @@ static void lguest_load_sp0(struct tss_s
 static void lguest_load_sp0(struct tss_struct *tss,
 			    struct thread_struct *thread)
 {
-	lazy_hcall(LHCALL_SET_STACK, __KERNEL_DS|0x1, thread->sp0,
-		   THREAD_SIZE/PAGE_SIZE);
+	lazy_hcall3(LHCALL_SET_STACK, __KERNEL_DS | 0x1, thread->sp0,
+		   THREAD_SIZE / PAGE_SIZE);
 }
 
 /* Let's just say, I wouldn't do debugging under a Guest. */
@@ -856,7 +875,7 @@ static struct apic_ops lguest_basic_apic
 /* STOP!  Until an interrupt comes in. */
 static void lguest_safe_halt(void)
 {
-	hcall(LHCALL_HALT, 0, 0, 0);
+	kvm_hypercall0(LHCALL_HALT);
 }
 
 /* The SHUTDOWN hypercall takes a string to describe what's happening, and
@@ -866,7 +885,8 @@ static void lguest_safe_halt(void)
  * rather than virtual addresses, so we use __pa() here. */
 static void lguest_power_off(void)
 {
-	hcall(LHCALL_SHUTDOWN, __pa("Power down"), LGUEST_SHUTDOWN_POWEROFF, 0);
+	kvm_hypercall2(LHCALL_SHUTDOWN, __pa("Power down"),
+					LGUEST_SHUTDOWN_POWEROFF);
 }
 
 /*
@@ -876,7 +896,7 @@ static void lguest_power_off(void)
  */
 static int lguest_panic(struct notifier_block *nb, unsigned long l, void *p)
 {
-	hcall(LHCALL_SHUTDOWN, __pa(p), LGUEST_SHUTDOWN_POWEROFF, 0);
+	kvm_hypercall2(LHCALL_SHUTDOWN, __pa(p), LGUEST_SHUTDOWN_POWEROFF);
 	/* The hcall won't return, but to keep gcc happy, we're "done". */
 	return NOTIFY_DONE;
 }
@@ -917,7 +937,7 @@ static __init int early_put_chars(u32 vt
 		len = sizeof(scratch) - 1;
 	scratch[len] = '\0';
 	memcpy(scratch, buf, len);
-	hcall(LHCALL_NOTIFY, __pa(scratch), 0, 0);
+	kvm_hypercall1(LHCALL_NOTIFY, __pa(scratch));
 
 	/* This routine returns the number of bytes actually written. */
 	return len;
@@ -927,7 +947,7 @@ static __init int early_put_chars(u32 vt
  * Launcher to reboot us. */
 static void lguest_restart(char *reason)
 {
-	hcall(LHCALL_SHUTDOWN, __pa(reason), LGUEST_SHUTDOWN_RESTART, 0);
+	kvm_hypercall2(LHCALL_SHUTDOWN, __pa(reason), LGUEST_SHUTDOWN_RESTART);
 }
 
 /*G:050
diff --git a/arch/x86/lguest/i386_head.S b/arch/x86/lguest/i386_head.S
--- a/arch/x86/lguest/i386_head.S
+++ b/arch/x86/lguest/i386_head.S
@@ -27,8 +27,8 @@ ENTRY(lguest_entry)
 	/* We make the "initialization" hypercall now to tell the Host about
 	 * us, and also find out where it put our page tables. */
 	movl $LHCALL_LGUEST_INIT, %eax
-	movl $lguest_data - __PAGE_OFFSET, %edx
-	int $LGUEST_TRAP_ENTRY
+	movl $lguest_data - __PAGE_OFFSET, %ebx
+	.byte 0x0f,0x01,0xc1 /* KVM_HYPERCALL */
 
 	/* Set up the initial stack so we can run C code. */
 	movl $(init_thread_union+THREAD_SIZE),%esp
diff --git a/drivers/lguest/interrupts_and_traps.c b/drivers/lguest/interrupts_and_traps.c
--- a/drivers/lguest/interrupts_and_traps.c
+++ b/drivers/lguest/interrupts_and_traps.c
@@ -288,9 +288,10 @@ static int direct_trap(unsigned int num)
 
 	/* The Host needs to see page faults (for shadow paging and to save the
 	 * fault address), general protection faults (in/out emulation) and
-	 * device not available (TS handling), and of course, the hypercall
-	 * trap. */
-	return num != 14 && num != 13 && num != 7 && num != LGUEST_TRAP_ENTRY;
+	 * device not available (TS handling), invalid opcode fault (kvm hcall),
+	 * and of course, the hypercall trap. */
+	return num != 14 && num != 13 && num != 7 &&
+			num != 6 && num != LGUEST_TRAP_ENTRY;
 }
 /*:*/
 
diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -161,7 +161,7 @@ static void set_status(struct virtio_dev
 
 	/* We set the status. */
 	to_lgdev(vdev)->desc->status = status;
-	hcall(LHCALL_NOTIFY, (max_pfn<<PAGE_SHIFT) + offset, 0, 0);
+	kvm_hypercall1(LHCALL_NOTIFY, (max_pfn << PAGE_SHIFT) + offset);
 }
 
 static void lg_set_status(struct virtio_device *vdev, u8 status)
@@ -209,7 +209,7 @@ static void lg_notify(struct virtqueue *
 	 * virtqueue structure. */
 	struct lguest_vq_info *lvq = vq->priv;
 
-	hcall(LHCALL_NOTIFY, lvq->config.pfn << PAGE_SHIFT, 0, 0);
+	kvm_hypercall1(LHCALL_NOTIFY, lvq->config.pfn << PAGE_SHIFT);
 }
 
 /* An extern declaration inside a C file is bad form.  Don't do it. */
diff --git a/drivers/lguest/x86/core.c b/drivers/lguest/x86/core.c
--- a/drivers/lguest/x86/core.c
+++ b/drivers/lguest/x86/core.c
@@ -290,6 +290,57 @@ static int emulate_insn(struct lg_cpu *c
 	return 1;
 }
 
+/* Our hypercalls mechanism used to be based on direct software interrupts.
+ * After Anthony's "Refactor hypercall infrastructure" kvm patch, we decided to
+ * change over to using kvm hypercalls.
+ *
+ * KVM_HYPERCALL is actually a "vmcall" instruction, which generates an invalid
+ * opcode fault (fault 6) on non-VT cpus, so the easiest solution seemed to be
+ * an *emulation approach*: if the fault was really produced by an hypercall
+ * (is_hypercall() does exactly this check), we can just call the corresponding
+ * hypercall host implementation function.
+ *
+ * But these invalid opcode faults are notably slower than software interrupts.
+ * So we implemented the *patching (or rewriting) approach*: every time we hit
+ * the KVM_HYPERCALL opcode in Guest code, we patch it to the old "int 0x1f"
+ * opcode, so next time the Guest calls this hypercall it will use the
+ * faster trap mechanism.
+ *
+ * Matias even benchmarked it to convince you: this shows the average cycle
+ * cost of a hypercall.  For each alternative solution mentioned above we've
+ * made 5 runs of the benchmark:
+ *
+ * 1) direct software interrupt: 2915, 2789, 2764, 2721, 2898
+ * 2) emulation technique: 3410, 3681, 3466, 3392, 3780
+ * 3) patching (rewrite) technique: 2977, 2975, 2891, 2637, 2884
+ *
+ * One two-line function is worth a 20% hypercall speed boost!
+ */
+static void rewrite_hypercall(struct lg_cpu *cpu)
+{
+	/* This are the opcodes we use to patch the Guest.  The opcode for "int
+	 * $0x1f" is "0xcd 0x1f" but vmcall instruction is 3 bytes long, so we
+	 * complete the sequence with a NOP (0x90). */
+	u8 insn[3] = {0xcd, 0x1f, 0x90};
+
+	__lgwrite(cpu, guest_pa(cpu, cpu->regs->eip), insn, sizeof(insn));
+}
+
+static bool is_hypercall(struct lg_cpu *cpu)
+{
+	u8 insn[3];
+
+	/* This must be the Guest kernel trying to do something.
+	 * The bottom two bits of the CS segment register are the privilege
+	 * level. */
+	if ((cpu->regs->cs & 3) != GUEST_PL)
+		return false;
+
+	/* Is it a vmcall? */
+	__lgread(cpu, insn, guest_pa(cpu, cpu->regs->eip), sizeof(insn));
+	return insn[0] == 0x0f && insn[1] == 0x01 && insn[2] == 0xc1;
+}
+
 /*H:050 Once we've re-enabled interrupts, we look at why the Guest exited. */
 void lguest_arch_handle_trap(struct lg_cpu *cpu)
 {
@@ -337,7 +388,7 @@ void lguest_arch_handle_trap(struct lg_c
 		break;
 	case 32 ... 255:
 		/* These values mean a real interrupt occurred, in which case
-		 * the Host handler has already been run.  We just do a
+		 * the Host handler has already been run. We just do a
 		 * friendly check if another process should now be run, then
 		 * return to run the Guest again */
 		cond_resched();
@@ -347,6 +398,15 @@ void lguest_arch_handle_trap(struct lg_c
 		 * up the pointer now to indicate a hypercall is pending. */
 		cpu->hcall = (struct hcall_args *)cpu->regs;
 		return;
+	case 6:
+		/* kvm hypercalls trigger an invalid opcode fault (6).
+		 * We need to check if ring == GUEST_PL and
+		 * faulting instruction == vmcall. */
+		if (is_hypercall(cpu)) {
+			rewrite_hypercall(cpu);
+			return;
+		}
+		break;
 	}
 
 	/* We didn't handle the trap, so it needs to go to the Guest. */
