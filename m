From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/4] kvm/host: fix paravirt clocksource to be
	compatible with xen.
Date: Thu,  8 May 2008 13:48:34 +0200
Message-ID: <1210247315-20472-4-git-send-email-kraxel@redhat.com>
References: <1210247315-20472-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1210247315-20472-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
To: virtualization@lists.osdl.org, kvm-devel@lists.sourceforge.net
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/kvm/x86.c |   63 +++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 979f983..6906d54 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -493,7 +493,7 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
 {
 	static int version;
 	struct kvm_wall_clock wc;
-	struct timespec wc_ts;
+	struct timespec now,sys,boot;
 
 	if (!wall_clock)
 		return;
@@ -502,9 +502,16 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
 
 	kvm_write_guest(kvm, wall_clock, &version, sizeof(version));
 
-	wc_ts = current_kernel_time();
-	wc.wc_sec = wc_ts.tv_sec;
-	wc.wc_nsec = wc_ts.tv_nsec;
+#if 0
+	/* Hmm, getboottime() isn't exported to modules ... */
+	getboottime(&boot);
+#else
+	now = current_kernel_time();
+	ktime_get_ts(&sys);
+	boot = ns_to_timespec(timespec_to_ns(&now) - timespec_to_ns(&sys));
+#endif
+	wc.wc_sec = boot.tv_sec;
+	wc.wc_nsec = boot.tv_nsec;
 	wc.wc_version = version;
 
 	kvm_write_guest(kvm, wall_clock, &wc, sizeof(wc));
@@ -537,20 +544,58 @@ static void kvm_write_guest_time(struct kvm_vcpu *v)
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
 
 	mark_page_dirty(v->kvm, vcpu->time >> PAGE_SHIFT);
 }
 
+static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
+{
+	uint32_t quotient, remainder;
+
+	__asm__ ( "divl %4"
+		  : "=a" (quotient), "=d" (remainder)
+		  : "0" (0), "1" (dividend), "r" (divisor) );
+	return quotient;
+}
+
+static void kvm_set_time_scale(uint32_t tsc_khz, struct kvm_vcpu_time_info *hv_clock)
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
+#if 0
+	printk(KERN_DEBUG "%s: tsc_khz %u, tsc_shift %d, tsc_mul %u\n",
+	       __FUNCTION__, tsc_khz, hv_clock->tsc_shift,
+	       hv_clock->tsc_to_system_mul);
+#endif
+}
 
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
@@ -599,9 +644,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 		/* ...but clean it before doing the actual write */
 		vcpu->arch.time_offset = data & ~(PAGE_MASK | 1);
 
-		vcpu->arch.hv_clock.tsc_to_system_mul =
-					clocksource_khz2mult(tsc_khz, 22);
-		vcpu->arch.hv_clock.tsc_shift = 22;
+		kvm_set_time_scale(tsc_khz, &vcpu->arch.hv_clock);
 
 		down_read(&current->mm->mmap_sem);
 		vcpu->arch.time_page =
-- 
1.5.4.1


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
