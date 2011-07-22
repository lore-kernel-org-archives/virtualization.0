From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH] staging: hv: fix some typos in netvsc.c
Date: Fri, 22 Jul 2011 08:56:32 -0700
Message-ID: <1311350192-13526-1-git-send-email-haiyangz__11561.8946533234$1311349241$gmane$org@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 2b33e13..23328aa 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -249,7 +249,7 @@ static int netvsc_init_recv_buf(struct hv_device *device)
 	if (init_packet->msg.v1_msg.
 	    send_recv_buf_complete.status != NVSP_STAT_SUCCESS) {
 		netdev_err(ndev, "Unable to complete receive buffer "
-			   "initialzation with NetVsp - status %d\n",
+			   "initialization with NetVsp - status %d\n",
 			   init_packet->msg.v1_msg.
 			   send_recv_buf_complete.status);
 		ret = -EINVAL;
@@ -746,7 +746,7 @@ static void netvsc_receive(struct hv_device *device,
 	xferpage_packet->count = count - 1;
 
 	if (xferpage_packet->count != vmxferpage_packet->range_cnt) {
-		netdev_err(ndev, "Needed %d netvsc pkts to satisy "
+		netdev_err(ndev, "Needed %d netvsc pkts to satisfy "
 			"this xfer page...got %d\n",
 			vmxferpage_packet->range_cnt, xferpage_packet->count);
 	}
-- 
1.6.3.2
