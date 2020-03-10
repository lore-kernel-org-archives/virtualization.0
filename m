From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 17/24] aacraid: move scsi_add_host()
Date: Wed, 11 Mar 2020 00:25:43 +0800
Message-ID: <1583857550-12049-18-git-send-email-john.garry@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hannes Reinecke <hare@suse.de>

Move the call to scsi_add_host() so that the Scsi_Host structure
is initialized before any I/O is sent.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/aacraid/linit.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index ee6bc2f9b80a..0e084b09615d 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1676,6 +1676,9 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->unique_id = unique_id;
 	shost->max_cmd_len = 16;
 	shost->use_cmd_list = 1;
+	shost->max_id = MAXIMUM_NUM_CONTAINERS;
+	shost->max_lun = AAC_MAX_LUN;
+	shost->sg_tablesize = HBA_MAX_SG_SEPARATE;
 
 	if (aac_cfg_major == AAC_CHARDEV_NEEDS_REINIT)
 		aac_init_char();
@@ -1740,6 +1743,10 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_deinit;
 	}
 
+	error = scsi_add_host(shost, &pdev->dev);
+	if (error)
+		goto out_deinit;
+
 	aac->maximum_num_channels = aac_drivers[index].channels;
 	error = aac_get_adapter_info(aac);
 	if (error < 0)
@@ -1798,18 +1805,8 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!aac->sa_firmware && aac_drivers[index].quirks & AAC_QUIRK_SRC)
 		aac_intr_normal(aac, 0, 2, 0, NULL);
 
-	/*
-	 * dmb - we may need to move the setting of these parms somewhere else once
-	 * we get a fib that can report the actual numbers
-	 */
-	shost->max_lun = AAC_MAX_LUN;
-
 	pci_set_drvdata(pdev, shost);
 
-	error = scsi_add_host(shost, &pdev->dev);
-	if (error)
-		goto out_deinit;
-
 	aac_scan_host(aac);
 
 	pci_enable_pcie_error_reporting(pdev);
-- 
2.17.1
