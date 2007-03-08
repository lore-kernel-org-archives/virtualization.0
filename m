From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 11/17] paravirt_ops - asm-offset updates
Date: Thu, 08 Mar 2007 01:02:25 -0500
Message-ID: <1173333745.25848.12.camel@localhost.localdomain>
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

plain text document attachment (xx-paravirt-asm-offsets.patch)
Add offsets for use of paravirt-ops in assembly.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: work-nopv/arch/x86_64/kernel/asm-offsets.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-nopv.orig/arch/x86_64/kernel/asm-offsets.c
+++ work-nopv/arch/x86_64/kernel/asm-offsets.c
@@ -15,6 +15,9 @@
 #include <asm/segment.h>
 #include <asm/thread_info.h>
 #include <asm/ia32.h>
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
 =

 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -71,5 +74,17 @@ int main(void)
 	DEFINE(TSS_ist, offsetof(struct tss_struct, ist));
 	BLANK();
 	DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
+
+#ifdef CONFIG_PARAVIRT
+#define ENTRY(entry) DEFINE(PARAVIRT_ ## entry, offsetof(struct paravirt_o=
ps, entry))
+	BLANK();
+	ENTRY(paravirt_enabled);
+	ENTRY(irq_disable);
+	ENTRY(irq_enable);
+	ENTRY(sysret);
+	ENTRY(iret);
+	ENTRY(read_cr2);
+	ENTRY(swapgs);
+#endif
 	return 0;
 }

--
