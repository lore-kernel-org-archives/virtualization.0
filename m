Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB7303A14
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796696; cv=none; b=EJJYqyp0ykpiRlQoNIYFmvoWYpFOJEZPJhp7B45aGwuEcIOHps0jE+dgxchwVmm3Oqb5Vj9WeWO8QA8ayeB7XIumoWKMkKHdFm6feOYePzLW5BAEJvQxGLTYV7yYmyAgVu339AbB8cl7aiea/30RpkxX62wChUhNAGFuQmdfh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796696; c=relaxed/simple;
	bh=ctWAoF6NDQS22pawq36XHcMmNpCzPJfLCBBhqfhJrLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbDbhB0zB4ACK/33qPxwF0vusxQG0oOwQVuXPIN2Hf09rKllP5uYvMD5CBsk26qpk7TyPxCJwYuV4Jy1etFkHQSjbmv5rLdtUYapnUFh02EEub/J2l+hJlqa5aVxs15vUXSNzFVi9oEU+vd2IY2LKkrxFUoPUo8bAGVkebv4pa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcIW+7Ba; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcIW+7Ba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwedawIccVQ5ghzRAqTae/e3WUnoTDtuYj1zh6XY5ic=;
	b=JcIW+7BafdlavRq8vuZ3vRtXSvm6bXEncEB5pxiKuheo9FYOTw2vGF5syE1XspXxCMCb2T
	6QS+vZqCLEumdfo7wkyU7ef5cGvztMnhJ8Vln3eHmzFop+b9mbUWkF/EP29absOvpfbT56
	qU2VHb6aVAPudT0O/je1bNEcGkdnT60=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-KldBHiCsPpiqbm3nZUplkQ-1; Thu,
 25 Sep 2025 06:38:10 -0400
X-MC-Unique: KldBHiCsPpiqbm3nZUplkQ-1
X-Mimecast-MFC-AGG-ID: KldBHiCsPpiqbm3nZUplkQ_1758796689
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 542C219774E6;
	Thu, 25 Sep 2025 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F84819560AB;
	Thu, 25 Sep 2025 10:38:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
Date: Thu, 25 Sep 2025 18:37:01 +0800
Message-ID: <20250925103708.44589-13-jasowang@redhat.com>
In-Reply-To: <20250925103708.44589-1-jasowang@redhat.com>
References: <20250925103708.44589-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use u16 for last_used_idx in virtqueue_poll_split() to align with the
spec.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58c03a8aab85..4679a027dc53 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -806,7 +806,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-				 unsigned int last_used_idx)
+				 u16 last_used_idx)
 {
 	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
-- 
2.31.1

