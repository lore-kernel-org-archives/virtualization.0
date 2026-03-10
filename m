Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553473B8924
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169704; cv=none; b=R+iCSI9jWO1RWaFujPQYqIRDDYD0B61JfseV1PaNznPys1uJ/YRVSSffPuPI0rGX95Bwg8COzzD8e2m3omFkgKjLdnRdEOlfYf/lWGaLzAvFyfpJka3X3/De3B14l7O18V2SBJDXhMInM9qLgJOhVsUuW+z2miYH/YAkJfl/95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169704; c=relaxed/simple;
	bh=H7lHk3Ysx6GZZZBAF6qLzH/CGGQwTNr7krSzUUGBMAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wpam8VyCN3iwf88ZvS6miQr26DqNedjQ1SJEpccIde5pya5GPTrf1n08I/+wZpuOgmQEuQ93h7ipdGvjAC4/Sc1PCGG31vt3750BFEEmt9nF9BOr0r1j+QyWs+DVqtdp97JgZO8ACGCY4B4MU1kNd6Jlq8EPXauobDZu9TCI/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgJH8Pre; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgJH8Pre"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773169702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJUqS2imEFwTX0IL+wAxAJuGtqlBQ80n/ZGFHgQMJOI=;
	b=QgJH8PreZFx1uCEx5yfbAAdJfjZLpW29bswthv0EDAVBoyyjF0PN/rmjuKmtrfX1CCFlw6
	JsYPfsA1jvAB1Ns1+xNBv9RV32pdb73hnYRD8CIzOX99t2LmThsry08STbHbauhiQbmFwW
	XplQIdGBzoTlDnA4fgUPwB3T0+GUL/I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-ltkdpPluNVSUG8ex8nyaPw-1; Tue,
 10 Mar 2026 15:08:18 -0400
X-MC-Unique: ltkdpPluNVSUG8ex8nyaPw-1
X-Mimecast-MFC-AGG-ID: ltkdpPluNVSUG8ex8nyaPw_1773169697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 205AF180060D;
	Tue, 10 Mar 2026 19:08:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.202])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D7F23000223;
	Tue, 10 Mar 2026 19:08:13 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
Date: Tue, 10 Mar 2026 20:07:59 +0100
Message-ID: <20260310190759.1097506-4-eperezma@redhat.com>
In-Reply-To: <20260310190759.1097506-1-eperezma@redhat.com>
References: <20260310190759.1097506-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: xrY2ZbEEeBTJoZDJRHYxgX29jHls_vIc7A7k4AYLeF8_1773169697
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
index 17e0358d3a68..4f642b95a7cb 100644
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
@@ -2078,6 +2101,9 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->vduse_features = config->vduse_features;
+	dev_dbg(vduse_ctrl_dev, "Creating device %s with features 0x%llx",
+		config->name, config->vduse_features);
 
 	dev->nas = (dev->api_version < VDUSE_API_VERSION_1) ? 1 : config->nas;
 	dev->as = kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index e9b5f32a452d..7324faea5df4 100644
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
@@ -330,6 +333,7 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
 };
 
 /**
@@ -377,6 +381,15 @@ struct vduse_iova_range_v2 {
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
@@ -387,6 +400,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -404,6 +418,10 @@ struct vduse_dev_request {
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

