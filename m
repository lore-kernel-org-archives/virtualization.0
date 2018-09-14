From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 10/11] x86/vdso: Move cycle_last handling into the caller
Date: Fri, 14 Sep 2018 14:50:16 +0200
Message-ID: <20180914125118.998589817__41202.785811811$1536929953$gmane$org@linutronix.de>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=x86-vdso--Move-cycle_last-handling-into-the-caller.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Dereferencing gtod->cycle_last all over the place and foing the cycles <
last comparison in the vclock read functions generates horrible code. Doing
it at the call site is much better and gains a few cycles both for TSC and
pvclock.

Caveat: This adds the comparison to the hyperv vclock as well, but I have
no way to test that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   39 ++++++-----------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -76,9 +76,8 @@ static notrace const struct pvclock_vsys
 static notrace u64 vread_pvclock(void)
 {
 	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
-	u64 ret;
-	u64 last;
 	u32 version;
+	u64 ret;
 
 	/*
 	 * Note: The kernel and hypervisor must guarantee that cpu ID
@@ -111,13 +110,7 @@ static notrace u64 vread_pvclock(void)
 		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
 	} while (pvclock_read_retry(pvti, version));
 
-	/* refer to vread_tsc() comment for rationale */
-	last = gtod->cycle_last;
-
-	if (likely(ret >= last))
-		return ret;
-
-	return last;
+	return ret;
 }
 #endif
 #ifdef CONFIG_HYPERV_TSCPAGE
@@ -130,30 +123,10 @@ static notrace u64 vread_hvclock(void)
 }
 #endif
 
-notrace static u64 vread_tsc(void)
-{
-	u64 ret = (u64)rdtsc_ordered();
-	u64 last = gtod->cycle_last;
-
-	if (likely(ret >= last))
-		return ret;
-
-	/*
-	 * GCC likes to generate cmov here, but this branch is extremely
-	 * predictable (it's just a function of time and the likely is
-	 * very likely) and there's a data dependence, so force GCC
-	 * to generate a branch instead.  I don't barrier() because
-	 * we don't actually need a barrier, and if this function
-	 * ever gets inlined it will generate worse code.
-	 */
-	asm volatile ("");
-	return last;
-}
-
 notrace static inline u64 vgetcyc(int mode)
 {
 	if (mode == VCLOCK_TSC)
-		return vread_tsc();
+		return (u64)rdtsc_ordered();
 #ifdef CONFIG_PARAVIRT_CLOCK
 	else if (mode == VCLOCK_PVCLOCK)
 		return vread_pvclock();
@@ -168,17 +141,19 @@ notrace static inline u64 vgetcyc(int mo
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
 	struct vgtod_ts *base = &gtod->basetime[clk];
+	u64 cycles, last, ns;
 	unsigned int seq;
-	u64 cycles, ns;
 
 	do {
 		seq = gtod_read_begin(gtod);
 		ts->tv_sec = base->sec;
 		ns = base->nsec;
+		last = gtod->cycle_last;
 		cycles = vgetcyc(gtod->vclock_mode);
 		if (unlikely((s64)cycles < 0))
 			return vdso_fallback_gettime(clk, ts);
-		ns += (cycles - gtod->cycle_last) * gtod->mult;
+		if (cycles > last)
+			ns += (cycles - last) * gtod->mult;
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
