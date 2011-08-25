From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 41/59] Staging: hv: storvsc: Fix/cleanup some dated comments
	in storvsc.c
Date: Thu, 25 Aug 2011 09:49:07 -0700
Message-ID: <1314290965-2698-41-git-send-email-kys@microsoft.com>
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

Fix/cleanup some dated comments in storvsc.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 3730f3f..827b6a3 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -166,7 +166,6 @@ static int storvsc_channel_init(struct hv_device *device)
 		goto cleanup;
 	}
 
-	/* TODO: Check returned version */
 	if (vstor_packet->operation != VSTOR_OPERATION_COMPLETE_IO ||
 	    vstor_packet->status != 0)
 		goto cleanup;
@@ -193,7 +192,6 @@ static int storvsc_channel_init(struct hv_device *device)
 		goto cleanup;
 	}
 
-	/* TODO: Check returned version */
 	if (vstor_packet->operation != VSTOR_OPERATION_COMPLETE_IO ||
 	    vstor_packet->status != 0)
 		goto cleanup;
@@ -384,11 +382,12 @@ int storvsc_dev_add(struct hv_device *device,
 
 	/* Save the channel properties to our storvsc channel */
 
-	/* FIXME: */
 	/*
 	 * If we support more than 1 scsi channel, we need to set the
 	 * port number here to the scsi channel but how do we get the
-	 * scsi channel prior to the bus scan
+	 * scsi channel prior to the bus scan.
+	 *
+	 * The host does not support this.
 	 */
 
 	stor_device->port_number = device_info->port_number;
@@ -545,4 +544,3 @@ int storvsc_get_major_info(struct storvsc_device_info *device_info,
 
 	return -ENODEV;
 }
-
-- 
1.7.4.1
