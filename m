From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 7/7] (Optional) implement current as a per-cpu var
Date: Mon, 25 Sep 2006 15:29:00 +1000
Message-ID: <1159162141.26986.46.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	<1158925997.26261.6.camel@localhost.localdomain>
	<1158926106.26261.8.camel@localhost.localdomain>
	<1158926215.26261.11.camel@localhost.localdomain>
	<1158926308.26261.14.camel@localhost.localdomain>
	<1158926386.26261.17.camel@localhost.localdomain>
	<1158926451.26261.18.camel@localhost.localdomain>
	<1158926502.26261.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1158926502.26261.20.camel@localhost.localdomain>
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
Cc: virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-22 at 22:01 +1000, Rusty Russell wrote:
> This implements current as a per-cpu variable.

Again, revised for updated 5/7: we no longer need to avoid using current
early on.

This implements current as a per-cpu variable.  The generic code
expects it in thread_info still, so I don't remove it from there, but
reducing current from 9 bytes/3 insns to 6 bytes/1 insn is a nice
micro-optimization.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Index: ak-fresh/arch/i386/kernel/setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ak-fresh.orig/arch/i386/kernel/setup.c	2006-09-25 15:02:33.000000000 +1=
000
+++ ak-fresh/arch/i386/kernel/setup.c	2006-09-25 15:06:31.000000000 +1000
@@ -148,6 +148,9 @@
 =

 unsigned char __initdata boot_params[PARAM_SIZE];
 =

+DEFINE_PER_CPU(struct task_struct *, current_task) =3D &init_task;
+EXPORT_PER_CPU_SYMBOL(current_task);
+
 static struct resource data_resource =3D {
 	.name	=3D "Kernel data",
 	.start	=3D 0,
Index: ak-fresh/arch/i386/kernel/smpboot.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ak-fresh.orig/arch/i386/kernel/smpboot.c	2006-09-25 15:02:51.000000000 =
+1000
+++ ak-fresh/arch/i386/kernel/smpboot.c	2006-09-25 15:06:31.000000000 +1000
@@ -972,6 +972,7 @@
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 	idle->thread.eip =3D (unsigned long) start_secondary;
+	per_cpu(current_task, cpu) =3D idle;
 =

  	setup_percpu(cpu);
  	booting_cpu_gdt_desc_ptr =3D &per_cpu(cpu_gdt_descr, cpu);
Index: ak-fresh/include/asm-i386/current.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ak-fresh.orig/include/asm-i386/current.h	2006-09-25 15:02:33.000000000 =
+1000
+++ ak-fresh/include/asm-i386/current.h	2006-09-25 15:06:31.000000000 +1000
@@ -1,15 +1,10 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 =

+#include <asm/percpu.h>
 #include <linux/thread_info.h>
 =

-struct task_struct;
-
-static __always_inline struct task_struct * get_current(void)
-{
-	return current_thread_info()->task;
-}
- =

-#define current get_current()
+DECLARE_PER_CPU(struct task_struct *, current_task);
+#define current x86_read_percpu(current_task)
 =

 #endif /* !(_I386_CURRENT_H) */
Index: ak-fresh/arch/i386/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ak-fresh.orig/arch/i386/kernel/process.c	2006-09-25 15:02:33.000000000 =
+1000
+++ ak-fresh/arch/i386/kernel/process.c	2006-09-25 15:06:31.000000000 +1000
@@ -669,6 +669,7 @@
 	if (unlikely(prev->fs | next->fs))
 		loadsegment(fs, next->fs);
 =

+	x86_write_percpu(current_task, next_p);
 =

 	/*
 	 * Restore IOPL if needed.

-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
