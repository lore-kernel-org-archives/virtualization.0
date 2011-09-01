From: Mike Sterling <steelforce@gmail.com>
Subject: [PATCH 1/1] staging: hv: Add support for >2 TB LUN in storage driver.
Date: Thu,  1 Sep 2011 14:11:52 -0700
Message-ID: <1314911512-1079-1-git-send-email-mike.sterling@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devel@linuxdriverproject.org, virtualization@lists.osdl.org, gregkh@suse.de, linux-kernel@vger.kernel.org
Cc: Mike Sterling <mike.sterling@microsoft.com>, "K.Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

If a LUN larger than 2 TB is attached to a Linux VM on Hyper-V, we currently 
report a maximum size of 2 TB. This patch resolves the issue in hv_storvsc. 
Thanks to Robert Scheck <robert.scheck@etes.de> for reporting the issue.

Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: K.Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv_storage.h |    1 +
 drivers/staging/hv/storvsc_drv.c    |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv_storage.h b/drivers/staging/hv/hyperv_storage.h
index a01f9a0..5af82f4 100644
--- a/drivers/staging/hv/hyperv_storage.h
+++ b/drivers/staging/hv/hyperv_storage.h
@@ -218,6 +218,7 @@ struct vstor_packet {
 #define STORVSC_MAX_LUNS_PER_TARGET			64
 #define STORVSC_MAX_TARGETS				1
 #define STORVSC_MAX_CHANNELS				1
+#define STORVSC_MAX_CMD_LEN				16
 
 struct hv_storvsc_request;
 
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 7effaf3..26983ac 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -701,6 +701,8 @@ static int storvsc_probe(struct hv_device *device)
 	host->max_id = STORVSC_MAX_TARGETS;
 	/* max # of channels */
 	host->max_channel = STORVSC_MAX_CHANNELS - 1;
+	/* max cmd length */
+	host->max_cmd_len = STORVSC_MAX_CMD_LEN;
 
 	/* Register the HBA and start the scsi bus scan */
 	ret = scsi_add_host(host, &device->device);
-- 
1.7.1
