From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH] xen: remove load_cr3() from manage.c for ia64 support.
Date: Thu, 3 Jul 2008 16:10:53 +0900
Message-ID: <20080703071053.GC15683%yamahata__46565.9550544389$1215069578$gmane$org@valinux.co.jp>
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
Cc: xen-ia64-devel@lists.xensource.com, xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

remove load_cr3() from manage.c. It is unncessary and x86 dependent.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 drivers/xen/manage.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 2bb268e..e8db90c 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -39,8 +39,6 @@ static int xen_suspend(void *data)
 
 	BUG_ON(!irqs_disabled());
 
-	load_cr3(swapper_pg_dir);
-
 	err = device_power_down(PMSG_SUSPEND);
 	if (err) {
 		printk(KERN_ERR "xen_suspend: device_power_down failed: %d\n",
-- 
1.5.3
