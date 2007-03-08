From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 06/17] paravirt_op - miscellaneous updates.
Date: Thu, 08 Mar 2007 01:02:12 -0500
Message-ID: <1173333732.25848.7.camel@localhost.localdomain>
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

plain text document attachment (xx-paravirt-misc-headers.patch)
Miscellaneous header updates.  Sort of a work-in-progress.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: clean-start/include/asm-x86_64/proto.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/proto.h
+++ clean-start/include/asm-x86_64/proto.h
@@ -27,7 +27,11 @@ extern void init_memory_mapping(unsigned
 =

 extern void system_call(void); =

 extern int kernel_syscall(void);
+#ifdef CONFIG_PARAVIRT
+extern void x86_64_syscall_init(void);
+#else
 extern void syscall_init(void);
+#endif
 =

 extern void ia32_syscall(void);
 extern void ia32_cstar_target(void); =

Index: clean-start/include/asm-x86_64/spinlock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/spinlock.h
+++ clean-start/include/asm-x86_64/spinlock.h
@@ -6,6 +6,10 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
+
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  *

--
