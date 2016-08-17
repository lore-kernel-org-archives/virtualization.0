From: Fam Zheng <famz@redhat.com>
Subject: [PATCH 11/15] zram: Pass attribute group to device_add_disk
Date: Wed, 17 Aug 2016 15:15:11 +0800
Message-ID: <1471418115-3654-12-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, virtualization@lists.linux-foundation.org, linux-nvme@lists.infradead.org, "Ed L. Cashin" <ed.cashin@acm.org>, Keith Busch <keith.busch@intel.com>, Minchan Kim <minchan@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>, Nitin Gupta <ngupta@vflare.org>
List-Id: virtualization@lists.linuxfoundation.org

Previously after device_add_disk returns, the KOBJ_ADD uevent is already
emitted. Adding attributes after that is a poor usage of kobject, and
in practice may result in race conditions with userspace, for
example udev checks availability of certain attributes and initializes
/dev entries conditionally.

device_add_disk can handle adding attribute group better, so use it.
Meanwhile, update the error check code and message.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/block/zram/zram_drv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 20920a2..2331788 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1298,13 +1298,10 @@ static int zram_add(void)
 		zram->disk->queue->limits.discard_zeroes_data = 0;
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
 
-	device_add_disk(NULL, zram->disk, NULL);
+	ret = device_add_disk(NULL, zram->disk, &zram_disk_attr_group);
 
-	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
-				&zram_disk_attr_group);
 	if (ret < 0) {
-		pr_err("Error creating sysfs group for device %d\n",
-				device_id);
+		pr_err("Error creating disk %d\n", device_id);
 		goto out_free_disk;
 	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
-- 
2.7.4
