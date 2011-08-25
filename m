From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 36/59] Staging: hv: storvsc: Cleanup error handling in
	storvsc_dev_add()
Date: Thu, 25 Aug 2011 09:49:02 -0700
Message-ID: <1314290965-2698-36-git-send-email-kys@microsoft.com>
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

Use standard Linux error values and cleanup error handling. I would like
to acknowledge Andre Bartke (andre.bartke@gmail.com) for highlighting this
problem.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 3029786..915aeee 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -392,10 +392,8 @@ int storvsc_dev_add(struct hv_device *device,
 
 	device_info = (struct storvsc_device_info *)additional_info;
 	stor_device = alloc_stor_device(device);
-	if (!stor_device) {
-		ret = -1;
-		goto cleanup;
-	}
+	if (!stor_device)
+		return -ENOMEM;
 
 	/* Save the channel properties to our storvsc channel */
 
@@ -409,11 +407,13 @@ int storvsc_dev_add(struct hv_device *device,
 	stor_device->port_number = device_info->port_number;
 	/* Send it back up */
 	ret = storvsc_connect_to_vsp(device, device_info->ring_buffer_size);
-
+	if (ret) {
+		free_stor_device(stor_device);
+		return ret;
+	}
 	device_info->path_id = stor_device->path_id;
 	device_info->target_id = stor_device->target_id;
 
-cleanup:
 	return ret;
 }
 
-- 
1.7.4.1
