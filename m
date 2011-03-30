From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] xen: events: fix error checks in bind_*_to_irqhandler()
Date: Wed, 30 Mar 2011 21:14:26 +0200
Message-ID: <20110330211426.13f182d6__38568.408546462$1301516960$gmane$org@absol.kitzblitz>
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
To: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Cc: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Checking 'irq < 0' doesn't work when 'irq' is unsigned.

The assigned bind_evtchn_to_irq() and bind_virq_to_irq()
return int, so using int appears appropriate.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 drivers/xen/events.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index 036343b..589f0a5 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -912,8 +912,7 @@ int bind_evtchn_to_irqhandler(unsigned int evtchn,
 			      unsigned long irqflags,
 			      const char *devname, void *dev_id)
 {
-	unsigned int irq;
-	int retval;
+	int irq, retval;
 
 	irq = bind_evtchn_to_irq(evtchn);
 	if (irq < 0)
@@ -955,8 +954,7 @@ int bind_virq_to_irqhandler(unsigned int virq, unsigned int cpu,
 			    irq_handler_t handler,
 			    unsigned long irqflags, const char *devname, void *dev_id)
 {
-	unsigned int irq;
-	int retval;
+	int irq, retval;
 
 	irq = bind_virq_to_irq(virq, cpu);
 	if (irq < 0)
-- 
1.7.3.4
