From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 074/117] Staging: hv: netvsc: Change the jump label Exit to
	exit
Date: Fri, 15 Jul 2011 10:47:02 -0700
Message-ID: <1310752065-27895-74-git-send-email-kys@microsoft.com>
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

Change the jump lable "Exit" to "exit".

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
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
