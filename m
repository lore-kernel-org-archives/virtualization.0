From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 131/206] Staging: hv: Get rid of some unnecessary DPRINTs
Date: Mon,  9 May 2011 14:56:53 -0700
Message-ID: <1304978288-22999-131-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/storvsc_drv.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 0d7e43b..07db877 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -103,10 +103,6 @@ static int storvsc_initialize(struct hv_driver *driver)
 			   sizeof(struct vstor_packet) + sizeof(u64),
 			   sizeof(u64)));
 
-	DPRINT_INFO(STORVSC, "max io %u, currently %u\n",
-		    stor_driver->max_outstanding_req_per_channel,
-		    STORVSC_MAX_IO_REQUESTS);
-
 
 	return 0;
 }
@@ -807,10 +803,6 @@ static int storvsc_drv_init(void)
 	/* Callback to client driver to complete the initialization */
 	storvsc_initialize(&storvsc_drv_obj->base);
 
-	DPRINT_INFO(STORVSC_DRV,
-		    "max outstanding reqs %u",
-		    storvsc_drv_obj->max_outstanding_req_per_channel);
-
 	if (storvsc_drv_obj->max_outstanding_req_per_channel <
 	    STORVSC_MAX_IO_REQUESTS)
 		return -1;
-- 
1.7.4.1
