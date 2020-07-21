From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 09/10] block: scsi: sd: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 13:52:38 +0300
Message-ID: <20200721105239.8270-10-mlevitsk@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20200721105239.8270-1-mlevitsk@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wd>
List-Id: virtualization@lists.linuxfoundation.org

Use blk_is_valid_logical_block_size instead of hardcoded list

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/scsi/sd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d90fefffe31b7..f012e7397b058 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2520,10 +2520,7 @@ sd_read_capacity(struct scsi_disk *sdkp, unsigned char *buffer)
 			  "assuming 512.\n");
 	}
 
-	if (sector_size != 512 &&
-	    sector_size != 1024 &&
-	    sector_size != 2048 &&
-	    sector_size != 4096) {
+	if (!blk_is_valid_logical_block_size(sector_size)) {
 		sd_printk(KERN_NOTICE, sdkp, "Unsupported sector size %d.\n",
 			  sector_size);
 		/*
-- 
2.26.2
