From: rusty@rustcorp.com.au
Subject: [patch 22/43] lguest: Introduce "hcall" pointer to indicate pending
	hypercall.
Date: Wed, 26 Sep 2007 16:36:40 +1000
Message-ID: <20070926063649.100793106@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=hcall-as-ptr.diff
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently we look at the "trapnum" to see if the Guest wants a
hypercall.  But once the hypercall is done we have to reset trapnum to
a bogus value, otherwise if we exit to userspace and return, we'd run
the same hypercall twice (that was a nasty bug to find!).

This has two main effects:

1) When Jes's patch changes the hypercall args to be a generic "struct
   hcall_args" we simply change the type of "lg->hcall".  It's set by
   arch code, so if it has to copy args or something it can do so, and
   point "hcall" into lg->arch somewhere.

2) Async hypercalls only get run when an actual hypercall is pending.
   This simplfies the code a little and is a more logical semantic.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 drivers/lguest/core.c       |    8 +++----
 drivers/lguest/hypercalls.c |   48 +++++++++++++++++--------------------------
 drivers/lguest/i386_core.c  |   13 ++++++-----
 drivers/lguest/lg.h         |    3 ++
 4 files changed, 34 insertions(+), 38 deletions(-)

===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -198,10 +198,10 @@ int run_guest(struct lguest *lg, unsigne
 {
 	/* We stop running once the Guest is dead. */
 	while (!lg->dead) {
-		/* First we run any hypercalls the Guest wants done: either in
-		 * the hypercall ring in "struct lguest_data", or directly by
-		 * using int 31 (LGUEST_TRAP_ENTRY). */
-		do_hypercalls(lg);
+		/* First we run any hypercalls the Guest wants done. */
+		if (lg->hcall)
+			do_hypercalls(lg);
+
 		/* It's possible the Guest did a SEND_DMA hypercall to the
 		 * Launcher, in which case we return from the read() now. */
 		if (lg->dma_is_pending) {
===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -246,19 +246,6 @@ static void initialize(struct lguest *lg
  * is one other way we can do things for the Guest, as we see in
  * emulate_insn(). */
 
-/*H:110 Tricky point: we mark the hypercall as "done" once we've done it.
- * Normally we don't need to do this: the Guest will run again and update the
- * trap number before we come back around the run_guest() loop to
- * do_hypercalls().
- *
- * However, if we are signalled or the Guest sends DMA to the Launcher, that
- * loop will exit without running the Guest.  When it comes back it would try
- * to re-run the hypercall. */
-static void clear_hcall(struct lguest *lg)
-{
-	lg->regs->trapnum = 255;
-}
-
 /*H:100
  * Hypercalls
  *
@@ -267,16 +254,12 @@ static void clear_hcall(struct lguest *l
  */
 void do_hypercalls(struct lguest *lg)
 {
-	/* Not initialized yet? */
+	/* Not initialized yet?  This hypercall must do it. */
 	if (unlikely(!lg->lguest_data)) {
-		/* Did the Guest make a hypercall?  We might have come back for
-		 * some other reason (an interrupt, a different trap). */
-		if (lg->regs->trapnum == LGUEST_TRAP_ENTRY) {
-			/* Set up the "struct lguest_data" */
-			initialize(lg);
-			/* The hypercall is done. */
-			clear_hcall(lg);
-		}
+		/* Set up the "struct lguest_data" */
+		initialize(lg);
+		/* Hcall is done. */
+		lg->hcall = NULL;
 		return;
 	}
 
@@ -286,12 +269,21 @@ void do_hypercalls(struct lguest *lg)
 	do_async_hcalls(lg);
 
 	/* If we stopped reading the hypercall ring because the Guest did a
-	 * SEND_DMA to the Launcher, we want to return now.  Otherwise if the
-	 * Guest asked us to do a hypercall, we do it. */
-	if (!lg->dma_is_pending && lg->regs->trapnum == LGUEST_TRAP_ENTRY) {
-		do_hcall(lg, lg->regs);
-		/* The hypercall is done. */
-		clear_hcall(lg);
+	 * SEND_DMA to the Launcher, we want to return now.  Otherwise we do
+	 * the hypercall. */
+	if (!lg->dma_is_pending) {
+		do_hcall(lg, lg->hcall);
+		/* Tricky point: we reset the hcall pointer to mark the
+		 * hypercall as "done".  We use the hcall pointer rather than
+		 * the trap number to indicate a hypercall is pending.
+		 * Normally it doesn't matter: the Guest will run again and
+		 * update the trap number before we come back here.
+		 *
+		 * However, if we are signalled or the Guest sends DMA to the
+		 * Launcher, the run_guest() loop will exit without running the
+		 * Guest.  When it comes back it would try to re-run the
+		 * hypercall. */
+		lg->hcall = NULL;
 	}
 }
 
===================================================================
--- a/drivers/lguest/i386_core.c
+++ b/drivers/lguest/i386_core.c
@@ -316,13 +316,14 @@ void lguest_arch_handle_trap(struct lgue
 			return;
 		break;
 	case 32 ... 255:
-		/* These values mean a real interrupt occurred, in
-		 * which case the Host handler has already been run.
-		 * We just do a friendly check if another process
-		 * should now be run, then fall through to loop
-		 * around: */
+		/* These values mean a real interrupt occurred, in which case
+		 * the Host handler has already been run.  We just do a
+		 * friendly check if another process should now be run, then
+		 * return to run the Guest again */
 		cond_resched();
-	case LGUEST_TRAP_ENTRY: /* Handled before re-entering Guest */
+		return;
+	case LGUEST_TRAP_ENTRY:
+		lg->hcall = lg->regs;
 		return;
 	}
 
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -111,6 +111,9 @@ struct lguest
 	u32 esp1;
 	u8 ss1;
 
+	/* If a hypercall was asked for, this points to the arguments. */
+	struct lguest_regs *hcall;
+
 	/* Do we need to stop what we're doing and return to userspace? */
 	int break_out;
 	wait_queue_head_t break_wq;

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
