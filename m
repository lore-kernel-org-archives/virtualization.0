Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176644DB61
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514573; cv=none; b=tvz4PLBsyG2vfUZ4lpz8XTH6fkAn9FjgfpU/sQr53oQ/UGCMHuhy6OFwSYSOwqlDTJfI9DqlQKNmoN9w5Ak2QPeXrdxho8ggSzqYR1FxU8qEaWQL1uhg/7WehOHFb/WJuGE4RAJS5ASdL4hxP5dWvtJa87aRSCgE5Iz1tAVzzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514573; c=relaxed/simple;
	bh=wc5dMccfHPF0jIPZMDVvuA87gFW2r3aVCzVRbysTLGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mU51yScyxS/PiyWMYeLMWCv9e2cjANn8cQJc0z9OF2izYO62Mx3UoR0NWy4gkPGd16i6Ir/BXe6HbvUEr/dLSRuGLg5DXS+x3uohb8liluFGedvqiGqlXuWNkdj48M+vsvWeRiSbXV/3yhBdfMCjauQoymXgufm3gHJlRLRT+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HCMjvU/T; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HCMjvU/T"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783514559; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xl39llvOjZ+te2FM23tMR1giAaMYkB/GLxejG0vyU78=;
	b=HCMjvU/TzeEdLWwxEvEoFMv2dEsQTg5E1ubE0cMfuKjkkYS1iEV0y4XIVH19yVBSQOvSVZPPfFAtzKDF7ay0A/gQdJ/R8fehhjUlSCuiaHvmKbdfCxGsakm0C7VyDaCG1bpdpLW5PYeoyzn8PCw2PZefkkKp03Jo6Qawm/2o/HI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6hfQBi_1783514558;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X6hfQBi_1783514558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 20:42:38 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Baokun Li <libaokun@linux.alibaba.com>
Subject: [PATCH] virtio-pmem: use GFP_NOIO for flush bio allocation
Date: Wed,  8 Jul 2026 20:42:38 +0800
Message-Id: <20260708124238.2817165-1-joseph.qi@linux.alibaba.com>
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

Use GFP_NOIO instead. It keeps __GFP_DIRECT_RECLAIM so the mempool and
rescuer machinery guarantee forward progress, while avoiding recursion
back into the filesystem and block layer during writeback.

Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 drivers/nvdimm/nd_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 4176046627beb..081370aac6317 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -117,7 +117,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 	if (bio && bio->bi_iter.bi_sector != -1) {
 		struct bio *child = bio_alloc(bio->bi_bdev, 0,
 					      REQ_OP_WRITE | REQ_PREFLUSH,
-					      GFP_ATOMIC);
+					      GFP_NOIO);
 
 		if (!child)
 			return -ENOMEM;
-- 
2.39.3

