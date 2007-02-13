From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 09/21] Xen-paravirt: add hooks to intercept mm creation and
	destruction
Date: Tue, 13 Feb 2007 14:17:38 -0800
Message-ID: <20070213221830.159330386@goop.org>
References: <20070213221729.772002682@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=mm-lifetime-hooks.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add hooks to allow a paravirt implementation to track the lifetime of
an mm.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
--
 arch/i386/kernel/paravirt.c    |    4 ++++
 include/asm-i386/mmu_context.h |    8 ++++++--
 include/asm-i386/paravirt.h    |   38 ++++++++++++++++++++++++++++++++++++=
++
 kernel/fork.c                  |    3 +++
 mm/mmap.c                      |    4 ++++
 5 files changed, 55 insertions(+), 2 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -706,6 +706,10 @@ struct paravirt_ops paravirt_ops =3D {
 	.irq_enable_sysexit =3D native_irq_enable_sysexit,
 	.iret =3D native_iret,
 =

+	.dup_mmap =3D (void *)native_nop,
+	.exit_mmap =3D (void *)native_nop,
+	.activate_mm =3D (void *)native_nop,
+
 	.startup_ipi_hook =3D (void *)native_nop,
 };
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/mmu_context.h
+++ b/include/asm-i386/mmu_context.h
@@ -5,6 +5,7 @@
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/paravirt.h>
 =

 /*
  * Used for LDT copy/destruction.
@@ -65,7 +66,10 @@ static inline void switch_mm(struct mm_s
 #define deactivate_mm(tsk, mm)			\
 	asm("movl %0,%%fs": :"r" (0));
 =

-#define activate_mm(prev, next) \
-	switch_mm((prev),(next),NULL)
+#define activate_mm(prev, next)				\
+	do {						\
+		arch_activate_mm(prev, next);		\
+		switch_mm((prev),(next),NULL);		\
+	} while(0);
 =

 #endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -126,6 +126,12 @@ struct paravirt_ops
 	void (fastcall *io_delay)(void);
 	void (*const_udelay)(unsigned long loops);
 =

+	void (fastcall *activate_mm)(struct mm_struct *prev,
+				     struct mm_struct *next);
+	void (fastcall *dup_mmap)(struct mm_struct *oldmm, =

+				  struct mm_struct *mm);
+	void (fastcall *exit_mmap)(struct mm_struct *mm);
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	void (fastcall *apic_write)(unsigned long reg, unsigned long v);
 	void (fastcall *apic_write_atomic)(unsigned long reg, unsigned long v);
@@ -429,6 +435,24 @@ static inline void paravirt_pagetable_se
 		(*paravirt_ops.pagetable_setup_done)(base);
 }
 =

+#define __HAVE_ARCH_MM_LIFETIME
+static inline void arch_activate_mm(struct mm_struct *prev,
+				    struct mm_struct *next)
+{
+	paravirt_ops.activate_mm(prev, next);
+}
+
+static inline void arch_dup_mmap(struct mm_struct *oldmm,
+				 struct mm_struct *mm)
+{
+	paravirt_ops.dup_mmap(oldmm, mm);
+}
+
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+	paravirt_ops.exit_mmap(mm);
+}
+
 #define __flush_tlb() paravirt_ops.flush_tlb_user()
 #define __flush_tlb_global() paravirt_ops.flush_tlb_kernel()
 #define __flush_tlb_single(addr) paravirt_ops.flush_tlb_single(addr)
@@ -673,5 +697,20 @@ static inline void paravirt_pagetable_se
 	set_pgd(&base[0], base[USER_PTRS_PER_PGD]);
 #endif
 }
+
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+}
+
+static inline void paravirt_dup_mmap(struct mm_struct *oldmm,
+				     struct mm_struct *mm)
+{
+}
+
+static inline void paravirt_exit_mmap(struct mm_struct *mm)
+{
+}
+
 #endif /* CONFIG_PARAVIRT */
 #endif	/* __ASM_PARAVIRT_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -374,6 +374,12 @@ struct mm_struct {
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
 };
+
+#ifndef __HAVE_ARCH_MM_LIFETIME
+#define arch_activate_mm(prev, next)	do {} while(0)
+#define arch_dup_mmap(oldmm, mm)	do {} while(0)
+#define arch_exit_mmap(mm)		do {} while(0)
+#endif
 =

 struct sighand_struct {
 	atomic_t		count;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -286,6 +286,7 @@ static inline int dup_mmap(struct mm_str
 		if (retval)
 			goto out;
 	}
+	arch_dup_mmap(oldmm, mm);
 	retval =3D 0;
 out:
 	up_write(&mm->mmap_sem);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1976,6 +1976,8 @@ void exit_mmap(struct mm_struct *mm)
 	struct vm_area_struct *vma =3D mm->mmap;
 	unsigned long nr_accounted =3D 0;
 	unsigned long end;
+
+	arch_exit_mmap(mm);
 =

 	lru_add_drain();
 	flush_cache_mm(mm);

-- =
