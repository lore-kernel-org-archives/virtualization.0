From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH v13 4/7] dm: enable synchronous dax
Date: Fri, 21 Jun 2019 19:04:52 +0530
Message-ID: <20190621133455.3303-5-pagupta__29428.7754384399$1561124352$gmane$org@redhat.com>
References: <20190621133455.3303-1-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190621133455.3303-1-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dm-devel@redhat.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: pagupta@redhat.com, rdunlap@infradead.org, jack@suse.cz, snitzer@redhat.com, mst@redhat.com, david@fromorbit.com, lcapitulino@redhat.com, adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com, dave.jiang@intel.com, jstaron@google.com, darrick.wong@oracle.com, vishal.l.verma@intel.com, willy@infradead.org, hch@infradead.org, jmoyer@redhat.com, nilal@redhat.com, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com, stefanha@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, tytso@mit.edu, xiaoguangrong.eric@gmail.com, cohuck@redhat.com, rjw@rjwysocki.net, imammedo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch sets dax device 'DAXDEV_SYNC' flag if all the target
devices of device mapper support synchrononous DAX. If device
mapper consists of both synchronous and asynchronous dax devices,
we don't set 'DAXDEV_SYNC' flag.

'dm_table_supports_dax' is refactored to pass 'iterate_devices_fn'
as argument so that the callers can pass the appropriate functions.

Suggested-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-table.c | 24 ++++++++++++++++++------
 drivers/md/dm.c       |  2 +-
 drivers/md/dm.h       |  5 ++++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 350cf0451456..81c55304c4fa 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -881,7 +881,7 @@ void dm_table_set_type(struct dm_table *t, enum dm_queue_mode type)
 EXPORT_SYMBOL_GPL(dm_table_set_type);
 
 /* validate the dax capability of the target device span */
-static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
+int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 				       sector_t start, sector_t len, void *data)
 {
 	int blocksize = *(int *) data;
@@ -890,7 +890,15 @@ static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 			start, len);
 }
 
-bool dm_table_supports_dax(struct dm_table *t, int blocksize)
+/* Check devices support synchronous DAX */
+static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
+				       sector_t start, sector_t len, void *data)
+{
+	return dax_synchronous(dev->dax_dev);
+}
+
+bool dm_table_supports_dax(struct dm_table *t,
+			  iterate_devices_callout_fn iterate_fn, int *blocksize)
 {
 	struct dm_target *ti;
 	unsigned i;
@@ -903,8 +911,7 @@ bool dm_table_supports_dax(struct dm_table *t, int blocksize)
 			return false;
 
 		if (!ti->type->iterate_devices ||
-		    !ti->type->iterate_devices(ti, device_supports_dax,
-			    &blocksize))
+			!ti->type->iterate_devices(ti, iterate_fn, blocksize))
 			return false;
 	}
 
@@ -940,6 +947,7 @@ static int dm_table_determine_type(struct dm_table *t)
 	struct dm_target *tgt;
 	struct list_head *devices = dm_table_get_devices(t);
 	enum dm_queue_mode live_md_type = dm_get_md_type(t->md);
+	int page_size = PAGE_SIZE;
 
 	if (t->type != DM_TYPE_NONE) {
 		/* target already set the table's type */
@@ -984,7 +992,7 @@ static int dm_table_determine_type(struct dm_table *t)
 verify_bio_based:
 		/* We must use this table as bio-based */
 		t->type = DM_TYPE_BIO_BASED;
-		if (dm_table_supports_dax(t, PAGE_SIZE) ||
+		if (dm_table_supports_dax(t, device_supports_dax, &page_size) ||
 		    (list_empty(devices) && live_md_type == DM_TYPE_DAX_BIO_BASED)) {
 			t->type = DM_TYPE_DAX_BIO_BASED;
 		} else {
@@ -1883,6 +1891,7 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			       struct queue_limits *limits)
 {
 	bool wc = false, fua = false;
+	int page_size = PAGE_SIZE;
 
 	/*
 	 * Copy table's limits to the DM device's request_queue
@@ -1910,8 +1919,11 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	}
 	blk_queue_write_cache(q, wc, fua);
 
-	if (dm_table_supports_dax(t, PAGE_SIZE))
+	if (dm_table_supports_dax(t, device_supports_dax, &page_size)) {
 		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
+		if (dm_table_supports_dax(t, device_synchronous, NULL))
+			set_dax_synchronous(t->md->dax_dev);
+	}
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b1caa7188209..b92c42a72ad4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1119,7 +1119,7 @@ static bool dm_dax_supported(struct dax_device *dax_dev, struct block_device *bd
 	if (!map)
 		return false;
 
-	ret = dm_table_supports_dax(map, blocksize);
+	ret = dm_table_supports_dax(map, device_supports_dax, &blocksize);
 
 	dm_put_live_table(md, srcu_idx);
 
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 17e3db54404c..0475673337f3 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -72,7 +72,10 @@ bool dm_table_bio_based(struct dm_table *t);
 bool dm_table_request_based(struct dm_table *t);
 void dm_table_free_md_mempools(struct dm_table *t);
 struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t);
-bool dm_table_supports_dax(struct dm_table *t, int blocksize);
+bool dm_table_supports_dax(struct dm_table *t, iterate_devices_callout_fn fn,
+			   int *blocksize);
+int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
+			   sector_t start, sector_t len, void *data);
 
 void dm_lock_md_type(struct mapped_device *md);
 void dm_unlock_md_type(struct mapped_device *md);
-- 
2.20.1
