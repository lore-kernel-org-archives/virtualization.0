From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/3] lguest: fix sense if IF flag on interrupt injection
Date: Fri, 20 Jul 2007 22:11:13 +1000
Message-ID: <1184933473.10380.296.camel__5429.46150894767$1184933808$gmane$org@localhost.localdomain>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The sense of the IF bit is backwards in the host interrupt handling.

This means we always save "IF=1" on the stack when injecting an
interrupt.  It turns out this is almost always correct (unless the
guest is taking a page fault in an interrupt due to an unpopulated
vmalloc mapping), so went unnoticed.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/interrupts_and_traps.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -r 209f5cd5cda5 drivers/lguest/interrupts_and_traps.c
--- a/drivers/lguest/interrupts_and_traps.c	Fri Jul 20 14:53:40 2007 +1000
+++ b/drivers/lguest/interrupts_and_traps.c	Fri Jul 20 21:34:06 2007 +1000
@@ -38,12 +38,12 @@ static void set_guest_interrupt(struct l
 		ss = lg->regs->ss;
 	}
 
-	/* We use IF bit in eflags to indicate whether irqs were disabled
-	   (it's always 0, since irqs are enabled when guest is running). */
+	/* We use IF bit in eflags to indicate whether irqs were enabled
+	   (it's always 1, since irqs are enabled when guest is running). */
 	eflags = lg->regs->eflags;
-	if (get_user(irq_enable, &lg->lguest_data->irq_enabled))
-		irq_enable = 0;
-	eflags |= (irq_enable & X86_EFLAGS_IF);
+	if (get_user(irq_enable, &lg->lguest_data->irq_enabled) == 0
+	    && !(irq_enable & X86_EFLAGS_IF))
+		eflags &= ~X86_EFLAGS_IF;
 
 	push_guest_stack(lg, &gstack, eflags);
 	push_guest_stack(lg, &gstack, lg->regs->cs);
