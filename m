From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 07/14] vmbus: callback is in softirq not workqueue
Date: Wed,  1 Feb 2017 08:28:54 -0800
Message-ID: <20170201162901.3894-8-sthemmin__3924.99124068326$1485966620$gmane$org@microsoft.com>
References: <20170201162901.3894-1-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170201162901.3894-1-sthemmin@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kys@microsoft.com, gregkh@linuxfoundation.org
Cc: devel@linuxdriverproject.org, Stephen Hemminger <sthemmin@microsoft.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The callback is done via tasklet not workqueue.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 include/linux/hyperv.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 39d493ce550d..b30808f740f9 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -32,7 +32,6 @@
 #include <linux/scatterlist.h>
 #include <linux/list.h>
 #include <linux/timer.h>
-#include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
@@ -729,9 +728,7 @@ struct vmbus_channel {
 
 	struct vmbus_close_msg close_msg;
 
-	/* Channel callback are invoked in this workqueue context */
-	/* HANDLE dataWorkQueue; */
-
+	/* Channel callback's invoked in softirq context */
 	void (*onchannel_callback)(void *context);
 	void *channel_callback_context;
 
-- 
2.11.0
