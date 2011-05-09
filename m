From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 129/206] Staging: hv: Move the sector size check into
	blkvsc_drv_init
Date: Mon,  9 May 2011 14:56:51 -0700
Message-ID: <1304978288-22999-129-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/blkvsc_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index f8a3bce..ed1439f 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -822,6 +822,8 @@ static int blkvsc_drv_init(void)
 	struct hv_driver *drv = &blkvsc_drv.base;
 	int ret;
 
+	BUILD_BUG_ON(sizeof(sector_t) != 8);
+
 	storvsc_drv->ring_buffer_size = blkvsc_ringbuffer_size;
 
 	memcpy(&drv->dev_type, &dev_type, sizeof(struct hv_guid));
@@ -1046,8 +1048,6 @@ static int __init blkvsc_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(sizeof(sector_t) != 8);
-
 	ret = blkvsc_drv_init();
 
 	return ret;
-- 
1.7.4.1
