From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 049/206] Staging: hv: Staging: hv: Rename the function
	stor_vsc_on_host_reset()
Date: Mon,  9 May 2011 14:55:31 -0700
Message-ID: <1304978288-22999-49-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/storvsc_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 4c08328..d8ce28e 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -536,7 +536,7 @@ static int storvsc_drv_init(void)
 }
 
 
-static int stor_vsc_on_host_reset(struct hv_device *device)
+static int storvsc_host_reset(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
 	struct hv_storvsc_request *request;
@@ -933,7 +933,7 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 		    scmnd->device, dev);
 
 	/* Invokes the vsc to reset the host/bus */
-	ret = stor_vsc_on_host_reset(dev);
+	ret = storvsc_host_reset(dev);
 	if (ret != 0)
 		return ret;
 
-- 
1.7.4.1
