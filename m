Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC824BD02
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793869; cv=none; b=AMeRuvtX6SWHZGNSH0TM3exBDUZY0pfNWpH5rzWKjk4428Zjh6ps7W4FbjTyf1OK7EpTvB3CqnA9Y0SPWHlWhbtypAZnnicJrQa2YpSn0qkOBExLT5FWDGj5bAB3Di0menkNjSYWGZu4VatTBwFb4UEafHeVZaIjEckCGmLYnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793869; c=relaxed/simple;
	bh=283HEQqRYfIsNiaMfyVunhuCtCyn94g73x9xYXlByAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jYIGPJ2LAiM4bY2WUvJwmuUrIpoJEPavfxTLcj1UD5zwTVJ1VA/jfN4NKEFyuYh05Dd9dHsmQS3TkS7RWG1/s6mhEAI/fK0/5uD8s+mTrSBaJsA4FhTn3iOLKjTaa4gDHGiAddMHpmL9/y+/145tTkDwJ/Eznpz+IUZA0m3ebOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>,
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
Date: Fri, 13 Jun 2025 13:50:51 +0800
Message-ID: <20250613055051.1873-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.51.57
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since clear_bit is an atomic operation, the spinlock is redundant and
can be removed, reducing lock contention is good for performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/fuse/virtio_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8f2e2f3..de34179 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -791,9 +791,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 		}
 	}
 
-	spin_lock(&fpq->lock);
 	clear_bit(FR_SENT, &req->flags);
-	spin_unlock(&fpq->lock);
 
 	fuse_request_end(req);
 	spin_lock(&fsvq->lock);
-- 
2.9.4

