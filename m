From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 69/70] x86/cpufeature: Add SEV_ES_GUEST CPU Feature
Date: Thu, 19 Mar 2020 10:14:06 +0100
Message-ID: <20200319091407.1481-70-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

The feature bit will indicate whether the kernel runs as an SEV-ES
guest. This can be used to apply alternatives at boot for SEV-ES guests
and provides a way for user-space to detect whether it runs as an SEV-ES
guest.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/amd.c          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2fee1a2cac2f..35df826ee3fc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -235,6 +235,7 @@
 #define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 #define X86_FEATURE_SEV_ES		( 8*32+20) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_ES_GUEST	( 8*32+21) /* SEV-ES Guest */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 523a6a76c6c1..8cdb190822de 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -485,7 +485,6 @@ static void early_init_amd_mc(struct cpuinfo_x86 *c)
 
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
-
 #ifdef CONFIG_X86_64
 	if (c->x86 >= 0xf) {
 		unsigned long long tseg;
@@ -614,6 +613,11 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_SEV);
 		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
 	}
+
+	if (!rdmsrl_safe(MSR_AMD64_SEV, &msr)) {
+		if (msr & MSR_AMD64_SEV_ES_ENABLED)
+			set_cpu_cap(c, X86_FEATURE_SEV_ES_GUEST);
+	}
 }
 
 static void early_init_amd(struct cpuinfo_x86 *c)
-- 
2.17.1
