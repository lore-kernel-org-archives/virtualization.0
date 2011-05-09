From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 089/206] Staging: hv: Rename the variable g_netvsc_drv
Date: Mon,  9 May 2011 14:56:11 -0700
Message-ID: <1304978288-22999-89-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 0e81a93..25883ca 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -61,7 +61,7 @@ module_param(ring_size, int, S_IRUGO);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
 
 /* The one and only one */
-static struct  netvsc_driver g_netvsc_drv;
+static struct  netvsc_driver netvsc_drv;
 
 /* no-op so the netdev core doesn't return -EINVAL when modifying the the
  * multicast address list in SIOCADDMULTI. hv is setup to get all multicast
@@ -444,7 +444,7 @@ static int netvsc_drv_exit_cb(struct device *dev, void *data)
 
 static void netvsc_drv_exit(void)
 {
-	struct hv_driver *drv = &g_netvsc_drv.base;
+	struct hv_driver *drv = &netvsc_drv.base;
 	struct device *current_dev;
 	int ret;
 
@@ -472,8 +472,8 @@ static void netvsc_drv_exit(void)
 
 static int netvsc_drv_init(int (*drv_init)(struct hv_driver *drv))
 {
-	struct netvsc_driver *net_drv_obj = &g_netvsc_drv;
-	struct hv_driver *drv = &g_netvsc_drv.base;
+	struct netvsc_driver *net_drv_obj = &netvsc_drv;
+	struct hv_driver *drv = &netvsc_drv.base;
 	int ret;
 
 	net_drv_obj->ring_buf_size = ring_size * PAGE_SIZE;
-- 
1.7.4.1
