From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH] use NR_IRQS for irq count
Date: Tue,  8 Apr 2008 14:04:36 -0300
Message-ID: <12076742761764-git-send-email-gcosta@redhat.com>
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
To: kvm-devel@lists.sourceforge.net
Cc: Glauber Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Instead of artificially limiting irq numbers, use arch provided NR_IRQS

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 irqhook/irqhook_main.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/irqhook/irqhook_main.c b/irqhook/irqhook_main.c
index 5f414d1..828c70a 100644
--- a/irqhook/irqhook_main.c
+++ b/irqhook/irqhook_main.c
@@ -31,15 +31,13 @@ #define ERROR(fmt, args...) printk("<1>"
 static spinlock_t irqh_lock;
 static wait_queue_head_t irqh_proc_list;
 
-enum {NINTR = 256};
-
-static DECLARE_BITMAP(pending, NINTR);
-static DECLARE_BITMAP(handled, NINTR);
+static DECLARE_BITMAP(pending, NR_IRQS);
+static DECLARE_BITMAP(handled, NR_IRQS);
 
 #define irqh_on(which, bit)	test_bit(bit, which)
 #define irqh_set(which, bit)	set_bit(bit, which)
 #define irqh_clear(which, bit)	clear_bit(bit, which)
-#define irqh_ffs(which)		find_first_bit(which, NINTR)
+#define irqh_ffs(which)		find_first_bit(which, NR_IRQS)
 
 static irqreturn_t
 irqh_interrupt(int irq, void *p)
@@ -92,7 +90,7 @@ irqh_dev_write(struct file *fp, const ch
 		if (pdp) {
 			if (pci_enable_device(pdp))
 				ERROR("device not enabled\n");
-			if ((unsigned)(n = pdp->irq) >= NINTR) {
+			if ((unsigned)(n = pdp->irq) >= NR_IRQS) {
 				ERROR("device has invalid IRQ set\n");
 				return -EINVAL;
 			}
@@ -107,7 +105,7 @@ irqh_dev_write(struct file *fp, const ch
 		irqh_set(handled, n);
 		goto done;
 	}
-	if ((unsigned)n >= NINTR)
+	if ((unsigned)n >= NR_IRQS)
 		return -EINVAL;
 	if (arg[0] == '-') {
 		if (pdp)
@@ -135,7 +133,7 @@ irqh_dev_read(struct file *fp, char *buf
 		return -EINVAL;
 	spin_lock_irq(&irqh_lock);
 	while (!signal_pending(current)) {
-		if ((n = irqh_ffs(pending)) < NINTR) {
+		if ((n = irqh_ffs(pending)) < NR_IRQS) {
 			if ((m = sprintf(b, "%d", n) + 1) > size)
 				m = size;
 			if (copy_to_user(buf, b, m))
@@ -203,7 +201,7 @@ irqh_cleanup(void)
 
 	DPRINTK("ENTER\n");
 	
-	while ((n = irqh_ffs(handled)) < NINTR) {
+	while ((n = irqh_ffs(handled)) < NR_IRQS) {
 		irqh_clear(handled, n);
 		free_irq(n, (void *)irqh_interrupt);
 	}
-- 
1.4.2
