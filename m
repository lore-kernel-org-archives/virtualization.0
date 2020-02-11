From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 54/62] x86/kvm: Add KVM specific VMMCALL handling under SEV-ES
Date: Tue, 11 Feb 2020 14:52:48 +0100
Message-ID: <20200211135256.24617-55-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Implement the callbacks to copy the processor state required by KVM to
the GHCB.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Split out of a larger patch
                   - Adapt to different callback functions ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/kvm.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d817f255aed8..318eb906a0b5 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -34,6 +34,8 @@
 #include <asm/hypervisor.h>
 #include <asm/tlb.h>
 #include <asm/cpuidle_haltpoll.h>
+#include <asm/ptrace.h>
+#include <asm/svm.h>
 
 static int kvmapf = 1;
 
@@ -711,13 +713,34 @@ static void __init kvm_init_platform(void)
 	x86_platform.apic_post_init = kvm_apic_init;
 }
 
+#if defined(CONFIG_AMD_MEM_ENCRYPT)
+static void kvm_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	/* RAX and CPL are already in the GHCB */
+	ghcb_set_rbx(ghcb, regs->bx);
+	ghcb_set_rcx(ghcb, regs->cx);
+	ghcb_set_rdx(ghcb, regs->dx);
+	ghcb_set_rsi(ghcb, regs->si);
+}
+
+static bool kvm_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	/* No checking of the return state needed */
+	return true;
+}
+#endif
+
 const __initconst struct hypervisor_x86 x86_hyper_kvm = {
-	.name			= "KVM",
-	.detect			= kvm_detect,
-	.type			= X86_HYPER_KVM,
-	.init.guest_late_init	= kvm_guest_init,
-	.init.x2apic_available	= kvm_para_available,
-	.init.init_platform	= kvm_init_platform,
+	.name				= "KVM",
+	.detect				= kvm_detect,
+	.type				= X86_HYPER_KVM,
+	.init.guest_late_init		= kvm_guest_init,
+	.init.x2apic_available		= kvm_para_available,
+	.init.init_platform		= kvm_init_platform,
+#if defined(CONFIG_AMD_MEM_ENCRYPT)
+	.runtime.sev_es_hcall_prepare	= kvm_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish	= kvm_sev_es_hcall_finish,
+#endif
 };
 
 static __init int activate_jump_labels(void)
-- 
2.17.1
