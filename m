From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 17/22] Staging: hv: Get rid of an unnecessary check in
	blkvsc_probe()
Date: Mon,  4 Apr 2011 15:48:06 -0700
Message-ID: <1301957291-8035-17-git-send-email-kys@microsoft.com>
References: <1301957186-7853-1-git-send-email-kys@microsoft.com>
	<1301957291-8035-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1301957291-8035-1-git-send-email-kys@microsoft.com>
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

It is never the case that the dev_add function pointer will not be set
(we set it in this code!). Get rid of this meaningless check.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index aff6356..7f511ee 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -967,11 +967,6 @@ static int blkvsc_probe(struct device *device)
 	static int ide1_registered;
 
 
-	if (!storvsc_drv_obj->base.dev_add) {
-		ret = -1;
-		goto Cleanup;
-	}
-
 	blkdev = kzalloc(sizeof(struct block_device_context), GFP_KERNEL);
 	if (!blkdev) {
 		ret = -ENOMEM;
-- 
1.7.4.1
