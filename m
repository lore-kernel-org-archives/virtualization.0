From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 20/22] Staging: hv: Fix a jump label (Remove) in blkvsc_drv.c
Date: Wed,  6 Apr 2011 16:05:20 -0700
Message-ID: <1302131122-15530-20-git-send-email-kys@microsoft.com>
References: <1302131006-15411-1-git-send-email-kys@microsoft.com>
	<1302131122-15530-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1302131122-15530-1-git-send-email-kys@microsoft.com>
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

One of the jump labels was named Remove; change it to remove.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index a47581c..3229ebc 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -1005,7 +1005,7 @@ static int blkvsc_probe(struct device *device)
 				DPRINT_ERR(BLKVSC_DRV,
 					   "register_blkdev() failed! ret %d",
 					   ret);
-				goto Remove;
+				goto remove;
 			}
 
 			ide0_registered = 1;
@@ -1020,7 +1020,7 @@ static int blkvsc_probe(struct device *device)
 				DPRINT_ERR(BLKVSC_DRV,
 					   "register_blkdev() failed! ret %d",
 					   ret);
-				goto Remove;
+				goto remove;
 			}
 
 			ide1_registered = 1;
@@ -1071,7 +1071,7 @@ static int blkvsc_probe(struct device *device)
 
 	return ret;
 
-Remove:
+remove:
 	storvsc_drv_obj->base.dev_rm(device_obj);
 
 cleanup:
-- 
1.7.4.1
