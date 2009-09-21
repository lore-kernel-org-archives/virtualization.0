From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/5] lguest: move panic notifier registration to its expected
	place.
Date: Mon, 21 Sep 2009 16:52:21 +0930
Message-ID: <200909210723.n8L7NnM9022126@smtp1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: virtualization@lists.osdl.org
Cc: lguest@ozlabs.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


We used to defer it, so lockdep was happy.  We now init lockdep early
anyway, so just do it after that.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/x86/lguest/boot.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1135,11 +1135,6 @@ static struct notifier_block paniced = {
 /* Setting up memory is fairly easy. */
 static __init char *lguest_memory_setup(void)
 {
-	/* We do this here and not earlier because lockcheck used to barf if we
-	 * did it before start_kernel().  I think we fixed that, so it'd be
-	 * nice to move it back to lguest_init.  Patch welcome... */
-	atomic_notifier_chain_register(&panic_notifier_list, &paniced);
-
 	/*
 	 *The Linux bootloader header contains an "e820" memory map: the
 	 * Launcher populated the first entry with our memory limit.
@@ -1365,10 +1360,13 @@ __init void lguest_init(void)
 
 	/*
 	 * If we don't initialize the lock dependency checker now, it crashes
-	 * paravirt_disable_iospace.
+	 * atomic_notifier_chain_register, then paravirt_disable_iospace.
 	 */
 	lockdep_init();
 
+	/* Hook in our special panic hypercall code. */
+	atomic_notifier_chain_register(&panic_notifier_list, &paniced);
+
 	/*
 	 * The IDE code spends about 3 seconds probing for disks: if we reserve
 	 * all the I/O ports up front it can't get them and so doesn't probe.
