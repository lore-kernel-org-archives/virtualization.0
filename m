Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041E34DCFE
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034979; cv=none; b=IbAx3obdmWkJdg4YMZfgFxxA1iLaMOqINztlv0/xrIUJdd6iF4QEGu4Kr0gL6/1sFPYVGOKqojMNrlkjBMnchIIcHr7T1bbA4M/Pl+XyhnJKdIcE6enY//rE/ysYY9p4mB1NDPcpafhWOgpCobazePM6ZriC36HPCJlPjtq3bHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034979; c=relaxed/simple;
	bh=7f2sede9loQzGhqe78/srP7qqeWEQcSJJxnZXVfFLh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEoTk/adMgTk1B+hSfugLW4ezKntmvSKciKGRLnzJtxAZCGxYy5CRp/CQNbFu4Qlsxe6tVbqcYAanNu0fMVGSLBF9pqgm1XpqlPcNoh8fsN1SlFOc283A0pCsYgAk8L240UE+mHkfjXfjrjuFp1H173s0eHjSHM/gvFhqLFph5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZowAapG6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZowAapG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763034977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQKdCRQoPomqIO2je1/r4U0HHTU5M7C0wzMHBOuha2U=;
	b=ZowAapG6vtqdcfEmnOgt9EzeX/h7HYL1VmMfs70rwMRtqpKl3jP/lsCsEEvCa4iknyU8hy
	ny0C1+JtBGz7jsvq38x/5a/KGoEIp0I9tWgW3BhamQ+/AQJSuClmGGtmfWIbVp42zkVvmr
	OpQArJhGJxgFdzXJoi9DFwDMmG14Dig=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-gCqaS7dbO_yCwFVU8TmM9Q-1; Thu,
 13 Nov 2025 06:56:15 -0500
X-MC-Unique: gCqaS7dbO_yCwFVU8TmM9Q-1
X-Mimecast-MFC-AGG-ID: gCqaS7dbO_yCwFVU8TmM9Q_1763034974
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4CDA18002C2;
	Thu, 13 Nov 2025 11:56:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D3BD19560B9;
	Thu, 13 Nov 2025 11:56:10 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v9 2/6] vduse: add vq group support
Date: Thu, 13 Nov 2025 12:55:54 +0100
Message-ID: <20251113115558.1277981-3-eperezma@redhat.com>
In-Reply-To: <20251113115558.1277981-1-eperezma@redhat.com>
References: <20251113115558.1277981-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This allows separate the different virtqueues in groups that shares the
same address space.  Asking the VDUSE device for the groups of the vq at
the beginning as they're needed for the DMA API.

Allocating 3 vq groups as net is the device that need the most groups:
* Dataplane (guest passthrough)
* CVQ
* Shadowed vrings.

Future versions of the series can include dynamic allocation of the
groups array so VDUSE can declare more groups.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v6:
* s/sepparate/separate (MST).
* s/dev->api_version < 1/dev->api_version < VDUSE_API_VERSION_1

v5:
* Revert core vdpa changes (Jason).
* Fix group == ngroup case in checking VQ_SETUP argument (Jason).

v4:
* Revert the "invalid vq group" concept and assume 0 if not set (Jason).
* Make config->ngroups == 0 invalid (Jason).

v3:
* Make the default group an invalid group as long as VDUSE device does
  not set it to some valid u32 value.  Modify the vdpa core to take that
  into account (Jason).
* Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number

v2:
* Now the vq group is in vduse_vq_config struct instead of issuing one
  VDUSE message per vq.

v1:
* Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)

RFC v3:
* Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lower
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
 drivers/vdpa/vdpa_user/vduse_dev.c | 48 ++++++++++++++++++++++++++----
 include/uapi/linux/vduse.h         | 12 ++++++--
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e7bced0b5542..d5c90c599698 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -39,6 +39,7 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDUSE_DEV_MAX (1U << MINORBITS)
+#define VDUSE_DEV_MAX_GROUPS 0xffff
 #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
 #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
 #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
@@ -58,6 +59,7 @@ struct vduse_virtqueue {
 	struct vdpa_vq_state state;
 	bool ready;
 	bool kicked;
+	u32 vq_group;
 	spinlock_t kick_lock;
 	spinlock_t irq_lock;
 	struct eventfd_ctx *kickfd;
@@ -114,6 +116,7 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	u32 ngroups;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
@@ -455,6 +458,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 		vq->driver_addr = 0;
 		vq->device_addr = 0;
 		vq->num = 0;
+		vq->vq_group = 0;
 		memset(&vq->state, 0, sizeof(vq->state));
 
 		spin_lock(&vq->kick_lock);
@@ -592,6 +596,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
+static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	if (dev->api_version < VDUSE_API_VERSION_1)
+		return 0;
+
+	return dev->vqs[idx]->vq_group;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -789,6 +803,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
 	.set_vq_num             = vduse_vdpa_set_vq_num,
 	.get_vq_size		= vduse_vdpa_get_vq_size,
+	.get_vq_group		= vduse_get_vq_group,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -1252,12 +1267,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (config.index >= dev->vq_num)
 			break;
 
-		if (!is_mem_zero((const char *)config.reserved,
-				 sizeof(config.reserved)))
+		if (dev->api_version < VDUSE_API_VERSION_1 && config.group)
+			break;
+
+		if (dev->api_version >= VDUSE_API_VERSION_1) {
+			if (config.group >= dev->ngroups)
+				break;
+			if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
+				break;
+		}
+
+		if (config.reserved1 ||
+		    !is_mem_zero((const char *)config.reserved2,
+				 sizeof(config.reserved2)))
 			break;
 
 		index = array_index_nospec(config.index, dev->vq_num);
 		dev->vqs[index]->num_max = config.max_size;
+		dev->vqs[index]->vq_group = config.group;
 		ret = 0;
 		break;
 	}
@@ -1737,12 +1764,20 @@ static bool features_is_valid(struct vduse_dev_config *config)
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
+	if (api_version >= VDUSE_API_VERSION_1 &&
+	    (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
+		return false;
+
 	if (config->vq_align > PAGE_SIZE)
 		return false;
 
@@ -1858,6 +1893,9 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->ngroups = (dev->api_version < VDUSE_API_VERSION_1)
+		       ? 1
+		       : config->ngroups;
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1936,7 +1974,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (vduse_validate_config(&config) == false)
+		if (!vduse_validate_config(&config, control->api_version))
 			break;
 
 		buf = vmemdup_user(argp + size, config.config_size);
@@ -2017,7 +2055,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
 				 &vduse_vdpa_config_ops, &vduse_map_ops,
-				 1, 1, name, true);
+				 dev->ngroups, 1, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index ccb92a1efce0..a3d51cf6df3a 100644
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
@@ -122,14 +124,18 @@ struct vduse_config_data {
  * struct vduse_vq_config - basic configuration of a virtqueue
  * @index: virtqueue index
  * @max_size: the max size of virtqueue
- * @reserved: for future use, needs to be initialized to zero
+ * @reserved1: for future use, needs to be initialized to zero
+ * @group: virtqueue group
+ * @reserved2: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
  */
 struct vduse_vq_config {
 	__u32 index;
 	__u16 max_size;
-	__u16 reserved[13];
+	__u16 reserved1;
+	__u32 group;
+	__u16 reserved2[10];
 };
 
 /*
-- 
2.51.1

