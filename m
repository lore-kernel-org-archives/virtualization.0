Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D12EA479
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791641; cv=none; b=YvIpPvlamBLIMdTh74F949b+N0Npi9yaL4YXnzBAjPVI4EnEV+PHyc25TRTjtsFaJO3PPT+ctvGYkoBP7kMVXdWNzUNEWjZ5+9Eobxfwb26QNuzV3zJMMDnbg0wE4Bys5eseZQPVoUOFayTBh+XYUBveTS5/F+bLTrGYbipxYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791641; c=relaxed/simple;
	bh=cbNI49wW8zK936U+ebQIaRaCEnsrlMwWUjB8jhGZk1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvvFcNMOw3+/Mjo4f6I/FGEV3Sb4ydynwAcoXnOOEQIwhfHVLfqsP6Bh9UpT21xGv9KFckBqDmJ1dUAqwHNUfLJe37GeW0u2RIYV0+EnSgUwEdHRn21oRTUvMbiO+Xs0uRsrAbTiHLTYzFfigbh6yRg431O6YTv6hEcjkK0c8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ck7Guqvs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ck7Guqvs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758791637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EG8AadLBBsgBX/qqs5Ee1JxtGvWNyIqsP88jqTxllnY=;
	b=ck7GuqvsaUC1ceBkTJBwGh9ZOYca5g+E+S0CcwsnXEL7WP+8p9CxWfSqJeCtI19vxfhwkv
	DsTjamhFMW30LoteNujjUkRsNmh2gWZuQTJbXbR9ZZxeQdUIcq4rixI7XANxXxVwCQHdKd
	uC52WIuqNpYioHIr63z1+Za06DwY2/0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-nfrexMTWPqqI07pcpT22wA-1; Thu,
 25 Sep 2025 05:13:56 -0400
X-MC-Unique: nfrexMTWPqqI07pcpT22wA-1
X-Mimecast-MFC-AGG-ID: nfrexMTWPqqI07pcpT22wA_1758791635
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 063271800295;
	Thu, 25 Sep 2025 09:13:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 492511956095;
	Thu, 25 Sep 2025 09:13:51 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 3/6] vduse: add vq group support
Date: Thu, 25 Sep 2025 11:13:32 +0200
Message-ID: <20250925091335.1964283-4-eperezma@redhat.com>
In-Reply-To: <20250925091335.1964283-1-eperezma@redhat.com>
References: <20250925091335.1964283-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 drivers/vdpa/vdpa_user/vduse_dev.c | 46 ++++++++++++++++++++++++++----
 drivers/vhost/vdpa.c               | 11 +++++--
 include/uapi/linux/vduse.h         | 12 ++++++--
 3 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 2b6a8958ffe0..3415217cb3a9 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -40,6 +40,7 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDUSE_DEV_MAX (1U << MINORBITS)
+#define VDUSE_DEV_MAX_GROUPS 0xffff
 #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
 #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
 #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
@@ -59,6 +60,7 @@ struct vduse_virtqueue {
 	struct vdpa_vq_state state;
 	bool ready;
 	bool kicked;
+	u32 vq_group;
 	spinlock_t kick_lock;
 	spinlock_t irq_lock;
 	struct eventfd_ctx *kickfd;
@@ -115,6 +117,7 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	u32 ngroups;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
@@ -456,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 		vq->driver_addr = 0;
 		vq->device_addr = 0;
 		vq->num = 0;
+		vq->vq_group = 0;
 		memset(&vq->state, 0, sizeof(vq->state));
 
 		spin_lock(&vq->kick_lock);
@@ -593,6 +597,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
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
@@ -790,6 +804,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
 	.set_vq_num             = vduse_vdpa_set_vq_num,
 	.get_vq_size		= vduse_vdpa_get_vq_size,
+	.get_vq_group		= vduse_get_vq_group,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -1253,12 +1268,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
@@ -1738,12 +1765,20 @@ static bool features_is_valid(struct vduse_dev_config *config)
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
 
@@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1937,7 +1973,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (vduse_validate_config(&config) == false)
+		if (!vduse_validate_config(&config, control->api_version))
 			break;
 
 		buf = vmemdup_user(argp + size, config.config_size);
@@ -2018,7 +2054,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
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

