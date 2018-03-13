From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 18/27] xen: Adapt assembly for PIE support
Date: Tue, 13 Mar 2018 13:59:36 -0700
Message-ID: <20180313205945.245105-19-thgarnie__28981.6432669342$1520974880$gmane$org@google.com>
References: <20180313205945.245105-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180313205945.245105-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Garnier <thgarnie@google.com>, Arnd Bergmann <arnd@arndb.de>, Philippe Ombredanne <pombredanne@nexb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Matthias Kaehlcke <mka@chromium.org>, Kees Cook <keescook@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Raf
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

Change the assembly code to use the new _ASM_MOVABS macro which get a
symbol reference while being PIE compatible. Adapt the relocation tool
to ignore 32-bit Xen code.

Position Independent Executable (PIE) support will allow to extended the
KASLR randomization range below the -2G memory limit.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/tools/relocs.c | 16 +++++++++++++++-
 arch/x86/xen/xen-head.S | 11 ++++++-----
 arch/x86/xen/xen-pvh.S  | 13 +++++++++----
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index a35cc337f883..29283ad3950f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -832,6 +832,16 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 		strncmp(symname, "init_per_cpu_", 13);
 }
 
+/*
+ * Check if the 32-bit relocation is within the xenpvh 32-bit code.
+ * If so, ignores it.
+ */
+static int is_in_xenpvh_assembly(ElfW(Addr) offset)
+{
+	ElfW(Sym) *sym = sym_lookup("pvh_start_xen");
+	return sym && (offset >= sym->st_value) &&
+		(offset < (sym->st_value + sym->st_size));
+}
 
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
@@ -895,8 +905,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		 * the relocations are processed.
 		 * Make sure that the offset will fit.
 		 */
-		if (r_type != R_X86_64_64 && (int32_t)offset != (int64_t)offset)
+		if (r_type != R_X86_64_64 &&
+		    (int32_t)offset != (int64_t)offset) {
+			if (is_in_xenpvh_assembly(offset))
+				break;
 			die("Relocation offset doesn't fit in 32 bits\n");
+		}
 
 		if (r_type == R_X86_64_64)
 			add_reloc(&relocs64, offset);
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 96f26e026783..210568e63c84 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -28,14 +28,15 @@ ENTRY(startup_xen)
 
 	/* Clear .bss */
 	xor %eax,%eax
-	mov $__bss_start, %_ASM_DI
-	mov $__bss_stop, %_ASM_CX
+	_ASM_MOVABS $__bss_start, %_ASM_DI
+	_ASM_MOVABS $__bss_stop, %_ASM_CX
 	sub %_ASM_DI, %_ASM_CX
 	shr $__ASM_SEL(2, 3), %_ASM_CX
 	rep __ASM_SIZE(stos)
 
-	mov %_ASM_SI, xen_start_info
-	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
+	_ASM_MOVABS $xen_start_info, %_ASM_AX
+	_ASM_MOV %_ASM_SI, (%_ASM_AX)
+	_ASM_MOVABS $init_thread_union+THREAD_SIZE, %_ASM_SP
 
 #ifdef CONFIG_X86_64
 	/* Set up %gs.
@@ -46,7 +47,7 @@ ENTRY(startup_xen)
 	 * init data section till per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
+	movabsq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
 	cdq
 	wrmsr
 #endif
diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index e1a5fbeae08d..43e234c7c2de 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -101,8 +101,8 @@ ENTRY(pvh_start_xen)
 	call xen_prepare_pvh
 
 	/* startup_64 expects boot_params in %rsi. */
-	mov $_pa(pvh_bootparams), %rsi
-	mov $_pa(startup_64), %rax
+	movabs $_pa(pvh_bootparams), %rsi
+	movabs $_pa(startup_64), %rax
 	jmp *%rax
 
 #else /* CONFIG_X86_64 */
@@ -137,10 +137,15 @@ END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
+	/*
+	 * Use a quad for _pa(gdt_start) because PIE does not understand a
+	 * long is enough. The resulting value will still be in the lower long
+	 * part.
+	 */
 gdt:
 	.word gdt_end - gdt_start
-	.long _pa(gdt_start)
-	.word 0
+	.quad _pa(gdt_start)
+	.balign 8
 gdt_start:
 	.quad 0x0000000000000000            /* NULL descriptor */
 	.quad 0x0000000000000000            /* reserved */
-- 
2.16.2.660.g709887971b-goog
