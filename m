From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/2] lguest: handle dodgy/non-existent TSC.  Host code.
Date: Wed, 04 Jul 2007 16:19:32 +1000
Message-ID: <1183529972.6005.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, Matt Mackall <mpm@selenic.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Lguest currently requires a TSC, which breaks older machines and Matt
Mackall who boots the host with "notsc".  In addition, there is no
good solution to changing TSC speeds (informing all the guests about
the TSC impending change before it happens would be a great deal of
code and have issues with disobedient guests).

This patch makes the host determine if the TSC is both constant and
stable: if not, it doesn't tell the guest to use it.  We export
check_tsc_unstable() for this.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/i386/kernel/tsc.c      |    3 ++-
 drivers/lguest/core.c       |    8 --------
 drivers/lguest/hypercalls.c |    9 +++++++++
 include/asm-i386/tsc.h      |    1 +
 4 files changed, 12 insertions(+), 9 deletions(-)

===================================================================
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -59,10 +59,11 @@ __setup("notsc", tsc_setup);
  */
 static int tsc_unstable;
 
-static inline int check_tsc_unstable(void)
+int check_tsc_unstable(void)
 {
 	return tsc_unstable;
 }
+EXPORT_SYMBOL_GPL(check_tsc_unstable);
 
 unsigned long native_calculate_cpu_khz(void)
 {
===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -332,14 +332,6 @@ int run_guest(struct lguest *lg, unsigne
 			continue;
 		}
 
-		/* If the Guest hasn't been told the clock multiplier to use or
-		 * it's changed, we update it here. */
-		if (unlikely(lg->tsc_khz != tsc_khz) && lg->lguest_data) {
-			lg->tsc_khz = tsc_khz;
-			if (put_user(lg->tsc_khz, &lg->lguest_data->tsc_khz))
-				return -EFAULT;
-		}
-
 		local_irq_disable();
 
 		/* Even if *we* don't want FPU trap, guest might... */
===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -132,11 +132,19 @@ static void do_async_hcalls(struct lgues
 
 static void initialize(struct lguest *lg)
 {
+	u32 tsc_speed;
+
 	if (lg->regs->eax != LHCALL_LGUEST_INIT) {
 		kill_guest(lg, "hypercall %li before LGUEST_INIT",
 			   lg->regs->eax);
 		return;
 	}
+
+	/* We only tell the guest to use the TSC if it's reliable. */
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) && !check_tsc_unstable())
+		tsc_speed = tsc_khz;
+	else
+		tsc_speed = 0;
 
 	lg->lguest_data = (struct lguest_data __user *)lg->regs->edx;
 	/* We check here so we can simply copy_to_user/from_user */
@@ -148,6 +156,7 @@ static void initialize(struct lguest *lg
 	    || get_user(lg->noirq_end, &lg->lguest_data->noirq_end)
 	    /* We reserve the top pgd entry. */
 	    || put_user(4U*1024*1024, &lg->lguest_data->reserve_mem)
+	    || put_user(tsc_speed, &lg->lguest_data->tsc_khz)
 	    || put_user(lg->guestid, &lg->lguest_data->guestid))
 		kill_guest(lg, "bad guest page %p", lg->lguest_data);
 
===================================================================
--- a/include/asm-i386/tsc.h
+++ b/include/asm-i386/tsc.h
@@ -63,6 +63,7 @@ extern void mark_tsc_unstable(char *reas
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern void init_tsc_clocksource(void);
+int check_tsc_unstable(void);
 
 /*
  * Boot-time check whether the TSCs are synchronized across
