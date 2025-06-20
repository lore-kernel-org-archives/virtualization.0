Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3871CAA6D
	for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420197; cv=none; b=rdrucopi8x0lbjSEud3hg9/CfkD6PxtkR8+69WZyJac1+0sxvdGCPgMeelp4+8YbHu1p6pzqNIm80k1v7xGLSR3UKoglHEdqO6LFiC6FAFxk8wJzc+1NfIvYGP6iE4H/aCGG1F9eISZnBfREVbmRRDQpZ016bmUon1RLCUEIrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420197; c=relaxed/simple;
	bh=nkpgK2qx0Maj3Ks5WDMYbHXp9o2yShyl8cyss/4J/sQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DGGADXtRUjxfcTnIqC9Vi6I8i/jvgq8gHdorwzPGFpMefdKok51K3uiL4csKG4Xv9aOnw4MlMoE/+u1IhryT4GXd0xkxZH7qljrtA9cjwrIDFLSyJ9yRNIuUS/DczQ2u7IvP/Y+UVAJ3e59txg0smYynsKIE9S1gsETFPT2V9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>,
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_fs: Remove request addition to processing list
Date: Fri, 20 Jun 2025 19:49:25 +0800
Message-ID: <20250620114925.2671-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.41
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since virtio_fs does not utilize the fuse_pqueue->processing list, we
can safely omit adding requests to this list. This change eliminates the
associated spin_lock operations, thereby improving performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/fuse/virtio_fs.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78..7a598ea5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -814,7 +814,6 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 {
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 done_work);
-	struct fuse_pqueue *fpq = &fsvq->fud->pq;
 	struct virtqueue *vq = fsvq->vq;
 	struct fuse_req *req;
 	struct fuse_req *next;
@@ -827,9 +826,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
-			spin_lock(&fpq->lock);
-			list_move_tail(&req->list, &reqs);
-			spin_unlock(&fpq->lock);
+			list_add_tail(&req->list, &reqs);
 		}
 	} while (!virtqueue_enable_cb(vq));
 	spin_unlock(&fsvq->lock);
@@ -1389,7 +1386,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	unsigned int i;
 	int ret;
 	bool notify;
-	struct fuse_pqueue *fpq;
 
 	/* Does the sglist fit on the stack? */
 	total_sgs = sg_count_fuse_req(req);
@@ -1445,10 +1441,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	/* Request successfully sent. */
-	fpq = &fsvq->fud->pq;
-	spin_lock(&fpq->lock);
-	list_add_tail(&req->list, fpq->processing);
-	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
-- 
2.9.4

