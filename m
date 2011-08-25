From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 50/59] Staging: hv: netvsc: Cleanup error return codes in
	netvsc_device_add()
Date: Thu, 25 Aug 2011 09:49:16 -0700
Message-ID: <1314290965-2698-50-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use standard Linux error codes.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index f7f4957..b6e1fb9 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -918,7 +918,7 @@ int netvsc_device_add(struct hv_device *device, void *additional_info)
 
 	net_device = alloc_net_device(device);
 	if (!net_device) {
-		ret = -1;
+		ret = -ENOMEM;
 		goto cleanup;
 	}
 
@@ -947,7 +947,6 @@ int netvsc_device_add(struct hv_device *device, void *additional_info)
 
 	if (ret != 0) {
 		dev_err(&device->device, "unable to open channel: %d", ret);
-		ret = -1;
 		goto cleanup;
 	}
 
@@ -959,7 +958,6 @@ int netvsc_device_add(struct hv_device *device, void *additional_info)
 	if (ret != 0) {
 		dev_err(&device->device,
 			"unable to connect to NetVSP - %d", ret);
-		ret = -1;
 		goto close;
 	}
 
-- 
1.7.4.1
