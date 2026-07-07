Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BB414A10
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427645; cv=none; b=RM8WeZ9eWdhCzBMSWNnSOqkroqg8JrAAQJ6boACYSXHhM6hebazjMnCTll5kumN8VMtMMLqEIRwWDP2NugSPr71L8L9dpdT4WG1tr1wy6S6WVXxUJkXB9EEgeuWbmELAPE/dTyVLT2AklMBtItC4aPr+cPgDp76YIbpObZTWaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427645; c=relaxed/simple;
	bh=+PMUpeHFownqavkM664xh18/sqDnJ5wuBbwBA9MF8Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFOHIgaxxryozmAl4RcL2nt7UrLje8Kp/a8qOTn92Nh6boW/NgVzrIFKzC8VkRo+sze+CyY7B3jysWzAse7b283oyOdQ9t1UR2rWoRy5MnCpHCz2PSa3hlrJafD5z08pvXO4Ns3MvMsbhkOH7dbk6OyC76m2fqlGEjRl1o3j4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eamu8cil; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eamu8cil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783427643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaBxdT85oE96XeUpht4f4Aq+rhLmG8Gh+RXSlyU+iL8=;
	b=eamu8cilPEazLcFKNpY2hKz14+B1zva2ZBr0X+pykhBhKqLXuGNgMD8P6zY+L7oi7NJNyu
	CCYJFk/zEi0NAzx6ORu7jfZaFH0tc4SbBSuRe8gaK+xhnqerjSMeZFvcnUK/uZoQ64g8ta
	f1BhBpLGtJc3rP/twTpGK76RDO30q7U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-4sz9HsRtOLq4n-9nkYj3qA-1; Tue,
 07 Jul 2026 08:33:59 -0400
X-MC-Unique: 4sz9HsRtOLq4n-9nkYj3qA-1
X-Mimecast-MFC-AGG-ID: 4sz9HsRtOLq4n-9nkYj3qA_1783427638
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53D5D1954120;
	Tue,  7 Jul 2026 12:33:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAF443691B;
	Tue,  7 Jul 2026 12:33:54 +0000 (UTC)
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
Subject: [PATCH v5 2/2] vduse: Add suspend
Date: Tue,  7 Jul 2026 14:33:44 +0200
Message-ID: <20260707123344.244575-3-eperezma@redhat.com>
In-Reply-To: <20260707123344.244575-1-eperezma@redhat.com>
References: <20260707123344.244575-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: DbjO6Flgz845ulAPyfZ4lUfCDJxYo4Q8yoApgLMpmiA_1783427638
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement suspend operation for vduse devices, so vhost-vdpa will offer
that backend feature and userspace can effectively suspend the device.

This is a must before get virtqueue indexes (base) for live migration,
since the device could modify them after userland gets them.

This patch does not implement resume, so VMM resets the whole device
to recover from a live migration failure.  Resume optimization can be
implemented on top of these patches, as other vDPA devices have done in
the past.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 95 +++++++++++++++++++++++++++---
 include/uapi/linux/vduse.h         |  4 ++
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 347afe7c6d92..0064891a08b2 100644
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
@@ -86,6 +87,7 @@ struct vduse_virtqueue {
 	int irq_effective_cpu;
 	struct cpumask irq_affinity;
 	struct kobject kobj;
+	struct vduse_dev *dev;
 };
 
 struct vduse_dev;
@@ -135,6 +137,7 @@ struct vduse_dev {
 	int minor;
 	bool broken;
 	bool connected;
+	bool suspended;
 	u64 api_version;
 	u64 device_features;
 	u64 driver_features;
@@ -504,6 +507,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	}
 
 	scoped_guard(rwsem_write, &dev->rwsem) {
+		dev->suspended = false;
 		dev->status = 0;
 		dev->driver_features = 0;
 		dev->generation++;
@@ -564,6 +568,10 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 
 static void vduse_vq_kick(struct vduse_virtqueue *vq)
 {
+	guard(rwsem_read)(&vq->dev->rwsem);
+	if (vq->dev->suspended)
+		return;
+
 	guard(spinlock)(&vq->kick_lock);
 	scoped_guard(spinlock_bh, &vq->ready_lock)
 		if (!vq->ready)
@@ -928,6 +936,27 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
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
@@ -969,6 +998,41 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
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
@@ -1181,6 +1245,10 @@ static void vduse_dev_irq_inject(struct work_struct *work)
 {
 	struct vduse_dev *dev = container_of(work, struct vduse_dev, inject);
 
+	guard(rwsem_read)(&dev->rwsem);
+	if (dev->suspended)
+		return;
+
 	spin_lock_bh(&dev->irq_lock);
 	if (dev->config_cb.callback)
 		dev->config_cb.callback(dev->config_cb.private);
@@ -1192,6 +1260,10 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 	struct vduse_virtqueue *vq = container_of(work,
 					struct vduse_virtqueue, inject);
 
+	guard(rwsem_read)(&vq->dev->rwsem);
+	if (vq->dev->suspended)
+		return;
+
 	guard(spinlock_bh)(&vq->irq_lock);
 	guard(spinlock_bh)(&vq->ready_lock);
 	if (vq->ready && vq->cb.callback)
@@ -1202,6 +1274,10 @@ static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
 {
 	bool signal = false;
 
+	guard(rwsem_read)(&vq->dev->rwsem);
+	if (vq->dev->suspended)
+		return false;
+
 	if (!vq->cb.trigger)
 		return false;
 
@@ -1221,9 +1297,9 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 {
 	int ret = -EINVAL;
 
-	down_read(&dev->rwsem);
-	if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
-		goto unlock;
+	guard(rwsem_read)(&dev->rwsem);
+	if (dev->suspended || !(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		return ret;
 
 	ret = 0;
 	if (irq_effective_cpu == IRQ_UNBOUND)
@@ -1231,8 +1307,6 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	else
 		queue_work_on(irq_effective_cpu,
 			      vduse_irq_bound_wq, irq_work);
-unlock:
-	up_read(&dev->rwsem);
 
 	return ret;
 }
@@ -1990,6 +2064,7 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 		}
 
 		dev->vqs[i]->index = i;
+		dev->vqs[i]->dev = dev;
 		dev->vqs[i]->irq_effective_cpu = IRQ_UNBOUND;
 		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
 		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
@@ -2466,12 +2541,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
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
index 7285f8570237..b7f8c04a0a44 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -17,6 +17,9 @@
 /* The VDUSE instance expects a request for vq ready */
 #define VDUSE_F_QUEUE_READY	0
 
+/* The VDUSE instance expects a request for suspend */
+#define VDUSE_F_SUSPEND		1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -335,6 +338,7 @@ enum vduse_req_type {
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
 	VDUSE_SET_VQ_READY,
+	VDUSE_SUSPEND,
 };
 
 /**
-- 
2.55.0

