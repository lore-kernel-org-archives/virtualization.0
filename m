From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] xen: fix non-ANSI function warning in irq.c
Date: Sat, 8 Jan 2011 20:00:36 -0800
Message-ID: <20110108200036.20ab98c7.randy.dunlap@oracle.com>
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
To: virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sparse warning for non-ANSI function declaration:

arch/x86/xen/irq.c:129:30: warning: non-ANSI function declaration of function 'xen_init_irq_ops'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc:	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
---
 arch/x86/xen/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx0107.orig/arch/x86/xen/irq.c
+++ lnx0107/arch/x86/xen/irq.c
@@ -126,7 +126,7 @@ static const struct pv_irq_ops xen_irq_o
 #endif
 };
 
-void __init xen_init_irq_ops()
+void __init xen_init_irq_ops(void)
 {
 	pv_irq_ops = xen_irq_ops;
 	x86_init.irqs.intr_init = xen_init_IRQ;
