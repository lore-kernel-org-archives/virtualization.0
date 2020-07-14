From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 31/75] x86/head/64: Reload GDT after switch to virtual addresses
Date: Tue, 14 Jul 2020 14:08:33 +0200
Message-ID: <20200714120917.11253-32-joro@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: x86@kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Reload the GDT after switching to virtual addresses to make sure it will
not go away when the lower mappings are removed. This will also reload
the GDT for booting APs, which will need a working GDT too to handle #VC
exceptions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/head_64.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 473e60a12e2f..87ea9f540608 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -164,6 +164,11 @@ SYM_CODE_START(secondary_startup_64)
 1:
 	UNWIND_HINT_EMPTY
 
+	/* Setup boot GDT descriptor and load boot GDT */
+	leaq	boot_gdt(%rip), %rax
+	movq	%rax, boot_gdt_descr+2(%rip)
+	lgdt	boot_gdt_descr(%rip)
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
-- 
2.27.0
