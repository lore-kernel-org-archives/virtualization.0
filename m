From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 6/9] staging: hv: fix counting of #outstanding-sends in failed
	sends
Date: Thu, 21 Jul 2011 10:14:54 -0700
Message-ID: <1311268497-8671-7-git-send-email-haiyangz__9035.03320082582$1311267676$gmane$org@microsoft.com>
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

If the packet failed to be sent, we shouldn't count it as the
number of outstanding sends.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 159c490..2b33e13 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -539,8 +539,9 @@ int netvsc_send(struct hv_device *device,
 	if (ret != 0)
 		netdev_err(ndev, "Unable to send packet %p ret %d\n",
 			   packet, ret);
+	else
+		atomic_inc(&net_device->num_outstanding_sends);
 
-	atomic_inc(&net_device->num_outstanding_sends);
 	put_net_device(device);
 	return ret;
 }
-- 
1.6.3.2
