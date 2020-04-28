From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 70/75] x86/head/64: Setup TSS early for secondary CPUs
Date: Tue, 28 Apr 2020 17:17:20 +0200
Message-ID: <20200428151725.31091-71-joro@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200428151725.31091-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

The #VC exception will trigger very early in head_64.S, when the first
CPUID instruction is executed. When secondary CPUs boot, they already
load the real system IDT, which has the #VC handler configured to be
using an IST stack. IST stacks require a TSS to be loaded, to set up the
TSS early for bringing up the secondary CPUs. Use the RW version of
early, until cpu_init() switches to the RO mapping.

On the boot CPU the TSS will also be loaded early, but not used as the
the early #VC handlers do not use IST stacks.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/desc.h |  2 ++
 arch/x86/kernel/head64.c    | 13 +++++++++++++
 arch/x86/kernel/head_64.S   |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 30e2a0e863b6..0777b100dc63 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -40,6 +40,8 @@ static inline void fill_ldt(struct desc_struct *desc, const struct user_desc *in
 	desc->l			= 0;
 }
 
+extern unsigned char boot_gdt[];
+
 extern struct desc_ptr idt_descr;
 extern gate_desc idt_table[];
 extern const struct desc_ptr debug_idt_descr;
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index d83d59c15548..30a6d09fd9d0 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -523,6 +523,19 @@ void __head early_idt_setup_early_handler(unsigned long physaddr)
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
 void __head early_idt_setup(unsigned long physbase)
 {
 	gate_desc *idt = fixup_pointer(idt_table, physbase);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 4d84a0c72e36..7f2d5e14db73 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -220,6 +220,9 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	movq initial_stack(%rip), %rsp
 
+	/* Setup a TSS for early IST handlers - needs %gs to be set up */
+	call	early_load_tss
+
 	/* Load IDT */
 	lidt	idt_descr(%rip)
 
-- 
2.17.1
