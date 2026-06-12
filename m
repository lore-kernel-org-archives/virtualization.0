Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75203812F5
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288115; cv=none; b=M8OiOJ/AquH5x3qU+SIgwYTzo5MoAOpDe/4AH2gBsHH8Z+Hr+h9CbQ4Rd1nVj1sfrbjz3wj33akOE4JqpHsJeHc+ik17Otc59WTgp1NX/wj0wOqGYkLcx8TCVxFQYsVnTwcjJStl4qJYTqc34BuHLcMb16cPfby6A2kedJqsXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288115; c=relaxed/simple;
	bh=dG3DzxnaurEJh8xpxUNSsCxz0YUeYiFBZPBHly71tiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN66rKkpgLJfK6H3oOYHboJFr7grnvQUgWXbrhsotVajLYjqgT9CRoWwQsvivrukWzhqg+S3zbTRZcWH8hb61uGnuMdTUZEn9gFdC6w4+BXLnRZFEkpzM3b10uQGgVaIBb4koRt3EeN390RSWfhFkKUpN+/8QF8SmBSm1Gb1UDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWrlFmWD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWrlFmWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781288112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu9A9kd8JCmjRb9VSzcWI4Z7Ay28AWwMmLW/VYYJhfk=;
	b=gWrlFmWDauH6Vt8P+DfaPpbKVD9mR6gBqw5RNiMK8NcwnB59YdCKsy2DkM7cxDshZeeq70
	EZQ0jMelod5U/EsjP6HaV0SVYC1/grctZLIxHMnN0WuICm/0MDQHZAHL+ZLlSFhiERxIfT
	fIUTMVIsdEMow7/+pMtQqb2Qs6xs+28=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-2drVd6BdNgib-FZU7VIJ7Q-1; Fri,
 12 Jun 2026 14:15:08 -0400
X-MC-Unique: 2drVd6BdNgib-FZU7VIJ7Q-1
X-Mimecast-MFC-AGG-ID: 2drVd6BdNgib-FZU7VIJ7Q_1781288107
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21ED218501C1;
	Fri, 12 Jun 2026 18:15:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2438130001A1;
	Fri, 12 Jun 2026 18:15:02 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yongji Xie <xieyongji@bytedance.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	Cindy Lu <lulu@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 1/2] vduse: do not take rwsem at reset work flush
Date: Fri, 12 Jun 2026 20:14:56 +0200
Message-ID: <20260612181457.622955-2-eperezma@redhat.com>
In-Reply-To: <20260612181457.622955-1-eperezma@redhat.com>
References: <20260612181457.622955-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Qsq0yOhPBQYCGpNPkn3ZgM4ue1UNIZm1ecRK4oM_77E_1781288107
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Next patches need to check suspend flag at this work item, and the
rwlock is used to protect the suspend flag update.  If the work takes
the rwlock too it will produce a deadlock.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 63 ++++++++++++++++--------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index eff104f90cee..0f15575df394 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -501,44 +501,47 @@ static void vduse_dev_reset(struct vduse_dev *dev)
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
+			vq->ready = false;
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
 
-		vq->ready = false;
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
2.54.0

