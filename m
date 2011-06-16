From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 58/77] Staging: hv: storvsc: Fix/cleanup some dated comments in storvsc.c
Date: Thu, 16 Jun 2011 13:17:31 -0700
Message-ID: <1308255470-3826-58-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix/cleanup some dated comments in storvsc.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index b3506f6..89de5b5 100644
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
@@ -542,4 +541,3 @@ int storvsc_get_major_info(struct storvsc_device_info *device_info,
 
 	return -ENODEV;
 }
-
-- 
1.7.4.1
