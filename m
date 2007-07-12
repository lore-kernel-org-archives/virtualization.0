From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] lguest: disable SYSENTER for guests
Date: Thu, 12 Jul 2007 17:16:35 +1000
Message-ID: <1184224595.6005.772.camel__20497.8656526238$1184224730$gmane$org@localhost.localdomain>
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
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The SYSENTER instruction jumps to a pre-programmed address at
privilege level 0.  We must not allow execution of guest code at that
privilege level, so disable sysenter when we enter the guest (and
re-enable it on return).  This fixes current case where guest
userspace can crash host.

This save/restore adds 3% to guest context switch times.  (If only
there were some kind of scheduler hook or something which would tell
us when we were being preempted so we could fix this up lazily.  But
what kind of daredevil coder would propose such a thing?)

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -338,6 +338,10 @@ int run_guest(struct lguest *lg, unsigne
 		if (lg->ts)
 			set_ts();
 
+		/* Don't let Guest do SYSENTER: we can't handle it. */
+		if (boot_cpu_has(X86_FEATURE_SEP))
+			wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);
+
 		run_guest_once(lg, lguest_pages(raw_smp_processor_id()));
 
 		/* Save cr2 now if we page-faulted. */
@@ -345,6 +349,9 @@ int run_guest(struct lguest *lg, unsigne
 			cr2 = read_cr2();
 		else if (lg->regs->trapnum == 7)
 			math_state_restore();
+
+		if (boot_cpu_has(X86_FEATURE_SEP))
+			wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 		local_irq_enable();
 
 		switch (lg->regs->trapnum) {
