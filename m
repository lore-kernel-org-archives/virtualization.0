From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 34/70] x86/head/64: Load IDT earlier
Date: Thu, 19 Mar 2020 10:13:31 +0100
Message-ID: <20200319091407.1481-35-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Load the IDT right after switching to virtual addresses in head_64.S
so that the kernel can handle #VC exceptions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/head64.c  | 15 +++++++++++++++
 arch/x86/kernel/head_64.S | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 206a4b6144c2..0ecdf28291fc 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -489,3 +489,18 @@ void __init x86_64_start_reservations(char *real_mode_data)
 
 	start_kernel();
 }
+
+void __head early_idt_setup_early_handler(unsigned long physaddr)
+{
+	gate_desc *idt = fixup_pointer(idt_table, physaddr);
+	int i;
+
+	for (i = 0; i < NUM_EXCEPTION_VECTORS; i++) {
+		struct idt_data data;
+		gate_desc desc;
+
+		init_idt_data(&data, i, early_idt_handler_array[i]);
+		idt_init_desc(&desc, &data);
+		native_write_idt_entry(idt, i, &desc);
+	}
+}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index b8ba72f31be9..8465290a1eb3 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -104,6 +104,20 @@ SYM_CODE_START_NOALIGN(startup_64)
 	leaq	_text(%rip), %rdi
 	pushq	%rsi
 	call	__startup_64
+	/* Save return value */
+	pushq	%rax
+
+	/*
+	 * Load IDT with early handlers - needed for SEV-ES
+	 * Do this here because this must only happen on the boot CPU
+	 * and the code below is shared with secondary CPU bringup.
+	 */
+	leaq	_text(%rip), %rdi
+	call	early_idt_setup_early_handler
+
+	/* Restore __startup_64 return value*/
+	popq	%rax
+	/* Restore pointer to real_mode_data */
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
@@ -200,6 +214,9 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	movq initial_stack(%rip), %rsp
 
+	/* Load IDT */
+	lidt	idt_descr(%rip)
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
-- 
2.17.1
