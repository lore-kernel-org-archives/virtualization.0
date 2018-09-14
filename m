From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/11] x86/vdso: Collapse coarse functions
Date: Fri, 14 Sep 2018 14:50:13 +0200
Message-ID: <20180914125118.742125147__42400.5590066828$1536929703$gmane$org@linutronix.de>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=x86-vdso--Collapse-coarse-functions.patch
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

do_realtime_coarse() and do_monotonic_coarse() are now the same except for
the storage array index. Hand the index in as an argument and collapse the
functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -225,21 +225,9 @@ notrace static int do_hres(clockid_t clk
 	return mode;
 }
 
-notrace static void do_realtime_coarse(struct timespec *ts)
+notrace static void do_coarse(clockid_t clk, struct timespec *ts)
 {
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME_COARSE];
-	unsigned int seq;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		ts->tv_sec = base->sec;
-		ts->tv_nsec = base->nsec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-}
-
-notrace static void do_monotonic_coarse(struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC_COARSE];
+	struct vgtod_ts *base = &gtod->basetime[clk];
 	unsigned int seq;
 
 	do {
@@ -261,10 +249,10 @@ notrace int __vdso_clock_gettime(clockid
 			goto fallback;
 		break;
 	case CLOCK_REALTIME_COARSE:
-		do_realtime_coarse(ts);
+		do_coarse(CLOCK_REALTIME_COARSE, ts);
 		break;
 	case CLOCK_MONOTONIC_COARSE:
-		do_monotonic_coarse(ts);
+		do_coarse(CLOCK_MONOTONIC_COARSE, ts);
 		break;
 	default:
 		goto fallback;
