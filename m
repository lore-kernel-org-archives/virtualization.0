From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 16/17] paravirt_ops - touch ups
Date: Thu, 08 Mar 2007 01:02:38 -0500
Message-ID: <1173333758.25848.17.camel@localhost.localdomain>
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

plain text document attachment (xx-paravirt-touchups.patch)
Some miscellaneous clean ups.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: clean-start/arch/x86_64/ia32/syscall32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/ia32/syscall32.c
+++ clean-start/arch/x86_64/ia32/syscall32.c
@@ -119,5 +119,5 @@ void syscall32_cpu_init(void)
 	checking_wrmsrl(MSR_IA32_SYSENTER_ESP, 0ULL);
 	checking_wrmsrl(MSR_IA32_SYSENTER_EIP, (u64)ia32_sysenter_target);
 =

-	wrmsrl(MSR_CSTAR, ia32_cstar_target);
+	wrmsrl(MSR_CSTAR, (u64)ia32_cstar_target);
 }
Index: clean-start/arch/x86_64/mm/pageattr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/mm/pageattr.c
+++ clean-start/arch/x86_64/mm/pageattr.c
@@ -81,7 +81,7 @@ static void flush_kernel_map(void *arg)
 		void *adr =3D page_address(pg);
 		if (cpu_has_clflush)
 			cache_flush_page(adr);
-		__flush_tlb_one(adr);
+		__flush_tlb_one((u64)adr);
 	}
 }
 =

Index: clean-start/include/linux/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/linux/irqflags.h
+++ clean-start/include/linux/irqflags.h
@@ -74,11 +74,11 @@
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 =

 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-static inline void safe_halt(void)
-{
-	trace_hardirqs_on();
-	raw_safe_halt();
-}
+#define safe_halt()						\
+	do {							\
+		trace_hardirqs_on();				\
+		raw_safe_halt();				\
+	} while (0)
 =

 #define local_save_flags(flags)		raw_local_save_flags(flags)
 =


--
