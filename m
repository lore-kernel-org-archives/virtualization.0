From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 079/206] Staging: hv: Get rid of some unnecessary code in
	rndis_filter.c
Date: Mon,  9 May 2011 14:56:01 -0700
Message-ID: <1304978288-22999-79-git-send-email-kys@microsoft.com>
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

Now that we have gotten rid of the indirection; get rid
of some unnecessary code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index f9c18fa..ee74cd1 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -606,19 +606,12 @@ int rndis_filter_init(struct netvsc_driver *drv)
 	rndisDriver->OnLinkStatusChanged = Driver->OnLinkStatusChanged;*/
 
 	/* Save the original dispatch handlers before we override it */
-	rndis_filter.inner_drv.base.dev_add = drv->base.dev_add;
-	rndis_filter.inner_drv.base.dev_rm =
-					drv->base.dev_rm;
-	rndis_filter.inner_drv.base.cleanup = drv->base.cleanup;
-
 	rndis_filter.inner_drv.send = drv->send;
 	rndis_filter.inner_drv.recv_cb = drv->recv_cb;
 	rndis_filter.inner_drv.link_status_change =
 					drv->link_status_change;
 
 	/* Override */
-	drv->base.dev_add = rndis_filte_device_add;
-	drv->base.dev_rm = rndis_filter_device_remove;
 	drv->send = rndis_filter_send;
 	drv->recv_cb = rndis_filter_receive;
 
-- 
1.7.4.1
