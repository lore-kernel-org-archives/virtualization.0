From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 41/75] x86/sev-es: Setup early #VC handler
Date: Tue, 28 Apr 2020 17:16:51 +0200
Message-ID: <20200428151725.31091-42-joro@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200428151725.31091-1-joro@8bytes.org>
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
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Setup an early handler for #VC exceptions. There is no GHCB mapped
yet, so just re-use the vc_no_ghcb_handler. It can only handle CPUID
exit-codes, but that should be enough to get the kernel through
verify_cpu() and __startup_64() until it runs on virtual addresses.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/desc.h      |  1 +
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/include/asm/sev-es.h    |  2 ++
 arch/x86/kernel/head64.c         | 17 +++++++++++++++
 arch/x86/kernel/head_64.S        | 36 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/idt.c            | 10 +++++++++
 6 files changed, 67 insertions(+)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 80bf63c08007..30e2a0e863b6 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -388,6 +388,7 @@ static inline void set_desc_limit(struct desc_struct *desc, unsigned long limit)
 
 void update_intr_gate(unsigned int n, const void *addr);
 void alloc_intr_gate(unsigned int n, const void *addr);
+void set_early_idt_handler(gate_desc *idt, int n, void *handler);
 
 static inline void init_idt_data(struct idt_data *data, unsigned int n,
 				 const void *addr)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3bcf27caf6c9..e369271bfd33 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -757,6 +757,7 @@ extern int sysenter_setup(void);
 
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
+extern struct desc_ptr		early_idt_descr;
 
 extern void switch_to_new_gdt(int);
 extern void load_direct_gdt(int);
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 7c0807b84546..b2cbcd40b52e 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -73,4 +73,6 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 	return (val & mask);
 }
 
+extern void vc_no_ghcb(void);
+
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 474f121d50f6..9586522bfcb3 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -38,6 +38,7 @@
 #include <asm/fixmap.h>
 #include <asm/extable.h>
 #include <asm/trap_defs.h>
+#include <asm/sev-es.h>
 
 /*
  * Manage page tables very early on.
@@ -515,3 +516,19 @@ void __head early_idt_setup_early_handler(unsigned long physaddr)
 		native_write_idt_entry(idt, i, &desc);
 	}
 }
+
+void __head early_idt_setup(unsigned long physbase)
+{
+	gate_desc *idt = fixup_pointer(idt_table, physbase);
+	void __maybe_unused *handler;
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* VMM Communication Exception */
+	handler = fixup_pointer(vc_no_ghcb, physbase);
+	set_early_idt_handler(idt, X86_TRAP_VC, handler);
+#endif
+
+	/* Initialize IDT descriptor and load IDT */
+	early_idt_descr.address = (unsigned long)idt;
+	native_load_idt(&early_idt_descr);
+}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index aca3beb336ce..4d84a0c72e36 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -92,6 +92,12 @@ SYM_CODE_START_NOALIGN(startup_64)
 .Lon_kernel_cs:
 	UNWIND_HINT_EMPTY
 
+	/* Setup IDT - Needed for SEV-ES */
+	leaq	_text(%rip), %rdi
+	pushq	%rsi
+	call	early_idt_setup
+	popq	%rsi
+
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
@@ -370,6 +376,33 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 	jmp restore_regs_and_return_to_kernel
 SYM_CODE_END(early_idt_handler_common)
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/*
+ * VC Exception handler used during very early boot. The
+ * early_idt_handler_array can't be used because it returns via the
+ * paravirtualized INTERRUPT_RETURN and pv-ops don't work that early.
+ */
+SYM_CODE_START_NOALIGN(vc_no_ghcb)
+	UNWIND_HINT_IRET_REGS offset=8
+
+	/* Build pt_regs */
+	PUSH_AND_CLEAR_REGS
+
+	/* Call C handler */
+	movq    %rsp, %rdi
+	movq	ORIG_RAX(%rsp), %rsi
+	call    do_vc_no_ghcb
+
+	/* Unwind pt_regs */
+	POP_REGS
+
+	/* Remove Error Code */
+	addq    $8, %rsp
+
+	/* Pure iret required here - don't use INTERRUPT_RETURN */
+	iretq
+SYM_CODE_END(vc_no_ghcb)
+#endif
 
 #define SYM_DATA_START_PAGE_ALIGNED(name)			\
 	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
@@ -511,6 +544,9 @@ SYM_DATA_END(level1_fixmap_pgt)
 SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
 SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
 
+SYM_DATA(early_idt_descr,		.word NUM_EXCEPTION_VECTORS * 16)
+SYM_DATA_LOCAL(early_idt_descr_base,	.quad 0)
+
 	.align 16
 /* This must match the first entry in level2_kernel_pgt */
 SYM_DATA(phys_base, .quad 0x0)
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 4a2c7791c697..135d208a2d38 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -341,3 +341,13 @@ void alloc_intr_gate(unsigned int n, const void *addr)
 	if (!test_and_set_bit(n, system_vectors))
 		set_intr_gate(n, addr);
 }
+
+void set_early_idt_handler(gate_desc *idt, int n, void *handler)
+{
+	struct idt_data data;
+	gate_desc desc;
+
+	init_idt_data(&data, n, handler);
+	idt_init_desc(&desc, &data);
+	native_write_idt_entry(idt, n, &desc);
+}
-- 
2.17.1
