From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH] xen: Use wmb instead of rmb in xen_evtchn_do_upcall().
Date: Tue, 10 Jun 2008 16:35:32 +0900
Message-ID: <20080610073532.GG24381%yamahata__22852.3299949758$1213083464$gmane$org@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: xen-ia64-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Samuel Thibault <samuel.thibault@eu.citrix.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch is ported one from 534:77db69c38249 of linux-2.6.18-xen.hg.
Use wmb instead of rmb to enforce ordering between
evtchn_upcall_pending and evtchn_pending_sel stores
in xen_evtchn_do_upcall().

Cc: Samuel Thibault <samuel.thibault@eu.citrix.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 drivers/xen/events.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index 73d78dc..332dd63 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -529,7 +529,7 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
 
 #ifndef CONFIG_X86 /* No need for a barrier -- XCHG is a barrier on x86. */
 		/* Clear master flag /before/ clearing selector flag. */
-		rmb();
+		wmb();
 #endif
 		pending_words = xchg(&vcpu_info->evtchn_pending_sel, 0);
 		while (pending_words != 0) {
-- 
1.5.3
