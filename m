From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 04/49] Staging: hv: storvsc: Fix a bug in the storvsc_remove()
	function
Date: Mon,  6 Jun 2011 15:49:28 -0700
Message-ID: <1307400613-13234-4-git-send-email-kys@microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
	<1307400613-13234-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1307400613-13234-1-git-send-email-kys@microsoft.com>
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

When the storvs driver unloads, we need to accomodate disk cache flushes.
Re-order the code to permit this.


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 33bce87..fd474d6 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -317,22 +317,20 @@ static int storvsc_remove(struct hv_device *dev)
 	struct hv_host_device *host_dev =
 			(struct hv_host_device *)host->hostdata;
 
+	DPRINT_INFO(STORVSC, "removing host adapter (%p)...", host);
+	scsi_remove_host(host);
+
+	DPRINT_INFO(STORVSC, "releasing host adapter (%p)...", host);
+	scsi_host_put(host);
 	/*
 	 * Call to the vsc driver to let it know that the device is being
 	 * removed
 	 */
 	storvsc_dev_remove(dev);
-
 	if (host_dev->request_pool) {
 		kmem_cache_destroy(host_dev->request_pool);
 		host_dev->request_pool = NULL;
 	}
-
-	DPRINT_INFO(STORVSC, "removing host adapter (%p)...", host);
-	scsi_remove_host(host);
-
-	DPRINT_INFO(STORVSC, "releasing host adapter (%p)...", host);
-	scsi_host_put(host);
 	return 0;
 }
 
-- 
1.7.4.1
