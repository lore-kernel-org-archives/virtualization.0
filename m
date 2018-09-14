From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 08/11] x86/vdso: Replace the clockid switch case
Date: Fri, 14 Sep 2018 14:50:14 +0200
Message-ID: <20180914125118.827005379__38742.5119210549$1536930040$gmane$org@linutronix.de>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=x86-vdso--Replace-the-clockid-switch-case.patch
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

Now that the time getter functions use the clockid as index into the
storage array for the base time access, the switch case can be replaced.

- Check for clockid >= MAX_CLOCKS and for negative clockid (CPU/FD) first
  and call the fallback function right away.

- After establishing that clockid is < MAX_CLOCKS, convert the clockid to a
  bitmask

- Check for the supported high resolution and coarse functions by anding
  the bitmask of supported clocks and check whether a bit is set.

This completely avoids jump tables, reduces the number of conditionals and
makes the VDSO extensible for other clock ids.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   38 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -239,29 +239,27 @@ notrace static void do_coarse(clockid_t
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
-	switch (clock) {
-	case CLOCK_REALTIME:
-		if (do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE)
-			goto fallback;
-		break;
-	case CLOCK_MONOTONIC:
-		if (do_hres(CLOCK_MONOTONIC, ts) == VCLOCK_NONE)
-			goto fallback;
-		break;
-	case CLOCK_REALTIME_COARSE:
-		do_coarse(CLOCK_REALTIME_COARSE, ts);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		do_coarse(CLOCK_MONOTONIC_COARSE, ts);
-		break;
-	default:
-		goto fallback;
-	}
+	unsigned int msk;
+
+	/* Sort out negative (CPU/FD) and invalid clocks */
+	if (unlikely((unsigned int) clock >= MAX_CLOCKS))
+		return vdso_fallback_gettime(clock, ts);
 
-	return 0;
-fallback:
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (likely(msk & VGTOD_HRES)) {
+		if (do_hres(clock, ts) != VCLOCK_NONE)
+			return 0;
+	} else if (msk & VGTOD_COARSE) {
+		do_coarse(clock, ts);
+		return 0;
+	}
 	return vdso_fallback_gettime(clock, ts);
 }
+
 int clock_gettime(clockid_t, struct timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
