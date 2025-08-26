Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6B32144F
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207652; cv=none; b=j6zWhv037j4UTzskc4Amel2ztZhzAEWhi5kUuMTI8+QvB4DKzV2Jh3PbeZIkJtYnGM2hNCcmgvZWPLcHeCGbwroEy4+xXDAioENTZcC77QjZqe6ZD/FgG3vok57W59ryYtoE5oPZsAV5VjwiPEtWkQjTiu15yT47ZJREyJNN+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207652; c=relaxed/simple;
	bh=91MrTF4kyUyQSid52eyDTM8REpCvGVqOFxU099T5b+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J10NDUR3qiixDJCC/lekeXCd/B6nvtCtSK7gKz26Cdfj2QolT7Q4FZ4jYrd21cvWKK6H1wPaPeJyDAm3sQk7DBjCYf24wKv17O7898f/Tx9JLNjhPLfigyHuXvcibvDzTas5CDLz0VfFoEG0mNHwzbf2TQUJM11BoqT/727RirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7rizRn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7rizRn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Dfr1AP301Ho/fgPsvC3NL7D/TxBaVo5KwFeo+iScfE=;
	b=X7rizRn971TdFxfDjAB1EeAQK5Vl7v7gyZ9gULWxPMX7iB0Ly6filB77pmE3kVPWTO4hoV
	NiLPkjxtzFIkjnI8NNnfXXAgU64j4dAymgwCdVYVmTccyKwJ0QoH/txQC30j/jx/sArGmQ
	A8AYgobWMaWc++L+AsdKfBFXxIItSMo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-YIBulR5hMoiXga6BNFXodw-1; Tue,
 26 Aug 2025 07:27:26 -0400
X-MC-Unique: YIBulR5hMoiXga6BNFXodw-1
X-Mimecast-MFC-AGG-ID: YIBulR5hMoiXga6BNFXodw_1756207645
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 345D419560AF;
	Tue, 26 Aug 2025 11:27:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 172011800280;
	Tue, 26 Aug 2025 11:27:20 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH 2/6] vduse: add vq group support
Date: Tue, 26 Aug 2025 13:27:05 +0200
Message-ID: <20250826112709.1051172-3-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-1-eperezma@redhat.com>
References: <20250826112709.1051172-1-eperezma@redhat.com>
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
v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)

RFC v3:
* Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
  value to reduce memory consumption, but vqs are already limited to
  that value and userspace VDUSE is able to allocate that many vqs.
* Remove the descs vq group capability as it will not be used and we can
  add it on top.
* Do not ask for vq groups in number of vq groups < 2.
* Move the valid vq groups range check to vduse_validate_config.

RFC v2:
* Cache group information in kernel, as we need to provide the vq map
  tokens properly.
* Add descs vq group to optimize SVQ forwarding and support indirect
  descriptors out of the box.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++++++--
 include/uapi/linux/vduse.h         | 21 +++++++++++-
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e7bced0b5542..0f4e36dd167e 100644
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
@@ -114,6 +115,7 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	u32 ngroups;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
@@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
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
@@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_device *vdpa)
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
@@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 	if (vduse_dev_set_status(dev, status))
 		return;
 
+	if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK) &&
+	    (status & VIRTIO_CONFIG_S_FEATURES_OK))
+		if (vduse_fill_vq_groups(dev))
+			return;
+
 	dev->status = status;
 }
 
@@ -789,6 +825,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
 	.set_vq_num             = vduse_vdpa_set_vq_num,
 	.get_vq_size		= vduse_vdpa_get_vq_size,
+	.get_vq_group		= vduse_get_vq_group,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -1737,12 +1774,19 @@ static bool features_is_valid(struct vduse_dev_config *config)
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
 
@@ -1858,6 +1902,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->ngroups = (dev->api_version < 1) ? 1 : (config->ngroups ?: 1);
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1936,7 +1981,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (vduse_validate_config(&config) == false)
+		if (!vduse_validate_config(&config, control->api_version))
 			break;
 
 		buf = vmemdup_user(argp + size, config.config_size);
@@ -2017,7 +2062,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
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
2.51.0

