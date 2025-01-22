Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C3149E17
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563550; cv=none; b=j4+m2UAyVHR9YWeIIHd/K1WarifaV89NdEfKX3T/ysjl5Utk4LYPLEWJmZqWZ7uQqlpHwPM7z50kFZPdgEBylSES1HsrcfyxWbEpDnRA7pfMNjOjgi05ltVyIoib0TDKVAxuy7fhpQmnpRVnXyVQyJtVi8vPRJ3o+/UWESMrlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563550; c=relaxed/simple;
	bh=dJcrTLaIhSm06/w7Rb2OXHacLpnI7bbPNtqDYJVfSwQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhYvrabR901pIu24hYmOMD8vNa0rGRXZT3AdS0cywNTSkqB00GRD7xRx+i2Dg25CfDhXuQ31H6AEj3rIlTfmcrHx0BQ2muh5o4PhJ4L9C+4ZQNSWoI3y69a2hlN5SuTztXr7A9xLIEP8Y9HQwfqpjE4WQtQPZVeb/jF3XIFPL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrbhJwD9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrbhJwD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737563547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOi2nU03OjL6m+oXViwgMuIreX6sxSUQngyKksLYHek=;
	b=KrbhJwD9CZBLVAM5y9dVD0w4gq4Q6SIOsDWlaPFZKQ98sz5/HOEXk+okr4qvQeBLcl1jW1
	M0+Ij+IfBY4Y97Am+CHSHzBoePGiYdh5s0LNTyQpip7whb27YX86g5ATA/0uW0hrhzZKPC
	wi9YcBBlMovnebAfELWxtRCBke9KO6Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-spEJLsVYMgOeJtLWMUzgGw-1; Wed,
 22 Jan 2025 11:32:18 -0500
X-MC-Unique: spEJLsVYMgOeJtLWMUzgGw-1
X-Mimecast-MFC-AGG-ID: spEJLsVYMgOeJtLWMUzgGw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80AF2196A940;
	Wed, 22 Jan 2025 16:32:14 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.171])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9194A195608A;
	Wed, 22 Jan 2025 16:32:10 +0000 (UTC)
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
Subject: [RFC 3/5] virtiofs: Move stack sg to fuse_req
Date: Wed, 22 Jan 2025 17:31:52 +0100
Message-ID: <20250122163154.1225353-4-eperezma@redhat.com>
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

We need to move the map and unmap out of virtiofs queue lock.  We need to
store the unmap sgs to call virtqueue_unmap_sgs, so use the request
itself.

TODO: We need to store the forget sgs too.  In my tests it is not called
so we're safe.  Find a way to force-call it.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 fs/fuse/fuse_i.h    |  7 +++++++
 fs/fuse/virtio_fs.c | 45 +++++++++++++++++++++------------------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f2860..e57664daa761 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -18,6 +18,7 @@
 #include <linux/mount.h>
 #include <linux/wait.h>
 #include <linux/list.h>
+#include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/backing-dev.h>
@@ -434,6 +435,12 @@ struct fuse_req {
 #if IS_ENABLED(CONFIG_VIRTIO_FS)
 	/** virtio-fs's physically contiguous buffer for in and out args */
 	void *argbuf;
+
+	/** virtio-fs's pre-mapped stuff */
+	struct scatterlist sg_inline_data[6]; /* optimization for short requests */
+	struct scatterlist *sg;
+	unsigned int out_sgs;
+	unsigned int in_sgs;
 #endif
 
 	/** fuse_mount this request belongs to */
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78ec542..1344c5782a7c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1377,14 +1377,10 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 {
 	/* requests need at least 4 elements */
 	struct scatterlist *stack_sgs[6];
-	struct scatterlist stack_sg[ARRAY_SIZE(stack_sgs)];
 	struct scatterlist **sgs = stack_sgs;
-	struct scatterlist *sg = stack_sg;
 	struct virtqueue *vq;
 	struct fuse_args *args = req->args;
 	unsigned int argbuf_used = 0;
-	unsigned int out_sgs = 0;
-	unsigned int in_sgs = 0;
 	unsigned int total_sgs;
 	unsigned int i;
 	int ret;
@@ -1392,11 +1388,13 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	struct fuse_pqueue *fpq;
 
 	/* Does the sglist fit on the stack? */
+	/* TODO replace magic 6 by a macro */
+	req->sg = req->sg_inline_data;
 	total_sgs = sg_count_fuse_req(req);
-	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
+	if (total_sgs > 6) {
 		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), gfp);
-		sg = kmalloc_array(total_sgs, sizeof(sg[0]), gfp);
-		if (!sgs || !sg) {
+		req->sg = kmalloc_array(total_sgs, sizeof(req->sg[0]), gfp);
+		if (!sgs || !req->sg) {
 			ret = -ENOMEM;
 			goto out;
 		}
@@ -1408,26 +1406,25 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		goto out;
 
 	/* Request elements */
-	sg_init_one(&sg[out_sgs++], &req->in.h, sizeof(req->in.h));
-	out_sgs += sg_init_fuse_args(&sg[out_sgs], req,
-				     (struct fuse_arg *)args->in_args,
-				     args->in_numargs, args->in_pages,
-				     req->argbuf, &argbuf_used);
+	sg_init_one(&req->sg[req->out_sgs++], &req->in.h, sizeof(req->in.h));
+	req->out_sgs += sg_init_fuse_args(&req->sg[req->out_sgs], req,
+					  (struct fuse_arg *)args->in_args,
+					  args->in_numargs, args->in_pages,
+					  req->argbuf, &argbuf_used);
 
 	/* Reply elements */
 	if (test_bit(FR_ISREPLY, &req->flags)) {
-		sg_init_one(&sg[out_sgs + in_sgs++],
+		sg_init_one(&req->sg[req->out_sgs + req->in_sgs++],
 			    &req->out.h, sizeof(req->out.h));
-		in_sgs += sg_init_fuse_args(&sg[out_sgs + in_sgs], req,
-					    args->out_args, args->out_numargs,
-					    args->out_pages,
-					    req->argbuf + argbuf_used, NULL);
+		req->in_sgs += sg_init_fuse_args(&req->sg[req->out_sgs + req->in_sgs], req,
+						 args->out_args, args->out_numargs,
+						 args->out_pages,
+						 req->argbuf + argbuf_used, NULL);
 	}
 
-	WARN_ON(out_sgs + in_sgs != total_sgs);
-
 	for (i = 0; i < total_sgs; i++)
-		sgs[i] = &sg[i];
+		sgs[i] = &req->sg[i];
+	WARN_ON(req->out_sgs + req->in_sgs != total_sgs);
 
 	spin_lock(&fsvq->lock);
 
@@ -1438,7 +1435,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	}
 
 	vq = fsvq->vq;
-	ret = virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_ATOMIC);
+	ret = virtqueue_add_sgs(vq, sgs, req->out_sgs, req->in_sgs, req, GFP_ATOMIC);
 	if (ret < 0) {
 		spin_unlock(&fsvq->lock);
 		goto out;
@@ -1467,10 +1464,10 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		kfree(req->argbuf);
 		req->argbuf = NULL;
 	}
-	if (sgs != stack_sgs) {
+	if (ret < 0 && req->sg != req->sg_inline_data)
+		kfree(req->sg);
+	if (sgs != stack_sgs)
 		kfree(sgs);
-		kfree(sg);
-	}
 
 	return ret;
 }
-- 
2.48.1

