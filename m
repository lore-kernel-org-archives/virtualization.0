Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA02FC024
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767077265; cv=none; b=fDInff7OsHt4LlCvBOSr4IU+xpNuQ/3xfXYSulLr711zh4E2NUrk6q2eFbFATsHnMayKiB8DJzcG3t0PNIMwdDOBAQPrk6P+r5mDm0Vy+1WePAxWmonmiXA50DvzHbXzo2jwa1lsl18JM5Xc/Zd2MOeIW9gK+MZif2fIt+sTkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767077265; c=relaxed/simple;
	bh=uyo+y8yMNzRePczbBs8BkNYCElPAnblW8pyjqupRq/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8d6y5FZ8gVK29v9YJu0o7C6+JJCuRumlbdz8gr7+ayed86F0ICSUAjFu/IHPhR+g2hbchJDwm+87tNIezSlV6I3p9gw+rsxaGmWwDeKZYOT4at6G6W86lDDnO1kDqWJKZF/w8DCilYcGdo0xT6T5mFiTwfj+JyLAr4rtR7eOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDLbRXZK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDLbRXZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767077262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhozjM3g2hApOE+D4QB0hdPzyPjgmFJvFsVo9a0LCYs=;
	b=EDLbRXZK4BcJdLTxRHkRTtIPTQnjRWlcEQz+9zyj7iAEQXxBr/AxnX8CpaWHlWKLFSNXxY
	lT1e85WHIEEcoLDvl1OtOBCS6Ht4aagrHFvJm7zgGzNeCA0wq24C9TmBAaWeb1RO9MjiGX
	d67sAb2qwoyr7homSYGAaGqTUtCM+ks=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-NOjL808FMVmwapPVNZEo-g-1; Tue,
 30 Dec 2025 01:47:39 -0500
X-MC-Unique: NOjL808FMVmwapPVNZEo-g-1
X-Mimecast-MFC-AGG-ID: NOjL808FMVmwapPVNZEo-g_1767077258
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F6FF1956095;
	Tue, 30 Dec 2025 06:47:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B27E19560AB;
	Tue, 30 Dec 2025 06:47:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 11/19] virtio_ring: switch to use vring_virtqueue for detach_unused_buf variants
Date: Tue, 30 Dec 2025 14:46:41 +0800
Message-ID: <20251230064649.55597-12-jasowang@redhat.com>
In-Reply-To: <20251230064649.55597-1-jasowang@redhat.com>
References: <20251230064649.55597-1-jasowang@redhat.com>
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

