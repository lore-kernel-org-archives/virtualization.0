From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 3/3] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method
Date: Fri,  3 Mar 2017 14:21:42 +0100
Message-ID: <20170303132142.25595-4-vkuznets__9252.41836016557$1488547337$gmane$org@redhat.com>
References: <20170303132142.25595-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170303132142.25595-1-vkuznets@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

Hyper-V TSC page clocksource is suitable for vDSO, however, the protocol
defined by the hypervisor is different from VCLOCK_PVCLOCK. Implement the
required support by adding hvclock_page VVAR.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/entry/vdso/vclock_gettime.c  | 24 ++++++++++++++++++++++++
 arch/x86/entry/vdso/vdso-layout.lds.S |  3 ++-
 arch/x86/entry/vdso/vdso2c.c          |  3 +++
 arch/x86/entry/vdso/vma.c             |  7 +++++++
 arch/x86/hyperv/hv_init.c             |  3 +++
 arch/x86/include/asm/clocksource.h    |  3 ++-
 arch/x86/include/asm/vdso.h           |  1 +
 7 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 9d4d6e1..fa8dbfc 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -17,6 +17,7 @@
 #include <asm/unistd.h>
 #include <asm/msr.h>
 #include <asm/pvclock.h>
+#include <asm/mshyperv.h>
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
@@ -32,6 +33,11 @@ extern u8 pvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
+#ifdef CONFIG_HYPERV_TSCPAGE
+extern u8 hvclock_page
+	__attribute__((visibility("hidden")));
+#endif
+
 #ifndef BUILD_VDSO32
 
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
@@ -141,6 +147,20 @@ static notrace u64 vread_pvclock(int *mode)
 	return last;
 }
 #endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+static notrace u64 vread_hvclock(int *mode)
+{
+	const struct ms_hyperv_tsc_page *tsc_pg =
+		(const struct ms_hyperv_tsc_page *)&hvclock_page;
+	u64 current_tick = hv_read_tsc_page(tsc_pg);
+
+	if (current_tick != U64_MAX)
+		return current_tick;
+
+	*mode = VCLOCK_NONE;
+	return 0;
+}
+#endif
 
 notrace static u64 vread_tsc(void)
 {
@@ -173,6 +193,10 @@ notrace static inline u64 vgetsns(int *mode)
 	else if (gtod->vclock_mode == VCLOCK_PVCLOCK)
 		cycles = vread_pvclock(mode);
 #endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+	else if (gtod->vclock_mode == VCLOCK_HVCLOCK)
+		cycles = vread_hvclock(mode);
+#endif
 	else
 		return 0;
 	v = (cycles - gtod->cycle_last) & gtod->mask;
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index a708aa9..8ebb4b6 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -25,7 +25,7 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 2 * PAGE_SIZE;
+	vvar_start = . - 3 * PAGE_SIZE;
 	vvar_page = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
@@ -36,6 +36,7 @@ SECTIONS
 #undef EMIT_VVAR
 
 	pvclock_page = vvar_start + PAGE_SIZE;
+	hvclock_page = vvar_start + 2 * PAGE_SIZE;
 
 	. = SIZEOF_HEADERS;
 
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 491020b..0780a44 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -74,6 +74,7 @@ enum {
 	sym_vvar_page,
 	sym_hpet_page,
 	sym_pvclock_page,
+	sym_hvclock_page,
 	sym_VDSO_FAKE_SECTION_TABLE_START,
 	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
@@ -82,6 +83,7 @@ const int special_pages[] = {
 	sym_vvar_page,
 	sym_hpet_page,
 	sym_pvclock_page,
+	sym_hvclock_page,
 };
 
 struct vdso_sym {
@@ -94,6 +96,7 @@ struct vdso_sym required_syms[] = {
 	[sym_vvar_page] = {"vvar_page", true},
 	[sym_hpet_page] = {"hpet_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
+	[sym_hvclock_page] = {"hvclock_page", true},
 	[sym_VDSO_FAKE_SECTION_TABLE_START] = {
 		"VDSO_FAKE_SECTION_TABLE_START", false
 	},
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 572cee3..71f5d3a 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -21,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
+#include <asm/mshyperv.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -120,6 +121,12 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 				vmf->address,
 				__pa(pvti) >> PAGE_SHIFT);
 		}
+	} else if (sym_offset == image->sym_hvclock_page) {
+		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
+
+		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
+			ret = vm_insert_pfn(vma, vmf->address,
+					    vmalloc_to_pfn(tsc_pg));
 	}
 
 	if (ret == 0 || ret == -EBUSY)
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 63dd00e..d08ac5e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -132,6 +132,9 @@ void hyperv_init(void)
 		tsc_msr.guest_physical_address = vmalloc_to_pfn(tsc_pg);
 
 		wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
+
+		hyperv_cs_tsc.archdata.vclock_mode = VCLOCK_HVCLOCK;
+
 		clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 		return;
 	}
diff --git a/arch/x86/include/asm/clocksource.h b/arch/x86/include/asm/clocksource.h
index eae33c7..47bea8c 100644
--- a/arch/x86/include/asm/clocksource.h
+++ b/arch/x86/include/asm/clocksource.h
@@ -6,7 +6,8 @@
 #define VCLOCK_NONE	0	/* No vDSO clock available.		*/
 #define VCLOCK_TSC	1	/* vDSO should use vread_tsc.		*/
 #define VCLOCK_PVCLOCK	2	/* vDSO should use vread_pvclock.	*/
-#define VCLOCK_MAX	2
+#define VCLOCK_HVCLOCK	3	/* vDSO should use vread_hvclock.	*/
+#define VCLOCK_MAX	3
 
 struct arch_clocksource_data {
 	int vclock_mode;
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 2444189..bccdf49 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -20,6 +20,7 @@ struct vdso_image {
 	long sym_vvar_page;
 	long sym_hpet_page;
 	long sym_pvclock_page;
+	long sym_hvclock_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
-- 
2.9.3
