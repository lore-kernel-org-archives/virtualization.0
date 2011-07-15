From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 073/117] Staging: hv: netvsc: Change the jump label Cleanup to
	cleanup
Date: Fri, 15 Jul 2011 10:47:01 -0700
Message-ID: <1310752065-27895-73-git-send-email-kys@microsoft.com>
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

Change the jump label "Cleanup" to "cleanup".

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index f0d1362..79dfe78 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -438,7 +438,7 @@ static int rndis_filter_query_device(struct rndis_device *dev, u32 oid,
 			RNDIS_MESSAGE_SIZE(struct rndis_query_request));
 	if (!request) {
 		ret = -ENOMEM;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	/* Setup the rndis query */
@@ -450,12 +450,12 @@ static int rndis_filter_query_device(struct rndis_device *dev, u32 oid,
 
 	ret = rndis_filter_send_request(dev, request);
 	if (ret != 0)
-		goto Cleanup;
+		goto cleanup;
 
 	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	/* Copy the response back */
@@ -463,7 +463,7 @@ static int rndis_filter_query_device(struct rndis_device *dev, u32 oid,
 
 	if (query_complete->info_buflen > inresult_size) {
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	memcpy(result,
@@ -473,7 +473,7 @@ static int rndis_filter_query_device(struct rndis_device *dev, u32 oid,
 
 	*result_size = query_complete->info_buflen;
 
-Cleanup:
+cleanup:
 	if (request)
 		put_rndis_request(dev, request);
 
@@ -512,7 +512,7 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 			sizeof(u32));
 	if (!request) {
 		ret = -ENOMEM;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	/* Setup the rndis set */
@@ -526,7 +526,7 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 
 	ret = rndis_filter_send_request(dev, request);
 	if (ret != 0)
-		goto Cleanup;
+		goto cleanup;
 
 	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
 
@@ -543,7 +543,7 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 		status = set_complete->status;
 	}
 
-Cleanup:
+cleanup:
 	if (request)
 		put_rndis_request(dev, request);
 Exit:
@@ -563,7 +563,7 @@ static int rndis_filter_init_device(struct rndis_device *dev)
 			RNDIS_MESSAGE_SIZE(struct rndis_initialize_request));
 	if (!request) {
 		ret = -ENOMEM;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	/* Setup the rndis set */
@@ -578,7 +578,7 @@ static int rndis_filter_init_device(struct rndis_device *dev)
 	ret = rndis_filter_send_request(dev, request);
 	if (ret != 0) {
 		dev->state = RNDIS_DEV_UNINITIALIZED;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 
@@ -586,7 +586,7 @@ static int rndis_filter_init_device(struct rndis_device *dev)
 
 	if (t == 0) {
 		ret = -ETIMEDOUT;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	init_complete = &request->response_msg.msg.init_complete;
@@ -599,7 +599,7 @@ static int rndis_filter_init_device(struct rndis_device *dev)
 		ret = -EINVAL;
 	}
 
-Cleanup:
+cleanup:
 	if (request)
 		put_rndis_request(dev, request);
 
@@ -615,7 +615,7 @@ static void rndis_filter_halt_device(struct rndis_device *dev)
 	request = get_rndis_request(dev, REMOTE_NDIS_HALT_MSG,
 				RNDIS_MESSAGE_SIZE(struct rndis_halt_request));
 	if (!request)
-		goto Cleanup;
+		goto cleanup;
 
 	/* Setup the rndis set */
 	halt = &request->request_msg.msg.halt_req;
@@ -626,7 +626,7 @@ static void rndis_filter_halt_device(struct rndis_device *dev)
 
 	dev->state = RNDIS_DEV_UNINITIALIZED;
 
-Cleanup:
+cleanup:
 	if (request)
 		put_rndis_request(dev, request);
 	return;
-- 
1.7.4.1
