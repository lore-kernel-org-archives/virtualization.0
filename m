From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 69/75] x86/head/64: Setup TSS early for secondary CPUs
Date: Tue, 14 Jul 2020 14:09:11 +0200
Message-ID: <20200714120917.11253-70-joro@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

The #VC exception will trigger very early in head_64.S, when the first
CPUID instruction is executed. When secondary CPUs boot, they already
load the real system IDT, which has the #VC handler configured to use an
IST stack. IST stacks require a TSS to be loaded, so set up the TSS
early for bringing up the secondary CPUs. Use the read-write version of
the per-CPU TSS struct early, until cpu_init() switches to the read-only
mapping.

On the boot CPU the TSS will also be loaded early, but not used as the
the early boot #VC handlers do not use IST stacks.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/head64.c  | 13 +++++++++++++
 arch/x86/kernel/head_64.S |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 23d492091f3b..f57eefb1e4ba 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -545,6 +545,19 @@ void __head early_idt_setup_early_handler(unsigned long descr_addr, unsigned lon
 	}
 }
 
+void __head early_load_tss(void)
+{
+	struct desc_struct *gdt = (struct desc_struct *)boot_gdt;
+	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	tss_desc tss_desc;
+
+	set_tssldt_descriptor(&tss_desc, (unsigned long)tss, DESC_TSS,
+			      __KERNEL_TSS_LIMIT);
+	native_write_gdt_entry(gdt, GDT_ENTRY_TSS, &tss_desc, DESC_TSS);
+
+	asm volatile("ltr %w0"::"q" (GDT_ENTRY_TSS*8));
+}
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 static void __head set_early_idt_handler(gate_desc *idt, int n, void *handler)
 {
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3bd4c36d1d36..5b577d6bce7a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -235,6 +235,11 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	movq initial_stack(%rip), %rsp
 
+	/* Setup a TSS for early IST handlers - needs %gs to be set up */
+	pushq	%rsi
+	call	early_load_tss
+	popq	%rsi
+
 	/* Load IDT */
 	lidt	idt_descr(%rip)
 
-- 
2.27.0
