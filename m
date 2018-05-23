From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH v3 27/27] x86/kaslr: Add option to extend KASLR range from 1GB
	to 3GB
Date: Wed, 23 May 2018 12:54:21 -0700
Message-ID: <20180523195421.180248-28-thgarnie__22047.674880787$1527106898$gmane$org@google.com>
References: <20180523195421.180248-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180523195421.180248-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Garnier <thgarnie@google.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Yonghong Song <yhs@fb.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>Len
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
index 26d5d4942777..3596a7a76ff0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2223,6 +2223,27 @@ config X86_PIE
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
index fa42f895fdde..8497ebd5e078 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -116,7 +116,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 
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
index 8dd1d5ccae58..28d17bd5bad8 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -171,10 +171,18 @@ void __puthex(unsigned long value)
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
index 2c5a966dc222..85ea681421d2 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -46,7 +46,11 @@
 #define __PAGE_OFFSET           __PAGE_OFFSET_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
+#ifdef CONFIG_RANDOMIZE_BASE_LARGE
+#define __START_KERNEL_map	_AC(0xffffffff00000000, UL)
+#else
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
+#endif /* CONFIG_RANDOMIZE_BASE_LARGE */
 
 /* See Documentation/x86/x86_64/mm.txt for a description of the memory map. */
 
@@ -64,9 +68,14 @@
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
index 3a1ce822e1c0..e18cc23b9d99 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -63,6 +63,7 @@ EXPORT_SYMBOL(vmemmap_base);
 #endif
 
 #define __head	__section(.head.text)
+#define pud_count(x)   (((x + (PUD_SIZE - 1)) & ~(PUD_SIZE - 1)) >> PUD_SHIFT)
 
 /* Required for read_cr3 when building as PIE */
 unsigned long __force_order;
@@ -118,6 +119,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 {
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
+	unsigned long level3_kernel_start, level3_kernel_count;
+	unsigned long level3_fixmap_start;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
 	pudval_t *pud;
@@ -149,6 +152,11 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
+	/* Look at the randomization spread to adapt page table used */
+	level3_kernel_start = pud_index(__START_KERNEL_map);
+	level3_kernel_count = pud_count(KERNEL_IMAGE_SIZE);
+	level3_fixmap_start = level3_kernel_start + level3_kernel_count;
+
 	/* Fixup the physical addresses in the page table */
 
 	pgd = fixup_pointer(&early_top_pgt, physaddr);
@@ -165,8 +173,9 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	}
 
 	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
-	pud[510] += load_delta;
-	pud[511] += load_delta;
+	for (i = 0; i < level3_kernel_count; i++)
+		pud[level3_kernel_start + i] += load_delta;
+	pud[level3_fixmap_start] += load_delta;
 
 	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
 	pmd[506] += load_delta;
@@ -224,7 +233,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 
 	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
-	for (i = 0; i < PTRS_PER_PMD; i++) {
+	for (i = 0; i < PTRS_PER_PMD * level3_kernel_count; i++) {
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 	}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f44b259b26d3..50343b9ba5da 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -41,12 +41,16 @@
 
 #define l4_index(x)	(((x) >> 39) & 511)
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#define pud_count(x)   (((x + (PUD_SIZE - 1)) & ~(PUD_SIZE - 1)) >> PUD_SHIFT)
 
 L4_PAGE_OFFSET = l4_index(__PAGE_OFFSET_BASE_L4)
 L4_START_KERNEL = l4_index(__START_KERNEL_map)
 
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
+/* Adapt page table L3 space based on range of randomization */
+L3_KERNEL_ENTRY_COUNT = pud_count(KERNEL_IMAGE_SIZE)
+
 	.text
 	__HEAD
 	.code64
@@ -441,7 +445,12 @@ NEXT_PAGE(level4_kernel_pgt)
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
2.17.0.441.gb46fe60e1d-goog
