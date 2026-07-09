Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB534229C3
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601103; cv=none; b=WhJLMqOG7+BhOfjtjMwuiLY9cyWPrS8iQ0FbOlO5q1CgtqY9LSlKYmxZdURgdWZVXQD6jnHprvOOJRDxFc3kZT3KyvZGKA84pqMo0TC2bhqgTtaJznFjPaDRIw8PSqNSWplxQmomPHgEOTLrSQ3E9uW/klIcLO8BN74ypWcv9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601103; c=relaxed/simple;
	bh=tnKvV/vZxy8BH/MfcsJskqhgvM9DHLyddVPTkpKAQEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQve3kTeyXULbJ0Jrpwcjq0WsdRSlub8wodin3bxXfl9H8wYwOMr1BCzXIH7GL50BXJ+obVAHac0PIzC8pdpYXXqjC62N77P0Ns9HcgJ1B+p6YTI1PY104feFIZzhxHr7Hje/a0Z6KrI3FTvfBXpQrjfiNpphNW6UPRajvLg0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uCDVldA6; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uCDVldA6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783601096; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=34FehkqTaypWLb4SszKCE3tIKNMiwKJMkGlsFA/v2Lo=;
	b=uCDVldA6j/xWuUkKWoI1VKSzZj+h5RM9HYqHRn2TM7A749xewNfpnYFllelOkeGBO46g+x1Umxok1u6Etb1WSodgHlkVzXWTppM6hwuzdLJstkELFdiCyogzW5Q1V2YO1qMOUxn7aOmsW5XV4JVNfaia0XVg2Qcsog8kp5cy30w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6kv1T5_1783601095;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X6kv1T5_1783601095 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 20:44:55 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Baokun Li <libaokun@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio-pmem: allocate flush bio from a driver-private bio_set
Date: Thu,  9 Jul 2026 20:44:55 +0800
Message-Id: <20260709124455.1547912-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

async_pmem_flush() allocates a child bio for the flush with GFP_ATOMIC.
This runs from pmem_submit_bio(), a ->submit_bio callback that executes
in a sleepable context, so there is no atomicity requirement here.

bio_alloc() only guarantees success when __GFP_DIRECT_RECLAIM is set,
because that is what lets it fall back to the mempool reserve. With
GFP_ATOMIC the reclaim bit is absent, so the allocation can fail and
return -ENOMEM whenever the fast paths (percpu cache and slab) are
exhausted, which is common right after boot. A flush is issued from
filesystem writeback and must not fail on a transient allocation
shortage, otherwise the device can appear unmountable:

  Buffer I/O error on dev pmem0, logical block 0, lost sync page write

Switch to GFP_NOIO so __GFP_DIRECT_RECLAIM is set and the allocation can
make forward progress. However, bio_alloc() draws from the shared
fs_bio_set, and the incoming bio being flushed may itself have come from
fs_bio_set; allocating a second bio from the same set while submitting
underneath ->submit_bio can deadlock the mempool. Add a driver-private
bio_set for the flush and allocate from it via bio_alloc_bioset(), so
the flush bio has an independent reserve.

With a dedicated mempool-backed bio_set and GFP_NOIO the allocation
cannot fail, so drop the now-redundant NULL check.

Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 drivers/nvdimm/nd_virtio.c   | 11 ++++++-----
 drivers/nvdimm/virtio_pmem.c | 11 ++++++++++-
 drivers/nvdimm/virtio_pmem.h |  4 ++++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 4176046627beb..b4bd21edf5c1c 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -110,17 +110,18 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 /* The asynchronous flush callback function */
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 {
+	struct virtio_device *vdev = nd_region->provider_data;
+	struct virtio_pmem *vpmem = vdev->priv;
+
 	/*
 	 * Create child bio for asynchronous flush and chain with
 	 * parent bio. Otherwise directly call nd_region flush.
 	 */
 	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(bio->bi_bdev, 0,
-					      REQ_OP_WRITE | REQ_PREFLUSH,
-					      GFP_ATOMIC);
+		struct bio *child = bio_alloc_bioset(bio->bi_bdev, 0,
+					REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO,
+					&vpmem->flush_bio_set);
 
-		if (!child)
-			return -ENOMEM;
 		bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
 		bio_chain(child, bio);
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 77b1966619059..136179506b478 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -65,12 +65,17 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	}
 
 	mutex_init(&vpmem->flush_lock);
+	err = bioset_init(&vpmem->flush_bio_set, BIO_POOL_SIZE, 0, 0);
+	if (err) {
+		dev_err(&vdev->dev, "failed to initialize flush bio_set\n");
+		goto out_err;
+	}
 	vpmem->vdev = vdev;
 	vdev->priv = vpmem;
 	err = init_vq(vpmem);
 	if (err) {
 		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
-		goto out_err;
+		goto out_bioset;
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
@@ -131,6 +136,8 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
 out_vq:
 	vdev->config->del_vqs(vdev);
+out_bioset:
+	bioset_exit(&vpmem->flush_bio_set);
 out_err:
 	return err;
 }
@@ -138,10 +145,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 static void virtio_pmem_remove(struct virtio_device *vdev)
 {
 	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
+	struct virtio_pmem *vpmem = vdev->priv;
 
 	nvdimm_bus_unregister(nvdimm_bus);
 	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	bioset_exit(&vpmem->flush_bio_set);
 }
 
 static int virtio_pmem_freeze(struct virtio_device *vdev)
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index f72cf17f9518f..4ff2076f75047 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -15,6 +15,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/bio.h>
 
 struct virtio_pmem_request {
 	struct virtio_pmem_req req;
@@ -39,6 +40,9 @@ struct virtio_pmem {
 	/* Serialize flush requests to the device. */
 	struct mutex flush_lock;
 
+	/* bio_set for allocating flush child bios */
+	struct bio_set flush_bio_set;
+
 	/* nvdimm bus registers virtio pmem device */
 	struct nvdimm_bus *nvdimm_bus;
 	struct nvdimm_bus_descriptor nd_desc;
-- 
2.39.3

