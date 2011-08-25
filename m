From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 43/59] Staging: hv: storvsc: Cleanup error code returned in
	storvsc_probe()
Date: Thu, 25 Aug 2011 09:49:09 -0700
Message-ID: <1314290965-2698-43-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/storvsc_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index c245698..956f010 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -693,7 +693,7 @@ static int storvsc_probe(struct hv_device *device)
 	if (ret != 0) {
 		kmem_cache_destroy(host_dev->request_pool);
 		scsi_host_put(host);
-		return -1;
+		return -ENODEV;
 	}
 
 	host_dev->path = device_info.path_id;
@@ -714,7 +714,7 @@ static int storvsc_probe(struct hv_device *device)
 
 		kmem_cache_destroy(host_dev->request_pool);
 		scsi_host_put(host);
-		return -1;
+		return -ENODEV;
 	}
 
 	scsi_scan_host(host);
-- 
1.7.4.1
