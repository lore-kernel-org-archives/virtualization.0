From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 05/13] asm-offsets update
Date: Thu, 08 Mar 2007 12:38:53 -0500
Message-ID: <1173375533.32170.7.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (lguest64-asm-offset.patch)
This patch puts in the offsets used by Lguest64 in assembly.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>


Index: work-pv/arch/x86_64/kernel/asm-offsets.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/arch/x86_64/kernel/asm-offsets.c
+++ work-pv/arch/x86_64/kernel/asm-offsets.c
@@ -18,6 +18,9 @@
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #endif
+#ifdef CONFIG_LGUEST_GUEST
+#include <asm/lguest.h>
+#endif
 =

 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -89,5 +92,51 @@ int main(void)
 	ENTRY(read_cr2);
 	ENTRY(swapgs);
 #endif
+
+#ifdef CONFIG_LGUEST_GUEST
+#undef ENTRY
+#define ENTRY(entry)  DEFINE(LGUEST_VCPU_ ##entry, offsetof(struct lguest_=
vcpu, entry))
+	ENTRY(vcpu);
+	ENTRY(debug);
+	ENTRY(magic);
+	ENTRY(guest_syscall);
+	ENTRY(host_stack);
+	ENTRY(host_cr3);
+	ENTRY(host_gs_a);
+	ENTRY(host_gs_d);
+	ENTRY(host_proc_gs_a);
+	ENTRY(host_proc_gs_d);
+	ENTRY(guest_gs_a);
+	ENTRY(guest_gs_d);
+	ENTRY(gdt);
+	ENTRY(idt);
+	ENTRY(host_gdt);
+	ENTRY(host_idt);
+	ENTRY(host_gdt_ptr);
+	ENTRY(gdt_table);
+	DEFINE(LGUEST_VCPU_trapnum, offsetof(struct lguest_vcpu, regs.trapnum));
+	DEFINE(LGUEST_VCPU_errcode, offsetof(struct lguest_vcpu, regs.errcode));
+	DEFINE(LGUEST_VCPU_rflags, offsetof(struct lguest_vcpu, regs.rflags));
+	DEFINE(LGUEST_VCPU_host_idt_address, offsetof(struct lguest_vcpu, host_id=
t.address));
+	ENTRY(regs);
+	ENTRY(nmi_regs);
+	DEFINE(LGUEST_VCPU_errcode, offsetof(struct lguest_vcpu, regs.errcode));
+	ENTRY(nmi_gs_a);
+	ENTRY(nmi_gs_d);
+	ENTRY(nmi_gs_shadow_a);
+	ENTRY(nmi_gs_shadow_d);
+	ENTRY(nmi_stack_end);
+	ENTRY(nmi_gdt);
+	ENTRY(nmi_sw);
+#undef ENTRY
+#define ENTRY(entry)  DEFINE(LGUEST_DATA_##entry, offsetof(struct lguest_d=
ata, entry))
+	ENTRY(irq_enabled);
+#undef ENTRY
+#define ENTRY(entry)  DEFINE(LGUEST_REGS_##entry, offsetof(struct lguest_r=
egs, entry))
+	ENTRY(errcode);
+	ENTRY(rip);
+	ENTRY(size);
+	BLANK();
+#endif
 	return 0;
 }

--
