Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C9312837
	for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811332; cv=none; b=u6xcaFsfPkn6ihKC4la6jN/oMKrjwGlwvjAgjtCUiiWcR32xV7taATIWGQUlOTlYOGXWVFqmVKWMLNZFrotHTKrvMsdRkLvPqfTVQsH7fjgYa9wacj4yQU41fzC6nsJBowmmA3qKbyzEyvVzm5l67IIo5+NU+C3JRimRJ0/buYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811332; c=relaxed/simple;
	bh=vzMXxnGrNiivAmCvuB8S1Fez0wosdLEpkfATppGqtUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ifpyqU5g2+NPT3fVMtmHYU5NI/pkFKsbasTN3ia1urG0fxXLLe9pJvRzKvcXNtsIE5uULUeCszQCjl7KkhpFGKqCLLAaU89Ss+k17gyeaMEvvkqltStARNhUwmJrtKvONIosTX6eqAi+BdTgmkKwShLKn8MNgT9lZ7Xmgj3TU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8YmBeQN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8YmBeQN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770811328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XxhNqDdKGaJchySxQaMnpZTyk1DscA4ZD5//3U2wYFs=;
	b=L8YmBeQNIyCGIA8vp7bxQ7jKZ7xNxYuj2YlmwLSjlLzI6bhV+MJ6Q15+QkTlTOItRU9nIo
	EA4JU0k92/8tC6nfsNZy2QmQebImSX0PLdzMsvRytQAnZr1F2XhhXme8cN3dIIMbyOzgUg
	fzC4Q+pkekUFR+WqiyJ0gf5NDVjh8y8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-jG4lKGS9MgSAfRHVdCuBCw-1; Wed,
 11 Feb 2026 07:02:05 -0500
X-MC-Unique: jG4lKGS9MgSAfRHVdCuBCw-1
X-Mimecast-MFC-AGG-ID: jG4lKGS9MgSAfRHVdCuBCw_1770811324
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDB2B195605F;
	Wed, 11 Feb 2026 12:02:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.212])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 606B019560A3;
	Wed, 11 Feb 2026 12:02:00 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH] vduse: Add suspend
Date: Wed, 11 Feb 2026 13:01:58 +0100
Message-ID: <20260211120158.2501592-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 49PcO91JuAvJFGpH7MQJDsjihdxwpozJQUz4D4maV48_1770811324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement suspend operation for vduse devices, so vhost-vdpa will offer
that backend feature and userspace can effectively suspend the device.

This is a must before get virtqueue indexes (base) for live migration,
since the device could modify them after userland gets them.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
This series depends on
https://lore.kernel.org/lkml/20260210082554.1582553-1-eperezma@redhat.com
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 86 +++++++++++++++++++++++++++++-
 include/uapi/linux/vduse.h         |  4 ++
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 59d9c4718d86..bdcc114e2710 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -54,7 +54,8 @@
 #define IRQ_UNBOUND -1
 
 /* Supported VDUSE features */
-static const uint64_t vduse_features = BIT_U64(VDUSE_F_QUEUE_READY);
+static const uint64_t vduse_features = BIT_U64(VDUSE_F_QUEUE_READY) |
+				       BIT_U64(VDUSE_F_SUSPEND);
 
 /*
  * VDUSE instance have not asked the vduse API version, so assume 0.
@@ -85,6 +86,7 @@ struct vduse_virtqueue {
 	int irq_effective_cpu;
 	struct cpumask irq_affinity;
 	struct kobject kobj;
+	struct vduse_dev *dev;
 };
 
 struct vduse_dev;
@@ -134,6 +136,7 @@ struct vduse_dev {
 	int minor;
 	bool broken;
 	bool connected;
+	bool suspended;
 	u64 api_version;
 	u64 device_features;
 	u64 driver_features;
@@ -480,6 +483,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 
 	down_write(&dev->rwsem);
 
+	dev->suspended = false;
 	dev->status = 0;
 	dev->driver_features = 0;
 	dev->generation++;
@@ -559,6 +563,10 @@ static void vduse_vdpa_kick_vq(struct vdpa_device *vdpa, u16 idx)
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = dev->vqs[idx];
 
+	guard(rwsem_read)(&vq->dev->rwsem);
+	if (vq->dev->suspended)
+		return;
+
 	if (!eventfd_signal_allowed()) {
 		schedule_work(&vq->kick);
 		return;
@@ -896,6 +904,27 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	return 0;
 }
 
+static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct vduse_dev_msg msg = { 0 };
+	int ret;
+
+	msg.req.type = VDUSE_SUSPEND;
+
+	ret = vduse_dev_msg_sync(dev, &msg);
+	if (ret == 0) {
+		scoped_guard(rwsem_write, &dev->rwsem)
+			dev->suspended = true;
+
+		cancel_work_sync(&dev->inject);
+		for (u32 i = 0; i < dev->vq_num; i++)
+			cancel_work_sync(&dev->vqs[i]->inject);
+	}
+
+	return ret;
+}
+
 static void vduse_vdpa_free(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
@@ -937,6 +966,41 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.free			= vduse_vdpa_free,
 };
 
+static const struct vdpa_config_ops vduse_vdpa_config_ops_with_suspend = {
+	.set_vq_address		= vduse_vdpa_set_vq_address,
+	.kick_vq		= vduse_vdpa_kick_vq,
+	.set_vq_cb		= vduse_vdpa_set_vq_cb,
+	.set_vq_num             = vduse_vdpa_set_vq_num,
+	.get_vq_size		= vduse_vdpa_get_vq_size,
+	.get_vq_group		= vduse_get_vq_group,
+	.set_vq_ready		= vduse_vdpa_set_vq_ready,
+	.get_vq_ready		= vduse_vdpa_get_vq_ready,
+	.set_vq_state		= vduse_vdpa_set_vq_state,
+	.get_vq_state		= vduse_vdpa_get_vq_state,
+	.get_vq_align		= vduse_vdpa_get_vq_align,
+	.get_device_features	= vduse_vdpa_get_device_features,
+	.set_driver_features	= vduse_vdpa_set_driver_features,
+	.get_driver_features	= vduse_vdpa_get_driver_features,
+	.set_config_cb		= vduse_vdpa_set_config_cb,
+	.get_vq_num_max		= vduse_vdpa_get_vq_num_max,
+	.get_device_id		= vduse_vdpa_get_device_id,
+	.get_vendor_id		= vduse_vdpa_get_vendor_id,
+	.get_status		= vduse_vdpa_get_status,
+	.set_status		= vduse_vdpa_set_status,
+	.get_config_size	= vduse_vdpa_get_config_size,
+	.get_config		= vduse_vdpa_get_config,
+	.set_config		= vduse_vdpa_set_config,
+	.get_generation		= vduse_vdpa_get_generation,
+	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
+	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
+	.reset			= vduse_vdpa_reset,
+	.set_map		= vduse_vdpa_set_map,
+	.set_group_asid		= vduse_set_group_asid,
+	.get_vq_map		= vduse_get_vq_map,
+	.suspend		= vduse_vdpa_suspend,
+	.free			= vduse_vdpa_free,
+};
+
 static void vduse_dev_sync_single_for_device(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
@@ -1148,6 +1212,10 @@ static void vduse_dev_irq_inject(struct work_struct *work)
 {
 	struct vduse_dev *dev = container_of(work, struct vduse_dev, inject);
 
+	guard(rwsem_read)(&dev->rwsem);
+	if (dev->suspended)
+		return;
+
 	spin_lock_bh(&dev->irq_lock);
 	if (dev->config_cb.callback)
 		dev->config_cb.callback(dev->config_cb.private);
@@ -1159,6 +1227,10 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 	struct vduse_virtqueue *vq = container_of(work,
 					struct vduse_virtqueue, inject);
 
+	guard(rwsem_read)(&vq->dev->rwsem);
+	if (vq->dev->suspended)
+		return;
+
 	spin_lock_bh(&vq->irq_lock);
 	if (vq->ready && vq->cb.callback)
 		vq->cb.callback(vq->cb.private);
@@ -1189,6 +1261,9 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	int ret = -EINVAL;
 
 	down_read(&dev->rwsem);
+	if (dev->suspended)
+		return ret;
+
 	if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
 		goto unlock;
 
@@ -1839,6 +1914,7 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 		}
 
 		dev->vqs[i]->index = i;
+		dev->vqs[i]->dev = dev;
 		dev->vqs[i]->irq_effective_cpu = IRQ_UNBOUND;
 		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
 		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
@@ -2311,12 +2387,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
 static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 {
 	struct vduse_vdpa *vdev;
+	const struct vdpa_config_ops *ops;
 
 	if (dev->vdev)
 		return -EEXIST;
 
+	if (dev->vduse_features & BIT_U64(VDUSE_F_SUSPEND))
+		ops = &vduse_vdpa_config_ops_with_suspend;
+	else
+		ops = &vduse_vdpa_config_ops;
+
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
-				 &vduse_vdpa_config_ops, &vduse_map_ops,
+				 ops, &vduse_map_ops,
 				 dev->ngroups, dev->nas, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index d39734cef6d3..95b93bc6bac5 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -21,6 +21,9 @@
 /* The VDUSE instance expects a request for vq ready */
 #define VDUSE_F_QUEUE_READY	0
 
+/* The VDUSE instance expects a request for suspend */
+#define VDUSE_F_SUSPEND		1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -338,6 +341,7 @@ enum vduse_req_type {
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
 	VDUSE_SET_VQ_READY,
+	VDUSE_SUSPEND,
 };
 
 /**
-- 
2.53.0

