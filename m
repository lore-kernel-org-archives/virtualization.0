From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/16] Staging: hv: Make the function stor_vsc_initialize()
	static
Date: Wed, 23 Mar 2011 10:50:26 -0700
Message-ID: <1300902635-1347-8-git-send-email-kys@microsoft.com>
References: <1300902537-1290-1-git-send-email-kys@microsoft.com>
	<1300902635-1347-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1300902635-1347-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Make the function  stor_vsc_initialize() a  static function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_api.h |    1 -
 drivers/staging/hv/storvsc_drv.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 141b8fd..9a452f2 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -138,7 +138,6 @@ struct storvsc_device {
 };
 
 /* Interface */
-int stor_vsc_initialize(struct hv_driver *driver);
 int stor_vsc_on_host_reset(struct hv_device *device);
 int blk_vsc_initialize(struct hv_driver *driver);
 
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 5ea09da..af6a37d 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -77,7 +77,7 @@ struct storvsc_cmd_request {
 /*
  * stor_vsc_initialize - Main entry point
  */
-int stor_vsc_initialize(struct hv_driver *driver)
+static int stor_vsc_initialize(struct hv_driver *driver)
 {
 	struct storvsc_driver_object *stor_driver;
 
-- 
1.7.4.1
