From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 10/10] block: scsi: sr: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 13:52:39 +0300
Message-ID: <20200721105239.8270-11-mlevitsk@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20200721105239.8270-1-mlevitsk@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wd>
List-Id: virtualization@lists.linuxfoundation.org

Plus some tiny refactoring.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/scsi/sr.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 0c4aa4665a2f9..0e96338029310 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -866,31 +866,26 @@ static void get_sectorsize(struct scsi_cd *cd)
 			cd->capacity = max_t(long, cd->capacity, last_written);
 
 		sector_size = get_unaligned_be32(&buffer[4]);
-		switch (sector_size) {
-			/*
-			 * HP 4020i CD-Recorder reports 2340 byte sectors
-			 * Philips CD-Writers report 2352 byte sectors
-			 *
-			 * Use 2k sectors for them..
-			 */
-		case 0:
-		case 2340:
-		case 2352:
+
+		/*
+		 * HP 4020i CD-Recorder reports 2340 byte sectors
+		 * Philips CD-Writers report 2352 byte sectors
+		 *
+		 * Use 2k sectors for them..
+		 */
+
+		if (!sector_size || sector_size == 2340 || sector_size == 2352)
 			sector_size = 2048;
-			/* fall through */
-		case 2048:
-			cd->capacity *= 4;
-			/* fall through */
-		case 512:
-			break;
-		default:
+
+		cd->capacity *= (sector_size >> SECTOR_SHIFT);
+
+		if (!blk_is_valid_logical_block_size(sector_size)) {
 			sr_printk(KERN_INFO, cd,
 				  "unsupported sector size %d.", sector_size);
 			cd->capacity = 0;
 		}
 
 		cd->device->sector_size = sector_size;
-
 		/*
 		 * Add this so that we have the ability to correctly gauge
 		 * what the device is capable of.
-- 
2.26.2
