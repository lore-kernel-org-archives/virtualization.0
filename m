From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Fri, 14 Sep 2018 14:50:15 +0200
Message-ID: <20180914125118.909646643__10747.9903883815$1536930121$gmane$org@linutronix.de>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=x86-vdso--Simplify-the-invalid-vclock-case.patch
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

The code flow for the vclocks is convoluted as it requires the vclocks
which can be invalidated separately from the vsyscall_gtod_data sequence to
store the fact in a separate variable. That's inefficient.

Restructure the code so the vclock readout returns cycles and the
conversion to nanoseconds is handled at the call site.

If the clock gets invalidated or vclock is already VCLOCK_NONE, return
U64_MAX as the cycle value, which is invalid for all clocks and leave the
sequence loop immediately in that case by calling the fallback function
directly.

This allows to remove the gettimeofday fallback as it now uses the
clock_gettime() fallback and does the nanoseconds to microseconds
conversion in the same way as it does when the vclock is functional. It
does not make a difference whether the division by 1000 happens in the
kernel fallback or in userspace.

Generates way better code and gains a few cycles back.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   81 +++++++++--------------------------
 1 file changed, 21 insertions(+), 60 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -48,16 +48,6 @@ notrace static long vdso_fallback_gettim
 	return ret;
 }
 
-notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
-{
-	long ret;
-
-	asm("syscall" : "=a" (ret) :
-	    "0" (__NR_gettimeofday), "D" (tv), "S" (tz) : "memory");
-	return ret;
-}
-
-
 #else
 
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
@@ -75,21 +65,6 @@ notrace static long vdso_fallback_gettim
 	return ret;
 }
 
-notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
-{
-	long ret;
-
-	asm(
-		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=a" (ret)
-		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
-		: "memory", "edx");
-	return ret;
-}
-
 #endif
 
 #ifdef CONFIG_PARAVIRT_CLOCK
@@ -98,7 +73,7 @@ static notrace const struct pvclock_vsys
 	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
 }
 
-static notrace u64 vread_pvclock(int *mode)
+static notrace u64 vread_pvclock(void)
 {
 	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
 	u64 ret;
@@ -130,10 +105,8 @@ static notrace u64 vread_pvclock(int *mo
 	do {
 		version = pvclock_read_begin(pvti);
 
-		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT))) {
-			*mode = VCLOCK_NONE;
-			return 0;
-		}
+		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
+			return U64_MAX;
 
 		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
 	} while (pvclock_read_retry(pvti, version));
@@ -148,17 +121,12 @@ static notrace u64 vread_pvclock(int *mo
 }
 #endif
 #ifdef CONFIG_HYPERV_TSCPAGE
-static notrace u64 vread_hvclock(int *mode)
+static notrace u64 vread_hvclock(void)
 {
 	const struct ms_hyperv_tsc_page *tsc_pg =
 		(const struct ms_hyperv_tsc_page *)&hvclock_page;
-	u64 current_tick = hv_read_tsc_page(tsc_pg);
-
-	if (current_tick != U64_MAX)
-		return current_tick;
 
-	*mode = VCLOCK_NONE;
-	return 0;
+	return hv_read_tsc_page(tsc_pg);
 }
 #endif
 
@@ -182,47 +150,42 @@ notrace static u64 vread_tsc(void)
 	return last;
 }
 
-notrace static inline u64 vgetsns(int *mode)
+notrace static inline u64 vgetcyc(int mode)
 {
-	u64 v;
-	cycles_t cycles;
-
-	if (gtod->vclock_mode == VCLOCK_TSC)
-		cycles = vread_tsc();
+	if (mode == VCLOCK_TSC)
+		return vread_tsc();
 #ifdef CONFIG_PARAVIRT_CLOCK
-	else if (gtod->vclock_mode == VCLOCK_PVCLOCK)
-		cycles = vread_pvclock(mode);
+	else if (mode == VCLOCK_PVCLOCK)
+		return vread_pvclock();
 #endif
 #ifdef CONFIG_HYPERV_TSCPAGE
-	else if (gtod->vclock_mode == VCLOCK_HVCLOCK)
-		cycles = vread_hvclock(mode);
+	else if (mode == VCLOCK_HVCLOCK)
+		return vread_hvclock();
 #endif
-	else
-		return 0;
-	v = cycles - gtod->cycle_last;
-	return v * gtod->mult;
+	return U64_MAX;
 }
 
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
 	struct vgtod_ts *base = &gtod->basetime[clk];
 	unsigned int seq;
-	int mode;
-	u64 ns;
+	u64 cycles, ns;
 
 	do {
 		seq = gtod_read_begin(gtod);
-		mode = gtod->vclock_mode;
 		ts->tv_sec = base->sec;
 		ns = base->nsec;
-		ns += vgetsns(&mode);
+		cycles = vgetcyc(gtod->vclock_mode);
+		if (unlikely((s64)cycles < 0))
+			return vdso_fallback_gettime(clk, ts);
+		ns += (cycles - gtod->cycle_last) * gtod->mult;
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	return mode;
+	return 0;
 }
 
 notrace static void do_coarse(clockid_t clk, struct timespec *ts)
@@ -251,8 +214,7 @@ notrace int __vdso_clock_gettime(clockid
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VGTOD_HRES)) {
-		if (do_hres(clock, ts) != VCLOCK_NONE)
-			return 0;
+		return do_hres(clock, ts);
 	} else if (msk & VGTOD_COARSE) {
 		do_coarse(clock, ts);
 		return 0;
@@ -268,8 +230,7 @@ notrace int __vdso_gettimeofday(struct t
 	if (likely(tv != NULL)) {
 		struct timespec *ts = (struct timespec *) tv;
 
-		if (unlikely(do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE))
-			return vdso_fallback_gtod(tv, tz);
+		do_hres(CLOCK_REALTIME, ts);
 		tv->tv_usec /= 1000;
 	}
 	if (unlikely(tz != NULL)) {
