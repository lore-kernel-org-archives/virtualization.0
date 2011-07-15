From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 068/117] Staging: hv: netvsc: Cleanup error return values in
	rndis_filter_set_packet_filter()
Date: Fri, 15 Jul 2011 10:46:56 -0700
Message-ID: <1310752065-27895-68-git-send-email-kys@microsoft.com>
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

Use standard Linux error codes and cleanup some error paths.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index f26886d..f5f3052 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -511,7 +511,7 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 			RNDIS_MESSAGE_SIZE(struct rndis_set_request) +
 			sizeof(u32));
 	if (!request) {
-		ret = -1;
+		ret = -ENOMEM;
 		goto Cleanup;
 	}
 
@@ -531,7 +531,6 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
 
 	if (t == 0) {
-		ret = -1;
 		dev_err(&dev->net_dev->dev->device,
 			"timeout before we got a set response...\n");
 		/*
@@ -540,8 +539,6 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 		 */
 		goto Exit;
 	} else {
-		if (ret > 0)
-			ret = 0;
 		set_complete = &request->response_msg.msg.set_complete;
 		status = set_complete->status;
 	}
-- 
1.7.4.1
