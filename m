Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DF2D3738
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636791; cv=none; b=tmqnx4gDK7pQGCT7hFcltrSIARo1IHmU3MiY9fDhl50e2lL0PKw1JU7JC2aksRWHPb3VWoTCTKyXad6iNN8xTFA3+GCP2Xk0iXk3M/+dwgGEUzE8Iyrtipqoptz4vyVqZ5e8s8FTvzDqUR3z7NmPC5yzTNgWRL2OFvRPrLgS2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636791; c=relaxed/simple;
	bh=yXYGAEZQ8Iw2OCraZR8+b/6Q0QjT7RWJKnz+9vw/Ed8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKdR8pY+fB4xYR4aFFUSdWtGIve8y1MO62Zfix1FZrK463S4wuoOZmaLzaFbmY87qo2q9BMuPgzpfwVzrBPVm42HuMtQmw1GfW5TY3GUsk+r723hmuGfN4fXPbkeWlinGo7E+L97FZX4pubqMzL0lbDVqQYQMmwK7Z2bRru3TJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYgLXig/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYgLXig/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766636788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJzLkNizPe0Q11iTpFozDICpZibb0u5PKmXWgxiw+ZE=;
	b=TYgLXig/TwYn3a2l8qNIj5Zkn7XKwNXJ3rQJscEo9m48YqXid6OAVsdTqjrFnMeGeaQfrl
	p7vIvNE9H0ewG2xdMrXWb00aQU3iIrjqmbXwEc/nlLNv9XuXtmmmJdzVfinaOea6iCDqqr
	z9kxQ4rg0UGfSPFHDp+3LASAcVaXtn8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-sNuKV0HmNx6asn5Z4sLY5A-1; Wed,
 24 Dec 2025 23:26:24 -0500
X-MC-Unique: sNuKV0HmNx6asn5Z4sLY5A-1
X-Mimecast-MFC-AGG-ID: sNuKV0HmNx6asn5Z4sLY5A_1766636783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 874981956054;
	Thu, 25 Dec 2025 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 358EB180049F;
	Thu, 25 Dec 2025 04:26:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 02/19] virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
Date: Thu, 25 Dec 2025 12:25:51 +0800
Message-ID: <20251225042608.32350-3-jasowang@redhat.com>
In-Reply-To: <20251225042608.32350-1-jasowang@redhat.com>
References: <20251225042608.32350-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cc1b8bbc6774..d5a317cb885f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -919,11 +919,10 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 	return last_used_idx;
 }
 
-static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_idx)
+static bool virtqueue_poll_split(struct vring_virtqueue *vq,
+				 unsigned int last_used_idx)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
-	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
+	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
 }
 
@@ -1844,9 +1843,8 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 	return vq->last_used_idx;
 }
 
-static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
+static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wrap)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	bool wrap_counter;
 	u16 used_idx;
 
@@ -2611,8 +2609,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 		return false;
 
 	virtio_mb(vq->weak_barriers);
-	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
-				 virtqueue_poll_split(_vq, last_used_idx);
+	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
+				 virtqueue_poll_split(vq, last_used_idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
-- 
2.31.1

