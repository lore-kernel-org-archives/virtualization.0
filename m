Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5498308F00
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507454; cv=none; b=ogTYs1AyZTwnFwAH+8isHOeyqPRrCfQPUFpa9Orzwc9kCgH7TKqz5SXhi1pwaz7HmxpV1T3VDCuuydXudQ/sn2yY+XNcpTC21n4vEM+1JH/Rs25Ayc4Gj0c4xEWjqa5bd6hRSPtfIWEFlvEm6Ay0eHep/uSoe67lm28YY5babHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507454; c=relaxed/simple;
	bh=bIJXmp+NJrMo9m0v1Ptbem41UpFckZaQZLVKL5jzZ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMnDYN+TgdD06JiV/OKQAQwt0i9XvpIQ53kQVtq4r88plF9pQyCRn2s3P/f8Wi5UCX5kSLrb4M8xmtC2GpRJzlZOJXOLjhruYzCsTmobqBDHpQRaXb4kqceTqVwGYkwMrK2XscUHmS4FcI3XHrGSt1a46YgWZoOrH8nnUz5MCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij0Jwcvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij0Jwcvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755507451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/3SgPuyeB/3g1noTu/JJgOcwr+hehlqJojKmHQcytI=;
	b=Ij0Jwcvk9fUDHQbSOgpoaDNZDNVaXfPCiq1OIXH0hlftM5AZoL1hGv3GTqNZ8tK+0IO72X
	UcbxH/Ff2VJcmwYDsjf1P5M8rJEei8JJQlSjei32uWcmF38Fka92VgGdQNQCQwYWn1eIct
	CDtvuYMrmyfQ6tmRkUXNLVm6K1fdV5I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630--H-08AnMMqiyhY1rZ4zMUg-1; Mon,
 18 Aug 2025 04:57:28 -0400
X-MC-Unique: -H-08AnMMqiyhY1rZ4zMUg-1
X-Mimecast-MFC-AGG-ID: -H-08AnMMqiyhY1rZ4zMUg_1755507447
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CED411800280;
	Mon, 18 Aug 2025 08:57:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.213])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7528180028A;
	Mon, 18 Aug 2025 08:57:22 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC v3 2/7] vduse: add vq group support
Date: Mon, 18 Aug 2025 10:57:06 +0200
Message-ID: <20250818085711.3461758-3-eperezma@redhat.com>
In-Reply-To: <20250818085711.3461758-1-eperezma@redhat.com>
References: <20250818085711.3461758-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
v3:
* Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
  value to reduce memory consumption, but vqs are already limited to
  that value and userspace VDUSE is able to allocate that many vqs.
* Remove the descs vq group capability as it will not be used and we can
  add it on top.
* Do not ask for vq groups in number of vq groups < 2.
* Move the valid vq groups range check to vduse_validate_config.

v2:
* Cache group information in kernel, as we need to provide the vq map
  tokens properly.
* Add descs vq group to optimize SVQ forwarding and support indirect
  descriptors out of the box.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 53 ++++++++++++++++++++++++++++--
 include/uapi/linux/vduse.h         | 21 +++++++++++-
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 3260edefdf0d..e42d14888ca2 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -58,6 +58,7 @@ struct vduse_virtqueue {
 	struct vdpa_vq_state state;
 	bool ready;
 	bool kicked;
+	u32 vq_group;
 	spinlock_t kick_lock;
 	spinlock_t irq_lock;
 	struct eventfd_ctx *kickfd;
@@ -115,6 +116,7 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	u32 ngroups;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
@@ -593,6 +595,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
+static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	return dev->vqs[idx]->vq_group;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -679,13 +688,42 @@ static u8 vduse_vdpa_get_status(struct vdpa_device *vdpa)
 	return dev->status;
 }
 
+static int vduse_fill_vq_groups(struct vduse_dev *dev)
+{
+	/* All vqs and descs must be in vq group 0 if ngroups < 2 */
+	if (dev->ngroups < 2)
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
+		dev->vqs[i]->vq_group = msg.resp.vq_group.group;
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
 
@@ -790,6 +828,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
 	.set_vq_num             = vduse_vdpa_set_vq_num,
 	.get_vq_size		= vduse_vdpa_get_vq_size,
+	.get_vq_group		= vduse_get_vq_group,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -1738,12 +1777,19 @@ static bool features_is_valid(struct vduse_dev_config *config)
 	return true;
 }
 
-static bool vduse_validate_config(struct vduse_dev_config *config)
+static bool vduse_validate_config(struct vduse_dev_config *config,
+				  u64 api_version)
 {
 	if (!is_mem_zero((const char *)config->reserved,
 			 sizeof(config->reserved)))
 		return false;
 
+	if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
+		return false;
+
+	if (api_version >= VDUSE_API_VERSION_1 && config->ngroups > 0xffff)
+		return false;
+
 	if (config->vq_align > PAGE_SIZE)
 		return false;
 
@@ -1859,6 +1905,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->ngroups = (dev->api_version < 1) ? 1 : (config->ngroups ?: 1);
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1937,7 +1984,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (vduse_validate_config(&config) == false)
+		if (!vduse_validate_config(&config, control->api_version))
 			break;
 
 		buf = vmemdup_user(argp + size, config.config_size);
@@ -2018,7 +2065,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
 				 &vduse_vdpa_config_ops, &vduse_map_ops,
-				 1, 1, name, true);
+				 dev->ngroups, 1, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 9a56d0416bfe..b1c0e47d71fb 100644
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
+ * @index: Index of the virtqueue
+ * @group: Virtqueue group
+ */
+struct vduse_vq_group {
+	__u32 index;
+	__u32 group;
+};
+
 /**
  * struct vduse_vq_info - information of a virtqueue
  * @index: virtqueue index
@@ -274,6 +286,7 @@ enum vduse_req_type {
 	VDUSE_GET_VQ_STATE,
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
+	VDUSE_GET_VQ_GROUP,
 };
 
 /**
@@ -316,6 +329,7 @@ struct vduse_iova_range {
  * @vq_state: virtqueue state, only index field is available
  * @s: device status
  * @iova: IOVA range for updating
+ * @vq_group: virtqueue group of a virtqueue
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -328,6 +342,8 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		/* Only if vduse api version >= 1 */;
+		struct vduse_vq_group vq_group;
 		__u32 padding[32];
 	};
 };
@@ -338,6 +354,7 @@ struct vduse_dev_request {
  * @result: the result of request
  * @reserved: for future use, needs to be initialized to zero
  * @vq_state: virtqueue state
+ * @vq_group: virtqueue group of a virtqueue
  * @padding: padding
  *
  * Structure used by write(2) on /dev/vduse/$NAME.
@@ -350,6 +367,8 @@ struct vduse_dev_response {
 	__u32 reserved[4];
 	union {
 		struct vduse_vq_state vq_state;
+		/* Only if vduse api version >= 1 */
+		struct vduse_vq_group vq_group;
 		__u32 padding[32];
 	};
 };
-- 
2.50.1

