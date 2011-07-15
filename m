From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 042/117] Staging: hv: vmbus: Get rid of the function
	dump_gpadl_body()
Date: Fri, 15 Jul 2011 10:46:30 -0700
Message-ID: <1310752065-27895-42-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
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

Get rid of the function dump_gpadl_body() since it adds no value and actually is
in the data path.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/channel.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 222adcc..2d5bfac 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -239,24 +239,6 @@ errorout:
 }
 EXPORT_SYMBOL_GPL(vmbus_open);
 
-/*
- * dump_gpadl_body - Dump the gpadl body message to the console for
- * debugging purposes.
- */
-static void dump_gpadl_body(struct vmbus_channel_gpadl_body *gpadl, u32 len)
-{
-	int i;
-	int pfncount;
-
-	pfncount = (len - sizeof(struct vmbus_channel_gpadl_body)) /
-		   sizeof(u64);
-
-	DPRINT_DBG(VMBUS, "gpadl body - len %d pfn count %d", len, pfncount);
-
-	for (i = 0; i < pfncount; i++)
-		DPRINT_DBG(VMBUS, "gpadl body  - %d) pfn %llu",
-			   i, gpadl->pfn[i]);
-}
 
 /*
  * dump_gpadl_header - Dump the gpadl header message to the console for
@@ -485,8 +467,6 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 				CHANNELMSG_GPADL_BODY;
 			gpadl_body->gpadl = next_gpadl_handle;
 
-			dump_gpadl_body(gpadl_body, submsginfo->msgsize -
-				      sizeof(*submsginfo));
 			ret = vmbus_post_msg(gpadl_body,
 					       submsginfo->msgsize -
 					       sizeof(*submsginfo));
-- 
1.7.4.1
