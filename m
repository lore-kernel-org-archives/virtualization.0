From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 26/40] Staging: hv: storvsc: Handle probing IDE devices
Date: Wed, 29 Jun 2011 07:39:23 -0700
Message-ID: <1309358377-8537-26-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Add code is storvsc_probe() to handle IDE devices. We currently boot
off of the first IDE disk. The emulated HBA assigned to manage the IDE
disks will be owned by this (boot) device. Subsequent IDE devices that
may be discovered will be managed by this HBA.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 898a311..c0d6e16 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -79,7 +79,7 @@ static void storvsc_get_ide_info(struct hv_device *dev, int *target, int *path)
 	dev->dev_instance.data[1] << 8  | dev->dev_instance.data[0];
 }
 
-int storvsc_ide_probe(struct hv_device *dev)
+static int storvsc_ide_probe(struct hv_device *dev)
 {
 	struct storvsc_device_info dev_info;
 	int target, path, channel;
@@ -713,6 +713,15 @@ static int storvsc_probe(struct hv_device *device)
 	struct Scsi_Host *host;
 	struct hv_host_device *host_dev;
 	struct storvsc_device_info device_info;
+	bool dev_is_ide;
+	int path, target;
+
+	if (!strcmp(device->device_type, "hv_block")) {
+		dev_is_ide = true;
+		if (storvsc_host)
+			return storvsc_ide_probe(device);
+	} else
+		dev_is_ide = false;
 
 	host = scsi_host_alloc(&scsi_driver,
 			       sizeof(struct hv_host_device));
@@ -751,8 +760,15 @@ static int storvsc_probe(struct hv_device *device)
 	 * This stor device owns the HBA; capture that state.
 	 */
 	((struct storvsc_device *)device->ext)->hba_owner = true;
-	host_dev->path = device_info.path_id;
-	host_dev->target = device_info.target_id;
+
+	if (dev_is_ide) {
+		storvsc_get_ide_info(device, &target, &path);
+		host_dev->path = path;
+		host_dev->target = target;
+	} else {
+		host_dev->path = device_info.path_id;
+		host_dev->target = device_info.target_id;
+	}
 
 	/* max # of devices per target */
 	host->max_lun = STORVSC_MAX_LUNS_PER_TARGET;
@@ -772,6 +788,7 @@ static int storvsc_probe(struct hv_device *device)
 		return -ENODEV;
 	}
 	scsi_scan_host(host);
+	storvsc_host = host;
 	return ret;
 }
 
-- 
1.7.4.1
