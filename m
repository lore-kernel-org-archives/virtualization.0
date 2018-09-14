From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 04/11] x86/vdso: Use unsigned int consistently for
	vsyscall_gtod_data::seq
Date: Fri, 14 Sep 2018 14:50:10 +0200
Message-ID: <20180914125118.457665349__16121.8861271211$1536929571$gmane$org@linutronix.de>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=x86-vdso--Mintor-cleanups.patch
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

The sequence count in vgtod_data is unsigned int, but the call sites use
unsigned long, which is a pointless exercise. Fix the call sites and
replace 'unsigned' with unsinged 'int' while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |    8 ++++----
 arch/x86/include/asm/vgtod.h         |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -206,7 +206,7 @@ notrace static inline u64 vgetsns(int *m
 /* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
 notrace static int __always_inline do_realtime(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	u64 ns;
 	int mode;
 
@@ -227,7 +227,7 @@ notrace static int __always_inline do_re
 
 notrace static int __always_inline do_monotonic(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	u64 ns;
 	int mode;
 
@@ -248,7 +248,7 @@ notrace static int __always_inline do_mo
 
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	do {
 		seq = gtod_read_begin(gtod);
 		ts->tv_sec = gtod->wall_time_coarse_sec;
@@ -258,7 +258,7 @@ notrace static void do_realtime_coarse(s
 
 notrace static void do_monotonic_coarse(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	do {
 		seq = gtod_read_begin(gtod);
 		ts->tv_sec = gtod->monotonic_time_coarse_sec;
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -15,9 +15,9 @@ typedef unsigned long gtod_long_t;
  * so be carefull by modifying this structure.
  */
 struct vsyscall_gtod_data {
-	unsigned seq;
+	unsigned int seq;
 
-	int vclock_mode;
+	int	vclock_mode;
 	u64	cycle_last;
 	u64	mask;
 	u32	mult;
@@ -44,9 +44,9 @@ static inline bool vclock_was_used(int v
 	return READ_ONCE(vclocks_used) & (1 << vclock);
 }
 
-static inline unsigned gtod_read_begin(const struct vsyscall_gtod_data *s)
+static inline unsigned int gtod_read_begin(const struct vsyscall_gtod_data *s)
 {
-	unsigned ret;
+	unsigned int ret;
 
 repeat:
 	ret = READ_ONCE(s->seq);
@@ -59,7 +59,7 @@ static inline unsigned gtod_read_begin(c
 }
 
 static inline int gtod_read_retry(const struct vsyscall_gtod_data *s,
-					unsigned start)
+				  unsigned int start)
 {
 	smp_rmb();
 	return unlikely(s->seq != start);
