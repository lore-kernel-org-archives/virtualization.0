From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 11/24] hpsa: move hpsa_hba_inquiry after scsi_add_host()
Date: Wed, 11 Mar 2020 00:25:37 +0800
Message-ID: <1583857550-12049-12-git-send-email-john.garry@huawei.com>
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

Move hpsa_hba_inquiry to after scsi_add_host() so that the host
is fully initialized.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/hpsa.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 1a4ddfacb458..703f824584fe 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5814,6 +5814,22 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 	return 0;
 }
 
+static void hpsa_hba_inquiry(struct ctlr_info *h)
+{
+	int rc;
+
+#define HBA_INQUIRY_BYTE_COUNT 64
+	h->hba_inquiry_data = kmalloc(HBA_INQUIRY_BYTE_COUNT, GFP_KERNEL);
+	if (!h->hba_inquiry_data)
+		return;
+	rc = hpsa_scsi_do_inquiry(h, RAID_CTLR_LUNID, 0,
+		h->hba_inquiry_data, HBA_INQUIRY_BYTE_COUNT);
+	if (rc != 0) {
+		kfree(h->hba_inquiry_data);
+		h->hba_inquiry_data = NULL;
+	}
+}
+
 static int hpsa_scsi_add_host(struct ctlr_info *h)
 {
 	int rv;
@@ -5823,6 +5839,9 @@ static int hpsa_scsi_add_host(struct ctlr_info *h)
 		dev_err(&h->pdev->dev, "scsi_add_host failed\n");
 		return rv;
 	}
+
+	hpsa_hba_inquiry(h);
+
 	scsi_scan_host(h->scsi_host);
 	return 0;
 }
@@ -7899,22 +7918,6 @@ static int hpsa_pci_init(struct ctlr_info *h)
 	return err;
 }
 
-static void hpsa_hba_inquiry(struct ctlr_info *h)
-{
-	int rc;
-
-#define HBA_INQUIRY_BYTE_COUNT 64
-	h->hba_inquiry_data = kmalloc(HBA_INQUIRY_BYTE_COUNT, GFP_KERNEL);
-	if (!h->hba_inquiry_data)
-		return;
-	rc = hpsa_scsi_do_inquiry(h, RAID_CTLR_LUNID, 0,
-		h->hba_inquiry_data, HBA_INQUIRY_BYTE_COUNT);
-	if (rc != 0) {
-		kfree(h->hba_inquiry_data);
-		h->hba_inquiry_data = NULL;
-	}
-}
-
 static int hpsa_init_reset_devices(struct pci_dev *pdev, u32 board_id)
 {
 	int rc, i;
@@ -8810,8 +8813,6 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Turn the interrupts on so we can service requests */
 	h->access.set_intr_mask(h, HPSA_INTR_ON);
 
-	hpsa_hba_inquiry(h);
-
 	h->lastlogicals = kzalloc(sizeof(*(h->lastlogicals)), GFP_KERNEL);
 	if (!h->lastlogicals)
 		dev_info(&h->pdev->dev,
-- 
2.17.1
