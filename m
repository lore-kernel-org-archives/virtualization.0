From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 2/6] Allow percpu variables to be page-aligned
Date: Fri, 30 Mar 2007 19:00:44 -0700
Message-ID: <20070331020054.806023902@goop.org>
References: <20070331020042.003398870@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=allow-per-cpu-variables-to-be-page-aligned.patch
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Let's allow page-alignment in general for per-cpu data (wanted by Xen, and
Ingo suggested KVM as well).

Because larger alignments can use more room, we increase the max per-cpu
memory to 64k rather than 32k: it's getting a little tight.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Acked-by: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/alpha/kernel/vmlinux.lds.S   |    2 +-
 arch/arm/kernel/vmlinux.lds.S     |    2 +-
 arch/cris/arch-v32/vmlinux.lds.S  |    1 +
 arch/frv/kernel/vmlinux.lds.S     |    1 +
 arch/i386/kernel/vmlinux.lds.S    |    2 +-
 arch/m32r/kernel/vmlinux.lds.S    |    2 +-
 arch/mips/kernel/vmlinux.lds.S    |    2 +-
 arch/parisc/kernel/vmlinux.lds.S  |    2 +-
 arch/powerpc/kernel/setup_64.c    |    4 ++--
 arch/powerpc/kernel/vmlinux.lds.S |    6 +-----
 arch/ppc/kernel/vmlinux.lds.S     |    2 +-
 arch/s390/kernel/vmlinux.lds.S    |    2 +-
 arch/sh/kernel/vmlinux.lds.S      |    2 +-
 arch/sh64/kernel/vmlinux.lds.S    |    2 +-
 arch/sparc/kernel/vmlinux.lds.S   |    2 +-
 arch/sparc64/kernel/smp.c         |    6 +++---
 arch/x86_64/kernel/setup64.c      |    4 ++--
 arch/x86_64/kernel/vmlinux.lds.S  |    2 +-
 arch/xtensa/kernel/vmlinux.lds.S  |    2 +-
 init/main.c                       |    4 ++--
 kernel/module.c                   |    8 ++++----
 21 files changed, 29 insertions(+), 31 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -69,7 +69,7 @@ SECTIONS
   . =3D ALIGN(8);
   SECURITY_INIT
 =

-  . =3D ALIGN(64);
+  . =3D ALIGN(8192);
   __per_cpu_start =3D .;
   .data.percpu : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -59,7 +59,7 @@ SECTIONS
 			usr/built-in.o(.init.ramfs)
 		__initramfs_end =3D .;
 #endif
-		. =3D ALIGN(64);
+		. =3D ALIGN(4096);
 		__per_cpu_start =3D .;
 			*(.data.percpu)
 		__per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/cris/arch-v32/vmlinux.lds.S
+++ b/arch/cris/arch-v32/vmlinux.lds.S
@@ -91,6 +91,7 @@ SECTIONS
 	}
 	SECURITY_INIT
 =

+	. =3D  ALIGN (8192);
 	__per_cpu_start =3D .;
 	.data.percpu  : { *(.data.percpu) }
 	__per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/frv/kernel/vmlinux.lds.S
+++ b/arch/frv/kernel/vmlinux.lds.S
@@ -57,6 +57,7 @@ SECTIONS
   __alt_instructions_end =3D .;
  .altinstr_replacement : { *(.altinstr_replacement) }
 =

+  . =3D ALIGN(4096);
   __per_cpu_start =3D .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -194,7 +194,7 @@ SECTIONS
 	__initramfs_end =3D .;
   }
 #endif
-  . =3D ALIGN(L1_CACHE_BYTES);
+  . =3D ALIGN(4096);
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {
 	__per_cpu_start =3D .;
 	*(.data.percpu)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/m32r/kernel/vmlinux.lds.S
+++ b/arch/m32r/kernel/vmlinux.lds.S
@@ -110,7 +110,7 @@ SECTIONS
   __initramfs_end =3D .;
 #endif
 =

-  . =3D ALIGN(32);
+  . =3D ALIGN(4096);
   __per_cpu_start =3D .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -119,7 +119,7 @@ SECTIONS
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end =3D .;
 #endif
-  . =3D ALIGN(32);
+  . =3D ALIGN(_PAGE_SIZE);
   __per_cpu_start =3D .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -181,7 +181,7 @@ SECTIONS
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end =3D .;
 #endif
-  . =3D ALIGN(32);
+  . =3D ALIGN(ASM_PAGE_SIZE);
   __per_cpu_start =3D .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -583,14 +583,14 @@ void __init setup_per_cpu_areas(void)
 	char *ptr;
 =

 	/* Copy section for each CPU (we discard the original) */
-	size =3D ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
+	size =3D ALIGN(__per_cpu_end - __per_cpu_start, PAGE_SIZE);
 #ifdef CONFIG_MODULES
 	if (size < PERCPU_ENOUGH_ROOM)
 		size =3D PERCPU_ENOUGH_ROOM;
 #endif
 =

 	for_each_possible_cpu(i) {
-		ptr =3D alloc_bootmem_node(NODE_DATA(cpu_to_node(i)), size);
+		ptr =3D alloc_bootmem_pages_node(NODE_DATA(cpu_to_node(i)), size);
 		if (!ptr)
 			panic("Cannot allocate cpu data for CPU %d\n", i);
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -139,11 +139,7 @@ SECTIONS
 		__initramfs_end =3D .;
 	}
 #endif
-#ifdef CONFIG_PPC32
-	. =3D ALIGN(32);
-#else
-	. =3D ALIGN(128);
-#endif
+	. =3D ALIGN(PAGE_SIZE);
 	.data.percpu : {
 		__per_cpu_start =3D .;
 		*(.data.percpu)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/ppc/kernel/vmlinux.lds.S
+++ b/arch/ppc/kernel/vmlinux.lds.S
@@ -130,7 +130,7 @@ SECTIONS
   __ftr_fixup : { *(__ftr_fixup) }
   __stop___ftr_fixup =3D .;
 =

-  . =3D ALIGN(32);
+  . =3D ALIGN(4096);
   __per_cpu_start =3D .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -99,7 +99,7 @@ SECTIONS
   . =3D ALIGN(2);
   __initramfs_end =3D .;
 #endif
-  . =3D ALIGN(256);
+  . =3D ALIGN(4096);
   __per_cpu_start =3D .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -54,7 +54,7 @@ SECTIONS
   . =3D ALIGN(PAGE_SIZE);
   .data.page_aligned : { *(.data.page_aligned) }
 =

-  . =3D ALIGN(L1_CACHE_BYTES);
+  . =3D ALIGN(PAGE_SIZE);
   __per_cpu_start =3D .;
   .data.percpu : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/sh64/kernel/vmlinux.lds.S
+++ b/arch/sh64/kernel/vmlinux.lds.S
@@ -85,7 +85,7 @@ SECTIONS
   . =3D ALIGN(PAGE_SIZE);
   .data.page_aligned : C_PHYS(.data.page_aligned) { *(.data.page_aligned) }
 =

-  . =3D ALIGN(L1_CACHE_BYTES);
+  . =3D ALIGN(PAGE_SIZE);
   __per_cpu_start =3D .;
   .data.percpu : C_PHYS(.data.percpu) { *(.data.percpu) }
   __per_cpu_end =3D . ;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -65,7 +65,7 @@ SECTIONS
   __initramfs_end =3D .;
 #endif
 =

-  . =3D ALIGN(32);
+  . =3D ALIGN(4096);
   __per_cpu_start =3D .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -1449,11 +1449,11 @@ void __init setup_per_cpu_areas(void)
 	/* Copy section for each CPU (we discard the original) */
 	goal =3D PERCPU_ENOUGH_ROOM;
 =

-	__per_cpu_shift =3D 0;
-	for (size =3D 1UL; size < goal; size <<=3D 1UL)
+	__per_cpu_shift =3D PAGE_SHIFT;
+	for (size =3D PAGE_SIZE; size < goal; size <<=3D 1UL)
 		__per_cpu_shift++;
 =

-	ptr =3D alloc_bootmem(size * NR_CPUS);
+	ptr =3D alloc_bootmem_pages(size * NR_CPUS);
 =

 	__per_cpu_base =3D ptr - __per_cpu_start;
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86_64/kernel/setup64.c
+++ b/arch/x86_64/kernel/setup64.c
@@ -103,9 +103,9 @@ void __init setup_per_cpu_areas(void)
 		if (!NODE_DATA(cpu_to_node(i))) {
 			printk("cpu with no node %d, num_online_nodes %d\n",
 			       i, num_online_nodes());
-			ptr =3D alloc_bootmem(size);
+			ptr =3D alloc_bootmem_pages(size);
 		} else { =

-			ptr =3D alloc_bootmem_node(NODE_DATA(cpu_to_node(i)), size);
+			ptr =3D alloc_bootmem_pages_node(NODE_DATA(cpu_to_node(i)), size);
 		}
 		if (!ptr)
 			panic("Cannot allocate cpu data for CPU %d\n", i);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -194,7 +194,7 @@ SECTIONS
   __initramfs_end =3D .;
 #endif
 =

-    . =3D ALIGN(CONFIG_X86_L1_CACHE_BYTES);
+  . =3D ALIGN(4096);
   __per_cpu_start =3D .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -198,7 +198,7 @@ SECTIONS
   __ftr_fixup : { *(__ftr_fixup) }
   __stop___ftr_fixup =3D .;
 =

-  . =3D ALIGN(32);
+  . =3D ALIGN(4096);
   __per_cpu_start =3D .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end =3D .;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/init/main.c
+++ b/init/main.c
@@ -370,8 +370,8 @@ static void __init setup_per_cpu_areas(v
 =

 	/* Copy section for each CPU (we discard the original) */
 =

-	size =3D ALIGN(PERCPU_ENOUGH_ROOM, SMP_CACHE_BYTES);
-	ptr =3D alloc_bootmem(size * nr_possible_cpus);
+	size =3D ALIGN(PERCPU_ENOUGH_ROOM, PAGE_SIZE);
+	ptr =3D alloc_bootmem_pages(size * nr_possible_cpus);
 =

 	for_each_possible_cpu(i) {
 		__per_cpu_offset[i] =3D ptr - __per_cpu_start;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -346,10 +346,10 @@ static void *percpu_modalloc(unsigned lo
 	unsigned int i;
 	void *ptr;
 =

-	if (align > SMP_CACHE_BYTES) {
-		printk(KERN_WARNING "%s: per-cpu alignment %li > %i\n",
-		       name, align, SMP_CACHE_BYTES);
-		align =3D SMP_CACHE_BYTES;
+	if (align > PAGE_SIZE) {
+		printk(KERN_WARNING "%s: per-cpu alignment %li > %li\n",
+		       name, align, PAGE_SIZE);
+		align =3D PAGE_SIZE;
 	}
 =

 	ptr =3D __per_cpu_start;

-- =
