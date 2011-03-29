From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 07/07] Replaced printk with pr_info in hv_timesource
Date: Tue, 29 Mar 2011 13:58:50 -0700
Message-ID: <1301432330-1705-8-git-send-email-hjanssen@microsoft.com>
References: <1301432330-1705-1-git-send-email-hjanssen@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301432330-1705-1-git-send-email-hjanssen@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hjanssen@microsoft.com, haiyangz@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Replaced printk in hv_timesource with pr_ calls

Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

---
 drivers/staging/hv/hv_timesource.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_timesource.c b/drivers/staging/hv/hv_timesource.c
index a7ee533..0efb049 100644
--- a/drivers/staging/hv/hv_timesource.c
+++ b/drivers/staging/hv/hv_timesource.c
@@ -20,6 +20,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/version.h>
 #include <linux/clocksource.h>
@@ -91,7 +92,7 @@ static int __init init_hv_clocksource(void)
 	if (!dmi_check_system(hv_timesource_dmi_table))
 		return -ENODEV;
 
-	printk(KERN_INFO "Registering HyperV clock source\n");
+	pr_info("Registering HyperV clock source\n");
 	return clocksource_register(&hyperv_cs);
 }
 
-- 
1.6.0.2
