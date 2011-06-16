From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 77/77] Staging: hv: netvsc: Change the jump lable Exit to exit
Date: Thu, 16 Jun 2011 13:17:50 -0700
Message-ID: <1308255470-3826-77-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Change the jump lable Exit to exit.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index 79dfe78..6db48b9 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -537,7 +537,7 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 		 * We can't deallocate the request since we may still receive a
 		 * send completion for it.
 		 */
-		goto Exit;
+		goto exit;
 	} else {
 		set_complete = &request->response_msg.msg.set_complete;
 		status = set_complete->status;
@@ -546,7 +546,7 @@ static int rndis_filter_set_packet_filter(struct rndis_device *dev,
 cleanup:
 	if (request)
 		put_rndis_request(dev, request);
-Exit:
+exit:
 	return ret;
 }
 
-- 
1.7.4.1
