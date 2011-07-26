From: ruslanpisarev@gmail.com
Subject: [PATCH 2/7] Xen: fix whitespaces,
	tabs coding style issue in drivers/xen/events.c
Date: Tue, 26 Jul 2011 14:16:13 +0300
Message-ID: <1311678973-16554-1-git-send-email-ruslan@rpisarev.org.ua>
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
To: jeremy.fitzhardinge@citrix.com
Cc: Ruslan Pisarev <ruslan@rpisarev.org.ua>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ruslan Pisarev <ruslan@rpisarev.org.ua>

This is a patch to the events.c file that fixed up
whitespaces, tabs and braces errors found by the
checkpatch.pl tools.

Signed-off-by: Ruslan Pisarev <ruslan@rpisarev.org.ua>
---
 drivers/xen/events.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index 30df85d..be7c31d 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -85,8 +85,7 @@ enum xen_irq_type {
  *    IPI - IPI vector
  *    EVTCHN -
  */
-struct irq_info
-{
+struct irq_info {
 	struct list_head list;
 	enum xen_irq_type type;	/* type */
 	unsigned irq;
@@ -282,9 +281,9 @@ static inline unsigned long active_evtchns(unsigned int cpu,
 					   struct shared_info *sh,
 					   unsigned int idx)
 {
-	return (sh->evtchn_pending[idx] &
+	return sh->evtchn_pending[idx] &
 		per_cpu(cpu_evtchn_mask, cpu)[idx] &
-		~sh->evtchn_mask[idx]);
+		~sh->evtchn_mask[idx];
 }
 
 static void bind_evtchn_to_cpu(unsigned int chn, unsigned int cpu)
@@ -1157,7 +1156,7 @@ static void __xen_evtchn_do_upcall(void)
 	int cpu = get_cpu();
 	struct shared_info *s = HYPERVISOR_shared_info;
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
- 	unsigned count;
+	unsigned count;
 
 	do {
 		unsigned long pending_words;
-- 
1.7.4.1
