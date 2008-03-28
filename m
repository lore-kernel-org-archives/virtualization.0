From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 08/12] xen: add resend_irq_on_evtchn() definition into
	events.c.
Date: Fri, 28 Mar 2008 20:40:14 +0900
Message-ID: <1206704418876-git-send-email-yamahata__47814.1240928837$1206705227$gmane$org@valinux.co.jp>
References: <12067044183207-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12067044183207-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jeremy@goop.org
Cc: eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Define resend_irq_on_evtchn() which ia64/xen uses.
Although it isn't used by current x86/xen code, it's arch generic
so that put it into common code.
make ipi_to_irq[] visible removing static because
ia64/xen needs to access the variable from ia64 specific code

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 drivers/xen/events.c |   18 +++++++++++++++++-
 include/xen/events.h |    1 +
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index 2396b44..1c2c193 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -48,7 +48,7 @@ static DEFINE_SPINLOCK(irq_mapping_update_lock);
 static DEFINE_PER_CPU(int, virq_to_irq[NR_VIRQS]) = {[0 ... NR_VIRQS-1] = -1};
 
 /* IRQ <-> IPI mapping */
-static DEFINE_PER_CPU(int, ipi_to_irq[XEN_NR_IPIS]) = {[0 ... XEN_NR_IPIS-1] = -1};
+DEFINE_PER_CPU(int, ipi_to_irq[XEN_NR_IPIS]) = {[0 ... XEN_NR_IPIS-1] = -1};
 
 /* Packed IRQ information: binding type, sub-type index, and event channel. */
 struct packed_irq
@@ -586,6 +586,22 @@ static void set_affinity_irq(unsigned irq, cpumask_t dest)
 	rebind_irq_to_cpu(irq, tcpu);
 }
 
+int resend_irq_on_evtchn(unsigned int irq)
+{
+	int masked, evtchn = evtchn_from_irq(irq);
+	struct shared_info *s = HYPERVISOR_shared_info;
+
+	if (!VALID_EVTCHN(evtchn))
+		return 1;
+
+	masked = sync_test_and_set_bit(evtchn, s->evtchn_mask);
+	sync_set_bit(evtchn, s->evtchn_pending);
+	if (!masked)
+		unmask_evtchn(evtchn);
+
+	return 1;
+}
+
 static void enable_dynirq(unsigned int irq)
 {
 	int evtchn = evtchn_from_irq(irq);
diff --git a/include/xen/events.h b/include/xen/events.h
index 2bde54d..574cfa4 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -37,6 +37,7 @@ int bind_ipi_to_irqhandler(enum ipi_vector ipi,
 void unbind_from_irqhandler(unsigned int irq, void *dev_id);
 
 void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector);
+int resend_irq_on_evtchn(unsigned int irq);
 
 static inline void notify_remote_via_evtchn(int port)
 {
-- 
1.5.3
