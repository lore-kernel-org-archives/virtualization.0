From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 08/12] xen: add resend_irq_on_evtchn() definition into
	events.c.
Date: Mon, 31 Mar 2008 18:36:22 +0900
Message-ID: <20080331093622.GH17609%yamahata__4858.35186341337$1206956580$gmane$org@valinux.co.jp>
References: <12067044183207-git-send-email-yamahata@valinux.co.jp>
	<1206704418876-git-send-email-yamahata@valinux.co.jp>
	<47ED5542.2060503@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47ED5542.2060503@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 28, 2008 at 01:29:54PM -0700, Jeremy Fitzhardinge wrote:
> Isaku Yamahata wrote:
> >Define resend_irq_on_evtchn() which ia64/xen uses.
> >Although it isn't used by current x86/xen code, it's arch generic
> >so that put it into common code.
> >make ipi_to_irq[] visible removing static because
> >ia64/xen needs to access the variable from ia64 specific code
> >  
> 
> What kind of access?  Would it be better to add some accessor functions?
> 
> If nothing else, it needs to be prefixed with xen_ if it goes non-static.
> 
> (As should resend_irq_on_evtchn(), but I'm less concerned about a name 
> collision.)

After revising code, I found the access to ipi_to_irq[] isn't necessary
by calling xen_send_IPI_one(). so dropped the line.

changes from the previous one.
- dropped ipi_to_irq[] change.


From 0b7806fd86c9dcbcd46946aeefedb7acf8d37451 Mon Sep 17 00:00:00 2001
From: Isaku Yamahata <yamahata@valinux.co.jp>
Date: Mon, 31 Mar 2008 17:45:32 -0700
Subject: [PATCH 008/112] xen: add resend_irq_on_evtchn() definition into events.c.

Define resend_irq_on_evtchn() which ia64/xen uses.
Although it isn't used by current x86/xen code, it's arch generic
so that put it into common code.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 drivers/xen/events.c |   16 ++++++++++++++++
 include/xen/events.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index 2396b44..4f0f22b 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
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
index d99a3e0..acd8e06 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -31,6 +31,7 @@ int bind_ipi_to_irqhandler(enum ipi_vector ipi,
 void unbind_from_irqhandler(unsigned int irq, void *dev_id);
 
 void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector);
+int resend_irq_on_evtchn(unsigned int irq);
 
 static inline void notify_remote_via_evtchn(int port)
 {
-- 
1.5.3


-- 
yamahata
