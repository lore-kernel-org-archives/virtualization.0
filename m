From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 14/21] [PATCH] unify x86_cpuinfo struct.
Date: Mon, 17 Dec 2007 20:52:37 -0200
Message-ID: <11979320354186-git-send-email-gcosta__30853.3335141421$1197942571$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
	<11979319903443-git-send-email-gcosta@redhat.com>
	<11979319953427-git-send-email-gcosta@redhat.com>
	<11979320011968-git-send-email-gcosta@redhat.com>
	<1197932006634-git-send-email-gcosta@redhat.com>
	<11979320114180-git-send-email-gcosta@redhat.com>
	<11979320163651-git-send-email-gcosta@redhat.com>
	<11979320211287-git-send-email-gcosta@redhat.com>
	<11979320252102-git-send-email-gcosta@redhat.com>
	<11979320302030-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979320302030-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

x86_cpuinfo is one more to the family of "not fundamentally different"
structs. It's unified in processor.h, with very specific fields enclosed
around ifdefs.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/cpu/common.c   |    6 +-
 include/asm-x86/processor.h    |   82 ++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/processor_32.h |   67 --------------------------------
 include/asm-x86/processor_64.h |   57 ---------------------------
 4 files changed, 85 insertions(+), 127 deletions(-)

Index: linux-2.6-x86/arch/x86/kernel/cpu/common.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/cpu/common.c
+++ linux-2.6-x86/arch/x86/kernel/cpu/common.c
@@ -427,7 +427,7 @@ static void __cpuinit identify_cpu(struc
 
 	printk(KERN_DEBUG "CPU: After generic identify, caps:");
 	for (i = 0; i < NCAPINTS; i++)
-		printk(" %08lx", c->x86_capability[i]);
+		printk(" %08x", c->x86_capability[i]);
 	printk("\n");
 
 	if (this_cpu->c_identify) {
@@ -435,7 +435,7 @@ static void __cpuinit identify_cpu(struc
 
 		printk(KERN_DEBUG "CPU: After vendor identify, caps:");
 		for (i = 0; i < NCAPINTS; i++)
-			printk(" %08lx", c->x86_capability[i]);
+			printk(" %08x", c->x86_capability[i]);
 		printk("\n");
 	}
 
@@ -493,7 +493,7 @@ static void __cpuinit identify_cpu(struc
 
 	printk(KERN_DEBUG "CPU: After all inits, caps:");
 	for (i = 0; i < NCAPINTS; i++)
-		printk(" %08lx", c->x86_capability[i]);
+		printk(" %08x", c->x86_capability[i]);
 	printk("\n");
 
 	/*
Index: linux-2.6-x86/include/asm-x86/processor.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor.h
+++ linux-2.6-x86/include/asm-x86/processor.h
@@ -6,6 +6,9 @@
 #include <asm/page.h>
 #include <asm/percpu.h>
 #include <asm/system.h>
+#include <asm/percpu.h>
+#include <linux/cpumask.h>
+#include <linux/cache.h>
 
 /*
  * Default implementation of macro that returns current
@@ -26,6 +29,85 @@ static inline void *current_text_addr(vo
 #define ARCH_MIN_MMSTRUCT_ALIGN	0
 #endif
 
+/*
+ *  CPU type and hardware bug flags. Kept separately for each CPU.
+ *  Members of this structure are referenced in head.S, so think twice
+ *  before touching them. [mj]
+ */
+
+struct cpuinfo_x86 {
+	__u8	x86;		/* CPU family */
+	__u8	x86_vendor;	/* CPU vendor */
+	__u8	x86_model;
+	__u8	x86_mask;
+#ifdef CONFIG_X86_32
+	char	wp_works_ok;	/* It doesn't on 386's */
+	char	hlt_works_ok;	/* Problems on some 486Dx4's and old 386's */
+	char	hard_math;
+	char	rfu;
+	char	fdiv_bug;
+	char	f00f_bug;
+	char	coma_bug;
+	char	pad0;
+#else
+	/* number of 4K pages in DTLB/ITLB combined(in pages)*/
+	int     x86_tlbsize;
+	__u8    x86_virt_bits, x86_phys_bits;
+	/* cpuid returned core id bits */
+	__u8    x86_coreid_bits;
+	/* Max extended CPUID function supported */
+	__u32   extended_cpuid_level;
+#endif
+	int	cpuid_level;	/* Maximum supported CPUID level, -1=no CPUID */
+	__u32	x86_capability[NCAPINTS];
+	char	x86_vendor_id[16];
+	char	x86_model_id[64];
+	int 	x86_cache_size;  /* in KB - valid for CPUS which support this
+				    call  */
+	int 	x86_cache_alignment;	/* In bytes */
+	int	x86_power;
+	unsigned long loops_per_jiffy;
+#ifdef CONFIG_SMP
+	cpumask_t llc_shared_map;	/* cpus sharing the last level cache */
+#endif
+	unsigned char x86_max_cores;	/* cpuid returned max cores value */
+	unsigned char apicid;
+	unsigned short x86_clflush_size;
+#ifdef CONFIG_SMP
+	unsigned char booted_cores;	/* number of cores as seen by OS */
+	__u8 phys_proc_id; 		/* Physical processor id. */
+	__u8 cpu_core_id;  		/* Core id */
+	__u8 cpu_index;			/* index into per_cpu list */
+#endif
+} __attribute__((__aligned__(SMP_CACHE_BYTES)));
+
+#define X86_VENDOR_INTEL 0
+#define X86_VENDOR_CYRIX 1
+#define X86_VENDOR_AMD 2
+#define X86_VENDOR_UMC 3
+#define X86_VENDOR_NEXGEN 4
+#define X86_VENDOR_CENTAUR 5
+#define X86_VENDOR_TRANSMETA 7
+#define X86_VENDOR_NSC 8
+#define X86_VENDOR_NUM 9
+#define X86_VENDOR_UNKNOWN 0xff
+
+extern struct cpuinfo_x86 boot_cpu_data;
+
+#ifdef CONFIG_SMP
+DECLARE_PER_CPU(struct cpuinfo_x86, cpu_info);
+#define cpu_data(cpu)		per_cpu(cpu_info, cpu)
+#define current_cpu_data	cpu_data(smp_processor_id())
+#else
+#define cpu_data(cpu)		boot_cpu_data
+#define current_cpu_data	boot_cpu_data
+#endif
+
+extern void print_cpu_info(struct cpuinfo_x86 *);
+extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
+extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
+extern unsigned short num_cache_leaves;
+
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 					 unsigned int *ecx, unsigned int *edx)
 {
Index: linux-2.6-x86/include/asm-x86/processor_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_32.h
+++ linux-2.6-x86/include/asm-x86/processor_32.h
@@ -14,83 +14,16 @@
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
 #include <asm/system.h>
-#include <linux/cache.h>
 #include <linux/threads.h>
-#include <asm/percpu.h>
-#include <linux/cpumask.h>
 #include <linux/init.h>
 #include <asm/desc_defs.h>
 
 /*
- *  CPU type and hardware bug flags. Kept separately for each CPU.
- *  Members of this structure are referenced in head.S, so think twice
- *  before touching them. [mj]
- */
-
-struct cpuinfo_x86 {
-	__u8	x86;		/* CPU family */
-	__u8	x86_vendor;	/* CPU vendor */
-	__u8	x86_model;
-	__u8	x86_mask;
-	char	wp_works_ok;	/* It doesn't on 386's */
-	char	hlt_works_ok;	/* Problems on some 486Dx4's and old 386's */
-	char	hard_math;
-	char	rfu;
-       	int	cpuid_level;	/* Maximum supported CPUID level, -1=no CPUID */
-	unsigned long	x86_capability[NCAPINTS];
-	char	x86_vendor_id[16];
-	char	x86_model_id[64];
-	int 	x86_cache_size;  /* in KB - valid for CPUS which support this
-				    call  */
-	int 	x86_cache_alignment;	/* In bytes */
-	char	fdiv_bug;
-	char	f00f_bug;
-	char	coma_bug;
-	char	pad0;
-	int	x86_power;
-	unsigned long loops_per_jiffy;
-#ifdef CONFIG_SMP
-	cpumask_t llc_shared_map;	/* cpus sharing the last level cache */
-#endif
-	unsigned char x86_max_cores;	/* cpuid returned max cores value */
-	unsigned char apicid;
-	unsigned short x86_clflush_size;
-#ifdef CONFIG_SMP
-	unsigned char booted_cores;	/* number of cores as seen by OS */
-	__u8 phys_proc_id; 		/* Physical processor id. */
-	__u8 cpu_core_id;  		/* Core id */
-	__u8 cpu_index;			/* index into per_cpu list */
-#endif
-} __attribute__((__aligned__(SMP_CACHE_BYTES)));
-
-#define X86_VENDOR_INTEL 0
-#define X86_VENDOR_CYRIX 1
-#define X86_VENDOR_AMD 2
-#define X86_VENDOR_UMC 3
-#define X86_VENDOR_NEXGEN 4
-#define X86_VENDOR_CENTAUR 5
-#define X86_VENDOR_TRANSMETA 7
-#define X86_VENDOR_NSC 8
-#define X86_VENDOR_NUM 9
-#define X86_VENDOR_UNKNOWN 0xff
-
-/*
  * capabilities of CPUs
  */
-
-extern struct cpuinfo_x86 boot_cpu_data;
 extern struct cpuinfo_x86 new_cpu_data;
 extern struct tss_struct doublefault_tss;
 
-#ifdef CONFIG_SMP
-DECLARE_PER_CPU(struct cpuinfo_x86, cpu_info);
-#define cpu_data(cpu)		per_cpu(cpu_info, cpu)
-#define current_cpu_data	cpu_data(smp_processor_id())
-#else
-#define cpu_data(cpu)		boot_cpu_data
-#define current_cpu_data	boot_cpu_data
-#endif
-
 /*
  * the following now lives in the per cpu area:
  * extern	int cpu_llc_id[NR_CPUS];
Index: linux-2.6-x86/include/asm-x86/processor_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_64.h
+++ linux-2.6-x86/include/asm-x86/processor_64.h
@@ -15,65 +15,9 @@
 #include <asm/current.h>
 #include <asm/system.h>
 #include <asm/mmsegment.h>
-#include <asm/percpu.h>
 #include <linux/personality.h>
-#include <linux/cpumask.h>
 #include <asm/desc_defs.h>
 
-/*
- *  CPU type and hardware bug flags. Kept separately for each CPU.
- */
-
-struct cpuinfo_x86 {
-	__u8	x86;		/* CPU family */
-	__u8	x86_vendor;	/* CPU vendor */
-	__u8	x86_model;
-	__u8	x86_mask;
-	int	cpuid_level;	/* Maximum supported CPUID level, -1=no CPUID */
-	__u32	x86_capability[NCAPINTS];
-	char	x86_vendor_id[16];
-	char	x86_model_id[64];
-	int 	x86_cache_size;  /* in KB */
-	int	x86_clflush_size;
-	int	x86_cache_alignment;
-	int	x86_tlbsize;	/* number of 4K pages in DTLB/ITLB combined(in pages)*/
-        __u8    x86_virt_bits, x86_phys_bits;
-	__u8	x86_max_cores;	/* cpuid returned max cores value */
-	__u8	x86_coreid_bits; /* cpuid returned core id bits */
-        __u32   x86_power; 	
-	__u32   extended_cpuid_level;	/* Max extended CPUID function supported */
-	unsigned long loops_per_jiffy;
-#ifdef CONFIG_SMP
-	cpumask_t llc_shared_map;	/* cpus sharing the last level cache */
-#endif
-	__u8	apicid;
-#ifdef CONFIG_SMP
-	__u8	booted_cores;	/* number of cores as seen by OS */
-	__u8	phys_proc_id;	/* Physical Processor id. */
-	__u8	cpu_core_id;	/* Core id. */
-	__u8	cpu_index;	/* index into per_cpu list */
-#endif
-} ____cacheline_aligned;
-
-#define X86_VENDOR_INTEL 0
-#define X86_VENDOR_CYRIX 1
-#define X86_VENDOR_AMD 2
-#define X86_VENDOR_UMC 3
-#define X86_VENDOR_NEXGEN 4
-#define X86_VENDOR_CENTAUR 5
-#define X86_VENDOR_TRANSMETA 7
-#define X86_VENDOR_NUM 8
-#define X86_VENDOR_UNKNOWN 0xff
-
-#ifdef CONFIG_SMP
-DECLARE_PER_CPU(struct cpuinfo_x86, cpu_info);
-#define cpu_data(cpu)		per_cpu(cpu_info, cpu)
-#define current_cpu_data	cpu_data(smp_processor_id())
-#else
-#define cpu_data(cpu)		boot_cpu_data
-#define current_cpu_data	boot_cpu_data
-#endif
-
 extern char ignore_irq13;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
@@ -110,7 +54,6 @@ union i387_union {
 	struct i387_fxsave_struct	fxsave;
 };
 
-extern struct cpuinfo_x86 boot_cpu_data;
 /* Save the original ist values for checking stack pointers during debugging */
 struct orig_ist {
 	unsigned long ist[7];
