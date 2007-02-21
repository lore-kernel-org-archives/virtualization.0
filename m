From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 01/24] Xen-paravirt_ops: No need to use -traditional for
	processing asm in arch/i386/
Date: Wed, 21 Feb 2007 12:52:55 -0800
Message-ID: <20070221205322.382553458@goop.org>
References: <20070221205254.169835700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=untraditionalize-asm.patch
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -36,9 +36,9 @@ HOSTCFLAGS_build.o :=3D $(LINUXINCLUDE)
 # ------------------------------------------------------------------------=
---
 =

 $(obj)/zImage:  IMAGE_OFFSET :=3D 0x1000
-$(obj)/zImage:  EXTRA_AFLAGS :=3D -traditional $(SVGA_MODE) $(RAMDISK)
+$(obj)/zImage:  EXTRA_AFLAGS :=3D $(SVGA_MODE) $(RAMDISK)
 $(obj)/bzImage: IMAGE_OFFSET :=3D 0x100000
-$(obj)/bzImage: EXTRA_AFLAGS :=3D -traditional $(SVGA_MODE) $(RAMDISK) -D_=
_BIG_KERNEL__
+$(obj)/bzImage: EXTRA_AFLAGS :=3D $(SVGA_MODE) $(RAMDISK) -D__BIG_KERNEL__
 $(obj)/bzImage: BUILDFLAGS   :=3D -b
 =

 quiet_cmd_image =3D BUILD   $@
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/boot/compressed/Makefile
+++ b/arch/i386/boot/compressed/Makefile
@@ -6,7 +6,6 @@
 =

 targets		:=3D vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o \
 			vmlinux.bin.all vmlinux.relocs
-EXTRA_AFLAGS	:=3D -traditional
 =

 LDFLAGS_vmlinux :=3D -T
 CFLAGS_misc.o +=3D -fPIC
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -44,8 +44,6 @@ obj-$(CONFIG_PARAVIRT)		+=3D paravirt.o
 obj-$(CONFIG_PARAVIRT)		+=3D paravirt.o
 obj-y				+=3D pcspeaker.o
 =

-EXTRA_AFLAGS   :=3D -traditional
-
 obj-$(CONFIG_SCx200)		+=3D scx200.o
 =

 # vsyscall.o contains the vsyscall DSO images as __initdata.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -635,7 +635,7 @@ ENTRY(name)				\
 	SAVE_ALL;			\
 	TRACE_IRQS_OFF			\
 	movl %esp,%eax;			\
-	call smp_/**/name;		\
+	call smp_##name;		\
 	jmp ret_from_intr;		\
 	CFI_ENDPROC;			\
 ENDPROC(name)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/percpu.h
+++ b/include/asm-i386/percpu.h
@@ -20,10 +20,10 @@
 #ifdef CONFIG_SMP
 #define PER_CPU(var, cpu) \
 	movl __per_cpu_offset(,cpu,4), cpu;	\
-	addl $per_cpu__/**/var, cpu;
+	addl $per_cpu__##var, cpu;
 #else /* ! SMP */
 #define PER_CPU(var, cpu) \
-	movl $per_cpu__/**/var, cpu;
+	movl $per_cpu__##var, cpu;
 #endif	/* SMP */
 =

 #endif /* !__ASSEMBLY__ */

-- =
