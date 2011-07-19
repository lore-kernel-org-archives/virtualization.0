From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] drivers/virt: add missing linux/interrupt.h to
	fsl_hypervisor.c
Date: Tue, 19 Jul 2011 15:45:51 -0500
Message-ID: <1311108351-3056-1-git-send-email-timur@freescale.com>
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
To: kumar.gala@freescale.com, linuxppc-dev@linux.freescale.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

fsl_hypervisor.c calls request_irq() but does not include linux/interrupt.h.
Normally, the driver will compile without error, but it can fail on some
configurations.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/virt/fsl_hypervisor.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 1d3b8eb..3d91621 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -37,6 +37,7 @@
 #include <linux/reboot.h>
 #include <linux/uaccess.h>
 #include <linux/notifier.h>
+#include <linux/interrupt.h>
 
 #include <linux/io.h>
 #include <asm/fsl_hcalls.h>
-- 
1.7.3.4
