From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 064/117] Staging: hv: netvsc: Cleanup error return values in
	netvsc_send()
Date: Fri, 15 Jul 2011 10:46:52 -0700
Message-ID: <1310752065-27895-64-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/netvsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 9cc126b..f7f4957 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -409,7 +409,7 @@ int netvsc_device_remove(struct hv_device *device)
 	net_device = release_outbound_net_device(device);
 	if (!net_device) {
 		dev_err(&device->device, "No net device present!!");
-		return -1;
+		return -ENODEV;
 	}
 
 	/* Wait for all send completions */
@@ -499,7 +499,7 @@ int netvsc_send(struct hv_device *device,
 	if (!net_device) {
 		dev_err(&device->device, "net device (%p) shutting down..."
 			   "ignoring outbound packets", net_device);
-		return -2;
+		return -ENODEV;
 	}
 
 	sendMessage.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
-- 
1.7.4.1
