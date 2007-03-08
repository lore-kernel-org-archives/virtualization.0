From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 10/17] paravirt_ops - boot changes
Date: Thu, 08 Mar 2007 01:02:23 -0500
Message-ID: <1173333743.25848.11.camel@localhost.localdomain>
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

plain text document attachment (xx-paravirt-boot.patch)
Boot up code modifications to get paravirt ops running.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>



Index: clean-start/arch/x86_64/kernel/head.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/head.S
+++ clean-start/arch/x86_64/kernel/head.S
@@ -16,6 +16,13 @@
 #include <asm/page.h>
 #include <asm/msr.h>
 #include <asm/cache.h>
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/asm-offsets.h>
+#include <asm/paravirt.h>
+#else
+#define GET_CR2_INTO_RAX mov %cr2, %rax
+#endif
 	=

 /* we are not able to switch in one step to the final KERNEL ADRESS SPACE
  * because we need identity-mapped pages on setup so define __START_KERNEL=
 to
@@ -106,6 +113,14 @@ startup_64:
 	 * reload the page tables here.
 	 */
 =

+#ifdef CONFIG_PARAVIRT
+	/* a CS ended in 0x3 indicates we're in userspace. That's where
+	 * our paravirt guests run. */
+	movq	%cs, %rax
+	testq	$0x3, %rax
+	jnz	startup_paravirt
+#endif
+
 	/* Enable PAE mode and PGE */
 	xorq	%rax, %rax
 	btsq	$5, %rax
@@ -208,10 +223,11 @@ ENTRY(early_idt_handler)
 	cmpl $2,early_recursion_flag(%rip)
 	jz  1f
 	incl early_recursion_flag(%rip)
-	xorl %eax,%eax
 	movq 8(%rsp),%rsi	# get rip
 	movq (%rsp),%rdx
-	movq %cr2,%rcx
+	GET_CR2_INTO_RAX
+	movq %rax,%rcx
+	xorq %rax, %rax
 	leaq early_idt_msg(%rip),%rdi
 	call early_printk
 	cmpl $2,early_recursion_flag(%rip)
@@ -232,6 +248,47 @@ early_idt_msg:
 early_idt_ripmsg:
 	.asciz "RIP %s\n"
 =

+#ifdef CONFIG_PARAVIRT
+ENTRY(startup_paravirt)
+	cld
+
+	/* initial stack location */
+ 	movq $(init_thread_union+THREAD_SIZE),%rsp
+
+	/* We take pains to preserve all the regs. */
+	pushq	%r11
+	pushq	%r10
+	pushq	%r9
+	pushq	%r8
+	pushq	%rsi
+	pushq	%rdi
+	pushq	%rdx
+	pushq	%rcx
+	pushq	%rax
+
+	/* paravirt.o is last in link, and that probe fn never returns */
+	pushq	$__start_paravirtprobe
+1:
+	movq	0(%rsp), %rax
+	pushq	(%rax)
+	movq	8(%rsp), %rdi
+	call	*(%rsp)
+	popq	%rax
+
+	movq	0x10(%rsp), %rax
+	movq	0x18(%rsp), %rcx
+	movq	0x20(%rsp), %rdx
+	movq	0x28(%rsp), %rdi
+	movq	0x30(%rsp), %rsi
+	movq	0x38(%rsp), %r8
+	movq	0x40(%rsp), %r9
+	movq	0x48(%rsp), %r10
+	movq	0x50(%rsp), %r11
+
+	addl	$8, (%rsp)
+	jmp	1b
+#endif
+
 .code32
 ENTRY(no_long_mode)
 	/* This isn't an x86-64 CPU so hang */
@@ -317,7 +374,9 @@ ENTRY(wakeup_level4_pgt)
 #endif
 =

 #ifndef CONFIG_HOTPLUG_CPU
+  #ifndef CONFIG_PARAVIRT
 	__INITDATA
+  #endif
 #endif
 	/*
 	 * This default setting generates an ident mapping at address 0x100000
Index: clean-start/arch/x86_64/kernel/head64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/head64.c
+++ clean-start/arch/x86_64/kernel/head64.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/percpu.h>
+#include <linux/module.h>
 =

 #include <asm/processor.h>
 #include <asm/proto.h>
@@ -20,6 +21,9 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 =

+/* Virtualized guests may want to use it */
+EXPORT_SYMBOL(cpu_gdt_descr);
+
 /* Don't add a printk in there. printk relies on the PDA which is not init=
ialized =

    yet. */
 static void __init clear_bss(void)
@@ -62,7 +66,7 @@ void __init x86_64_start_kernel(char * r
 =

 	for (i =3D 0; i < IDT_ENTRIES; i++)
 		set_intr_gate(i, early_idt_handler);
-	asm volatile("lidt %0" :: "m" (idt_descr));
+	load_idt((const struct desc_ptr *)&idt_descr);
 =

 	early_printk("Kernel alive\n");
 =

@@ -70,7 +74,7 @@ void __init x86_64_start_kernel(char * r
 	 * switch to init_level4_pgt from boot_level4_pgt
 	 */
 	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
-	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
+	write_cr3(__pa_symbol(&init_level4_pgt));
 =

  	for (i =3D 0; i < NR_CPUS; i++)
  		cpu_pda(i) =3D &boot_cpu_pda[i];
Index: clean-start/arch/x86_64/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/process.c
+++ clean-start/arch/x86_64/kernel/process.c
@@ -42,6 +42,7 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/processor.h>
+#include <asm/system.h>
 #include <asm/i387.h>
 #include <asm/mmu_context.h>
 #include <asm/pda.h>
@@ -338,10 +339,10 @@ void __show_regs(struct pt_regs * regs)
 	rdmsrl(MSR_GS_BASE, gs); =

 	rdmsrl(MSR_KERNEL_GS_BASE, shadowgs); =

 =

-	asm("movq %%cr0, %0": "=3Dr" (cr0));
-	asm("movq %%cr2, %0": "=3Dr" (cr2));
-	asm("movq %%cr3, %0": "=3Dr" (cr3));
-	asm("movq %%cr4, %0": "=3Dr" (cr4));
+	cr0 =3D read_cr0();
+	cr2 =3D read_cr2();
+	cr3 =3D read_cr3();
+	cr4 =3D read_cr4();
 =

 	printk("FS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n", =

 	       fs,fsindex,gs,gsindex,shadowgs); =

@@ -578,7 +579,7 @@ __switch_to(struct task_struct *prev_p, =

 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
-	tss->rsp0 =3D next->rsp0;
+	load_rsp0(tss, next);
 =

 	/* =

 	 * Switch DS and ES.
Index: clean-start/arch/x86_64/kernel/reboot.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/reboot.c
+++ clean-start/arch/x86_64/kernel/reboot.c
@@ -15,6 +15,7 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/apic.h>
+#include <asm/desc.h>
 =

 /*
  * Power off function, if any
@@ -131,7 +132,7 @@ void machine_emergency_restart(void)
 		}
 =

 		case BOOT_TRIPLE: =

-			__asm__ __volatile__("lidt (%0)": :"r" (&no_idt));
+			load_idt((const struct desc_ptr *)&no_idt);
 			__asm__ __volatile__("int3");
 =

 			reboot_type =3D BOOT_KBD;
Index: clean-start/arch/x86_64/kernel/setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/setup.c
+++ clean-start/arch/x86_64/kernel/setup.c
@@ -327,10 +327,7 @@ static void discover_ebda(void)
 	 * there is a real-mode segmented pointer pointing to the =

 	 * 4K EBDA area at 0x40E
 	 */
-	ebda_addr =3D *(unsigned short *)EBDA_ADDR_POINTER;
-	ebda_addr <<=3D 4;
-
-	ebda_size =3D *(unsigned short *)(unsigned long)ebda_addr;
+	ebda_info(&ebda_addr,&ebda_size);
 =

 	/* Round EBDA up to pages */
 	if (ebda_size =3D=3D 0)
@@ -341,6 +338,12 @@ static void discover_ebda(void)
 		ebda_size =3D 64*1024;
 }
 =

+/* Overridden in paravirt.c if CONFIG_PARAVIRT */
+void __attribute__((weak)) memory_setup(void)
+{
+       return setup_memory_region();
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	printk(KERN_INFO "Command line: %s\n", saved_command_line);
@@ -356,7 +359,7 @@ void __init setup_arch(char **cmdline_p)
 	rd_prompt =3D ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) !=3D 0);
 	rd_doload =3D ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) !=3D 0);
 #endif
-	setup_memory_region();
+	memory_setup();
 	copy_edd();
 =

 	if (!MOUNT_ROOT_RDONLY)
@@ -561,7 +564,6 @@ static int __cpuinit get_model_name(stru
 	return 1;
 }
 =

-
 static void __cpuinit display_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, eax, ebx, ecx, edx;
Index: clean-start/arch/x86_64/kernel/setup64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/setup64.c
+++ clean-start/arch/x86_64/kernel/setup64.c
@@ -123,7 +123,7 @@ void pda_init(int cpu)
 	asm volatile("movl %0,%%fs ; movl %0,%%gs" :: "r" (0)); =

 	/* Memory clobbers used to order PDA accessed */
 	mb();
-	wrmsrl(MSR_GS_BASE, pda);
+	wrmsrl(MSR_GS_BASE, (u64)pda);
 	mb();
 =

 	pda->cpunumber =3D cpu; =

@@ -152,7 +152,7 @@ char boot_exception_stacks[(N_EXCEPTION_
 __attribute__((section(".bss.page_aligned")));
 =

 /* May not be marked __init: used by software suspend */
-void syscall_init(void)
+void x86_64_syscall_init(void)
 {
 	/* =

 	 * LSTAR and STAR live in a bit strange symbiosis.
@@ -160,7 +160,7 @@ void syscall_init(void)
 	 * but only a 32bit target. LSTAR sets the 64bit rip. 	 =

 	 */ =

 	wrmsrl(MSR_STAR,  ((u64)__USER32_CS)<<48  | ((u64)__KERNEL_CS)<<32); =

-	wrmsrl(MSR_LSTAR, system_call); =

+	wrmsrl(MSR_LSTAR, (u64)system_call);
 =

 #ifdef CONFIG_IA32_EMULATION   		=

 	syscall32_cpu_init ();
@@ -170,6 +170,12 @@ void syscall_init(void)
 	wrmsrl(MSR_SYSCALL_MASK, EF_TF|EF_DF|EF_IE|0x3000); =

 }
 =

+/* Overriden in paravirt.c if CONFIG_PARAVIRT */
+void __attribute__((weak)) syscall_init(void)
+{
+	x86_64_syscall_init();
+}
+
 void __cpuinit check_efer(void)
 {
 	unsigned long efer;
@@ -223,8 +229,8 @@ void __cpuinit cpu_init (void)
  		memcpy(cpu_gdt(cpu), cpu_gdt_table, GDT_SIZE);
 =

 	cpu_gdt_descr[cpu].size =3D GDT_SIZE;
-	asm volatile("lgdt %0" :: "m" (cpu_gdt_descr[cpu]));
-	asm volatile("lidt %0" :: "m" (idt_descr));
+	load_gdt((const struct desc_ptr *)&cpu_gdt_descr[cpu]);
+	load_idt((const struct desc_ptr *)&idt_descr);
 =

 	memset(me->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
 	syscall_init();
@@ -267,6 +273,7 @@ void __cpuinit cpu_init (void)
 		BUG();
 	enter_lazy_tlb(&init_mm, me);
 =

+	load_rsp0(t, &current->thread);
 	set_tss_desc(cpu, t);
 	load_TR_desc();
 	load_LDT(&init_mm.context);
Index: clean-start/arch/x86_64/kernel/smpboot.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/smpboot.c
+++ clean-start/arch/x86_64/kernel/smpboot.c
@@ -848,7 +848,7 @@ do_rest:
 	start_rip =3D setup_trampoline();
 =

 	init_rsp =3D c_idle.idle->thread.rsp;
-	per_cpu(init_tss,cpu).rsp0 =3D init_rsp;
+	load_rsp0(&per_cpu(init_tss,cpu), &c_idle.idle->thread);
 	initial_code =3D start_secondary;
 	clear_tsk_thread_flag(c_idle.idle, TIF_FORK);
 =

Index: clean-start/arch/x86_64/kernel/vmlinux.lds.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ clean-start/arch/x86_64/kernel/vmlinux.lds.S
@@ -61,6 +61,13 @@ SECTIONS
 	CONSTRUCTORS
 	} :data
 =

+  .paravirtprobe : AT(ADDR(.paravirtprobe) - LOAD_OFFSET) {
+	__start_paravirtprobe =3D .;
+	*(.paravirtprobe);
+	*(.paravirtprobe_failsafe);
+	__stop_paravirtprobe =3D .;
+  }
+
   _edata =3D .;			/* End of data section */
 =

   . =3D ALIGN(PAGE_SIZE);
@@ -180,14 +187,20 @@ SECTIONS
   __con_initcall_end =3D .;
   SECURITY_INIT
   . =3D ALIGN(8);
-  __alt_instructions =3D .;
   .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+	__alt_instructions =3D .;
 	*(.altinstructions)
+  	__alt_instructions_end =3D .;
   }
-  __alt_instructions_end =3D .; =

   .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
 	*(.altinstr_replacement)
   }
+  . =3D ALIGN(8);
+  .parainstructions : AT(ADDR(.parainstructions)  - LOAD_OFFSET) {
+	__start_parainstructions =3D .;
+	*(.parainstructions)
+	__stop_parainstructions =3D .;
+  }
   /* .exit.text is discard at runtime, not link time, to deal with referen=
ces
      from .altinstructions and .eh_frame */
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }

--
