From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 4/4] Make COMPAT_VDSO runtime selectable.
Date: Fri, 06 Apr 2007 15:41:56 -0700
Message-ID: <20070406224205.093530064@goop.org>
References: <20070406224152.556848893@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=runtime-COMPAT_VDSO-selection.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that relocation of the VDSO for COMPAT_VDSO users is done at
runtime rather than compile time, it is possible to enable/disable
compat mode at runtime.

This patch allows you to enable COMPAT_VDSO mode with "vdso=3D2" on the
kernel command line, or via sysctl.  (Switching on a running system
shouldn't be done lightly; any process which was relying on the compat
VDSO will be upset if it goes away.)

The COMPAT_VDSO config option still exists, but if enabled it just
makes vdso_enabled default to VDSO_COMPAT.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: "Jan Beulich" <JBeulich@novell.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Roland McGrath <roland@redhat.com>

---
 Documentation/kernel-parameters.txt |    1 =

 arch/i386/kernel/sysenter.c         |  141 +++++++++++++++++++++++--------=
----
 include/asm-i386/page.h             |    2 =

 3 files changed, 94 insertions(+), 50 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1807,6 +1807,7 @@ and is between 256 and 4096 characters. =

 			[USBHID] The interval which mice are to be polled at.
 =

 	vdso=3D		[IA-32,SH]
+			vdso=3D2: enable compat VDSO (default with COMPAT_VDSO)
 			vdso=3D1: enable VDSO (default)
 			vdso=3D0: disable VDSO mapping
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/sysenter.c
+++ b/arch/i386/kernel/sysenter.c
@@ -23,12 +23,25 @@
 #include <asm/pgtable.h>
 #include <asm/unistd.h>
 #include <asm/elf.h>
+#include <asm/tlbflush.h>
+
+enum {
+	VDSO_DISABLED =3D 0,
+	VDSO_ENABLED =3D 1,
+	VDSO_COMPAT =3D 2,
+};
+
+#ifdef CONFIG_COMPAT_VDSO
+#define VDSO_DEFAULT	VDSO_COMPAT
+#else
+#define VDSO_DEFAULT	VDSO_ENABLED
+#endif
 =

 /*
  * Should the kernel map a VDSO page into processes and pass its
  * address down to glibc upon exec()?
  */
-unsigned int __read_mostly vdso_enabled =3D 1;
+unsigned int __read_mostly vdso_enabled =3D VDSO_DEFAULT;
 =

 EXPORT_SYMBOL_GPL(vdso_enabled);
 =

@@ -43,7 +56,6 @@ __setup("vdso=3D", vdso_setup);
 =

 extern asmlinkage void sysenter_entry(void);
 =

-#ifdef CONFIG_COMPAT_VDSO
 static __init void reloc_symtab(Elf32_Ehdr *ehdr,
 				unsigned offset, unsigned size)
 {
@@ -160,11 +172,6 @@ static __init void relocate_vdso(Elf32_E
 				     shdr[i].sh_size);
 	}
 }
-#else
-static inline void relocate_vdso(Elf32_Ehdr *ehdr)
-{
-}
-#endif	/* COMPAT_VDSO */
 =

 void enable_sep_cpu(void)
 {
@@ -182,6 +189,25 @@ void enable_sep_cpu(void)
 	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp1, 0);
 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
 	put_cpu();	=

+}
+
+static struct vm_area_struct gate_vma;
+
+static int __init gate_vma_init(void)
+{
+	gate_vma.vm_mm =3D NULL;
+	gate_vma.vm_start =3D FIXADDR_USER_START;
+	gate_vma.vm_end =3D FIXADDR_USER_END;
+	gate_vma.vm_flags =3D VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
+	gate_vma.vm_page_prot =3D __P101;
+	/*
+	 * Make sure the vDSO gets into every core dump.
+	 * Dumping its contents makes post-mortem fully interpretable later
+	 * without matching up the same kernel and hardware config to see
+	 * what PC values meant.
+	 */
+	gate_vma.vm_flags |=3D VM_ALWAYSDUMP;
+	return 0;
 }
 =

 /*
@@ -192,6 +218,22 @@ extern const char vsyscall_sysenter_star
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
 static struct page *syscall_pages[1];
 =

+static void map_compat_vdso(int map)
+{
+	static int vdso_mapped;
+
+	if (map =3D=3D vdso_mapped)
+		return;
+
+	vdso_mapped =3D map;
+
+	__set_fixmap(FIX_VDSO, page_to_pfn(syscall_pages[0]) << PAGE_SHIFT,
+		     map ? PAGE_READONLY_EXEC : PAGE_NONE);
+
+	/* flush stray tlbs */
+	flush_tlb_all();
+}
+
 int __init sysenter_setup(void)
 {
 	void *syscall_page =3D (void *)get_zeroed_page(GFP_ATOMIC);
@@ -200,10 +242,9 @@ int __init sysenter_setup(void)
 =

 	syscall_pages[0] =3D virt_to_page(syscall_page);
 =

-#ifdef CONFIG_COMPAT_VDSO
-	__set_fixmap(FIX_VDSO, __pa(syscall_page), PAGE_READONLY_EXEC);
+	gate_vma_init();
+
 	printk("Compat vDSO mapped to %08lx.\n", __fix_to_virt(FIX_VDSO));
-#endif
 =

 	if (!boot_cpu_has(X86_FEATURE_SEP)) {
 		vsyscall =3D &vsyscall_int80_start;
@@ -222,42 +263,57 @@ int __init sysenter_setup(void)
 /* Defined in vsyscall-sysenter.S */
 extern void SYSENTER_RETURN;
 =

-#ifdef __HAVE_ARCH_GATE_AREA
 /* Setup a VMA at program startup for the vsyscall page */
 int arch_setup_additional_pages(struct linux_binprm *bprm, int exstack)
 {
 	struct mm_struct *mm =3D current->mm;
 	unsigned long addr;
 	int ret;
+	bool compat;
 =

 	down_write(&mm->mmap_sem);
-	addr =3D get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
-	if (IS_ERR_VALUE(addr)) {
-		ret =3D addr;
-		goto up_fail;
-	}
-
-	/*
-	 * MAYWRITE to allow gdb to COW and set breakpoints
-	 *
-	 * Make sure the vDSO gets into every core dump.
-	 * Dumping its contents makes post-mortem fully interpretable later
-	 * without matching up the same kernel and hardware config to see
-	 * what PC values meant.
-	 */
-	ret =3D install_special_mapping(mm, addr, PAGE_SIZE,
-				      VM_READ|VM_EXEC|
-				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
-				      VM_ALWAYSDUMP,
-				      syscall_pages);
-	if (ret)
-		goto up_fail;
+
+	/* Test compat mode once here, in case someone
+	   changes it via sysctl */
+	compat =3D (vdso_enabled =3D=3D VDSO_COMPAT);
+
+	map_compat_vdso(compat);
+
+	if (compat)
+		addr =3D VDSO_HIGH_BASE;
+	else {
+		addr =3D get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
+		if (IS_ERR_VALUE(addr)) {
+			ret =3D addr;
+			goto up_fail;
+		}
+
+		/*
+		 * MAYWRITE to allow gdb to COW and set breakpoints
+		 *
+		 * Make sure the vDSO gets into every core dump.
+		 * Dumping its contents makes post-mortem fully
+		 * interpretable later without matching up the same
+		 * kernel and hardware config to see what PC values
+		 * meant.
+		 */
+		ret =3D install_special_mapping(mm, addr, PAGE_SIZE,
+					      VM_READ|VM_EXEC|
+					      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+					      VM_ALWAYSDUMP,
+					      syscall_pages);
+
+		if (ret)
+			goto up_fail;
+	}
 =

 	current->mm->context.vdso =3D (void *)addr;
 	current_thread_info()->sysenter_return =3D
-				    (void *)VDSO_SYM(&SYSENTER_RETURN);
-up_fail:
+		(void *)VDSO_SYM(&SYSENTER_RETURN);
+
+  up_fail:
 	up_write(&mm->mmap_sem);
+
 	return ret;
 }
 =

@@ -270,6 +326,9 @@ const char *arch_vma_name(struct vm_area
 =

 struct vm_area_struct *get_gate_vma(struct task_struct *tsk)
 {
+	/* Check to see if this task was created in compat vdso mode */
+	if (tsk->mm->context.vdso =3D=3D (void *)VDSO_HIGH_BASE)
+		return &gate_vma;
 	return NULL;
 }
 =

@@ -282,17 +341,3 @@ int in_gate_area_no_task(unsigned long a
 {
 	return 0;
 }
-#else  /* !__HAVE_ARCH_GATE_AREA */
-int arch_setup_additional_pages(struct linux_binprm *bprm, int exstack)
-{
-	/*
-	 * If not creating userspace VMA, simply set vdso to point to
-	 * fixmap page.
-	 */
-	current->mm->context.vdso =3D (void *)VDSO_HIGH_BASE;
-	current_thread_info()->sysenter_return =3D
-		(void *)VDSO_SYM(&SYSENTER_RETURN);
-
-	return 0;
-}
-#endif	/* __HAVE_ARCH_GATE_AREA */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -143,9 +143,7 @@ extern int page_is_ram(unsigned long pag
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 =

-#ifndef CONFIG_COMPAT_VDSO
 #define __HAVE_ARCH_GATE_AREA 1
-#endif
 #endif /* __KERNEL__ */
 =

 #endif /* _I386_PAGE_H */

-- =
