From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Wed, 13 Dec 2006 13:04:24 +1100
Message-ID: <1165975464.30004.44.camel@localhost.localdomain>
References: <457E0460.4030107@goop.org> <200612121301.08444.ak@suse.de>
	<457F0D02.3040000@goop.org>  <200612122215.19238.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200612122215.19238.ak@suse.de>
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

On Tue, 2006-12-12 at 22:15 +0100, Andi Kleen wrote:
> On Tuesday 12 December 2006 21:11, Jeremy Fitzhardinge wrote:
> > Andi Kleen wrote:
> > > I don't think being incompatible to old binaries is a sensible defaul=
t. That
> > > is why I changed the wrong default. If paravirt ops cannot supply
> > > a compatible vdso it has to do without one.
> > =

> > Do you know what glibc2.1 actually needs from the vdso?  Does it
> > actually interpret as an elf file,
> =

> Interpret it as a ELF file, but then has some special hacks to jump
> directly anyways (or at least there is no direct linking, but =

> it goes over a trampoline in the main glibc)
> =

> The failure is an assertation failure in ld.so.

And since init is special, the SIGABRT doesn't get delivered.  Andi,
does this hack come close?  (Against older kernel, you'll need to take
out the #ifdef CONFIG_PARAVIRT around the vdso_enabled initialization).

Rusty.


Older glibcs assert() that the vdso will be in a particular spot
(which it can no longer be with CONFIG_PARAVIRT).  As this glibc was
shipped in SuSE 9.0 and Fedora Core 1, it's not a trivial breakage.

Try to detect the failing init at runtime, turn off vdso and re-exec.
Untested, since I don't have a failing system.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r c3d6f0e043e0 arch/i386/Kconfig
--- a/arch/i386/Kconfig	Wed Nov 15 19:21:22 2006 +1100
+++ b/arch/i386/Kconfig	Wed Dec 13 12:20:49 2006 +1100
@@ -848,15 +848,14 @@ config HOTPLUG_CPU
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

diff -r c3d6f0e043e0 arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c	Wed Nov 15 19:21:22 2006 +1100
+++ b/arch/i386/kernel/signal.c	Wed Dec 13 12:47:16 2006 +1100
@@ -608,6 +608,17 @@ static void fastcall do_signal(struct pt
 =

 		return;
 	}
+#ifdef CONFIG_COMPAT_VDSO
+	else if (signr =3D=3D -1) {
+		void reexec_init(void);
+		static int reexec_done;
+		if (!reexec_done++) {
+			printk("COMPAT_VDSO: old glibc?  Disabling vdso\n");
+			vdso_enabled =3D 0;
+			reexec_init();
+		}
+	}
+#endif
 =

 	/* Did we come from a system call? */
 	if (regs->orig_eax >=3D 0) {
diff -r c3d6f0e043e0 arch/i386/kernel/sysenter.c
--- a/arch/i386/kernel/sysenter.c	Wed Nov 15 19:21:22 2006 +1100
+++ b/arch/i386/kernel/sysenter.c	Wed Dec 13 12:17:02 2006 +1100
@@ -72,15 +72,10 @@ int __init sysenter_setup(void)
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
diff -r c3d6f0e043e0 arch/i386/mm/pgtable.c
--- a/arch/i386/mm/pgtable.c	Wed Nov 15 19:21:22 2006 +1100
+++ b/arch/i386/mm/pgtable.c	Wed Dec 13 12:17:18 2006 +1100
@@ -141,10 +141,8 @@ void set_pmd_pfn(unsigned long vaddr, un
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
@@ -168,12 +166,8 @@ void reserve_top_address(unsigned long r
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
diff -r c3d6f0e043e0 include/asm-i386/elf.h
--- a/include/asm-i386/elf.h	Wed Nov 15 19:21:22 2006 +1100
+++ b/include/asm-i386/elf.h	Wed Dec 13 12:43:45 2006 +1100
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
diff -r c3d6f0e043e0 include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Wed Nov 15 19:21:22 2006 +1100
+++ b/include/asm-i386/fixmap.h	Wed Dec 13 12:39:42 2006 +1100
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
diff -r c3d6f0e043e0 init/main.c
--- a/init/main.c	Wed Nov 15 19:21:22 2006 +1100
+++ b/init/main.c	Wed Dec 13 12:01:27 2006 +1100
@@ -707,6 +707,13 @@ static void run_init_process(char *init_
 	kernel_execve(init_filename, argv_init, envp_init);
 }
 =

+#ifdef CONFIG_COMPAT_VDSO
+void reexec_init(void)
+{
+	kernel_execve(argv_init[0], argv_init, envp_init);
+}
+#endif
+
 static int init(void * unused)
 {
 	lock_kernel();
diff -r c3d6f0e043e0 kernel/signal.c
--- a/kernel/signal.c	Wed Nov 15 19:21:22 2006 +1100
+++ b/kernel/signal.c	Wed Dec 13 11:59:05 2006 +1100
@@ -2010,8 +2010,17 @@ relock:
 		 * within that pid space. It can of course get signals from
 		 * its parent pid space.
 		 */
-		if (current =3D=3D child_reaper(current))
+		if (current =3D=3D child_reaper(current)) {
+#ifdef CONFIG_COMPAT_VDSO
+			/* Gross hack: Old glibc asserts, not
+			   liking moved vdso (SuSE 9, FC1) */
+			if (signr =3D=3D SIGABRT && list_empty(&current->children)) {
+				signr =3D -1;
+				break;
+			}
+#endif				=

 			continue;
+		}
 =

 		if (sig_kernel_stop(signr)) {
 			/*
