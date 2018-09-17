From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 11/11] x66/vdso: Add CLOCK_TAI support
Date: Mon, 17 Sep 2018 14:45:44 +0200
Message-ID: <20180917130707.823878601__43996.0384196185$1537190469$gmane$org@linutronix.de>
References: <20180917124533.329334911@linutronix.de>
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
the vdso. Extend the base time storage array and add the update code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---

V2: Remove the masking trick

 arch/x86/entry/vsyscall/vsyscall_gtod.c |    4 ++++
 arch/x86/include/asm/vgtod.h            |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -51,6 +51,10 @@ void update_vsyscall(struct timekeeper *
 	base->sec = tk->xtime_sec;
 	base->nsec = tk->tkr_mono.xtime_nsec;
 
+	base = &vdata->basetime[CLOCK_TAI];
+	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
+	base->nsec = tk->tkr_mono.xtime_nsec;
+
 	base = &vdata->basetime[CLOCK_MONOTONIC];
 	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec = tk->tkr_mono.xtime_nsec;
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -18,8 +18,8 @@ struct vgtod_ts {
 	u64		nsec;
 };
 
-#define VGTOD_BASES	(CLOCK_MONOTONIC_COARSE + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC))
+#define VGTOD_BASES	(CLOCK_TAI + 1)
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
 #define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
 
 /*
