From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/5] Make kvm host use the paravirt clocksource structs.
Date: Tue,  3 Jun 2008 15:07:17 +0200
Message-ID: <1212498439-1283-4-git-send-email-kraxel@redhat.com>
References: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-owner@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This patch updates the kvm host code to use the pvclock structs.
It also makes the paravirt clock compatible with Xen.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/kvm/x86.c         |   75 ++++++++++++++++++++++++++++++++++++-------
 include/asm-x86/kvm_host.h |    4 ++-
 2 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 77fb2bd..7a62860 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -499,8 +499,8 @@ static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
 {
 	static int version;
-	struct kvm_wall_clock wc;
-	struct timespec wc_ts;
+	struct pvclock_wall_clock wc;
+	struct timespec now, sys, boot;
 
 	if (!wall_clock)
 		return;
@@ -509,10 +509,19 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
 
 	kvm_write_guest(kvm, wall_clock, &version, sizeof(version));
 
-	wc_ts = current_kernel_time();
-	wc.wc_sec = wc_ts.tv_sec;
-	wc.wc_nsec = wc_ts.tv_nsec;
-	wc.wc_version = version;
+	/*
+	 * The guest calculates current wall clock time by adding
+	 * system time (updated by kvm_write_guest_time below) to the
+	 * wall clock specified here.  guest system time equals host
+	 * system time for us, thus we must fill in host boot time here.
+	 */
+	now = current_kernel_time();
+	ktime_get_ts(&sys);
+	boot = ns_to_timespec(timespec_to_ns(&now) - timespec_to_ns(&sys));
+
+	wc.sec = boot.tv_sec;
+	wc.nsec = boot.tv_nsec;
+	wc.version = version;
 
 	kvm_write_guest(kvm, wall_clock, &wc, sizeof(wc));
 
@@ -520,6 +529,45 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
 	kvm_write_guest(kvm, wall_clock, &version, sizeof(version));
 }
 
+static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
+{
+	uint32_t quotient, remainder;
+
+	/* Don't try to replace with do_div(), this one calculates
+	 * "(dividend << 32) / divisor" */
+	__asm__ ( "divl %4"
+		  : "=a" (quotient), "=d" (remainder)
+		  : "0" (0), "1" (dividend), "r" (divisor) );
+	return quotient;
+}
+
+static void kvm_set_time_scale(uint32_t tsc_khz, struct pvclock_vcpu_time_info *hv_clock)
+{
+	uint64_t nsecs = 1000000000LL;
+	int32_t  shift = 0;
+	uint64_t tps64;
+	uint32_t tps32;
+
+	tps64 = tsc_khz * 1000LL;
+	while (tps64 > nsecs*2) {
+		tps64 >>= 1;
+		shift--;
+	}
+
+	tps32 = (uint32_t)tps64;
+	while (tps32 <= (uint32_t)nsecs) {
+		tps32 <<= 1;
+		shift++;
+	}
+
+	hv_clock->tsc_shift = shift;
+	hv_clock->tsc_to_system_mul = div_frac(nsecs, tps32);
+
+	pr_debug("%s: tsc_khz %u, tsc_shift %d, tsc_mul %u\n",
+		 __FUNCTION__, tsc_khz, hv_clock->tsc_shift,
+		 hv_clock->tsc_to_system_mul);
+}
+
 static void kvm_write_guest_time(struct kvm_vcpu *v)
 {
 	struct timespec ts;
@@ -530,6 +578,11 @@ static void kvm_write_guest_time(struct kvm_vcpu *v)
 	if ((!vcpu->time_page))
 		return;
 
+	if (unlikely(vcpu->hv_clock_tsc_khz != tsc_khz)) {
+		kvm_set_time_scale(tsc_khz, &vcpu->hv_clock);
+		vcpu->hv_clock_tsc_khz = tsc_khz;
+	}
+	
 	/* Keep irq disabled to prevent changes to the clock */
 	local_irq_save(flags);
 	kvm_get_msr(v, MSR_IA32_TIME_STAMP_COUNTER,
@@ -544,14 +597,14 @@ static void kvm_write_guest_time(struct kvm_vcpu *v)
 	/*
 	 * The interface expects us to write an even number signaling that the
 	 * update is finished. Since the guest won't see the intermediate
-	 * state, we just write "2" at the end
+	 * state, we just increase by 2 at the end.
 	 */
-	vcpu->hv_clock.version = 2;
+	vcpu->hv_clock.version += 2;
 
 	shared_kaddr = kmap_atomic(vcpu->time_page, KM_USER0);
 
 	memcpy(shared_kaddr + vcpu->time_offset, &vcpu->hv_clock,
-		sizeof(vcpu->hv_clock));
+	       sizeof(vcpu->hv_clock));
 
 	kunmap_atomic(shared_kaddr, KM_USER0);
 
@@ -639,10 +692,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 		/* ...but clean it before doing the actual write */
 		vcpu->arch.time_offset = data & ~(PAGE_MASK | 1);
 
-		vcpu->arch.hv_clock.tsc_to_system_mul =
-					clocksource_khz2mult(tsc_khz, 22);
-		vcpu->arch.hv_clock.tsc_shift = 22;
-
 		down_read(&current->mm->mmap_sem);
 		vcpu->arch.time_page =
 				gfn_to_page(vcpu->kvm, data >> PAGE_SHIFT);
diff --git a/include/asm-x86/kvm_host.h b/include/asm-x86/kvm_host.h
index cd50380..459461c 100644
--- a/include/asm-x86/kvm_host.h
+++ b/include/asm-x86/kvm_host.h
@@ -18,6 +18,7 @@
 #include <linux/kvm_para.h>
 #include <linux/kvm_types.h>
 
+#include <asm/pvclock-abi.h>
 #include <asm/desc.h>
 
 #define KVM_MAX_VCPUS 16
@@ -285,7 +286,8 @@ struct kvm_vcpu_arch {
 	struct x86_emulate_ctxt emulate_ctxt;
 
 	gpa_t time;
-	struct kvm_vcpu_time_info hv_clock;
+	struct pvclock_vcpu_time_info hv_clock;
+	unsigned int hv_clock_tsc_khz;
 	unsigned int time_offset;
 	struct page *time_page;
 
-- 
1.5.4.1
