From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 24/24] scsi: hisi_sas: Use libsas slow task SCSI command
Date: Wed, 11 Mar 2020 00:25:50 +0800
Message-ID: <1583857550-12049-25-git-send-email-john.garry@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Sender: linux-block-owner@vger.kernel.org
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, John Garry <john.garry@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that a SCSI command can be allocated for a libsas slow tasks, make the
task prep code use it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 5 ++++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index c7951ac8b075..61039f3608c8 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -476,8 +476,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
 			} else {
 				scsi_cmnd = task->uldd_task;
 			}
+		} else if (task->slow_task) {
+			scsi_cmnd = task->slow_task->scmd;
 		}
-		rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
+		rc = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
 	}
 	if (rc < 0)
 		goto err_out_dif_dma_unmap;
@@ -2650,6 +2652,7 @@ int hisi_sas_probe(struct platform_device *pdev,
 	} else {
 		shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
 		shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
+		shost->nr_reserved_cmds = HISI_SAS_RESERVED_IPTT;
 	}
 
 	sha->sas_ha_name = DRV_NAME;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index a2debe0c8185..44530f8c0319 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3237,8 +3237,9 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_lun = ~0;
 	shost->max_channel = 1;
 	shost->max_cmd_len = 16;
-	shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
-	shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
+	shost->can_queue = HISI_SAS_MAX_COMMANDS;
+	shost->cmd_per_lun = HISI_SAS_MAX_COMMANDS;
+	shost->nr_reserved_cmds = HISI_SAS_RESERVED_IPTT;
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = dev;
-- 
2.17.1
