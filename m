From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 06/11] x86/vdso: Collapse high resolution functions
Date: Fri, 14 Sep 2018 14:50:12 +0200
Message-ID: <20180914125118.658760051__15814.2579290599$1536929813$gmane$org@linutronix.de>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=x86-vdso--Collapse-high-res-functions.patch
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

do_realtime() and do_monotonic() are now the same except for the storage
array index. Hand the index in as an argument and collapse the functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -203,35 +203,12 @@ notrace static inline u64 vgetsns(int *m
 	return v * gtod->mult;
 }
 
-/* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
-notrace static int __always_inline do_realtime(struct timespec *ts)
+notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME];
+	struct vgtod_ts *base = &gtod->basetime[clk];
 	unsigned int seq;
-	u64 ns;
 	int mode;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		mode = gtod->vclock_mode;
-		ts->tv_sec = base->sec;
-		ns = base->nsec;
-		ns += vgetsns(&mode);
-		ns >>= gtod->shift;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return mode;
-}
-
-notrace static int __always_inline do_monotonic(struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC];
-	unsigned int seq;
 	u64 ns;
-	int mode;
 
 	do {
 		seq = gtod_read_begin(gtod);
@@ -276,11 +253,11 @@ notrace int __vdso_clock_gettime(clockid
 {
 	switch (clock) {
 	case CLOCK_REALTIME:
-		if (do_realtime(ts) == VCLOCK_NONE)
+		if (do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
 	case CLOCK_MONOTONIC:
-		if (do_monotonic(ts) == VCLOCK_NONE)
+		if (do_hres(CLOCK_MONOTONIC, ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
 	case CLOCK_REALTIME_COARSE:
@@ -303,7 +280,9 @@ int clock_gettime(clockid_t, struct time
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	if (likely(tv != NULL)) {
-		if (unlikely(do_realtime((struct timespec *)tv) == VCLOCK_NONE))
+		struct timespec *ts = (struct timespec *) tv;
+
+		if (unlikely(do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE))
 			return vdso_fallback_gtod(tv, tz);
 		tv->tv_usec /= 1000;
 	}
