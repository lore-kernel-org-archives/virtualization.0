From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 55/62] x86/vmware: Add VMware specific handling for VMMCALL under SEV-ES
Date: Tue, 11 Feb 2020 14:52:49 +0100
Message-ID: <20200211135256.24617-56-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, Doug Covelli <dcovelli@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Doug Covelli <dcovelli@vmware.com>

This change adds VMware specific handling for #VC faults caused by
VMMCALL instructions.

Signed-off-by: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Adapt to different paravirt interface ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/cpu/vmware.c | 48 ++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 46d732696c1c..7edab8fcf8bf 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -31,6 +31,7 @@
 #include <asm/timer.h>
 #include <asm/apic.h>
 #include <asm/vmware.h>
+#include <asm/svm.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -263,10 +264,47 @@ static bool __init vmware_legacy_x2apic_available(void)
 	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
+					struct pt_regs *regs)
+{
+	/* Copy VMWARE specific Hypercall parameters to the GHCB */
+	ghcb_set_rip(ghcb, regs->ip);
+	ghcb_set_rbx(ghcb, regs->bx);
+	ghcb_set_rcx(ghcb, regs->cx);
+	ghcb_set_rdx(ghcb, regs->dx);
+	ghcb_set_rsi(ghcb, regs->si);
+	ghcb_set_rdi(ghcb, regs->di);
+	ghcb_set_rbp(ghcb, regs->bp);
+}
+
+static bool vmware_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	if (!(ghcb_is_valid_rbx(ghcb) &&
+	      ghcb_is_valid_rcx(ghcb) &&
+	      ghcb_is_valid_rdx(ghcb) &&
+	      ghcb_is_valid_rsi(ghcb) &&
+	      ghcb_is_valid_rdi(ghcb) &&
+	      ghcb_is_valid_rbp(ghcb)))
+		return false;
+
+	regs->bx = ghcb->save.rbx;
+	regs->cx = ghcb->save.rcx;
+	regs->dx = ghcb->save.rdx;
+	regs->si = ghcb->save.rsi;
+	regs->di = ghcb->save.rdi;
+	regs->bp = ghcb->save.rbp;
+
+	return true;
+}
+#endif
+
 const __initconst struct hypervisor_x86 x86_hyper_vmware = {
-	.name			= "VMware",
-	.detect			= vmware_platform,
-	.type			= X86_HYPER_VMWARE,
-	.init.init_platform	= vmware_platform_setup,
-	.init.x2apic_available	= vmware_legacy_x2apic_available,
+	.name				= "VMware",
+	.detect				= vmware_platform,
+	.type				= X86_HYPER_VMWARE,
+	.init.init_platform		= vmware_platform_setup,
+	.init.x2apic_available		= vmware_legacy_x2apic_available,
+	.runtime.sev_es_hcall_prepare	= vmware_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish	= vmware_sev_es_hcall_finish,
 };
-- 
2.17.1
