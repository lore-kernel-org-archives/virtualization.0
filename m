From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH] xen: wrap load_cr3() in manage.c for ia64 support.
Date: Tue, 26 Aug 2008 14:28:12 +0900
Message-ID: <20080826052812.GD1496%yamahata__14431.5036050559$1219728615$gmane$org@valinux.co.jp>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-ia64-devel@lists.xensource.com, xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

wrap load_cr3() in manage.c by xen_pre_device_suspend()
because it is x86 dependent.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/x86/xen/suspend.c |    5 +++++
 drivers/xen/manage.c   |    3 +--
 include/xen/xen-ops.h  |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 2a234db..ac139a2 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -10,6 +10,11 @@
 #include "xen-ops.h"
 #include "mmu.h"
 
+void xen_pre_device_suspend(void)
+{
+        load_cr3(swapper_pg_dir);
+}
+
 void xen_pre_suspend(void)
 {
 	xen_start_info->store_mfn = mfn_to_pfn(xen_start_info->store_mfn);
diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index a5bc91a..c7f2953 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -39,8 +39,7 @@ static int xen_suspend(void *data)
 
 	BUG_ON(!irqs_disabled());
 
-	load_cr3(swapper_pg_dir);
-
+	xen_pre_device_suspend();
 	err = device_power_down(PMSG_SUSPEND);
 	if (err) {
 		printk(KERN_ERR "xen_suspend: device_power_down failed: %d\n",
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 883a21b..a26db6f 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -5,6 +5,7 @@
 
 DECLARE_PER_CPU(struct vcpu_info *, xen_vcpu);
 
+void xen_pre_device_suspend(void);
 void xen_pre_suspend(void);
 void xen_post_suspend(int suspend_cancelled);
 
-- 
1.6.0.rc0.42.g186458
