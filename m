Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A6151CDB
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131249; cv=none; b=qkp3Gz1gxEUAd8LSqnPeu5k08BHjagu8g92BBsHqiuMrpsMbO9QZzs1sE13w1oMC/AAx39rvDzSz0bSXFemhkOuz7dCsr7FizTuceb6bb6nHejqVfl1hqaflGHraNuNeHaWqeB/2qVA2iwo3FZeFIMVGhNax06k2VpXqQ9bYg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131249; c=relaxed/simple;
	bh=MfpUPQ3tl/f5UmupFztvkyZZv7LY1g0CBIcSjcfAuK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOyXAkRcvthhhfj8Y4eIenLBNh7Sl1XjdtITNt3QuB3USDk2MG1vtW+375VSbMORONqdtrwUPcteMKbO0sBtrtL1aiPHSFltPwztT5KUbZESbzu8YBorXKKH9jnA+wlLxc7Q/poBeE9s1M/DR3AeBhRmGJXRS9kpdURpGq+VeeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TlH8R4VW8z4f3jdG
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 22:40:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D7A891A0568
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 22:40:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHkRd9lwGKzFQ--.18779S10;
	Wed, 28 Feb 2024 22:40:44 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: [PATCH v2 6/6] virtiofs: use GFP_NOFS when enqueuing request through kworker
Date: Wed, 28 Feb 2024 22:41:26 +0800
Message-Id: <20240228144126.2864064-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240228144126.2864064-1-houtao@huaweicloud.com>
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBHkRd9lwGKzFQ--.18779S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4kXrWUAr1rGryrAF1rXrb_yoW5tF4xpr
	WkAa15GFZ5JrW2gFWkKF4UCw4Ykw1kCrW7G34fX3sIkr4jqw47uFyUZFy0qFsavrykAF1x
	WF4FqF4DuFsrZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When invoking virtio_fs_enqueue_req() through kworker, both the
allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
Considering the size of the sg array may be greater than PAGE_SIZE, use
GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
allocation failure and to avoid unnecessarily depleting the atomic
reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
use GFP_KERNEL and memalloc_nofs_{save|restore} helpers instead.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/virtio_fs.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 34b9370beba6d..9ee71051c89f2 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -108,7 +108,8 @@ struct virtio_fs_argbuf {
 };
 
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req, bool in_flight);
+				 struct fuse_req *req, bool in_flight,
+				 gfp_t gfp);
 
 static const struct constant_table dax_param_enums[] = {
 	{"always",	FUSE_DAX_ALWAYS },
@@ -394,6 +395,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 
 	/* Dispatch pending requests */
 	while (1) {
+		unsigned int flags;
+
 		spin_lock(&fsvq->lock);
 		req = list_first_entry_or_null(&fsvq->queued_reqs,
 					       struct fuse_req, list);
@@ -404,7 +407,9 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 		list_del_init(&req->list);
 		spin_unlock(&fsvq->lock);
 
-		ret = virtio_fs_enqueue_req(fsvq, req, true);
+		flags = memalloc_nofs_save();
+		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL);
+		memalloc_nofs_restore(flags);
 		if (ret < 0) {
 			if (ret == -ENOMEM || ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
@@ -1332,7 +1337,8 @@ static bool use_scattered_argbuf(struct fuse_req *req)
 
 /* Add a request to a virtqueue and kick the device */
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
-				 struct fuse_req *req, bool in_flight)
+				 struct fuse_req *req, bool in_flight,
+				 gfp_t gfp)
 {
 	/* requests need at least 4 elements */
 	struct scatterlist *stack_sgs[6];
@@ -1364,8 +1370,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	total_sgs = sg_count_fuse_req(req, in_args_len, out_args_len,
 				      flat_argbuf);
 	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
-		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
-		sg = kmalloc_array(total_sgs, sizeof(sg[0]), GFP_ATOMIC);
+		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), gfp);
+		sg = kmalloc_array(total_sgs, sizeof(sg[0]), gfp);
 		if (!sgs || !sg) {
 			ret = -ENOMEM;
 			goto out;
@@ -1373,8 +1379,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Use a bounce buffer since stack args cannot be mapped */
-	req->argbuf = virtio_fs_argbuf_new(in_args_len, out_args_len,
-					   GFP_ATOMIC, flat_argbuf);
+	req->argbuf = virtio_fs_argbuf_new(in_args_len, out_args_len, gfp,
+					   flat_argbuf);
 	if (!req->argbuf) {
 		ret = -ENOMEM;
 		goto out;
@@ -1473,7 +1479,7 @@ __releases(fiq->lock)
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
 	fsvq = &fs->vqs[queue_id];
-	ret = virtio_fs_enqueue_req(fsvq, req, false);
+	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
 			/*
-- 
2.29.2

