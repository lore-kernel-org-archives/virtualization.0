From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 07/10] block: mspro_blk: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 13:52:36 +0300
Message-ID: <20200721105239.8270-8-mlevitsk@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20200721105239.8270-1-mlevitsk@redhat.com>
Sender: linux-scsi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wd>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/memstick/core/mspro_block.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index cd6b8d4f23350..86c9eb0aef512 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1199,6 +1199,12 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 
 	msb->page_size = be16_to_cpu(sys_info->unit_size);
 
+	if (!(blk_is_valid_logical_block_size(msb->page_size))) {
+		dev_warn(&card->dev,
+			 "unsupported block size %d", msb->page_size);
+		return -EINVAL;
+	}
+
 	mutex_lock(&mspro_block_disk_lock);
 	disk_id = idr_alloc(&mspro_block_disk_idr, card, 0, 256, GFP_KERNEL);
 	mutex_unlock(&mspro_block_disk_lock);
-- 
2.26.2
