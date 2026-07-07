Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD540A950
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427642; cv=none; b=ElTKgA41GGWCFQhSvbKKCJePsypqod4EgpwRAkby5GS1+owNi09z34G+fnHYuIhcLqyE5VrT7AaCunqf4CDMW6+rhwOxr24UrvaHNko/LJP92y1bPXxHo5D0OVW6qHdVT3xp2R1wDsNjDcMZmg1IZehxB8THaqhesZKIirdALmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427642; c=relaxed/simple;
	bh=2o2bDl/todxKwJOQz369iGBMqyTujhvNhKYf1UT32k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8GTOp+B9rGu05pqPhj/FWt9xuVyz0T7t92XIuy8QMfdOg+jH/lRnCMQjG1bTEcZGpibY6jGjZN35F5BpzjP+ooTpFJGqHIdyLNmafWXeBocy3HGOM1/vLLfqFfR/cUKAPKalY70eEEjHtS9XnL+njVZ8iM0OUaxGe3JPbWOyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqJ5nvdH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqJ5nvdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783427639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AabzEcEZCK3sclJeYc2b4orZc0Vg+8R2uqibUfV2Nfo=;
	b=HqJ5nvdHAz/Gs+nLVxyoW6wAOocvchPhR8rKr5ncq9P1RV7rZqln4SSeykubwkEr0gUCgY
	yPsoZWqhv50fednkKh/Xhy38l4LQggVNRLmysnHVC8ENIsY61Obq8JbDuV4M2MH15tTR5w
	68zueBilWi9S4UyfipqWvtI3JmTbV6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-GG6KzFJsOMGcqjSnzWtKlA-1; Tue,
 07 Jul 2026 08:33:55 -0400
X-MC-Unique: GG6KzFJsOMGcqjSnzWtKlA-1
X-Mimecast-MFC-AGG-ID: GG6KzFJsOMGcqjSnzWtKlA_1783427634
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D8A819560BD;
	Tue,  7 Jul 2026 12:33:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A178B36925;
	Tue,  7 Jul 2026 12:33:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	linux-kernel@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH v5 1/2] vduse: do not take rwsem at reset work flush
Date: Tue,  7 Jul 2026 14:33:43 +0200
Message-ID: <20260707123344.244575-2-eperezma@redhat.com>
In-Reply-To: <20260707123344.244575-1-eperezma@redhat.com>
References: <20260707123344.244575-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: kBlAtF2OH4N8YXs5I5TBiAS6O3flkBvXVI9hdIe5s9w_1783427634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Next patches need to check suspend flag at this work item, and the
rwlock is used to protect the suspend flag update.  If the work takes
the rwlock too it will produce a deadlock.

Make flushing work do nothing when called by de-initializing everything:
vq->ready, vq->kickfd, vq->cb.callback.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 67 ++++++++++++++++--------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 307d13fbe942..347afe7c6d92 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -503,46 +503,49 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 			vduse_domain_reset_bounce_map(domain);
 	}
 
-	down_write(&dev->rwsem);
+	scoped_guard(rwsem_write, &dev->rwsem) {
+		dev->status = 0;
+		dev->driver_features = 0;
+		dev->generation++;
+		spin_lock(&dev->irq_lock);
+		dev->config_cb.callback = NULL;
+		dev->config_cb.private = NULL;
+		spin_unlock(&dev->irq_lock);
+
+		for (i = 0; i < dev->vq_num; i++) {
+			struct vduse_virtqueue *vq = dev->vqs[i];
+
+			scoped_guard(spinlock_bh, &vq->ready_lock) {
+				vq->ready = false;
+			}
+			vq->desc_addr = 0;
+			vq->driver_addr = 0;
+			vq->device_addr = 0;
+			vq->num = 0;
+			memset(&vq->state, 0, sizeof(vq->state));
+
+			spin_lock(&vq->kick_lock);
+			vq->kicked = false;
+			if (vq->kickfd)
+				eventfd_ctx_put(vq->kickfd);
+			vq->kickfd = NULL;
+			spin_unlock(&vq->kick_lock);
+
+			spin_lock(&vq->irq_lock);
+			vq->cb.callback = NULL;
+			vq->cb.private = NULL;
+			vq->cb.trigger = NULL;
+			spin_unlock(&vq->irq_lock);
+		}
+	}
 
-	dev->status = 0;
-	dev->driver_features = 0;
-	dev->generation++;
-	spin_lock(&dev->irq_lock);
-	dev->config_cb.callback = NULL;
-	dev->config_cb.private = NULL;
-	spin_unlock(&dev->irq_lock);
 	flush_work(&dev->inject);
-
 	for (i = 0; i < dev->vq_num; i++) {
 		struct vduse_virtqueue *vq = dev->vqs[i];
 
-		scoped_guard(spinlock_bh, &vq->ready_lock) {
-			vq->ready = false;
-		}
-		vq->desc_addr = 0;
-		vq->driver_addr = 0;
-		vq->device_addr = 0;
-		vq->num = 0;
-		memset(&vq->state, 0, sizeof(vq->state));
-
-		spin_lock(&vq->kick_lock);
-		vq->kicked = false;
-		if (vq->kickfd)
-			eventfd_ctx_put(vq->kickfd);
-		vq->kickfd = NULL;
-		spin_unlock(&vq->kick_lock);
-
-		spin_lock(&vq->irq_lock);
-		vq->cb.callback = NULL;
-		vq->cb.private = NULL;
-		vq->cb.trigger = NULL;
-		spin_unlock(&vq->irq_lock);
 		flush_work(&vq->inject);
 		flush_work(&vq->kick);
 	}
-
-	up_write(&dev->rwsem);
 }
 
 static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
-- 
2.55.0

