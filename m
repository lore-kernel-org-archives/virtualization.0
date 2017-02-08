From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method
Date: Wed,  8 Feb 2017 18:07:44 +0100
Message-ID: <20170208170744.7632-3-vkuznets__3404.69383304498$1486573688$gmane$org@redhat.com>
References: <20170208170744.7632-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170208170744.7632-1-vkuznets@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Andy Lutomirski <luto@amacapital.net>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Hyper-V TSC page clocksource is suitable for vDSO, however, the protocol
defined by the hypervisor is different from VCLOCK_PVCLOCK. Implement the
required support re-using pvclock_page VVAR as VCLOCK_PVCLOCK is mutually
exclusive with VCLOCK_HVCLOCK at run time.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/entry/vdso/vclock_gettime.c | 48 ++++++++++++++++++++++++++++++++++++
 arch/x86/entry/vdso/vma.c            | 26 +++++++++++++------
 arch/x86/hyperv/hv_init.c            |  3 +++
 arch/x86/include/asm/clocksource.h   |  3 ++-
 4 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 9d4d6e1..93e9dcd 100644
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
@@ -141,6 +142,49 @@ static notrace u64 vread_pvclock(int *mode)
 	return last;
 }
 #endif
+#ifdef CONFIG_HYPERV_CLOCK
+/* (a * b) >> 64 implementation */
+static inline u64 mul64x64_hi(u64 a, u64 b)
+{
+	u64 a_lo, a_hi, b_lo, b_hi, p1, p2;
+
+	a_lo = (u32)a;
+	a_hi = a >> 32;
+	b_lo = (u32)b;
+	b_hi = b >> 32;
+	p1 = a_lo * b_hi;
+	p2 = a_hi * b_lo;
+
+	return a_hi * b_hi + (p1 >> 32) + (p2 >> 32) +
+		((((a_lo * b_lo) >> 32) + (u32)p1 + (u32)p2) >> 32);
+
+}
+
+static notrace u64 vread_hvclock(int *mode)
+{
+	const struct ms_hyperv_tsc_page *tsc_pg =
+		(const struct ms_hyperv_tsc_page *)&pvclock_page;
+	u64 sequence, scale, offset, current_tick, cur_tsc;
+
+	while (1) {
+		sequence = READ_ONCE(tsc_pg->tsc_sequence);
+		if (!sequence)
+			break;
+
+		scale = READ_ONCE(tsc_pg->tsc_scale);
+		offset = READ_ONCE(tsc_pg->tsc_offset);
+		rdtscll(cur_tsc);
+
+		current_tick = mul64x64_hi(cur_tsc, scale) + offset;
+
+		if (READ_ONCE(tsc_pg->tsc_sequence) == sequence)
+			return current_tick;
+	}
+
+	*mode = VCLOCK_NONE;
+	return 0;
+}
+#endif
 
 notrace static u64 vread_tsc(void)
 {
@@ -173,6 +217,10 @@ notrace static inline u64 vgetsns(int *mode)
 	else if (gtod->vclock_mode == VCLOCK_PVCLOCK)
 		cycles = vread_pvclock(mode);
 #endif
+#ifdef CONFIG_HYPERV_CLOCK
+	else if (gtod->vclock_mode == VCLOCK_HVCLOCK)
+		cycles = vread_hvclock(mode);
+#endif
 	else
 		return 0;
 	v = (cycles - gtod->cycle_last) & gtod->mask;
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 10820f6..4b9d90c 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -21,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
+#include <asm/mshyperv.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -112,13 +113,24 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 		ret = vm_insert_pfn(vma, vmf->address,
 				    __pa_symbol(&__vvar_page) >> PAGE_SHIFT);
 	} else if (sym_offset == image->sym_pvclock_page) {
-		struct pvclock_vsyscall_time_info *pvti =
-			pvclock_pvti_cpu0_va();
-		if (pvti && vclock_was_used(VCLOCK_PVCLOCK)) {
-			ret = vm_insert_pfn(
-				vma,
-				vmf->address,
-				__pa(pvti) >> PAGE_SHIFT);
+		if (vclock_was_used(VCLOCK_PVCLOCK)) {
+			struct pvclock_vsyscall_time_info *pvti =
+				pvclock_pvti_cpu0_va();
+			if (pvti) {
+				ret = vm_insert_pfn(
+					vma,
+					vmf->address,
+					__pa(pvti) >> PAGE_SHIFT);
+			}
+		} else if (vclock_was_used(VCLOCK_HVCLOCK)) {
+			struct ms_hyperv_tsc_page *tsc_pg =
+				hv_get_tsc_page();
+			if (tsc_pg) {
+				ret = vm_insert_pfn(
+					vma,
+					vmf->address,
+					vmalloc_to_pfn(tsc_pg));
+			}
 		}
 	}
 
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index aa36049..3d534d2 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -157,6 +157,9 @@ void hyperv_init(void)
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
-- 
2.9.3
