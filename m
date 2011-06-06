From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 43/49] Staging: hv: vmbus: Cleanup some error codes in
	vmbus_drv.c
Date: Mon,  6 Jun 2011 15:50:07 -0700
Message-ID: <1307400613-13234-43-git-send-email-kys@microsoft.com>
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

Cleanup some error codes in vmbus_drv.c

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 17692ce..a3c99f1 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -329,7 +329,7 @@ static int vmbus_probe(struct device *child_device)
 	} else {
 		pr_err("probe not set for driver %s\n",
 		       dev_name(child_device));
-		ret = -1;
+		ret = -ENODEV;
 	}
 	return ret;
 }
@@ -352,7 +352,7 @@ static int vmbus_remove(struct device *child_device)
 		} else {
 			pr_err("remove not set for driver %s\n",
 				dev_name(child_device));
-			ret = -1;
+			ret = -ENODEV;
 		}
 	}
 
-- 
1.7.4.1
