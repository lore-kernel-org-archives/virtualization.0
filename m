Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099BF1BC07A
	for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749993668; cv=none; b=J5/J2VUGzEJK9aXslxDs3qI7wvuQpbIMO/0L/T606X4823MjpQU1XG1c0T4wIECMS9O9aoF2APV2xdN+qIDdlPbAlWCoMN8Zy4XdFEfp5e7C1pLmIDk8JghxVDStMtYRXHIooCGF0zomtjCNS1xc8Ab1K+uqVA27jfAiMcOjgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749993668; c=relaxed/simple;
	bh=bm9j9HkN3DmglJ1pTLJS9Rx8RMb/Sg5+HWlI77noIqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JINL25GmS1wTDJljWwdFRSn8ueUUCFcBbKev7/U8Q6TcZ/STQzN7MS05NPVvKRk+Zo/axDP/oQ5HUIWuM1S1BmC+nM1lhiY1WR5yw103drqYaLSN5G47ExmZiKDJmg3Y9iUA/YMZlvQOWXZ2LBX0VuMMTftyfXpjlRd2hf5DpC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>,
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
Date: Sun, 15 Jun 2025 21:20:39 +0800
Message-ID: <20250615132039.2051-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.42
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since clear_bit is an atomic operation, the spinlock is redundant and
can be removed, reducing lock contention is good for performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: remove unused variable "fpq"

 fs/fuse/virtio_fs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 53c2626..b8a99d3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -762,7 +762,6 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 static void virtio_fs_request_complete(struct fuse_req *req,
 				       struct virtio_fs_vq *fsvq)
 {
-	struct fuse_pqueue *fpq = &fsvq->fud->pq;
 	struct fuse_args *args;
 	struct fuse_args_pages *ap;
 	unsigned int len, i, thislen;
@@ -791,9 +790,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 		}
 	}
 
-	spin_lock(&fpq->lock);
 	clear_bit(FR_SENT, &req->flags);
-	spin_unlock(&fpq->lock);
 
 	fuse_request_end(req);
 	spin_lock(&fsvq->lock);
-- 
2.9.4

