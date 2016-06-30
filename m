From: Fam Zheng <famz@redhat.com>
Subject: [PATCH v2 11/12] mtd: Generate uevent after attribute available
Date: Thu, 30 Jun 2016 09:59:52 +0800
Message-ID: <20160630015953.6888-12-famz__47514.8692880341$1467252145$gmane$org@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>, Shaohua Li <shli@kernel.org>, Nitin Gupta <ngupta@vflare.org>, famz@redhat.com, Jiri Kosina <jikos@kernel.org>, linux-block@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-mmc@vger.kernel.org, Minchan Kim <minchan@kernel.org>, linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/mtd/mtd_blkdevs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index ab3bc22..6848141 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -436,13 +436,14 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
-	add_disk(gd, true);
+	add_disk(gd, false);
 
 	if (new->disk_attributes) {
 		ret = sysfs_create_group(&disk_to_dev(gd)->kobj,
 					new->disk_attributes);
 		WARN_ON(ret);
 	}
+	disk_gen_uevents(gd);
 	return 0;
 error4:
 	blk_cleanup_queue(new->rq);
-- 
2.9.0
