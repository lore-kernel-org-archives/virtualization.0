From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 35/75] x86/head/64: Load IDT earlier
Date: Tue, 14 Jul 2020 14:08:37 +0200
Message-ID: <20200714120917.11253-36-joro@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, virtualization@lists.linux-foundation.org, Martin Radev <martin.b.radev@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Load the IDT right after switching to virtual addresses in head_64.S
so that the kernel can handle #VC exceptions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/setup.h |  2 ++
 arch/x86/kernel/head64.c     | 18 ++++++++++++++++++
 arch/x86/kernel/head_64.S    | 28 ++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 84b645cc8bc9..19ccb1211004 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -39,6 +39,7 @@ void vsmp_init(void);
 static inline void vsmp_init(void) { }
 #endif
 
+
 void setup_bios_corruption_check(void);
 void early_platform_quirks(void);
 
@@ -49,6 +50,7 @@ extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
 extern unsigned long __startup_secondary_64(void);
 extern int early_make_pgtable(unsigned long address);
+extern void early_idt_setup_early_handler(unsigned long descr_addr, unsigned long physaddr);
 
 #ifdef CONFIG_X86_INTEL_MID
 extern void x86_intel_mid_early_setup(void);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 51059bfd4b99..3598c091ff24 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -508,3 +508,21 @@ void __init x86_64_start_reservations(char *real_mode_data)
 
 	start_kernel();
 }
+
+void __head early_idt_setup_early_handler(unsigned long descr_addr, unsigned long physaddr)
+{
+	struct desc_ptr *descr = (struct desc_ptr *)descr_addr;
+	gate_desc *idt = (gate_desc *)descr->address;
+	int i;
+
+	idt = fixup_pointer(idt, physaddr);
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
index fcaa5dbd728a..8f9548071e84 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -105,6 +105,31 @@ SYM_CODE_START_NOALIGN(startup_64)
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
+
+	/* IDT descriptor with pointer to IDT table as first parameter */
+	leaq	idt_descr(%rip), %rdi
+
+	/* Kernel _text offset as second parameter */
+	leaq	_text(%rip), %rsi
+
+	/*
+	 * Setup IDT with early entries - The entries already use virtual
+	 * addresses, so the IDT can't be used until the kernel switched to
+	 * virtual addresses too.
+	 */
+	call	early_idt_setup_early_handler
+
+	/* Restore __startup_64 return value*/
+	popq	%rax
+	/* Restore pointer to real_mode_data */
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
@@ -201,6 +226,9 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	movq initial_stack(%rip), %rsp
 
+	/* Load IDT */
+	lidt	idt_descr(%rip)
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
-- 
2.27.0
