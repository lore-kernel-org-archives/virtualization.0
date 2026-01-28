Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83805137923
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604358; cv=none; b=cSYNAxqtgeu2k11xc1uYqULixfhoBlJlP3ZOt86L2acd0LiIdIkbF5pX6plNwywmfLb4RU9OKAt+cG9UfNyn5No5jau5CFR+iXJqN79Qiwi6RIZcrEZq3cckL4wqwSWiRd7R01XJDZbRjKBW8PKU8n74HVEHSgp9wfgh2mKdR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604358; c=relaxed/simple;
	bh=ZSBZDLG6/HePANcFQxRld3Pamu8fkUNGQbeHZjZre+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIKC4wV71AH3R4Me974IPrLFnIdWhZ3HJe6pQsHgcfyFUibCe+95LaeuxgL/MSKtFBsLKtF4ZD5VsdokyXBvFUb18OeCGgkubxtS5MJ+d8QODXLqdPLiCJcgj84uNqOKh83b50/s2MJpJm8SxqJkqCzeziFQ5ZV7a4EuSOxnoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1lkQIB1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1lkQIB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769604355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMuDVwbLpNOKJnmsQp3y2Bk7yNL03EP1tUH4/lkzTgo=;
	b=I1lkQIB1gt0YDYJXvMb8Mq7S5bpExY8cce+qoco0NTvtnuv3X1ESiJd2GOOugoyQZDWgxm
	PPNBOP6+w8ZeZEZByOFzINAkuGGu2pEB8OkjbnXd6QAk3h+Zagt7M4dhvU079MlZ11ghPs
	p+mgKjMCEhltdPOvnJ5ZtcDumX/vpRw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-v7hLI8FFMtWl5naXsRTKxQ-1; Wed,
 28 Jan 2026 07:45:54 -0500
X-MC-Unique: v7hLI8FFMtWl5naXsRTKxQ-1
X-Mimecast-MFC-AGG-ID: v7hLI8FFMtWl5naXsRTKxQ_1769604353
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC56E1955D84;
	Wed, 28 Jan 2026 12:45:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3679230001A2;
	Wed, 28 Jan 2026 12:45:48 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 5/6] vduse: add F_QUEUE_READY feature
Date: Wed, 28 Jan 2026 13:45:23 +0100
Message-ID: <20260128124524.875271-6-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-1-eperezma@redhat.com>
References: <20260128124524.875271-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add the VDUSE_F_QUEUE_READY feature flag. This allows the kernel module
to explicitly signal userspace when a specific virtqueue has been
enabled.

In scenarios like Live Migration of VirtIO net devices, the dataplane
starts after the control virtqueue allowing QEMU to apply configuration
in the destination device.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
 include/uapi/linux/vduse.h         | 19 +++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e7da69c2ad71..1d93b540db4d 100644
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
@@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = dev->vqs[idx];
+	struct vduse_dev_msg msg = { 0 };
+	int r;
+
+	if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
+		goto out;
+
+	msg.req.type = VDUSE_SET_VQ_READY;
+	msg.req.vq_ready.num = idx;
+	msg.req.vq_ready.ready = !!ready;
+
+	r = vduse_dev_msg_sync(dev, &msg);
 
+	if (r < 0) {
+		dev_dbg(&vdpa->dev, "device refuses to set vq %u ready %u",
+			idx, ready);
+
+		/* We can't do better than break the device in this case */
+		spin_lock(&dev->msg_lock);
+		vduse_dev_broken(dev);
+		spin_unlock(&dev->msg_lock);
+		return;
+	}
+
+out:
 	vduse_vq_set_ready(vq, ready);
 }
 
@@ -2121,6 +2146,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->vduse_features = config->vduse_features;
 
 	dev->nas = (dev->api_version < VDUSE_API_VERSION_1) ? 1 : config->nas;
 	dev->as = kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 1f68e556cbf2..1e27395692ea 100644
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
@@ -330,6 +333,7 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
 };
 
 /**
@@ -376,6 +380,15 @@ struct vduse_iova_range_v2 {
 	__u32 asid;
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
@@ -386,6 +399,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -403,6 +417,11 @@ struct vduse_dev_request {
 		 */
 		struct vduse_iova_range_v2 iova_v2;
 		struct vduse_vq_group_asid vq_group_asid;
+		/*
+		 * Following members but padding exist only if vduse api
+		 * version >= 2
+		 */
+		struct vduse_vq_ready vq_ready;
 		__u32 padding[32];
 	};
 };
-- 
2.52.0

