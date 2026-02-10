Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B430B51F
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711988; cv=none; b=hR7Nvy0ym/UgRzhZoH0iBsR4F8clBRQMMPRfmXl/GNn8bdMz6FR09l3Qu+UKzD8vphOLBWIxswYctfV53b3kLhn/xJHSO3DpfSUv8yS/nSErcqCFoe2+ql2bJmyLCsdGQBe8GCRCMDq4KiM91tU6/XwiqhXD71opxRsLp5a5T04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711988; c=relaxed/simple;
	bh=G2r8WqiREUW+2jJzyeP9wUiTiglWnV0YXunzqZmXlj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okYdKryFAnm7Xwi9Jw0zCk1A8RL51nkCtOnBxVTrPmIrx4FevIM9wN5IpZQDHZPGkxJA0AZuaYFyYDzSNNcqUNoqjhS41A3iWwMutJii8Tbvqwux0NtjaSZF/0FzUMZ48gAVSHhI+mJsfh7Vg5YZEAu5V+oe1rII+hGw6XHK9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyR5Ae8R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyR5Ae8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770711986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQ85lh3hgGge5muoa+9ltiWnErqCfrrQ6Voxp1y4QXw=;
	b=FyR5Ae8RCnhI5GoEjuJLVr9BRfULH7dV9ONvud1DLSKTrfz9H1Hmnqez4w3+JhXVTRy4Kd
	/wYMlfhbBFonRNsENsAhFfdkVzoQVPM7D0ZSfRvNRhDHo4XnQmvAa2kBogo8cGDvou7mbL
	xOtj2o8kzEMH1sFWGpisMMNXPeehPHs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-JW9wPPa2PCWprVqSV22T4g-1; Tue,
 10 Feb 2026 03:26:23 -0500
X-MC-Unique: JW9wPPa2PCWprVqSV22T4g-1
X-Mimecast-MFC-AGG-ID: JW9wPPa2PCWprVqSV22T4g_1770711982
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 548A91800370;
	Tue, 10 Feb 2026 08:26:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AB8C1956053;
	Tue, 10 Feb 2026 08:26:18 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2 5/5] vduse: add F_QUEUE_READY feature
Date: Tue, 10 Feb 2026 09:25:54 +0100
Message-ID: <20260210082554.1582553-6-eperezma@redhat.com>
In-Reply-To: <20260210082554.1582553-1-eperezma@redhat.com>
References: <20260210082554.1582553-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: J59AkhsXQUfnStL1KsF0on3mEq_F4CS2-id7yRSxWOQ_1770711982
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
v2:
* Fix comment of vduse_dev_request.vq_ready
* Set vq_ready before sending the message to the VDUSE userland
  instance, avoiding the need for SMP sync after receiving the message.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
 include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 39e115b8bf44..59d9c4718d86 100644
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
@@ -120,6 +121,7 @@ struct vduse_dev {
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
+	u64 vduse_features;
 	u64 msg_unique;
 	u32 msg_timeout;
 	wait_queue_head_t waitq;
@@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = dev->vqs[idx];
+	struct vduse_dev_msg msg = { 0 };
+	int r;
 
 	vq->ready = ready;
+
+	if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
+		return;
+
+	msg.req.type = VDUSE_SET_VQ_READY;
+	msg.req.vq_ready.num = idx;
+	msg.req.vq_ready.ready = !!ready;
+
+	r = vduse_dev_msg_sync(dev, &msg);
+
+	if (r < 0) {
+		dev_dbg(&vdpa->dev, "device refuses to set vq %u ready %u",
+			idx, ready);
+
+		/* We can't do better than break the device in this case */
+		spin_lock(&dev->msg_lock);
+		vduse_dev_broken(dev);
+		spin_unlock(&dev->msg_lock);
+	}
 }
 
 static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
@@ -2091,6 +2114,9 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->vduse_features = config->vduse_features;
+	dev_dbg(vduse_ctrl_dev, "Creating device %s with features 0x%llx",
+		config->name, config->vduse_features);
 
 	dev->nas = (dev->api_version < VDUSE_API_VERSION_1) ? 1 : config->nas;
 	dev->as = kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 8898d9daa777..d39734cef6d3 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -18,6 +18,9 @@
 
 #define VDUSE_API_VERSION_2	2
 
+/* The VDUSE instance expects a request for vq ready */
+#define VDUSE_F_QUEUE_READY	0
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -334,6 +337,7 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
 };
 
 /**
@@ -381,6 +385,15 @@ struct vduse_iova_range_v2 {
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
@@ -391,6 +404,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -408,6 +422,10 @@ struct vduse_dev_request {
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
2.53.0

