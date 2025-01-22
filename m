Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D10215190
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563553; cv=none; b=UnRqV0Gvl8xGCQwFkD26ZVyk6yIllqCu28BI12V/qOpZoVJqijMgvaR6oYqIl+PPeLNlpS3weWJdqUAIPUtrtcL8HN9J5FzyH82BOR8zvvZlFFL29vzCZscbNEhmA/uE2pSu8B2WjAciCz2uL/YMOQrV85oQq3rl39iNgQZr8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563553; c=relaxed/simple;
	bh=X7WuejYrNLGbPdGmSl/hQJAVJY+nCsQOinXwdcwRx34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXlb2QWYBccmX7YWJc1qgpHnbRIrJ7mlCBzI3+UrBgXLzGHxQbyuS9ycY/KlzYhrirQm+ukHhbjopvUyzlIJr7CajvCWMjyvqzj3SsErffy4lmjx22KkbYKQHwJeuK7spLcC9EgKx3FM4TNQulNp+icsBu5rC06u9uNELFJoILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVWUeVbT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVWUeVbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737563550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBhkAUsYGe18p0NTj+xot2gFPpqUS6sdPO7V3+k7KyY=;
	b=dVWUeVbT67A0frR7yb7amDYS350m4tfQtxMAAvnku9pa9l9vZN+6oaDXqrB+vx9oB2pxSX
	3/ccO1MUHVGzfK8y622cJqS2V/uAEXMjB3nsIntOicdKLq4c5TD0+uotRDqob1rloyL1V0
	hlHMtvyxBbFQ/OZAF3KHVWloCiu/JBI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-u1MiQJYYPzCUFobrBgtMPw-1; Wed,
 22 Jan 2025 11:32:24 -0500
X-MC-Unique: u1MiQJYYPzCUFobrBgtMPw-1
X-Mimecast-MFC-AGG-ID: u1MiQJYYPzCUFobrBgtMPw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49D361955D9C;
	Wed, 22 Jan 2025 16:32:23 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.171])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BD9A195608A;
	Wed, 22 Jan 2025 16:32:19 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	Hanna Reitz <hreitz@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev
Subject: [RFC 5/5] virtiofs: perform DMA operations out of the spinlock
Date: Wed, 22 Jan 2025 17:31:54 +0100
Message-ID: <20250122163154.1225353-6-eperezma@redhat.com>
In-Reply-To: <20250122163154.1225353-1-eperezma@redhat.com>
References: <20250122163154.1225353-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This is useful for some setups like swiotlb or VDUSE where the DMA
operations are expensive and/or need to be performed with a write lock.

After applying this patch, fio read test goes from 1201MiB/s to 1211MiB/s.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/virtio/virtio_ring.c |  2 ++
 fs/fuse/virtio_fs.c          | 25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e49912fa77c5..eb22bfcb9100 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -580,6 +580,7 @@ int virtqueue_map_sgs(struct virtqueue *_vq,
 				goto unmap_release;
 
 			sg_dma_address(sg) = addr;
+			sg_dma_len(sg) = sg->length;
 			mapped_sg++;
 		}
 	}
@@ -592,6 +593,7 @@ int virtqueue_map_sgs(struct virtqueue *_vq,
 				goto unmap_release;
 
 			sg_dma_address(sg) = addr;
+			sg_dma_len(sg) = sg->length;
 			mapped_sg++;
 		}
 	}
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1344c5782a7c..2b558b05d0f8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -836,8 +836,21 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 
 	/* End requests */
 	list_for_each_entry_safe(req, next, &reqs, list) {
+		struct scatterlist *stack_sgs[6];
+		struct scatterlist **sgs = stack_sgs;
+		unsigned int total_sgs = req->out_sgs + req->in_sgs;
+
 		list_del_init(&req->list);
 
+		/* TODO replace magic 6 by a macro */
+		if (total_sgs > 6)
+			sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
+
+		for (unsigned int i = 0; i < total_sgs; ++i)
+			sgs[i] = &req->sg[i];
+
+		virtqueue_unmap_sgs(vq, sgs, req->out_sgs, req->in_sgs);
+
 		/* blocking async request completes in a worker context */
 		if (req->args->may_block) {
 			struct virtio_fs_req_work *w;
@@ -850,6 +863,9 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		} else {
 			virtio_fs_request_complete(req, fsvq);
 		}
+
+		if (sgs != stack_sgs)
+			kfree(sgs);
 	}
 
 	/* Try to push previously queued requests, as the queue might no longer be full */
@@ -1426,6 +1442,11 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		sgs[i] = &req->sg[i];
 	WARN_ON(req->out_sgs + req->in_sgs != total_sgs);
 
+	// TODO can we change this ptr out of the lock?
+	vq = fsvq->vq;
+	// TODO handle this and following errors
+	ret = virtqueue_map_sgs(vq, sgs, req->out_sgs, req->in_sgs);
+	BUG_ON(ret < 0);
 	spin_lock(&fsvq->lock);
 
 	if (!fsvq->connected) {
@@ -1434,8 +1455,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		goto out;
 	}
 
-	vq = fsvq->vq;
-	ret = virtqueue_add_sgs(vq, sgs, req->out_sgs, req->in_sgs, req, GFP_ATOMIC);
+	ret = virtqueue_add_sgs_premapped(vq, sgs, req->out_sgs,
+					  req->in_sgs, req, GFP_ATOMIC);
 	if (ret < 0) {
 		spin_unlock(&fsvq->lock);
 		goto out;
-- 
2.48.1

