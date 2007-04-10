From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 7/10] Resurrect the VMI lazy mode fixes.
Date: Mon, 9 Apr 2007 17:06:21 -0700
Message-ID: <200704100006.l3A06LPO020632@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Subject: Resurrect the VMI lazy mode fixes.
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Code changes and cleanup in the paravirt-ops queue caused the original
fix for this in 2.6.21 to create conflicts.  The easiest thing to do was
back it out before applying the queue.  In that case, this fix brings it
back with the newly right properly tidied up paravirt-ops code.

Wheee!

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r ecb571084874 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Fri Apr 06 12:31:06 2007 -0700
+++ b/arch/i386/kernel/vmi.c	Fri Apr 06 14:25:03 2007 -0700
@@ -69,6 +69,7 @@ static struct {
 	void (*flush_tlb)(int);
 	void (*set_initial_ap_state)(int, int);
 	void (*halt)(void);
+  	void (*set_lazy_mode)(int mode);
 } vmi_ops;
 =

 /*
@@ -545,6 +546,26 @@ vmi_startup_ipi_hook(int phys_apicid, un
 }
 #endif
 =

+static void vmi_set_lazy_mode(enum paravirt_lazy_mode mode)
+{
+	static DEFINE_PER_CPU(int, lazy_mode);
+
+	if (!vmi_ops.set_lazy_mode)
+		return;
+
+	/* Modes should never nest or overlap */
+	BUG_ON(__get_cpu_var(lazy_mode) && !(mode =3D=3D PARAVIRT_LAZY_NONE ||
+					     mode =3D=3D PARAVIRT_LAZY_FLUSH));
+	=

+	if (mode =3D=3D PARAVIRT_LAZY_FLUSH) {
+		vmi_ops.set_lazy_mode(0);
+		vmi_ops.set_lazy_mode(__get_cpu_var(lazy_mode));
+	} else {
+		vmi_ops.set_lazy_mode(mode);
+		__get_cpu_var(lazy_mode) =3D mode;
+	}
+}
+
 static inline int __init check_vmi_rom(struct vrom_header *rom)
 {
 	struct pci_header *pci;
@@ -769,7 +790,7 @@ static inline int __init activate_vmi(vo
 	para_wrap(load_esp0, vmi_load_esp0, set_kernel_stack, UpdateKernelStack);
 	para_fill(set_iopl_mask, SetIOPLMask);
 	para_fill(io_delay, IODelay);
-	para_fill(set_lazy_mode, SetLazyMode);
+	para_wrap(set_lazy_mode, vmi_set_lazy_mode, set_lazy_mode, SetLazyMode);
 =

 	/* user and kernel flush are just handled with different flags to FlushTL=
B */
 	para_wrap(flush_tlb_user, vmi_flush_tlb_user, flush_tlb, FlushTLB);
