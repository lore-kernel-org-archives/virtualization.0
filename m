From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] xen/smp: Remove unnecessary call to smp_processor_id()
Date: Thu, 22 Mar 2012 18:29:24 +0530
Message-ID: <20120322125923.19782.82924.stgit__16893.3206041858$1332476984$gmane$org@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: konrad.wilk@oracle.com, jeremy@goop.org
Cc: xen-devel@lists.xensource.com, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, hpa@zytor.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

There is an extra and unnecessary call to smp_processor_id()
in cpu_bringup(). Remove it.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/xen/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 501d4e0..acfe7a3 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -59,7 +59,7 @@ static irqreturn_t xen_reschedule_interrupt(int irq, void *dev_id)
 
 static void __cpuinit cpu_bringup(void)
 {
-	int cpu = smp_processor_id();
+	int cpu;
 
 	cpu_init();
 	touch_softlockup_watchdog();
