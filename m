From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 9/9] staging: hv: fix the page buffer when rndis data go
	across page boundary
Date: Thu, 21 Jul 2011 10:14:57 -0700
Message-ID: <1311268497-8671-10-git-send-email-haiyangz__47487.0749902495$1311267668$gmane$org@microsoft.com>
References: <1311268497-8671-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1311268497-8671-1-git-send-email-haiyangz@microsoft.com>
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
