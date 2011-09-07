From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH 23/62] x86: irq: Remove IRQF_DISABLED
Date: Wed,  7 Sep 2011 16:10:20 +0800
Message-ID: <1315383059-3673-24-git-send-email-yong.zhang0@gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Don Zickus <dzickus@redhat.com>, "Venkatesh Pallipadi (Venki)" <venki@google.com>, Andy Lutomirski <luto@mit.edu>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, virtualization@lists.linux-foundation.org, Yong Zhang <yong.zhang0@gmail.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xensource.com, tglx@linutronix.de, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This flag is a NOOP and can be removed now.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/x86/include/asm/floppy.h |    4 ++--
 arch/x86/kernel/hpet.c        |    2 +-
 arch/x86/kernel/time.c        |    2 +-
 arch/x86/xen/smp.c            |    8 ++++----
 arch/x86/xen/spinlock.c       |    2 +-
 arch/x86/xen/time.c           |    5 ++---
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/floppy.h b/arch/x86/include/asm/floppy.h
index dbe82a5..22bf4d6 100644
--- a/arch/x86/include/asm/floppy.h
+++ b/arch/x86/include/asm/floppy.h
@@ -145,10 +145,10 @@ static int fd_request_irq(void)
 {
 	if (can_use_virtual_dma)
 		return request_irq(FLOPPY_IRQ, floppy_hardint,
-				   IRQF_DISABLED, "floppy", NULL);
+				   0, "floppy", NULL);
 	else
 		return request_irq(FLOPPY_IRQ, floppy_interrupt,
-				   IRQF_DISABLED, "floppy", NULL);
+				   0, "floppy", NULL);
 }
 
 static unsigned long dma_mem_alloc(unsigned long size)
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 4aecc54..9d96096 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -515,7 +515,7 @@ static int hpet_setup_irq(struct hpet_dev *dev)
 {
 
 	if (request_irq(dev->irq, hpet_interrupt_handler,
-			IRQF_TIMER | IRQF_DISABLED | IRQF_NOBALANCING,
+			IRQF_TIMER | IRQF_NOBALANCING,
 			dev->name, dev))
 		return -1;
 
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 5a64d05..e62386a 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -70,7 +70,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction irq0  = {
 	.handler = timer_interrupt,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER,
+	.flags = IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER,
 	.name = "timer"
 };
 
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index e79dbb9..b20b94d 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -99,7 +99,7 @@ static int xen_smp_intr_init(unsigned int cpu)
 	rc = bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
 				    cpu,
 				    xen_reschedule_interrupt,
-				    IRQF_DISABLED|IRQF_PERCPU|IRQF_NOBALANCING,
+				    IRQF_PERCPU|IRQF_NOBALANCING,
 				    resched_name,
 				    NULL);
 	if (rc < 0)
@@ -110,7 +110,7 @@ static int xen_smp_intr_init(unsigned int cpu)
 	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_VECTOR,
 				    cpu,
 				    xen_call_function_interrupt,
-				    IRQF_DISABLED|IRQF_PERCPU|IRQF_NOBALANCING,
+				    IRQF_PERCPU|IRQF_NOBALANCING,
 				    callfunc_name,
 				    NULL);
 	if (rc < 0)
@@ -119,7 +119,7 @@ static int xen_smp_intr_init(unsigned int cpu)
 
 	debug_name = kasprintf(GFP_KERNEL, "debug%d", cpu);
 	rc = bind_virq_to_irqhandler(VIRQ_DEBUG, cpu, xen_debug_interrupt,
-				     IRQF_DISABLED | IRQF_PERCPU | IRQF_NOBALANCING,
+				     IRQF_PERCPU | IRQF_NOBALANCING,
 				     debug_name, NULL);
 	if (rc < 0)
 		goto fail;
@@ -129,7 +129,7 @@ static int xen_smp_intr_init(unsigned int cpu)
 	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
 				    cpu,
 				    xen_call_function_single_interrupt,
-				    IRQF_DISABLED|IRQF_PERCPU|IRQF_NOBALANCING,
+				    IRQF_PERCPU|IRQF_NOBALANCING,
 				    callfunc_name,
 				    NULL);
 	if (rc < 0)
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index cc9b1e1..27882f5 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -354,7 +354,7 @@ void __cpuinit xen_init_lock_cpu(int cpu)
 	irq = bind_ipi_to_irqhandler(XEN_SPIN_UNLOCK_VECTOR,
 				     cpu,
 				     dummy_handler,
-				     IRQF_DISABLED|IRQF_PERCPU|IRQF_NOBALANCING,
+				     IRQF_PERCPU|IRQF_NOBALANCING,
 				     name,
 				     NULL);
 
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 5158c50..f164ccc 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -393,9 +393,8 @@ void xen_setup_timer(int cpu)
 		name = "<timer kasprintf failed>";
 
 	irq = bind_virq_to_irqhandler(VIRQ_TIMER, cpu, xen_timer_interrupt,
-				      IRQF_DISABLED|IRQF_PERCPU|
-				      IRQF_NOBALANCING|IRQF_TIMER|
-				      IRQF_FORCE_RESUME,
+				      IRQF_PERCPU|IRQF_NOBALANCING|
+				      IRQF_TIMER|IRQF_FORCE_RESUME,
 				      name, NULL);
 
 	evt = &per_cpu(xen_clock_events, cpu);
-- 
1.7.4.1
