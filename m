Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A812FBDF0
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767077255; cv=none; b=T7EPfHWPBlzd3AjT7/HJjWIjYNP9qZRBa+0drHhJxVR8anl3ZL02oo+P2ymF41ARKBQweGRB/mtyUZhDsQFe6YRkNj0bQTtDCBGpxp++sPBa7ifkMSrU/Ko/F2uBQ8p/topD2VNJuERMHp9sSkNq1Mq0jJYcVEuBIosAJxghROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767077255; c=relaxed/simple;
	bh=5Dfj5IOBvxhWPF1wbe8qoF0YyD/64MDtHXXBVShzG4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGhS8x99DCG4m3BobrrAkFmK74Mgc/0cDwxa1y/myAgAcnpQ53xWTppgKtcRDtFf256SyDgg2BIZTRB8Ov5GKtzAC19vaA5DXNwJJPdth6TJmKWdorYAPANHh1KQtebCnJQbuP0VrP8/NeknOMYOOLo1HYjfXUyCQYVdJK7rSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0Aa/wTz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0Aa/wTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767077252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndAUlC27ozZob57i45Gbec3x37MLWrFO1aO92A9reJA=;
	b=Y0Aa/wTz6MT1mbX1aKvrVwoR0vsRjbtFggyGxnOtbeA9+7z6A1X3IYwlMTB9nLAIdVGZPx
	ttKJZ5SWSfoY/UMx8vt6hnKwGqUWIJ88nB6dq3nZpvkCpwoSC08zrspPTeD8Ab/Y676yy9
	5NiPe9Ok0mhhmolusxRZ6v7aTQiOjOs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-01nr5WWiMCukj_6FT6guzA-1; Tue,
 30 Dec 2025 01:47:28 -0500
X-MC-Unique: 01nr5WWiMCukj_6FT6guzA-1
X-Mimecast-MFC-AGG-ID: 01nr5WWiMCukj_6FT6guzA_1767077247
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BC1118002C9;
	Tue, 30 Dec 2025 06:47:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 438AC1956053;
	Tue, 30 Dec 2025 06:47:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 08/19] virtio_ring: switch to use vring_virtqueue for enable_cb_prepare variants
Date: Tue, 30 Dec 2025 14:46:38 +0800
Message-ID: <20251230064649.55597-9-jasowang@redhat.com>
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
 drivers/virtio/virtio_ring.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3fd65b1177a3..8ffe7daa1e5f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -898,9 +898,8 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 last_used_idx;
 
 	START_USE(vq);
@@ -914,10 +913,10 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
 		if (!vq->event)
 			vq->split.vring.avail->flags =
-				cpu_to_virtio16(_vq->vdev,
+				cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_flags_shadow);
 	}
-	vring_used_event(&vq->split.vring) = cpu_to_virtio16(_vq->vdev,
+	vring_used_event(&vq->split.vring) = cpu_to_virtio16(vq->vq.vdev,
 			last_used_idx = vq->last_used_idx);
 	END_USE(vq);
 	return last_used_idx;
@@ -1807,10 +1806,8 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	START_USE(vq);
 
 	/*
@@ -2572,8 +2569,8 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
-				 virtqueue_enable_cb_prepare_split(_vq);
+	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
+				 virtqueue_enable_cb_prepare_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
-- 
2.31.1

