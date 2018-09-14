From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 05/11] x86/vdso: Introduce and use vgtod_ts
Date: Fri, 14 Sep 2018 14:50:11 +0200
Message-ID: <20180914125118.554865878__21114.4964946017$1536929885$gmane$org@linutronix.de>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=x86-vdso--Introduce-and-use-vgtod_ts.patch
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

It's desired to support more clocks in the VDSO, e.g. CLOCK_TAI. This
results either in indirect calls due to the larger switch case, which then
requires retpolines or when the compiler is forced to avoid jump tables it
results in even more conditionals.

To avoid both variants which are bad for performance the high resolution
functions and the coarse grained functions will be collapsed into one for
each. That requires to store the clock specific base time in an array.

Introcude struct vgtod_ts for storage and convert the data store, the
update function and the individual clock functions over to use it.

The new storage does not longer use gtod_long_t for seconds depending on 32
or 64 bit compile because this needs to be the full 64bit value even for
32bit when a Y2038 function is added. No point in keeping the distinction
alive in the internal representation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c    |   24 +++++++++------
 arch/x86/entry/vsyscall/vsyscall_gtod.c |   51 ++++++++++++++++----------------
 arch/x86/include/asm/vgtod.h            |   36 ++++++++++++----------
 3 files changed, 61 insertions(+), 50 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -206,6 +206,7 @@ notrace static inline u64 vgetsns(int *m
 /* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
 notrace static int __always_inline do_realtime(struct timespec *ts)
 {
+	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME];
 	unsigned int seq;
 	u64 ns;
 	int mode;
@@ -213,8 +214,8 @@ notrace static int __always_inline do_re
 	do {
 		seq = gtod_read_begin(gtod);
 		mode = gtod->vclock_mode;
-		ts->tv_sec = gtod->wall_time_sec;
-		ns = gtod->wall_time_snsec;
+		ts->tv_sec = base->sec;
+		ns = base->nsec;
 		ns += vgetsns(&mode);
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
@@ -227,6 +228,7 @@ notrace static int __always_inline do_re
 
 notrace static int __always_inline do_monotonic(struct timespec *ts)
 {
+	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC];
 	unsigned int seq;
 	u64 ns;
 	int mode;
@@ -234,8 +236,8 @@ notrace static int __always_inline do_mo
 	do {
 		seq = gtod_read_begin(gtod);
 		mode = gtod->vclock_mode;
-		ts->tv_sec = gtod->monotonic_time_sec;
-		ns = gtod->monotonic_time_snsec;
+		ts->tv_sec = base->sec;
+		ns = base->nsec;
 		ns += vgetsns(&mode);
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
@@ -248,21 +250,25 @@ notrace static int __always_inline do_mo
 
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
+	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME_COARSE];
 	unsigned int seq;
+
 	do {
 		seq = gtod_read_begin(gtod);
-		ts->tv_sec = gtod->wall_time_coarse_sec;
-		ts->tv_nsec = gtod->wall_time_coarse_nsec;
+		ts->tv_sec = base->sec;
+		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 }
 
 notrace static void do_monotonic_coarse(struct timespec *ts)
 {
+	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC_COARSE];
 	unsigned int seq;
+
 	do {
 		seq = gtod_read_begin(gtod);
-		ts->tv_sec = gtod->monotonic_time_coarse_sec;
-		ts->tv_nsec = gtod->monotonic_time_coarse_nsec;
+		ts->tv_sec = base->sec;
+		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 }
 
@@ -318,7 +324,7 @@ int gettimeofday(struct timeval *, struc
 notrace time_t __vdso_time(time_t *t)
 {
 	/* This is atomic on x86 so we don't need any locks. */
-	time_t result = READ_ONCE(gtod->wall_time_sec);
+	time_t result = READ_ONCE(gtod->basetime[CLOCK_REALTIME].sec);
 
 	if (t)
 		*t = result;
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -31,6 +31,8 @@ void update_vsyscall(struct timekeeper *
 {
 	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
 	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
+	struct vgtod_ts *base;
+	u64 nsec;
 
 	/* Mark the new vclock used. */
 	BUILD_BUG_ON(VCLOCK_MAX >= 32);
@@ -45,34 +47,33 @@ void update_vsyscall(struct timekeeper *
 	vdata->mult		= tk->tkr_mono.mult;
 	vdata->shift		= tk->tkr_mono.shift;
 
-	vdata->wall_time_sec		= tk->xtime_sec;
-	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
-
-	vdata->monotonic_time_sec	= tk->xtime_sec
-					+ tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_snsec	= tk->tkr_mono.xtime_nsec
-					+ ((u64)tk->wall_to_monotonic.tv_nsec
-						<< tk->tkr_mono.shift);
-	while (vdata->monotonic_time_snsec >=
-					(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
-		vdata->monotonic_time_snsec -=
-					((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
-		vdata->monotonic_time_sec++;
+	base = &vdata->basetime[CLOCK_REALTIME];
+	base->sec = tk->xtime_sec;
+	base->nsec = tk->tkr_mono.xtime_nsec;
+
+	base = &vdata->basetime[CLOCK_MONOTONIC];
+	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec = tk->tkr_mono.xtime_nsec;
+	nsec +=	((u64)tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
+	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+		nsec -= ((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
+		base->sec++;
 	}
+	base->nsec = nsec;
 
-	vdata->wall_time_coarse_sec	= tk->xtime_sec;
-	vdata->wall_time_coarse_nsec	= (long)(tk->tkr_mono.xtime_nsec >>
-						 tk->tkr_mono.shift);
-
-	vdata->monotonic_time_coarse_sec =
-		vdata->wall_time_coarse_sec + tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_coarse_nsec =
-		vdata->wall_time_coarse_nsec + tk->wall_to_monotonic.tv_nsec;
-
-	while (vdata->monotonic_time_coarse_nsec >= NSEC_PER_SEC) {
-		vdata->monotonic_time_coarse_nsec -= NSEC_PER_SEC;
-		vdata->monotonic_time_coarse_sec++;
+	base = &vdata->basetime[CLOCK_REALTIME_COARSE];
+	base->sec = tk->xtime_sec;
+	base->nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+
+	base = &vdata->basetime[CLOCK_MONOTONIC_COARSE];
+	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec += tk->wall_to_monotonic.tv_nsec;
+	while (nsec >= NSEC_PER_SEC) {
+		nsec -= NSEC_PER_SEC;
+		base->sec++;
 	}
+	base->nsec = nsec;
 
 	gtod_write_end(vdata);
 }
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -5,33 +5,37 @@
 #include <linux/compiler.h>
 #include <linux/clocksource.h>
 
+#include <uapi/linux/time.h>
+
 #ifdef BUILD_VDSO32_64
 typedef u64 gtod_long_t;
 #else
 typedef unsigned long gtod_long_t;
 #endif
+
+struct vgtod_ts {
+	u64		sec;
+	u64		nsec;
+};
+
+#define VGTOD_BASES	(CLOCK_MONOTONIC_COARSE + 1)
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC))
+#define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
+
 /*
  * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
  * so be carefull by modifying this structure.
  */
 struct vsyscall_gtod_data {
-	unsigned int seq;
+	unsigned int	seq;
+
+	int		vclock_mode;
+	u64		cycle_last;
+	u64		mask;
+	u32		mult;
+	u32		shift;
 
-	int	vclock_mode;
-	u64	cycle_last;
-	u64	mask;
-	u32	mult;
-	u32	shift;
-
-	/* open coded 'struct timespec' */
-	u64		wall_time_snsec;
-	gtod_long_t	wall_time_sec;
-	gtod_long_t	monotonic_time_sec;
-	u64		monotonic_time_snsec;
-	gtod_long_t	wall_time_coarse_sec;
-	gtod_long_t	wall_time_coarse_nsec;
-	gtod_long_t	monotonic_time_coarse_sec;
-	gtod_long_t	monotonic_time_coarse_nsec;
+	struct vgtod_ts	basetime[VGTOD_BASES];
 
 	int		tz_minuteswest;
 	int		tz_dsttime;
