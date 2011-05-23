From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 6/6] staging: hv: removed commented out code from
	rndis_filter_receive()
Date: Mon, 23 May 2011 09:03:50 -0700
Message-ID: <1306166630-17336-6-git-send-email-haiyangz__19532.5613873594$1306165885$gmane$org@microsoft.com>
References: <1306166630-17336-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1306166630-17336-1-git-send-email-haiyangz@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/rndis_filter.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index b142aae..5a5bf64 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -372,24 +372,6 @@ int rndis_filter_receive(struct hv_device *dev,
 			pkt->page_buf[0].offset);
 
 	/* Make sure we got a valid rndis message */
-	/*
-	 * FIXME: There seems to be a bug in set completion msg where its
-	 * MessageLength is 16 bytes but the ByteCount field in the xfer page
-	 * range shows 52 bytes
-	 * */
-#if 0
-	if (pkt->total_data_buflen != rndis_hdr->msg_len) {
-		kunmap_atomic(rndis_hdr - pkt->page_buf[0].offset,
-			      KM_IRQ0);
-
-		dev_err(&dev->device, "invalid rndis message? (expected %u "
-			   "bytes got %u)...dropping this message!\n",
-			   rndis_hdr->msg_len,
-			   pkt->total_data_buflen);
-		return -1;
-	}
-#endif
-
 	if ((rndis_hdr->ndis_msg_type != REMOTE_NDIS_PACKET_MSG) &&
 	    (rndis_hdr->msg_len > sizeof(struct rndis_message))) {
 		dev_err(&dev->device, "incoming rndis message buffer overflow "
-- 
1.6.3.2
