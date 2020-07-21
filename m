From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 05/10] block: null: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 13:52:34 +0300
Message-ID: <20200721105239.8270-6-mlevitsk@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200721105239.8270-1-mlevitsk@redhat.com>
Sender: linux-block-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wd>
List-Id: virtualization@lists.linuxfoundation.org

This slightly changes the behavier of the driver,
when given invalid block size (non power of two, or below 512 bytes),
but shoudn't matter.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/block/null_blk_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 87b31f9ca362e..e4df4b903b90b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1684,8 +1684,8 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 
 static int null_validate_conf(struct nullb_device *dev)
 {
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if (!blk_is_valid_logical_block_size(dev->blocksize))
+		return -ENODEV;
 
 	if (dev->queue_mode == NULL_Q_MQ && dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
@@ -1865,7 +1865,7 @@ static int __init null_init(void)
 	struct nullb *nullb;
 	struct nullb_device *dev;
 
-	if (g_bs > PAGE_SIZE) {
+	if (!blk_is_valid_logical_block_size(g_bs)) {
 		pr_warn("invalid block size\n");
 		pr_warn("defaults block size to %lu\n", PAGE_SIZE);
 		g_bs = PAGE_SIZE;
-- 
2.26.2
