From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/5] staging: hv: fix some white spaces in netvsc driver
Date: Fri, 17 Jun 2011 07:58:04 -0700
Message-ID: <1308322688-9796-1-git-send-email-haiyangz__22748.1472924866$1308323256$gmane$org@microsoft.com>
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

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc.c     |    8 ++++----
 drivers/staging/hv/netvsc_drv.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 0ae35e7..b6e1fb9 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -525,10 +525,10 @@ int netvsc_send(struct hv_device *device,
 						  (unsigned long)packet);
 	} else {
 		ret = vmbus_sendpacket(device->channel, &sendMessage,
-				       sizeof(struct nvsp_message),
-				       (unsigned long)packet,
-				       VM_PKT_DATA_INBAND,
-				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+				sizeof(struct nvsp_message),
+				(unsigned long)packet,
+				VM_PKT_DATA_INBAND,
+				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 
 	}
 
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index b339acc..8380fe9 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -122,7 +122,7 @@ static void netvsc_xmit_completion(void *context)
 		atomic_add(num_pages, &net_device_ctx->avail);
 		if (atomic_read(&net_device_ctx->avail) >=
 				PACKET_PAGES_HIWATER)
- 			netif_wake_queue(net);
+			netif_wake_queue(net);
 	}
 }
 
-- 
1.6.3.2
