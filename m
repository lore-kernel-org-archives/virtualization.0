From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 28/59] Staging: hv: vmbus: Get rid of the function
	dump_gpadl_header()
Date: Thu, 25 Aug 2011 09:48:54 -0700
Message-ID: <1314290965-2698-28-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the function dump_gpadl_header() as this adds no value.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/channel.c |   28 ----------------------------
 1 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 2d5bfac..aa0a150 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -239,33 +239,6 @@ errorout:
 }
 EXPORT_SYMBOL_GPL(vmbus_open);
 
-
-/*
- * dump_gpadl_header - Dump the gpadl header message to the console for
- * debugging purposes.
- */
-static void dump_gpadl_header(struct vmbus_channel_gpadl_header *gpadl)
-{
-	int i, j;
-	int pagecount;
-
-	DPRINT_DBG(VMBUS,
-		   "gpadl header - relid %d, range count %d, range buflen %d",
-		   gpadl->child_relid, gpadl->rangecount, gpadl->range_buflen);
-	for (i = 0; i < gpadl->rangecount; i++) {
-		pagecount = gpadl->range[i].byte_count >> PAGE_SHIFT;
-		pagecount = (pagecount > 26) ? 26 : pagecount;
-
-		DPRINT_DBG(VMBUS, "gpadl range %d - len %d offset %d "
-			   "page count %d", i, gpadl->range[i].byte_count,
-			   gpadl->range[i].byte_offset, pagecount);
-
-		for (j = 0; j < pagecount; j++)
-			DPRINT_DBG(VMBUS, "%d) pfn %llu", j,
-				   gpadl->range[i].pfn_array[j]);
-	}
-}
-
 /*
  * create_gpadl_header - Creates a gpadl for the specified buffer
  */
@@ -443,7 +416,6 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 	gpadlmsg->child_relid = channel->offermsg.child_relid;
 	gpadlmsg->gpadl = next_gpadl_handle;
 
-	dump_gpadl_header(gpadlmsg);
 
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
 	list_add_tail(&msginfo->msglistentry,
-- 
1.7.4.1
