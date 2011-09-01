From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 10/10] staging: hv: fix some typos in netvsc.c
Date: Thu,  1 Sep 2011 12:19:48 -0700
Message-ID: <1314904788-32746-11-git-send-email-haiyangz@microsoft.com>
References: <1314904788-32746-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314904788-32746-1-git-send-email-haiyangz@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index efbc8a0..115629f 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -218,7 +218,7 @@ static int netvsc_init_recv_buf(struct hv_device *device)
 	if (init_packet->msg.v1_msg.
 	    send_recv_buf_complete.status != NVSP_STAT_SUCCESS) {
 		netdev_err(ndev, "Unable to complete receive buffer "
-			   "initialzation with NetVsp - status %d\n",
+			   "initialization with NetVsp - status %d\n",
 			   init_packet->msg.v1_msg.
 			   send_recv_buf_complete.status);
 		ret = -EINVAL;
@@ -695,7 +695,7 @@ static void netvsc_receive(struct hv_device *device,
 	xferpage_packet->count = count - 1;
 
 	if (xferpage_packet->count != vmxferpage_packet->range_cnt) {
-		netdev_err(ndev, "Needed %d netvsc pkts to satisy "
+		netdev_err(ndev, "Needed %d netvsc pkts to satisfy "
 			"this xfer page...got %d\n",
 			vmxferpage_packet->range_cnt, xferpage_packet->count);
 	}
-- 
1.6.3.2
