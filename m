Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B312D46A2
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054584; cv=none; b=L5eM+1+lqmArhE5reROI40BsNBQpIDwtG8fMgFwxEOf2N4O1WEa3h55E8/wvm4zPc9BuxwTqUHpZ6mnO3/Rx/MW/LZ7FBZMezgt2rDwFiLgKFW3k03JNGPgHQlYOaOgF+h9Man8qkSUDnTmphuoPpgQ8pEerSlDXJW3r5TCrVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054584; c=relaxed/simple;
	bh=uyo+y8yMNzRePczbBs8BkNYCElPAnblW8pyjqupRq/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6m2hU6eUDI/qFttznHGBiAlwno0j6T+A8YbgZLbBQ05VdLPv2oMgYDaie7WDkYP8xzpdonUgx+Nk/m5e/FIHcb5y4Q7tisKGoOTDv1pXQfBsYDFcjap1CAPReusrkltD2idV9nQ2zEv9ZsmaNTbIU/UBHWYXeYdnfbLqdMA8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDqVumZm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDqVumZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764054582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhozjM3g2hApOE+D4QB0hdPzyPjgmFJvFsVo9a0LCYs=;
	b=YDqVumZmjMFZzbeJ0QFtzvzFJ6M0WJ/lz0b05kyX+ehmRQ0tqSxiLcjkMYnZJWIL//xClG
	L2PEXCjIhQ4pgVcZCaQlwQmHpjPZZnmbykKFGmj4RachbbhcxUk4zSloOUBIm4wfhyaq6L
	Kx6BFHbT4NmCdD4mUMWDBOWA73j9xc4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-1LlkANwDNf-HMVExMqfQIA-1; Tue,
 25 Nov 2025 02:09:37 -0500
X-MC-Unique: 1LlkANwDNf-HMVExMqfQIA-1
X-Mimecast-MFC-AGG-ID: 1LlkANwDNf-HMVExMqfQIA_1764054576
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA9541800357;
	Tue, 25 Nov 2025 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B9C4195419F;
	Tue, 25 Nov 2025 07:09:32 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 11/19] virtio_ring: switch to use vring_virtqueue for detach_unused_buf variants
Date: Tue, 25 Nov 2025 15:08:30 +0800
Message-ID: <20251125070838.70736-12-jasowang@redhat.com>
In-Reply-To: <20251125070838.70736-1-jasowang@redhat.com>
References: <20251125070838.70736-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a4d084f5ca95..db5cdb5fcb20 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -955,9 +955,8 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
 	void *buf;
 
@@ -970,7 +969,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 		buf = vq->split.desc_state[i].data;
 		detach_buf_split(vq, i, NULL);
 		vq->split.avail_idx_shadow--;
-		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
+		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
 				vq->split.avail_idx_shadow);
 		END_USE(vq);
 		return buf;
@@ -1892,9 +1891,8 @@ static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
 	void *buf;
 
@@ -2646,8 +2644,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
-				 virtqueue_detach_unused_buf_split(_vq);
+	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
+				 virtqueue_detach_unused_buf_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
-- 
2.31.1

