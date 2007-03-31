From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 3/6] Page-align the GDT
Date: Fri, 30 Mar 2007 19:00:45 -0700
Message-ID: <20070331020054.990278862@goop.org>
References: <20070331020042.003398870@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=i386-gdt-cleanups-page-align-the-gdt.patch
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Xen wants a dedicated page for the GDT.  I believe VMI likes it too.
lguest, KVM and native don't care.

Simple transformation to page-aligned "struct gdt_page".

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/cpu/common.c |    6 +++---
 arch/i386/kernel/entry.S      |    2 +-
 arch/i386/kernel/head.S       |    2 +-
 arch/i386/kernel/traps.c      |    2 +-
 include/asm-i386/desc.h       |    9 +++++++--
 5 files changed, 13 insertions(+), 8 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -22,7 +22,7 @@
 =

 #include "cpu.h"
 =

-DEFINE_PER_CPU(struct desc_struct, cpu_gdt[GDT_ENTRIES]) =3D {
+DEFINE_PER_CPU(struct gdt_page, gdt_page) =3D { .gdt =3D {
 	[GDT_ENTRY_KERNEL_CS] =3D { 0x0000ffff, 0x00cf9a00 },
 	[GDT_ENTRY_KERNEL_DS] =3D { 0x0000ffff, 0x00cf9200 },
 	[GDT_ENTRY_DEFAULT_USER_CS] =3D { 0x0000ffff, 0x00cffa00 },
@@ -48,8 +48,8 @@ DEFINE_PER_CPU(struct desc_struct, cpu_g
 =

 	[GDT_ENTRY_ESPFIX_SS] =3D { 0x00000000, 0x00c09200 },
 	[GDT_ENTRY_PDA] =3D { 0x00000000, 0x00c09200 }, /* set in setup_pda */
-};
-EXPORT_PER_CPU_SYMBOL_GPL(cpu_gdt);
+} };
+EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
 =

 DEFINE_PER_CPU(struct i386_pda, _cpu_pda) =3D {
 	._pda =3D &per_cpu___cpu_pda,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -558,7 +558,7 @@ END(syscall_badsys)
 #define FIXUP_ESPFIX_STACK \
 	/* since we are on a wrong stack, we cant make it a C code :( */ \
 	movl %fs:PDA_cpu, %ebx; \
-	PER_CPU(cpu_gdt, %ebx); \
+	PER_CPU(gdt_page, %ebx); \
 	GET_DESC_BASE(GDT_ENTRY_ESPFIX_SS, %ebx, %eax, %ax, %al, %ah); \
 	addl %esp, %eax; \
 	pushl $__KERNEL_DS; \
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -599,7 +599,7 @@ idt_descr:
 	.word 0				# 32 bit align gdt_desc.address
 ENTRY(early_gdt_descr)
 	.word GDT_ENTRIES*8-1
-	.long per_cpu__cpu_gdt		/* Overwritten for secondary CPUs */
+	.long per_cpu__gdt_page		/* Overwritten for secondary CPUs */
 =

 /*
  * The boot_gdt_table must mirror the equivalent in setup.S and is
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -1037,7 +1037,7 @@ fastcall unsigned long patch_espfix_desc
 fastcall unsigned long patch_espfix_desc(unsigned long uesp,
 					  unsigned long kesp)
 {
-	struct desc_struct *gdt =3D __get_cpu_var(cpu_gdt);
+	struct desc_struct *gdt =3D __get_cpu_var(gdt_page).gdt;
 	unsigned long base =3D (kesp - uesp) & -THREAD_SIZE;
 	unsigned long new_kesp =3D kesp - base;
 	unsigned long lim_pages =3D (new_kesp | (THREAD_SIZE - 1)) >> PAGE_SHIFT;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/desc.h
+++ b/include/asm-i386/desc.h
@@ -18,10 +18,15 @@ struct Xgt_desc_struct {
 	unsigned short pad;
 } __attribute__ ((packed));
 =

-DECLARE_PER_CPU(struct desc_struct, cpu_gdt[GDT_ENTRIES]);
+struct gdt_page
+{
+	struct desc_struct gdt[GDT_ENTRIES];
+} __attribute__((aligned(PAGE_SIZE)));
+DECLARE_PER_CPU(struct gdt_page, gdt_page);
+
 static inline struct desc_struct *get_cpu_gdt_table(unsigned int cpu)
 {
-	return per_cpu(cpu_gdt, cpu);
+	return per_cpu(gdt_page, cpu).gdt;
 }
 =

 extern struct Xgt_desc_struct idt_descr;

-- =
