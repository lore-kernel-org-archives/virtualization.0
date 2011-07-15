From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 062/117] Staging: hv: netvsc: Cleanup error return values in
	netvsc_init_recv_buf()
Date: Fri, 15 Jul 2011 10:46:50 -0700
Message-ID: <1310752065-27895-62-git-send-email-kys@microsoft.com>
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

Use standard Linux error codes.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index baa0c8d..5703fd7 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -207,7 +207,7 @@ static int netvsc_init_recv_buf(struct hv_device *device)
 	if (!net_device) {
 		dev_err(&device->device, "unable to get net device..."
 			   "device being destroyed?");
-		return -1;
+		return -ENODEV;
 	}
 
 	net_device->recv_buf =
@@ -216,7 +216,7 @@ static int netvsc_init_recv_buf(struct hv_device *device)
 	if (!net_device->recv_buf) {
 		dev_err(&device->device, "unable to allocate receive "
 			"buffer of size %d", net_device->recv_buf_size);
-		ret = -1;
+		ret = -ENOMEM;
 		goto cleanup;
 	}
 
@@ -269,7 +269,7 @@ static int netvsc_init_recv_buf(struct hv_device *device)
 			   "initialzation with NetVsp - status %d",
 			   init_packet->msg.v1_msg.
 			   send_recv_buf_complete.status);
-		ret = -1;
+		ret = -EINVAL;
 		goto cleanup;
 	}
 
@@ -281,7 +281,7 @@ static int netvsc_init_recv_buf(struct hv_device *device)
 	net_device->recv_section = kmalloc(net_device->recv_section_cnt
 		* sizeof(struct nvsp_1_receive_buffer_section), GFP_KERNEL);
 	if (net_device->recv_section == NULL) {
-		ret = -1;
+		ret = -EINVAL;
 		goto cleanup;
 	}
 
@@ -297,7 +297,7 @@ static int netvsc_init_recv_buf(struct hv_device *device)
 	 */
 	if (net_device->recv_section_cnt != 1 ||
 	    net_device->recv_section->offset != 0) {
-		ret = -1;
+		ret = -EINVAL;
 		goto cleanup;
 	}
 
-- 
1.7.4.1
