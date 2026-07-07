Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F634EF15
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427130; cv=none; b=NEwpekTKg808Zcs3B+3uSBs38sYqWaYxS32/UOx+JVHSXZBdbk1kXtPbHL4mY3I5gHGZacIZf3IFa+UN8qJM+CrwG799LAJQj1fAxaa8SgjHJ9eXLQO0sSLseaEuo744M6H9NhmEVYK6f+6spW9SIATtsPppvBKI411E7Gsg/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427130; c=relaxed/simple;
	bh=h7dkyRvxg5OOQ5l1MWIWcW262KOJaRbMJespUBBA7YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dg91wEiUu7qL3iVYG0UAQhcQ9CMD4Bhw1IA4/Lz+FaQCZWrpTj24XDPLkLCUOAC5utNAVcwqzWvk3JRYjnUvTgSm1kqLxWAQLUOVANiHgGJotrQr+0EVWE1frV6DZ7BUDdSptkWRrOn04xcRH9PxcbwQASYR/y+w/J6FKAfe7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fagUHsDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fagUHsDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783427128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvYj1fpViBxlMdfxPjVl83BZq+xu+ATZ4QYODSUFoM4=;
	b=fagUHsDGXgbeYA3z4OlkRD/zUnbCj6fU/D6EYSF7jhLe4dw1EBeVgFJ4FqMR554jffM4d5
	qdeIXWJ/XQjMFldDgujW7fLSD8R0b6k3WIjFBPwaGSjk2469/viHof02RJ8YCuSfZhLQDR
	1L1KUIgrHEYw/XLPqG//F6+xTUKfNcI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-j6j28gUWOEaCN4WX4ej5CA-1; Tue,
 07 Jul 2026 08:25:24 -0400
X-MC-Unique: j6j28gUWOEaCN4WX4ej5CA-1
X-Mimecast-MFC-AGG-ID: j6j28gUWOEaCN4WX4ej5CA_1783427123
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2B84195421C;
	Tue,  7 Jul 2026 12:25:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 984F118005B2;
	Tue,  7 Jul 2026 12:25:20 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH v4 4/4] vduse: add F_QUEUE_READY feature
Date: Tue,  7 Jul 2026 14:25:02 +0200
Message-ID: <20260707122502.239022-5-eperezma@redhat.com>
In-Reply-To: <20260707122502.239022-1-eperezma@redhat.com>
References: <20260707122502.239022-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 0d1YKil0aJBSjz4mk3SFRU0nnn-cy-Tiq0tre4ZSnU8_1783427123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the VDUSE_F_QUEUE_READY feature flag. This allows the kernel module
to explicitly signal userspace when a specific virtqueue has been
enabled.

In scenarios like Live Migration of VirtIO net devices, the dataplane
starts after the control virtqueue allowing QEMU to apply configuration
in the destination device.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v4:
* Create its own spinlock for vq->ready instead of relying on kick and
  call spinlocks.

v2:
* Fix comment of vduse_dev_request.vq_ready
* Set vq_ready before sending the message to the VDUSE userland
  instance, avoiding the need for SMP sync after receiving the message.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 73 +++++++++++++++++++++++-------
 include/uapi/linux/vduse.h         | 18 ++++++++
 2 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 4d561b9fbf5e..307d13fbe942 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -9,6 +9,7 @@
  */
 
 #include "linux/virtio_net.h"
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -53,7 +54,7 @@
 #define IRQ_UNBOUND -1
 
 /* Supported VDUSE features */
-static const uint64_t vduse_features;
+static const uint64_t vduse_features = BIT_U64(VDUSE_F_QUEUE_READY);
 
 /*
  * VDUSE instance have not asked the vduse API version, so assume 0.
@@ -77,6 +78,7 @@ struct vduse_virtqueue {
 	u32 group;
 	spinlock_t kick_lock;
 	spinlock_t irq_lock;
+	spinlock_t ready_lock;
 	struct eventfd_ctx *kickfd;
 	struct vdpa_callback cb;
 	struct work_struct inject;
@@ -120,6 +122,7 @@ struct vduse_dev {
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
+	u64 vduse_features;
 	u64 msg_unique;
 	u32 msg_timeout;
 	wait_queue_head_t waitq;
@@ -514,7 +517,9 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	for (i = 0; i < dev->vq_num; i++) {
 		struct vduse_virtqueue *vq = dev->vqs[i];
 
-		vq->ready = false;
+		scoped_guard(spinlock_bh, &vq->ready_lock) {
+			vq->ready = false;
+		}
 		vq->desc_addr = 0;
 		vq->driver_addr = 0;
 		vq->device_addr = 0;
@@ -556,16 +561,15 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 
 static void vduse_vq_kick(struct vduse_virtqueue *vq)
 {
-	spin_lock(&vq->kick_lock);
-	if (!vq->ready)
-		goto unlock;
+	guard(spinlock)(&vq->kick_lock);
+	scoped_guard(spinlock_bh, &vq->ready_lock)
+		if (!vq->ready)
+			return;
 
 	if (vq->kickfd)
 		eventfd_signal(vq->kickfd);
 	else
 		vq->kicked = true;
-unlock:
-	spin_unlock(&vq->kick_lock);
 }
 
 static void vduse_vq_kick_work(struct work_struct *work)
@@ -625,7 +629,30 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = dev->vqs[idx];
+	struct vduse_dev_msg msg = { 0 };
+	int r;
+
+	if (dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)) {
+		msg.req.type = VDUSE_SET_VQ_READY;
+		msg.req.vq_ready.num = idx;
+		msg.req.vq_ready.ready = !!ready;
+
+		r = vduse_dev_msg_sync(dev, &msg);
+
+		if (r < 0) {
+			dev_dbg(&vdpa->dev, "device refuses to set vq %u ready %u",
+					idx, ready);
 
+			/* We can't do better than break the device in this case */
+			spin_lock(&dev->msg_lock);
+			vduse_dev_broken(dev);
+			spin_unlock(&dev->msg_lock);
+
+			return;
+		}
+	}
+
+	guard(spinlock_bh)(&vq->ready_lock);
 	vq->ready = ready;
 }
 
@@ -634,6 +661,7 @@ static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = dev->vqs[idx];
 
+	guard(spinlock_bh)(&vq->ready_lock);
 	return vq->ready;
 }
 
@@ -1121,15 +1149,16 @@ static int vduse_kickfd_setup(struct vduse_dev *dev,
 	} else if (eventfd->fd != VDUSE_EVENTFD_DEASSIGN)
 		return 0;
 
-	spin_lock(&vq->kick_lock);
+	guard(spinlock)(&vq->kick_lock);
 	if (vq->kickfd)
 		eventfd_ctx_put(vq->kickfd);
 	vq->kickfd = ctx;
+
+	guard(spinlock_bh)(&vq->ready_lock);
 	if (vq->ready && vq->kicked && vq->kickfd) {
 		eventfd_signal(vq->kickfd);
 		vq->kicked = false;
 	}
-	spin_unlock(&vq->kick_lock);
 
 	return 0;
 }
@@ -1160,10 +1189,10 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 	struct vduse_virtqueue *vq = container_of(work,
 					struct vduse_virtqueue, inject);
 
-	spin_lock_bh(&vq->irq_lock);
+	guard(spinlock_bh)(&vq->irq_lock);
+	guard(spinlock_bh)(&vq->ready_lock);
 	if (vq->ready && vq->cb.callback)
 		vq->cb.callback(vq->cb.private);
-	spin_unlock_bh(&vq->irq_lock);
 }
 
 static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
@@ -1173,12 +1202,12 @@ static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
 	if (!vq->cb.trigger)
 		return false;
 
-	spin_lock_irq(&vq->irq_lock);
+	guard(spinlock_irq)(&vq->irq_lock);
+	guard(spinlock_irq)(&vq->ready_lock);
 	if (vq->ready && vq->cb.trigger) {
 		eventfd_signal(vq->cb.trigger);
 		signal = true;
 	}
-	spin_unlock_irq(&vq->irq_lock);
 
 	return signal;
 }
@@ -1516,7 +1545,9 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			vq_info.split.avail_index =
 				vq->state.split.avail_index;
 
-		vq_info.ready = vq->ready;
+		scoped_guard(spinlock_bh, &vq->ready_lock) {
+			vq_info.ready = vq->ready;
+		}
 
 		ret = -EFAULT;
 		if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
@@ -1746,7 +1777,9 @@ static long vduse_dev_compat_ioctl(struct file *file, unsigned int cmd,
 			vq_info.split.avail_index =
 				vq->state.split.avail_index;
 
-		vq_info.ready = vq->ready;
+		scoped_guard(spinlock_bh, &vq->ready_lock) {
+			vq_info.ready = vq->ready;
+		}
 
 		ret = -EFAULT;
 		if (copy_to_user(argp, &vq_info,
@@ -1959,6 +1992,7 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
 		spin_lock_init(&dev->vqs[i]->kick_lock);
 		spin_lock_init(&dev->vqs[i]->irq_lock);
+		spin_lock_init(&dev->vqs[i]->ready_lock);
 		cpumask_setall(&dev->vqs[i]->irq_affinity);
 
 		kobject_init(&dev->vqs[i]->kobj, &vq_type);
@@ -2194,7 +2228,8 @@ static struct attribute *vduse_dev_attrs[] = {
 ATTRIBUTE_GROUPS(vduse_dev);
 
 static int vduse_create_dev(struct vduse_dev_config *config,
-			    void *config_buf, u64 api_version)
+			    void *config_buf, u64 api_version,
+			    uint64_t vduse_features)
 {
 	int ret;
 	struct vduse_dev *dev;
@@ -2216,6 +2251,9 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->vduse_features = vduse_features;
+	dev_dbg(vduse_ctrl_dev, "Creating device %s with features 0x%llx",
+		config->name, vduse_features);
 
 	dev->nas = (dev->api_version < VDUSE_API_VERSION_1) ? 1 : config->nas;
 	dev->as = kzalloc_objs(dev->as[0], dev->nas);
@@ -2331,7 +2369,8 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 		config.name[VDUSE_NAME_MAX - 1] = '\0';
-		ret = vduse_create_dev(&config, buf, control->api_version);
+		ret = vduse_create_dev(&config, buf, control->api_version,
+				       control->vduse_features);
 		if (ret)
 			kvfree(buf);
 		break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index f14c965bb7f6..7285f8570237 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -14,6 +14,9 @@
 
 #define VDUSE_API_VERSION_1	1
 
+/* The VDUSE instance expects a request for vq ready */
+#define VDUSE_F_QUEUE_READY	0
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -331,6 +334,7 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
 };
 
 /**
@@ -378,6 +382,15 @@ struct vduse_iova_range_v2 {
 	__u32 padding;
 };
 
+/**
+ * struct vduse_vq_ready - Virtqueue ready request message
+ * @num: Virtqueue number
+ */
+struct vduse_vq_ready {
+	__u32 num;
+	__u32 ready;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -388,6 +401,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -405,6 +419,10 @@ struct vduse_dev_request {
 		 */
 		struct vduse_iova_range_v2 iova_v2;
 		struct vduse_vq_group_asid vq_group_asid;
+
+		/* Only if VDUSE_F_QUEUE_READY is negotiated */
+		struct vduse_vq_ready vq_ready;
+
 		__u32 padding[32];
 	};
 };
-- 
2.55.0

