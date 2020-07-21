From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 04/10] block: nbd: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 13:52:33 +0300
Message-ID: <20200721105239.8270-5-mlevitsk@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20200721105239.8270-1-mlevitsk@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wd>
List-Id: virtualization@lists.linuxfoundation.org

This allows to remove nbd's own check for valid block size

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/block/nbd.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ce7e9f223b20b..2cd9c4e824f8b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1347,14 +1347,6 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 		nbd_config_put(nbd);
 }
 
-static bool nbd_is_valid_blksize(unsigned long blksize)
-{
-	if (!blksize || !is_power_of_2(blksize) || blksize < 512 ||
-	    blksize > PAGE_SIZE)
-		return false;
-	return true;
-}
-
 static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
 {
 	nbd->tag_set.timeout = timeout * HZ;
@@ -1379,7 +1371,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_BLKSIZE:
 		if (!arg)
 			arg = NBD_DEF_BLKSIZE;
-		if (!nbd_is_valid_blksize(arg))
+		if (!blk_is_valid_logical_block_size(arg))
 			return -EINVAL;
 		nbd_size_set(nbd, arg,
 			     div_s64(config->bytesize, arg));
@@ -1811,7 +1803,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
 		if (!bsize)
 			bsize = NBD_DEF_BLKSIZE;
-		if (!nbd_is_valid_blksize(bsize)) {
+		if (!blk_is_valid_logical_block_size(bsize)) {
 			printk(KERN_ERR "Invalid block size %llu\n", bsize);
 			return -EINVAL;
 		}
-- 
2.26.2
