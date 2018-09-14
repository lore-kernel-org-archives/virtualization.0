From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 11/11] x66/vdso: Add CLOCK_TAI support
Date: Fri, 14 Sep 2018 14:50:17 +0200
Message-ID: <20180914125119.081037164__18629.1604921736$1536930210$gmane$org@linutronix.de>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=x66-vdso--Add-CLOCK_TAI-support.patch
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

With the storage array in place it's now trivial to support CLOCK_TAI in
the vdso. Instead of extending the array to accomodate CLOCK_TAI, make use
of the fact that:

 - CLOCK ids are set in stone
 - CLOCK_THREAD_CPUTIME is never going to be supported in the VDSO so
   the array slot 3 is unused
 - CLOCK_TAI is id 11 which results in 3 when masked with 0x3

Add the mask to the basetime array lookup and set up the CLOCK_TAI base
time in update_vsyscall().

The performance impact of the mask operation is within the noise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c    |    2 +-
 arch/x86/entry/vsyscall/vsyscall_gtod.c |    4 ++++
 arch/x86/include/asm/vgtod.h            |    6 +++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -140,7 +140,7 @@ notrace static inline u64 vgetcyc(int mo
 
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
+	struct vgtod_ts *base = &gtod->basetime[clk & VGTOD_HRES_MASK];
 	u64 cycles, last, ns;
 	unsigned int seq;
 
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -51,6 +51,10 @@ void update_vsyscall(struct timekeeper *
 	base->sec = tk->xtime_sec;
 	base->nsec = tk->tkr_mono.xtime_nsec;
 
+	base = &vdata->basetime[VGTOD_TAI];
+	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
+	base->nsec = tk->tkr_mono.xtime_nsec;
+
 	base = &vdata->basetime[CLOCK_MONOTONIC];
 	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec = tk->tkr_mono.xtime_nsec;
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -19,9 +19,13 @@ struct vgtod_ts {
 };
 
 #define VGTOD_BASES	(CLOCK_MONOTONIC_COARSE + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC))
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
 #define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
 
+/* Abuse CLOCK_THREAD_CPUTIME_ID for VGTOD CLOCK TAI */
+#define VGTOD_HRES_MASK	0x3
+#define VGTOD_TAI	(CLOCK_TAI & VGTOD_HRES_MASK)
+
 /*
  * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
  * so be carefull by modifying this structure.
