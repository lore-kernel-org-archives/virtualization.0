From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Wed, 13 Dec 2006 16:25:21 +1100
Message-ID: <1165987521.30792.12.camel@localhost.localdomain>
References: <457E0460.4030107@goop.org> <200612121301.08444.ak@suse.de>
	<457F0D02.3040000@goop.org>  <200612122215.19238.ak@suse.de>
	<1165984617.30792.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1165984617.30792.1.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-12-13 at 15:36 +1100, Rusty Russell wrote:
> On Tue, 2006-12-12 at 22:15 +0100, Andi Kleen wrote:
> > The failure is an assertation failure in ld.so.
> =

> OK, this patch tested on an assert() in init.

And this variant traps kill instead which is simpler:

Older glibcs assert() that the vdso will be in a particular spot
(which it can no longer be with CONFIG_PARAVIRT).  As this glibc was
shipped in SuSE 9.0 and Fedora Core 1, it's not a trivial breakage.

Try to detect the failing init at runtime, turn off vdso and re-exec.
Not tested on this particular assertion, but should work.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 2d9ddfd41f3a arch/i386/Kconfig
--- a/arch/i386/Kconfig	Wed Dec 13 16:04:20 2006 +1100
+++ b/arch/i386/Kconfig	Wed Dec 13 16:04:21 2006 +1100
@@ -816,15 +816,14 @@ config HOTPLUG_CPU
 	  /sys/devices/system/cpu.
 =

 config COMPAT_VDSO
-	bool "Compat VDSO support"
-	default y
-	depends on !PARAVIRT
-	help
-	  Map the VDSO to the predictable old-style address too.
-	---help---
-	  Say N here if you are running a sufficiently recent glibc
-	  version (2.3.3 or later), to remove the high-mapped
-	  VDSO mapping and to exclusively use the randomized VDSO.
+	bool "Disable VDSO for old glibc"
+	default y
+	---help---
+	  Old glibc does not like the modern VDSO placement (glibc
+	  2.3.3 or later is fine, Fedora Core 1 and SuSE 9.0 have
+	  problems).  Very old glibc versions don't use the VDSO at
+	  all.  This option tries to detect the glibc assertion which
+	  occurs and then disables the VDSO.
 =

 	  If unsure, say Y.
 =

diff -r 2d9ddfd41f3a arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c	Wed Dec 13 16:04:20 2006 +1100
+++ b/arch/i386/kernel/signal.c	Wed Dec 13 16:20:32 2006 +1100
@@ -655,3 +655,22 @@ void do_notify_resume(struct pt_regs *re
 	=

 	clear_thread_flag(TIF_IRET);
 }
+
+#ifdef CONFIG_COMPAT_VDSO
+#include <linux/syscalls.h>
+
+asmlinkage long
+sys_check_init_abort_kill(int pid, int sig)
+{
+	if (unlikely(current =3D=3D child_reaper)
+	    && pid =3D=3D 1 && sig =3D=3D SIGABRT && vdso_enabled) {
+		void reexec_init(void);
+		printk(KERN_WARNING "COMPAT_VDSO: Old glibc?"
+		       " Re-execing init with vdso disabled\n");
+		vdso_enabled =3D 0;
+		reexec_init();
+		printk(KERN_WARNING "Re-exec of init failed\n");
+	}
+	return sys_kill(pid, sig);
+}
+#endif
diff -r 2d9ddfd41f3a arch/i386/kernel/syscall_table.S
--- a/arch/i386/kernel/syscall_table.S	Wed Dec 13 16:04:20 2006 +1100
+++ b/arch/i386/kernel/syscall_table.S	Wed Dec 13 16:06:44 2006 +1100
@@ -36,7 +36,11 @@ ENTRY(sys_call_table)
 	.long sys_nice
 	.long sys_ni_syscall	/* 35 - old ftime syscall holder */
 	.long sys_sync
+#ifdef CONFIG_COMPAT_VDSO
+	.long sys_check_init_abort_kill
+#else
 	.long sys_kill
+#endif
 	.long sys_rename
 	.long sys_mkdir
 	.long sys_rmdir		/* 40 */
diff -r 2d9ddfd41f3a arch/i386/kernel/sysenter.c
--- a/arch/i386/kernel/sysenter.c	Wed Dec 13 16:04:20 2006 +1100
+++ b/arch/i386/kernel/sysenter.c	Wed Dec 13 16:04:21 2006 +1100
@@ -27,11 +27,7 @@
  * Should the kernel map a VDSO page into processes and pass its
  * address down to glibc upon exec()?
  */
-#ifdef CONFIG_PARAVIRT
-unsigned int __read_mostly vdso_enabled =3D 0;
-#else
 unsigned int __read_mostly vdso_enabled =3D 1;
-#endif
 =

 EXPORT_SYMBOL_GPL(vdso_enabled);
 =

@@ -76,15 +72,10 @@ int __init sysenter_setup(void)
 {
 	syscall_page =3D (void *)get_zeroed_page(GFP_ATOMIC);
 =

-#ifdef CONFIG_COMPAT_VDSO
-	__set_fixmap(FIX_VDSO, __pa(syscall_page), PAGE_READONLY);
-	printk("Compat vDSO mapped to %08lx.\n", __fix_to_virt(FIX_VDSO));
-#else
 	/*
 	 * In the non-compat case the ELF coredumping code needs the fixmap:
 	 */
 	__set_fixmap(FIX_VDSO, __pa(syscall_page), PAGE_KERNEL_RO);
-#endif
 =

 	if (!boot_cpu_has(X86_FEATURE_SEP)) {
 		memcpy(syscall_page,
diff -r 2d9ddfd41f3a arch/i386/mm/pgtable.c
--- a/arch/i386/mm/pgtable.c	Wed Dec 13 16:04:20 2006 +1100
+++ b/arch/i386/mm/pgtable.c	Wed Dec 13 16:04:21 2006 +1100
@@ -144,10 +144,8 @@ void set_pmd_pfn(unsigned long vaddr, un
 }
 =

 static int fixmaps;
-#ifndef CONFIG_COMPAT_VDSO
 unsigned long __FIXADDR_TOP =3D 0xfffff000;
 EXPORT_SYMBOL(__FIXADDR_TOP);
-#endif
 =

 void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t =
flags)
 {
@@ -171,12 +169,8 @@ void reserve_top_address(unsigned long r
 void reserve_top_address(unsigned long reserve)
 {
 	BUG_ON(fixmaps > 0);
-#ifdef CONFIG_COMPAT_VDSO
-	BUG_ON(reserve !=3D 0);
-#else
 	__FIXADDR_TOP =3D -reserve - PAGE_SIZE;
 	__VMALLOC_RESERVE +=3D reserve;
-#endif
 }
 =

 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
diff -r 2d9ddfd41f3a include/asm-i386/elf.h
--- a/include/asm-i386/elf.h	Wed Dec 13 16:04:20 2006 +1100
+++ b/include/asm-i386/elf.h	Wed Dec 13 16:04:21 2006 +1100
@@ -135,13 +135,8 @@ extern int dump_task_extended_fpu (struc
 #define VDSO_HIGH_BASE		(__fix_to_virt(FIX_VDSO))
 #define VDSO_BASE		((unsigned long)current->mm->context.vdso)
 =

-#ifdef CONFIG_COMPAT_VDSO
-# define VDSO_COMPAT_BASE	VDSO_HIGH_BASE
-# define VDSO_PRELINK		VDSO_HIGH_BASE
-#else
 # define VDSO_COMPAT_BASE	VDSO_BASE
 # define VDSO_PRELINK		0
-#endif
 =

 #define VDSO_COMPAT_SYM(x) \
 		(VDSO_COMPAT_BASE + (unsigned long)(x) - VDSO_PRELINK)
diff -r 2d9ddfd41f3a include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Wed Dec 13 16:04:20 2006 +1100
+++ b/include/asm-i386/fixmap.h	Wed Dec 13 16:04:21 2006 +1100
@@ -19,11 +19,7 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#ifndef CONFIG_COMPAT_VDSO
 extern unsigned long __FIXADDR_TOP;
-#else
-#define __FIXADDR_TOP  0xfffff000
-#endif
 =

 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
diff -r 2d9ddfd41f3a init/main.c
--- a/init/main.c	Wed Dec 13 16:04:20 2006 +1100
+++ b/init/main.c	Wed Dec 13 16:04:21 2006 +1100
@@ -710,6 +710,16 @@ static void run_init_process(char *init_
 	kernel_execve(init_filename, argv_init, envp_init);
 }
 =

+#ifdef CONFIG_COMPAT_VDSO
+void reexec_init(void)
+{
+	mm_segment_t oldfs =3D get_fs();
+	set_fs(KERNEL_DS);
+	kernel_execve(argv_init[0], argv_init, envp_init);
+	set_fs(oldfs);
+}
+#endif
+
 static int init(void * unused)
 {
 	lock_kernel();
