Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FD242D78
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567897; cv=none; b=P9r3wbCifSA4CReV+KLHdIxdhoDp0YPD7FSkUNdGboTsvYddVZmAYskrc5EjAr9iw8yvr1iJR2GextWNuf1qXH8kM6cMU50C2GL5NQ/fLp59VA9VP8ZANTN6xHULKfjcix+a70v8ZFpoLldW4oKVWHi+Jv4lAmW2ooij+uzg+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567897; c=relaxed/simple;
	bh=lFbTJHKpLGgRGxz1nfJ4cngDaeFwCqjUdDFdG0qkBsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EP47bAmqgqmBEfFfaHXUWn+a6vAx+GUabTfWR5K1a1LkMuuJznbxgzuatM4utyFO751p8QspVkHqbmLt6Sryfqw3H6K2ESD2vKdHDNM9LmPR4g8kqwAxt1gMZl2QTdbu6oUs0jpIDXWK3eEInK8DD5N877eeICfNL5HV71bi/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClvkX2gq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClvkX2gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754567893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGiIUzD9X5QD5dRQeSDFEtRhGWKy0hYTxpY/PFA5TqM=;
	b=ClvkX2gqwNGArhoWnR2U8CzYH8fM90xF7quP0ruxQ/cTLCiLMcARptJlZwYDj7VkTwYNce
	fS9B7NFKeqg8RKAawvhR7U2OaU1XfHCx6F5kAf/vrBxZc1VedIZZiHzNCus88Lf/dwWRpE
	cegNKIpX2t3GPZyX/nUWCvd60Y7u6AU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-scn3ZyX5PsuVXQC152AUYQ-1; Thu,
 07 Aug 2025 07:58:09 -0400
X-MC-Unique: scn3ZyX5PsuVXQC152AUYQ-1
X-Mimecast-MFC-AGG-ID: scn3ZyX5PsuVXQC152AUYQ_1754567888
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F141195608B;
	Thu,  7 Aug 2025 11:58:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B33823001453;
	Thu,  7 Aug 2025 11:58:04 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	jasowang@redhat.com,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [RFC v2 2/7] vduse: add vq group support
Date: Thu,  7 Aug 2025 13:57:47 +0200
Message-ID: <20250807115752.1663383-3-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-1-eperezma@redhat.com>
References: <20250807115752.1663383-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This allows sepparate the different virtqueues in groups that shares the
same address space.  Asking the VDUSE device for the groups of the vq at
the beginning as they're needed for the DMA API.

Allocating 3 vq groups as net is the device that need the most groups:
* Dataplane (guest passthrough)
* CVQ
* Shadowed vrings.

Future versions of the series can include dynamic allocation of the
groups array so VDUSE can declare more groups.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v2:
* Cache group information in kernel, as we need to provide the vq map
  tokens properly.
* Add descs vq group to optimize SVQ forwarding and support indirect
  descriptors out of the box.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 71 +++++++++++++++++++++++++++++-
 include/uapi/linux/vduse.h         | 19 +++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d858c4389cc1..d1f6d00a9c71 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -46,6 +46,11 @@
 #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
+/*
+ * Let's make it 3 for simplicity.
+ */
+#define VDUSE_MAX_VQ_GROUPS 3
+
 #define IRQ_UNBOUND -1
 
 struct vduse_virtqueue {
@@ -58,6 +63,8 @@ struct vduse_virtqueue {
 	struct vdpa_vq_state state;
 	bool ready;
 	bool kicked;
+	u32 vq_group;
+	u32 vq_desc_group;
 	spinlock_t kick_lock;
 	spinlock_t irq_lock;
 	struct eventfd_ctx *kickfd;
@@ -114,6 +121,7 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	u32 ngroups;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
@@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
+static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	return dev->vqs[idx]->vq_group;
+}
+
+static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	return dev->vqs[idx]->vq_desc_group;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_device *vdpa)
 	return dev->status;
 }
 
+static int vduse_fill_vq_groups(struct vduse_dev *dev)
+{
+	if (dev->api_version < VDUSE_API_VERSION_1)
+		return 0;
+
+	for (int i = 0; i < dev->vdev->vdpa.nvqs; ++i) {
+		struct vduse_dev_msg msg = { 0 };
+		int ret;
+
+		msg.req.type = VDUSE_GET_VQ_GROUP;
+		msg.req.vq_group.index = i;
+		ret = vduse_dev_msg_sync(dev, &msg);
+		if (ret)
+			return ret;
+
+		dev->vqs[i]->vq_group = msg.resp.vq_group.num;
+
+		msg.req.type = VDUSE_GET_VRING_DESC_GROUP;
+		ret = vduse_dev_msg_sync(dev, &msg);
+		if (ret)
+			return ret;
+
+		dev->vqs[i]->vq_desc_group = msg.resp.vq_group.num;
+	}
+
+	return 0;
+}
+
 static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	u8 previous_status = dev->status;
 
 	if (vduse_dev_set_status(dev, status))
 		return;
 
+	if ((dev->status ^ previous_status) &
+	     BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
+	    status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
+		if (vduse_fill_vq_groups(dev))
+			return;
+
 	dev->status = status;
 }
 
@@ -789,6 +846,8 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
 	.set_vq_num             = vduse_vdpa_set_vq_num,
 	.get_vq_size		= vduse_vdpa_get_vq_size,
+	.get_vq_group		= vduse_get_vq_group,
+	.get_vq_desc_group	= vduse_get_vq_desc_group,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -1856,6 +1915,16 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	if (dev->api_version >= 1) {
+		if (config->ngroups > VDUSE_MAX_VQ_GROUPS) {
+			pr_err("Not creating a VDUSE device with %u vq groups. Max: %u",
+				config->ngroups, VDUSE_MAX_VQ_GROUPS);
+			goto err;
+		}
+		dev->ngroups = config->ngroups ?: 1;
+	} else {
+		dev->ngroups = 1;
+	}
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -2016,7 +2085,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
 				 &vduse_vdpa_config_ops, &vduse_map_ops,
-				 1, 1, name, true);
+				 dev->ngroups, 1, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 9a56d0416bfe..b4b139dc76bb 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -31,6 +31,7 @@
  * @features: virtio features
  * @vq_num: the number of virtqueues
  * @vq_align: the allocation alignment of virtqueue's metadata
+ * @ngroups: number of vq groups that VDUSE device declares
  * @reserved: for future use, needs to be initialized to zero
  * @config_size: the size of the configuration space
  * @config: the buffer of the configuration space
@@ -45,7 +46,8 @@ struct vduse_dev_config {
 	__u64 features;
 	__u32 vq_num;
 	__u32 vq_align;
-	__u32 reserved[13];
+	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
+	__u32 reserved[12];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -160,6 +162,16 @@ struct vduse_vq_state_packed {
 	__u16 last_used_idx;
 };
 
+/**
+ * struct vduse_vq_group - virtqueue group
+ * @num: Index of the virtqueue group
+ * @num: Group
+ */
+struct vduse_vq_group {
+	__u32 index;
+	__u32 num;
+};
+
 /**
  * struct vduse_vq_info - information of a virtqueue
  * @index: virtqueue index
@@ -182,6 +194,7 @@ struct vduse_vq_info {
 	union {
 		struct vduse_vq_state_split split;
 		struct vduse_vq_state_packed packed;
+		struct vduse_vq_group group;
 	};
 	__u8 ready;
 };
@@ -274,6 +287,8 @@ enum vduse_req_type {
 	VDUSE_GET_VQ_STATE,
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
+	VDUSE_GET_VQ_GROUP,
+	VDUSE_GET_VRING_DESC_GROUP,
 };
 
 /**
@@ -328,6 +343,7 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
 		__u32 padding[32];
 	};
 };
@@ -350,6 +366,7 @@ struct vduse_dev_response {
 	__u32 reserved[4];
 	union {
 		struct vduse_vq_state vq_state;
+		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
 		__u32 padding[32];
 	};
 };
-- 
2.50.1

