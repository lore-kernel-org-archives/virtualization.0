From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 27/27] x86/kaslr: Add option to extend KASLR range from 1GB
	to 3GB
Date: Wed, 11 Oct 2017 13:30:27 -0700
Message-ID: <20171011203027.11248-28-thgarnie__43152.5163622156$1509080479$gmane$org@google.com>
References: <20171011203027.11248-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171011203027.11248-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Garnier <thgarnie@google.com>, Kees Cook <keescook@chromium.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Matthias Kaehlcke <mka@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.>
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

Add a new CONFIG_RANDOMIZE_BASE_LARGE option to benefit from PIE
support. It increases the KASLR range from 1GB to 3GB. The new range
stars at 0xffffffff00000000 just above the EFI memory region. This
option is off by default.

The boot code is adapted to create the appropriate page table spanning
three PUD pages.

The relocation table uses 64-bit integers generated with the updated
relocation tool with the large-reloc option.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/Kconfig                     | 21 +++++++++++++++++++++
 arch/x86/boot/compressed/Makefile    |  5 +++++
 arch/x86/boot/compressed/misc.c      | 10 +++++++++-
 arch/x86/include/asm/page_64_types.h |  9 +++++++++
 arch/x86/kernel/head64.c             | 15 ++++++++++++---
 arch/x86/kernel/head_64.S            | 11 ++++++++++-
 6 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bbd28a46ab55..54627dd06348 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2155,6 +2155,27 @@ config X86_PIE
 	select DYNAMIC_MODULE_BASE
 	select MODULE_REL_CRCS if MODVERSIONS
 
+config RANDOMIZE_BASE_LARGE
+	bool "Increase the randomization range of the kernel image"
+	depends on X86_64 && RANDOMIZE_BASE
+	select X86_PIE
+	select X86_MODULE_PLTS if MODULES
+	default n
+	---help---
+	  Build the kernel as a Position Independent Executable (PIE) and
+	  increase the available randomization range from 1GB to 3GB.
+
+	  This option impacts performance on kernel CPU intensive workloads up
+	  to 10% due to PIE generated code. Impact on user-mode processes and
+	  typical usage would be significantly less (0.50% when you build the
+	  kernel).
+
+	  The kernel and modules will generate slightly more assembly (1 to 2%
+	  increase on the .text sections). The vmlinux binary will be
+	  significantly smaller due to less relocations.
+
+	  If unsure say N
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 8a958274b54c..94dfee5a7cd2 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -112,7 +112,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 
 targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
 
+# Large randomization require bigger relocation table
+ifeq ($(CONFIG_RANDOMIZE_BASE_LARGE),y)
+CMD_RELOCS = arch/x86/tools/relocs --large-reloc
+else
 CMD_RELOCS = arch/x86/tools/relocs
+endif
 quiet_cmd_relocs = RELOCS  $@
       cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
 $(obj)/vmlinux.relocs: vmlinux FORCE
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c14217cd0155..c1ac9f2e283d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -169,10 +169,18 @@ void __puthex(unsigned long value)
 }
 
 #if CONFIG_X86_NEED_RELOCS
+
+/* Large randomization go lower than -2G and use large relocation table */
+#ifdef CONFIG_RANDOMIZE_BASE_LARGE
+typedef long rel_t;
+#else
+typedef int rel_t;
+#endif
+
 static void handle_relocations(void *output, unsigned long output_len,
 			       unsigned long virt_addr)
 {
-	int *reloc;
+	rel_t *reloc;
 	unsigned long delta, map, ptr;
 	unsigned long min_addr = (unsigned long)output;
 	unsigned long max_addr = min_addr + (VO___bss_start - VO__text);
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 3f5f08b010d0..6b65f846dd64 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -48,7 +48,11 @@
 #define __PAGE_OFFSET           __PAGE_OFFSET_BASE
 #endif /* CONFIG_RANDOMIZE_MEMORY */
 
+#ifdef CONFIG_RANDOMIZE_BASE_LARGE
+#define __START_KERNEL_map	_AC(0xffffffff00000000, UL)
+#else
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
+#endif /* CONFIG_RANDOMIZE_BASE_LARGE */
 
 /* See Documentation/x86/x86_64/mm.txt for a description of the memory map. */
 #ifdef CONFIG_X86_5LEVEL
@@ -65,9 +69,14 @@
  * 512MiB by default, leaving 1.5GiB for modules once the page tables
  * are fully set up. If kernel ASLR is configured, it can extend the
  * kernel page table mapping, reducing the size of the modules area.
+ * On PIE, we relocate the binary 2G lower so add this extra space.
  */
 #if defined(CONFIG_RANDOMIZE_BASE)
+#ifdef CONFIG_RANDOMIZE_BASE_LARGE
+#define KERNEL_IMAGE_SIZE	(_AC(3, UL) * 1024 * 1024 * 1024)
+#else
 #define KERNEL_IMAGE_SIZE	(1024 * 1024 * 1024)
+#endif
 #else
 #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index b6363f0d11a7..d603d0f5a40a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -39,6 +39,7 @@ static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #define __head	__section(.head.text)
+#define pud_count(x)   (((x + (PUD_SIZE - 1)) & ~(PUD_SIZE - 1)) >> PUD_SHIFT)
 
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
@@ -56,6 +57,8 @@ unsigned long __head notrace __startup_64(unsigned long physaddr,
 {
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
+	unsigned long level3_kernel_start, level3_kernel_count;
+	unsigned long level3_fixmap_start;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
 	pudval_t *pud;
@@ -83,6 +86,11 @@ unsigned long __head notrace __startup_64(unsigned long physaddr,
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
+	/* Look at the randomization spread to adapt page table used */
+	level3_kernel_start = pud_index(__START_KERNEL_map);
+	level3_kernel_count = pud_count(KERNEL_IMAGE_SIZE);
+	level3_fixmap_start = level3_kernel_start + level3_kernel_count;
+
 	/* Fixup the physical addresses in the page table */
 
 	pgd = fixup_pointer(&early_top_pgt, physaddr);
@@ -94,8 +102,9 @@ unsigned long __head notrace __startup_64(unsigned long physaddr,
 	}
 
 	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
-	pud[510] += load_delta;
-	pud[511] += load_delta;
+	for (i = 0; i < level3_kernel_count; i++)
+		pud[level3_kernel_start + i] += load_delta;
+	pud[level3_fixmap_start] += load_delta;
 
 	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
 	pmd[506] += load_delta;
@@ -150,7 +159,7 @@ unsigned long __head notrace __startup_64(unsigned long physaddr,
 	 */
 
 	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
-	for (i = 0; i < PTRS_PER_PMD; i++) {
+	for (i = 0; i < PTRS_PER_PMD * level3_kernel_count; i++) {
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 	}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index df5198e310fc..7918ffefc9c9 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -39,11 +39,15 @@
 
 #define p4d_index(x)	(((x) >> P4D_SHIFT) & (PTRS_PER_P4D-1))
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#define pud_count(x)   (((x + (PUD_SIZE - 1)) & ~(PUD_SIZE - 1)) >> PUD_SHIFT)
 
 PGD_PAGE_OFFSET = pgd_index(__PAGE_OFFSET_BASE)
 PGD_START_KERNEL = pgd_index(__START_KERNEL_map)
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
+/* Adapt page table L3 space based on range of randomization */
+L3_KERNEL_ENTRY_COUNT = pud_count(KERNEL_IMAGE_SIZE)
+
 	.text
 	__HEAD
 	.code64
@@ -413,7 +417,12 @@ NEXT_PAGE(level4_kernel_pgt)
 NEXT_PAGE(level3_kernel_pgt)
 	.fill	L3_START_KERNEL,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
-	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
+	i = 0
+	.rept	L3_KERNEL_ENTRY_COUNT
+	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC \
+		+ PAGE_SIZE*i
+	i = i + 1
+	.endr
 	.quad	level2_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 
 NEXT_PAGE(level2_kernel_pgt)
-- 
2.15.0.rc0.271.g36b669edcc-goog
