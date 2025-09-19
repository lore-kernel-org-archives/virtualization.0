Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15442F1FD9
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274470; cv=none; b=o1CIjV+MM1k0gmmkEiUptdW/Bnt3z94bTweLZ9DwuhK7/JuSZHEx8DoXXeiIdf5YiRw1viliR/DS8fBpEFpSiWLFzcoR3NVioV70zUNiX+B/L7ooP5qCW3wx5r8N+7qsko+fql4Jy+9sRw9XPCuocWlwKDCYcVufFTO3VVGMXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274470; c=relaxed/simple;
	bh=k/3+6JVrPWh07iZLjgM5A8ukiUPo5SQojJ3B04q5YRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZkCLB57doQ1uECHi8juXPC5LyzzAtAMr6LzNSpysyoXBU0aOfTE3SqzevgAl8dtiEj2i00vuoVfi9FoAUplWNOOj8KEvl9NeCI0NVyix3FKugvPHyj3vkCkTOpJPXgOpq76X99PQfn3xtCN4Yjn1WnF2PTgW0FDOtr/ALUvqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Suf3hAW9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Suf3hAW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758274467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkzzjSg/UFdQEsIBAFwFFMlTrWks0AFtzULNTjenjIE=;
	b=Suf3hAW95YhtKSA2GIvGemMbVxj+c2CxXlXOGDBoqOq8MkPXaZrrmzqCXS5cPaR66LByCx
	Zh7smMuCBbYka/noAO5IGbkAOX+M+PPAuBPQFRUT3gHWtt9/7gaiHkpailDbEHNUKLvtHC
	BNU/N7lWyL+nlLtX0pv6KTYTrW/fNHw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-n4ezJPYcPDOKIulXfpZQzQ-1; Fri,
 19 Sep 2025 05:34:23 -0400
X-MC-Unique: n4ezJPYcPDOKIulXfpZQzQ-1
X-Mimecast-MFC-AGG-ID: n4ezJPYcPDOKIulXfpZQzQ_1758274462
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14EBA1800452;
	Fri, 19 Sep 2025 09:34:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.69])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A783618004A3;
	Fri, 19 Sep 2025 09:34:17 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 3/6] vduse: add vq group support
Date: Fri, 19 Sep 2025 11:33:56 +0200
Message-ID: <20250919093359.961296-4-eperezma@redhat.com>
In-Reply-To: <20250919093359.961296-1-eperezma@redhat.com>
References: <20250919093359.961296-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 drivers/vdpa/ifcvf/ifcvf_main.c    |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c   |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c | 51 +++++++++++++++++++++++++++---
 drivers/vhost/vdpa.c               | 11 +++++--
 include/linux/vdpa.h               |  5 +--
 include/uapi/linux/vduse.h         | 12 +++++--
 7 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 6658dc74d915..ea6643760fb7 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -559,7 +559,7 @@ static size_t ifcvf_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
 	return  vf->config_size;
 }
 
-static u32 ifcvf_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+static s64 ifcvf_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx)
 {
 	return 0;
 }
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 82034efb74fc..daab0ccb78b2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2640,7 +2640,7 @@ static u32 mlx5_vdpa_get_vq_align(struct vdpa_device *vdev)
 	return PAGE_SIZE;
 }
 
-static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
+static s64 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index c1c6431950e1..fe4d65aaf6aa 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -412,7 +412,7 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
 	return VDPASIM_QUEUE_ALIGN;
 }
 
-static u32 vdpasim_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+static s64 vdpasim_get_vq_group(struct vdpa_device *vdpa, u16 idx)
 {
 	/* RX and TX belongs to group 0, CVQ belongs to group 1 */
 	if (idx == 2)
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 2b6a8958ffe0..7ddd81456f7b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -40,6 +40,7 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDUSE_DEV_MAX (1U << MINORBITS)
+#define VDUSE_DEV_MAX_GROUPS 0xffff
 #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
 #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
 #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
@@ -49,6 +50,8 @@
 
 #define IRQ_UNBOUND -1
 
+#define VQ_GROUP_INVALID -1
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -59,6 +62,7 @@ struct vduse_virtqueue {
 	struct vdpa_vq_state state;
 	bool ready;
 	bool kicked;
+	u32 vq_group;
 	spinlock_t kick_lock;
 	spinlock_t irq_lock;
 	struct eventfd_ctx *kickfd;
@@ -115,6 +119,7 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	u32 ngroups;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
@@ -456,6 +461,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 		vq->driver_addr = 0;
 		vq->device_addr = 0;
 		vq->num = 0;
+		vq->vq_group = VQ_GROUP_INVALID;
 		memset(&vq->state, 0, sizeof(vq->state));
 
 		spin_lock(&vq->kick_lock);
@@ -593,6 +599,19 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
+static s64 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	if (dev->api_version < VDUSE_API_VERSION_1)
+		return 0;
+
+	if (dev->vqs[idx]->vq_group == VQ_GROUP_INVALID)
+		return -EINVAL;
+
+	return dev->vqs[idx]->vq_group;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -790,6 +809,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
 	.set_vq_num             = vduse_vdpa_set_vq_num,
 	.get_vq_size		= vduse_vdpa_get_vq_size,
+	.get_vq_group		= vduse_get_vq_group,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -1253,12 +1273,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (config.index >= dev->vq_num)
 			break;
 
-		if (!is_mem_zero((const char *)config.reserved,
-				 sizeof(config.reserved)))
+		if (dev->api_version < VDUSE_API_VERSION_1 && config.group)
+			break;
+
+		if (dev->api_version >= VDUSE_API_VERSION_1) {
+			if (config.group > dev->ngroups)
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
@@ -1738,12 +1770,20 @@ static bool features_is_valid(struct vduse_dev_config *config)
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
+	    config->ngroups > VDUSE_DEV_MAX_GROUPS)
+		return false;
+
 	if (config->vq_align > PAGE_SIZE)
 		return false;
 
@@ -1859,6 +1899,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->ngroups = (dev->api_version < 1) ? 1 : (config->ngroups ?: 1);
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1937,7 +1978,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (vduse_validate_config(&config) == false)
+		if (!vduse_validate_config(&config, control->api_version))
 			break;
 
 		buf = vmemdup_user(argp + size, config.config_size);
@@ -2018,7 +2059,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
 				 &vduse_vdpa_config_ops, &vduse_map_ops,
-				 1, 1, name, true);
+				 dev->ngroups, 1, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 05a481e4c385..6305382eacbb 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -22,6 +22,7 @@
 #include <linux/vdpa.h>
 #include <linux/nospec.h>
 #include <linux/vhost.h>
+#include <linux/types.h>
 
 #include "vhost.h"
 
@@ -657,16 +658,20 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			return -EFAULT;
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
-	case VHOST_VDPA_GET_VRING_GROUP:
+	case VHOST_VDPA_GET_VRING_GROUP: {
+		u64 group;
+
 		if (!ops->get_vq_group)
 			return -EOPNOTSUPP;
 		s.index = idx;
-		s.num = ops->get_vq_group(vdpa, idx);
-		if (s.num >= vdpa->ngroups)
+		group = ops->get_vq_group(vdpa, idx);
+		if (group >= vdpa->ngroups || group > U32_MAX || group < 0)
 			return -EIO;
 		else if (copy_to_user(argp, &s, sizeof(s)))
 			return -EFAULT;
+		s.num = group;
 		return 0;
+	}
 	case VHOST_VDPA_GET_VRING_DESC_GROUP:
 		if (!vhost_vdpa_has_desc_group(v))
 			return -EOPNOTSUPP;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 4cf21d6e9cfd..76a673ef7deb 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -211,7 +211,8 @@ struct vdpa_map_file {
  *				virtqueue (optional)
  *				@vdev: vdpa device
  *				@idx: virtqueue index
- *				Returns u32: group id for this virtqueue
+ *				Returns i64: (32 bits wide) group id for this
+ *				virtqueue if >0. If <0, errno.
  * @get_vq_desc_group:		Get the group id for the descriptor table of
  *				a specific virtqueue (optional)
  *				@vdev: vdpa device
@@ -398,7 +399,7 @@ struct vdpa_config_ops {
 
 	/* Device ops */
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
-	u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
+	s64 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
 	u32 (*get_vq_desc_group)(struct vdpa_device *vdev, u16 idx);
 	u64 (*get_device_features)(struct vdpa_device *vdev);
 	u64 (*get_backend_features)(const struct vdpa_device *vdev);
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
2.51.0

