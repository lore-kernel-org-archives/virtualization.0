From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 09/10] staging: hv: fix the page buffer when rndis data go
	across page boundary
Date: Thu,  1 Sep 2011 12:19:47 -0700
Message-ID: <1314904788-32746-10-git-send-email-haiyangz@microsoft.com>
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

In rndis_filter_receive_data(), we need to drop the 0th page and move the
rest of pages forward if the rndis data go across page boundary, otherwise
the page offset will overflow.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index 20e673d..b325345 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -323,6 +323,7 @@ static void rndis_filter_receive_data(struct rndis_device *dev,
 {
 	struct rndis_packet *rndis_pkt;
 	u32 data_offset;
+	int i;
 
 	rndis_pkt = &msg->msg.pkt;
 
@@ -338,6 +339,15 @@ static void rndis_filter_receive_data(struct rndis_device *dev,
 	pkt->page_buf[0].offset += data_offset;
 	pkt->page_buf[0].len -= data_offset;
 
+	/* Drop the 0th page, if rndis data go beyond page boundary */
+	if (pkt->page_buf[0].offset >= PAGE_SIZE) {
+		pkt->page_buf[1].offset = pkt->page_buf[0].offset - PAGE_SIZE;
+		pkt->page_buf[1].len -= pkt->page_buf[1].offset;
+		pkt->page_buf_cnt--;
+		for (i = 0; i < pkt->page_buf_cnt; i++)
+			pkt->page_buf[i] = pkt->page_buf[i+1];
+	}
+
 	pkt->is_data_pkt = true;
 
 	netvsc_recv_callback(dev->net_dev->dev, pkt);
-- 
1.6.3.2
