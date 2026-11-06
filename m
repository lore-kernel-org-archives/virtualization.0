Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971195;
	b=giQHwn2Lys7qLLS8wWH0D99hySG8tiZ50HukAC9IdlzK1vOjw/yyGwaZnHD4uC01qR+y
	 F2gv0saT3Suwco5b2MRQ2zsVwn+9k81u80fB975873H/Kd+aXarnUYhKwvbg3x+8D907X
	 ZNoskyzstSSzuuJYYFs+8niOPEY6Vg5E5U+k3/zAEAPRdlv80jkxbb85FHHmzkVT+5ELP
	 Gyjo9R6xymG5TGthktP7YpAhedNZa9VQu+2JOHCD6viimyQg3gczTISHPqqsIIEbH9XxU
	 ixZJe4TOs6pw1mjHsZzwUD+oPAhLRse6Pew5f3S8QVLbBbHLuZlVVGJC2FOAI7sVrxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971195;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CYfB1FwPouVvSzabiejXQPBqorI59dDF0aM5IPAqcsI=;
	b=5FojKj9qXMqPYzbUDChifCTe/aAph++I0UUYNcmKnm6Ej6ocHiaYjdpkKwUZStfl7Srf
	 L5/2gjey3Uy8UT0Jg7i9lx2WWMjmC9ZZXTOiqNRWU2NrAUU87KYgdaX2H7UDjhSJKZE2z
	 B7mQaHpPcScVdgTA9PBoA2U8wzfcFhwkuhRVXmb7LAH5JcGwUixYnqnwj63SMCxOAqQOa
	 s+Yjc0ECMyWbbEJK1jGsaiz5z6ZPYQuDExHeFStDNmdnlb6QSxCtuVSs7sInQCB5Biz1C
	 ZbsJnZkGFORrdgKmH4YWfXXIKSK8luPxnPA8k/dyfGVfS6Z/5IvMl/a3zJ2chhVYklw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OBh2yzfS;
	arc=none smtp.remote-ip=91.218.175.94
Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50096606A33F
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 13:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50096606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OBh2yzfS
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=73QCibDvpuaBGtRTNbIkxL+btURCG2VkLUsjiT9bmAg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971192; v=1; x=1794575992;
 b=OBh2yzfS4sOkxhGkT+JBPca55NoqbHEL9VIcAcbEj1J1rXgOoQHQgV3Mcnc02kQNXVO902W+
 noDVT/X6o8QePW+IXif0wVhRtAIt7pCstFsBd5LRqmTL17bi9HehYz49UEdj6gHklLbJYcIOxCM
 FPVWpW0g4r5YYg1Ao8bNZ4dk=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b2c073d8feb08521;
	Fri, 06 Nov 2026 13:19:52 +0000
X-Mizu-Trace-ID: b2c073d8feb08521
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: akpm@linux-foundation.org,
	dgilbert@interlog.com,
	mkp@kernel.org,
	loberman@redhat.com,
	jmeneghi@redhat.com,
	kraxel@redhat.com,
	vivek.kasireddy@intel.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	rostedt@goodmis.org,
	vdonnefort@google.com,
	mhiramat@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	axboe@kernel.dk
Cc: linux-mm@kvack.org,
	James.Bottomley@HansenPartnership.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com,
	robin.murphy@arm.com,
	mason@kernel.org,
	aesteve@redhat.com,
	tjmercier@google.com,
	harry@kernel.org,
	vbabka@suse.cz,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH 3/7] vhost: account the per-device kernel allocations to memcg
Date: Fri,  6 Nov 2026 21:18:25 +0800
Message-ID: <20261106131829.3228926-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106131829.3228926-1-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Everything except the worker struct is allocated with plain GFP_KERNEL:
the per-vq iovec and log arrays at VHOST_SET_OWNER, the memory table at
VHOST_SET_MEM_TABLE whose size follows the user supplied region count,
the pending message nodes, and the vhost_net/vhost_vsock device structs
with their fallback to vmalloc.  The worker has been accounted since the
vhost_task conversion.

A container that can open /dev/vhost-net or /dev/vhost-vsock, which
device plugins hand out with passthrough, holds roughly 150KB of
resident kernel memory per device after SET_OWNER.  Charge the rest the
same way the worker already is.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/vhost/net.c   | 14 ++++++++------
 drivers/vhost/vhost.c | 16 ++++++++++------
 drivers/vhost/vsock.c |  5 +++--
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4570a4ffbab2..bab6597c696d 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -249,7 +249,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
 	/* No zero copy backend? Nothing to count. */
 	if (!zcopy)
 		return NULL;
-	ubufs = kmalloc_obj(*ubufs);
+	ubufs = kmalloc_obj(*ubufs, GFP_KERNEL_ACCOUNT);
 	if (!ubufs)
 		return ERR_PTR(-ENOMEM);
 	atomic_set(&ubufs->refcount, 1);
@@ -302,7 +302,8 @@ static int vhost_net_set_ubuf_info(struct vhost_net *n)
 		if (!zcopy)
 			continue;
 		n->vqs[i].ubuf_info =
-			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV);
+			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV,
+				     GFP_KERNEL_ACCOUNT);
 		if  (!n->vqs[i].ubuf_info)
 			goto err;
 	}
@@ -1344,17 +1345,18 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	struct xdp_buff *xdp;
 	int i;
 
-	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
+			 __GFP_ACCOUNT);
 	if (!n)
 		return -ENOMEM;
-	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX);
+	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX, GFP_KERNEL_ACCOUNT);
 	if (!vqs) {
 		kvfree(n);
 		return -ENOMEM;
 	}
 
 	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
-			      GFP_KERNEL);
+			      GFP_KERNEL_ACCOUNT);
 	if (!queue) {
 		kfree(vqs);
 		kvfree(n);
@@ -1362,7 +1364,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	}
 	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
 
-	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH);
+	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH, GFP_KERNEL_ACCOUNT);
 	if (!xdp) {
 		kfree(vqs);
 		kvfree(n);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ea127af58ada..d1274106ad5d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -526,11 +526,14 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
 
 	for (i = 0; i < dev->nvqs; ++i) {
 		vq = dev->vqs[i];
-		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV);
-		vq->log = kmalloc_objs(*vq->log, dev->iov_limit);
-		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit);
+		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV,
+					    GFP_KERNEL_ACCOUNT);
+		vq->log = kmalloc_objs(*vq->log, dev->iov_limit,
+				       GFP_KERNEL_ACCOUNT);
+		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit,
+					 GFP_KERNEL_ACCOUNT);
 		vq->nheads = kmalloc_array(dev->iov_limit, sizeof(*vq->nheads),
-					   GFP_KERNEL);
+					   GFP_KERNEL_ACCOUNT);
 		if (!vq->indirect || !vq->log || !vq->heads || !vq->nheads)
 			goto err_nomem;
 	}
@@ -2053,7 +2056,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 		return -E2BIG;
 	if (max_iotlb_entries <= 0)
 		return -EINVAL;
-	newmem = kvzalloc_flex(*newmem, regions, mem.nregions);
+	newmem = kvzalloc_flex(*newmem, regions, mem.nregions,
+			       GFP_KERNEL_ACCOUNT);
 	if (!newmem)
 		return -ENOMEM;
 
@@ -3405,7 +3409,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 {
 	/* Make sure all padding within the structure is initialized. */
-	struct vhost_msg_node *node = kzalloc_obj(*node);
+	struct vhost_msg_node *node = kzalloc_obj(*node, GFP_KERNEL_ACCOUNT);
 	if (!node)
 		return NULL;
 
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..600daeb05e7b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -721,11 +721,12 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
-	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
+			     __GFP_ACCOUNT);
 	if (!vsock)
 		return -ENOMEM;
 
-	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs));
+	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs), GFP_KERNEL_ACCOUNT);
 	if (!vqs) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.43.0

